Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13A1C22DCD9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Jul 2020 09:15:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbgGZHPh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 Jul 2020 03:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgGZHOL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 Jul 2020 03:14:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D604C0619D2;
        Sun, 26 Jul 2020 00:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=wH1km2ojPC19iQ5ljU6mKThZqRhQ0p6SNiSca9bvcb4=; b=V0fMxFu/0VNxrPNwteA7uYcULW
        cCHPuDsdTokcNv0XCQjqoNxI0g9r1xe/LDruU/3YARx+BDs+uFffuCPADxWpms+TTYuJlOycbuKCk
        7+UPYFA3htZUyt/JA79OXkQ4FsGb33SZ3n3mu/PSQWnfRFocGlmjqsmX+n4qAEisxTufK/OIB1ytM
        aIOtDh8uS7PxfAeXeEYcSaOvz+k+oTVOW/vdATXqEoJgbIrrDPgjJIilTBwnbyT0vz28Jp9BfwGOI
        bCRgVdQQSyqM1zsqEPPYVB7FRlv5qPpr2CjwC+kQcLGtMTiyN/SQ/5R/BJivGd0XX/P/7DPRhyAlo
        TiqesjPQ==;
Received: from [2001:4bb8:18c:2acc:5ff1:d0b0:8643:670e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzarI-0002P0-0A; Sun, 26 Jul 2020 07:14:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH 05/21] init: initialize ramdisk_execute_command at compile time
Date:   Sun, 26 Jul 2020 09:13:40 +0200
Message-Id: <20200726071356.287160-6-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200726071356.287160-1-hch@lst.de>
References: <20200726071356.287160-1-hch@lst.de>
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

