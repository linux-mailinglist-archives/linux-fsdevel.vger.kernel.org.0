Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37DAB6C25F0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 00:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjCTXpA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 19:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjCTXon (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 19:44:43 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273A126B7;
        Mon, 20 Mar 2023 16:44:06 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p16so8538941wmq.5;
        Mon, 20 Mar 2023 16:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679355784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4AaWDqV89kHBZGOLd4BouvpuEGkoHHTR7oX6vXaXkQ=;
        b=joYGkNHDTIsLDeWPgNoFM1Q2okpaE69pfNRmsJ+y/FqybsxiiD+p7xTXMJv2UFV0A4
         61fb425zxzibhUQzrQsMe+rvlxgYOETUMHea7etZsESI8rZOo4ch6rs8uwDgEw4AZwQq
         WptL6DO4Mh3xD3x/xEpN4MzKVjKbqOFOuXI8KHNI2LyUGuRKrkBrDQzECkZx7pRpslH5
         mDklMyfPXPFzXOVbZnRQD9T7rso1xeq9+UI4bd/sNZgmWlqJJWEsu0WvCuvldUOHOgsz
         ISy5IEqLL/JqGRLSc/sCbOBrebzi6Wz+mu3+a8zo1CDe3MyBUJbx31A/G3Kquds1CT5J
         UH7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679355784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4AaWDqV89kHBZGOLd4BouvpuEGkoHHTR7oX6vXaXkQ=;
        b=JfUyYl7U3EnofG+9dG4CR9+EQYSrB6r66KcV/wBHio117iwh3Ui+V3vGHIvSWhWa+u
         ECcqqT10PwBdT+MTB88WYEYRMZSxvVHb62VMZI4jgk4xpivyE98RejMhxX2U+jgNZdKX
         2qZnboEo1a7ywDgyzfPaoAiuPfjEjyy/jhRmUITvLmW4LW9uONFoWnIi7T3Tad9+q76z
         by0sMZIKsNUhC6FryyrNYzytQoQlzSxdWe4Q3bKEcEkC9WKqBTABSqdC/xpTDK6MH8mW
         ZYhyuRFnxK1OG0Th4f7fL85ZSYt1H0eRFVGt5nCvHW8rourr0440LzH0zXejf5EGfRUy
         Ietg==
X-Gm-Message-State: AO0yUKXqjdPtNNuBgfT/QzMWM8oxq8t8JJbjTVbDu/eGssYzwbm602CC
        CHgSuopQMpzPljBcs3M9wJU=
X-Google-Smtp-Source: AK7set9UWWC6CCPypNwh9/g+mA241iJtMd+z1H8zy+rUDOsZ1zyTSPvDhBDWMVBAvr03Fg0Tb8CvAA==
X-Received: by 2002:a05:600c:296:b0:3ea:f873:13aa with SMTP id 22-20020a05600c029600b003eaf87313aamr773429wmk.40.1679355783915;
        Mon, 20 Mar 2023 16:43:03 -0700 (PDT)
Received: from lucifer.home (host86-146-209-214.range86-146.btcentralplus.com. [86.146.209.214])
        by smtp.googlemail.com with ESMTPSA id u1-20020a05600c440100b003e209186c07sm17504541wmn.19.2023.03.20.16.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 16:43:02 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v3 3/4] iov_iter: add copy_page_to_iter_atomic()
Date:   Mon, 20 Mar 2023 23:42:44 +0000
Message-Id: <31482908634cbb68adafedb65f0b21888c194a1b.1679355227.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679355227.git.lstoakes@gmail.com>
References: <cover.1679355227.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide an atomic context equivalent for copy_page_to_iter(). This eschews
the might_fault() check copies memory in the same way that
copy_page_from_iter_atomic() does.

This functions assumes a non-compound page, however this mimics the
existing behaviour of copy_page_from_iter_atomic(). I am keeping the
behaviour consistent between the two, deferring any such change to an
explicit folio-fication effort.

This is being added in order that an iteratable form of vread() can be
implemented with known prefaulted pages to avoid the need for mutex
locking.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd942960..fab07103090f 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -154,6 +154,8 @@ static inline struct iovec iov_iter_iovec(const struct iov_iter *iter)
 
 size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
 				  size_t bytes, struct iov_iter *i);
+size_t copy_page_to_iter_atomic(struct page *page, unsigned offset,
+				size_t bytes, struct iov_iter *i);
 void iov_iter_advance(struct iov_iter *i, size_t bytes);
 void iov_iter_revert(struct iov_iter *i, size_t bytes);
 size_t fault_in_iov_iter_readable(const struct iov_iter *i, size_t bytes);
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..48ca1c5dfc04 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -821,6 +821,34 @@ size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t byt
 }
 EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
+size_t copy_page_to_iter_atomic(struct page *page, unsigned offset, size_t bytes,
+				struct iov_iter *i)
+{
+	char *kaddr = kmap_local_page(page);
+	char *p = kaddr + offset;
+	size_t copied = 0;
+
+	if (!page_copy_sane(page, offset, bytes) ||
+	    WARN_ON_ONCE(i->data_source))
+		goto out;
+
+	if (unlikely(iov_iter_is_pipe(i))) {
+		copied = copy_page_to_iter_pipe(page, offset, bytes, i);
+		goto out;
+	}
+
+	iterate_and_advance(i, bytes, base, len, off,
+		copyout(base, p + off, len),
+		memcpy(base, p + off, len)
+	)
+	copied = bytes;
+
+out:
+	kunmap_local(kaddr);
+	return copied;
+}
+EXPORT_SYMBOL(copy_page_to_iter_atomic);
+
 static void pipe_advance(struct iov_iter *i, size_t size)
 {
 	struct pipe_inode_info *pipe = i->pipe;
-- 
2.39.2

