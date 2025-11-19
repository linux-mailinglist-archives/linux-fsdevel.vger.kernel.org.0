Return-Path: <linux-fsdevel+bounces-69053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 11730C6CF5E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 07:40:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71CBC4F2DB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 06:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60FFD2F2916;
	Wed, 19 Nov 2025 06:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mujQnR5c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D63A27A130
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Nov 2025 06:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763534349; cv=none; b=uDXN/lOJDtm/PDquj6fOUkNC5bfqmJDSf+8CPIYWBowpHcINbilZJsJWIhYbtCbaCA+vDkgNKyrK4OSFgUbDO47nSCGeyXNtghArpfJ8t7CrMPvWkqOaA2yJKaTZsI5zePntTkftsHlBMtlGgPVfLm2Svmn6AACcowhFAWdLmbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763534349; c=relaxed/simple;
	bh=iv/2V65ay3MYD+zg/uXmPYJEYt6c0/sS7ygSOWw1Tzc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DkWLQt9CsWdXarEy7CJPXYUY20euMHOkSnn0Oc9Bj5PiCyXt5YwDPctpO/cknGWe5uAMr49b42sLMGBqqSGhVltU4uTZD2Qtla7Zqf7GEh1baHsga7FCnPwBIOUxtZvpXlm8Gkq8TfD0JoIclTShLa9F79WCNoDQnRW+Vj53CbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mujQnR5c; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4779b49d724so4697475e9.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 22:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763534346; x=1764139146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=h1xVzQCUtlha4eANiMsZQcVMtYn0VURMct9OKFdBU5k=;
        b=mujQnR5cm4jZfz7oOQzKaA4KWYK2BCmaYns2n/3X4eAmouc7xgHYmFjDjDDPrLAl8C
         VKfyJ6jIHa3cZQqEFrrUd/yeINLDI5cuteJcI9sXCB6Fk+gTE2DTxzJcB994y4Wc9O8S
         51oZ6tNzwyXqW/EzrdpHvUZh6+ZbldV5Q7cpqKK4rg4JzR+JFD1EnyIZsp0g3+jxK/F6
         kWy5hBbEwTPMW2du/pa5GE99nvGIlUt/QqivU8Res/WdDNwgwIqhcjKUO+hcYUB8ZNUn
         iB1RywsLy0fSCxVKcpVCciygky7IbSzg0Pb+jKuGIO3l+GKOepmV10OEkT/XEqgZ7Kif
         QIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763534346; x=1764139146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1xVzQCUtlha4eANiMsZQcVMtYn0VURMct9OKFdBU5k=;
        b=ZCxcYBsrKIbksTJDSfXdViz7pAAyn+a9WjDmtFsPu1IFNRMlGCmn3Z5stk6gF7Els+
         HKDsMSt9cGBLV5mclQnJwRjC3elfUure0ccvR4T+lgnNVDnzqMXW7nx3t9O2Vi7lzotN
         LXf8etXL4M47TORFOFk1+EaHIi2+kbq4YiFR2sfKUl1jeqE5oFaUGtmPKmBy516siAkH
         2IJ53Hh9dtQC/0M2IpR2sJWyA/tRkYswfRUZJFvv8A6/+g/AEuEVpAl6n5FSTzjSCsLv
         L7E/IAu945jFEduBFokdnSv30lB3mgGP9pSIk+CIRYSW2dHBsus+iDXAkICecxAuKh+5
         GC9w==
X-Gm-Message-State: AOJu0YxPm8up6HD4Dz3PxBdovzzY8CEMYqyBwLL5M9pzO19dV82mm7A0
	oMQkNzaPysTLglzAeXfqhyVbjTxvrcySC7AATJo3NYK/NdrkQSU271IhktzS7g==
X-Gm-Gg: ASbGnctbP7T0xLYIC0bbZfmiltp9eXxjP3jbkPdLxUsrVbd7UczVBGjB9k/ke+7t9l9
	qs3W6yGSkUZ7G24rwzqmU8JihWD9484bY9XHnPMQqJw16XgodPjoVH+aiucaVb+76QLGpKJ0NZi
	rt1RIDRUZCzOXUkr86Nkksl3VEdHUE4fajWpJcVxdgBeJfIywE4/xOYs1hbe/rWguryuO/1YsNW
	QGnPeGfvnjZy/hL/t/ET0wePnZXjrf2ozPi+6rZHIxi/2SySFGZb2ZaOQENFMefHQgMCvkdesqJ
	B4ISJMKsreagrIk9drdSH/9kIjhCinIO6gnq44wwtEkH7HUPWvpWyY9YBhgDx6M/mAhm9VZJXLO
	bBeOR3bNG26PvSW4uCsEjBBpvpb78GM49vctkRBhOqPWV7hnurMpHZXtx3eSt/oFST9QJVJGsNl
	gDXM+UD9KtSTpq4ek=
