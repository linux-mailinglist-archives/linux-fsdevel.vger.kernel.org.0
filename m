Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6435721A815
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jul 2020 21:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgGITsO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jul 2020 15:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgGITr5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jul 2020 15:47:57 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7302C08E6DC
        for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jul 2020 12:47:57 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id j17so2453859pjy.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Jul 2020 12:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+/XxnKhf8VQXnWlmxkLfLTPJmNMo/X9aFiP13+Lo8YI=;
        b=h/H0yRKbuSfyI8puj/GfGNpcjE4q8yWyZ39S7u7IcbvSYgI4b91Twrik62nZGiY8/z
         vzOjVOI15upZpzR/91wpbk98WfhemXBOL8DnysODYMcDgtbDIUG7EO6XLwAxLx0SkTlF
         QuQjmm6XT0lnZviNNA1jOOUC2jD+UG5qvworuWF3RuQKUTvEWAjaiWPwi84RKPEfbi3m
         hFPycqByVMLVQymThzvU3TnnurvzfN7ul52dp57GX99wkXEEyn1d/4kXqFJDCSww1rkP
         NSAplp6KppOYzHSsEqJTRpsyYGTar0iKcIpip6VZw4atI9KNa17YKeOYmpjk2VYFGA+a
         1cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+/XxnKhf8VQXnWlmxkLfLTPJmNMo/X9aFiP13+Lo8YI=;
        b=hEyD3OxPYY/FtxThc354HETrA/WvnvNhugcw1FA92Kl6qcU/f/gZ+1opFt8Pl1sItt
         WFt3sCMx//0zLVxLMviQWoYx9RAYGbiHL2Mi/vXB3Xh9MlNybCWOo7OMVJ6imo3M1CzS
         JWTULhd9KmrM349d4wJS7RCwUja39f8g/Y641EFnGhAGq7x6HEALcLYayF0A+jF0228z
         O70P70tF8pOEBGP/5aG5bV7699EM1Zl9xHcxLpWIsSjPjJvg7fgKePwsIje+/eFhHSP4
         /hFC5bR4CZKZGWMtOn3F0hk1bnU7zIdOiaaoWmsQF+o5aU6r51/G0lqOv0yg8RGqX6y8
         aREw==
X-Gm-Message-State: AOAM530n4/pF9UgkORjQtWv6VgCicaV46jBlMXIeL/jbATogG1mrq9NN
        fxGy9inl8RZyG777JY1Bwxqd1dURst4=
X-Google-Smtp-Source: ABdhPJxYeiQ2L/94mDwyv3mswoERkGf+Tmeckiw7ylTjL8M61t3axBfoCoxoXL00bXkKN7P/cwqndSOs1sQ=
X-Received: by 2002:aa7:9e4e:: with SMTP id z14mr31139029pfq.256.1594324077224;
 Thu, 09 Jul 2020 12:47:57 -0700 (PDT)
Date:   Thu,  9 Jul 2020 19:47:47 +0000
In-Reply-To: <20200709194751.2579207-1-satyat@google.com>
Message-Id: <20200709194751.2579207-2-satyat@google.com>
Mime-Version: 1.0
References: <20200709194751.2579207-1-satyat@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH 1/5] fscrypt: Add functions for direct I/O support
From:   Satya Tangirala <satyat@google.com>
To:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Cc:     Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Introduce fscrypt_dio_supported() to check whether a direct I/O request
is unsupported due to encryption constraints, and
fscrypt_limit_dio_pages() to check how many pages may be added to a bio
being prepared for direct I/O.

The IV_INO_LBLK_32 fscrypt policy introduces the possibility that DUNs
in logically continuous file blocks might wrap from 0xffffffff to 0.
Bios in which the DUN wraps around like this cannot be submitted. This
is especially difficult to handle when block_size != PAGE_SIZE, since in
that case the DUN can wrap in the middle of a page.

