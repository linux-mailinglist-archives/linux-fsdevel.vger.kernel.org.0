Return-Path: <linux-fsdevel+bounces-45073-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6675A7159D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:22:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D86857A38D2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:21:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D67641DE3B5;
	Wed, 26 Mar 2025 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VrLxQf1m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A65D61D7E54;
	Wed, 26 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988149; cv=none; b=NGu2YS679PkKrsvzaUAiJelVaMlCWNdHLaCf38LySLGaO6Je+6S0N65Mao1ANBxgtnYtl7HYfqGU80GStmLgPq1OFFSMd4CerzriH4fJQv8zpAlmt5+5bMNdtcAbbeuTesmHkkvVAz5ricqenb1+I4pz90d4/B5f9ttCCdCsjfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988149; c=relaxed/simple;
	bh=hQmD8Ne/zZ/7oILam905jmXxWAOBDGDDhXw5kV1cutY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mCLvgiigdj9O1f43b7fl5FttciLMLQYRf5PiEGfrBPPxtnKUzeoqjgtjGUXY2yNfPSvd7UoE5ujq8XP7uTjKmlJjhQ4Yl5oMlqPOrH4b5lMKDxTOkBksfMDzYYITEoRowCyY63yRPc8et/arJ7VnadMZ3eliMQ9xMsK7MXsigR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VrLxQf1m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=pdczgHoQ3gJoGYNTPNCpioUWf2FhTA/MekqoAmjq6go=; b=VrLxQf1mv7g2AsZ9CjHeHgjGTp
	coHNkOSAclf5NumdxeToua2tseVq70wGIMOAmROTVso5X/mSMQFDC84jspLT6HMclEWIO+BhsLwX2
	0R0TLQz0+AokaMad0DJBq0s6/NQExIFog8syQqc0koMymLuEZgT1wHe0Sh1OtmkzalHKhIzcuOzU2
	LKXaDsBr+cLlMllkXm7BCy+4zDMdlo+MQinOmGzTI8Jaa9g5rsZgIZ8+tIW25sRYRxK9MWRHWFOjJ
	OxinKT8FQQHM2IyY6lfiDPoBcM8aC3/GCWUZdVNjs+SZsg7iZ+jUhrcvZIgFEIPR6JcbKNxpyck0B
	wTwG/+rw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOq0-00000008LM8-3O8f;
	Wed, 26 Mar 2025 11:22:24 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: jack@suse.cz,
	hch@infradead.org,
	James.Bottomley@HansenPartnership.com,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	song@kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	gost.dev@samsung.com,
	Luis Chamberlain <mcgrof@kernel.org>
Subject: [RFC 5/6] btrfs: replace kthread freezing with auto fs freezing
Date: Wed, 26 Mar 2025 04:22:19 -0700
Message-ID: <20250326112220.1988619-6-mcgrof@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250326112220.1988619-1-mcgrof@kernel.org>
References: <20250326112220.1988619-1-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

The kernel power management now supports allowing the VFS
to handle filesystem freezing freezes and thawing. Take advantage
of that and remove the kthread freezing. This is needed so that we
properly really stop IO in flight without races after userspace
has been frozen. Without this we rely on kthread freezing and
its semantics are loose and error prone.

The filesystem therefore is in charge of properly dealing with
quiescing of the filesystem through its callbacks if it thinks
it knows better than how the VFS handles it.

The following Coccinelle rule was used as to remove the now superfluous
freezer calls:

make coccicheck MODE=patch SPFLAGS="--in-place --no-show-diff" COCCI=./fs-freeze-cleanup.cocci M=fs/btrfs

virtual patch

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
 fs/btrfs/super.c   | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/disk-io.c b/fs/btrfs/disk-io.c
index 3dd555db3d32..03332f914be7 100644
--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -1962,8 +1962,8 @@ static void btrfs_init_qgroup(struct btrfs_fs_info *fs_info)
 static int btrfs_init_workqueues(struct btrfs_fs_info *fs_info)
 {
 	u32 max_active = fs_info->thread_pool_size;
-	unsigned int flags = WQ_MEM_RECLAIM | WQ_FREEZABLE | WQ_UNBOUND;
-	unsigned int ordered_flags = WQ_MEM_RECLAIM | WQ_FREEZABLE;
+	unsigned int flags = WQ_MEM_RECLAIM | WQ_UNBOUND;
+	unsigned int ordered_flags = WQ_MEM_RECLAIM;
 
 	fs_info->workers =
 		btrfs_alloc_workqueue(fs_info, "worker", flags, max_active, 16);
diff --git a/fs/btrfs/scrub.c b/fs/btrfs/scrub.c
index ae34353a34d9..52ef84923645 100644
--- a/fs/btrfs/scrub.c
+++ b/fs/btrfs/scrub.c
@@ -2811,7 +2811,7 @@ static void scrub_workers_put(struct btrfs_fs_info *fs_info)
 static noinline_for_stack int scrub_workers_get(struct btrfs_fs_info *fs_info)
 {
 	struct workqueue_struct *scrub_workers = NULL;
-	unsigned int flags = WQ_FREEZABLE | WQ_UNBOUND;
+	unsigned int flags = WQ_UNBOUND;
 	int max_active = fs_info->thread_pool_size;
 	int ret = -ENOMEM;
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 40709e2a44fc..153e8a2d7fbb 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -2178,7 +2178,7 @@ static struct file_system_type btrfs_fs_type = {
 	.parameters		= btrfs_fs_parameters,
 	.kill_sb		= btrfs_kill_super,
 	.fs_flags		= FS_REQUIRES_DEV | FS_BINARY_MOUNTDATA |
-				  FS_ALLOW_IDMAP | FS_MGTIME,
+				  FS_ALLOW_IDMAP | FS_MGTIME | FS_AUTOFREEZE,
  };
 
 MODULE_ALIAS_FS("btrfs");
-- 
2.47.2


