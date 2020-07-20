Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632F02269D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Jul 2020 18:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732136AbgGTP7K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Jul 2020 11:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732127AbgGTP7I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:59:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF1BC061794;
        Mon, 20 Jul 2020 08:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wH1km2ojPC19iQ5ljU6mKThZqRhQ0p6SNiSca9bvcb4=; b=ragr2qUYABEngfygXGZqb8ZnM0
        yhbkiW5TKV6WWYluat9zuI7JpscuFj/2xPIGQwaG8Jh4rC83L4qD+4+oMlrMW9JmuO1zcizt0hj6e
        gd+DivP8iaenwZv8HQWe0pj16vPSvXR1+gdlLUOb2DqSfSfSPwLKsDRq8cpgzMbB+WUfFA55E7Gl5
        SKdWXmekWSmLXqxqViJgJUc/7jm4ljuBjLE1zZNyB2pTEVWqr8O8TDCaORM4dJgLmRvwRYtv272AH
        Z+bfZCn2SeApfZCWhObEM4woQUwlQMuxhKAQIazTU5FiUVX1M7rfvxaqRfN31Hf/a0wVoxtsndG75
        OewVjeAA==;
Received: from [2001:4bb8:105:4a81:db56:edb1:dbf2:5cc3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxYC0-0007md-NU; Mon, 20 Jul 2020 15:59:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 01/24] init: initialize ramdisk_execute_command at compile time
Date:   Mon, 20 Jul 2020 17:58:39 +0200
Message-Id: <20200720155902.181712-2-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720155902.181712-1-hch@lst.de>
References: <20200720155902.181712-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Set ramdisk_execute_command to "/init" at compile time.  The command
line can still override it, but this saves a few instructions and
removes a NULL check.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 init/main.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index db0621dfbb0468..c2c9143db96795 100644
--- a/init/main.c
+++ b/init/main.c
@@ -154,7 +154,7 @@ static bool initargs_found;
 #endif
 
 static char *execute_command;
-static char *ramdisk_execute_command;
+static char *ramdisk_execute_command = "/init";
 
 /*
  * Used to generate warnings if static_key manipulation functions are used
@@ -1514,10 +1514,6 @@ static noinline void __init kernel_init_freeable(void)
 	 * check if there is an early userspace init.  If yes, let it do all
 	 * the work
 	 */
-
-	if (!ramdisk_execute_command)
-		ramdisk_execute_command = "/init";
-
 	if (ksys_access((const char __user *)
 			ramdisk_execute_command, 0) != 0) {
 		ramdisk_execute_command = NULL;
-- 
2.27.0

