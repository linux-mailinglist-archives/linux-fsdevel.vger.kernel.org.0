Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 515BF74D6E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Jul 2023 15:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjGJNEy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 10 Jul 2023 09:04:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbjGJNER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 10 Jul 2023 09:04:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46AE26BD;
        Mon, 10 Jul 2023 06:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=fgATlNpbiNqq83Ojja38NAx+RR0jSyfX0XbqMlmQLy0=; b=GfIT+KlVwp0XjNATiVkrAOJPIF
        UhU4g8bxNTdo6Y3p00xDAfr3NMSSiZByaDjzJMwAHa0v0FO49eUCoPcES0Uf3p+am9iFgiT6Hrt2F
        bMX8JfVCmFBhP6bDm/zWiAMz83V981H26bIPRW/ZMhp+8UQbS7usZvs/WMOXIxb8+YVGmo6W3rS5t
        wxvYC5/8Y1i6Qdno1CzrXZJDkEtG5dzbSrJL9F4dFbPzSjDpwBM62gbEDMl+p1Jpoabt2Ki17woSI
        Rf17MY7PceKxsaDsQkkg+IZhrOBm34uY49/x5UTzk0An/OqHI8qQulR+YElWFVhB6vbxHRnCUX0wm
        d5LDVnaQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qIqXX-00EcX8-AK; Mon, 10 Jul 2023 13:02:55 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-xfs@vger.kernel.org, Wang Yugui <wangyugui@e16-tech.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Kent Overstreet <kent.overstreet@linux.dev>
Subject: [PATCH v4 1/9] iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()
Date:   Mon, 10 Jul 2023 14:02:45 +0100
Message-Id: <20230710130253.3484695-2-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230710130253.3484695-1-willy@infradead.org>
References: <20230710130253.3484695-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

copy_page_from_iter_atomic() already handles !highmem compound
pages correctly, but if we are passed a highmem compound page,
each base page needs to be mapped & unmapped individually.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 lib/iov_iter.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b667b1e2f688..c728b6e4fb18 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -566,24 +566,37 @@ size_t iov_iter_zero(size_t bytes, struct iov_iter *i)
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
2.39.2

