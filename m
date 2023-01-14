Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707DF66A7A7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:35:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjANAfP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:35:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjANAe1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25E0D87900;
        Fri, 13 Jan 2023 16:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=06HkOlYxNDNauIY+aptrMNX1Acam7rQQdFMEW91x4gI=; b=dmobBKVRKmnC/djRsU22pKKjLH
        qHbvEMvdQ7jSL6MOO0ti+uOE3mgxAkhbkfOQK8K/cuAO5xROLulOEejlmOKd2dpI3461QqAeCPgBD
        EmbzkV0fiwb5Sa5ncA+xYq3F1IqOUIGfw20IROWKFtoxujjdWl5WJTSEiUcH7zz0qekdbgOLRbsSR
        ZyITxoU4MnLoCU1M/6CBK+Egm7p7vOrYcEa8Y4g7SCBcrpxHAOglVwNeb7a857rtU82HSjLGWZKk6
        nyrxiOnTBB024+zM6onfA2+xjlkpdyOdixZRvblmDognu/mCVXFbxidE1FzdDpj0DF+lOFJIlI+Kp
        VUtXAcOQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUt-004twF-Aq; Sat, 14 Jan 2023 00:34:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 10/24] cifs: replace kthread freezing with auto fs freezing
Date:   Fri, 13 Jan 2023 16:33:55 -0800
Message-Id: <20230114003409.1168311-11-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230114003409.1168311-1-mcgrof@kernel.org>
References: <20230114003409.1168311-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The kernel power management now supports allowing the VFS
to handle filesystem freezing freezes and thawing. Take advantage
of that and remove the kthread freezing. This is needed so that we
properly really stop IO in flight without races after userspace
has been frozen. Without this we rely on kthread freezing and
its semantics are loose and error prone.

The filesystem therefore is in charge of properly dealing with
quiescing of the filesystem through its callbacks if it thinks
it knows better than how the VFS handles it.

The following Coccinelle rule was used as to remove the now superflous
freezer calls:

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/cifs --jobs 12 --use-gitgrep

@ remove_set_freezable @
expression time;
statement S, S2;
expression task, current;
@@

(
-       set_freezable();
|
-       if (try_to_freeze())
-               continue;
|
-       try_to_freeze();
|
-       freezable_schedule();
+       schedule();
|
-       freezable_schedule_timeout(time);
+       schedule_timeout(time);
|
-       if (freezing(task)) { S }
|
-       if (freezing(task)) { S }
-       else
	    { S2 }
|
-       freezing(current)
)

@ remove_wq_freezable @
expression WQ_E, WQ_ARG1, WQ_ARG2, WQ_ARG3, WQ_ARG4;
identifier fs_wq_fn;
@@

(
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_FREEZABLE,
+                              WQ_ARG2,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_FREEZABLE | WQ_ARG3,
+                              WQ_ARG2 | WQ_ARG3,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE,
+                              WQ_ARG2 | WQ_ARG3,
			   ...);
|
    WQ_E = alloc_workqueue(WQ_ARG1,
-                              WQ_ARG2 | WQ_ARG3 | WQ_FREEZABLE | WQ_ARG4,
+                              WQ_ARG2 | WQ_ARG3 | WQ_ARG4,
			   ...);
|
	    WQ_E =
-               WQ_ARG1 | WQ_FREEZABLE
+               WQ_ARG1
|
	    WQ_E =
-               WQ_ARG1 | WQ_FREEZABLE | WQ_ARG3
+               WQ_ARG1 | WQ_ARG3
|
    fs_wq_fn(
-               WQ_FREEZABLE | WQ_ARG2 | WQ_ARG3
+               WQ_ARG2 | WQ_ARG3
    )
|
    fs_wq_fn(
-               WQ_FREEZABLE | WQ_ARG2
+               WQ_ARG2
    )
|
    fs_wq_fn(
-               WQ_FREEZABLE
+               0
    )
)

@ add_auto_flag @
expression E1;
identifier fs_type;
@@

struct file_system_type fs_type = {
	.fs_flags = E1
+                   | FS_AUTOFREEZE
	,
};

