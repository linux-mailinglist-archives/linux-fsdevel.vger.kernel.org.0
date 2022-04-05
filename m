Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4648E4F4D22
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 03:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1581555AbiDEXjx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Apr 2022 19:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1573596AbiDETXQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Apr 2022 15:23:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFFFF4DF6F;
        Tue,  5 Apr 2022 12:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6DF64B81FA5;
        Tue,  5 Apr 2022 19:21:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C99DC385A0;
        Tue,  5 Apr 2022 19:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649186475;
        bh=6YU8kP1jnlCntdm06abZO3qzfSycP7nQ8wCDSx1OVxc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJWjxWIc7MwDcyTJU6n6fM7VbWsg1dMosSAG12Mu3MRch4LXpWwtgBSkfZF+Qt2HM
         iF6Yqp/2mDmHYbbyAWTqPz5IirvTm7BqSnDhPmIIfQTvkSknr2RTDL1i2zZFu657BC
         Vx0DjtqG5D+xF0A5FMOMnooBewjUC8yJAZuwXLWZZMUo5i9zdMWpvEUIt4sEPMKGJr
         byzjBMZfUVd/Hc0MKsovfOGtAl+c1PNXRc/yY7rSKcEw+8cRgVgw6qe/ihuKLGJunI
         YswR8yFyMjBF2cq5PxecesCqdQ1taczYugFfjaDYSTRfq0n4++hRPWp1A0k6jxS8Yy
         xSvqZpZXB3Uig==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [PATCH v13 47/59] ceph: add infrastructure for file encryption and decryption
Date:   Tue,  5 Apr 2022 15:20:18 -0400
Message-Id: <20220405192030.178326-48-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405192030.178326-1-jlayton@kernel.org>
References: <20220405192030.178326-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...and allow test_dummy_encryption to bypass content encryption
if mounted with test_dummy_encryption=clear.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 177 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h |  71 +++++++++++++++++++
 fs/ceph/super.c  |   8 +++
 fs/ceph/super.h  |   1 +
 4 files changed, 257 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 19c113afb400..e24e61c51118 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -2,6 +2,7 @@
 #include <linux/ceph/ceph_debug.h>
 #include <linux/xattr.h>
 #include <linux/fscrypt.h>
+#include <linux/ceph/striper.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -263,3 +264,179 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 	fscrypt_fname_free_buffer(&_tname);
 	return ret;
 }
