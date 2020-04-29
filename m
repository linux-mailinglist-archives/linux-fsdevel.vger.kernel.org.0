Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0D51BDE27
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 15:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgD2Nhl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 09:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbgD2NhB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 09:37:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE717C03C1AE;
        Wed, 29 Apr 2020 06:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=bLegsrf1DhSkc7w1f1NHk29akaQzX/hYK/HqXtMKqBY=; b=D/NhGevB1GCZkpjQ5e/LyIzhLa
        MiCHOSb2ZqRew0WiSYEp6RelJc/meuYuQ5BKuBvt4AsHoF2mYVMVBVYW9fSVTMN24WRm4ZL707JqM
        S9juOe2bWgsJ1km49tzmMVdnbOCLbdw0oJSsYZ8wowk6q7syX3+ZRV4UL6Hh/yIjNbCe0H4MAiL1S
        h3eqQ3ClygNYMAm6rlUqANJD8gOdzEuYhz6LGqut5C4c56wfeJjAN7ILxjitlYyaWc4vHQYoGrljq
        AJUV0zjZzknj+w64+fKBcMiJoIekzy9zw+cSYQcPoLXKaO1SBzcqPHCZuBo6wfP46o7pbMFsvfCv7
        O7gxEpHQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTmtX-0005wI-Pq; Wed, 29 Apr 2020 13:36:59 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 19/25] mm: Allow large pages to be removed from the page cache
Date:   Wed, 29 Apr 2020 06:36:51 -0700
Message-Id: <20200429133657.22632-20-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200429133657.22632-1-willy@infradead.org>
References: <20200429133657.22632-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

page_cache_free_page() assumes compound pages are PMD_SIZE; fix
that assumption.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 842afee3d066..8c174e6064d4 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -248,7 +248,7 @@ static void page_cache_free_page(struct address_space *mapping,
 		freepage(page);
 
 	if (PageTransHuge(page) && !PageHuge(page)) {
-		page_ref_sub(page, HPAGE_PMD_NR);
+		page_ref_sub(page, hpage_nr_pages(page));
 		VM_BUG_ON_PAGE(page_count(page) <= 0, page);
 	} else {
 		put_page(page);
-- 
2.26.2