X-Google-Smtp-Source: AGHT+IFVKoZk9N7QhSRfuxnSPuUS4Q1FHG+IbsLr577Ad9xm7bFuDNcywKGc+cpHM2PozpRA9AyIIw==
X-Received: by 2002:a05:600c:1d1b:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-477a9c2aa7amr29179765e9.3.1763534346199;
        Tue, 18 Nov 2025 22:39:06 -0800 (PST)
Received: from bhk ([165.50.116.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477b10173a3sm29112015e9.5.2025.11.18.22.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:39:05 -0800 (PST)
From: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	brauner@kernel.org,
	jack@suse.cz,
	viro@zeniv.linux.org.uk
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	khalid@kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>,
	syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Subject: [PATCH v2] fs/hfs: fix s_fs_info leak on setup_bdev_super() failure
Date: Wed, 19 Nov 2025 08:38:20 +0100
Message-ID: <20251119073845.18578-1-mehdi.benhadjkhelifa@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The regression introduced by commit aca740cecbe5 ("fs: open block device
after superblock creation") allows setup_bdev_super() to fail after a new
superblock has been allocated by sget_fc(), but before hfs_fill_super()
takes ownership of the filesystem-specific s_fs_info data.

In that case, hfs_put_super() and the failure paths of hfs_fill_super()
are never reached, leaving the HFS mdb structures attached to s->s_fs_info
unreleased.The default kill_block_super() teardown also does not free 
HFS-specific resources, resulting in a memory leak on early mount failure.

Fix this by moving all HFS-specific teardown (hfs_mdb_put()) from
hfs_put_super() and the hfs_fill_super() failure path into a dedicated
hfs_kill_sb() implementation. This ensures that both normal unmount and
early teardown paths (including setup_bdev_super() failure) correctly
release HFS metadata.

This also preserves the intended layering: generic_shutdown_super()
handles VFS-side cleanup, while HFS filesystem state is fully destroyed
afterwards.

Fixes: aca740cecbe5 ("fs: open block device after superblock creation")
Reported-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ad45f827c88778ff7df6
Tested-by: syzbot+ad45f827c88778ff7df6@syzkaller.appspotmail.com
Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Mehdi Ben Hadj Khelifa <mehdi.benhadjkhelifa@gmail.com>
---
ChangeLog:

Changes from v1:

-Changed the patch direction to focus on hfs changes specifically as 
suggested by al viro

Link:https://lore.kernel.org/all/20251114165255.101361-1-mehdi.benhadjkhelifa@gmail.com/

Note:This patch might need some more testing as I only did run selftests 
with no regression, check dmesg output for no regression, run reproducer 
with no bug and test it with syzbot as well.

 fs/hfs/super.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/hfs/super.c b/fs/hfs/super.c
index 47f50fa555a4..06e1c25e47dc 100644
--- a/fs/hfs/super.c
+++ b/fs/hfs/super.c
@@ -49,8 +49,6 @@ static void hfs_put_super(struct super_block *sb)
 {
 	cancel_delayed_work_sync(&HFS_SB(sb)->mdb_work);
 	hfs_mdb_close(sb);
-	/* release the MDB's resources */
-	hfs_mdb_put(sb);
 }
 
 static void flush_mdb(struct work_struct *work)
@@ -383,7 +381,6 @@ static int hfs_fill_super(struct super_block *sb, struct fs_context *fc)
 bail_no_root:
 	pr_err("get root inode failed\n");
 bail:
-	hfs_mdb_put(sb);
 	return res;
 }
 
@@ -431,10 +428,21 @@ static int hfs_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void hfs_kill_sb(struct super_block *sb)
+{
+	generic_shutdown_super(sb);
+	hfs_mdb_put(sb);
+	if (sb->s_bdev) {
+		sync_blockdev(sb->s_bdev);
+		bdev_fput(sb->s_bdev_file);
+	}
+
+}
+
 static struct file_system_type hfs_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfs",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfs_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfs_init_fs_context,
 };
-- 
2.52.0


