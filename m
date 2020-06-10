Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6991F5CA2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbgFJUPE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730583AbgFJUNw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:52 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE77C00863E;
        Wed, 10 Jun 2020 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=hjtxBqocMNhYkpp8Xg/ALyMhtyMIq4PqDFO3IKqKJpw=; b=oDy2sEk0C4TA1UDvwaLLIZI1pR
        JOfaoKJP5U4cmw6dzVSzyT3+5dHoqA5/I+266eum7s4YMxumC41j4BEMSKdVFxg0rqbQ8EbzxBcW0
        tmcsUU+gXd4itwdzOvXJ5v/MZm8kd3gIKt+aNO9QygBxeQtig1m/7iTG4ECvpESE77noHDK+IW6z/
        RWTDg2rHeESxtEQ+zT5ERB5MxcdUm10gFtU4uXzT6dJeOzmjFm7ALjQgKjbnjA3BIGOttq2nL0j8H
        Ol3SEWEzBDX1QHTfee6yb1WHMFl6UnuTzt1vzj5CoH3AmzGf6wiJnf5AqBFcKttjctcP7bhSRSrfN
        QhauW/9Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76b-0003Xr-3g; Wed, 10 Jun 2020 20:13:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 45/51] mm: Support tail pages in wait_for_stable_page
Date:   Wed, 10 Jun 2020 13:13:39 -0700
Message-Id: <20200610201345.13273-46-willy@infradead.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200610201345.13273-1-willy@infradead.org>
References: <20200610201345.13273-1-willy@infradead.org>
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
index 28b3e7a67565..1b358aac065f 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2851,6 +2851,7 @@ EXPORT_SYMBOL_GPL(wait_on_page_writeback);
  */
 void wait_for_stable_page(struct page *page)
 {
+	page = thp_head(page);
 	if (bdi_cap_stable_pages_required(inode_to_bdi(page->mapping->host)))
 		wait_on_page_writeback(page);
 }
-- 
2.26.2

