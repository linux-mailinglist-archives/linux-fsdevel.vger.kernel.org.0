Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6277F2699E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Sep 2020 01:44:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgINXoD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Sep 2020 19:44:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:45354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbgINXoC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Sep 2020 19:44:02 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF885208B3;
        Mon, 14 Sep 2020 23:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600127042;
        bh=+DqxYvBngyZrZz22UeBG9+BpvNMUMtZj7c0av3Ii81Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=x5F9JkPe5AV5E/C+Hz6KKHq7jirNq4iiG2EHTCfUudMK6YCJ2/1WTnRBTHoEKgQFy
         /JIiFRqXV66hZE6K7NUn+Ku3LPLp8Ez5InxCmdkQUtFBKJIYQU5KqAfdmdzyvknGlk
         Dj+FWYdyR4iusssoBUjWlD0e2rBC0MZVkUg1cYdY=
Date:   Mon, 14 Sep 2020 16:44:00 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v3 02/16] fscrypt: export fscrypt_base64_encode and
 fscrypt_base64_decode
Message-ID: <20200914234400.GB899@sol.localdomain>
References: <20200914191707.380444-1-jlayton@kernel.org>
 <20200914191707.380444-3-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200914191707.380444-3-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 14, 2020 at 03:16:53PM -0400, Jeff Layton wrote:
> Ceph will need to base64-encode some encrypted inode names, so make
> these routines, and FSCRYPT_BASE64_CHARS available to modules.

"inode names" => "filenames"

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/crypto/fname.c       | 59 ++++++++++++++++++++++++++++++++++-------
>  include/linux/fscrypt.h |  4 +++
>  2 files changed, 53 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index eb13408b50a7..a1cb6c2c50c4 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -187,10 +187,8 @@ static int fname_decrypt(const struct inode *inode,
>  static const char lookup_table[65] =
>  	"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+,";
>  
> -#define BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> -
>  /**
> - * base64_encode() - base64-encode some bytes
> + * fscrypt_base64_encode() - base64-encode some bytes
>   * @src: the bytes to encode
>   * @len: number of bytes to encode
>   * @dst: (output) the base64-encoded string.  Not NUL-terminated.
> @@ -200,7 +198,7 @@ static const char lookup_table[65] =
>   *
>   * Return: length of the encoded string
>   */
> -static int base64_encode(const u8 *src, int len, char *dst)
> +int fscrypt_base64_encode(const u8 *src, int len, char *dst)
>  {
>  	int i, bits = 0, ac = 0;
>  	char *cp = dst;
> @@ -218,8 +216,9 @@ static int base64_encode(const u8 *src, int len, char *dst)
>  		*cp++ = lookup_table[ac & 0x3f];
>  	return cp - dst;
>  }
> +EXPORT_SYMBOL(fscrypt_base64_encode);
>  
> -static int base64_decode(const char *src, int len, u8 *dst)
> +int fscrypt_base64_decode(const char *src, int len, u8 *dst)

fscrypt_base64_decode() could use a kerneldoc comment, now that it will be
exported for filesystems to use.

> +void fscrypt_encode_nokey_name(u32 hash, u32 minor_hash,
> +			     const struct fscrypt_str *iname,
> +			     struct fscrypt_str *oname)
> +{
> +	struct fscrypt_nokey_name nokey_name;
> +	u32 size; /* size of the unencoded no-key name */
> +
> +	/*
> +	 * Sanity check that struct fscrypt_nokey_name doesn't have padding
> +	 * between fields and that its encoded size never exceeds NAME_MAX.
> +	 */
> +	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, dirhash) !=
> +		     offsetof(struct fscrypt_nokey_name, bytes));
> +	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
> +		     offsetof(struct fscrypt_nokey_name, sha256));
> +	BUILD_BUG_ON(FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
> +
> +	if (hash) {
> +		nokey_name.dirhash[0] = hash;
> +		nokey_name.dirhash[1] = minor_hash;
> +	} else {
> +		nokey_name.dirhash[0] = 0;
> +		nokey_name.dirhash[1] = 0;
> +	}
> +	if (iname->len <= sizeof(nokey_name.bytes)) {
> +		memcpy(nokey_name.bytes, iname->name, iname->len);
> +		size = offsetof(struct fscrypt_nokey_name, bytes[iname->len]);
> +	} else {
> +		memcpy(nokey_name.bytes, iname->name, sizeof(nokey_name.bytes));
> +		/* Compute strong hash of remaining part of name. */
> +		fscrypt_do_sha256(&iname->name[sizeof(nokey_name.bytes)],
> +				  iname->len - sizeof(nokey_name.bytes),
> +				  nokey_name.sha256);
> +		size = FSCRYPT_NOKEY_NAME_MAX;
> +	}
> +	oname->len = fscrypt_base64_encode((const u8 *)&nokey_name, size, oname->name);
> +}
> +EXPORT_SYMBOL(fscrypt_encode_nokey_name);

fscrypt_encode_nokey_name() still isn't actually used in this patchset.  Also,
the commit message doesn't mention it; it only mentions the base64 encoding and
decoding.

> +
>  /**
>   * fscrypt_fname_disk_to_usr() - convert an encrypted filename to
>   *				 user-presentable form
> @@ -351,7 +390,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
>  		     offsetof(struct fscrypt_nokey_name, bytes));
>  	BUILD_BUG_ON(offsetofend(struct fscrypt_nokey_name, bytes) !=
>  		     offsetof(struct fscrypt_nokey_name, sha256));
> -	BUILD_BUG_ON(BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
> +	BUILD_BUG_ON(FSCRYPT_BASE64_CHARS(FSCRYPT_NOKEY_NAME_MAX) > NAME_MAX);
>  
>  	if (hash) {
>  		nokey_name.dirhash[0] = hash;
> @@ -371,7 +410,7 @@ int fscrypt_fname_disk_to_usr(const struct inode *inode,
>  				  nokey_name.sha256);
>  		size = FSCRYPT_NOKEY_NAME_MAX;
>  	}
> -	oname->len = base64_encode((const u8 *)&nokey_name, size, oname->name);
> +	oname->len = fscrypt_base64_encode((const u8 *)&nokey_name, size, oname->name);

Personally I still prefer keeping keeping lines at or below the traditional 80
column limit, at least in existing files, and not introducing random longer
lines...  I.e. pass --max-line-length=80 to checkpatch.

> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index b3b0c5675c6b..95dddba3ed00 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -182,6 +182,10 @@ void fscrypt_free_inode(struct inode *inode);
>  int fscrypt_drop_inode(struct inode *inode);
>  
>  /* fname.c */
> +#define FSCRYPT_BASE64_CHARS(nbytes)	DIV_ROUND_UP((nbytes) * 4, 3)
> +
> +int fscrypt_base64_encode(const u8 *src, int len, char *dst);
> +int fscrypt_base64_decode(const char *src, int len, u8 *dst);
>  int fscrypt_setup_filename(struct inode *inode, const struct qstr *iname,
>  			   int lookup, struct fscrypt_name *fname);

Aren't stubs for !CONFIG_FS_ENCRYPTION needed?

- Eric
