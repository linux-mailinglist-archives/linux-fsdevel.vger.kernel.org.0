Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C5DB1F5CAB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 22:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730828AbgFJUPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 16:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730570AbgFJUNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 16:13:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12BAC008637;
        Wed, 10 Jun 2020 13:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=GNlEMLfntSDE532epxm8/a2szgwh2sOQWwXDZZAut5w=; b=n3ImGHOjuUO9zIU7NnGb9iTHx7
        4sa3MibmY3FJdosztsimDOYfZBl7yLld3xeEzyDKGf83WLEqWZVZJxZu2jmNx8zRWYx9KhGV7wbbF
        GG1x0oC9vXRPN2ZaoPXK8/UEnBq2vRmLPg1Do8sL33L6iw+BCGAL5T3kwxZ+FVjMmoLWIjwwzUqL6
        jKLdsn4yqyECBldoeveUcK/HHHx8DYtHYp0GVmX27vajxTxTGs/ODW+C8yNUl1wX7zQFpU8a/Bved
        ZENUz3vpikMfHQ4JuWtOClDmFfmnMUOoVzt3nUHS4qrhnrfp6HLTRIGDX6QzIbPyVxkQ+B42qF1ke
        HkEiZzhw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jj76a-0003Wn-Nc; Wed, 10 Jun 2020 20:13:48 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 36/51] mm: Allow THPs to be removed from the page cache
Date:   Wed, 10 Jun 2020 13:13:30 -0700
Message-Id: <20200610201345.13273-37-willy@infradead.org>
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

page_cache_free_page() assumes THPs are PMD_SIZE; fix that assumption.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index ab9746aff766..78f888d028c5 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -248,7 +248,7 @@ static void page_cache_free_page(struct address_space *mapping,
 		freepage(page);
 
 	if (PageTransHuge(page) && !PageHuge(page)) {
-		page_ref_sub(page, HPAGE_PMD_NR);
+		page_ref_sub(page, thp_nr_pages(page));
 		VM_BUG_ON_PAGE(page_count(page) <= 0, page);
 	} else {
 		put_page(page);
-- 
2.26.2

