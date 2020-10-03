Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD0628209E
	for <lists+linux-fsdevel@lfdr.de>; Sat,  3 Oct 2020 04:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725834AbgJCCzi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Oct 2020 22:55:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJCCzi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Oct 2020 22:55:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF90C0613E4
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Oct 2020 19:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4Q1QQFLQanTqVkXXeX8jIIAnHPnuK0SRgeGF6Gq3oPI=; b=VJWU0pHh6Xo0vZkwy7MR0uBj04
        pPag/D/1T+wRCAlfOLJxpMVQmjBrSuGqVVC7tkOXtSxula0WBpcEpQQmdh0EorBNDA2ZmmEemGgdm
        ZPGf6Q0mBu5c82Tokk86cCOViiemOCGps1nFchfMcXMP55ZyFIFhk1kDSDQ3F9vJJgMVPo8HjufuS
        z71YIEV0OhZWqwRZrgLB5MMiR+C8CRG/ob2XGGsXh5qiPk2LtNy6xpBPuzKmJxXLsLjtYk3PLwxh9
        ko6mtD9ReproWXEZwsbb0zK+dz8LTxgPkW+KZ/gpx/jqG9nMQsjdtVFLtkJwcR1HspLa4++qRqQQn
        32n89PhQ==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kOXhw-0005Um-82; Sat, 03 Oct 2020 02:55:36 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/13] fs/acct: Pass a NULL pointer to __kernel_write
Date:   Sat,  3 Oct 2020 03:55:24 +0100
Message-Id: <20201003025534.21045-4-willy@infradead.org>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We do nothing with the updated pos, so we can pass in NULL here.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 kernel/acct.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/acct.c b/kernel/acct.c
index b0c5b3a9f5af..08f0ec28d188 100644
--- a/kernel/acct.c
+++ b/kernel/acct.c
@@ -517,9 +517,7 @@ static void do_acct_process(struct bsd_acct_struct *acct)
 	 * as we could deadlock the system otherwise.
 	 */
 	if (file_start_write_trylock(file)) {
-		/* it's been opened O_APPEND, so position is irrelevant */
-		loff_t pos = 0;
-		__kernel_write(file, &ac, sizeof(acct_t), &pos);
+		__kernel_write(file, &ac, sizeof(acct_t), NULL);
 		file_end_write(file);
 	}
 out:
-- 
2.28.0

