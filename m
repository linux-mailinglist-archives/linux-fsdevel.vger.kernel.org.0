Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35DC65E592
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 07:24:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbjAEGYA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 5 Jan 2023 01:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjAEGXw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 5 Jan 2023 01:23:52 -0500
X-Greylist: delayed 314 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 Jan 2023 22:23:51 PST
Received: from mail.nfschina.com (unknown [42.101.60.237])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3026251334;
        Wed,  4 Jan 2023 22:23:50 -0800 (PST)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 20E631A00A03;
        Thu,  5 Jan 2023 14:18:46 +0800 (CST)
X-Virus-Scanned: amavisd-new at nfschina.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (localhost.localdomain [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id b3-uxC-P4cjZ; Thu,  5 Jan 2023 14:18:45 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: zeming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 4B7FE1A0074C;
        Thu,  5 Jan 2023 14:18:45 +0800 (CST)
From:   Li zeming <zeming@nfschina.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Li zeming <zeming@nfschina.com>
Subject: [PATCH] filesystems: Simplify if conditional statements
Date:   Thu,  5 Jan 2023 14:18:31 +0800
Message-Id: <20230105061831.3516-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the * p pointer is null, assign a value to res; otherwise, do not
execute the content in the conditional statement block.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/filesystems.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/filesystems.c b/fs/filesystems.c
index 58b9067b2391..1839dcd6cfbd 100644
--- a/fs/filesystems.c
+++ b/fs/filesystems.c
@@ -71,7 +71,7 @@ static struct file_system_type **find_filesystem(const char *name, unsigned len)
  
 int register_filesystem(struct file_system_type * fs)
 {
-	int res = 0;
+	int res = -EBUSY;
 	struct file_system_type ** p;
 
 	if (fs->parameters &&
@@ -83,10 +83,10 @@ int register_filesystem(struct file_system_type * fs)
 		return -EBUSY;
 	write_lock(&file_systems_lock);
 	p = find_filesystem(fs->name, strlen(fs->name));
-	if (*p)
-		res = -EBUSY;
-	else
+	if (!*p) {
+		res = 0;
 		*p = fs;
+	}
 	write_unlock(&file_systems_lock);
 	return res;
 }
-- 
2.18.2

