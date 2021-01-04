Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1071F2E9DFB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 20:12:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbhADTL0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 14:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726019AbhADTLY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 14:11:24 -0500
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8559CC061574;
        Mon,  4 Jan 2021 11:10:44 -0800 (PST)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kwVFb-006r86-1a; Mon, 04 Jan 2021 19:10:43 +0000
Date:   Mon, 4 Jan 2021 19:10:43 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/inode.c: make inode_init_always() initialize i_ino to
 0
Message-ID: <20210104191043.GM3579531@ZenIV.linux.org.uk>
References: <20201031004420.87678-1-ebiggers@kernel.org>
 <20201106175205.GE845@sol.localdomain>
 <X7gP9iuTuRp9MHpP@sol.localdomain>
 <X8gE01JQANXhenMC@gmail.com>
 <X/NkSg4i7h5h4+Wc@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/NkSg4i7h5h4+Wc@sol.localdomain>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 04, 2021 at 10:54:02AM -0800, Eric Biggers wrote:
> On Wed, Dec 02, 2020 at 01:19:15PM -0800, Eric Biggers wrote:
> > On Fri, Nov 20, 2020 at 10:50:30AM -0800, Eric Biggers wrote:
> > > On Fri, Nov 06, 2020 at 09:52:05AM -0800, Eric Biggers wrote:
> > > > On Fri, Oct 30, 2020 at 05:44:20PM -0700, Eric Biggers wrote:
> > > > > From: Eric Biggers <ebiggers@google.com>
> > > > > 
> > > > > Currently inode_init_always() doesn't initialize i_ino to 0.  This is
> > > > > unexpected because unlike the other inode fields that aren't initialized
> > > > > by inode_init_always(), i_ino isn't guaranteed to end up back at its
> > > > > initial value after the inode is freed.  Only one filesystem (XFS)
> > > > > actually sets set i_ino back to 0 when freeing its inodes.
> > > > > 
> > > > > So, callers of new_inode() see some random previous i_ino.  Normally
> > > > > that's fine, since normally i_ino isn't accessed before being set.
> > > > > There can be edge cases where that isn't necessarily true, though.
> > > > > 
> > > > > The one I've run into is that on ext4, when creating an encrypted file,
> > > > > the new file's encryption key has to be set up prior to the jbd2
> > > > > transaction, and thus prior to i_ino being set.  If something goes
> > > > > wrong, fs/crypto/ may log warning or error messages, which normally
> > > > > include i_ino.  So it needs to know whether it is valid to include i_ino
> > > > > yet or not.  Also, on some files i_ino needs to be hashed for use in the
> > > > > crypto, so fs/crypto/ needs to know whether that can be done yet or not.
> > > > > 
> > > > > There are ways this could be worked around, either in fs/crypto/ or in
> > > > > fs/ext4/.  But, it seems there's no reason not to just fix
> > > > > inode_init_always() to do the expected thing and initialize i_ino to 0.
> > > > > 
> > > > > So, do that, and also remove the initialization in jfs_fill_super() that
> > > > > becomes redundant.
> > > > > 
> > > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > > ---
> > > > >  fs/inode.c     | 1 +
> > > > >  fs/jfs/super.c | 1 -
> > > > >  2 files changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > > index 9d78c37b00b81..eb001129f157c 100644
> > > > > --- a/fs/inode.c
> > > > > +++ b/fs/inode.c
> > > > > @@ -142,6 +142,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> > > > >  	atomic_set(&inode->i_count, 1);
> > > > >  	inode->i_op = &empty_iops;
> > > > >  	inode->i_fop = &no_open_fops;
> > > > > +	inode->i_ino = 0;
> > > > >  	inode->__i_nlink = 1;
> > > > >  	inode->i_opflags = 0;
> > > > >  	if (sb->s_xattr)
> > > > > diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> > > > > index b2dc4d1f9dcc5..1f0ffabbde566 100644
> > > > > --- a/fs/jfs/super.c
> > > > > +++ b/fs/jfs/super.c
> > > > > @@ -551,7 +551,6 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
> > > > >  		ret = -ENOMEM;
> > > > >  		goto out_unload;
> > > > >  	}
> > > > > -	inode->i_ino = 0;
> > > > >  	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
> > > > >  	inode->i_mapping->a_ops = &jfs_metapage_aops;
> > > > >  	inode_fake_hash(inode);
> > > > > 
> > > > 
> > > > Al, any thoughts on this?
> > 
> > Ping.
> 
> Ping.

Applied.
