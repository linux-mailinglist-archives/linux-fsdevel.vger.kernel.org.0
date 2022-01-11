Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F42C48B712
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jan 2022 20:17:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350773AbiAKTRv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jan 2022 14:17:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350662AbiAKTRK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jan 2022 14:17:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEC4C06175B;
        Tue, 11 Jan 2022 11:16:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23202B81D2A;
        Tue, 11 Jan 2022 19:16:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD74C36AE9;
        Tue, 11 Jan 2022 19:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641928595;
        bh=fS2OSYWQAYU6dgNohiaAhLeUPSUAJMzPoZu/hFO+AI4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kXty3floN225RpnXosZPfh2gge2xNcE0+spsNqG9YHCd+HkkelplEdTsxi2WFzsls
         ypiJyvF/krLVwffyivFe0nzyCuAuV9IS0dtK4WFH3m8fd97mj92G8b4ZO0HRUlOrp4
         nWeuq0kR1pC7ePIPvo2y4uKxhwqINMqS2usWlKe0d3XBXhaBSolb8x0WS3pLuNr48G
         4IsOhclVBkV1WQG1952xYL1L+Y+FA+BzZOTTTsx4Np2DQyUlaq4Ly98l3z19xC3XWp
         FWrV9ZAh8UjTk/hG6OQcBkhmH0hQa68w9aekvwJBK9PUWN/428LU2Gu5WqBGiBrAvD
         cfsMGp7JkDNVQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, idryomov@gmail.com
Subject: [RFC PATCH v10 35/48] ceph: add infrastructure for file encryption and decryption
Date:   Tue, 11 Jan 2022 14:15:55 -0500
Message-Id: <20220111191608.88762-36-jlayton@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220111191608.88762-1-jlayton@kernel.org>
References: <20220111191608.88762-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

...and allow test_dummy_encryption to bypass content encryption
if mounted with test_dummy_encryption=clear.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ceph/crypto.c | 121 +++++++++++++++++++++++++++++++++++++++++++++++
 fs/ceph/crypto.h |  66 ++++++++++++++++++++++++++
 fs/ceph/super.c  |   8 ++++
 fs/ceph/super.h  |   1 +
 4 files changed, 196 insertions(+)

diff --git a/fs/ceph/crypto.c b/fs/ceph/crypto.c
index 35137beb027b..5a87e7385d3f 100644
--- a/fs/ceph/crypto.c
+++ b/fs/ceph/crypto.c
@@ -251,3 +251,124 @@ int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscrypt_str *tname,
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
index ab27a7ed62c3..b5d360085fe8 100644
--- a/fs/ceph/crypto.h
+++ b/fs/ceph/crypto.h
@@ -31,6 +31,10 @@ struct ceph_fscrypt_auth {
 	u8	cfa_blob[FSCRYPT_SET_CONTEXT_MAX_SIZE];
 } __packed;
 
+#define CEPH_FSCRYPT_BLOCK_SHIFT	12
+#define CEPH_FSCRYPT_BLOCK_SIZE		(_AC(1,UL) << CEPH_FSCRYPT_BLOCK_SHIFT)
+#define CEPH_FSCRYPT_BLOCK_MASK		(~(CEPH_FSCRYPT_BLOCK_SIZE-1))
+
 #define CEPH_FSCRYPT_AUTH_VERSION	1
 static inline u32 ceph_fscrypt_auth_len(struct ceph_fscrypt_auth *fa)
 {
@@ -83,6 +87,38 @@ static inline void ceph_fname_free_buffer(struct inode *parent, struct fscrypt_s
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
+static inline void fscrypt_adjust_off_and_len(struct inode *inode, u64 *off, u64 *len)
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
+int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page, u64 off,
+				int len, gfp_t gfp);
 #else /* CONFIG_FS_ENCRYPTION */
 
 static inline void ceph_fscrypt_set_ops(struct super_block *sb)
@@ -128,6 +164,36 @@ static inline int ceph_fname_to_usr(const struct ceph_fname *fname, struct fscry
 	oname->len = fname->name_len;
 	return 0;
 }
+
+static inline void fscrypt_adjust_off_and_len(struct inode *inode, u64 *off, u64 *len)
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
+static inline int ceph_fscrypt_encrypt_pages(struct inode *inode, struct page **page,
+					     u64 off, int len, gfp_t gfp)
+{
+	return 0;
+}
 #endif /* CONFIG_FS_ENCRYPTION */
 
 #endif
diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 0b32d31c6fe0..10923d75a876 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -1076,6 +1076,14 @@ static int ceph_set_test_dummy_encryption(struct super_block *sb, struct fs_cont
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
index c17622778720..4d2ccb51fe61 100644
--- a/fs/ceph/super.h
+++ b/fs/ceph/super.h
@@ -50,6 +50,7 @@
 #define CEPH_MOUNT_OPT_ASYNC_DIROPS    (1<<15) /* allow async directory ops */
 #define CEPH_MOUNT_OPT_NOPAGECACHE     (1<<16) /* bypass pagecache altogether */
 #define CEPH_MOUNT_OPT_TEST_DUMMY_ENC  (1<<17) /* enable dummy encryption (for testing) */
+#define CEPH_MOUNT_OPT_DUMMY_ENC_CLEAR (1<<18) /* don't actually encrypt content */
 
 #define CEPH_MOUNT_OPT_DEFAULT			\
 	(CEPH_MOUNT_OPT_DCACHE |		\
-- 
2.34.1