+
+int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
+				  struct page *page, unsigned int len,
+				  unsigned int offs, u64 lblk_num)
+{
+	struct ceph_mount_options *opt = ceph_inode_to_client(inode)->mount_options;
+
+	if (opt->flags & CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR)
+		return 0;
+
+	dout("%s: len %u offs %u blk %llu\n", __func__, len, offs, lblk_num);
+	return fscrypt_decrypt_block_inplace(inode, page, len, offs, lblk_num);
+}
+
+int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
+				  struct page *page, unsigned int len,
+				  unsigned int offs, u64 lblk_num, gfp_t gfp_flags)
+{
+	struct ceph_mount_options *opt = ceph_inode_to_client(inode)->mount_options;
+
+	if (opt->flags & CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR)
+		return 0;
+
+	dout("%s: len %u offs %u blk %llu\n", __func__, len, offs, lblk_num);
+	return fscrypt_encrypt_block_inplace(inode, page, len, offs, lblk_num, gfp_flags);
+}
+
+/**
+ * ceph_fscrypt_decrypt_pages - decrypt an array of pages
+ * @inode: pointer to inode associated with these pages
+ * @page: pointer to page array
+ * @off: offset into the file that the read data starts
+ * @len: max length to decrypt
+ *
+ * Decrypt an array of fscrypt'ed pages and return the amount of
+ * data decrypted. Any data in the page prior to the start of the
+ * first complete block in the read is ignored. Any incomplete
+ * crypto blocks at the end of the array are ignored (and should
+ * probably be zeroed by the caller).
+ *
+ * Returns the length of the decrypted data or a negative errno.
+ */
+int ceph_fscrypt_decrypt_pages(struct inode *inode, struct page **page, u64 off, int len)
+{
+	int i, num_blocks;
+	u64 baseblk = off >> CEPH_FSCRYPT_BLOCK_SHIFT;
+	int ret = 0;
+
+	/*
+	 * We can't deal with partial blocks on an encrypted file, so mask off
+	 * the last bit.
+	 */
+	num_blocks = ceph_fscrypt_blocks(off, len & CEPH_FSCRYPT_BLOCK_MASK);
+
+	/* Decrypt each block */
+	for (i = 0; i < num_blocks; ++i) {
+		int blkoff = i << CEPH_FSCRYPT_BLOCK_SHIFT;
+		int pgidx = blkoff >> PAGE_SHIFT;
+		unsigned int pgoffs = offset_in_page(blkoff);
+		int fret;
+
+		fret = ceph_fscrypt_decrypt_block_inplace(inode, page[pgidx],
+				CEPH_FSCRYPT_BLOCK_SIZE, pgoffs,
+				baseblk + i);
+		if (fret < 0) {
+			if (ret == 0)
+				ret = fret;
+			break;
+		}
+		ret += CEPH_FSCRYPT_BLOCK_SIZE;
+	}
+	return ret;
+}
+
+/**
+ * ceph_fscrypt_decrypt_extents: decrypt received extents in given buffer
+ * @inode: inode associated with pages being decrypted
+ * @page: pointer to page array
+ * @off: offset into the file that the data in page[0] starts
+ * @map: pointer to extent array
+ * @ext_cnt: length of extent array
+ *
+ * Given an extent map and a page array, decrypt the received data in-place,
+ * skipping holes. Returns the offset into buffer of end of last decrypted
+ * block.
+ */
+int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page, u64 off,
+				 struct ceph_sparse_extent *map, u32 ext_cnt)
+{
+	int i, ret = 0;
+	struct ceph_inode_info *ci = ceph_inode(inode);
+	u64 objno, objoff;
+	u32 xlen;
+
+	/* Nothing to do for empty array */
+	if (ext_cnt == 0) {
+		dout("%s: empty array, ret 0\n", __func__);
+		return 0;
+	}
+
+	ceph_calc_file_object_mapping(&ci->i_layout, off, map[0].len,
+				      &objno, &objoff, &xlen);
+
+	for (i = 0; i < ext_cnt; ++i) {
+		struct ceph_sparse_extent *ext = &map[i];
+		int pgsoff = ext->off - objoff;
+		int pgidx = pgsoff >> PAGE_SHIFT;
+		int fret;
+
+		if ((ext->off | ext->len) & ~CEPH_FSCRYPT_BLOCK_MASK) {
+			pr_warn("%s: bad encrypted sparse extent idx %d off %llx len %llx\n",
+				__func__, i, ext->off, ext->len);
+			return -EIO;
+		}
+		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
+						 off + pgsoff, ext->len);
+		dout("%s: [%d] 0x%llx~0x%llx fret %d\n", __func__, i,
+				ext->off, ext->len, fret);
+		if (fret < 0) {
+			if (ret == 0)
+				ret = fret;
+			break;
+		}
+		ret = pgsoff + fret;
+	}
+	dout("%s: ret %d\n", __func__, ret);
+	return ret;
+}
+
+/**
+ * ceph_fscrypt_encrypt_pages - encrypt an array of pages
+ * @inode: pointer to inode associated with these pages
+ * @page: pointer to page array
+ * @off: offset into the file that the data starts
+ * @len: max length to encrypt
+ * @gfp: gfp flags to use for allocation
+ *
+ * Decrypt an array of cleartext pages and return the amount of
+ * data encrypted. Any data in the page prior to the start of the
+ * first complete block in the read is ignored. Any incomplete
+ * crypto blocks at the end of the array are ignored.
+ *
+ * Returns the length of the encrypted data or a negative errno.
+ */
+int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, u64 off,
+				int len, gfp_t gfp)
+{
+	int i, num_blocks;
+	u64 baseblk = off >> CEPH_FSCRYPT_BLOCK_SHIFT;
+	int ret = 0;
+
+	/*
+	 * We can't deal with partial blocks on an encrypted file, so mask off
+	 * the last bit.
+	 */
+	num_blocks = ceph_fscrypt_blocks(off, len & CEPH_FSCRYPT_BLOCK_MASK);
+
+	/* Encrypt each block */
+	for (i = 0; i < num_blocks; ++i) {
+		int blkoff = i << CEPH_FSCRYPT_BLOCK_SHIFT;
+		int pgidx = blkoff >> PAGE_SHIFT;
+		unsigned int pgoffs = offset_in_page(blkoff);
+		int fret;
+
+		fret = ceph_fscrypt_encrypt_block_inplace(inode, page[pgidx],
+				CEPH_FSCRYPT_BLOCK_SIZE, pgoffs,
+				baseblk + i, gfp);
+		if (fret < 0) {
+			if (ret == 0)
+				ret = fret;
+			break;
+		}
+		ret += CEPH_FSCRYPT_BLOCK_SIZE;
+	}
+	return ret;
+}
diff --git a/fs/ceph/crypto.h b/fs/ceph/crypto.h
index 56a61ba64edc..fdd73c50487f 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -91,6 +91,40 @@ static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_s
 int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
 			struct fscrypt_str *oname, bool *is_nokey);
 
