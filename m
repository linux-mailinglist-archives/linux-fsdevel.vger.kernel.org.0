Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877DB3ABFCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Jun 2021 01:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhFQXx7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Jun 2021 19:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhFQXx6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Jun 2021 19:53:58 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFF6C06175F
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:51:49 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id l11so380611pji.5
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jun 2021 16:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xNwGoUMyfeYqD+Bx4vIA/2/g+T4eyBaHgsh9OW57yKs=;
        b=1GlVuhgjMpfMwStzqL8PP9Rus+VrUqJnb/DupgaQ19TaUtRIwR4VSEJAuhVRZk5dio
         R5tzAIR33nGApLguZbCb+cYeeYGCCthCCTWow1yBwTHY/Ls1WCqIWEP+FmtJ2EMMB+a1
         BnYoYCWSNjBqwQOMQbpQ4LXlgn1IEBkFwWP++yfUTm9hvhoMwRS6my5Nm3lmUfqDxTuJ
         4M7kjlH9uddiH6BBExZBlV0vF0+gAYqPSNKrpbhxbiJuPjI+224ZmChOqt1F6mO1oEyW
         Hi/hAKRlMb0mI1svNJfI2KljJNBVcYgz2HimjcMLGqGvKQ59W1dR0C0zjIkBaQsv0Dmn
         YRCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xNwGoUMyfeYqD+Bx4vIA/2/g+T4eyBaHgsh9OW57yKs=;
        b=tlb+Le+fltdRr4RlInbKe8CqxiCYdXVXeJvE0xaSN9gexY4xFwTTJ9Fde/d1RfPw9T
         tLRS58iBVcTDAGZS7Jn1/Gw6cGzfrJLCynnKEPGgT24j/2AgiJ9ikZKFSUCreHAKQyyf
         ukIn+PW8TvbeKNTFM4sxSnCHSqXATra7wlh3Ke4qMltkM9PYEJF5znWWwf5XxvabUUMz
         U/lO1uD7FoyJB7+/EmtpkMvn21l23I5W66tuyTH1JtnvUNmMMSs0+4RslNRT7dAKru/J
         7tn/fSTQFzoTtm1NB4C3iKpuck+BdFl+3mWvsQO6qqtekZ73+XaCk4NkR6mTydEA1dvR
         6qNw==
X-Gm-Message-State: AOAM531h/IS1Znfa5wrw2W/OtUOoUg0bLcmezN2kn+4/ltN9+sLFfCMi
        Q8+YPmRUoRFKOyKVu9Q8clXn7i8ZLcSBMA==
X-Google-Smtp-Source: ABdhPJyTWSM/PrmIlFFCQ3w8+ffXmFmDe8OJP2hufWz/1P7jbqYkyv0pRVRXbNvElSKjULlEscf2Qg==
X-Received: by 2002:a17:90b:502:: with SMTP id r2mr19179936pjz.18.1623973908752;
        Thu, 17 Jun 2021 16:51:48 -0700 (PDT)
Received: from relinquished.tfbnw.net ([2620:10d:c090:400::5:2f0e])
        by smtp.gmail.com with ESMTPSA id a187sm6087517pfb.66.2021.06.17.16.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 16:51:48 -0700 (PDT)
From:   Omar Sandoval <osandov@osandov.com>
To:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-api@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH RESEND x3 v9 1/9] iov_iter: add copy_struct_from_iter()
Date:   Thu, 17 Jun 2021 16:51:24 -0700
Message-Id: <6caae597eb20da5ea23e53e8e64ce0c4f4d9c6d2.1623972519.git.osandov@fb.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623972518.git.osandov@fb.com>
References: <cover.1623972518.git.osandov@fb.com>
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
index d3ec87706d75..cbaf6b3bfcbc 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -129,6 +129,7 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i);
+int copy_struct_from_iter(void *dst, size_t ksize, struct iov_iter *i);
 
 size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index c701b7a187f2..129f264416ff 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -995,6 +995,97 @@ size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
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
2.32.0

