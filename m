Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCA7516F44F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 01:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgBZAa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Feb 2020 19:30:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729387AbgBZAa5 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Feb 2020 19:30:57 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2220721D7E;
        Wed, 26 Feb 2020 00:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582677056;
        bh=bSWh+q++sx8C8D9lAd6ZLiMK7C4FjpFs2du6fFMigso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iPlCxoABGs8vm/dCfwQe7NAQXpNxvKvL/hghlJBEeMiaWyVPkj76Y8RftvlocF5QQ
         O38Q2Y7BPU3Fom0eR+SD1OFL79U9zFr79KbcFx2n0xjjE/J2+AeXoHaA3bS1cQW3Xe
         RjZqqiITwX9rWuGTXEyKS+hv4IXCbJJVbxX/ZjSs=
Date:   Tue, 25 Feb 2020 16:30:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v7 7/9] fscrypt: add inline encryption support
Message-ID: <20200226003054.GC114977@gmail.com>
References: <20200221115050.238976-1-satyat@google.com>
 <20200221115050.238976-8-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221115050.238976-8-satyat@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 21, 2020 at 03:50:48AM -0800, Satya Tangirala wrote:
> +/**
> + * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline
> + *				      encryption
> + * @inode: an inode
> + *
> + * Return: true if the inode requires file contents encryption and if the
> + *	   encryption should be done in the block layer via blk-crypto rather
> + *	   than in the filesystem layer.
> + */
> +bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
> +{
> +	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
> +		inode->i_crypt_info->ci_inlinecrypt;
> +}
> +EXPORT_SYMBOL_GPL(fscrypt_inode_uses_inline_crypto);
> +
> +/**
> + * fscrypt_inode_uses_fs_layer_crypto - test whether an inode uses fs-layer
> + *					encryption
> + * @inode: an inode
> + *
> + * Return: true if the inode requires file contents encryption and if the
> + *	   encryption should be done in the filesystem layer rather than in the
> + *	   block layer via blk-crypto.
> + */
> +bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
> +{
> +	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
> +		!inode->i_crypt_info->ci_inlinecrypt;
> +}
> +EXPORT_SYMBOL_GPL(fscrypt_inode_uses_fs_layer_crypto);

We should use the fscrypt_needs_contents_encryption() helper function which I
added in v5.6.  I.e.:

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 72692366795aa9..36510802a3665a 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -32,7 +32,7 @@ void fscrypt_select_encryption_impl(struct fscrypt_info *ci)
 	struct super_block *sb = inode->i_sb;
 
 	/* The file must need contents encryption, not filenames encryption */
-	if (!S_ISREG(inode->i_mode))
+	if (!fscrypt_needs_contents_encryption(inode))
 		return;
 
 	/* blk-crypto must implement the needed encryption algorithm */
@@ -148,7 +148,7 @@ void fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key)
  */
 bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
-	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+	return fscrypt_needs_contents_encryption(inode) &&
 		inode->i_crypt_info->ci_inlinecrypt;
 }
 EXPORT_SYMBOL_GPL(fscrypt_inode_uses_inline_crypto);
@@ -164,7 +164,7 @@ EXPORT_SYMBOL_GPL(fscrypt_inode_uses_inline_crypto);
  */
 bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
 {
-	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode) &&
+	return fscrypt_needs_contents_encryption(inode) &&
 		!inode->i_crypt_info->ci_inlinecrypt;
 }
 EXPORT_SYMBOL_GPL(fscrypt_inode_uses_fs_layer_crypto);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 2a84131ab270fd..1d9810eb88b113 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -528,7 +528,7 @@ static inline bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 
 static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
 {
-	return IS_ENCRYPTED(inode) && S_ISREG(inode->i_mode);
+	return fscrypt_needs_contents_encryption(inode);
 }
 
 static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
