Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85E2622A5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Sep 2020 00:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbgIHWb2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 18:31:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:51048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728463AbgIHWb2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 18:31:28 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 333E8207DE;
        Tue,  8 Sep 2020 22:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599604287;
        bh=A1LfYdzKG72qmoSPkLTt71QAMNuJH3nWVaUGoZGihjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YJsuv9A4XQ5rH4phFzz5ro45Fsc1biUDYkrv45xUmGuJQskKp6IHWfmYn+KDdfFQH
         zDL2T34gEqAA2e0/FSzoig7jQ2QEZV3rwa08wBMwDzgKAKGjznsxzQYJ2MqsAuIBKN
         nho1D7lxL4p7xgWQOH9ynymQ93jPEXFR4Ref68Eg=
Date:   Tue, 8 Sep 2020 15:31:25 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 01/18] vfs: export new_inode_pseudo
Message-ID: <20200908223125.GA3760467@gmail.com>
References: <20200904160537.76663-1-jlayton@kernel.org>
 <20200904160537.76663-2-jlayton@kernel.org>
 <20200908033819.GD68127@sol.localdomain>
 <42e2de297552a8642bfe21ab082e490678b5be38.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42e2de297552a8642bfe21ab082e490678b5be38.camel@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 08, 2020 at 07:27:58AM -0400, Jeff Layton wrote:
> On Mon, 2020-09-07 at 20:38 -0700, Eric Biggers wrote:
> > On Fri, Sep 04, 2020 at 12:05:20PM -0400, Jeff Layton wrote:
> > > Ceph needs to be able to allocate inodes ahead of a create that might
> > > involve a fscrypt-encrypted inode. new_inode() almost fits the bill,
> > > but it puts the inode on the sb->s_inodes list, and we don't want to
> > > do that until we're ready to insert it into the hash.
> > > 
> > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > ---
> > >  fs/inode.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/fs/inode.c b/fs/inode.c
> > > index 72c4c347afb7..61554c2477ab 100644
> > > --- a/fs/inode.c
> > > +++ b/fs/inode.c
> > > @@ -935,6 +935,7 @@ struct inode *new_inode_pseudo(struct super_block *sb)
> > >  	}
> > >  	return inode;
> > >  }
> > > +EXPORT_SYMBOL(new_inode_pseudo);
> > >  
> > 
> > What's the problem with putting the new inode on sb->s_inodes already?
> > That's what all the other filesystems do.
> > 
> 
> The existing ones are all local filesystems that use
> insert_inode_locked() and similar paths. Ceph needs to use the '5'
> variants of those functions (inode_insert5(), iget5_locked(), etc.).
> 
> When we go to insert it into the hash in inode_insert5(), we'd need to
> set I_CREATING if allocated from new_inode(). But, if you do _that_,
> then you'll get back ESTALE from find_inode() if (eg.) someone calls
> iget5_locked() before you can clear I_CREATING.
> 
> Hitting that race is easy with an asynchronous create. The simplest
> scheme to avoid that is to just export new_inode_pseudo and keep it off
> of s_inodes until we're ready to do the insert. The only real issue here
> is that this inode won't be findable by evict_inodes during umount, but
> that shouldn't be happening during an active syscall anyway.

Is your concern the following scenario?

1. ceph successfully created a new file on the server
2. inode_insert5() is called for the new file's inode
3. error occurs in ceph_fill_inode()
4. discard_new_inode() is called
5. another thread looks up the inode and gets ESTALE
6. iput() is finally called

And the claim is that the ESTALE in (5) is unexpected?  I'm not sure that it's
unexpected, given that the file allegedly failed to be created...  Also, it
seems that maybe (3) isn't something that should actually happen, since after
(1) it's too late to fail the file creation.

- Eric
