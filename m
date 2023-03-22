Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 209136C545C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Mar 2023 19:58:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbjCVS62 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Mar 2023 14:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjCVS54 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Mar 2023 14:57:56 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8146A40E;
        Wed, 22 Mar 2023 11:57:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso1011041wmo.0;
        Wed, 22 Mar 2023 11:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679511432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziv2ovcgc/3NOuBG0+YWYfMhKDq2ZBtAkLCMMX3QtWE=;
        b=pSMg5UEBvQYaeaphxsZGSMu90NwfzNxBS853TRITWW30wbesMhqO1tZGT+kb4EgOvf
         u5JiSwpHERnz4s0V0LYNAYZ47ItfIYo5L0N6vhezRC7f7jPvNZSIP89HlkXwl1EYgdl4
         yU53nBJsGttjxnq94XhWM3OZccecYFq4rReA4dFVP2bRHG47H/fknqADtiM1EsKzU5sH
         CNQQN+puNLYcVyJ+gS6g0ylCPWw/pb0qao085ebZ7ugsE3WO4bzvQAdsbpFtqv/tRkc6
         gbp/3Myl+5qGfXYWHj/0cyV0ZoHXxIXk9va4erc8oy8C2kJroyaroczPNG89Pz+bgEv5
         6jEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679511432;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziv2ovcgc/3NOuBG0+YWYfMhKDq2ZBtAkLCMMX3QtWE=;
        b=bsGuUJfsafrUAJoOTp1zazwvAOYtLup/3hDFJNTm+yBYNayTpU15bkd+2yTDVn5qwk
         z1CvqFiyVdCXHVD9059COHzWLbR+5GzYOhjkPSSUY+6RcHUiUliAt+gGtXt/yYl+XuCn
         bEfJ5+ZA68Q+Wl/P09F+0E1kV1lMjt/21GBcDoZZf6F8z4FMORDp6j4hyy99tq2pbHDz
         qGlkFZiaVIUZMa7WtCN268/VT3dp8hvAkwnrYRy2aaEJUo192ubbX6Ohg6zTdIJlmt76
         BPYT1ZumE9zEwCIfeiUIfmml0QdN89fJWELBNmU3G8QZaFhnZPXRG8OZzW5pw5299iBi
         d7SA==
X-Gm-Message-State: AO0yUKUutxAfs3+mtg/PfVNAf4YMHdLu7Q68A/PjXSWBQ3X7wkVRuB/G
        q8WYOQ6UORO3lJe8XVGucjY=
X-Google-Smtp-Source: AK7set8bE42fH1R1oGv50QRT3x9gS/sS2xnJ60wHoLpsl3YDcPHlPhDOLkQG/4Fu97XTiqchgJ3K8A==
X-Received: by 2002:a05:600c:3503:b0:3ee:598:7a9b with SMTP id h3-20020a05600c350300b003ee05987a9bmr457743wmq.11.1679511432121;
        Wed, 22 Mar 2023 11:57:12 -0700 (PDT)
Received: from lucifer.home ([2a00:23c5:dc8c:8701:1663:9a35:5a7b:1d76])
        by smtp.googlemail.com with ESMTPSA id j21-20020a05600c42d500b003ee581f37a9sm3181241wme.10.2023.03.22.11.57.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Mar 2023 11:57:11 -0700 (PDT)
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
Subject: [PATCH v7 3/4] iov_iter: add copy_page_to_iter_nofault()
Date:   Wed, 22 Mar 2023 18:57:03 +0000
Message-Id: <19734729defb0f498a76bdec1bef3ac48a3af3e8.1679511146.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679511146.git.lstoakes@gmail.com>
References: <cover.1679511146.git.lstoakes@gmail.com>
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

