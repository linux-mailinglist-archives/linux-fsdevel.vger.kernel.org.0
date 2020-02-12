Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA89E15A056
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 06:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgBLFKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 00:10:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgBLFKQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 00:10:16 -0500
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2F0782073C;
        Wed, 12 Feb 2020 05:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581484215;
        bh=SoSyxp3A0UA/8Dnh/f7bNxJ3PKh7YiP5yN7Miz0urew=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NJ4hV4Xer0eG0SHiCiwOzByKd5JyUN7uZA4Ev57RCddYfHiQhVYc1ZP6Nu/jQiKeI
         sM/IB+kbGDo4+3rniEtpM5HWck5ZfygaFJlCh2p31egPYqFLRTnuG6Vzno8r8uusGN
         eqTOJ2fXAIxq3MOi1WPwMBn/MfIrQVYZVrO20sdk=
Date:   Tue, 11 Feb 2020 21:10:13 -0800
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
Message-ID: <20200212051013.GG870@sol.localdomain>
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
> This expands f2fs's casefolding support to include encrypted
> directories. For encrypted directories, we use the siphash of the
> casefolded name. This ensures there is no direct way to go from an
> unencrypted name to the stored hash on disk without knowledge of the
> encryption policy keys.
> 
> Additionally, we switch to using the vfs layer's casefolding support
> instead of storing this information inside of f2fs's private data.
> 
> Signed-off-by: Daniel Rosenberg <drosen@google.com>
> ---
>  fs/f2fs/dir.c    | 65 ++++++++++++++++++++++++++++++++----------------
>  fs/f2fs/f2fs.h   |  8 +++---
>  fs/f2fs/hash.c   | 23 +++++++++++------
>  fs/f2fs/inline.c |  9 ++++---
>  fs/f2fs/super.c  |  6 -----
>  5 files changed, 68 insertions(+), 43 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 38c0e6d589be4..3517dd4060341 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -112,30 +112,50 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
>   * doesn't match or less than zero on error.
>   */
>  int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
> -				const struct qstr *entry, bool quick)
> +		    unsigned char *name2, size_t len, bool quick)
>  {
>  	const struct super_block *sb = parent->i_sb;
>  	const struct unicode_map *um = sb->s_encoding;
> +	const struct fscrypt_str crypt_entry = FSTR_INIT(name2, len);
> +	struct fscrypt_str decrypted_entry;
> +	struct qstr decrypted;
> +	struct qstr entry = QSTR_INIT(name2, len);
> +	struct qstr *tocheck;
>  	int ret;
>  
> +	decrypted_entry.name = NULL;
> +
> +	if (IS_ENCRYPTED(parent) && fscrypt_has_encryption_key(parent)) {
> +		decrypted_entry.name = kmalloc(len, GFP_ATOMIC);
> +		decrypted.name = decrypted_entry.name;
> +		decrypted_entry.len = len;
> +		decrypted.len = len;
> +		if (!decrypted.name)
> +			return -ENOMEM;
> +		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &crypt_entry,
> +							&decrypted_entry);
> +		if (ret < 0)
> +			goto out;
> +	}
> +	tocheck = decrypted_entry.name ? &decrypted : &entry;
> +
>  	if (quick)
> -		ret = utf8_strncasecmp_folded(um, name, entry);
> +		ret = utf8_strncasecmp_folded(um, name, tocheck);
>  	else
> -		ret = utf8_strncasecmp(um, name, entry);
> -
> +		ret = utf8_strncasecmp(um, name, tocheck);
>  	if (ret < 0) {
>  		/* Handle invalid character sequence as either an error
>  		 * or as an opaque byte sequence.
>  		 */
>  		if (sb_has_enc_strict_mode(sb))
> -			return -EINVAL;
> -
> -		if (name->len != entry->len)
> -			return 1;
> -
> -		return !!memcmp(name->name, entry->name, name->len);
> +			ret = -EINVAL;
> +		else if (name->len != len)
> +			ret = 1;
> +		else
> +			ret = !!memcmp(name->name, tocheck->name, len);
>  	}
> -
> +out:
> +	kfree(decrypted_entry.name);
>  	return ret;
>  }

The case-sensitive fallback is broken with encrypted filenames; it's checking
the length of the encrypted filename rather than the decrypted filename.  The
decrypted name may be shorter.

Can you please improve your testing to catch bugs like this?

IMO, part of the problem is that there are multiple lengths here, so the
variable named 'len' is ambiguous.  Can you please clean this function up to
name things properly?  Also, the 'tocheck' variable is unnecessary, and it's
confusing having both 'decrypted' and 'decrypted_entry', and to decrypt
conditionally when fscrypt_has_encryption_key() since that's already required.

How about:

int f2fs_ci_compare(const struct inode *parent, const struct qstr *name,
		    u8 *de_name, size_t de_name_len, bool quick)
{
	const struct super_block *sb = parent->i_sb;
	const struct unicode_map *um = sb->s_encoding;
	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
	struct qstr entry = QSTR_INIT(de_name, de_name_len);
	int ret;

	if (IS_ENCRYPTED(parent)) {
		const struct fscrypt_str encrypted_name =
			FSTR_INIT(de_name, de_name_len);

		decrypted_name.name = kmalloc(de_name_len, GFP_ATOMIC);
		if (!decrypted_name.name)
			return -ENOMEM;
		ret = fscrypt_fname_disk_to_usr(parent, 0, 0, &encrypted_name,
						&decrypted_name);
		if (ret < 0)
			goto out;
		entry.name = decrypted_name.name;
		entry.len = decrypted_name.len;
	}

	if (quick)
		ret = utf8_strncasecmp_folded(um, name, &entry);
	else
		ret = utf8_strncasecmp(um, name, &entry);
	if (ret < 0) {
		/* Handle invalid character sequence as either an error
		 * or as an opaque byte sequence.
		 */
		if (sb_has_enc_strict_mode(sb))
			ret = -EINVAL;
		else if (name->len != entry.len)
			ret = 1;
		else
			ret = !!memcmp(name->name, entry.name, entry.len);
	}
out:
	kfree(decrypted_name.name);
	return ret;
}


Of course, all this applies to ext4_ci_compare() as well.

- Eric
