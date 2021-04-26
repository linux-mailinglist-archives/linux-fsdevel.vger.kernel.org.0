Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5A7636B9AE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Apr 2021 21:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbhDZTHP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Apr 2021 15:07:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239934AbhDZTHH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Apr 2021 15:07:07 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F80C061763
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:06:24 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id kb13-20020a17090ae7cdb02901503d67f0beso55589pjb.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Apr 2021 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fi2Oan0mGiDav2mDFzFT9HRE0EOQ+3jECdDIraTSexk=;
        b=uC3RXx1+ULzUlJksMMsRaW3Wv9lDIos3Ujx5LL+yzugvIY3cnHD2/mj4jU2bTyypzU
         Q87GZoHSnq7rDCqKsOlcHmjeski5Pz1EVUA/cokW229+UQpjGfXD/VtWroMpZtdLtgb6
         Y1ikzUINnDz4JutrjL0Eg1RWtEytWFmtUViF8smxyj51AWa1YBIKkUansLM9gU9fCeoI
         6E802BcpAQ1LQMlI2Ed8COmquYz0ZzSb8mUADqRptqDEqhfzwONnDXqeGD/UUl4XB6rR
         jrtPnkue20jVhh7ZcqFP09jMc9p5kMXZuXI7cWHRHwOU+n3qhjzUr3uWZ/Bp1z1sTeQm
         1zpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fi2Oan0mGiDav2mDFzFT9HRE0EOQ+3jECdDIraTSexk=;
        b=PpXhwTy9BGuuoAZnMR9xqLQXIQyTXx8AbFRxbaueNwPqnpJzq5wLZk/kxoO4WLONai
         67yTwfG5/SnUbAmwZ+bHtUgO2wZikfeb+QPOfY+LSmuveChHtBJwhRU298PrQDtlyvGs
         u74DbXyM3KsAbbpVHCGF5Lyj7VyYM3EH20rkXKYwWrfxoTIpw6qSY1eKznj2/HCGI6+H
         bLXqEGsqzk93C73BrEWZ9vW14JSla/eRzwCcYisnxN8Rx3GonOYMK9KMmQBJxsbLco5p
         baRET0vrs8IFZ6RyEBeCItzqBS8WQgnj1CqsuLmxIbBHX5lFiqK6LcdnEpKU+kAAV0bN
         IfnQ==
X-Gm-Message-State: AOAM533WdhIzek9r6AtpdkAMOxFAGxA9WVuO8/p0mF3ZzagFzmc90RTL
        dHmhLd3u/yxPV8sHA6yY1GWKt+V0j72WYQ==
X-Google-Smtp-Source: ABdhPJzKaz4uU402z3M92e7RfNQ7YneiXXMO/ytLC7rYJbx6cs6J1jTnaCwBT9nPI93IpBvZ5SDleQ==
X-Received: by 2002:a17:902:36b:b029:ed:4645:2ed1 with SMTP id 98-20020a170902036bb02900ed46452ed1mr2911353pld.16.1619463982907;
        Mon, 26 Apr 2021 12:06:22 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:f06a])
        by smtp.gmail.com with ESMTPSA id lx11sm331745pjb.27.2021.04.26.12.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:06:22 -0700 (PDT)
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
Subject: [PATCH RESEND v9 1/9] iov_iter: add copy_struct_from_iter()
Date:   Mon, 26 Apr 2021 12:06:04 -0700
Message-Id: <bc106964f468a20e4d1c7d8b5f4ac0879c01630e.1619463858.git.osandov@fb.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1619463858.git.osandov@fb.com>
References: <cover.1619463858.git.osandov@fb.com>
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

