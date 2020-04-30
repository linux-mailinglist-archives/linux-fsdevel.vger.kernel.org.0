Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22351BF147
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 09:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgD3HYh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 03:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:38542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgD3HYh (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:24:37 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD94A20838;
        Thu, 30 Apr 2020 07:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588231476;
        bh=B1510mH7/QkNFP5gDC7/BK6EbcgbEzV8MhuqKtudeLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0jSbTpTIKAp8HftBanaummT3PLxHjd7KNLv7h+rLMtW46sSj4rCYu67IuaiurcWub
         ndocTRCyPFh7Efb03EY75Tg1wlk8hu+ayQEYKpXdfI7SxyfnlakHfBB7OpKfdPw94L
         V7tN58WoWf9C3V0q2eTm9gEr1x9xbLPnT2nk/B90=
Date:   Thu, 30 Apr 2020 00:24:34 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Barani Muthukumaran <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Subject: Re: [PATCH v11 10/12] fscrypt: add inline encryption support
Message-ID: <20200430072434.GD16238@sol.localdomain>
References: <20200429072121.50094-1-satyat@google.com>
 <20200429072121.50094-11-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429072121.50094-11-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:21:19AM +0000, Satya Tangirala wrote:
> +/**
> + * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline
> + *				      encryption
> + * @inode: an inode

I think this should also mention that the key must be setup, like

 * @inode: an inode.  If encrypted, its key must be set up.

Likewise in fscrypt_inode_uses_fs_layer_crypto().

> + *
> + * Return: true if the inode requires file contents encryption and if the
> + *	   encryption should be done in the block layer via blk-crypto rather
> + *	   than in the filesystem layer.
> + */
> +bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
> +{
> +	return fscrypt_needs_contents_encryption(inode) &&
> +	       inode->i_crypt_info->ci_inlinecrypt;
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
> +	return fscrypt_needs_contents_encryption(inode) &&
> +	       !inode->i_crypt_info->ci_inlinecrypt;
> +}
> +EXPORT_SYMBOL_GPL(fscrypt_inode_uses_fs_layer_crypto);

It might also make sense to implement these as inline functions in fscrypt.h:

diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index 0676832817a74a..6d44d89087b4e5 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -178,37 +178,10 @@ void fscrypt_destroy_inline_crypt_key(struct fscrypt_prepared_key *prep_key)
 	}
 }
 
-/**
- * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline
- *				      encryption
- * @inode: an inode
- *
- * Return: true if the inode requires file contents encryption and if the
- *	   encryption should be done in the block layer via blk-crypto rather
- *	   than in the filesystem layer.
- */
-bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
-{
-	return fscrypt_needs_contents_encryption(inode) &&
-	       inode->i_crypt_info->ci_inlinecrypt;
-}
-EXPORT_SYMBOL_GPL(fscrypt_inode_uses_inline_crypto);
-
-/**
- * fscrypt_inode_uses_fs_layer_crypto - test whether an inode uses fs-layer
- *					encryption
- * @inode: an inode
- *
- * Return: true if the inode requires file contents encryption and if the
- *	   encryption should be done in the filesystem layer rather than in the
- *	   block layer via blk-crypto.
- */
-bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
+bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
-	return fscrypt_needs_contents_encryption(inode) &&
-	       !inode->i_crypt_info->ci_inlinecrypt;
+	return inode->i_crypt_info->ci_inlinecrypt;
 }
-EXPORT_SYMBOL_GPL(fscrypt_inode_uses_fs_layer_crypto);
 
 static void fscrypt_generate_dun(const struct fscrypt_info *ci, u64 lblk_num,
 				 u64 dun[BLK_CRYPTO_DUN_ARRAY_SIZE])
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index e02820b8e981e1..df30d3dde6ce02 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -508,9 +508,7 @@ static inline void fscrypt_set_ops(struct super_block *sb,
 
 /* inline_crypt.c */
 #ifdef CONFIG_FS_ENCRYPTION_INLINE_CRYPT
-extern bool fscrypt_inode_uses_inline_crypto(const struct inode *inode);
-
-extern bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode);
+extern bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode);
 
 extern void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 				      const struct inode *inode,
@@ -527,16 +525,11 @@ extern bool fscrypt_mergeable_bio_bh(struct bio *bio,
 				     const struct buffer_head *next_bh);
 
 #else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
-static inline bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+static inline bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
 {
 	return false;
 }
 
-static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
-{
-	return fscrypt_needs_contents_encryption(inode);
-}
-
 static inline void fscrypt_set_bio_crypt_ctx(struct bio *bio,
 					     const struct inode *inode,
 					     u64 first_lblk, gfp_t gfp_mask) { }
@@ -560,6 +553,36 @@ static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
 }
 #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
+/**
+ * fscrypt_inode_uses_inline_crypto - test whether an inode uses inline
+ *				      encryption
+ * @inode: an inode.  If encrypted, its key must be set up.
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the block layer via blk-crypto rather
+ *	   than in the filesystem layer.
+ */
+static inline bool fscrypt_inode_uses_inline_crypto(const struct inode *inode)
+{
+	return fscrypt_needs_contents_encryption(inode) &&
+	       __fscrypt_inode_uses_inline_crypto(inode);
+}
+
+/**
+ * fscrypt_inode_uses_fs_layer_crypto - test whether an inode uses fs-layer
+ *					encryption
+ * @inode: an inode.  If encrypted, its key must be set up.
+ *
+ * Return: true if the inode requires file contents encryption and if the
+ *	   encryption should be done in the filesystem layer rather than in the
+ *	   block layer via blk-crypto.
+ */
+static inline bool fscrypt_inode_uses_fs_layer_crypto(const struct inode *inode)
+{
+	return fscrypt_needs_contents_encryption(inode) &&
+	       !__fscrypt_inode_uses_inline_crypto(inode);
+}
+
 /**
  * fscrypt_require_key - require an inode's encryption key
  * @inode: the inode we need the key for

