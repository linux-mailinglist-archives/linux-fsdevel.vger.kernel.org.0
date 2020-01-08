Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67BAB134F4C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 23:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726895AbgAHWH0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jan 2020 17:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:55416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbgAHWHZ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jan 2020 17:07:25 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3A87206DA;
        Wed,  8 Jan 2020 22:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578521243;
        bh=+UnJvUkys/YWUVHVjABMYQ24pt1fYpAkSC4c1D+rAv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xq/aDkNkFZc4P3D2boMAu2AUJf2l/KLxBkxHHzhKfYNYB38tWxhNjzyEyWDfzcOjE
         FqYbhY0CHy2zs/QSR0prrYwCC/D7bMIIVhusSDjOIhshpFEIMENhVe0XX1D38z53uL
         kgMBSK29Zk3E05KIPSiNRIGXouzeiao23DrDCq7s=
Date:   Wed, 8 Jan 2020 14:07:22 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daniel Rosenberg <drosen@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel-team@android.com
Subject: Re: [PATCH v2 3/3] fscrypt: Change format of no-key token
Message-ID: <20200108220722.GB232722@sol.localdomain>
References: <20200107023323.38394-1-drosen@google.com>
 <20200107023323.38394-4-drosen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107023323.38394-4-drosen@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A few more nits:

On Mon, Jan 06, 2020 at 06:33:23PM -0800, Daniel Rosenberg wrote:
> +static int fscrypt_do_sha256(unsigned char *result,
> +	     const u8 *data, unsigned int data_len)

Use 'u8 *' instead of 'unsigned char *', and then this fits on one line.

I'd probably also put 'result' last since it's an output parameter, and that
also matches the crypto interfaces.

