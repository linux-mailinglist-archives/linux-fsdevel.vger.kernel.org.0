Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321E915A0C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 06:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgBLFrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 00:47:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:39652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgBLFrY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:47:24 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D15620714;
        Wed, 12 Feb 2020 05:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581486442;
        bh=vfQCzX8Gzst/DyzbbP8Yb9hEeqTup17d6ibCA2atEQk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=16O0AgpGnIblG8wXcW2EbHRzkj93++0mtvCGjFsyUCV76OVBn3s08Rm0Tzv10tDKX
         lVogvBzynO1bch/RJ/BUyPtnWFQPHyHktHkoCQZmBDMm5mY+WEzsP8LNaRpna7Nlxp
         fGy1pIz8XmPZ5U7MkLYBItDm8Mu67V3uwnIqWsJk=
Date:   Tue, 11 Feb 2020 21:47:20 -0800
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
Subject: Re: [PATCH v7 6/8] f2fs: Handle casefolding with Encryption
Message-ID: <20200212054720.GH870@sol.localdomain>
References: <20200208013552.241832-1-drosen@google.com>
 <20200208013552.241832-7-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200208013552.241832-7-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:35:50PM -0800, Daniel Rosenberg wrote:
> @@ -173,24 +193,24 @@ static inline bool f2fs_match_name(struct f2fs_dentry_ptr *d,
>  {
>  #ifdef CONFIG_UNICODE
>  	struct inode *parent = d->inode;
> -	struct super_block *sb = parent->i_sb;
> -	struct qstr entry;
> +	unsigned char *name;
> +	int len;
>  #endif
>  
>  	if (de->hash_code != namehash)
>  		return false;
>  
>  #ifdef CONFIG_UNICODE
> -	entry.name = d->filename[bit_pos];
> -	entry.len = de->name_len;
> +	name = d->filename[bit_pos];
> +	len = de->name_len;

This is missing le16_to_cpu().

>  int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>  				const struct qstr *orig_name,
> +				f2fs_hash_t dentry_hash,
>  				struct inode *inode, nid_t ino, umode_t mode)
>  {
>  	unsigned int bit_pos;
>  	unsigned int level;
>  	unsigned int current_depth;
>  	unsigned long bidx, block;
> -	f2fs_hash_t dentry_hash;
>  	unsigned int nbucket, nblock;
>  	struct page *dentry_page = NULL;
>  	struct f2fs_dentry_block *dentry_blk = NULL;
> @@ -632,7 +652,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>  
>  	level = 0;
>  	slots = GET_DENTRY_SLOTS(new_name->len);
> -	dentry_hash = f2fs_dentry_hash(dir, new_name, NULL);

Why was the call to f2fs_dentry_hash() moved to the caller, but for
f2fs_add_inline_entry() a different approach was taken?

> @@ -718,17 +737,19 @@ int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
>  				struct inode *inode, nid_t ino, umode_t mode)
>  {
>  	struct qstr new_name;
> +	f2fs_hash_t dentry_hash;
>  	int err = -EAGAIN;
>  
>  	new_name.name = fname_name(fname);
>  	new_name.len = fname_len(fname);
>  
>  	if (f2fs_has_inline_dentry(dir))
> -		err = f2fs_add_inline_entry(dir, &new_name, fname->usr_fname,
> +		err = f2fs_add_inline_entry(dir, &new_name, fname,
>  							inode, ino, mode);

I'm really confused.  Why are you passing around both new_name and fname?
We already have new_name == fname.disk_name.  So isn't just the
'struct fscrypt_name' sufficient?

> +static f2fs_hash_t __f2fs_dentry_hash(const struct inode *dir,
> +				const struct qstr *name_info,
> +				const struct fscrypt_name *fname)
>  {
>  	__u32 hash;
>  	f2fs_hash_t f2fs_hash;
> @@ -85,6 +86,11 @@ static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
>  	if (is_dot_dotdot(name_info))
>  		return 0;
>  
> +	if (IS_CASEFOLDED(dir) && IS_ENCRYPTED(dir)) {
> +		f2fs_hash = fscrypt_fname_siphash(dir, name_info);
> +		return f2fs_hash;
> +	}

This is missing cpu_to_le32().

Also, above we have:

        /* encrypted bigname case */
        if (fname && !fname->disk_name.name)
                return cpu_to_le32(fname->hash);

That won't work with encrypted+casefolded directories without the key, because
now sometimes the hash from the no-key name is needed even when the disk_name is
available.  This will cause a crash in fscrypt_fname_siphash() being called
without the key.  I think you want:

        if (fname && fname->is_ciphertext_name)
                return cpu_to_le32(fname->hash);

Can you please write xfstests for encrypt+casefold?

- Eric
