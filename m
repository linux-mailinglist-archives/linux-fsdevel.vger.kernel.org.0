Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8536633DDC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Mar 2021 20:44:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240567AbhCPTn6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Mar 2021 15:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240531AbhCPTnb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Mar 2021 15:43:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D66C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id ga23-20020a17090b0397b02900c0b81bbcd4so1943074pjb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 Mar 2021 12:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S/6rupWKTyorGS3sxCouSuC4B76W02uh+glgFafNJ6k=;
        b=l+/Kjam5NvfeDfV+Yu8QrXWQSQcinlicuz+iAO3dFsBEhL7wOE2CVxMoAsbS86+ngI
         GW308Ao/qDz4jYifgdFeTpPhnKmBwPVvIlzz/KW/j682xfe13WAnfH3tHNtk0HNPBMIi
         saywqG7giRqW2aekzc3OTq8GvrLmmbth5nIYDxMRX8v0L+b7hT7ND0Ak8Xy+uDTYimAV
         eqXEYZHdOCYZw47U6Sn1RA0AS+qrbOZk61GncN7N6sd9ayRuNHqBxX4CeuUD1Jkgq3MA
         mdEuncYZwRjPwlxv55956ASrh4zpV72GcKbMXmBISJ1fz1oWVeq7oPM1hvFaG3n29ooh
         1DBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S/6rupWKTyorGS3sxCouSuC4B76W02uh+glgFafNJ6k=;
        b=rxYGfZuQtTgtwcbW0fUTsCDajAvrJgEu95NvxhY2TZrUU2ng2/rdhxUWn80fn5Xhmr
         6CXHpWYwjIQxnUgj/CCicWzrP4ya7pfrlRLNut1WF3LrpWrmlYySLUaTnH4CJilMFosG
         46MA8r/w2nBwBW3b+/MU3/TZZ53ViwINX4nv9m0WKZN8IzuMqFeNBZvIdNZwLfIPAgFy
         zFLk969PN/SA6bCr4OZwihZWucArA47VGXSUEFszPoNvEduBwgDcUGpckiCwgpI2DHMt
         OqU5icV97BmO0nPpw4DD/s99xXmbYTGcBhjb8+YMf2Bz9Wm+LBAEJKHrmnGT25NEcTBo
         Z4SA==
X-Gm-Message-State: AOAM532ICsVBoxMm0ODFHfhc5+SiAwSa8U1Y+luM5KqzfJX+Ek89ED5S
        SLZXA3AOY+IroPhFGJ+m2MkdKF/ZngQgOg==
X-Google-Smtp-Source: ABdhPJyiKRF0IUPmE2h2K3CQBqvwez2zLaKR9/UVEtIqMTg95vIuBi3aGfn8wYzj9wThanJy/XMI7Q==
X-Received: by 2002:a17:90a:fe93:: with SMTP id co19mr647555pjb.142.1615923808981;
        Tue, 16 Mar 2021 12:43:28 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:532])
        by smtp.gmail.com with ESMTPSA id gm10sm217264pjb.4.2021.03.16.12.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 12:43:27 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v8 01/10] iov_iter: add copy_struct_from_iter()
Date:   Tue, 16 Mar 2021 12:42:57 -0700
Message-Id: <e71e712d27b2e2c19efc5b1454bd8581ad98d900.1615922644.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1615922644.git.osandov@fb.com>
References: <cover.1615922644.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is essentially copy_struct_from_user() but for an iov_iter.

Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
Reviewed-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 72d88566694e..f4e6ea85a269 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -121,6 +121,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
+			  size_t usize);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a21e6a5792c5..f45826ed7528 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -948,6 +948,88 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
+/**
+ * copy_struct_from_iter - copy a struct from an iov_iter
+ * @dst: Destination buffer.
+ * @ksize: Size of @dst struct.
+ * @i: Source iterator.
+ * @usize: (Alleged) size of struct in @i.
+ *
+ * Copies a struct from an iov_iter in a way that guarantees
+ * backwards-compatibility for struct arguments in an iovec (as long as the
+ * rules for copy_struct_from_user() are followed).
+ *
+ * The recommended usage is that @usize be taken from the current segment:
+ *
+ *   int do_foo(struct iov_iter *i)
+ *   {
+ *     size_t usize = iov_iter_single_seg_count(i);
+ *     struct foo karg;
+ *     int err;
+ *
+ *     if (usize > PAGE_SIZE)
+ *       return -E2BIG;
+ *     if (usize < FOO_SIZE_VER0)
+ *       return -EINVAL;
+ *     err = copy_struct_from_iter(&karg, sizeof(karg), i, usize);
+ *     if (err)
+ *       return err;
+ *
+ *     // ...
+ *   }
+ *
+ * Return: 0 on success, -errno on error (see copy_struct_from_user()).
+ *
+ * On success, the iterator is advanced @usize bytes. On error, the iterator is
+ * not advanced.
+ */
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
+			  size_t usize)
+{
+	if (usize <= ksize) {
+		if (!copy_from_iter_full(dst, usize, i))
+			return -EFAULT;
+		memset(dst + usize, 0, ksize - usize);
+	} else {
+		size_t copied = 0, copy;
+		int ret;
+
+		if (WARN_ON(iov_iter_is_pipe(i)) || unlikely(i->count < usize))
+			return -EFAULT;
+		if (iter_is_iovec(i))
+			might_fault();
+		iterate_all_kinds(i, usize, v, ({
+			copy = min(ksize - copied, v.iov_len);
+			if (copy && copyin(dst + copied, v.iov_base, copy))
+				return -EFAULT;
+			copied += copy;
+			ret = check_zeroed_user(v.iov_base + copy,
+						v.iov_len - copy);
+			if (ret <= 0)
+				return ret ?: -E2BIG;
+			0;}), ({
+			char *addr = kmap_atomic(v.bv_page);
+			copy = min_t(size_t, ksize - copied, v.bv_len);
+			memcpy(dst + copied, addr + v.bv_offset, copy);
+			copied += copy;
+			ret = memchr_inv(addr + v.bv_offset + copy, 0,
+					 v.bv_len - copy) ? -E2BIG : 0;
+			kunmap_atomic(addr);
+			if (ret)
+				return ret;
+			}), ({
+			copy = min(ksize - copied, v.iov_len);
+			memcpy(dst + copied, v.iov_base, copy);
+			if (memchr_inv(v.iov_base, 0, v.iov_len))
+				return -E2BIG;
+			})
+		)
+		iov_iter_advance(i, usize);
+	}
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_struct_from_iter);
+
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.30.2

