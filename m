Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C510F17CC15
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Mar 2020 06:24:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgCGFY1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 7 Mar 2020 00:24:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:55806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgCGFY1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 7 Mar 2020 00:24:27 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BB0F0206D5;
        Sat,  7 Mar 2020 05:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583558666;
        bh=RX0pNoVLLIpZJez+whEJRUeQ38hXRUIlXOZTSFatJPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LuI8jDenuD9MDJb74KTi0cYu7g+PgR49RKpNM1J4/DpdTFuMztsm5BcT7iCbZLRFR
         /xk7S67Q4yYrKb0E1hrPg3TXQNbpsfTzE7JQwl+jgOyWS8u1lVtbQtSln4IssFgpap
         4js7JvYIxcRaCBJVznAVegpJWiyX1eui7nOWa3w4=
Date:   Fri, 6 Mar 2020 21:24:24 -0800
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
Subject: Re: [PATCH v8 8/8] f2fs: Handle casefolding with Encryption
Message-ID: <20200307052424.GB1069@sol.localdomain>
References: <20200307023611.204708-1-drosen@google.com>
 <20200307023611.204708-9-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200307023611.204708-9-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 06:36:11PM -0800, Daniel Rosenberg wrote:
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
> @@ -632,7 +650,6 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
>  
>  	level = 0;
>  	slots = GET_DENTRY_SLOTS(new_name->len);
> -	dentry_hash = f2fs_dentry_hash(dir, new_name, NULL);
>  
>  	current_depth = F2FS_I(dir)->i_current_depth;
>  	if (F2FS_I(dir)->chash == dentry_hash) {
> @@ -718,17 +735,19 @@ int f2fs_add_dentry(struct inode *dir, struct fscrypt_name *fname,
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
> +	dentry_hash = f2fs_dentry_hash(dir, &new_name, fname);
>  	if (err == -EAGAIN)
>  		err = f2fs_add_regular_entry(dir, &new_name, fname->usr_fname,
> -							inode, ino, mode);
> +						dentry_hash, inode, ino, mode);
>  

Why are the changes to f2fs_add_dentry(), f2fs_add_regular_entry(), and
f2fs_add_inline_entry() being made?  Directories can't be modified through
no-key names, so there's no need to make this part of the code handle grabbing
the dentry hash from the struct fscrypt_name.  And both the on-disk and original
filenames were already passed to these functions.  So what else do we need?

> +static f2fs_hash_t __f2fs_dentry_hash(const struct inode *dir,
> +				const struct qstr *name_info,
> +				const struct fscrypt_name *fname)
>  {
>  	__u32 hash;
>  	f2fs_hash_t f2fs_hash;
> @@ -79,12 +80,17 @@ static f2fs_hash_t __f2fs_dentry_hash(const struct qstr *name_info,
>  	size_t len = name_info->len;
>  
>  	/* encrypted bigname case */
> -	if (fname && !fname->disk_name.name)
> +	if (fname && !fname->is_ciphertext_name)
>  		return cpu_to_le32(fname->hash);

Isn't this check backwards?  The hash is valid if fname->is_ciphertext_name, not
if !fname->is_ciphertext_name.

(Maybe the phrase "ciphertext name" is causing confusion, as we're now calling
them "no-key names" instead?  We could rename it, if that would help.)

- Eric
