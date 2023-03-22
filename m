Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB0BA6C4EAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 15:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCVO4X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 10:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbjCVOz5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:55:57 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43E03F74D;
        Wed, 22 Mar 2023 07:55:38 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id l15-20020a05600c4f0f00b003ed58a9a15eso11680979wmq.5;
        Wed, 22 Mar 2023 07:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679496937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziv2ovcgc/3NOuBG0+YWYfMhKDq2ZBtAkLCMMX3QtWE=;
        b=OAV5bOCAXt/brQqvvLh3Ler2AJ9GHlTfIBj1zt+bsAVk1mAGgHj8zeXzy1CFUIp59c
         g0j4bfCzrA7HOPI24EkKttjDSOoekv+lp+Ux319tiQlEiMRhczQCWjFgd+nzWyQKlYOT
         4G+WxPHSgXXiBWEEVZp2ZsT7q1mu6rQC7V+PJJFavEAzMrHcGzFz/V0d2Ten7uIdDb2o
         Rh+kJe2IOaU5+vJojOU8XbVJBIgq4JPoY7Lw2AfMgj7MaAlx776xF93KeEnSwUv6Plzp
         l1moQKfShHAfPpJjJMHywcku9UjCVzyket6xtX2PJvJCiWX1uH1VH3plioVFy68wB7v2
         TPhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziv2ovcgc/3NOuBG0+YWYfMhKDq2ZBtAkLCMMX3QtWE=;
        b=edOQ4JU/au7L5Vu1swcyW3dr5AD8MRb0SUT0/xDHsfEk/Y+/G3qQU0UPGSpur23UVX
         6yF8Wo2VK9eWsZhWYPwcSCDt5sTahTzPK1cfF5CQhxpSlkACxO8a2eCB6uePkV2ttVtV
         DiC5ej+hMVlhG7scaDumBQ+rNMKz9nLJkUZf3RhUmGPisYbkm6ncisA1fpzgxVsca7IP
         kG3HK73LZT++SlO6CF3mtmk1g0E9P6XsziKB5UjOoa4NAaTiTYzwTtzcxfDVoYCQt/Cy
         Tb2O14EistXZx8pAZHixIpq0eFVlhHr3bGd32RX/2AQwc/vgr73rNoIv8p83PSZFunzq
         jdGg==
X-Gm-Message-State: AO0yUKXm2L6nvQVH1gp3Zm9rdDzuwtAK2tOPuIYtwWanQcsew47VDHh7
        zUgiFuKqimeAcvuh2gpl5lA=
X-Google-Smtp-Source: AK7set9doYzaEsFJwhlnO7ROmhc0QBK17nVojzEcg2JEds9E8AVQb6TMCOYkJXMHKA13gZcDAvM6xw==
X-Received: by 2002:a05:600c:2048:b0:3ed:cf2a:3fe8 with SMTP id p8-20020a05600c204800b003edcf2a3fe8mr5815815wmg.8.1679496936720;
        Wed, 22 Mar 2023 07:55:36 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id n23-20020a7bcbd7000000b003ed243222adsm16812246wmi.42.2023.03.22.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 07:55:35 -0700 (PDT)
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
Subject: [PATCH v6 3/4] iov_iter: add copy_page_to_iter_nofault()
Date:   Wed, 22 Mar 2023 14:55:27 +0000
Message-Id: <19734729defb0f498a76bdec1bef3ac48a3af3e8.1679496827.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679496827.git.lstoakes@gmail.com>
References: <cover.1679496827.git.lstoakes@gmail.com>
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
 lib/iov_iter.c      | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index 274014e4eafe..34dd6bdf2fba 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -172,6 +172,18 @@ static int copyout(void __user *to, const void *from, size_t n)
 	return n;
 }
 
+static int copyout_nofault(void __user *to, const void *from, size_t n)
+{
+	long res;
+
+	if (should_fail_usercopy())
+		return n;
+
+	res = copy_to_user_nofault(to, from, n);
+
+	return res < 0 ? n : res;
+}
+
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	size_t res = n;
@@ -734,6 +746,42 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
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
+			copyout_nofault(base, kaddr + offset + off, len),
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

