Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39746263644
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 20:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIStP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 14:49:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:43414 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbgIIStO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 14:49:14 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 830AD2080C;
        Wed,  9 Sep 2020 18:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599677353;
        bh=0Hc0A2DHIpQxSXAUP1fYSrqZvdF79n71IkCFeuZVvus=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EYmVpe3PMtGnon7JXzpdciqTBAHxlDimISoc/VVCqmCj3Pl9WGnQoKknxx4SFwukt
         Lb/0BAGFm6JZ3RamYzCabZuwAH/xkKymqiYAO2xVVqKUJiWggL8sYvTQiWrWWEocq7
         qNFpVoqAn78eXnfCgbSPkyO5RyFZ4jArvDUi78Z4=
Date:   Wed, 9 Sep 2020 11:49:12 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH v2 01/18] vfs: export new_inode_pseudo
Message-ID: <20200909184912.GA425889@gmail.com>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-2-jlayton@kernel.org>
 <20200908033819.GD68127@sol.localdomain>
 <42e2de297552a8642bfe21ab082e490678b5be38.camel@kernel.org>
 <20200908223125.GA3760467@gmail.com>
 <6cfe023df5cf6c50d6197bb7c71b3fa6a51bf555.camel@kernel.org>
 <20200909161242.GA828@sol.localdomain>
 <f04ca91e7c617c01e8428725a5286157415a3dac.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f04ca91e7c617c01e8428725a5286157415a3dac.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc Al]

On Wed, Sep 09, 2020 at 12:51:02PM -0400, Jeff Layton wrote:
> > > No, more like:
> > > 
> > > Syscall					Workqueue
> > > ------------------------------------------------------------------------------
> > > 1. allocate an inode
> > > 2. determine we can do an async create
> > >    and allocate an inode number for it
> > > 3. hash the inode (must set I_CREATING
> > >    if we allocated with new_inode()) 
> > > 4. issue the call to the MDS
> > > 5. finish filling out the inode()
> > > 6.					MDS reply comes in, and workqueue thread
> > > 					looks up new inode (-ESTALE)
> > > 7. unlock_new_inode()
> > > 
> > > 
> > > Because 6 happens before 7 in this case, we get an ESTALE on that
> > > lookup.
> > 
> > How is ESTALE at (6) possible?  (3) will set I_NEW on the inode when inserting
> > it into the inode hash table.  Then (6) will wait for I_NEW to be cleared before
> > returning the inode.  (7) will clear I_NEW and I_CREATING together.
> > 
> 
> Long call chain, but:
> 
> ceph_fill_trace
>    ceph_get_inode
>       iget5_locked
>          ilookup5(..._nowait, etc)
>             find_inode_fast
> 
> 
> ...and find_inode_fast does:
> 
>                 if (unlikely(inode->i_state & I_CREATING)) {                                        
>                         spin_unlock(&inode->i_lock);                                                
>                         return ERR_PTR(-ESTALE);                                                    
>                 }                                                                                   

Why does ilookup5() not wait for I_NEW to be cleared if the inode has
I_NEW|I_CREATING, but it does wait for I_NEW to be cleared if I_NEW is set its
own?  That seems like a bug.

- Eric
