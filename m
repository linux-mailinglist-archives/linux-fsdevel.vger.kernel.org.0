Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C476C300EB4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 22:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730048AbhAVVPz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 16:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729250AbhAVUtW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 15:49:22 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51643C061351
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:22 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id p15so4579842pjv.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 12:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rUrSv5a3k4qaJA6xCjOA8O8ZkzvHiOJp37R6oMRhd/s=;
        b=cy0QcBWEJOpNlrEEH0Rtvrozscq6t7muLe7G4vOHIQmvaG6O34slLP+UhdcVfMS2Ij
         m50JAjx5fsKG6cHJiQ1VHW5woqouctcQZDdXSy8ZXhzewz3YtBTXfMdIyYe2Y2K3wWVN
         6/Nch2PFRFvWM6ApcJD+68fu26qelaHpN7z5kuw6HVAiBssB6r1QRILGkS6+9SnQ5yfT
         0di5h77BoSxmZD10Mjk+1KvTyHmRR6DHI7QghfEo6IsYdhYBA+VjQtAMTLq96j4leXhK
         riaGoCpLAWX1SeVu0bJgSpbDsthPNPd/sstc3ceGHV3/a1SJl4L2pYHh3767mev3QHbF
         bLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rUrSv5a3k4qaJA6xCjOA8O8ZkzvHiOJp37R6oMRhd/s=;
        b=C89aMBxlJuMGt5uL+ajbVNKBNVy1nc34mCQ8GwiNiMYbDW4ry2pW7YsKu6fJhFtI8P
         uuDLEZpe62pFKTuZ0dKjOwG6wwT53yX5b4/BEg6U7e3jf7ISedMlid1dJwH7T7AQPJr/
         GpbVRxtEwSEDWY6Kl+Nwsb5YX6I+F2fRp1jkaRugS+/XpiAvFWcZ9lN3Rp6IoxtVjm/p
         W8WhLyLq3lIZA53HSbbcy0IBKtDiBECoLwYdP5fbRQ2GJ1NufReTw4DiWktGWij/ldyv
         GxamF3ijYGCZeS78csOZh8cYN3vf5ETcGnzBrGjegD7I58sC5DKkEH2V7FI+Q3FdBTlk
         3fZw==
X-Gm-Message-State: AOAM533ukz7UNTn5hq2tp/5WBsP6WTjC4y5aKO/Z4GdIgV6eOpLW+0LF
        rtWdFv1/LfKNy/xCNSvlMWOjD94uhf5Pcg==
X-Google-Smtp-Source: ABdhPJz1B4n6Rk7dvmWq3RNevUOFnZeWA8G4FgacZGyIY3z/iihHeNfBrAFENgHBLu0CfBfWS3X5tQ==
X-Received: by 2002:a17:90b:1a86:: with SMTP id ng6mr7239385pjb.113.1611348441102;
        Fri, 22 Jan 2021 12:47:21 -0800 (PST)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:ea88])
        by smtp.gmail.com with ESMTPSA id j18sm4092900pfc.99.2021.01.22.12.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jan 2021 12:47:20 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v7 01/10] iov_iter: add copy_struct_from_iter()
Date:   Fri, 22 Jan 2021 12:46:48 -0800
Message-Id: <e71e712d27b2e2c19efc5b1454bd8581ad98d900.1611346706.git.osandov@fb.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <cover.1611346706.git.osandov@fb.com>
References: <cover.1611346706.git.osandov@fb.com>
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
2.30.0

