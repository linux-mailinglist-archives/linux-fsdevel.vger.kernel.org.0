Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6168F16B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Feb 2023 15:56:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjBHO4d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Feb 2023 09:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230178AbjBHO43 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Feb 2023 09:56:29 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA3F212B3;
        Wed,  8 Feb 2023 06:56:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=baZ/nm5e+R3XpfQTMaFkd+YUn4nTSX5Qn+q+GEDnUZo=; b=Gx5CVRVtkXGKd05GkNug9twl21
        3Yfy4xwVgLapq4T07IKuCqXyQ/xIoSY6UQ4BQLUR8utAE97rmLAQ2CHuXDZVdEllbJHNJg7UDEPcb
        LA3is5r4btsWGjLgp3Vza9VfjjfZ5WPW62mgxbQsW9k1VuAVCdwFsNFoCEKvmqdDwuWcHaA2mNmDp
        6pwQQpwU5kcZfl5LqI3QUATioxNPHwuWXXxAF9CjI0buFVcvDpWxUCkYCuw4sAn58nellOtfxi/JG
        JYO6qJ/cfcDsRA8sHH+6gLaYdZ83R6JVkid+OcotN45MCdl2HqzO4gs3NM4B1mLKTJpkbds4kpMlK
        pp2+c+HQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pPlrp-001I3K-Hd; Wed, 08 Feb 2023 14:56:13 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 2/2] filemap: Remove lock_page_killable()
Date:   Wed,  8 Feb 2023 14:56:11 +0000
Message-Id: <20230208145611.307706-3-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230208145611.307706-1-willy@infradead.org>
References: <20230208145611.307706-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There are no more callers; remove this function before any more appear.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/pagemap.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index cf0677419981..51b75b89730e 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -993,16 +993,6 @@ static inline int folio_lock_killable(struct folio *folio)
 	return 0;
 }
 
-/*
- * lock_page_killable is like lock_page but can be interrupted by fatal
- * signals.  It returns 0 if it locked the page and -EINTR if it was
- * killed while waiting.
- */
-static inline int lock_page_killable(struct page *page)
-{
-	return folio_lock_killable(page_folio(page));
-}
-
 /*
  * folio_lock_or_retry - Lock the folio, unless this would block and the
  * caller indicated that it can handle a retry.
-- 
2.35.1

