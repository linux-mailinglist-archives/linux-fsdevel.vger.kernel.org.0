Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38C4210436B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Nov 2019 19:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbfKTSYx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Nov 2019 13:24:53 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45796 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728164AbfKTSYx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Nov 2019 13:24:53 -0500
Received: by mail-pg1-f195.google.com with SMTP id k1so111634pgg.12
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Nov 2019 10:24:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BL2QE/KeJqdnhjLUxyPz3bAYUZFYP5HC6G0oOFMNP9w=;
        b=xKNLEdzhbfup5x/bg2p9Xn5GbkpRL3Fhu3Mr5GgH9g00Aoz5MZz/J6AeE7c/KGnxDz
         uR/iJUUYEpaIMBm8T2m/AYhbygBzSDVuGrjk+GKZ94EH8VRtZ7hYQ0hY4eW4GYQiAnZG
         nRQgW6M03V7oTRN9u4RsDgX1OUCMYS6+vjGFPoxlfWc1VS8ox4PmpPzmrupi+6PVFGuP
         2bJSCfSfFKKOIU8Fh0p/n6jYPPmv0s7tUtppqptuez2MYOFzRYmYI8MkE6K6YiOk0cwE
         XjSxQI9Je1UpHNgkUEzH0Fr/qDFkJSf9lqPcXtIl9Ttd77+gAltznYbvPWEkrL4DVuAw
         /cUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BL2QE/KeJqdnhjLUxyPz3bAYUZFYP5HC6G0oOFMNP9w=;
        b=V3Xtyhq+0rtNn9+kJRbJcwGGRjtaL8RMgmnZQqpcm2YnzxLVIi3Vg/ioxF+E4mJULs
         6mZZJZ56dzg2PCHzPX9B5lQsfrNST3xh8YhCMWd1TetY/TnSUHo2+gXBNX2wyfkZ3Th9
         Ac76Fl8h923w/o9p3vk35dhP1z0d3eceUzESD0w4bUqqi2ETtL1QrUfxgwWZnlpM2G2l
         F4QCLZtNiV2LdB98v8RKuSZFrFHPjucxw7s7aekWyl92jHK1ssTxrVSICUBVhdqcM2CV
         qn4/q2do43eUxNOYfs5nxQHJsn1pb9fUt145HShHdgFyvZjGBccSfK4JWJJcMsnh8QWH
         xICA==
X-Gm-Message-State: APjAAAXwLS2/MDf6MpPm6TVARpva5jrKNLG9+Xko2bzGbQQVs6rVanml
        whvni4co7BfsjAHGYvTiIyQbCzyxlkI=
X-Google-Smtp-Source: APXvYqxwFDInJaK7L4xPGI5U87dhsu+CPeJ3QIEBbJNax4j19XEsJdxyj3O8jOyOH/hFfy7bm1kg6Q==
X-Received: by 2002:a63:1b4e:: with SMTP id b14mr4934573pgm.280.1574274291658;
        Wed, 20 Nov 2019 10:24:51 -0800 (PST)
Received: from vader.thefacebook.com ([2620:10d:c090:180::1a46])
        by smtp.gmail.com with ESMTPSA id q34sm7937866pjb.15.2019.11.20.10.24.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 10:24:51 -0800 (PST)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Cc:     Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [RFC PATCH v3 01/12] iov_iter: add copy_struct_from_iter()
Date:   Wed, 20 Nov 2019 10:24:21 -0800
Message-Id: <a90443c332d7469bb3fbdc2127caa861f0d99146.1574273658.git.osandov@fb.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1574273658.git.osandov@fb.com>
References: <cover.1574273658.git.osandov@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

This is essentially copy_struct_from_user() but for an iov_iter.

Suggested-by: Aleksa Sarai <cyphar@cyphar.com>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 82 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index ab5f523bc0df..39aa35e94d3a 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -122,6 +122,8 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i,
+			  size_t usize);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 639d5e7014c1..8fc2fa92a129 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -922,6 +922,88 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
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
2.24.0

