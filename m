Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF986139508
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 16:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAMPiA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 10:38:00 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57848 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728787AbgAMPhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 10:37:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vLB2jRQV91vKQomphjORNZkEWBxCp59XHq5vnywYunQ=; b=bVGbFhVMMT+7TVZGCO2aflgl8H
        O8Z4R/lI3cOpP/TzqMnwKTMOOkltgN2B5Vj2gd+AZqUmlOpANyZy/enEkr8308SQEZhXHi1PzN9uv
        eja1wuOO7oYjbUtnO29PI4gX+9j9P9fcbBGXBp35l2/NsL/H/Ila+Er32x4iGNBNdAkFuUqDKNppq
        6JtacCHZo/d3EcmdCE4sVkRfmQTjYW91ywNs+Emooh4ZnU2s4kePsHhAOoLT6+8NYtLcNHfkK6K+h
        tBRVJivAofvygLZwAL+cWVvYkAbLi12vsApT4qx0DB3F5uFLeY0rS3NrJEM5+B42VuKSBzrjXLHRj
        BYkqKLng==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ir1mr-00075a-1j; Mon, 13 Jan 2020 15:37:53 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        jlayton@kernel.org, hch@infradead.org
Subject: [PATCH 1/8] pagevec: Add an iterator
Date:   Mon, 13 Jan 2020 07:37:39 -0800
Message-Id: <20200113153746.26654-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200113153746.26654-1-willy@infradead.org>
References: <20200113153746.26654-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

There's plenty of space in the pagevec for a loop counter, and
that will come in handy later.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagevec.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/include/linux/pagevec.h b/include/linux/pagevec.h
index 081d934eda64..9b8c43661ab3 100644
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@ -19,6 +19,7 @@ struct address_space;
 
 struct pagevec {
 	unsigned char nr;
+	unsigned char first;
 	bool percpu_pvec_drained;
 	struct page *pages[PAGEVEC_SIZE];
 };
@@ -55,12 +56,14 @@ static inline unsigned pagevec_lookup_tag(struct pagevec *pvec,
 static inline void pagevec_init(struct pagevec *pvec)
 {
 	pvec->nr = 0;
+	pvec->first = 0;
 	pvec->percpu_pvec_drained = false;
 }
 
 static inline void pagevec_reinit(struct pagevec *pvec)
 {
 	pvec->nr = 0;
+	pvec->first = 0;
 }
 
 static inline unsigned pagevec_count(struct pagevec *pvec)
@@ -88,4 +91,21 @@ static inline void pagevec_release(struct pagevec *pvec)
 		__pagevec_release(pvec);
 }
 
+static inline struct page *pagevec_last(struct pagevec *pvec)
+{
+	if (pvec->nr == 0)
+		return NULL;
+	return pvec->pages[pvec->nr - 1];
+}
+
+static inline struct page *pagevec_next(struct pagevec *pvec)
+{
+	if (pvec->first >= pvec->nr)
+		return NULL;
+	return pvec->pages[pvec->first++];
+}
+
+#define pagevec_for_each(pvec, page)	\
+	while ((page = pagevec_next(pvec)))
+
 #endif /* _LINUX_PAGEVEC_H */
-- 
2.24.1

