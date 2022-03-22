Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63E3F4E40A4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Mar 2022 15:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237057AbiCVOQf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Mar 2022 10:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237081AbiCVOPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Mar 2022 10:15:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C103F888FE;
        Tue, 22 Mar 2022 07:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AD89615D4;
        Tue, 22 Mar 2022 14:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BDA2C340EE;
        Tue, 22 Mar 2022 14:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647958436;
        bh=iRJm64mPP8F4vNzQ7yV2VFVPHSio3ItQvOe6B8EYrZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eu3cyw1BDn/fG1D3mFgUBzdbwlRxf30oNm01NgVsLIL5i8fNffDe9TvpMj1UoWhF3
         lDUu5cuqpsUPWFtHFD2BpNQIfq9LeLj7p2KybC/f4NlXqaYwed3jNoMej9orGIE4Eu
         AxNspP/aQLs9ScEQjV7w3/1AijFqixn/KpcxgNex5gWB2Nf+rRaWzOl2k5bUKItJPz
         zhG2QLAn3LauFK4QOdvN38qcLM8GRE0vWjxcYyYmPA0tfPc3u6huxA4JMwxDUmD6Jk
         OwWCFUUBR/hMBEqHalXEfDLwqUWCao0Is3oSzcNI20cjtE8zEFn74CI0SAqiHzl8Zz
         Gbei77rTVe0kg==
From:   Jeff Layton <jlayton@kernel.org>
To:     idryomov@gmail.com, xiubli@redhat.com
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-kernel@vger.kernel.org,
        lhenriques@suse.de
Subject: [RFC PATCH v11 39/51] ceph: add infrastructure for file encryption and decryption
Date:   Tue, 22 Mar 2022 10:13:04 -0400
Message-Id: <20220322141316.41325-40-jlayton@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220322141316.41325-1-jlayton@kernel.org>
References: <20220322141316.41325-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 fs/ceph/crypto.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h |  71 ++++++++++++++++++++
 fs/ceph/super.c  |   8 +++
 fs/ceph/super.h  |   1 +
 4 files changed, 247 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index c331b895c430..c2e28ae54323 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -2,6 +2,7 @@
 #include <linux/ceph/ceph_debug.h>
 #include <linux/xattr.h>
 #include <linux/fscrypt.h>
+#include <linux/ceph/striper.h>
 
 #include "super.h"
 #include "mds_client.h"
@@ -263,3 +264,169 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
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
+	if (ext_cnt == 0)
+		return 0;
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
+		fret = ceph_fscrypt_decrypt_pages(inode, &page[pgidx],
+						 off + pgsoff, ext->len);
+		if (fret < 0) {
+			if (ret == 0)
+				ret = fret;
+			break;
+		}
+		ret = pgsoff + fret;
+	}
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
index 6a2044d61420..77c7906090bc 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1092,6 +1092,14 @@ static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_cont
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
index e3d63b727e52..af59066071a6 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -48,6 +48,7 @@
 #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altogether */
 #define CEPH_MOUNT_OPT_SPARSEREAD      (1<<17) /* always do sparse reads */
 #define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<18) /* enable dummy encryption (for testing) */
+#define CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR (1<<19) /* don't actually encrypt content */
 
 #define CEPH_MOUNT_OPT_DEFAULT			\
 	(CEPH_MOUNT_OPT_DCACHE |		\
-- 
2.35.1

