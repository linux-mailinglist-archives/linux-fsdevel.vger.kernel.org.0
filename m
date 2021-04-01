Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15A93350F58
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Apr 2021 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230284AbhDAGvk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Apr 2021 02:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhDAGva (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Apr 2021 02:51:30 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5B05C0613E6
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:30 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id bt4so634595pjb.5
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Mar 2021 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fi2Oan0mGiDav2mDFzFT9HRE0EOQ+3jECdDIraTSexk=;
        b=XQ86lQ4uO5W0N07XHeJXa1d+EXIJ/JfXF4DtoosSryycrrLeTXdfuq/KbCioRhE8Hg
         En9/j1kfqqih3qlfA6Ddw8wTYegGCFT/+3eUEZ7f9Bq0dSMhXtQmqLlmBvuCswUho5Ba
         9o3dv82jKFDcp54lG0Uf5hwy2bxPcgz3MJwN/Lrlzdfw6AoS6ODa7YnvPfcVlBDZhiND
         ahzvVrF+iiyW1bdHWDIlB3ikPOK+Q/+CStHrN2t0Yy251licbNqBkucvHEKqBKVjA2UQ
         NJ4iRlAUBrKx12XzXo54ouzIj0clQADnQd7J7MeTrDJek+msm0Kg5xTKd6zmGGlGGXgP
         ixXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fi2Oan0mGiDav2mDFzFT9HRE0EOQ+3jECdDIraTSexk=;
        b=GcnIJtYr4HSRxjB1xPJ/UTkI9qUFoDrl8rGvKptENwufizvvUadJiN1sKNcQAUsm4C
         0Y9GSUeXZLWkQ2YNdCHh2tOU+p0fji2FgdBwV0oAWK6TS6SDbsHosJejkCu2ogEUNCEM
         vFtzR80DcNDA727nYQmb1pm+3nxF8O3ESltUzlMQUlAveh+7ROU8YOm1EPxJO0lZRCi6
         vjtglrX6pfrr7x/XzMkMUQjQnBfqsUPjH9gJ4KzUuNY3vpwpsuDus6qt97KqKT5uWI4t
         tXqDlSiE63hFxLgo3hUuGJfz9DfXWlvL//Tezbd1oiKkcgFFs1HBNaxutHfh33bL1HeX
         AjzA==
X-Gm-Message-State: AOAM5318tlkmfsYU0j30snTkr+wwPgJGPTh76Sa1HayjpgPgSa/4SgVl
        nYfg/dq+goglm57p3ynprXxjNE0kc9V0Cw==
X-Google-Smtp-Source: ABdhPJwglSGsSsv4Q0/1gjwyc4kNp2Fh0c4K6jTX2oC/2h//t74GbXHnhluP11Ycwi4sbiZxCpektg==
X-Received: by 2002:a17:90a:d991:: with SMTP id d17mr7290640pjv.229.1617259889486;
        Wed, 31 Mar 2021 23:51:29 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:3734])
        by smtp.gmail.com with ESMTPSA id kk6sm4158345pjb.51.2021.03.31.23.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 23:51:28 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH v9 1/9] iov_iter: add copy_struct_from_iter()
Date:   Wed, 31 Mar 2021 23:51:06 -0700
Message-Id: <0e7270919b461c4249557b12c7dfce0ad35af300.1617258892.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1617258892.git.osandov@fb.com>
References: <cover.1617258892.git.osandov@fb.com>
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
 include/linux/uio.h |  1 +
 lib/iov_iter.c      | 91 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27ff8eb786dc..cc94223d16d9 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -121,6 +121,7 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index f66c62aa7154..9642f651e27a 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -934,6 +934,97 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_from_iter);
 
+/**
+ * copy_struct_from_iter - copy a struct from an iov_iter
+ * @dst: Destination buffer.
+ * @ksize: Size of @dst struct.
+ * @i: Source iterator.
+ *
+ * Copies a struct from an iov_iter in a way that guarantees
+ * backwards-compatibility for struct arguments in an iovec (as long as the
+ * rules for copy_struct_from_user() are followed).
+ *
+ * The source struct is assumed to be stored in the current segment of the
+ * iov_iter, and its size is the size of the current segment. The iov_iter must
+ * be positioned at the beginning of the current segment.
+ *
+ * The recommended usage is something like the following:
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
+ *     err = copy_struct_from_iter(&karg, sizeof(karg), i);
+ *     if (err)
+ *       return err;
+ *
+ *     // ...
+ *   }
+ *
+ * Returns 0 on success or one of the following errors:
+ *  * -E2BIG:  (size of current segment > @ksize) and there are non-zero
+ *             trailing bytes in the current segment.
+ *  * -EFAULT: access to userspace failed.
+ *  * -EINVAL: the iterator is not at the beginning of the current segment.
+ *
+ * On success, the iterator is advanced to the next segment. On error, the
+ * iterator is not advanced.
+ */
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i)
+{
+	size_t usize;
+	int ret;
+
+	if (i->iov_offset != 0)
+		return -EINVAL;
+	if (iter_is_iovec(i)) {
+		usize = i->iov->iov_len;
+		might_fault();
+		if (copyin(dst, i->iov->iov_base, min(ksize, usize)))
+			return -EFAULT;
+		if (usize > ksize) {
+			ret = check_zeroed_user(i->iov->iov_base + ksize,
+						usize - ksize);
+			if (ret < 0)
+				return ret;
+			else if (ret == 0)
+				return -E2BIG;
+		}
+	} else if (iov_iter_is_kvec(i)) {
+		usize = i->kvec->iov_len;
+		memcpy(dst, i->kvec->iov_base, min(ksize, usize));
+		if (usize > ksize &&
+		    memchr_inv(i->kvec->iov_base + ksize, 0, usize - ksize))
+			return -E2BIG;
+	} else if (iov_iter_is_bvec(i)) {
+		char *p;
+
+		usize = i->bvec->bv_len;
+		p = kmap_local_page(i->bvec->bv_page);
+		memcpy(dst, p + i->bvec->bv_offset, min(ksize, usize));
+		if (usize > ksize &&
+		    memchr_inv(p + i->bvec->bv_offset + ksize, 0,
+			       usize - ksize)) {
+			kunmap_local(p);
+			return -E2BIG;
+		}
+		kunmap_local(p);
+	} else {
+		return -EFAULT;
+	}
+	if (usize < ksize)
+		memset(dst + usize, 0, ksize - usize);
+	iov_iter_advance(i, usize);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(copy_struct_from_iter);
+
 static size_t pipe_zero(size_t bytes, struct iov_iter *i)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.31.1

