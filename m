Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83182632CE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 18:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731117AbgIIQvH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Sep 2020 12:51:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731091AbgIIQvE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:51:04 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 293372087C;
        Wed,  9 Sep 2020 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599670263;
        bh=ZYUUqdjDo3xnnBFPKB+tDInjVxu/wSoVFgIiGTz6VEA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Ghd4+mgHLUIDn/jAfR7EyGHipT4HdbSy/foCmLGoyK0+XATf44my8yatS3RUSQ8er
         hnEld5RnINKI7BA4FORTcngkDdPVRiUBFjpwfw8WEuqcl1nqOYaZd22qYdtPt2pMh9
         /mtSQluXqQqavO9aH5dt6xMXdlNtb15LdU/APRDk=
Message-ID: <f04ca91e7c617c01e8428725a5286157415a3dac.camel@kernel.org>
Subject: Re: [RFC PATCH v2 01/18] vfs: export new_inode_pseudo
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Date:   Wed, 09 Sep 2020 12:51:02 -0400
In-Reply-To: <20200909161242.GA828@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
         <20200904160537.76663-2-jlayton@kernel.org>
         <20200908033819.GD68127@sol.localdomain>
         <42e2de297552a8642bfe21ab082e490678b5be38.camel@kernel.org>
         <20200908223125.GA3760467@gmail.com>
         <6cfe023df5cf6c50d6197bb7c71b3fa6a51bf555.camel@kernel.org>
         <20200909161242.GA828@sol.localdomain>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-09-09 at 09:12 -0700, Eric Biggers wrote:
> On Wed, Sep 09, 2020 at 06:47:28AM -0400, Jeff Layton wrote:
> > On Tue, 2020-09-08 at 15:31 -0700, Eric Biggers wrote:
> > > On Tue, Sep 08, 2020 at 07:27:58AM -0400, Jeff Layton wrote:
> > > > On Mon, 2020-09-07 at 20:38 -0700, Eric Biggers wrote:
> > > > > On Fri, Sep 04, 2020 at 12:05:20PM -0400, Jeff Layton wrote:
> > > > > > Ceph needs to be able to allocate inodes ahead of a create that might
> > > > > > involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> > > > > > but it puts the inode on the sb->s_inodes list, and we don't want to
> > > > > > do that until we're ready to insert it into the hash.
> > > > > > 
> > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > ---
> > > > > >  fs/inode.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > > 
> > > > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > > > index 72c4c347afb7..61554c2477ab 100644
> > > > > > --- a/fs/inode.c
> > > > > > +++ b/fs/inode.c
> > > > > > @@ -935,6 +935,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
> > > > > >  	}
> > > > > >  	return inode;
> > > > > >  }
> > > > > > +EXPORT_SYMBOL(new_inode_pseudo);
> > > > > >  
> > > > > 
> > > > > What's the problem with putting the new inode on sb->s_inodes already?
> > > > > That's what all the other filesystems do.
> > > > > 
> > > > 
> > > > The existing ones are all local filesystems that use
> > > > insert_inode_locked() and similar paths. Ceph needs to use the '5'
> > > > variants of those functions (inode_insert5(), iget5_locked(), etc.).
> > > > 
> > > > When we go to insert it into the hash in inode_insert5(), we'd need to
> > > > set I_CREATING if allocated from new_inode(). But, if you do _that_,
> > > > then you'll get back ESTALE from find_inode() if (eg.) someone calls
> > > > iget5_locked() before you can clear I_CREATING.
> > > > 
> > > > Hitting that race is easy with an asynchronous create. The simplest
> > > > scheme to avoid that is to just export new_inode_pseudo and keep it off
> > > > of s_inodes until we're ready to do the insert. The only real issue here
> > > > is that this inode won't be findable by evict_inodes during umount, but
> > > > that shouldn't be happening during an active syscall anyway.
> > > 
> > > Is your concern the following scenario?
> > > 
> > > 1. ceph successfully created a new file on the server
> > > 2. inode_insert5() is called for the new file's inode
> > > 3. error occurs in ceph_fill_inode()
> > > 4. discard_new_inode() is called
> > > 5. another thread looks up the inode and gets ESTALE
> > > 6. iput() is finally called
> > > 
> > > And the claim is that the ESTALE in (5) is unexpected?  I'm not sure that it's
> > > unexpected, given that the file allegedly failed to be created...  Also, it
> > > seems that maybe (3) isn't something that should actually happen, since after
> > > (1) it's too late to fail the file creation.
> > > 
> > 
> > No, more like:
> > 
> > Syscall					Workqueue
> > ------------------------------------------------------------------------------
> > 1. allocate an inode
> > 2. determine we can do an async create
> >    and allocate an inode number for it
> > 3. hash the inode (must set I_CREATING
> >    if we allocated with new_inode()) 
> > 4. issue the call to the MDS
> > 5. finish filling out the inode()
> > 6.					MDS reply comes in, and workqueue thread
> > 					looks up new inode (-ESTALE)
> > 7. unlock_new_inode()
> > 
> > 
> > Because 6 happens before 7 in this case, we get an ESTALE on that
> > lookup.
> 
> How is ESTALE at (6) possible?  (3) will set I_NEW on the inode when inserting
> it into the inode hash table.  Then (6) will wait for I_NEW to be cleared before
> returning the inode.  (7) will clear I_NEW and I_CREATING together.
> 

Long call chain, but:

ceph_fill_trace
   ceph_get_inode
      iget5_locked
         ilookup5(..._nowait, etc)
            find_inode_fast


...and find_inode_fast does:

                if (unlikely(inode->i_state & I_CREATING)) {                                        
                        spin_unlock(&inode->i_lock);                                                
                        return ERR_PTR(-ESTALE);                                                    
                }                                                                                   

-- 
Jeff Layton <jlayton@kernel.org>

