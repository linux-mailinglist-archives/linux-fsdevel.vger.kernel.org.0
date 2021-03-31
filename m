Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 731EE3506D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Mar 2021 20:53:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbhCaSw2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Mar 2021 14:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbhCaSwK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Mar 2021 14:52:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E674FC06174A;
        Wed, 31 Mar 2021 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=J9McjwmMfYw4xRYFCKHIFxwFXE7/kt39jJTAhXblis8=; b=WMzDYFuT6QIGU46/aq0G+JNuNm
        rYxWWMKold9NpNzv+COe+HMa4XhYRbBjH++3KjJLZFp/HHbuvU5vzNDMj2vo26tPVlnnT7Z0vcf22
        YDHghd8sK8EWi5ns/4Yi8g+1MmafgaosW97wJmXL5JGH6rQFTGIx+3AGUigJnBnt1EI8MGwH1u1Dq
        vfwK2vV/vKlhg8RBzEXSTpodclj9O+WuLBhoJ7gcSATQnyvKylBit8HpQoKQR3ojsCLBlURouUF8l
        9yW3cn8Y3S4fDDoRUfJx4WU7xsox5XqnC978ArWE1dUd0MyOf37Wt4dJbKRQsA93FSX9BaPMCmnId
        /HLFC98w==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lRfvz-004zUL-KU; Wed, 31 Mar 2021 18:51:27 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org
Subject: [PATCH v6 11/27] mm/filemap: Add folio_next_index
Date:   Wed, 31 Mar 2021 19:47:12 +0100
Message-Id: <20210331184728.1188084-12-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210331184728.1188084-1-willy@infradead.org>
References: <20210331184728.1188084-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper returns the page index of the next folio in the file (ie
the end of this folio, plus one).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 6749c47d3c33..3aefe6558f7d 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -482,6 +482,17 @@ static inline pgoff_t folio_index(struct folio *folio)
         return folio->index;
 }
 
+/**
+ * folio_next_index - Get the index of the next folio.
+ * @folio: The current folio.
+ *
+ * Return: The index of the folio which follows this folio in the file.
+ */
+static inline pgoff_t folio_next_index(struct folio *folio)
+{
+	return folio->index + folio_nr_pages(folio);
+}
+
 /**
  * folio_file_page - The page for a particular index.
  * @folio: The folio which contains this index.
-- 
2.30.2

