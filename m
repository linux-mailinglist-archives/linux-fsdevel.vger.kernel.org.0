Return-Path: <linux-fsdevel+bounces-45398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3522A771EB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 02:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884E1188CCFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Apr 2025 00:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1CE14F9D6;
	Tue,  1 Apr 2025 00:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMON9pul"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FC06F099;
	Tue,  1 Apr 2025 00:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743467611; cv=none; b=trmlSQB0tps86OR7HS4jtXjk8soJxxlrRgMCtua+geuVkFzGECRcfUAyLllhvTh9Jvl6gsaU94azOab3fXaC8Sb9rd4PBkFrU5UFHDISyTG5zsY0CgrfsetdW71m0OQAtAbThKlAdoCN/v7t8CVBiV8DnRncWZ/DW4NQS3veyU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743467611; c=relaxed/simple;
	bh=v/2U6Lf3UPg1q5dA8hz9DqjrfG65mtSGjt9qiHZK+iU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ow06JRjHbNIyPYZaYMw+lTgcsdOFE1/4oBnl5eBNRc7Vb/dZdkJ+13kkI50k9Bg9gxduPVocVMzyG3hVRIbgZuVbzBiWO4RqdkvGEdVGUGNefIGv24emv+s50FKGqOfKnFhJB38PQ09uL6iRzf+CkbfYYU03MEQ5NdMofIL6ypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMON9pul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBB9C4CEE5;
	Tue,  1 Apr 2025 00:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743467610;
	bh=v/2U6Lf3UPg1q5dA8hz9DqjrfG65mtSGjt9qiHZK+iU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VMON9pulmwp/ZtqWmuBSqNWW3AbYWmZblYTC16tKmiNm/DfBxsVKWe7vemiU7vmtB
	 Vbho5t2kWOso3YuO9Ewm2dFB/yCISmcHT6Q8Bt3WH5lpzR+pru2o/mamdax8FfJ88K
	 9uZQaDrFHjAhKxlCcLF6eUJKqXGWGoiSzXL81eVp0xyStBWrMGmjKaKAC4vbHjq6Nm
	 PlpVqVa8z5f18Xji1kHV97U/uRsVEwsoSuK37ONHwje/dmgGce0D/Xy2xWCjrTpppg
	 H1Om10HS2e28vKs+YFGDAM3epsU/WAwdo9HfHJvsJp/idze3nAY/24xDS7Amkjbl+k
	 wicCjLOpFnQEw==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	jack@suse.cz
Cc: Christian Brauner <brauner@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	mcgrof@kernel.org,
	hch@infradead.org,
	david@fromorbit.com,
	rafael@kernel.org,
	djwong@kernel.org,
	pavel@kernel.org,
	peterz@infradead.org,
	mingo@redhat.com,
	will@kernel.org,
	boqun.feng@gmail.com
Subject: [PATCH 1/6] ext4: replace kthread freezing with auto fs freezing
Date: Tue,  1 Apr 2025 02:32:46 +0200
Message-ID: <20250401-work-freeze-v1-1-d000611d4ab0@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
References: <20250401-work-freeze-v1-0-d000611d4ab0@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-42535
X-Developer-Signature: v=1; a=openpgp-sha256; l=4014; i=brauner@kernel.org; h=from:subject:message-id; bh=I1JUqV0XESLI2NYVo+JV4P0snp7i2H23CqsH/UPiKWY=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS/NrHelvdCcjfHx9N1dcvOm27qSpK5cXHXtLtrkxec5 fywYlHU0Y5SFgYxLgZZMUUWh3aTcLnlPBWbjTI1YOawMoEMYeDiFICJHPjC8M/owt23wbpxkhFT DX9zK76vdxSMPhq+2KW9cM/tDxlv3T4w/FM8l7HncLQBg4Dc4TrXxdUpTzVPmMp0+snfSPZfb+U pxwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

From: Luis Chamberlain <mcgrof@kernel.org>

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
Link: https://lore.kernel.org/r/20250326112220.1988619-5-mcgrof@kernel.org
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/ext4/mballoc.c | 2 +-
 fs/ext4/super.c   | 3 ---
 2 files changed, 1 insertion(+), 4 deletions(-)

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
index 8122d4ffb3b5..020c818078d7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3778,7 +3778,6 @@ static int ext4_lazyinit_thread(void *arg)
 	unsigned long next_wakeup, cur;
 
 	BUG_ON(NULL == eli);
-	set_freezable();
 
 cont_thread:
 	while (true) {
@@ -3837,8 +3836,6 @@ static int ext4_lazyinit_thread(void *arg)
 		}
 		mutex_unlock(&eli->li_list_mtx);
 
-		try_to_freeze();
-
 		cur = jiffies;
 		if (!next_wakeup_initialized || time_after_eq(cur, next_wakeup)) {
 			cond_resched();

-- 
2.47.2


