Return-Path: <linux-fsdevel+bounces-54989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12C3FB06236
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 17:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FF554A6A71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 14:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D79C1F0E3E;
	Tue, 15 Jul 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnxD27ed"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA601922C0
	for <linux-fsdevel@vger.kernel.org>; Tue, 15 Jul 2025 14:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752591159; cv=none; b=fzFTvY98TnD9pcK4xk4bwa7/WVuzQ2H3FyXXjlM9qN+MQ+VT58pwkhO1A2V42PVm2EbMQ/JG3sJ8AgBAJTHUIBgjWdwzv5wxZIivX12Z3n/RYjVuy2mAqNY3woAEh78vC/SA5Qj0iTh+yllHryMcXwkWQYy+NFW0NwoPzeZHSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752591159; c=relaxed/simple;
	bh=GmrhspyFpQFlCEgeJeKRAo3C/8u9rktsye6evQF01IA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bDx/CSoqRRUYcdWV+jduZSJ2X+bz75lva/GJsOY0hIxASa25AdVlMl+Gx9d1/OdmfoBGW7lZiHtLuKlktS3TaX82lK942IKJXskT4dJdZ+PpZQb8NzIaeGqthzOcrs2gCvmzs2N299a5a+gPrIx9vNZe+6C8TZO7/P0fHgRhmC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnxD27ed; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D79C4CEE3;
	Tue, 15 Jul 2025 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752591159;
	bh=GmrhspyFpQFlCEgeJeKRAo3C/8u9rktsye6evQF01IA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=fnxD27ed+cM5q3Hilc88s1svuJMLvvseSEIk9IXuw1//DWt44GnKLuRNyJIfqWwp2
	 LV7zjfMHK3hXLSt0lS7d1/wDlATqx7KOV34p0b8yoh9O+scFy4vgmAqPgsWwSJTzIC
	 ubwVnNNlwgocEZiGuw65V30Grg3jZsqsr7LssZE/lQ4cBSE3j2g+QURZ/twbodFjg6
	 JjU5sY/0CaKRyhWzC8tImJN57/9fg02DsF/DBYUDPmh8xizdHywXbiCYgr3RTUH77P
	 u7moyj6dtBqT9dNZBHQxqZ/XcOjrRYKoVRneInmTIZh5fSDPMEu1oo9WfHb6PmGZpT
	 30vXK7IokJgTA==
Message-ID: <752741eb678c201b534074a0997a783787eca68d.camel@kernel.org>
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
From: Jeff Layton <jlayton@kernel.org>
To: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.com>, 
 Christoph Hellwig	 <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Josef Bacik
 <josef@toxicpanda.com>
Cc: linux-fsdevel@vger.kernel.org
Date: Tue, 15 Jul 2025 10:52:37 -0400
In-Reply-To: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
Autocrypt: addr=jlayton@kernel.org; prefer-encrypt=mutual;
 keydata=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
 QZIQXVeAA+smfTT0tDrisj1U5x6ZB9b3nBg65kc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2025-07-15 at 16:35 +0200, Christian Brauner wrote:
