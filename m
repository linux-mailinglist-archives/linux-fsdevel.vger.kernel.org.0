Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2061727508B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Sep 2020 07:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgIWF7x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Sep 2020 01:59:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:38524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgIWF7x (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Sep 2020 01:59:53 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 73F0123444;
        Wed, 23 Sep 2020 05:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600840792;
        bh=I/8XzISzbBcCgYVmxLepZyG9w1CITHS3v+J9bySyNa0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ma7PADmZA95LLBo9KrXphWNWVsOVp+R73XlXBBcLHitEY4X5VwCFJSVq7vuCYgC3V
         HIT9jQdNXpRYH0Rkj3vSz4V7G9BGteBdDqsxV/pAjN1mmz6khsLf9uFQEZlx+JA+bt
         9uHpKQjziJ+IY+pVDK+nuHCnTz8A3CoT7WQ/HOGU=
Date:   Tue, 22 Sep 2020 22:59:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Chao Yu <chao@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Richard Weinberger <richard@nod.at>,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/5] fscrypt: Export fscrypt_d_revalidate
Message-ID: <20200923055950.GC9538@sol.localdomain>
References: <20200923010151.69506-1-drosen@google.com>
 <20200923010151.69506-3-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200923010151.69506-3-drosen@google.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 23, 2020 at 01:01:48AM +0000, Daniel Rosenberg wrote:
> This is in preparation for shifting the responsibility of setting the
> dentry_operations to the filesystem, allowing it to maintain its own
> operations.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/crypto/fname.c       | 3 ++-
>  include/linux/fscrypt.h | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 011830f84d8d..d45db23ff6c4 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -541,7 +541,7 @@ EXPORT_SYMBOL_GPL(fscrypt_fname_siphash);
>   * Validate dentries in encrypted directories to make sure we aren't potentially
>   * caching stale dentries after a key has been added.
>   */
> -static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
> +int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  {
>  	struct dentry *dir;
>  	int err;
> @@ -580,6 +580,7 @@ static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  
>  	return valid;
>  }
> +EXPORT_SYMBOL_GPL(fscrypt_d_revalidate);
>  
>  const struct dentry_operations fscrypt_d_ops = {
>  	.d_revalidate = fscrypt_d_revalidate,
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 991ff8575d0e..265b1e9119dc 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -207,6 +207,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
>  bool fscrypt_match_name(const struct fscrypt_name *fname,
>  			const u8 *de_name, u32 de_name_len);
>  u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *name);
> +extern int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags);

Please don't use 'extern' here.

Also FYI, Jeff Layton has sent this same patch as part of the ceph support for
fscrypt: https://lkml.kernel.org/linux-fscrypt/20200914191707.380444-4-jlayton@kernel.org

I'd like to apply one of them for 5.10 to get it out of the way for both
patchsets, but I'd like for the commit message to mention both users.

- Eric
