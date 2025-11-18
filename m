Return-Path: <linux-fsdevel+bounces-68963-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 21C86C6A6CA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:54:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B91E4F3AE4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10321368280;
	Tue, 18 Nov 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltUqSRH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED5B34DB67
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480986; cv=none; b=n8JB84gVE68TBGtnHrqgsEkM7KzCG6/AneW8ndVZQ9AP0SrlRWqBd6Hva4hlcDLoYw6l51YvfQl2Ih3oyDjvds8ZhPFAjoJiczwrWHkAUKgaIg3IHn1xqfdam9o7NTWh8huBRsvet/JFx+SZVEDMK89thL0wKapz+spF86okLtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480986; c=relaxed/simple;
	bh=nJcmeBr9XPX88DGYvg5+cM71dsWYPIeOfJLZP1JU0KQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KzTqOw6LqTH7ip9Me1R4iYgFnr4BOJB6GXT8NRnd48ZcOEsIR91HoUToJkEhO6GaNFq4agM/yRnD9GzdZbx/HmByRhPodFzSqgEZckVBZUBQcHCJUi+QuteLHC/LnoaKva6keazVV9ZQ11g6tk51LnpsPbFiE8UJ9PjGnYIAjJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltUqSRH1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE3DC2BC87;
	Tue, 18 Nov 2025 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480985;
	bh=nJcmeBr9XPX88DGYvg5+cM71dsWYPIeOfJLZP1JU0KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ltUqSRH1br/hfM0NqCaWl2aSMe5iYGGta5ZMmOxjqtzxU/fQtsGzVXy5TYjzYcjkL
	 pYNt3JzUOl0PkRYfEBSrYhUy382GlfyQQ/JnBSWYUIctYwC/javtcuFhmmW90gYS8D
	 83dYKIJWchg7MI4oxdkf3sCUfSs+WfBY0S/ugS1KVQPm/puPHko3giRGtOMk2DWTxI
	 M11r71IVjyosy3oYirX5JMrqDiFKti+aDackjzsbnNSfNyaVocrRYl8TOY/+gNtaVb
	 9vqxCMmqnhY3bRe2OWDS1mF6g23ckW53lXf1trC16WRCG3s+2zS5h49i/v8hVQKdVY
	 Kv/Q6IGP/yORw==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:44 +0100
Subject: [PATCH DRAFT RFC UNTESTED 04/18] fs: fhandle
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-4-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1587; i=brauner@kernel.org;
 h=from:subject:message-id; bh=nJcmeBr9XPX88DGYvg5+cM71dsWYPIeOfJLZP1JU0KQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO0raF37pE6j5OzX3r4b+9ydX+xtvLb2bdFTnjzLj
 sfvnJfYd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykWYvhf8yMhzdvZq3h/2kq
 zmi0bc6G5KLQ6SFb303RZOCIX9bp7sXwP1Wjny+o5fOWTnXOnw9kuzIeKk+9c3xqVmnN8Vc5N+L
 FWQE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/fhandle.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 052f9c9368fb..fd46ecb014ea 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -404,32 +404,32 @@ static int handle_to_path(int mountdirfd, struct file_handle __user *ufh,
 	return retval;
 }
 
+static struct file *file_open_handle(struct path *path, int open_flag)
+{
+	const struct export_operations *eops;
+
+	eops = path->mnt->mnt_sb->s_export_op;
+	if (eops->open)
+		return eops->open(path, open_flag);
+
+	return file_open_root(path, "", open_flag, 0);
+}
+
 static long do_handle_open(int mountdirfd, struct file_handle __user *ufh,
 			   int open_flag)
 {
 	long retval = 0;
 	struct path path __free(path_put) = {};
-	struct file *file;
-	const struct export_operations *eops;
 
 	retval = handle_to_path(mountdirfd, ufh, &path, open_flag);
 	if (retval)
 		return retval;
 
-	CLASS(get_unused_fd, fd)(open_flag);
-	if (fd < 0)
-		return fd;
-
-	eops = path.mnt->mnt_sb->s_export_op;
-	if (eops->open)
-		file = eops->open(&path, open_flag);
-	else
-		file = file_open_root(&path, "", open_flag, 0);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	FD_PREPARE(fdprep, open_flag, file_open_handle(&path, open_flag));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
-	fd_install(fd, file);
-	return take_fd(fd);
+	return fd_publish(fdprep);
 }
 
 /**

-- 
2.47.3