> struct inode is bloated as everyone is aware and we should try and
> shrink it as that's potentially a lot of memory savings. I've already
> freed up around 8 bytes but we can probably do better.
>=20
> There's a bunch of stuff that got shoved into struct inode that I don't
> think deserves a spot in there. There are two members I'm currently
> particularly interested in:
>=20
> (1) #ifdef CONFIG_FS_ENCRYPTION
>             struct fscrypt_inode_info *i_crypt_info;
>     #endif
>=20
>     ceph, ext4, f2fs, ubifs
>=20
> (2) #ifdef CONFIG_FS_VERITY
>             struct fsverity_info *i_verity_info;
>     #endif
>=20
>     btrfs, ext4, f2fs
>=20
> So we have 4 users for fscrypt and 3 users for fsverity with both
> features having been around for a decent amount of time.
>=20
> For all other filesystems the 16 bytes are just wasted bloating inodes
> for every pseudo filesystem and most other regular filesystems.
>=20
> We should be able to move both of these out of struct inode by adding
> inode operations and making it the filesystem's responsibility to
> accommodate the information in their respective inodes.
>=20
> Unless there are severe performance penalties for the extra pointer
> dereferences getting our hands on 16 bytes is a good reason to at least
> consider doing this.
>=20
> I've drafted one way of doing this using ext4 as my victim^wexample. I'd
> like to hear some early feedback whether this is something we would want
> to pursue.
>=20
> Build failures very much expected!
>=20
> Not-Signed-off-by: Christian Brauner <brauner@kernel.org>
> ---
>  fs/crypto/bio.c             |  2 +-
>  fs/crypto/crypto.c          |  8 ++++----
>  fs/crypto/fname.c           |  8 ++++----
>  fs/crypto/fscrypt_private.h |  3 +--
>  fs/crypto/hooks.c           |  2 +-
>  fs/crypto/inline_crypt.c    | 10 +++++-----
>  fs/crypto/keysetup.c        | 21 ++++----------------
>  fs/crypto/policy.c          |  8 ++++----
>  fs/ext4/ext4.h              |  9 +++++++++
>  fs/ext4/file.c              |  4 ++++
>  fs/ext4/namei.c             | 22 +++++++++++++++++++++
>  fs/ext4/super.c             |  6 +++++-
>  fs/ext4/symlink.c           | 12 ++++++++++++
>  include/linux/fs.h          |  9 +++++----
>  include/linux/fscrypt.h     | 47 ++++++++++++++++++++++++++++++---------=
------
>  15 files changed, 112 insertions(+), 59 deletions(-)
>=20
> diff --git a/fs/crypto/bio.c b/fs/crypto/bio.c
> index 0ad8c30b8fa5..f541e6b3a9cc 100644
> --- a/fs/crypto/bio.c
> +++ b/fs/crypto/bio.c
> @@ -111,7 +111,7 @@ static int fscrypt_zeroout_range_inline_crypt(const s=
truct inode *inode,
>  int fscrypt_zeroout_range(const struct inode *inode, pgoff_t lblk,
>  			  sector_t pblk, unsigned int len)
>  {
> -	const struct fscrypt_inode_info *ci =3D inode->i_crypt_info;
> +	const struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode)=
;
>  	const unsigned int du_bits =3D ci->ci_data_unit_bits;
>  	const unsigned int du_size =3D 1U << du_bits;
>  	const unsigned int du_per_page_bits =3D PAGE_SHIFT - du_bits;
> diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
> index b74b5937e695..c480f6867101 100644
> --- a/fs/crypto/crypto.c
> +++ b/fs/crypto/crypto.c
> @@ -181,7 +181,7 @@ struct page *fscrypt_encrypt_pagecache_blocks(struct =
folio *folio,
>  		size_t len, size_t offs, gfp_t gfp_flags)
>  {
>  	const struct inode *inode =3D folio->mapping->host;
> -	const struct fscrypt_inode_info *ci =3D inode->i_crypt_info;
> +	const struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode)=
;
>  	const unsigned int du_bits =3D ci->ci_data_unit_bits;
>  	const unsigned int du_size =3D 1U << du_bits;
>  	struct page *ciphertext_page;
> @@ -241,7 +241,7 @@ int fscrypt_encrypt_block_inplace(const struct inode =
*inode, struct page *page,
>  {
>  	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
>  		return -EOPNOTSUPP;
> -	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_ENCRYPT,
> +	return fscrypt_crypt_data_unit(inode->i_op->get_fscrypt(inode), FS_ENCR=
YPT,
>  				       lblk_num, page, page, len, offs,
>  				       gfp_flags);
>  }
> @@ -265,7 +265,7 @@ int fscrypt_decrypt_pagecache_blocks(struct folio *fo=
lio, size_t len,
>  				     size_t offs)
>  {
>  	const struct inode *inode =3D folio->mapping->host;
> -	const struct fscrypt_inode_info *ci =3D inode->i_crypt_info;
> +	const struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode)=
;
>  	const unsigned int du_bits =3D ci->ci_data_unit_bits;
>  	const unsigned int du_size =3D 1U << du_bits;
>  	u64 index =3D ((u64)folio->index << (PAGE_SHIFT - du_bits)) +
> @@ -316,7 +316,7 @@ int fscrypt_decrypt_block_inplace(const struct inode =
*inode, struct page *page,
>  {
>  	if (WARN_ON_ONCE(inode->i_sb->s_cop->supports_subblock_data_units))
>  		return -EOPNOTSUPP;
> -	return fscrypt_crypt_data_unit(inode->i_crypt_info, FS_DECRYPT,
> +	return fscrypt_crypt_data_unit(inode->i_op->get_fscrypt(inode), FS_DECR=
YPT,
>  				       lblk_num, page, page, len, offs,
>  				       GFP_NOFS);
>  }
> diff --git a/fs/crypto/fname.c b/fs/crypto/fname.c
> index 010f9c0a4c2f..a0317df113a9 100644
> --- a/fs/crypto/fname.c
> +++ b/fs/crypto/fname.c
> @@ -94,7 +94,7 @@ int fscrypt_fname_encrypt(const struct inode *inode, co=
nst struct qstr *iname,
>  {
>  	struct skcipher_request *req =3D NULL;
>  	DECLARE_CRYPTO_WAIT(wait);
> -	const struct fscrypt_inode_info *ci =3D inode->i_crypt_info;
> +	const struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode)=
;
>  	struct crypto_skcipher *tfm =3D ci->ci_enc_key.tfm;
>  	union fscrypt_iv iv;
>  	struct scatterlist sg;
> @@ -151,7 +151,7 @@ static int fname_decrypt(const struct inode *inode,
>  	struct skcipher_request *req =3D NULL;
>  	DECLARE_CRYPTO_WAIT(wait);
>  	struct scatterlist src_sg, dst_sg;
> -	const struct fscrypt_inode_info *ci =3D inode->i_crypt_info;
> +	const struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode)=
;
>  	struct crypto_skcipher *tfm =3D ci->ci_enc_key.tfm;
>  	union fscrypt_iv iv;
>  	int res;
> @@ -293,7 +293,7 @@ bool __fscrypt_fname_encrypted_size(const union fscry=
pt_policy *policy,
>  bool fscrypt_fname_encrypted_size(const struct inode *inode, u32 orig_le=
n,
>  				  u32 max_len, u32 *encrypted_len_ret)
>  {
> -	return __fscrypt_fname_encrypted_size(&inode->i_crypt_info->ci_policy,
> +	return __fscrypt_fname_encrypted_size(&inode->i_op->get_fscrypt(inode)-=
>ci_policy,
>  					      orig_len, max_len,
>  					      encrypted_len_ret);
>  }
> @@ -562,7 +562,7 @@ EXPORT_SYMBOL_GPL(fscrypt_match_name);
>   */
>  u64 fscrypt_fname_siphash(const struct inode *dir, const struct qstr *na=
me)
>  {
> -	const struct fscrypt_inode_info *ci =3D dir->i_crypt_info;
> +	const struct fscrypt_inode_info *ci =3D dir->i_op->get_fscrypt(dir);
> =20
>  	WARN_ON_ONCE(!ci->ci_dirhash_key_initialized);
> =20
> diff --git a/fs/crypto/fscrypt_private.h b/fs/crypto/fscrypt_private.h
> index c1d92074b65c..ddc3c86494cf 100644
> --- a/fs/crypto/fscrypt_private.h
> +++ b/fs/crypto/fscrypt_private.h
> @@ -231,8 +231,7 @@ struct fscrypt_prepared_key {
>   * fscrypt_inode_info - the "encryption key" for an inode
>   *
>   * When an encrypted file's key is made available, an instance of this s=
truct is
> - * allocated and stored in ->i_crypt_info.  Once created, it remains unt=
il the
> - * inode is evicted.
> + * allocated and stored.  Once created, it remains until the inode is ev=
icted.
>   */
>  struct fscrypt_inode_info {
> =20
> diff --git a/fs/crypto/hooks.c b/fs/crypto/hooks.c
> index d8d5049b8fe1..a45763da352e 100644
> --- a/fs/crypto/hooks.c
> +++ b/fs/crypto/hooks.c
> @@ -197,7 +197,7 @@ int fscrypt_prepare_setflags(struct inode *inode,
>  		err =3D fscrypt_require_key(inode);
>  		if (err)
>  			return err;
> -		ci =3D inode->i_crypt_info;
> +		ci =3D inode->i_op->get_fscrypt(inode);
>  		if (ci->ci_policy.version !=3D FSCRYPT_POLICY_V2)
>  			return -EINVAL;
>  		mk =3D ci->ci_master_key;
> diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
> index 1d008c440cb6..f5a6560a9c2e 100644
> --- a/fs/crypto/inline_crypt.c
> +++ b/fs/crypto/inline_crypt.c
> @@ -262,7 +262,7 @@ int fscrypt_derive_sw_secret(struct super_block *sb,
> =20
>  bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
>  {
> -	return inode->i_crypt_info->ci_inlinecrypt;
> +	return inode->i_op->get_fscrypt(inode)->ci_inlinecrypt;
>  }
>  EXPORT_SYMBOL_GPL(__fscrypt_inode_uses_inline_crypto);
> =20
> @@ -306,7 +306,7 @@ void fscrypt_set_bio_crypt_ctx(struct bio *bio, const=
 struct inode *inode,
> =20
>  	if (!fscrypt_inode_uses_inline_crypto(inode))
>  		return;
> -	ci =3D inode->i_crypt_info;
> +	ci =3D inode->i_op->get_fscrypt(inode);
> =20
>  	fscrypt_generate_dun(ci, first_lblk, dun);
>  	bio_crypt_set_ctx(bio, ci->ci_enc_key.blk_key, dun, gfp_mask);
> @@ -396,10 +396,10 @@ bool fscrypt_mergeable_bio(struct bio *bio, const s=
truct inode *inode,
>  	 * uses the same pointer.  I.e., there's currently no need to support
>  	 * merging requests where the keys are the same but the pointers differ=
.
>  	 */
> -	if (bc->bc_key !=3D inode->i_crypt_info->ci_enc_key.blk_key)
> +	if (bc->bc_key !=3D inode->i_op->get_fscrypt(inode)->ci_enc_key.blk_key=
)
>  		return false;
> =20
> -	fscrypt_generate_dun(inode->i_crypt_info, next_lblk, next_dun);
> +	fscrypt_generate_dun(inode->i_op->get_fscrypt(inode), next_lblk, next_d=
un);
>  	return bio_crypt_dun_is_contiguous(bc, bio->bi_iter.bi_size, next_dun);
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio);
> @@ -501,7 +501,7 @@ u64 fscrypt_limit_io_blocks(const struct inode *inode=
, u64 lblk, u64 nr_blocks)
>  	if (nr_blocks <=3D 1)
>  		return nr_blocks;
> =20
> -	ci =3D inode->i_crypt_info;
> +	ci =3D inode->i_op->get_fscrypt(inode);
>  	if (!(fscrypt_policy_flags(&ci->ci_policy) &
>  	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
>  		return nr_blocks;
> diff --git a/fs/crypto/keysetup.c b/fs/crypto/keysetup.c
> index 0d71843af946..90e1ea83c573 100644
> --- a/fs/crypto/keysetup.c
> +++ b/fs/crypto/keysetup.c
> @@ -568,7 +568,7 @@ static int setup_file_encryption_key(struct fscrypt_i=
node_info *ci,
>  	return err;
>  }
> =20
> -static void put_crypt_info(struct fscrypt_inode_info *ci)
> +void put_crypt_info(struct fscrypt_inode_info *ci)
>  {
>  	struct fscrypt_master_key *mk;
> =20
> @@ -597,6 +597,7 @@ static void put_crypt_info(struct fscrypt_inode_info =
*ci)
>  	memzero_explicit(ci, sizeof(*ci));
>  	kmem_cache_free(fscrypt_inode_info_cachep, ci);
>  }
> +EXPORT_SYMBOL(put_crypt_info);
> =20
>  static int
>  fscrypt_setup_encryption_info(struct inode *inode,
> @@ -644,7 +645,7 @@ fscrypt_setup_encryption_info(struct inode *inode,
>  	 * fscrypt_get_inode_info().  I.e., here we publish ->i_crypt_info with
>  	 * a RELEASE barrier so that other tasks can ACQUIRE it.
>  	 */
> -	if (cmpxchg_release(&inode->i_crypt_info, NULL, crypt_info) =3D=3D NULL=
) {
> +	if (!inode->i_op->set_fscrypt(crypt_info, inode)) {
>  		/*
>  		 * We won the race and set ->i_crypt_info to our crypt_info.
>  		 * Now link it into the master key's inode list.
> @@ -788,20 +789,6 @@ int fscrypt_prepare_new_inode(struct inode *dir, str=
uct inode *inode,
>  }
>  EXPORT_SYMBOL_GPL(fscrypt_prepare_new_inode);
> =20
> -/**
> - * fscrypt_put_encryption_info() - free most of an inode's fscrypt data
> - * @inode: an inode being evicted
> - *
> - * Free the inode's fscrypt_inode_info.  Filesystems must call this when=
 the
> - * inode is being evicted.  An RCU grace period need not have elapsed ye=
t.
> - */
> -void fscrypt_put_encryption_info(struct inode *inode)
> -{
> -	put_crypt_info(inode->i_crypt_info);
> -	inode->i_crypt_info =3D NULL;
> -}
> -EXPORT_SYMBOL(fscrypt_put_encryption_info);
> -
>  /**
>   * fscrypt_free_inode() - free an inode's fscrypt data requiring RCU del=
ay
>   * @inode: an inode being freed
> @@ -830,7 +817,7 @@ EXPORT_SYMBOL(fscrypt_free_inode);
>   */
>  int fscrypt_drop_inode(struct inode *inode)
>  {
> -	const struct fscrypt_inode_info *ci =3D fscrypt_get_inode_info(inode);
> +	const struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode)=
;
> =20
>  	/*
>  	 * If ci is NULL, then the inode doesn't have an encryption key set up
> diff --git a/fs/crypto/policy.c b/fs/crypto/policy.c
> index 701259991277..694d1ed26eeb 100644
> --- a/fs/crypto/policy.c
> +++ b/fs/crypto/policy.c
> @@ -436,7 +436,7 @@ static int fscrypt_get_policy(struct inode *inode, un=
ion fscrypt_policy *policy)
>  	union fscrypt_context ctx;
>  	int ret;
> =20
> -	ci =3D fscrypt_get_inode_info(inode);
> +	ci =3D inode->i_op->get_fscrypt(inode);
>  	if (ci) {
>  		/* key available, use the cached policy */
>  		*policy =3D ci->ci_policy;
> @@ -725,7 +725,7 @@ const union fscrypt_policy *fscrypt_policy_to_inherit=
(struct inode *dir)
>  		err =3D fscrypt_require_key(dir);
>  		if (err)
>  			return ERR_PTR(err);
> -		return &dir->i_crypt_info->ci_policy;
> +		return &dir->i_op->get_fscrypt(dir)->ci_policy;
>  	}
> =20
>  	return fscrypt_get_dummy_policy(dir->i_sb);
> @@ -744,7 +744,7 @@ const union fscrypt_policy *fscrypt_policy_to_inherit=
(struct inode *dir)
>   */
>  int fscrypt_context_for_new_inode(void *ctx, struct inode *inode)
>  {
> -	struct fscrypt_inode_info *ci =3D inode->i_crypt_info;
> +	struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode);
> =20
>  	BUILD_BUG_ON(sizeof(union fscrypt_context) !=3D
>  			FSCRYPT_SET_CONTEXT_MAX_SIZE);
> @@ -769,7 +769,7 @@ EXPORT_SYMBOL_GPL(fscrypt_context_for_new_inode);
>   */
>  int fscrypt_set_context(struct inode *inode, void *fs_data)
>  {
> -	struct fscrypt_inode_info *ci =3D inode->i_crypt_info;
> +	struct fscrypt_inode_info *ci =3D inode->i_op->get_fscrypt(inode);
>  	union fscrypt_context ctx;
>  	int ctxsize;
> =20
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 18373de980f2..34685eec6245 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1197,6 +1197,10 @@ struct ext4_inode_info {
>  	__u32 i_csum_seed;
> =20
>  	kprojid_t i_projid;
> +
> +#ifdef CONFIG_FS_ENCRYPTION
> +	struct fscrypt_inode_info	*i_fscrypt_info;
> +#endif
>  };
> =20
>  /*
> @@ -3904,6 +3908,11 @@ static inline bool ext4_inode_can_atomic_write(str=
uct inode *inode)
>  extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
>  				  loff_t pos, unsigned len,
>  				  get_block_t *get_block);
> +#ifdef CONFIG_FS_ENCRYPTION
> +struct fscrypt_inode_info *ext4_get_fscrypt(const struct inode *inode);
> +int ext4_set_fscrypt(struct fscrypt_inode_info *fscrypt_info,struct inod=
e *inode);
> +#endif
> +
>  #endif	/* __KERNEL__ */
> =20
>  #define EFSBADCRC	EBADMSG		/* Bad CRC detected */
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 21df81347147..676d33a7d842 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -989,5 +989,9 @@ const struct inode_operations ext4_file_inode_operati=
ons =3D {
>  	.fiemap		=3D ext4_fiemap,
>  	.fileattr_get	=3D ext4_fileattr_get,
>  	.fileattr_set	=3D ext4_fileattr_set,
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.get_fscrypt	=3D ext4_get_fscrypt,
> +	.set_fscrypt	=3D ext4_set_fscrypt,
> +#endif
>  };
> =20
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index a178ac229489..a27c5925c836 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -4203,6 +4203,20 @@ static int ext4_rename2(struct mnt_idmap *idmap,
>  	return ext4_rename(idmap, old_dir, old_dentry, new_dir, new_dentry, fla=
gs);
>  }
> =20
> +#ifdef CONFIG_FS_ENCRYPTION
> +struct fscrypt_inode_info *ext4_get_fscrypt(const struct inode *inode)
> +{
> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
> +	return fscrypt_inode_info_get(&ei->i_fscrypt_info);
> +}
> +
> +int ext4_set_fscrypt(struct fscrypt_inode_info *fscrypt_info, struct ino=
de *inode)
> +{
> +	struct ext4_inode_info *ei =3D EXT4_I(inode);
> +	return fscrypt_inode_info_set(fscrypt_info, &ei->i_fscrypt_info);
> +}
> +#endif
> +
>  /*
>   * directories can handle most operations...
>   */
> @@ -4225,6 +4239,10 @@ const struct inode_operations ext4_dir_inode_opera=
tions =3D {
>  	.fiemap         =3D ext4_fiemap,
>  	.fileattr_get	=3D ext4_fileattr_get,
>  	.fileattr_set	=3D ext4_fileattr_set,
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.get_fscrypt	=3D ext4_get_fscrypt,
> +	.set_fscrypt	=3D ext4_set_fscrypt,
> +#endif
>  };
> =20
>  const struct inode_operations ext4_special_inode_operations =3D {
> @@ -4233,4 +4251,8 @@ const struct inode_operations ext4_special_inode_op=
erations =3D {
>  	.listxattr	=3D ext4_listxattr,
>  	.get_inode_acl	=3D ext4_get_acl,
>  	.set_acl	=3D ext4_set_acl,
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.get_fscrypt	=3D ext4_get_fscrypt,
> +	.set_fscrypt	=3D ext4_set_fscrypt,
> +#endif
>  };
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index c7d39da7e733..972b057b0d00 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1412,6 +1412,9 @@ static struct inode *ext4_alloc_inode(struct super_=
block *sb)
>  	INIT_WORK(&ei->i_rsv_conversion_work, ext4_end_io_rsv_work);
>  	ext4_fc_init_inode(&ei->vfs_inode);
>  	spin_lock_init(&ei->i_fc_lock);
> +#ifdef CONFIG_FS_ENCRYPTION
> +	ei->i_fscrypt_info =3D NULL;
> +#endif
>  	return &ei->vfs_inode;
>  }
> =20
> @@ -1509,7 +1512,8 @@ void ext4_clear_inode(struct inode *inode)
>  		jbd2_free_inode(EXT4_I(inode)->jinode);
>  		EXT4_I(inode)->jinode =3D NULL;
>  	}
> -	fscrypt_put_encryption_info(inode);
> +	put_crypt_info(EXT4_I(inode)->i_fscrypt_info);
> +	EXT4_I(inode)->i_fscrypt_info =3D NULL;
>  	fsverity_cleanup_inode(inode);
>  }
> =20
> diff --git a/fs/ext4/symlink.c b/fs/ext4/symlink.c
> index 645240cc0229..ee3f71e406ce 100644
> --- a/fs/ext4/symlink.c
> +++ b/fs/ext4/symlink.c
> @@ -119,6 +119,10 @@ const struct inode_operations ext4_encrypted_symlink=
_inode_operations =3D {
>  	.setattr	=3D ext4_setattr,
>  	.getattr	=3D ext4_encrypted_symlink_getattr,
>  	.listxattr	=3D ext4_listxattr,
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.get_fscrypt	=3D ext4_get_fscrypt,
> +	.set_fscrypt	=3D ext4_set_fscrypt,
> +#endif
>  };
> =20
>  const struct inode_operations ext4_symlink_inode_operations =3D {
> @@ -126,6 +130,10 @@ const struct inode_operations ext4_symlink_inode_ope=
rations =3D {
>  	.setattr	=3D ext4_setattr,
>  	.getattr	=3D ext4_getattr,
>  	.listxattr	=3D ext4_listxattr,
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.get_fscrypt	=3D ext4_get_fscrypt,
> +	.set_fscrypt	=3D ext4_set_fscrypt,
> +#endif
>  };
> =20
>  const struct inode_operations ext4_fast_symlink_inode_operations =3D {
> @@ -133,4 +141,8 @@ const struct inode_operations ext4_fast_symlink_inode=
_operations =3D {
>  	.setattr	=3D ext4_setattr,
>  	.getattr	=3D ext4_getattr,
>  	.listxattr	=3D ext4_listxattr,
> +#ifdef CONFIG_FS_ENCRYPTION
> +	.get_fscrypt	=3D ext4_get_fscrypt,
> +	.set_fscrypt	=3D ext4_set_fscrypt,
> +#endif
>  };
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 96c7925a6551..600b878f41ab 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -778,10 +778,6 @@ struct inode {
>  	struct fsnotify_mark_connector __rcu	*i_fsnotify_marks;
>  #endif
> =20
> -#ifdef CONFIG_FS_ENCRYPTION
> -	struct fscrypt_inode_info	*i_crypt_info;
> -#endif
> -
>  #ifdef CONFIG_FS_VERITY
>  	struct fsverity_info	*i_verity_info;
>  #endif
> @@ -2257,6 +2253,11 @@ struct inode_operations {
>  			    struct dentry *dentry, struct fileattr *fa);
>  	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
>  	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
> +#ifdef CONFIG_FS_ENCRYPTION
> +	struct fscrypt_inode_info *(*get_fscrypt)(const struct inode *inode);
> +	int (*set_fscrypt)(struct fscrypt_inode_info *fscrypt_info,
> +			   struct inode *inode);
> +#endif
>  } ____cacheline_aligned;
> =20
>  /* Did the driver provide valid mmap hook configuration? */
> diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
> index 56fad33043d5..7ac612fec6bb 100644
> --- a/include/linux/fscrypt.h
> +++ b/include/linux/fscrypt.h
> @@ -195,18 +195,6 @@ struct fscrypt_operations {
>  int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
>  			 struct dentry *dentry, unsigned int flags);
> =20
> -static inline struct fscrypt_inode_info *
> -fscrypt_get_inode_info(const struct inode *inode)
> -{
> -	/*
> -	 * Pairs with the cmpxchg_release() in fscrypt_setup_encryption_info().
> -	 * I.e., another task may publish ->i_crypt_info concurrently, executin=
g
> -	 * a RELEASE barrier.  We need to use smp_load_acquire() here to safely
> -	 * ACQUIRE the memory the other task published.
> -	 */
> -	return smp_load_acquire(&inode->i_crypt_info);
> -}
> -
>  /**
>   * fscrypt_needs_contents_encryption() - check whether an inode needs
>   *					 contents encryption
> @@ -385,7 +373,7 @@ int fscrypt_ioctl_get_key_status(struct file *filp, v=
oid __user *arg);
>  /* keysetup.c */
>  int fscrypt_prepare_new_inode(struct inode *dir, struct inode *inode,
>  			      bool *encrypt_ret);
> -void fscrypt_put_encryption_info(struct inode *inode);
> +void put_crypt_info(struct fscrypt_inode_info *ci);
>  void fscrypt_free_inode(struct inode *inode);
>  int fscrypt_drop_inode(struct inode *inode);
> =20
> @@ -446,10 +434,37 @@ static inline void fscrypt_set_ops(struct super_blo=
ck *sb,
>  {
>  	sb->s_cop =3D s_cop;
>  }
> +
> +static inline int fscrypt_inode_info_set(struct fscrypt_inode_info *cryp=
t_info,
> +					 struct fscrypt_inode_info **p)
> +{
> +	if (cmpxchg_release(p, NULL, crypt_info) !=3D NULL)
> +		return -EEXIST;
> +	return 0;
> +}
> +
> +static inline struct fscrypt_inode_info *
> +fscrypt_inode_info_get(struct fscrypt_inode_info **crypt_info)
> +{
> +	/*
> +	 * Pairs with the cmpxchg_release() in fscrypt_inode_info_set(). I.e.,
> +	 * another task may publish crypt_info concurrently, executing a
> +	 * RELEASE barrier.  We need to use smp_load_acquire() here to safely
> +	 * ACQUIRE the memory the other task published (could be a READ_ONCE()
> +	 * really).
> +	 */
> +	return smp_load_acquire(crypt_info);
> +}
>  #else  /* !CONFIG_FS_ENCRYPTION */
> =20
> +static inline int fscrypt_inode_info_set(struct fscrypt_inode_info *cryp=
t_info,
> +					 struct fscrypt_inode_info **p)
> +{
> +	return 0;
> +}
> +
>  static inline struct fscrypt_inode_info *
> -fscrypt_get_inode_info(const struct inode *inode)
> +fscrypt_inode_info_get(const struct fscrypt_inode_info **crypt_info)
>  {
>  	return NULL;
>  }
> @@ -639,7 +654,7 @@ static inline int fscrypt_prepare_new_inode(struct in=
ode *dir,
>  	return 0;
>  }
> =20
> -static inline void fscrypt_put_encryption_info(struct inode *inode)
> +static inline void put_crypt_info(struct fscrypt_inode_info *ci)
>  {
>  	return;
>  }
> @@ -930,7 +945,7 @@ static inline bool fscrypt_inode_uses_fs_layer_crypto=
(const struct inode *inode)
>   */
>  static inline bool fscrypt_has_encryption_key(const struct inode *inode)
>  {
> -	return fscrypt_get_inode_info(inode) !=3D NULL;
> +	return inode->i_op->get_fscrypt(inode) !=3D NULL;
>  }
> =20
>  /**
>=20
> ---
> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
> change-id: 20250715-work-inode-fscrypt-2b63b276e793


I like the concept. Debloating struct inode is a great goal, IMO.
Fields that are not generally useful should be in the fs-specific
inodes.

I do wish it weren't quite so cumbersome with having to define
_get/_set operations, but I think it's a reasonable tradeoff to get
these fields out of struct inode.

Cheers!
--=20
Jeff Layton <jlayton@kernel.org>

