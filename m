Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514C3223097
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 03:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgGQBpr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 21:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgGQBpq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 21:45:46 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE646C08C5CE
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id f2so5609286plt.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 18:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=B0x0K0LAx9+Y7Q8FXBFUwx+eU4+ad8NV7ubLsxeFaf4=;
        b=NgLVdFfzPI8rniPtNm8DqUu4McExuVBrHsycos4sDr8HsIC6inA/SB0isGbUmdBmO7
         G/OrVuLZvnL13Tu1mu21s4F7Ileup0x4d6uYiJ/kRc/SQmxDVcl9ygK9eVQ7wsjmIqNo
         eElNu+LzNt9T9mDuksME3/2KwYx+iFpkfHnqd+pwMaw4jxdcWmmUK78AYXj+/Kf9MXkh
         86ClwUljjM8zN95NX5YUb5jda8EvPewsTfVBDH6wUOZej4e/FczD89ejdlyqv5g+4dbU
         6Cz7coqFDmzebNg2T0T8MZ6p/kLm5A96Fi28C012iOqXi7l4A7sD3rqk2EZ5Xxa58Gh/
         WOWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=B0x0K0LAx9+Y7Q8FXBFUwx+eU4+ad8NV7ubLsxeFaf4=;
        b=Huo6C4WisALB5l3j7oXDpgCEpneeeus6/+v4cqOmFyDIYGfZ/n+CpaeCakAubX41wB
         NEMwI74a1Unvi06vGKEBRX2g2NPQaIw9fbJhkSWSs36Rwimp5xMIr1FgOnLL6i+M5Xoo
         OPbVO0pg4JFByPRRbghkaYQflbTd+5QD00tPcuVkUsiyuOrOTx88GpTyP1yVyDs/0plI
         nPwhKIJnlKGs6ceaHlPI6fVIFCmoyDlkApg0nS92eSUrdLnmlydyVECmmJluf4AiKR3s
         kR71R5xwAnTlv96KunYaIVRmSYp6iZ4TJ2aQyabd4GSPhlplSXGiwcJhZJxGGT+/S46w
         efWw==
X-Gm-Message-State: AOAM532J6LvAqqiyEV6y+2AXQe76UU/vQYSd1tufoblAmnUmRrb2neVc
        dXbLfK+ofQGTMnzzPegJd22q7fnwsB8=
X-Google-Smtp-Source: ABdhPJx6iODqkhaKqJfQZ6FjelMNp9N/V3wUMH1/G/neMrWU0AXc+o65/W6IN7lPQnmGBJARaC+27IB1sHQ=
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr6955247pju.80.1594950345389;
 Thu, 16 Jul 2020 18:45:45 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:45:34 +0000
In-Reply-To: <20200717014540.71515-1-satyat@google.com>
Message-Id: <20200717014540.71515-2-satyat@google.com>
Mime-Version: 1.0
References: <20200717014540.71515-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v3 1/7] fscrypt: Add functions for direct I/O support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Introduce fscrypt_dio_supported() to check whether a direct I/O request
is unsupported due to encryption constraints, and
fscrypt_limit_io_pages() to check how many pages may be added to a bio
being prepared for direct I/O.

The IV_INO_LBLK_32 fscrypt policy introduced the possibility that DUNs
in logically continuous file blocks might wrap from 0xffffffff to 0.
Since this was particularly difficult to handle when block_size !=
PAGE_SIZE, fscrypt only supports blk-crypto en/decryption with
the IV_INO_LBLK_32 policy when block_size == PAGE_SIZE, and ensures that
the DUN never wraps around within any submitted bio.
fscrypt_limit_io_pages() can be used to determine the number of logically
contiguous blocks/pages that may be added to the bio without causing the
DUN to wrap around within the bio. This is an alternative to calling
fscrypt_mergeable_bio() on each page in a range of logically contiguous
pages.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Co-developed-by: Satya Tangirala <satyat@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/crypto/crypto.c       |  8 ++++
 fs/crypto/inline_crypt.c | 80 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscrypt.h  | 19 ++++++++++
 3 files changed, 107 insertions(+)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index a52cf32733ab..fb34364360b3 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -69,6 +69,14 @@ void fscrypt_free_bounce_page(struct page *bounce_page)
 }
 EXPORT_SYMBOL(fscrypt_free_bounce_page);
 
