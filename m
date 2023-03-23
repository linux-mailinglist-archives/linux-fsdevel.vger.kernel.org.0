Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC23C6C6496
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Mar 2023 11:15:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCWKPf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Mar 2023 06:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjCWKP3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Mar 2023 06:15:29 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1194319F2F;
        Thu, 23 Mar 2023 03:15:28 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r29so19807702wra.13;
        Thu, 23 Mar 2023 03:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679566526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ziv2ovcgc/3NOuBG0+YWYfMhKDq2ZBtAkLCMMX3QtWE=;
        b=q71TRgMaiJhexb4rt9K6K/OJXB+xp2xMvihLfEQSyx92J+vcfBnKnPXLHd1HxY+Jkh
         fylGKmF703YaOMD430/wzE2YVyB/toaRNiNVbr9xNt1ushLgX7U8X6EWfC7giBMjdd3A
         QXbJXhtqmS/cNRUAe5OtLLDmT/jhP5iNMIcVmfToX2nFjnziIra8o0oqX0SPd5mdlBvo
         s7byAuwRvXRdFSvpzjpYzFYWDE8ZDnUc/S4DsfwvwNsHx4H9uXjgvTyptRBwa0AgmqkG
         4txxsONgFqFC4qRe5uOA2fEgbppYZRZHznEeqrg73PhMqjSuCGV61AMbGtfc84SQPvMv
         sobA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679566526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ziv2ovcgc/3NOuBG0+YWYfMhKDq2ZBtAkLCMMX3QtWE=;
        b=Nj6uPGH3iLSHQo8w3mpWHoW5V2LFPhOEOsIcd5OGYubt6rr2npv3qexHyKUfyOHK5+
         cWS5d+3ccDGkRYfXFPlE5e4MsjLHAmzRmkN+PpALduv0J5WA0rnj2VrKsusbT0UwpFin
         53QtaSWjiMz6ICYha1nJXugJn7i/aIg7TNds7bEjSr601zo1FnmypYoed8mQTV2ZA0Mr
         WZqHWZzeYaUK1okEKYz5iRDOF1iBlgMCdS3NpZp4IcT4VySnR3Xi9WwfiVI/myHho79K
         3lLuCF6HuO7OfEPdRhp0ox+EIdJOg/gFrfAXM6Hh4xW1HglPen80YtihEz46QfTvI53+
         OMZQ==
X-Gm-Message-State: AAQBX9cX7orPE+/ec8DU0SraNRhOFmhAk5rLEwuQ/EbuoStO8OmEjbxr
        JWsiXervKELJLiK+J0aX+G8=
X-Google-Smtp-Source: AKy350ZF32A8g3SpKgBLxf2F/F30nUWdXSvk0BtRiQ25SfSbpeVUfcurgkUToqQZN9wTmKBO9ILEMQ==
X-Received: by 2002:adf:f30a:0:b0:2dc:c45:faf6 with SMTP id i10-20020adff30a000000b002dc0c45faf6mr794519wro.51.1679566526457;
        Thu, 23 Mar 2023 03:15:26 -0700 (PDT)
Received: from lucifer.home (host86-156-84-164.range86-156.btcentralplus.com. [86.156.84.164])
        by smtp.googlemail.com with ESMTPSA id f18-20020a05600c155200b003ede2c59a54sm1416952wmg.37.2023.03.23.03.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 03:15:25 -0700 (PDT)
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
Subject: [PATCH v8 3/4] iov_iter: add copy_page_to_iter_nofault()
Date:   Thu, 23 Mar 2023 10:15:18 +0000
Message-Id: <19734729defb0f498a76bdec1bef3ac48a3af3e8.1679566220.git.lstoakes@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1679566220.git.lstoakes@gmail.com>
References: <cover.1679566220.git.lstoakes@gmail.com>
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

