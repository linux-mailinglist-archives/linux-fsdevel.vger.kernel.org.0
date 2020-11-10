Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FAED2ADAF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 16:55:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgKJPzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 10:55:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:42812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbgKJPzL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:55:11 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8242B20678;
        Tue, 10 Nov 2020 15:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605023711;
        bh=VOtMpxt/g+8QNrCCztO8kyXSNbpXTZU8HKmddESaGao=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=NNVASeTW/+M8rSg7ZJX9jcDT+XxPwzGKXtmSNULif9cdweQckjj4Vhp0auKMB4ZD0
         o+sJx5f1LxzPLbGIGUqcKVTvvxuSfJ/auPxyRZc8YNOIGS261LVaSoFOoPQiLdQZa+
         EsDd3WtWKtXMGjHmKPNOVhkmV07OaEeYpuB7S3EE=
Message-ID: <9860e28cdb88617462912548f1af4dfaecb602ab.camel@kernel.org>
Subject: Re: [PATCH] fs/inode.c: make inode_init_always() initialize i_ino
 to 0
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>, linux-fsdevel@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org
Date:   Tue, 10 Nov 2020 10:55:09 -0500
In-Reply-To: <20201031004420.87678-1-ebiggers@kernel.org>
References: <20201031004420.87678-1-ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.1 (3.38.1-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2020-10-30 at 17:44 -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Currently inode_init_always() doesn't initialize i_ino to 0.  This is
> unexpected because unlike the other inode fields that aren't initialized
> by inode_init_always(), i_ino isn't guaranteed to end up back at its
> initial value after the inode is freed.  Only one filesystem (XFS)
> actually sets set i_ino back to 0 when freeing its inodes.
> 
> So, callers of new_inode() see some random previous i_ino.  Normally
> that's fine, since normally i_ino isn't accessed before being set.
> There can be edge cases where that isn't necessarily true, though.
> 
> The one I've run into is that on ext4, when creating an encrypted file,
> the new file's encryption key has to be set up prior to the jbd2
> transaction, and thus prior to i_ino being set.  If something goes
> wrong, fs/crypto/ may log warning or error messages, which normally
> include i_ino.  So it needs to know whether it is valid to include i_ino
> yet or not.  Also, on some files i_ino needs to be hashed for use in the
> crypto, so fs/crypto/ needs to know whether that can be done yet or not.
> 
> There are ways this could be worked around, either in fs/crypto/ or in
> fs/ext4/.  But, it seems there's no reason not to just fix
> inode_init_always() to do the expected thing and initialize i_ino to 0.
> 
> So, do that, and also remove the initialization in jfs_fill_super() that
> becomes redundant.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  fs/inode.c     | 1 +
>  fs/jfs/super.c | 1 -
>  2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d78c37b00b81..eb001129f157c 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -142,6 +142,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
>  	atomic_set(&inode->i_count, 1);
>  	inode->i_op = &empty_iops;
>  	inode->i_fop = &no_open_fops;
> +	inode->i_ino = 0;
>  	inode->__i_nlink = 1;
>  	inode->i_opflags = 0;
>  	if (sb->s_xattr)
> diff --git a/fs/jfs/super.c b/fs/jfs/super.c
> index b2dc4d1f9dcc5..1f0ffabbde566 100644
> --- a/fs/jfs/super.c
> +++ b/fs/jfs/super.c
> @@ -551,7 +551,6 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
>  		ret = -ENOMEM;
>  		goto out_unload;
>  	}
> -	inode->i_ino = 0;
>  	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
>  	inode->i_mapping->a_ops = &jfs_metapage_aops;
>  	inode_fake_hash(inode);
> 
> base-commit: 5fc6b075e165f641fbc366b58b578055762d5f8c

This seems like a reasonable thing to do.

Acked-by: Jeff Layton <jlayton@kernel.org>

