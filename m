Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AAF83C3FD3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 00:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230435AbhGKW41 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jul 2021 18:56:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229544AbhGKW41 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jul 2021 18:56:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 52C3A61008;
        Sun, 11 Jul 2021 22:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626044019;
        bh=fNZh4l5+lAvcCs6wrBgsew6D+ISP6YlpA4DG02ZWRkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wx7JTfKZGIPThCFJw8Ei4ATDdjzdA+nYsMArQrxUhTlwXjFKkjpFK70Yx/s0MX3om
         1ITY545roAcS2LyFicZC/86EPCKBMvCWPiSagzSYxx4lh/rZ4bbdC6boGlQEKD0vxw
         qsYb2OSRRlfU9TmmH2KR/I6Z+sYZ31fQPex1la6MQ150KQMEkW/GpnDZ6tCRig0kw+
         HEg/G1PkisJoCjddPGd3El5HVwnISmwP0N3bkapjKxn7VVJdtycL9K1xyL4HtWwhSE
         Bzq147OClDBlyIc89AsW7qUxXLyTuEwG2nis6oQovNucnmYVizFW0QDKOvaGzgiqdj
         nl0cWU/mUcUZQ==
Date:   Sun, 11 Jul 2021 17:53:37 -0500
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Subject: Re: [RFC PATCH v7 15/24] ceph: add encrypted fname handling to
 ceph_mdsc_build_path
Message-ID: <YOt2cVJLEXt88SVJ@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
 <20210625135834.12934-16-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625135834.12934-16-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 25, 2021 at 09:58:25AM -0400, Jeff Layton wrote:
> +/*
> + * We want to encrypt filenames when creating them, but the encrypted
> + * versions of those names may have illegal characters in them. To mitigate
> + * that, we base64 encode them, but that gives us a result that can exceed
> + * NAME_MAX.
> + *
> + * Follow a similar scheme to fscrypt itself, and cap the filename to a
> + * smaller size. If the cleartext name is longer than the value below, then
> + * sha256 hash the remaining bytes.
> + *
> + * 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
> + */
> +#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)

Shouldn't this say "If the ciphertext name is longer than the value below", not
"If the cleartext name is longer than the value below"?

It would also be helpful if the above comment mentioned that when the hashing is
done, the real encrypted name is stored separately.

> +#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> +static int encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
> +{
> +	u32 len;
> +	int elen;
> +	int ret;
> +	u8 *cryptbuf;
> +
> +	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
> +
> +	/*
> +	 * convert cleartext dentry name to ciphertext
> +	 * if result is longer than CEPH_NOKEY_NAME_MAX,
> +	 * sha256 the remaining bytes
> +	 *
> +	 * See: fscrypt_setup_filename
> +	 */
> +	if (!fscrypt_fname_encrypted_size(parent, dentry->d_name.len, NAME_MAX, &len))
> +		return -ENAMETOOLONG;
> +
> +	/* If we have to hash the end, then we need a full-length buffer */
> +	if (len > CEPH_NOHASH_NAME_MAX)
> +		len = NAME_MAX;
> +
> +	cryptbuf = kmalloc(len, GFP_KERNEL);
> +	if (!cryptbuf)
> +		return -ENOMEM;
> +
> +	ret = fscrypt_fname_encrypt(parent, &dentry->d_name, cryptbuf, len);
> +	if (ret) {
> +		kfree(cryptbuf);
> +		return ret;
> +	}
> +
> +	/* hash the end if the name is long enough */
> +	if (len > CEPH_NOHASH_NAME_MAX) {
> +		u8 hash[SHA256_DIGEST_SIZE];
> +		u8 *extra = cryptbuf + CEPH_NOHASH_NAME_MAX;
> +
> +		/* hash the extra bytes and overwrite crypttext beyond that point with it */
> +		sha256(extra, len - CEPH_NOHASH_NAME_MAX, hash);
> +		memcpy(extra, hash, SHA256_DIGEST_SIZE);
> +		len = CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE;
> +	}

When the ciphertext name is longer than CEPH_NOHASH_NAME_MAX, why is the
filename being padded all the way to NAME_MAX?  That can produce a totally
different ciphertext from that produced by get_fscrypt_altname() in the next
patch.

The logical thing to do would be to do the encryption in the same way as
get_fscrypt_altname(), and then replace any bytes beyond CEPH_NOHASH_NAME_MAX
with their hash.

> +
> +	/* base64 encode the encrypted name */
> +	elen = fscrypt_base64_encode(cryptbuf, len, buf);
> +	kfree(cryptbuf);
> +	dout("base64-encoded ciphertext name = %.*s\n", len, buf);
> +	return elen;

The argument to dout() should be elen, not len.

- Eric
