Return-Path: <linux-fsdevel+bounces-56809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9133B1BFAC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 06:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8214188C900
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Aug 2025 04:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BADA31F866A;
	Wed,  6 Aug 2025 04:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="Vsb5mhdU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973831F4CBC;
	Wed,  6 Aug 2025 04:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754455741; cv=none; b=XGLNYwHSdYvFLl+lcGvHlh0q90Gc4F4xZaw0s5YFNbJq9elJJozE5UHIUBXfjLvoSXdTzwTkDvVE953mYIYpSaFIWIhB1wqauYg/dU3BN/SVmh61fj3+6rJZ8iibs/3Ng3xDXlXpNiDtLJqyp2ZF2IG4NGEz3At6vghc1bPyvBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754455741; c=relaxed/simple;
	bh=hE1jzhCIqDyIWqjL9YCdSp48W9E82NKQr3N/AJyoveA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rMtQ/bpVsAS1FF7AiyK4Vn9yx5gTI/ghkGKo8kJcr56GRPU2msPBc6ERg6J+tQT5CCki0MbVfIZmxyJvQ2L1wwfhrxXtAuHqzmTsBzlScTRhqQd9MtUDkDWVa+EHIWqy1pK5V0VnWuQuiC4G4yyi3ZJLkGXs+HKcKEDPTCRn7BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=Vsb5mhdU; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bxd9N0mCsz9tBc;
	Wed,  6 Aug 2025 06:48:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1754455736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iOcmob/KBJLyEb2W1q46NfuHtAS0YPNzHthf2+pOIlc=;
	b=Vsb5mhdUdVEPX9SNJKEOEnQHNvxL9oBMRd+iNbJvgkhG01xY7rtkxgS+BVLBlhMHlgJSE/
	sfONYwyky1IDUj8vDvU7jHojb8o9Lh4t0aiXZ6Cyja8H85MExcD8SRgbHle0T1019L6l0I
	aZmaE73bboQVYFUVams1dAE6ofnUP8I2wge34by98bqxGH1nh/e8qxAfBxldJQYPBXYags
	CNzh6B7btQciNUY/44Av+vjikDPGb5kgJCI5LNYBZn5elMN5nlsXwd50P85Qik99an0hS2
	X9udLBs9SvYStfFR0W0zD3ECKYEKD+aHu6+fXogkbp270HI2Ocd8BuJfsei1Ug==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Wed, 06 Aug 2025 14:48:30 +1000
Subject: [PATCH 2/2] vfs: output mount_too_revealing() errors to fscontext
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-errorfc-mount-too-revealing-v1-2-536540f51560@cyphar.com>
References: <20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>
In-Reply-To: <20250806-errorfc-mount-too-revealing-v1-0-536540f51560@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: David Howells <dhowells@redhat.com>, linux-api@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1639; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=hE1jzhCIqDyIWqjL9YCdSp48W9E82NKQr3N/AJyoveA=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMWRMurdqu8mTilSu2XnRAn46Wkv11ng98lwunXTgR4uf5
 YrwgN07OkpZGMS4GGTFFFm2+XmGbpq/+Eryp5VsMHNYmUCGMHBxCsBEmKMZ/pfsad/37aH/j/J7
 Mn1drm8ZNwTdKj0WNC/l6hR2YZ/MV1cZ/kqlf1P/x9FsENJq/Pb5bWdXQ5lVPc1/F5zwfWBlGx6
 zgQkA
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386

It makes little sense for fsmount() to output the warning message when
mount_too_revealing() is violated to kmsg. Instead, the warning should
be output (with a "VFS" prefix) to the fscontext log. In addition,
include the same log message for mount_too_revealing() when doing a
regular mount for consistency.

With the newest fsopen()-based mount(8) from util-linux, the error
messages now look like

  # mount -t proc proc /tmp
  mount: /tmp: fsmount() failed: VFS: Mount too revealing.
         dmesg(1) may have more information after failed mount system call.

which could finally result in mount_too_revealing() errors being easier
for users to detect and understand.

Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 fs/namespace.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 55f28cebbe7d..b2146857cbbd 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3820,8 +3820,10 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	int error;
 
 	error = security_sb_kern_mount(sb);
-	if (!error && mount_too_revealing(sb, &mnt_flags))
+	if (!error && mount_too_revealing(sb, &mnt_flags)) {
 		error = -EPERM;
+		errorfcp(fc, "VFS", "Mount too revealing");
+	}
 
 	if (unlikely(error)) {
 		fc_drop_locked(fc);
@@ -4547,7 +4549,7 @@ SYSCALL_DEFINE3(fsmount, int, fs_fd, unsigned int, flags,
 
 	ret = -EPERM;
 	if (mount_too_revealing(fc->root->d_sb, &mnt_flags)) {
-		pr_warn("VFS: Mount too revealing\n");
+		errorfcp(fc, "VFS", "Mount too revealing");
 		goto err_unlock;
 	}
 

-- 
2.50.1


