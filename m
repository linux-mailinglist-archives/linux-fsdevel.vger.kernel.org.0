Return-Path: <linux-fsdevel+bounces-24747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F778944AF8
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 14:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 325861C21382
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 12:08:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A6319F48D;
	Thu,  1 Aug 2024 12:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="if05AWJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C041918DF8B
	for <linux-fsdevel@vger.kernel.org>; Thu,  1 Aug 2024 12:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722514109; cv=none; b=gexH1gXOreoNL/Rtz14uQfktnRpqsx67W/cFGDnb7FrT8iZquETWmv5d+bPVGIyIEpbgVwh12nFip4VTFMwAqlqNHRt26lRU83r3d281jjGQBRkJo0PKNGluCQPnGWnCS2mBMl3xP3BmNAav9RANG9hMCDQfSE9SJiL+GAibkH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722514109; c=relaxed/simple;
	bh=PCQi4OG8cIumgtxOAQs8C6+7+92T+n41RVqxxL5Tsbc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=F4wphHk5qnJ45aS9AEa9//j9qmo4qCTaUB7hyeE9BhWWsTJbxnjZh5Fei4mXUwSQzR/O3rquRoE4RctjPvN14JGVwyxATh1ApRn35nwOKMWZj7iTKy3Qau4rSn+XDNbSlrQlwBeiIH62uaGSoIvqNKdXBsv3rK1sJMFRrSHVeoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=if05AWJI; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a7a975fb47eso958315366b.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 01 Aug 2024 05:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1722514105; x=1723118905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nB/idpKvpCC5AMBAVtxITho2KioK5WwQCn31MARLVcA=;
        b=if05AWJIZjs0blvhIa0ggebm54A9ZveXH47kGPrnoEpnek+5Wym3TQ3CfSPhznfPBe
         2EwfdwapOuKP+zqt8QrXMWdFY2g3PkCm+x403KJuOx97iTJJDMtC13fj+NuAIZSiP6JG
         V+dC2EYCLcpyX0sfZFAr/rI8Buqup/Uj1cD20d7dfRfQI0C1/i2ENT8/rUhuNJfiAUyx
         Bvs2ZIS3EoTGuFMbH+bXUvDY40oVVCGxrHFzAaW49E6HSb0IExiDhDMmCzbfqPz/TG84
         yr+aWG587700b0+367mwk6gkQ0X8ZSatcv9sWZRbNkO61/kPq5TQv3ioIx0LR5CVjkZj
         tt9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722514105; x=1723118905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nB/idpKvpCC5AMBAVtxITho2KioK5WwQCn31MARLVcA=;
        b=T54RgaamDyadT1pABGcYbFr4584Qbvcx6h6zxErkvBr+F12ASxJMIvI+CzTZvnba4N
         AOI0YEnTOotyc97NdjgU+Vdw+jRSZ4Dnz8IiUcqwjz5Acw1uiMUTGwOyzB0vIldS2i5g
         F9xz/rBAWI7NdNpmQhcFwJu2Xp13vF/F7qF5aI6IGnAOSnR7RbKi86A5ppiepvjuTapE
         f7BwxPti4/dP+0Edo8v9cMG7Xfxbo5dqEtTVPKXJ3TEJqfbAtmys2GqFP58Ix733XtY8
         GCVa79f+pmCfhH0QY2xYV5NjDX3VQY3ZO1Bqtp/S5c52M6ofZXE5Wc2z34EHG3DeiYLJ
         6WMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOwokWX3T4Wzgpn+1Ba6ViH1sIcY8xEMh8BBais+Q3YoaBReYd0G49Ozl5CZbpC+Hej4y/y83O8ZZASP21D4KE9OR4xrxxUQsu6JuH5g==
X-Gm-Message-State: AOJu0Yz6sk8WpH73+F8mdmNO4RL7BSIdSbP4sLVXpRJQlWW0nm3pj11U
	rZ4il8cVN4jc2Gun/OY+3hiEL/KbjV+sSzKkty7m2eJIhu3Y0XjIjZR2Snd/mjbyPKw5GLFNxJB
	R5LQ=
X-Google-Smtp-Source: AGHT+IFVqIRaH4uLNDl8kuzBw0JjVatO72588Ewo/xAcVdYA3RWoyNva4io93ZY9i0b22EJTh5oC+A==
X-Received: by 2002:a17:907:94cc:b0:a7a:a7b8:ada3 with SMTP id a640c23a62f3a-a7daf7929c1mr183395266b.3.1722514104389;
        Thu, 01 Aug 2024 05:08:24 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-3-137.dynamic.gprs.plus.pl. [31.0.3.137])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab4dec6sm890783066b.61.2024.08.01.05.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:08:23 -0700 (PDT)
From: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiederm@xmission.com,
	kees@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Subject: [PATCH] kernel/fs: last check for exec credentials on NOEXEC mount
