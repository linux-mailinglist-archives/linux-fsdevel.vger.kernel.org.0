Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E48290936
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Oct 2020 18:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410579AbgJPQE5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Oct 2020 12:04:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410568AbgJPQE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Oct 2020 12:04:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8575C0613DB
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Oct 2020 09:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=GW1YniPzUpda1PIsi2+AeQMOnKxd544xKFcJ+bcv5fM=; b=K7eCJ07RGw8arkwgdNQlSnFq2d
        h58I6X6KM/kN3gsXkDv8ux5v0KW2AdOMDbxEYqWMRa2akXqD1y7uxOqSSE3mbOQiQP5XubA1bTI9d
        5QhNLeLpvS5ZSpLhxDD6q7m+bunICgdybQ5RkJLfRivaOkc7VsVkKt579lLY/VLYfLufn1SXfuODI
        MpDLjJQF6BqojsFDzeUzHOKrttAlZTfqm4uY5ds92AkkILMEcF0HDAE95ByBWgPnyVSek8g10QYfu
        BRkDeEIxHLIOFAT/tp5BZU/4KHfxkHkOOn9rCVq0R8OwtkBguJR8VN07wr++Djct1xBbqq68FQVQZ
        Ru/VSt/A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kTSDo-0004tr-WB; Fri, 16 Oct 2020 16:04:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-mm@kvack.org, Richard Weinberger <richard@nod.at>
Subject: [PATCH v3 14/18] hostfs: Tell the VFS that readpage was synchronous
Date:   Fri, 16 Oct 2020 17:04:39 +0100
Message-Id: <20201016160443.18685-15-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201016160443.18685-1-willy@infradead.org>
References: <20201016160443.18685-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The hostfs readpage implementation was already synchronous, so use
AOP_UPDATED_PAGE to avoid cycling the page lock.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 fs/hostfs/hostfs_kern.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index c070c0d8e3e9..c49221c09c4b 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -455,6 +455,8 @@ static int hostfs_readpage(struct file *file, struct page *page)
  out:
 	flush_dcache_page(page);
 	kunmap(page);
+	if (!ret)
+		return AOP_UPDATED_PAGE;
 	unlock_page(page);
 	return ret;
 }
-- 
2.28.0

