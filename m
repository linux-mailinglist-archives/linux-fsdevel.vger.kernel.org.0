Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 639C64AFE5F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Feb 2022 21:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbiBIUXk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Feb 2022 15:23:40 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbiBIUWb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Feb 2022 15:22:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47276E040DCB
        for <linux-fsdevel@vger.kernel.org>; Wed,  9 Feb 2022 12:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=lgLr7F4mCaZa5dhEiQnpGpr7GukvUZ+mdxjqS4eDkXY=; b=dL8Ia+yK5JSWvbrQAxQfdvEgrM
        qymp+83rjMDveZrYpCwOJ3n2EV3TG+hmNzONgdwCjlXyKYaLdeb7fQrACLZkSMu6onmAGQVK2SuOr
        AtVebBgKuQ8u4bNktKBzJXjmHX4kB9BSZxvZOj5kIPkm7htjeRR8m+HzkzAYC6J5BAFayIENPvmAJ
        bFFD67Qc4hHOi9xVKiCADXHY/TYQSdCCjIasnMobXS6eky8eo9qllBsiAiJLKp8CAdtsQ7rnZIlPP
        P+Cztx8ssX3XvccVhRkkVv679P43bpi0euxqjzSsD85wBEi3rGEEBkjnxVks8UBtfjiGk14yNgu8l
        cAYWLhFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHtTx-008ctr-L2; Wed, 09 Feb 2022 20:22:29 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 55/56] fb_defio: Use noop_dirty_folio()
Date:   Wed,  9 Feb 2022 20:22:14 +0000
Message-Id: <20220209202215.2055748-56-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220209202215.2055748-1-willy@infradead.org>
References: <20220209202215.2055748-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the custom implementation of set_page_dirty.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 drivers/video/fbdev/core/fb_defio.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index a591d291b231..d0b0b05e0dff 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -151,15 +151,8 @@ static const struct vm_operations_struct fb_deferred_io_vm_ops = {
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
 
-static int fb_deferred_io_set_page_dirty(struct page *page)
-{
-	if (!PageDirty(page))
-		SetPageDirty(page);
-	return 0;
-}
-
 static const struct address_space_operations fb_deferred_io_aops = {
-	.set_page_dirty = fb_deferred_io_set_page_dirty,
+	.dirty_folio	= noop_dirty_folio,
 };
 
 int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
-- 
2.34.1

