Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69BE3C5C3F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 14:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233381AbhGLMjE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 08:39:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230361AbhGLMjD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 08:39:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01DD560FF3;
        Mon, 12 Jul 2021 12:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626093375;
        bh=zN9Hq9FpIAMVrdPNdDqA/6rgCOrfBlpDNhEcHAUrM7U=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SF9OPKGDsq/b/BdHy4ZrkaFL1/OvCKGN9zHT/j1MEFj12V4C7jx25QDpweILs5u9R
         XM6XbKfwlTaAySAxRG7T1HXU2HElkXYvnmmiyMCsYGOStpJBYghLam3yqls2zEOaLw
         kbK2qj0FvCuGpcUORdxzYzKBcZO3XF/6sfuLve0IviqxZbKj7MWeNCKSBQvBLh+jKS
         Ppd5wvpNoZg8knD57Fnk614ZcuYcEXiR58QlP4gZz9OELesA4Lk6XpZGYtskURsuM0
         PA77xdxt3EPWcSVO7dPL7Kj3ueF6+2B7jq5JPBeY/rNAtNDFdNf1DS8zYgDxBc+zMt
         ZzxpyGgz987ZA==
Message-ID: <7c57504514c107aa1cde04b566575a6e1461ecd5.camel@kernel.org>
Subject: Re: [RFC PATCH v7 15/24] ceph: add encrypted fname handling to
 ceph_mdsc_build_path
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     ceph-devel@vger.kernel.org, lhenriques@suse.de, xiubli@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        dhowells@redhat.com
Date:   Mon, 12 Jul 2021 08:36:13 -0400
In-Reply-To: <YOt2cVJLEXt88SVJ@quark.localdomain>
References: <20210625135834.12934-1-jlayton@kernel.org>
         <20210625135834.12934-16-jlayton@kernel.org>
         <YOt2cVJLEXt88SVJ@quark.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.2 (3.40.2-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, 2021-07-11 at 17:53 -0500, Eric Biggers wrote:
> On Fri, Jun 25, 2021 at 09:58:25AM -0400, Jeff Layton wrote:
> > +/*
> > + * We want to encrypt filenames when creating them, but the encrypted
> > + * versions of those names may have illegal characters in them. To mitigate
> > + * that, we base64 encode them, but that gives us a result that can exceed
> > + * NAME_MAX.
> > + *
> > + * Follow a similar scheme to fscrypt itself, and cap the filename to a
> > + * smaller size. If the cleartext name is longer than the value below, then
> > + * sha256 hash the remaining bytes.
> > + *
> > + * 189 bytes => 252 bytes base64-encoded, which is <= NAME_MAX (255)
> > + */
> > +#define CEPH_NOHASH_NAME_MAX (189 - SHA256_DIGEST_SIZE)
> 
> Shouldn't this say "If the ciphertext name is longer than the value below", not
> "If the cleartext name is longer than the value below"?
> 
> It would also be helpful if the above comment mentioned that when the hashing is
> done, the real encrypted name is stored separately.
> 
> > +#if IS_ENABLED(CONFIG_FS_ENCRYPTION)
> > +static int encode_encrypted_fname(const struct inode *parent, struct dentry *dentry, char *buf)
> > +{
> > +	u32 len;
> > +	int elen;
> > +	int ret;
> > +	u8 *cryptbuf;
> > +
> > +	WARN_ON_ONCE(!fscrypt_has_encryption_key(parent));
> > +
> > +	/*
> > +	 * convert cleartext dentry name to ciphertext
> > +	 * if result is longer than CEPH_NOKEY_NAME_MAX,
> > +	 * sha256 the remaining bytes
> > +	 *
> > +	 * See: fscrypt_setup_filename
> > +	 */
> > +	if (!fscrypt_fname_encrypted_size(parent, dentry->d_name.len, NAME_MAX, &len))
> > +		return -ENAMETOOLONG;
> > +
> > +	/* If we have to hash the end, then we need a full-length buffer */
> > +	if (len > CEPH_NOHASH_NAME_MAX)
> > +		len = NAME_MAX;
> > +
> > +	cryptbuf = kmalloc(len, GFP_KERNEL);
> > +	if (!cryptbuf)
> > +		return -ENOMEM;
> > +
> > +	ret = fscrypt_fname_encrypt(parent, &dentry->d_name, cryptbuf, len);
> > +	if (ret) {
> > +		kfree(cryptbuf);
> > +		return ret;
> > +	}
> > +
> > +	/* hash the end if the name is long enough */
> > +	if (len > CEPH_NOHASH_NAME_MAX) {
> > +		u8 hash[SHA256_DIGEST_SIZE];
> > +		u8 *extra = cryptbuf + CEPH_NOHASH_NAME_MAX;
> > +
> > +		/* hash the extra bytes and overwrite crypttext beyond that point with it */
> > +		sha256(extra, len - CEPH_NOHASH_NAME_MAX, hash);
> > +		memcpy(extra, hash, SHA256_DIGEST_SIZE);
> > +		len = CEPH_NOHASH_NAME_MAX + SHA256_DIGEST_SIZE;
> > +	}
> 
> When the ciphertext name is longer than CEPH_NOHASH_NAME_MAX, why is the
> filename being padded all the way to NAME_MAX?  That can produce a totally
> different ciphertext from that produced by get_fscrypt_altname() in the next
> patch.
> 

Oh, I misunderstood the meaning of the last parameter to
fscrypt_fname_encrypt. I had thought that was the length of the target
buffer, but it's not -- it's the length of the resulting filename (which
we need to precompute). I'll fix that up.

> The logical thing to do would be to do the encryption in the same way as
> get_fscrypt_altname(), and then replace any bytes beyond CEPH_NOHASH_NAME_MAX
> with their hash.
> 

That might make more sense.

> > +
> > +	/* base64 encode the encrypted name */
> > +	elen = fscrypt_base64_encode(cryptbuf, len, buf);
> > +	kfree(cryptbuf);
> > +	dout("base64-encoded ciphertext name = %.*s\n", len, buf);
> > +	return elen;
> 
> The argument to dout() should be elen, not len.
> 

Will fix, thanks.
-- 
Jeff Layton <jlayton@kernel.org>

