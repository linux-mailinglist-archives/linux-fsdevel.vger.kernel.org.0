Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E314B6C4D51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231386AbjCVORt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbjCVORq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:17:46 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015EF3A870;
        Wed, 22 Mar 2023 07:17:44 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id u11-20020a05600c19cb00b003edcc414997so6748442wmq.3;
        Wed, 22 Mar 2023 07:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679494663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sD0MPlFrVhMWSH5JN60JlycyouFVYe+2olLzRC7osbE=;
        b=SZZrJwTkk1Zp73lTIMKRvwbQGa8ch1PX+jAmldPyOG5gRBURN8BvmtVtUIhmj0HBvA
         pLzunQEEy4rL6QTv41jMRyOOksFWRsR5twWDy4pJvm8hgO7yzQAkYX2fV+wSvafa3KXP
         HtrucpKSdU+9bLowW7IO/xa8mJ9XfmDYUkib+6M/DPA5FgDkZaCNByy5GJXoLwfBTSu/
         eav9wpZczMJE752bzCcHxoftP1luDewpWFSmXhCDgVvNRvcF8nopae4lpWM+otnMS/Cw
         FzjFn/2aZOox8FCmeJI1qdrST/WW4+cD48RxBFxuxvPAcy6Im7cVpEbqQHpIhfHbY4NA
         0Hyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679494663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sD0MPlFrVhMWSH5JN60JlycyouFVYe+2olLzRC7osbE=;
        b=KOL/93q7hi7wSyeQUnjt2EjkjP6sawfGwwfC9tXEgQnDwtqfwcACC4kBEdyyfjLwPR
         MMLm5aMosKksl4LJZXwFp8J+8tmj3wijbVjcJfB+wJEPTuvmvLooisaZrxbOvuE3OFt1
         uLoD1FvHKZ7pqF+zS3oG6geXFvD10v23mDJvZq+Mo9kfw1yhZ7OeFyyMhKVRcL6x5YQf
         mBaMU7gDqwnBBotVTDrNPbI6ZCoIYif6irudd9OVfZ/yS2gp6x0n390S4ZvwdJTQhb6C
         cLOsB1d5lae5XuL655H3UvlasvrSWqOn88Hrln/qcLCHj72CdNBez1iDOt+K4Amd2FoS
         uJtg==
X-Gm-Message-State: AO0yUKWqkCQL8YixNUZe+UbLHQ/fizIkA3IocuKSA3ldj7llKH5d/9px
        VMgUOKzZIflAZNuR4cMKfE5hxPU4LSI=
X-Google-Smtp-Source: AK7set+mK+AFWoXkRQPmX4wDJTNtUX6lmlPzgoFe5inhIs5MHAzQ1qRRKbnOt+buQWmG09ni8HmOmg==
X-Received: by 2002:a05:600c:21da:b0:3ed:307f:1663 with SMTP id x26-20020a05600c21da00b003ed307f1663mr6011613wmj.15.1679494663036;
        Wed, 22 Mar 2023 07:17:43 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id h20-20020a1ccc14000000b003dc522dd25esm16824893wmb.30.2023.03.22.07.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:17:42 -0700 (PDT)
From:   Lorenzo Stoakes <lstoakes@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Baoquan He <bhe@redhat.com>, Uladzislau Rezki <urezki@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Jiri Olsa <jolsa@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Lorenzo Stoakes <lstoakes@gmail.com>
Subject: [PATCH v5 3/4] iov_iter: add copy_page_to_iter_nofault()
Date:   Wed, 22 Mar 2023 14:17:34 +0000
Message-Id: <50d2f757ab570dbb84e44eb84e25bd9780842d5f.1679494218.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679494218.git.lstoakes@gmail.com>
References: <cover.1679494218.git.lstoakes@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Provide a means to copy a page to user space from an iterator, aborting if
a page fault would occur. This supports compound pages, but may be passed a
tail page with an offset extending further into the compound page, so we
cannot pass a folio.

This allows for this function to be called from atomic context and _try_ to
user pages if they are faulted in, aborting if not.

The function does not use _copy_to_iter() in order to not specify
might_fault(), this is similar to copy_page_from_iter_atomic().

This is being added in order that an iteratable form of vread() can be
implemented while holding spinlocks.

Signed-off-by: Lorenzo Stoakes <lstoakes@gmail.com>
---
 include/linux/uio.h |  2 ++
 lib/iov_iter.c      | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 27e3fd942960..29eb18bb6feb 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -173,6 +173,8 @@ static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 {
 	return copy_page_to_iter(&folio->page, offset, bytes, i);
 }
+size_t copy_page_to_iter_nofault(struct page *page, unsigned offset,
+				 size_t bytes, struct iov_iter *i);
 
 static __always_inline __must_check
 size_t copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 274014e4eafe..b286cfea4bee 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -734,6 +734,42 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+size_t copy_page_to_iter_nofault(struct page *page, unsigned offset, size_t bytes,
+				 struct iov_iter *i)
+{
+	size_t res = 0;
+
+	if (!page_copy_sane(page, offset, bytes))
+		return 0;
+	if (WARN_ON_ONCE(i->data_source))
+		return 0;
+	if (unlikely(iov_iter_is_pipe(i)))
+		return copy_page_to_iter_pipe(page, offset, bytes, i);
+	page += offset / PAGE_SIZE; // first subpage
+	offset %= PAGE_SIZE;
+	while (1) {
+		void *kaddr = kmap_local_page(page);
+		size_t n = min(bytes, (size_t)PAGE_SIZE - offset);
+
+		iterate_and_advance(i, n, base, len, off,
+			copy_to_user_nofault(base, kaddr + offset + off, len),
+			memcpy(base, kaddr + offset + off, len)
+		)
+		kunmap_local(kaddr);
+		res += n;
+		bytes -= n;
+		if (!bytes || !n)
+			break;
+		offset += n;
+		if (offset == PAGE_SIZE) {
+			page++;
+			offset = 0;
+		}
+	}
+	return res;
+}
+EXPORT_SYMBOL(copy_page_to_iter_nofault);
+
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-- 
2.39.2