Generated-by: Coccinelle SmPL
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/cifs/cifsfs.c    | 14 +++++++-------
 fs/cifs/connect.c   |  8 --------
 fs/cifs/dfs_cache.c |  2 +-
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f052f190b2e8..25ee05c8af65 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1104,7 +1104,7 @@ struct file_system_type cifs_fs_type = {
 	.init_fs_context = smb3_init_fs_context,
 	.parameters = smb3_fs_parameters,
 	.kill_sb = cifs_kill_sb,
-	.fs_flags = FS_RENAME_DOES_D_MOVE,
+	.fs_flags = FS_RENAME_DOES_D_MOVE | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("cifs");
 
@@ -1114,7 +1114,7 @@ struct file_system_type smb3_fs_type = {
 	.init_fs_context = smb3_init_fs_context,
 	.parameters = smb3_fs_parameters,
 	.kill_sb = cifs_kill_sb,
-	.fs_flags = FS_RENAME_DOES_D_MOVE,
+	.fs_flags = FS_RENAME_DOES_D_MOVE | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("smb3");
 MODULE_ALIAS("smb3");
@@ -1668,7 +1668,7 @@ init_cifs(void)
 			 CIFS_MAX_REQ);
 	}
 
-	cifsiod_wq = alloc_workqueue("cifsiod", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+	cifsiod_wq = alloc_workqueue("cifsiod", WQ_MEM_RECLAIM, 0);
 	if (!cifsiod_wq) {
 		rc = -ENOMEM;
 		goto out_clean_proc;
@@ -1682,28 +1682,28 @@ init_cifs(void)
 
 	/* WQ_UNBOUND allows decrypt tasks to run on any CPU */
 	decrypt_wq = alloc_workqueue("smb3decryptd",
-				     WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				     WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!decrypt_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsiod_wq;
 	}
 
 	fileinfo_put_wq = alloc_workqueue("cifsfileinfoput",
-				     WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+				     WQ_UNBOUND | WQ_MEM_RECLAIM, 0);
 	if (!fileinfo_put_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_decrypt_wq;
 	}
 
 	cifsoplockd_wq = alloc_workqueue("cifsoplockd",
-					 WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					 WQ_MEM_RECLAIM, 0);
 	if (!cifsoplockd_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_fileinfo_put_wq;
 	}
 
 	deferredclose_wq = alloc_workqueue("deferredclose",
-					   WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
+					   WQ_MEM_RECLAIM, 0);
 	if (!deferredclose_wq) {
 		rc = -ENOMEM;
 		goto out_destroy_cifsoplockd_wq;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 164beb365bfe..43a86a369a31 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -375,7 +375,6 @@ static int __cifs_reconnect(struct TCP_Server_Info *server,
 	cifs_abort_connection(server);
 
 	do {
-		try_to_freeze();
 		cifs_server_lock(server);
 
 		if (!cifs_swn_set_server_dstaddr(server)) {
@@ -504,7 +503,6 @@ static int reconnect_dfs_server(struct TCP_Server_Info *server)
 	cifs_abort_connection(server);
 
 	do {
-		try_to_freeze();
 		cifs_server_lock(server);
 
 		rc = reconnect_target_unlocked(server, &tl, &target_hint);
@@ -678,8 +676,6 @@ cifs_readv_from_socket(struct TCP_Server_Info *server, struct msghdr *smb_msg)
 	int total_read;
 
 	for (total_read = 0; msg_data_left(smb_msg); total_read += length) {
-		try_to_freeze();
-
 		/* reconnect if no credits and no requests in flight */
 		if (zero_credits(server)) {
 			cifs_reconnect(server, false);
@@ -1132,12 +1128,8 @@ cifs_demultiplex_thread(void *p)
 	if (length > 1)
 		mempool_resize(cifs_req_poolp, length + cifs_min_rcv);
 
-	set_freezable();
 	allow_kernel_signal(SIGKILL);
 	while (server->tcpStatus != CifsExiting) {
-		if (try_to_freeze())
-			continue;
-
 		if (!allocate_buffers(server))
 			continue;
 
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index e20f8880363f..371c5f0a3523 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -376,7 +376,7 @@ int dfs_cache_init(void)
 	int rc;
 	int i;
 
-	dfscache_wq = alloc_workqueue("cifs-dfscache", WQ_FREEZABLE | WQ_UNBOUND, 1);
+	dfscache_wq = alloc_workqueue("cifs-dfscache", WQ_UNBOUND, 1);
 	if (!dfscache_wq)
 		return -ENOMEM;
 
-- 
2.35.1

