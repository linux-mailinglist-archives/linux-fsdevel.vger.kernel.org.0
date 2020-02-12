Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B52FC15A00F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 05:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgBLEUS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Feb 2020 23:20:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:53880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbgBLESq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Feb 2020 23:18:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=1UKSv/uR1gizoUM2UndkwewM2cMbtXFX9L0k4TgJeuY=; b=R3nxxPSWtj03IZA6Q60snyIzPC
        GEXcItmVPJlJHpYTVYajKyGL+Oah/pLRMZoM0pxNVjAmV17PEmygBknVi6eaUTjjKoN9cpq4+JHXL
        RL1UbPTwnKrsk8GpNs8cRGurbpDDDUdN3l81jSG+bIPO5ZbdY7TCErTlS6AdU1B8FLHKB17Xe3ARX
        +aT0Jn9aCjuKj/9UzBhjJdNoBuCU8PsSWEVj2v1aZQiKQVHYA2abifN36GqiA25Zw1l7OsXPbSN3+
        fEL/2JM3lAN5lWKlWRJNGCA+CDJ3KnkVMySNLAc80+BzEgDx27JeWSIwm+clccZuD90m53fWyXXjY
        D2CNc58w==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j1jU6-0006mU-JQ; Wed, 12 Feb 2020 04:18:46 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 03/25] mm: Use VM_BUG_ON_PAGE in clear_page_dirty_for_io
Date:   Tue, 11 Feb 2020 20:18:23 -0800
Message-Id: <20200212041845.25879-4-willy@infradead.org>
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

Dumping the page information in this circumstance helps for debugging.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 2caf780a42e7..9173c25cf8e6 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2655,7 +2655,7 @@ int clear_page_dirty_for_io(struct page *page)
 	struct address_space *mapping = page_mapping(page);
 	int ret = 0;
 
-	BUG_ON(!PageLocked(page));
+	VM_BUG_ON_PAGE(!PageLocked(page), page);
 
 	if (mapping && mapping_cap_account_dirty(mapping)) {
 		struct inode *inode = mapping->host;
-- 
2.25.0

