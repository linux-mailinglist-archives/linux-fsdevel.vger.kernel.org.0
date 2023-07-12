Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D16B75124D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Jul 2023 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232760AbjGLVMC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Jul 2023 17:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjGLVLk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Jul 2023 17:11:40 -0400
Received: from out-24.mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A51E1FDA
        for <linux-fsdevel@vger.kernel.org>; Wed, 12 Jul 2023 14:11:33 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1689196292;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VDLK1ONggBB+eFfykVjGTBwfVG7SE70wyxw3cDrS9g4=;
        b=nT353abG+gbYP6wNNp6mG4LtZUQRLG3e0cPhL1rQKv2kf3gbONxLaGbqeV3CzmCE0QZL67
        VUDWogb/VvrW+h5sxU9GWjtZp5r01ye1GW3+eEZ/HLw2o6WAprjFLVvqgeJaGqyLLKxSSk
        mMD13c0PBmafrfMPWBAUk6sz4OJS+VY=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH 03/20] iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()
Date:   Wed, 12 Jul 2023 17:10:58 -0400
Message-Id: <20230712211115.2174650-4-kent.overstreet@linux.dev>
In-Reply-To: <20230712211115.2174650-1-kent.overstreet@linux.dev>
References: <20230712211115.2174650-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

copy_page_from_iter_atomic() already handles !highmem compound
pages correctly, but if we are passed a highmem compound page,
each base page needs to be mapped & unmapped individually.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 lib/iov_iter.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 960223ed91..f9c4bba272 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -857,24 +857,37 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_zero);
 
-size_t copy_page_from_iter_atomic(struct page *page, unsigned offset, size_t bytes,
-				  struct iov_iter *i)
+size_t copy_page_from_iter_atomic(struct page *page, unsigned offset,
+		size_t bytes, struct iov_iter *i)
 {
-	char *kaddr = kmap_atomic(page), *p = kaddr + offset;
-	if (!page_copy_sane(page, offset, bytes)) {
-		kunmap_atomic(kaddr);
+	size_t n, copied = 0;
+
+	if (!page_copy_sane(page, offset, bytes))
 		return 0;
-	}
-	if (WARN_ON_ONCE(!i->data_source)) {
-		kunmap_atomic(kaddr);
+	if (WARN_ON_ONCE(!i->data_source))
 		return 0;
-	}
-	iterate_and_advance(i, bytes, base, len, off,
-		copyin(p + off, base, len),
-		memcpy_from_iter(i, p + off, base, len)
-	)
-	kunmap_atomic(kaddr);
-	return bytes;
+
+	do {
+		char *p;
+
+		n = bytes - copied;
+		if (PageHighMem(page)) {
+			page += offset / PAGE_SIZE;
+			offset %= PAGE_SIZE;
+			n = min_t(size_t, n, PAGE_SIZE - offset);
+		}
+
+		p = kmap_atomic(page) + offset;
+		iterate_and_advance(i, n, base, len, off,
+			copyin(p + off, base, len),
+			memcpy_from_iter(i, p + off, base, len)
+		)
+		kunmap_atomic(p);
+		copied += n;
+		offset += n;
+	} while (PageHighMem(page) && copied != bytes && n > 0);
+
+	return copied;
 }
 EXPORT_SYMBOL(copy_page_from_iter_atomic);
 
-- 
2.40.1

