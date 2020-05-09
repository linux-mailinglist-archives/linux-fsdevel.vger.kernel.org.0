Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D788E1CC594
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 01:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgEIXrO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 May 2020 19:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728752AbgEIXqB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 May 2020 19:46:01 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C584CC05BD09;
        Sat,  9 May 2020 16:46:00 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jXZAM-004iRc-O3; Sat, 09 May 2020 23:45:58 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 07/20] nvram: drop useless access_ok()
Date:   Sun, 10 May 2020 00:45:44 +0100
Message-Id: <20200509234557.1124086-7-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
References: <20200509234124.GM23230@ZenIV.linux.org.uk>
 <20200509234557.1124086-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

we are using copy_to_user()/memdup_user() anyway

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/char/nvram.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/char/nvram.c b/drivers/char/nvram.c
index 4667844eee69..8206412d25ba 100644
--- a/drivers/char/nvram.c
+++ b/drivers/char/nvram.c
@@ -232,8 +232,6 @@ static ssize_t nvram_misc_read(struct file *file, char __user *buf,
 	ssize_t ret;
 
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
 	if (*ppos >= nvram_size)
 		return 0;
 
@@ -264,8 +262,6 @@ static ssize_t nvram_misc_write(struct file *file, const char __user *buf,
 	char *tmp;
 	ssize_t ret;
 
-	if (!access_ok(buf, count))
-		return -EFAULT;
 	if (*ppos >= nvram_size)
 		return 0;
 
-- 
2.11.0

