Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64807263691
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 21:24:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbgIITYF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 15:24:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:52864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgIITYE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:24:04 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A41E121D6C;
        Wed,  9 Sep 2020 19:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599679444;
        bh=Xhn+vvZycsbQ5WqXRYhi8PJe8samP3+kyxYjq75CDC8=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=oKuWGpvEvqjEX2g7GQcjHw+RlE4f6dK9j4Zi3m08Mqm2y4cP6CiaO0S3NQ6wjkWPT
         vogeXi4kZaPoIGCLlapDUoN9dahF57xBs+E34KZgfiOSyMyXMFpsYI9iZJL6oBW7+k
         JSjrlR0uot6yTNUfMrYSmmkwLJNzvXNWj3DeeCDY=
Message-ID: <5471b5436b71e860da5bb3bb76a2a8bd0a61387e.camel@kernel.org>
Subject: Re: [RFC PATCH v2 01/18] vfs: export new_inode_pseudo
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Date:   Wed, 09 Sep 2020 15:24:02 -0400
In-Reply-To: <20200909184912.GA425889@gmail.com>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-2-jlayton@kernel.org>
         <20200908033819.GD68127@sol.localdomain>
         <42e2de297552a8642bfe21ab082e490678b5be38.camel@kernel.org>
         <20200908223125.GA3760467@gmail.com>
         <6cfe023df5cf6c50d6197bb7c71b3fa6a51bf555.camel@kernel.org>
         <20200909161242.GA828@sol.localdomain>
         <f04ca91e7c617c01e8428725a5286157415a3dac.camel@kernel.org>
         <20200909184912.GA425889@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-09 at 11:49 -0700, Eric Biggers wrote:
> [+Cc Al]
> 
> On Wed, Sep 09, 2020 at 12:51:02PM -0400, Jeff Layton wrote:
> > > > No, more like:
> > > > 
> > > > Syscall					Workqueue
> > > > ------------------------------------------------------------------------------
> > > > 1. allocate an inode
> > > > 2. determine we can do an async create
> > > >    and allocate an inode number for it
> > > > 3. hash the inode (must set I_CREATING
> > > >    if we allocated with new_inode()) 
> > > > 4. issue the call to the MDS
> > > > 5. finish filling out the inode()
> > > > 6.					MDS reply comes in, and workqueue thread
> > > > 					looks up new inode (-ESTALE)
> > > > 7. unlock_new_inode()
> > > > 
> > > > 
> > > > Because 6 happens before 7 in this case, we get an ESTALE on that
> > > > lookup.
> > > 
> > > How is ESTALE at (6) possible?  (3) will set I_NEW on the inode when inserting
> > > it into the inode hash table.  Then (6) will wait for I_NEW to be cleared before
> > > returning the inode.  (7) will clear I_NEW and I_CREATING together.
> > > 
> > 
> > Long call chain, but:
> > 
> > ceph_fill_trace
> >    ceph_get_inode
> >       iget5_locked
> >          ilookup5(..._nowait, etc)
> >             find_inode_fast
> > 
> > 
> > ...and find_inode_fast does:
> > 
> >                 if (unlikely(inode->i_state & I_CREATING)) {                                        
> >                         spin_unlock(&inode->i_lock);                                                
> >                         return ERR_PTR(-ESTALE);                                                    
> >                 }                                                                                   
> 
> Why does ilookup5() not wait for I_NEW to be cleared if the inode has
> I_NEW|I_CREATING, but it does wait for I_NEW to be cleared if I_NEW is set its
> own?  That seems like a bug.
> 

Funny, I asked Al the same thing on IRC the other day:

23:28 < jlayton> viro: wondering if there is a potential race with I_CREATING in find_inode. 
                 Seems like you could have 2 tasks racing in calls to iget5_locked for the 
                 same inode. One creates an inode and starts instantiating it, and the second 
                 one gets NULL back because I_CREATING is set.
23:30 < viro> jlayton: where would I_CREATING come from?
23:30 < viro> it's set on insert_inode_locked() and similar paths
23:31 < viro> where you want iget5_locked() to fuck off and eat ESTALE
23:31 < jlayton> ok, right -- I was trying to pass an inode from new_inode to inode_insert5
23:32 < viro> seeing that it's been asked for an inode number that did _not_ exist until just 
              now (we'd just allocated it)

The assumption is that we'll never go looking for an inode until after
I_NEW is cleared. In the case of an asynchronous create in ceph though,
we may do exactly that if the reply comes back very quickly.

-- 
Jeff Layton <jlayton@kernel.org>

