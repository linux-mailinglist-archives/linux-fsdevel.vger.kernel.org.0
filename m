Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7031373E8A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 May 2021 17:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhEEPbb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 May 2021 11:31:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbhEEPba (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 May 2021 11:31:30 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644EDC061574;
        Wed,  5 May 2021 08:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9rtODSmIJKR20NHLM752dZ31YbLyr/X1zRcMNs06Ph8=; b=pw1HMHjun7e/I5M+pb65knSSs8
        MxzYSe6T4H4roEgCUIeUZvLYzRmFx8iNUapKyzXzhJqtXJI0A0d0VMMmOZGCR30uKhxxCoZK24W5S
        /rQVnApjLPqSOd27MWe+s3dJ1iiYop72Zks/9SLLELMjVnQZMqcdZe4OpSyxeKAss61ZoAuEFxgKx
        qBtDyWz+8Bx6wR8Zpz6E5miVx9a4AjGtXWe2PdChqYwhb9VzQfLpz3ddK+4n8BLxGgxtNZy8aC+xp
        t6vIIxWHqF2sp23cXqoayatzq10nq7PGi0Gi/tkY3OVkW4sojAKJuujKglccf8qOrxV+ERMFB6g+U
        i11LZbng==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1leJRj-000V70-0R; Wed, 05 May 2021 15:28:37 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jeff Layton <jlayton@kernel.org>
Subject: [PATCH v9 20/96] mm/filemap: Add folio_next_index
Date:   Wed,  5 May 2021 16:05:12 +0100
Message-Id: <20210505150628.111735-21-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210505150628.111735-1-willy@infradead.org>
References: <20210505150628.111735-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This helper returns the page index of the next folio in the file (ie
the end of this folio, plus one).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jeff Layton <jlayton@kernel.org>
---
 include/linux/pagemap.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index fdb319928781..5ccc73c760b1 100644
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

