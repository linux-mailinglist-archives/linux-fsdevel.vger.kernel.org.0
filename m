Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E866A78C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Jan 2023 01:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjANAee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 19:34:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231179AbjANAeZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 19:34:25 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E9F88A231;
        Fri, 13 Jan 2023 16:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=obMZn3Dx/CMQUli0SydFBvsNyz0GqtJ7R0RfTckDcTU=; b=eDhKtpbg+S4awXHAT7Q2vNAMwP
        zoZEFqY9POcYiEqSIyx3pNevoE9+gkF3EvsRVA7d4SkqXnLklgC7qWU84x7Mf7oFzWvdTrbYtG2F8
        1McOhdoj5Y0hsyPCKQOYRCI4PYvYSa2eMROMHJicWMltALmHMPeWc5KJQ8dIKhv0gazKcpst0IO7Q
        PujkIbiq+erIpM5xZjwbzQcQwZATpHcJTOjs45BJHQSTMezxXmtytbjl7u9+DdfzvOiqWLXI4Bw7J
        CuI6FXbvLY3JLKSMZWTht4Iqfjd+egFx3Nki2MEnehYXBPPon1+DSC87gs7B4H87uakrbxf4fqUnx
        J2oQrOiQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pGUUt-004tw9-6G; Sat, 14 Jan 2023 00:34:11 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     hch@infradead.org, djwong@kernel.org, song@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, bvanassche@acm.org,
        ebiederm@xmission.com
Cc:     mchehab@kernel.org, keescook@chromium.org, p.raghav@samsung.com,
        linux-fsdevel@vger.kernel.org, kernel@tuxforce.de,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC v3 07/24] btrfs: replace kthread freezing with auto fs freezing
Date:   Fri, 13 Jan 2023 16:33:52 -0800
Message-Id: <20230114003409.1168311-8-mcgrof@kernel.org>
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

spatch --sp-file fs-freeze-cleanup.cocci --in-place --timeout 120 --dir fs/btrfs --jobs 12 --use-gitgrep

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
 fs/btrfs/disk-io.c | 4 ++--
 fs/btrfs/scrub.c   | 2 +-
 fs/btrfs/super.c   | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index f330dfa066c0..bf7ad1f34e21 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -2354,7 +2354,7 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 {
 	u32 max_active = fs_info->thread_pool_size;
-	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
+	unsigned int flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
@@ -2395,7 +2395,7 @@ static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 	fs_info->qgroup_rescan_workers =
 		btrfs_alloc_workqueue(fs_info, "qgroup-rescan", flags, 1, 0);
 	fs_info->discard_ctl.discard_workers =
-		alloc_workqueue("btrfs_discard", WQ_UNBOUND | WQ_FREEZABLE, 1);
+		alloc_workqueue("btrfs_discard", WQ_UNBOUND, 1);
 
 	if (!(fs_info->workers && fs_info->hipri_workers &&
 	      fs_info->delalloc_workers && fs_info->flush_workers &&
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index 52b346795f66..d32d7308c3a1 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -4207,7 +4207,7 @@ static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info,
 	struct workqueue_struct *scrub_workers = NULL;
 	struct workqueue_struct *scrub_wr_comp = NULL;
 	struct workqueue_struct *scrub_parity = NULL;
-	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
+	unsigned int flags = WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 433ce221dc5c..35059fe276ac 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2138,7 +2138,7 @@ static struct file_system_type btrfs_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_AUTOFREEZE,
 };
 
 static struct file_system_type btrfs_root_fs_type = {
@@ -2146,7 +2146,7 @@ static struct file_system_type btrfs_root_fs_type = {
 	.name		= "btrfs",
 	.mount		= btrfs_mount_root,
 	.kill_sb	= btrfs_kill_super,
-	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP,
+	.fs_flags	= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA | FS_ALLOW_IDMAP | FS_AUTOFREEZE,
 };
 
 MODULE_ALIAS_FS("btrfs");
-- 
2.35.1

