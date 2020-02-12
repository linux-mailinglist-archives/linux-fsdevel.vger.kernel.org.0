Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7B2915A004
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgBLET5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:19:57 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbgBLESr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=NvMfSbwCSPQiuZsVqZ+gREFLXJWQ8lHxQALsTybal28=; b=dkvEEjgLlJHt5AUjH/hWPpXsBM
        lvuxoe/UOq8JMvoe4+4d2BIvo6eOU/p/MgXsXq4YB7gYbXgFFo0Mu5apYDAh2dsrW5vd4BgV6XZJE
        YAFMVpJO0SUtPSCPR1Ykw3uoryiy98Elgl14DBpGG6bYlMS6ug+xx/vw5p4m8wSxkDae6nxACaB50
        JyFVlMdaM6MyG1iN+HegUPoASXD8Q2wsxrpX0158WABia1lrxdNI7Zpo0FAGwy6cRUJgzoU5k4yox
        Br/r/CtwEdK8t6TEE56VC4g60V3GKDvaqMOHo24Eom5/5TB54IhcZiwEx+OLv0zJDjDwU+OoEiizA
        j5WW+MTw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU7-0006nq-13; Wed, 12 Feb 2020 04:18:47 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/25] fs: Add zero_user_large
Date:   Tue, 11 Feb 2020 20:18:33 -0800
Message-Id: <20200212041845.25879-14-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200212041845.25879-1-willy@infradead.org>
References: <20200212041845.25879-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

We can't kmap() a THP, so add a wrapper around zero_user() for large
pages.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/highmem.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index ea5cdbd8c2c3..4465b8784353 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -245,6 +245,28 @@ static inline void zero_user(struct page *page,
 	zero_user_segments(page, start, start + size, 0, 0);
 }
 
+static inline void zero_user_large(struct page *page,
+		unsigned start, unsigned size)
+{
+	unsigned int i;
+
+	for (i = 0; i < thp_order(page); i++) {
+		if (start > PAGE_SIZE) {
+			start -= PAGE_SIZE;
+		} else {
+			unsigned this_size = size;
+
+			if (size > (PAGE_SIZE - start))
+				this_size = PAGE_SIZE - start;
+			zero_user(page + i, start, this_size);
+			start = 0;
+			size -= this_size;
+			if (!size)
+				break;
+		}
+	}
+}
+
 #ifndef __HAVE_ARCH_COPY_USER_HIGHPAGE
 
 static inline void copy_user_highpage(struct page *to, struct page *from,
-- 
2.25.0

