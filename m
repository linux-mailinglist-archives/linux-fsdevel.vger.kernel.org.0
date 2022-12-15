Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A664E365
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Dec 2022 22:44:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiLOVoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Dec 2022 16:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiLOVoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Dec 2022 16:44:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20493396F9
        for <linux-fsdevel@vger.kernel.org>; Thu, 15 Dec 2022 13:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=Dcm9/6g8BjFdXRPPxqIgd6WNImoV7y2C+AwRujEkEmY=; b=dq6sFbWRNpiuCWX5hHsKqpaIwk
        ZTaXLpEVMzKRxs5aiYPw4kQahQnup9T9OPEm1avIbxlmBvNaAg3agJs7hVXuaO8IfBWUAIkfd1Ae7
        w82ykPwzxFBckW7CQ05zKyCpmPWE+Tp0weqpz9dI6mbeepSSbgmCEO3mVvoZ/srb5EOZpjfGe7iC6
        uHAlTphrV35D0jtuw96yjdOjGI8o1qAYUE32wJJnjt0XDRRtpw9w6eEiRhnBDHos09l/XnU5rLIZl
        /0Vn5mzYmu0D/8ylsbNOevqX4iO7UuTGVQRJ+VEBGc8faQDUa3KRvLR8AJsGkt8A1y3Ds36gMgBwR
        S+sH3TmA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1p5w1O-00EmLK-DE; Thu, 15 Dec 2022 21:44:06 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/12] buffer: Use b_folio in touch_buffer()
Date:   Thu, 15 Dec 2022 21:43:53 +0000
Message-Id: <20221215214402.3522366-4-willy@infradead.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221215214402.3522366-1-willy@infradead.org>
References: <20221215214402.3522366-1-willy@infradead.org>
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

Removes a call to compound_head() in this path.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index e1055fe0b366..8a02fdaeec9a 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -60,7 +60,7 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
 inline void touch_buffer(struct buffer_head *bh)
 {
 	trace_block_touch_buffer(bh);
-	mark_page_accessed(bh->b_page);
+	folio_mark_accessed(bh->b_folio);
 }
 EXPORT_SYMBOL(touch_buffer);
 
-- 
2.35.1