+/*
+ * Generate the IV for the given logical block number within the given file.
+ * For filenames encryption, lblk_num == 0.
+ *
+ * Keep this in sync with fscrypt_limit_io_pages().  fscrypt_limit_io_pages()
+ * needs to know about any IV generation methods where the low bits of IV don't
+ * simply contain the lblk_num (e.g., IV_INO_LBLK_32).
+ */
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci)
 {
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index d7aecadf33c1..f5af6a63e04c 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -16,6 +16,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/sched/mm.h>
+#include <linux/uio.h>
 
 #include "fscrypt_private.h"
 
@@ -362,3 +363,82 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
 	return fscrypt_mergeable_bio(bio, inode, next_lblk);
 }
 EXPORT_SYMBOL_GPL(fscrypt_mergeable_bio_bh);
+
+/**
+ * fscrypt_dio_supported() - check whether a direct I/O request is unsupported
+ *			     due to encryption constraints
+ * @iocb: the file and position the I/O is targeting
+ * @iter: the I/O data segment(s)
+ *
+ * Return: true if direct I/O is supported
+ */
+bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter)
+{
+	const struct inode *inode = file_inode(iocb->ki_filp);
+	const unsigned int blocksize = i_blocksize(inode);
+
+	/* If the file is unencrypted, no veto from us. */
+	if (!fscrypt_needs_contents_encryption(inode))
+		return true;
+
+	/* We only support direct I/O with inline crypto, not fs-layer crypto */
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return false;
+
+	/*
+	 * Since the granularity of encryption is filesystem blocks, the I/O
+	 * must be block aligned -- not just disk sector aligned.
+	 */
+	if (!IS_ALIGNED(iocb->ki_pos | iov_iter_alignment(iter), blocksize))
+		return false;
+
+	return true;
+}
+EXPORT_SYMBOL_GPL(fscrypt_dio_supported);
+
+/**
+ * fscrypt_limit_io_pages() - limit I/O pages to avoid discontiguous DUNs
+ * @inode: the file on which I/O is being done
+ * @pos: the file position (in bytes) at which the I/O is being done
+ * @nr_pages: the number of pages we want to submit starting at @pos
+ *
+ * Determine the limit to the number of pages that can be submitted in the bio
+ * targeting @pos without causing a data unit number (DUN) discontinuity.
+ *
+ * For IV generation methods that can't cause DUN wraparounds
+ * within logically continuous data blocks, the maximum number of pages is
+ * simply @nr_pages. For those IV generation methods that *might* cause DUN
+ * wraparounds, the returned number of pages is the largest possible number of
+ * pages (less than @nr_pages) that can be added to the bio without causing a
+ * DUN wraparound within the bio.
+ *
+ * Return: the actual number of pages that can be submitted
+ */
+int fscrypt_limit_io_pages(const struct inode *inode, loff_t pos, int nr_pages)
+{
+	const struct fscrypt_info *ci = inode->i_crypt_info;
+	u32 dun;
+
+	if (!fscrypt_inode_uses_inline_crypto(inode))
+		return nr_pages;
+
+	if (nr_pages <= 1)
+		return nr_pages;
+
+	if (!(fscrypt_policy_flags(&ci->ci_policy) &
+	      FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32))
+		return nr_pages;
+
+	/*
+	 * fscrypt_select_encryption_impl() ensures that block_size == PAGE_SIZE
+	 * when using FSCRYPT_POLICY_FLAG_IV_INO_LBLK_32.
+	 */
+	if (WARN_ON_ONCE(i_blocksize(inode) != PAGE_SIZE))
+		return 1;
+
+	/* With IV_INO_LBLK_32, the DUN can wrap around from U32_MAX to 0. */
+
+	dun = ci->ci_hashed_ino + (pos >> inode->i_blkbits);
+
+	return min_t(u64, nr_pages, (u64)U32_MAX + 1 - dun);
+}
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index bb257411365f..c205c214b35e 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -559,6 +559,11 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh);
 
+bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter);
+
+int fscrypt_limit_io_pages(const struct inode *inode, loff_t pos,
+			   int nr_pages);
+
 #else /* CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 static inline bool __fscrypt_inode_uses_inline_crypto(const struct inode *inode)
@@ -587,6 +592,20 @@ static inline bool fscrypt_mergeable_bio_bh(struct bio *bio,
 {
 	return true;
 }
+
+static inline bool fscrypt_dio_supported(struct kiocb *iocb,
+					 struct iov_iter *iter)
+{
+	const struct inode *inode = file_inode(iocb->ki_filp);
+
+	return !fscrypt_needs_contents_encryption(inode);
+}
+
+static inline int fscrypt_limit_io_pages(const struct inode *inode, loff_t pos,
+					 int nr_pages)
+{
+	return nr_pages;
+}
 #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 /**
-- 
2.28.0.rc0.105.gf9edc3c819-goog