> @@ -307,8 +372,7 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
>   * get the disk_name.
>   *
>   * Else, for keyless @lookup operations, @iname is the presented ciphertext, so
> - * we decode it to get either the ciphertext disk_name (for short names) or the
> - * fscrypt_digested_name (for long names).  Non-@lookup operations will be
> + * we decode it to get the fscrypt_nokey_name. Non-@lookup operations will be
>   * impossible in this case, so we fail them with ENOKEY.
>   *
>   * If successful, fscrypt_free_filename() must be called later to clean up.
> @@ -318,8 +382,8 @@ EXPORT_SYMBOL(fscrypt_fname_disk_to_usr);
>  int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
>  			      int lookup, struct fscrypt_name *fname)
>  {
> +	struct fscrypt_nokey_name *nokey_name;

This can be 'const'.

>  	int ret;
> -	int digested;
>  
>  	memset(fname, 0, sizeof(struct fscrypt_name));
>  	fname->usr_fname = iname;
> @@ -359,41 +423,29 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
>  	 * We don't have the key and we are doing a lookup; decode the
>  	 * user-supplied name
>  	 */
> -	if (iname->name[0] == '_') {
> -		if (iname->len !=
> -		    1 + BASE64_CHARS(sizeof(struct fscrypt_digested_name)))
> -			return -ENOENT;
> -		digested = 1;
> -	} else {
> -		if (iname->len >
> -		    BASE64_CHARS(FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE))
> -			return -ENOENT;
> -		digested = 0;
> -	}
>  
>  	fname->crypto_buf.name =
> -		kmalloc(max_t(size_t, FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE,
> -			      sizeof(struct fscrypt_digested_name)),
> -			GFP_KERNEL);
> +			kmalloc(sizeof(struct fscrypt_nokey_name), GFP_KERNEL);
>  	if (fname->crypto_buf.name == NULL)
>  		return -ENOMEM;
>  
> -	ret = base64_decode(iname->name + digested, iname->len - digested,
> -			    fname->crypto_buf.name);
> -	if (ret < 0) {
> +	if (iname->len > BASE64_CHARS(sizeof(struct fscrypt_nokey_name))) {
>  		ret = -ENOENT;
>  		goto errout;
>  	}
> -	fname->crypto_buf.len = ret;
> -	if (digested) {
> -		const struct fscrypt_digested_name *n =
> -			(const void *)fname->crypto_buf.name;
> -		fname->hash = n->hash;
> -		fname->minor_hash = n->minor_hash;
> -	} else {
> -		fname->disk_name.name = fname->crypto_buf.name;
> -		fname->disk_name.len = fname->crypto_buf.len;
> +	ret = base64_decode(iname->name, iname->len, fname->crypto_buf.name);
> +	if ((int)ret < offsetof(struct fscrypt_nokey_name, bytes[1]) ||
> +	    (ret > offsetof(struct fscrypt_nokey_name, sha256) &&
> +	     ret != offsetofend(struct fscrypt_nokey_name, sha256))) {
> +		ret = -ENOENT;
> +		goto errout;
>  	}
> +
> +	nokey_name = (void *)fname->crypto_buf.name;
> +	fname->crypto_buf.len = ret;
> +
> +	fname->hash = nokey_name->dirtree_hash[0];
> +	fname->minor_hash = nokey_name->dirtree_hash[1];
>  	return 0;
>  
>  errout:
> @@ -402,6 +454,62 @@ int fscrypt_setup_filename(struct inode *dir, const struct qstr *iname,
>  }
>  EXPORT_SYMBOL(fscrypt_setup_filename);
>  
> +/**
> + * fscrypt_match_name() - test whether the given name matches a directory entry
> + * @fname: the name being searched for
> + * @de_name: the name from the directory entry
> + * @de_name_len: the length of @de_name in bytes
> + *
> + * Normally @fname->disk_name will be set, and in that case we simply compare
> + * that to the name stored in the directory entry.  The only exception is that
> + * if we don't have the key for an encrypted directory we'll instead need to
> + * match against the fscrypt_nokey_name.
> + *
> + * Return: %true if the name matches, otherwise %false.
> + */
> +bool fscrypt_match_name(const struct fscrypt_name *fname,
> +				      const u8 *de_name, u32 de_name_len)

Align the continuation line:

bool fscrypt_match_name(const struct fscrypt_name *fname,
                        const u8 *de_name, u32 de_name_len)

> +	if (unlikely(!fname->disk_name.name)) {
> +		const struct fscrypt_nokey_name *n =
> +			(const void *)fname->crypto_buf.name;
> +
> +		if (fname->crypto_buf.len ==
> +			    offsetofend(struct fscrypt_nokey_name, sha256)) {
> +			u8 sha256[SHA256_DIGEST_SIZE];
> +
> +			if (de_name_len <= FSCRYPT_FNAME_UNDIGESTED_SIZE)
> +				return false;
> +			if (memcmp(de_name, n->bytes,
> +				   FSCRYPT_FNAME_UNDIGESTED_SIZE) != 0)
> +				return false;
> +			fscrypt_do_sha256(sha256,
> +				&de_name[FSCRYPT_FNAME_UNDIGESTED_SIZE],
> +				de_name_len - FSCRYPT_FNAME_UNDIGESTED_SIZE);
> +			if (memcmp(sha256, n->sha256, sizeof(sha256)) != 0)
> +				return false;

Should check the return value of fscrypt_do_sha256().  I guess for now just
return false if it fails.  It would be nice if the sha256 tfm were preallocated
when the directory was opened, or alternatively the sha256 library interface
were used, so that this couldn't fail.  But just returning false should be fine
for now...

> +			u32 len = fname->crypto_buf.len -
> +				offsetof(struct fscrypt_nokey_name, bytes);
> +
> +			if (de_name_len != len)
> +				return false;
> +
> +			if (memcmp(de_name, n->bytes, len) != 0)
> +				return false;
> +		}
> +
> +		return true;
> +	}
> +
> +	if (de_name_len != fname->disk_name.len)
> +		return false;
> +	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
> +}
> +EXPORT_SYMBOL(fscrypt_match_name);
> +
>  /**
>   * fscrypt_fname_siphash() - Calculate the siphash for a file name
>   * @dir: the parent directory
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 2c292f19c6b9..14a727759a81 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -179,79 +179,8 @@ extern int fscrypt_fname_disk_to_usr(const struct inode *inode,
>  extern u64 fscrypt_fname_siphash(const struct inode *dir,
>  				 const struct qstr *name);
>  
> -#define FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE	32
> -
> -/* Extracts the second-to-last ciphertext block; see explanation below */
> -#define FSCRYPT_FNAME_DIGEST(name, len)	\
> -	((name) + round_down((len) - FS_CRYPTO_BLOCK_SIZE - 1, \
> -			     FS_CRYPTO_BLOCK_SIZE))
> -
> -#define FSCRYPT_FNAME_DIGEST_SIZE	FS_CRYPTO_BLOCK_SIZE
> -
> -/**
> - * fscrypt_digested_name - alternate identifier for an on-disk filename
> - *
> - * When userspace lists an encrypted directory without access to the key,
> - * filenames whose ciphertext is longer than FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE
> - * bytes are shown in this abbreviated form (base64-encoded) rather than as the
> - * full ciphertext (base64-encoded).  This is necessary to allow supporting
> - * filenames up to NAME_MAX bytes, since base64 encoding expands the length.
> - *
> - * To make it possible for filesystems to still find the correct directory entry
> - * despite not knowing the full on-disk name, we encode any filesystem-specific
> - * 'hash' and/or 'minor_hash' which the filesystem may need for its lookups,
> - * followed by the second-to-last ciphertext block of the filename.  Due to the
> - * use of the CBC-CTS encryption mode, the second-to-last ciphertext block
> - * depends on the full plaintext.  (Note that ciphertext stealing causes the
> - * last two blocks to appear "flipped".)  This makes accidental collisions very
> - * unlikely: just a 1 in 2^128 chance for two filenames to collide even if they
> - * share the same filesystem-specific hashes.
> - *
> - * However, this scheme isn't immune to intentional collisions, which can be
> - * created by anyone able to create arbitrary plaintext filenames and view them
> - * without the key.  Making the "digest" be a real cryptographic hash like
> - * SHA-256 over the full ciphertext would prevent this, although it would be
> - * less efficient and harder to implement, especially since the filesystem would
> - * need to calculate it for each directory entry examined during a search.
> - */
> -struct fscrypt_digested_name {
> -	u32 hash;
> -	u32 minor_hash;
> -	u8 digest[FSCRYPT_FNAME_DIGEST_SIZE];
> -};
> -
> -/**
> - * fscrypt_match_name() - test whether the given name matches a directory entry
> - * @fname: the name being searched for
> - * @de_name: the name from the directory entry
> - * @de_name_len: the length of @de_name in bytes
> - *
> - * Normally @fname->disk_name will be set, and in that case we simply compare
> - * that to the name stored in the directory entry.  The only exception is that
> - * if we don't have the key for an encrypted directory and a filename in it is
> - * very long, then we won't have the full disk_name and we'll instead need to
> - * match against the fscrypt_digested_name.
> - *
> - * Return: %true if the name matches, otherwise %false.
> - */
> -static inline bool fscrypt_match_name(const struct fscrypt_name *fname,
> -				      const u8 *de_name, u32 de_name_len)
> -{
> -	if (unlikely(!fname->disk_name.name)) {
> -		const struct fscrypt_digested_name *n =
> -			(const void *)fname->crypto_buf.name;
> -		if (WARN_ON_ONCE(fname->usr_fname->name[0] != '_'))
> -			return false;
> -		if (de_name_len <= FSCRYPT_FNAME_MAX_UNDIGESTED_SIZE)
> -			return false;
> -		return !memcmp(FSCRYPT_FNAME_DIGEST(de_name, de_name_len),
> -			       n->digest, FSCRYPT_FNAME_DIGEST_SIZE);
> -	}
> -
> -	if (de_name_len != fname->disk_name.len)
> -		return false;
> -	return !memcmp(de_name, fname->disk_name.name, fname->disk_name.len);
> -}
> +extern bool fscrypt_match_name(const struct fscrypt_name *fname,
> +				      const u8 *de_name, u32 de_name_len);

Align the continuation line:

extern bool fscrypt_match_name(const struct fscrypt_name *fname,
                               const u8 *de_name, u32 de_name_len);

Also, this should be moved above fscrypt_fname_siphash() in order to match their
order in the .c file.

- Eric
