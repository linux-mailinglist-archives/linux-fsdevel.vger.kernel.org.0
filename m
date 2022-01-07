Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFEE4875C5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jan 2022 11:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237553AbiAGKi6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 7 Jan 2022 05:38:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237637AbiAGKiv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 7 Jan 2022 05:38:51 -0500
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188FBC06118C
        for <linux-fsdevel@vger.kernel.org>; Fri,  7 Jan 2022 02:38:50 -0800 (PST)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:190f:68c2:a684:b2f7])
        by xavier.telenet-ops.be with bizsmtp
        id fmen2600U31q0Fw01menaL; Fri, 07 Jan 2022 11:38:47 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n5mdz-008Vsj-0U; Fri, 07 Jan 2022 11:38:47 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1n5mdy-00EzLU-9H; Fri, 07 Jan 2022 11:38:46 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] sysctl: Fix duplicate path separator in printed entries
Date:   Fri,  7 Jan 2022 11:38:44 +0100
Message-Id: <e3054d605dc56f83971e4b6d2f5fa63a978720ad.1641551872.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sysctl_print_dir() always terminates the printed path name with a slash,
so printing a slash before the file part causes a duplicate like in

    sysctl duplicate entry: /kernel//perf_user_access

Fix this by dropping the extra slash.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 fs/proc/proc_sysctl.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5d66faecd4ef06b8..4f6168ec5079fc8f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -163,7 +163,7 @@ static int insert_entry(struct ctl_table_header *head, struct ctl_table *entry)
 		else {
 			pr_err("sysctl duplicate entry: ");
 			sysctl_print_dir(head->parent);
-			pr_cont("/%s\n", entry->procname);
+			pr_cont("%s\n", entry->procname);
 			return -EEXIST;
 		}
 	}
@@ -1020,8 +1020,8 @@ static struct ctl_dir *get_subdir(struct ctl_dir *dir,
 	if (IS_ERR(subdir)) {
 		pr_err("sysctl could not get directory: ");
 		sysctl_print_dir(dir);
-		pr_cont("/%*.*s %ld\n",
-			namelen, namelen, name, PTR_ERR(subdir));
+		pr_cont("%*.*s %ld\n", namelen, namelen, name,
+			PTR_ERR(subdir));
 	}
 	drop_sysctl_table(&dir->header);
 	if (new)
@@ -1626,7 +1626,7 @@ static void put_links(struct ctl_table_header *header)
 		else {
 			pr_err("sysctl link missing during unregister: ");
 			sysctl_print_dir(parent);
-			pr_cont("/%s\n", name);
+			pr_cont("%s\n", name);
 		}
 	}
 }
-- 
2.25.1