For now, we add direct I/O support while using IV_INO_LBLK_32 policies
only for the case when block_size == PAGE_SIZE. When IV_INO_LBLK_32
policy is used, fscrypt_dio_supported() rejects the bio when
block_size != PAGE_SIZE. fscrypt_limit_dio_pages() returns the number of
pages that may be added to the bio without causing the DUN to wrap
around within the bio.

Signed-off-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Satya Tangirala <satyat@google.com>
---
 fs/crypto/crypto.c       |  8 +++++
 fs/crypto/inline_crypt.c | 72 ++++++++++++++++++++++++++++++++++++++++
 include/linux/fscrypt.h  | 19 +++++++++++
 3 files changed, 99 insertions(+)

diff --git a/fs/crypto/crypto.c b/fs/crypto/crypto.c
index a52cf32733ab..b88d97618efb 100644
--- a/fs/crypto/crypto.c
+++ b/fs/crypto/crypto.c
@@ -69,6 +69,14 @@ void fscrypt_free_bounce_page(struct page *bounce_page)
 }
 EXPORT_SYMBOL(fscrypt_free_bounce_page);
 
+/*
+ * Generate the IV for the given logical block number within the given file.
+ * For filenames encryption, lblk_num == 0.
+ *
+ * Keep this in sync with fscrypt_limit_dio_pages().  fscrypt_limit_dio_pages()
+ * needs to know about any IV generation methods where the low bits of IV don't
+ * simply contain the lblk_num (e.g., IV_INO_LBLK_32).
+ */
 void fscrypt_generate_iv(union fscrypt_iv *iv, u64 lblk_num,
 			 const struct fscrypt_info *ci)
 {
diff --git a/fs/crypto/inline_crypt.c b/fs/crypto/inline_crypt.c
index d7aecadf33c1..86788ee2b206 100644
--- a/fs/crypto/inline_crypt.c
+++ b/fs/crypto/inline_crypt.c
@@ -16,6 +16,7 @@
 #include <linux/blkdev.h>
 #include <linux/buffer_head.h>
 #include <linux/sched/mm.h>
+#include <linux/uio.h>
 
 #include "fscrypt_private.h"
 
@@ -362,3 +363,74 @@ bool fscrypt_mergeable_bio_bh(struct bio *bio,
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
+ * fscrypt_limit_dio_pages() - limit I/O pages to avoid discontiguous DUNs
+ * @inode: the file on which I/O is being done
+ * @pos: the file position (in bytes) at which the I/O is being done
+ * @nr_pages: the number of pages we want to submit starting at @pos
+ *
+ * For direct I/O: limit the number of pages that will be submitted in the bio
+ * targeting @pos, in order to avoid crossing a data unit number (DUN)
+ * discontinuity.  This is only needed for certain IV generation methods.
+ *
+ * This assumes block_size == PAGE_SIZE; see fscrypt_dio_supported().
+ *
+ * Return: the actual number of pages that can be submitted
+ */
+int fscrypt_limit_dio_pages(const struct inode *inode, loff_t pos, int nr_pages)
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
index bb257411365f..9c65d949c611 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -559,6 +559,11 @@ bool fscrypt_mergeable_bio(struct bio *bio, const struct inode *inode,
 bool fscrypt_mergeable_bio_bh(struct bio *bio,
 			      const struct buffer_head *next_bh);
 
+bool fscrypt_dio_supported(struct kiocb *iocb, struct iov_iter *iter);
+
+int fscrypt_limit_dio_pages(const struct inode *inode, loff_t pos,
+			    int nr_pages);
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
+static inline int fscrypt_limit_dio_pages(const struct inode *inode, loff_t pos,
+					  int nr_pages)
+{
+	return nr_pages;
+}
 #endif /* !CONFIG_FS_ENCRYPTION_INLINE_CRYPT */
 
 /**
-- 
2.27.0.383.g050319c2ae-goog

