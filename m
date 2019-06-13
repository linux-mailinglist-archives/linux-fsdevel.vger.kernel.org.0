Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC6D844B66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2019 20:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbfFMSz7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Jun 2019 14:55:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:41296 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727273AbfFMSz7 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Jun 2019 14:55:59 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C005220B7C;
        Thu, 13 Jun 2019 18:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560452158;
        bh=EsTk4HvtPnRJFuCBvZ/1aCPCtFTDrzSsd6Xdltd+PK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2TPo2Y3G6fiIF6nOyZlqyucyfl8i3dyj7UOfUq8OpkQO8enlLLru4RkjM9wUoYEX/
         sW2ydaV+wbVvmz764syPg6XWSgly2+hyXRUa4EHgzmEJleIDeNJfkO/anokDwP7xI3
         eEttBuIoEbCob2X/3NzFcz8P4POmvSeJqM+KoOr0=
Date:   Thu, 13 Jun 2019 11:55:56 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        Parshuram Raju Thombare <pthombar@cadence.com>,
        Ladvine D Almeida <ladvine.dalmeida@synopsys.com>,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>
Subject: Re: [RFC PATCH v2 7/8] fscrypt: wire up fscrypt to use blk-crypto
Message-ID: <20190613185556.GD686@sol.localdomain>
References: <20190605232837.31545-1-satyat@google.com>
 <20190605232837.31545-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605232837.31545-8-satyat@google.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Satya,

On Wed, Jun 05, 2019 at 04:28:36PM -0700, Satya Tangirala wrote:
> Introduce fscrypt_set_bio_crypt_ctx for filesystems to call to set up
> encryption contexts in bios, and fscrypt_evict_crypt_key to evict
> the encryption context associated with an inode.
> 
> Inline encryption is controlled by a policy flag in the fscrypt_info
> in the inode, and filesystems may check if an inode should use inline
> encryption by calling fscrypt_inode_is_hw_encrypted. Files can be marked
> as inline encrypted from userspace by appropriately modifying the flags
> (OR-ing FS_POLICY_FLAGS_HW_ENCRYPTION to it) in the fscrypt_policy
> passed to fscrypt_ioctl_set_policy.
> 
> To test inline encryption with the fscrypt dummy context, add
> ctx.flags |= FS_POLICY_FLAGS_HW_ENCRYPTION
> when setting up the dummy context in fs/crypto/keyinfo.c.
> 
> Note that blk-crypto will fall back to software en/decryption in the
> absence of inline crypto hardware, so setting up the ctx.flags in the
> dummy context without inline crypto hardware serves as a test for
> the software fallback in blk-crypto.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>

I think a fscrypt_policy flag is the right approach, but the "HW_ENCRYPTION"
name is really confusing and wrong.

What it really enables is a cryptosystem and on-disk format change where, for
the purpose of working better with inline encryption, file contents are
encrypted with the master key directly (or for v2 encryption policies it will be
a per-mode derived key as it really should be, once we can actually get the v2
encryption policy support reviewed and merged), and the inode numbers are added
to the IVs.  As we know, when ext4 support is added, this will also preclude the
filesystem from being resized.

It's not necessarily "hardware encryption".  You're implementing it using the
block layer encryption, but that can fallback to the crypto API in blk-crypto.

Moreover fscrypt already supports hardware encryption via the crypto API, just
not *inline* hardware encryption.

So calling it "hardware encryption" is wrong.

I think a much better name would be something like
FS_POLICY_FLAG_DIRECT_CONTENTS or FS_POLICY_FLAG_INLINECRYPT_OPTIMIZED.

Similarly for everywhere else in this patch that references "hardware
encryption" -- usually it should be "inline encryption".

