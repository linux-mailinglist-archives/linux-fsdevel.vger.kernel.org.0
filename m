Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 944AF1D4ED1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726731AbgEONRY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgEONRE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:17:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05727C05BD1F;
        Fri, 15 May 2020 06:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=EpnkLjZqk1S3DSmVdcLM12MdJ2sgIE4S7yU2k8eu7Iw=; b=Ouac5fKOcAvAmnZMVvgIPIulHz
        DBYXu8tRuuU2a1+ObC+C8BwL0TvJlGyVB2yuMmX+Yt5T2jW2NDuiC1XnYHtaW2rmMH15oyeWPkVDd
        uWHxTwHy06J+v1q+Z7YcZmhjqG+5wkRycaYFO6Td47uoQiauEsfZWpQJH/MOutPZmGXJt7AW20Nfq
        NZU/AQg9di4fKaqnG3jm/1CZ4gb0IFH/WgWCC2yb1Aw8MlUVSooBh2QbM+UrqLwZ2kGNSKXsN0qO1
        F/QddNe1SrlYeEjhcgOYx2ZIpQmezI0VcBi2wn45FMUyqdG8I6/gQwedLDAzNeQUhpUCoCbspc1Tb
        slpHaFWA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZaD0-0005nF-Jh; Fri, 15 May 2020 13:17:02 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 30/36] mm: Support tail pages in wait_for_stable_page
Date:   Fri, 15 May 2020 06:16:50 -0700
Message-Id: <20200515131656.12890-31-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200515131656.12890-1-willy@infradead.org>
References: <20200515131656.12890-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

page->mapping is undefined for tail pages, so operate exclusively on
the head page.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 7326b54ab728..e2da7d7e93b8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2841,6 +2841,7 @@ EXPORT_SYMBOL_GPL(wait_on_page_writeback);
  */
 void wait_for_stable_page(struct page *page)
 {
+	page = compound_head(page);
 	if (bdi_cap_stable_pages_required(inode_to_bdi(page->mapping->host)))
 		wait_on_page_writeback(page);
 }
-- 
2.26.2

