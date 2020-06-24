Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7D8206C11
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 07:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389097AbgFXF5L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 01:57:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:59580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388724AbgFXF5K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:57:10 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4DCC22085B;
        Wed, 24 Jun 2020 05:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592978229;
        bh=2lsFqyU8P0hr8E82YY+KRZpjYFvt+d061bicFKiQlRc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lbxsf9ik4Ybnb1VNbbAkDP+AkNKZAjMqErfEG+Qv5FJjpqdXBrE0v20o6fKaxGDjU
         6IbwyTMIIAryhYBDmhFPRgTRIvcrOwKn8x8VQtZkIfd6G07QWTXk8aEvAPsrzSaFLQ
         hTu4hRjCUpgjrPNmucpIRCRbHtnLrLbiJjgdLxRY=
Date:   Tue, 23 Jun 2020 22:57:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v9 2/4] fs: Add standard casefolding support
Message-ID: <20200624055707.GG844@sol.localdomain>
References: <20200624043341.33364-1-drosen@google.com>
 <20200624043341.33364-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624043341.33364-3-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:33:39PM -0700, Daniel Rosenberg wrote:
> This adds general supporting functions for filesystems that use
> utf8 casefolding. It provides standard dentry_operations and adds the
> necessary structures in struct super_block to allow this standardization.
> 
> Ext4 and F2fs will switch to these common implementations.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/libfs.c         | 101 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/fs.h |  22 ++++++++++
>  2 files changed, 123 insertions(+)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 4d08edf19c782..f7345a5ed562f 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -20,6 +20,8 @@
>  #include <linux/fs_context.h>
>  #include <linux/pseudo_fs.h>
>  #include <linux/fsnotify.h>
> +#include <linux/unicode.h>
> +#include <linux/fscrypt.h>
>  
>  #include <linux/uaccess.h>
>  
> @@ -1363,3 +1365,102 @@ bool is_empty_dir_inode(struct inode *inode)
>  	return (inode->i_fop == &empty_dir_operations) &&
>  		(inode->i_op == &empty_dir_inode_operations);
>  }
> +
> +#ifdef CONFIG_UNICODE
> +/**
> + * needs_casefold - generic helper to determine if a filename should be casefolded
> + * @dir: Parent directory
> + *
> + * Generic helper for filesystems to use to determine if the name of a dentry
> + * should be casefolded. It does not make sense to casefold the no-key token of
> + * an encrypted filename.
> + *
> + * Return: if names will need casefolding
> + */
> +bool needs_casefold(const struct inode *dir)
> +{
> +	return IS_CASEFOLDED(dir) && dir->i_sb->s_encoding &&
> +			(!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir));
> +}
> +EXPORT_SYMBOL(needs_casefold);

Note that the '!IS_ENCRYPTED(dir) || fscrypt_has_encryption_key(dir)' check can
be racy, because a process can be looking up a no-key token in a directory while
concurrently another process initializes the directory's ->i_crypt_info, causing
fscrypt_has_encryption_key(dir) to suddenly start returning true.

In my rework of filename handling in f2fs, I actually ended up removing all
calls to needs_casefold(), thus avoiding this race.  f2fs now decides whether
the name is going to need casefolding early on, in __f2fs_setup_filename(),
where it knows in a race-free way whether the filename is a no-key token or not.

Perhaps ext4 should work the same way?  It did look like there would be some
extra complexity due to how the ext4 directory hashing works in comparison to
f2fs's, but I haven't had a chance to properly investigate it.

- Eric
