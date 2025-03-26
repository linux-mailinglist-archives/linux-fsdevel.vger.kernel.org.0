Return-Path: <linux-fsdevel+bounces-45075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE818A715A6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 12:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 470153B0114
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Mar 2025 11:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 940401E1DF9;
	Wed, 26 Mar 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="E2HwO4rh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742101C8635;
	Wed, 26 Mar 2025 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742988149; cv=none; b=uuBAQW2mLOIlEogvUibPU7NtBD63aI3FPH+rAbiLWcqb+9gIrhVVfQUpW6D9FkCd1qInf6UkbfdbLSX3X3eNbcyuYmsln7UGn7eHTzzvfK+4ajQ770lfE3Oyo+tor01f5y+7z+xbyX+Pm+j1M37Kxzdo3KAv+Dl9dczK823gRig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742988149; c=relaxed/simple;
	bh=7oEB3iyiQ+3DRRjgaNKNQIcZL+vSTPPPNL/kxJwh2i0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Aq3MfNEtYo/8zQNadLXtl59w8SfaD4vrRxUBxSGR0hx/3/B6oAXbq9s807uwbsGyE9iWH7AM1UbDOwAzxAGoSvft106Geh/uHDw6wVWVf4Z5Ut3JhZJkL4rtAxfH1/Z0F38FVcl3H4j/fFfeD8rdJOc1iYUAcXCSjMcamGdAEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=E2HwO4rh; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=84t0ULXhvJVB5iCtiqB96HKwPHTuYkS+RDsGjxv7yJ8=; b=E2HwO4rhIJg+H9626l3KLfQDl9
	y/6dLebcHCJYdXQiHUwNc31o2HC9poJGeOKH0wQjmlXC7bGya+pRLUj2qj/pOEIQ0b6/d1Cj2KISI
	k17P04jGFxiKwfplwfIAVfGSB434gBGIECpfP1YM5eOdVFX0OWfnmrcnQ1oAChucfn2SmaEHGN4K0
	igiMYj9/o9OC/tcwxfz5wlQXq9S3TP89E8xJi/j6qwoUL6bEBToFzbQMOh6RaPFHx1N7TLfHOSMue
	SE3TDWXkpN9x5+Z9kGAVc96M3LnVxMk7lJWFavWaECSPl24lu6pHyEQw5+j+J8r9ftvs19LzvFnIb
	ryZiGwRw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txOq0-00000008LM5-3FP6;
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
Subject: [RFC 4/6] ext4: replace kthread freezing with auto fs freezing
Date: Wed, 26 Mar 2025 04:22:18 -0700
Message-ID: <20250326112220.1988619-5-mcgrof@kernel.org>
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

make coccicheck MODE=patch SPFLAGS="--in-place --no-show-diff" COCCI=./fs-freeze-cleanup.cocci M=fs/ext4

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
 fs/ext4/mballoc.c | 2 +-
 fs/ext4/super.c   | 9 +++------
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 0d523e9fb3d5..ae235ec5ff3a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6782,7 +6782,7 @@ static ext4_grpblk_t ext4_last_grp_cluster(struct super_block *sb,
 
 static bool ext4_trim_interrupted(void)
 {
-	return fatal_signal_pending(current) || freezing(current);
+	return fatal_signal_pending(current);
 }
 
 static int ext4_try_to_trim_range(struct super_block *sb,
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 8cafcd3e9f5f..4241043262c8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -136,7 +136,7 @@ static struct file_system_type ext2_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("ext2");
 MODULE_ALIAS("ext2");
@@ -152,7 +152,7 @@ static struct file_system_type ext3_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV,
+	.fs_flags		= FS_REQUIRES_DEV | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("ext3");
 MODULE_ALIAS("ext3");
@@ -3776,7 +3776,6 @@ static int ext4_lazyinit_thread(void *arg)
 	unsigned long next_wakeup, cur;
 
 	BUG_ON(NULL == eli);
-	set_freezable();
 
 cont_thread:
 	while (true) {
@@ -3835,8 +3834,6 @@ static int ext4_lazyinit_thread(void *arg)
 		}
 		mutex_unlock(&eli->li_list_mtx);
 
-		try_to_freeze();
-
 		cur = jiffies;
 		if (!next_wakeup_initialized || time_after_eq(cur, next_wakeup)) {
 			cond_resched();
@@ -7404,7 +7401,7 @@ static struct file_system_type ext4_fs_type = {
 	.init_fs_context	= ext4_init_fs_context,
 	.parameters		= ext4_param_specs,
 	.kill_sb		= ext4_kill_sb,
-	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME,
+	.fs_flags		= FS_REQUIRES_DEV | FS_ALLOW_IDMAP | FS_MGTIME | FS_AUTOFREEZE,
 };
 MODULE_ALIAS_FS("ext4");
 
-- 
2.47.2


