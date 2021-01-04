Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 965FF2E9D82
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 19:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbhADSyq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 13:54:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:49416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725830AbhADSyp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 13:54:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7A36821D1B;
        Mon,  4 Jan 2021 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609786444;
        bh=ALjPf9mA+5qsZKZg6AOgKpgqT+RTFmaxS7GgH34EOpE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AVibMkrVYs9xlvjjyN8JjyHSKImCnKlV3z6l7v9mSJjWoYSzmSCPQnGQc8ZosZBH7
         7S+i6Ks2iM5yLpSZeCUr6CztNcWpxfuZZbIONbbBwnEnWmcYBr72TqTAy4AlWc0WZC
         V7ytivWEVlUpoR45tJRG/Equ96CDSI+ci7Prvt7y9u7ieO7FOf+DeNADjZqRYfAgRk
         Z4VhOBrRYr00qBa5dTAnpr29TaXwxgiXQJkFN7+Bw1hI4J6oS1YcAsM6lHA7WFWDlH
         FiaBYebXIvsYSIg5fl34AIClCFYI3uQkjvLrr5TRVgNMxTi70PT3WHw7W/cxeSz7tf
         d6FgdGQJTL9Dw==
Date:   Mon, 4 Jan 2021 10:54:02 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] fs/inode.c: make inode_init_always() initialize i_ino to
 0
Message-ID: <X/NkSg4i7h5h4+Wc@sol.localdomain>
References: <20201031004420.87678-1-ebiggers@kernel.org>
 <20201106175205.GE845@sol.localdomain>
 <X7gP9iuTuRp9MHpP@sol.localdomain>
 <X8gE01JQANXhenMC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X8gE01JQANXhenMC@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 02, 2020 at 01:19:15PM -0800, Eric Biggers wrote:
> On Fri, Nov 20, 2020 at 10:50:30AM -0800, Eric Biggers wrote:
> > On Fri, Nov 06, 2020 at 09:52:05AM -0800, Eric Biggers wrote:
> > > On Fri, Oct 30, 2020 at 05:44:20PM -0700, Eric Biggers wrote:
> > > > From: Eric Biggers <ebiggers@google.com>
> > > > 
> > > > Currently inode_init_always() doesn't initialize i_ino to 0.  This is
> > > > unexpected because unlike the other inode fields that aren't initialized
> > > > by inode_init_always(), i_ino isn't guaranteed to end up back at its
> > > > initial value after the inode is freed.  Only one filesystem (XFS)
> > > > actually sets set i_ino back to 0 when freeing its inodes.
> > > > 
> > > > So, callers of new_inode() see some random previous i_ino.  Normally
> > > > that's fine, since normally i_ino isn't accessed before being set.
> > > > There can be edge cases where that isn't necessarily true, though.
> > > > 
> > > > The one I've run into is that on ext4, when creating an encrypted file,
> > > > the new file's encryption key has to be set up prior to the jbd2
> > > > transaction, and thus prior to i_ino being set.  If something goes
> > > > wrong, fs/crypto/ may log warning or error messages, which normally
> > > > include i_ino.  So it needs to know whether it is valid to include i_ino
> > > > yet or not.  Also, on some files i_ino needs to be hashed for use in the
> > > > crypto, so fs/crypto/ needs to know whether that can be done yet or not.
> > > > 
> > > > There are ways this could be worked around, either in fs/crypto/ or in
> > > > fs/ext4/.  But, it seems there's no reason not to just fix
> > > > inode_init_always() to do the expected thing and initialize i_ino to 0.
> > > > 
> > > > So, do that, and also remove the initialization in jfs_fill_super() that
> > > > becomes redundant.
> > > > 
> > > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > > > ---
> > > >  fs/inode.c     | 1 +
> > > >  fs/jfs/super.c | 1 -
> > > >  2 files changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/fs/inode.c b/fs/inode.c
> > > > index 9d78c37b00b81..eb001129f157c 100644
> > > > --- a/fs/inode.c
> > > > +++ b/fs/inode.c
> > > > @@ -142,6 +142,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
> > > >  	atomic_set(&inode->i_count, 1);
> > > >  	inode->i_op = &empty_iops;
> > > >  	inode->i_fop = &no_open_fops;
> > > > +	inode->i_ino = 0;
> > > >  	inode->__i_nlink = 1;
> > > >  	inode->i_opflags = 0;
> > > >  	if (sb->s_xattr)
> > > > diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> > > > index b2dc4d1f9dcc5..1f0ffabbde566 100644
> > > > --- a/fs/jfs/super.c
> > > > +++ b/fs/jfs/super.c
> > > > @@ -551,7 +551,6 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
> > > >  		ret = -ENOMEM;
> > > >  		goto out_unload;
> > > >  	}
> > > > -	inode->i_ino = 0;
> > > >  	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
> > > >  	inode->i_mapping->a_ops = &jfs_metapage_aops;
> > > >  	inode_fake_hash(inode);
> > > > 
> > > 
> > > Al, any thoughts on this?
> 
> Ping.

Ping.