+static inline unsigned int ceph_fscrypt_blocks(u64 off, u64 len)
+{
+	/* crypto blocks cannot span more than one page */
+	BUILD_BUG_ON(CEPH_FSCRYPT_BLOCK_SHIFT > PAGE_SHIFT);
+
+	return ((off+len+CEPH_FSCRYPT_BLOCK_SIZE-1) >> CEPH_FSCRYPT_BLOCK_SHIFT) -
+		(off >> CEPH_FSCRYPT_BLOCK_SHIFT);
+}
+
+/*
+ * If we have an encrypted inode then we must adjust the offset and
+ * range of the on-the-wire read to cover an entire encryption block.
+ * The copy will be done using the original offset and length, after
+ * we've decrypted the result.
+ */
+static inline void ceph_fscrypt_adjust_off_and_len(struct inode *inode, u64 *off, u64 *len)
+{
+	if (IS_ENCRYPTED(inode)) {
+		*len = ceph_fscrypt_blocks(*off, *len) * CEPH_FSCRYPT_BLOCK_SIZE;
+		*off &= CEPH_FSCRYPT_BLOCK_MASK;
+	}
+}
+
+int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
+				  struct page *page, unsigned int len,
+				  unsigned int offs, u64 lblk_num);
+int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
+				  struct page *page, unsigned int len,
+				  unsigned int offs, u64 lblk_num, gfp_t gfp_flags);
+int ceph_fscrypt_decrypt_pages(struct inode *inode, struct page **page, u64 off, int len);
+int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page, u64 off,
+				 struct ceph_sparse_extent *map, u32 ext_cnt);
+int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, u64 off,
+				int len, gfp_t gfp);
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
@@ -143,6 +177,43 @@ static inline int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscry
 	oname->len = fname->name_len;
 	return 0;
 }
+
+static inline void ceph_fscrypt_adjust_off_and_len(struct inode *inode, u64 *off, u64 *len)
+{
+}
+
+static inline int ceph_fscrypt_decrypt_block_inplace(const struct inode *inode,
+					  struct page *page, unsigned int len,
+					  unsigned int offs, u64 lblk_num)
+{
+	return 0;
+}
+
+static inline int ceph_fscrypt_encrypt_block_inplace(const struct inode *inode,
+				  struct page *page, unsigned int len,
+				  unsigned int offs, u64 lblk_num, gfp_t gfp_flags)
+{
+	return 0;
+}
+
+static inline int ceph_fscrypt_decrypt_pages(struct inode *inode, struct page **page,
+					     u64 off, int len)
+{
+	return 0;
+}
+
+static inline int ceph_fscrypt_decrypt_extents(struct inode *inode, struct page **page,
+					u64 off, struct ceph_sparse_extent *map,
+					u32 ext_cnt)
+{
+	return 0;
+}
+
+static inline int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page,
+					     u64 off, int len, gfp_t gfp)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index a1f921d5675d..70cd1dcad645 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1093,6 +1093,14 @@ static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_cont
 			return -EEXIST;
 		}
 
+		/* HACK: allow for cleartext "encryption" in files for testing */
+		if (fsc->mount_options->test_dummy_encryption &&
+		    !strcmp(fsc->mount_options->test_dummy_encryption, "clear")) {
+			fsopt->flags |= CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR;
+			kfree(fsc->mount_options->test_dummy_encryption);
+			fsc->mount_options->test_dummy_encryption = NULL;
+		}
+
 		err = fscrypt_set_test_dummy_encryption(sb,
 							fsc->mount_options->test_dummy_encryption,
 							&fsc->dummy_enc_policy);
diff --git a/fs/ceph/super.h b/fs/ceph/super.h
index 9809bc97b89e..9c205c6967b7 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -44,6 +44,7 @@
 #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altogether */
 #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse reads */
 #define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<18) /* enable dummy encryption (for testing) */
+#define CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR (1<<19) /* don't actually encrypt content */
 
 #define CEPH_MOUNT_OPT_DEFAULT			\
 	(CEPH_MOUNT_OPT_DCACHE |		\
-- 
2.35.1

