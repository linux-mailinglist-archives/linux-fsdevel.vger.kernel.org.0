Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D057217CAB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 03:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgGHBlU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 21:41:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:50510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728417AbgGHBlU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 21:41:20 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F3A74206DF;
        Wed,  8 Jul 2020 01:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594172479;
        bh=KAvFbnLGnnoN00vC1m9a7iUoWjJr1jCD7u4eNPmMldM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oxcXuBLgev+EmuOUJZ9xxnkt0hBRav9qYoi7+9qx2aRXuk3wI+obdTPMA4wLc01Ub
         qRgbpbnRamihiDOUJM0sRoCQ9boGhBrJGnqhrXYv9YQKgmYSMLDIb02Ix9DqzOy+rD
         PGou2nZqy4vEsYIx2llEo4tZE5Fa8wNOCopEAnFk=
Date:   Tue, 7 Jul 2020 18:41:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-fscrypt@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v10 3/4] f2fs: Use generic casefolding support
Message-ID: <20200708014117.GG839@sol.localdomain>
References: <20200707113123.3429337-1-drosen@google.com>
 <20200707113123.3429337-4-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707113123.3429337-4-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 07, 2020 at 04:31:22AM -0700, Daniel Rosenberg wrote:
> This switches f2fs over to the generic support provided in
> the previous patch.
> 
> Since casefolded dentries behave the same in ext4 and f2fs, we decrease
> the maintenance burden by unifying them, and any optimizations will
> immediately apply to both.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/f2fs/dir.c           | 83 +++++------------------------------------
>  fs/f2fs/f2fs.h          |  4 --
>  fs/f2fs/super.c         | 10 ++---
>  fs/f2fs/sysfs.c         | 10 +++--
>  include/linux/f2fs_fs.h |  3 --
>  5 files changed, 20 insertions(+), 90 deletions(-)

Looks good, you can add:

    Reviewed-by: Eric Biggers <ebiggers@google.com>

One nit below:

>  #ifdef CONFIG_UNICODE
> -static int f2fs_d_compare(const struct dentry *dentry, unsigned int len,
> -			  const char *str, const struct qstr *name)
> -{
> -	const struct dentry *parent = READ_ONCE(dentry->d_parent);
> -	const struct inode *dir = READ_ONCE(parent->d_inode);
> -	const struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
> -	struct qstr entry = QSTR_INIT(str, len);
> -	char strbuf[DNAME_INLINE_LEN];
> -	int res;
> -
> -	if (!dir || !IS_CASEFOLDED(dir))
> -		goto fallback;
> -
> -	/*
> -	 * If the dentry name is stored in-line, then it may be concurrently
> -	 * modified by a rename.  If this happens, the VFS will eventually retry
> -	 * the lookup, so it doesn't matter what ->d_compare() returns.
> -	 * However, it's unsafe to call utf8_strncasecmp() with an unstable
> -	 * string.  Therefore, we have to copy the name into a temporary buffer.
> -	 */
> -	if (len <= DNAME_INLINE_LEN - 1) {
> -		memcpy(strbuf, str, len);
> -		strbuf[len] = 0;
> -		entry.name = strbuf;
> -		/* prevent compiler from optimizing out the temporary buffer */
> -		barrier();
> -	}
> -
> -	res = utf8_strncasecmp(sbi->s_encoding, name, &entry);
> -	if (res >= 0)
> -		return res;
> -
> -	if (f2fs_has_strict_mode(sbi))
> -		return -EINVAL;
> -fallback:
> -	if (len != name->len)
> -		return 1;
> -	return !!memcmp(str, name->name, len);
> -}
> -
> -static int f2fs_d_hash(const struct dentry *dentry, struct qstr *str)
> -{
> -	struct f2fs_sb_info *sbi = F2FS_SB(dentry->d_sb);
> -	const struct unicode_map *um = sbi->s_encoding;
> -	const struct inode *inode = READ_ONCE(dentry->d_inode);
> -	unsigned char *norm;
> -	int len, ret = 0;
> -
> -	if (!inode || !IS_CASEFOLDED(inode))
> -		return 0;
> -
> -	norm = f2fs_kmalloc(sbi, PATH_MAX, GFP_ATOMIC);
> -	if (!norm)
> -		return -ENOMEM;
> -
> -	len = utf8_casefold(um, str, norm, PATH_MAX);
> -	if (len < 0) {
> -		if (f2fs_has_strict_mode(sbi))
> -			ret = -EINVAL;
> -		goto out;
> -	}
> -	str->hash = full_name_hash(dentry, norm, len);
> -out:
> -	kvfree(norm);
> -	return ret;
> -}
>  
>  const struct dentry_operations f2fs_dentry_ops = {
> -	.d_hash = f2fs_d_hash,
> -	.d_compare = f2fs_d_compare,
> +	.d_hash = generic_ci_d_hash,
> +	.d_compare = generic_ci_d_compare,
>  };
>  #endif

This leaves an extra blank line just above f2fs_dentry_ops.

- Eric