Date: Thu,  1 Aug 2024 14:07:45 +0200
Message-Id: <20240801120745.13318-1-wojciech.gladysz@infogain.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Test case: thread mounts NOEXEC fuse to a file being executed.
WARN_ON_ONCE is triggered yielding panic for some config.
Add a check to security_bprm_creds_for_exec(bprm).

Stack trace:
------------[ cut here ]------------
WARNING: CPU: 0 PID: 2736 at fs/exec.c:933 do_open_execat+0x311/0x710 fs/exec.c:932
Modules linked in:
CPU: 0 PID: 2736 Comm: syz-executor384 Not tainted 5.10.0-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:do_open_execat+0x311/0x710 fs/exec.c:932
Code: 89 de e8 02 b1 a1 ff 31 ff 89 de e8 f9 b0 a1 ff 45 84 ff 75 2e 45 85 ed 0f 8f ed 03 00 00 e8 56 ae a1 ff eb bd e8 4f ae a1 ff <0f> 0b 48 c7 c3 f3 ff ff ff 4c 89 f7 e8 9e cb fe ff 49 89 de e9 2d
RSP: 0018:ffffc90008e07c20 EFLAGS: 00010293
RAX: ffffffff82131ac6 RBX: 0000000000000004 RCX: ffff88801a6611c0
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000000
RBP: ffffc90008e07cf0 R08: ffffffff8213173f R09: ffffc90008e07aa0
R10: 0000000000000000 R11: dffffc0000000001 R12: ffff8880115810e0
R13: dffffc0000000000 R14: ffff88801122c040 R15: ffffc90008e07c60
FS:  00007f9e283ce6c0(0000) GS:ffff888058a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9e2848600a CR3: 00000000139de000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 bprm_execve+0x60b/0x1c40 fs/exec.c:1939
 do_execveat_common+0x5a6/0x770 fs/exec.c:2077
 do_execve fs/exec.c:2147 [inline]
 __do_sys_execve fs/exec.c:2223 [inline]
 __se_sys_execve fs/exec.c:2218 [inline]
 __x64_sys_execve+0x92/0xb0 fs/exec.c:2218
 do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7f9e2842f299
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f9e283ce218 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 00007f9e284bd3f8 RCX: 00007f9e2842f299
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000400
RBP: 00007f9e284bd3f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f9e2848a134
R13: 0030656c69662f2e R14: 00007ffc819a23d0 R15: 00007f9e28488130

Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
---
 fs/exec.c | 42 +++++++++++++++++++-----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/fs/exec.c b/fs/exec.c
index a126e3d1cacb..0cc6a7d033a1 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -953,8 +953,6 @@ EXPORT_SYMBOL(transfer_args_to_stack);
  */
 static struct file *do_open_execat(int fd, struct filename *name, int flags)
 {
-	struct file *file;
-	int err;
 	struct open_flags open_exec_flags = {
 		.open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
 		.acc_mode = MAY_EXEC,
@@ -969,26 +967,7 @@ static struct file *do_open_execat(int fd, struct filename *name, int flags)
 	if (flags & AT_EMPTY_PATH)
 		open_exec_flags.lookup_flags |= LOOKUP_EMPTY;
 
-	file = do_filp_open(fd, name, &open_exec_flags);
-	if (IS_ERR(file))
-		goto out;
-
-	/*
-	 * may_open() has already checked for this, so it should be
-	 * impossible to trip now. But we need to be extra cautious
-	 * and check again at the very end too.
-	 */
-	err = -EACCES;
-	if (WARN_ON_ONCE(!S_ISREG(file_inode(file)->i_mode) ||
-			 path_noexec(&file->f_path)))
-		goto exit;
-
-out:
-	return file;
-
-exit:
-	fput(file);
-	return ERR_PTR(err);
+	return do_filp_open(fd, name, &open_exec_flags);
 }
 
 /**
@@ -1730,6 +1709,23 @@ static void bprm_fill_uid(struct linux_binprm *bprm, struct file *file)
 	}
 }
 
+static int bprm_creds_for_exec(struct linux_binprm *bprm)
+{
+	struct file *file = bprm->file;
+
+	/*
+	 * Do not execute a regular file on NOEXEC mount.
+	 * May_open() has already checked for this but a NOEXEC mount
+	 * operation may have happened to the file since then (fuse).
+	 * This is the last check point.
+	 */
+	if (!S_ISREG(file_inode(file)->i_mode) ||
+			path_noexec(&file->f_path))
+		return -EACCES;
+
+	return security_bprm_creds_for_exec(bprm);
+}
+
 /*
  * Compute brpm->cred based upon the final binary.
  */
@@ -1907,7 +1903,7 @@ static int bprm_execve(struct linux_binprm *bprm)
 	sched_exec();
 
 	/* Set the unchanging part of bprm->cred */
-	retval = security_bprm_creds_for_exec(bprm);
+	retval = bprm_creds_for_exec(bprm);
 	if (retval)
 		goto out;
 
-- 
2.35.3


