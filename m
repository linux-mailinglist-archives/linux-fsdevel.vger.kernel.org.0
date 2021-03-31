Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3C13506EC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbhCaSyE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbhCaSxg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:53:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DFF3C061574;
        Wed, 31 Mar 2021 11:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=nVyXR6HRjLgu3KkaVohlQVN86exh8AV6iRsShfPIk6Y=; b=uiGvyaj+PWljHx/9rLlLwe7+xF
        vG/ae1A+9GMCVFrNucOB4Jg872lTaABHUfEC+PYyKVmCuhFbA/NlaMVnqRXlFirYmcPrpGq7VYube
        Yw5ccBPGnBHb+P6KYNvy0GvWx1nvNqcZifomeSwngNKuMbTN2Z5/5EdJ8zA2mh3sERFzAIGTImOsz
        U6zif4YDUChrW1NxPxZROPASaDYk20a8kFy4EFNXZEhZtUwdTJ8U4NQWHbi/AVLtJidE5IpA/T6ex
        RvT7GZLbZrBtlEUHEoS82+ZaKD+GsJYwajfgpf3xOJMbAc/ZJr2OtxfJYUCpd0KiDi97W0bgW1Rm7
        q0SPdpTA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfx7-004zYl-H7; Wed, 31 Mar 2021 18:52:44 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 14/27] mm: Add folio_mapcount
Date:   Wed, 31 Mar 2021 19:47:15 +0100
Message-Id: <20210331184728.1188084-15-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the folio equivalent of page_mapcount().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index a4f2818aeb1d..fc15a256e686 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -869,6 +869,22 @@ static inline int page_mapcount(struct page *page)
 	return atomic_read(&page->_mapcount) + 1;
 }
 
+/**
+ * folio_mapcount - The number of mappings of this folio.
+ * @folio: The folio.
+ *
+ * The result includes the number of times any of the pages in the
+ * folio are mapped to userspace.
+ *
+ * Return: The number of page table entries which refer to this folio.
+ */
+static inline int folio_mapcount(struct folio *folio)
+{
+	if (unlikely(FolioMulti(folio)))
+		return __page_mapcount(&folio->page);
+	return atomic_read(&folio->_mapcount) + 1;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 int total_mapcount(struct page *page);
 int page_trans_huge_mapcount(struct page *page, int *total_mapcount);
-- 
2.30.2