> diff --git a/block/blk-crypto.c b/block/blk-crypto.c
> index 5adb5251ae7e..7e98acd2b963 100644
> --- a/block/blk-crypto.c
> +++ b/block/blk-crypto.c
> @@ -82,7 +82,6 @@ static int blk_crypto_keyslot_program(void *priv, const u8 *key,
>  		slotp->tfm = tfm;
>  	}
>  
> -
>  	err = crypto_skcipher_setkey(tfm, key, keysize);
>  
>  	if (err) {

This should be folded into an earlier patch.

> diff --git a/fs/crypto/Kconfig b/fs/crypto/Kconfig
> index 24ed99e2eca0..aa5b2bc6c8dd 100644
> --- a/fs/crypto/Kconfig
> +++ b/fs/crypto/Kconfig
> @@ -15,3 +15,10 @@ config FS_ENCRYPTION
>  	  efficient since it avoids caching the encrypted and
>  	  decrypted pages in the page cache.  Currently Ext4,
>  	  F2FS and UBIFS make use of this feature.
> +
> +config FS_ENCRYPTION_HW_CRYPT
> +	tristate "Enable fscrypt to use inline crypto"
> +	default n
> +	depends on FS_ENCRYPTION && BLK_INLINE_ENCRYPTION
> +	help
> +	  Enables fscrypt to use inline crypto hardware if available.

"Enable fscrypt to use inline crypto" isn't a loadable module, so it needs to be
a bool, not a tristate.

That also means use '#ifdef CONFIG_...', not '#if IS_ENABLED(CONFIG...)'.

Also no need for 'default n', since 'n' is already the default.

> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index b46021ebde85..b06b1a2be99b 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -24,17 +24,24 @@
>  #include <linux/module.h>
>  #include <linux/bio.h>
>  #include <linux/namei.h>
> +#include <linux/keyslot-manager.h>
> +#include <linux/blkdev.h>
> +#include <crypto/algapi.h>
>  #include "fscrypt_private.h"
>  
> -static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
> +static void __fscrypt_decrypt_bio(struct bio *bio, bool done, bool decrypt)
>  {
>  	struct bio_vec *bv;
>  	struct bvec_iter_all iter_all;
>  
>  	bio_for_each_segment_all(bv, bio, iter_all) {
>  		struct page *page = bv->bv_page;
> -		int ret = fscrypt_decrypt_page(page->mapping->host, page,
> -				PAGE_SIZE, 0, page->index);
> +		int ret = 0;
> +
> +		if (decrypt) {
> +			ret = fscrypt_decrypt_page(page->mapping->host, page,
> +						   PAGE_SIZE, 0, page->index);
> +		}
>  
>  		if (ret)
>  			SetPageError(page);
> @@ -47,7 +54,7 @@ static void __fscrypt_decrypt_bio(struct bio *bio, bool done)
>  
>  void fscrypt_decrypt_bio(struct bio *bio)
>  {
> -	__fscrypt_decrypt_bio(bio, false);
> +	__fscrypt_decrypt_bio(bio, false, true);
>  }
>  EXPORT_SYMBOL(fscrypt_decrypt_bio);
>  
> @@ -57,16 +64,27 @@ static void completion_pages(struct work_struct *work)
>  		container_of(work, struct fscrypt_ctx, r.work);
>  	struct bio *bio = ctx->r.bio;
>  
> -	__fscrypt_decrypt_bio(bio, true);
> +	__fscrypt_decrypt_bio(bio, true, true);
> +	fscrypt_release_ctx(ctx);
> +	bio_put(bio);
> +}
> +
> +static void decrypt_bio_hwcrypt(struct fscrypt_ctx *ctx, struct bio *bio)
> +{
> +	__fscrypt_decrypt_bio(bio, true, false);
>  	fscrypt_release_ctx(ctx);
>  	bio_put(bio);
>  }
>  
>  void fscrypt_enqueue_decrypt_bio(struct fscrypt_ctx *ctx, struct bio *bio)
>  {
> -	INIT_WORK(&ctx->r.work, completion_pages);
> -	ctx->r.bio = bio;
> -	fscrypt_enqueue_decrypt_work(&ctx->r.work);
> +	if (bio_is_encrypted(bio)) {
> +		decrypt_bio_hwcrypt(ctx, bio);
> +	} else {
> +		INIT_WORK(&ctx->r.work, completion_pages);
> +		ctx->r.bio = bio;
> +		fscrypt_enqueue_decrypt_work(&ctx->r.work);
> +	}
>  }
>  EXPORT_SYMBOL(fscrypt_enqueue_decrypt_bio);

I don't think we should be repurposing the normal fscrypt decryption path like
this.  In the case of inline decryption, the decryption *already happened*, so
there's no need for the filesystem to call into fs/crypto/ after the I/O
completes.  It's also inefficient since there is a fscrypt_ctx being allocated
for every bio, but it's useless for inline decryption since the only purpose of
fscrypt_ctx is to hold the bio decryption workqueue item.

Instead I think we should just make the filesystems' ->readpages() correctly
check whether post-read decryption is needed.  I.e. instead of checking...

	IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode)

add a helper function...

	fscrypt_needs_fs_layer_crypto()

(there may be a better name for it)

that returns true if IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
FS_POLICY_FLAG_INLINECRYPT_OPTIMIZED (or whatever we decide to call it) is unset
in the inode's fscrypt policy.

Likewise for encryption: only call fscrypt_encrypt_page() when
fscrypt_needs_fs_layer_crypto().

> +int fscrypt_set_bio_crypt_ctx(const struct inode *inode,
> +				 struct bio *bio, u64 data_unit_num)
> +{
> +	struct fscrypt_info *ci = inode->i_crypt_info;
> +
> +	/* If inode is not hw encrypted, nothing to do. */
> +	if (!fscrypt_inode_is_hw_encrypted(inode))
> +		return 0;
> +
> +	return bio_crypt_set_ctx(bio, ci->ci_master_key->mk_raw,
> +			get_blk_crypto_alg_for_fscryptalg(ci->ci_data_mode),
> +			data_unit_num,
> +			PAGE_SHIFT);
> +}
> +EXPORT_SYMBOL(fscrypt_set_bio_crypt_ctx);

To be ready for ext4 encryption with block_size < PAGE_SIZE this needs to pass
inode->i_blkbits for the dun_bits, not inode->i_blkbits.

> diff --git a/fs/crypto/keyinfo.c b/fs/crypto/keyinfo.c
> index dcd91a3fbe49..c00d986799d5 100644
> --- a/fs/crypto/keyinfo.c
> +++ b/fs/crypto/keyinfo.c
> @@ -25,6 +25,21 @@ static struct crypto_shash *essiv_hash_tfm;
>  static DEFINE_HASHTABLE(fscrypt_master_keys, 6); /* 6 bits = 64 buckets */
>  static DEFINE_SPINLOCK(fscrypt_master_keys_lock);
>  
> +#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
> +static inline bool __flags_hw_encrypted(u8 flags,
> +					const struct inode *inode)
> +{
> +	return inode && (flags & FS_POLICY_FLAGS_HW_ENCRYPTION) &&
> +	       S_ISREG(inode->i_mode);
> +}
> +#else
> +static inline bool __flags_hw_encrypted(u8 flags,
> +					const struct inode *inode)
> +{
> +	return false;
> +}
> +#endif /* CONFIG_FS_ENCRYPTION_HW_CRYPT */
> +
>  /*
>   * Key derivation function.  This generates the derived key by encrypting the
>   * master key with AES-128-ECB using the inode's nonce as the AES key.
> @@ -220,6 +235,9 @@ static int find_and_derive_key(const struct inode *inode,
>  			memcpy(derived_key, payload->raw, mode->keysize);
>  			err = 0;
>  		}
> +	} else if (__flags_hw_encrypted(ctx->flags, inode)) {
> +		memcpy(derived_key, payload->raw, mode->keysize);
> +		err = 0;
>  	} else {
>  		err = derive_key_aes(payload->raw, ctx, derived_key,
>  				     mode->keysize);
> @@ -269,16 +287,6 @@ allocate_skcipher_for_mode(struct fscrypt_mode *mode, const u8 *raw_key,
>  	return ERR_PTR(err);
>  }

As I mentioned, to follow crypto best practices this really should use a
per-mode key and not the master key directly...  We can do that pretty easily
after the v2 encryption policy support is merged.

> -static void put_master_key(struct fscrypt_master_key *mk)
> +static void put_master_key(struct fscrypt_master_key *mk,
> +			   struct inode *inode)
>  {
>  	if (!refcount_dec_and_lock(&mk->mk_refcount, &fscrypt_master_keys_lock))
>  		return;
>  	hash_del(&mk->mk_node);
>  	spin_unlock(&fscrypt_master_keys_lock);
>  
> +	fscrypt_evict_crypt_key(inode);
>  	free_master_key(mk);
>  }
>  
> @@ -360,11 +370,13 @@ fscrypt_get_master_key(const struct fscrypt_info *ci, struct fscrypt_mode *mode,
>  		return ERR_PTR(-ENOMEM);
>  	refcount_set(&mk->mk_refcount, 1);
>  	mk->mk_mode = mode;
> -	mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
> -	if (IS_ERR(mk->mk_ctfm)) {
> -		err = PTR_ERR(mk->mk_ctfm);
> -		mk->mk_ctfm = NULL;
> -		goto err_free_mk;
> +	if (!__flags_hw_encrypted(ci->ci_flags, inode)) {
> +		mk->mk_ctfm = allocate_skcipher_for_mode(mode, raw_key, inode);
> +		if (IS_ERR(mk->mk_ctfm)) {
> +			err = PTR_ERR(mk->mk_ctfm);
> +			mk->mk_ctfm = NULL;
> +			goto err_free_mk;
> +		}
>  	}
>  	memcpy(mk->mk_descriptor, ci->ci_master_key_descriptor,
>  	       FS_KEY_DESCRIPTOR_SIZE);
> @@ -456,7 +468,8 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
>  	struct crypto_skcipher *ctfm;
>  	int err;
>  
> -	if (ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) {
> +	if ((ci->ci_flags & FS_POLICY_FLAG_DIRECT_KEY) ||
> +	    __flags_hw_encrypted(ci->ci_flags, inode)) {
>  		mk = fscrypt_get_master_key(ci, mode, raw_key, inode);
>  		if (IS_ERR(mk))
>  			return PTR_ERR(mk);
> @@ -486,13 +499,13 @@ static int setup_crypto_transform(struct fscrypt_info *ci,
>  	return 0;
>  }
>  
> -static void put_crypt_info(struct fscrypt_info *ci)
> +static void put_crypt_info(struct fscrypt_info *ci, struct inode *inode)
>  {
>  	if (!ci)
>  		return;
>  
>  	if (ci->ci_master_key) {
> -		put_master_key(ci->ci_master_key);
> +		put_master_key(ci->ci_master_key, inode);
>  	} else {
>  		crypto_free_skcipher(ci->ci_ctfm);
>  		crypto_free_cipher(ci->ci_essiv_tfm);

Using the struct fscrypt_master_key in this way is wrong because they are
identified by (ci_mode, ci_descriptor, and ci_raw_key).  That means:

- The same fscrypt_master_key might be used by both inodes with and without the
  FS_POLICY_FLAGS_HW_ENCRYPTION (or whatever it's renamed to) flag set.  This
  will cause a NULL dereference on ->ci_ctfm if the fscrypt_master_key was
  initially created for a policy with FS_POLICY_FLAGS_HW_ENCRYPTION, and then
  later used by a policy without FS_POLICY_FLAGS_HW_ENCRYPTION.

- The same fscrypt_master_key can be used by inodes on multiple filesystems.
  This patch only makes the key be evicted from the keyslots on the last device
  to be used.

We can fix this by extending the identifier for fscrypt_master_key to (ci_mode,
ci_descriptor, ci_raw_key, super_block, ci_ctfm != NULL).  So you'd get separate
fscrypt_master_key's for different filesystems, and for policies with and
without FS_POLICY_FLAGS_HW_ENCRYPTION.

Of course, you are screwed if you use the same master key for inline encryption
on multiple filesystems anyway, since IVs will be reused.  What we really should
be doing is use HKDF to derive the inline encryption key from (master_key,
contents_encryption_mode, filesystem_uuid).  Which again, depends on v2 policy
support, which hopefully I can convince people should be merged so we don't have
to keep piling on these cryptographically questionable hacks :-)

> --- a/include/uapi/linux/fs.h
> +++ b/include/uapi/linux/fs.h
> @@ -224,7 +224,17 @@ struct fsxattr {
>  #define FS_POLICY_FLAGS_PAD_32		0x03
>  #define FS_POLICY_FLAGS_PAD_MASK	0x03
>  #define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
> -#define FS_POLICY_FLAGS_VALID		0x07
> +#define FS_POLICY_FLAGS_VALID_BASE	0x07
> +
> +#if IS_ENABLED(CONFIG_FS_ENCRYPTION_HW_CRYPT)
> +#define FS_POLICY_FLAGS_HW_ENCRYPTION	0x08
> +#else
> +#define FS_POLICY_FLAGS_HW_ENCRYPTION	0x00
> +#endif
> +
> +
> +#define FS_POLICY_FLAGS_VALID (FS_POLICY_FLAGS_VALID_BASE | \
> +			       FS_POLICY_FLAGS_HW_ENCRYPTION)
>  
>  /* Encryption algorithms */
>  #define FS_ENCRYPTION_MODE_INVALID		0
> -- 

Checking the kernel config is meaningless in UAPI headers.  Everyone gets the
same <linux/fs.h> header, and they can build programs with it and run them on
any arbitrary kernel.  So flag needs to be unconditional.

Thanks,

- Eric
