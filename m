Return-Path: <linux-fsdevel+bounces-71600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 628E9CCA0D5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 03:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45B0B30173B6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 02:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76D9C277CB8;
	Thu, 18 Dec 2025 02:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ugd1W4oo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB020274B51;
	Thu, 18 Dec 2025 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766023517; cv=none; b=otJBL/DfPLcZWRjx/hZqMcFuBfeoPCZp3NRz0S1IWmS6SOzL5zvt0AYYFAZIR3JN5P+nW09PeEG78NTvagSbxjPS3mZ/D2uK4nmWGgftIigGukKjzFTMMmnhgFKQvwRLqGOdJj0C3oiOj0Cu+vm8bdsJFMPNmUeZDKwFrfBqpGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766023517; c=relaxed/simple;
	bh=reAMsScd2BFpDk9EyOLih8I1wC6A8cezvL7blngtQAk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m9aFOORSMcw02qBPS8AIBHLqXBoFiys/jpDwh91EywL6vwRt7ddL0hfRTXYnx/xhUff9D8iLxjfFjKSwKm0jewGhEHmnMpeafVfVmXaZ/EwHKXKUxazX3+aE5v5+ptLVS95wfb8G2FOX51P3Lvh8rlEzs88rJptkmFcshrhzQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ugd1W4oo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA26C116B1;
	Thu, 18 Dec 2025 02:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766023517;
	bh=reAMsScd2BFpDk9EyOLih8I1wC6A8cezvL7blngtQAk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=Ugd1W4ooJlt+89YxiMThkqH7ZKjnC1D7OWTLXMa5qibuQ2xpRKVVSGg4qqK7rRps0
	 XV92AuP8hPwjGyORomZtbJFatNusTy8gJrqYS8ABFmrav98o4Px3DnNXS6pEssL9re
	 Uqc35f9LqVGpOVs9iWVX1aTQ77raQC/+UXh0GIGZMtzaRIazHO8vMitPAOD6vAtlDT
	 6G2NiUyJxexboGOzHiiXWC+l8/oIIVLF839V5YReaH5dH8oFdWrm95MxxnocicGCbE
	 qawTrzr0L6Zb/j4xNIHjBQN2vVyIyFlsu/0c2Ae1YdAhybdcGM77eN7HvDnL+dZJx1
	 rf4GHkirw7gpw==
Date: Wed, 17 Dec 2025 18:05:16 -0800
Subject: [PATCH 4/4] ext4: send uevents when major filesystem events happen
From: "Darrick J. Wong" <djwong@kernel.org>
To: brauner@kernel.org, djwong@kernel.org
Cc: linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org, hch@lst.de,
 linux-fsdevel@vger.kernel.org
Message-ID: <176602332590.688213.9240067999700074165.stgit@frogsfrogsfrogs>
In-Reply-To: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
References: <176602332484.688213.11232314346072982565.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Send uevents when we mount, unmount, and shut down the filesystem, so
that people can trigger systemd services when major events happen.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/ext4/ioctl.c |    2 ++
 fs/ext4/super.c |    6 ++++++
 fs/ext4/sysfs.c |    2 ++
 3 files changed, 10 insertions(+)


diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index ea26cd03d3ce28..48ea33cdebbf0c 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -27,6 +27,7 @@
 #include "fsmap.h"
 #include <trace/events/ext4.h>
 #include <linux/fserror.h>
+#include <linux/fsevent.h>
 
 typedef void ext4_update_sb_callback(struct ext4_sb_info *sbi,
 				     struct ext4_super_block *es,
@@ -845,6 +846,7 @@ int ext4_force_shutdown(struct super_block *sb, u32 flags)
 		return -EINVAL;
 	}
 	clear_opt(sb, DISCARD);
+	fsevent_send_shutdown(sb, &sbi->s_kobj);
 	fserror_report_shutdown(sb, GFP_KERNEL);
 	return 0;
 }
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a6241ffb8639c3..649eed02d45dbb 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -49,6 +49,7 @@
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
 #include <linux/fserror.h>
+#include <linux/fsevent.h>
 
 #include "ext4.h"
 #include "ext4_extents.h"	/* Needed for trace points definition */
@@ -1284,6 +1285,8 @@ static void ext4_put_super(struct super_block *sb)
 	int aborted = 0;
 	int err;
 
+	fsevent_send_unmount(sb, &sbi->s_kobj);
+
 	/*
 	 * Unregister sysfs before destroying jbd2 journal.
 	 * Since we could still access attr_journal_task attribute via sysfs
@@ -5698,6 +5701,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	if (err)
 		goto failed_mount9;
 
+	fsevent_send_mount(sb, &sbi->s_kobj, fc);
 	return 0;
 
 failed_mount9:
@@ -6835,6 +6839,7 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
 static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
 	int ret;
 	bool old_ro = sb_rdonly(sb);
 
@@ -6852,6 +6857,7 @@ static int ext4_reconfigure(struct fs_context *fc)
 		 &sb->s_uuid,
 		 (old_ro != sb_rdonly(sb)) ? (sb_rdonly(sb) ? " ro" : " r/w") : "");
 
+	fsevent_send_remount(sb, &sbi->s_kobj);
 	return 0;
 }
 
diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
index e6a14585244308..9d9812a5b265ba 100644
--- a/fs/ext4/sysfs.c
+++ b/fs/ext4/sysfs.c
@@ -335,6 +335,7 @@ EXT4_ATTR_FEATURE(encrypted_casefold);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 EXT4_ATTR_FEATURE(blocksize_gt_pagesize);
 #endif
+EXT4_ATTR_FEATURE(uevents);
 
 static struct attribute *ext4_feat_attrs[] = {
 	ATTR_LIST(lazy_itable_init),
@@ -358,6 +359,7 @@ static struct attribute *ext4_feat_attrs[] = {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	ATTR_LIST(blocksize_gt_pagesize),
 #endif
+	ATTR_LIST(uevents),
 	NULL,
 };
 ATTRIBUTE_GROUPS(ext4_feat);


