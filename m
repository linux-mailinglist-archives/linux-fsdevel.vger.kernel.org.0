Return-Path: <linux-fsdevel+bounces-25128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4136894952B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 18:05:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DEB021F25221
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Aug 2024 16:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF8213B288;
	Tue,  6 Aug 2024 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BZIZeCRX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2898B4CB5B
	for <linux-fsdevel@vger.kernel.org>; Tue,  6 Aug 2024 16:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722960162; cv=none; b=lwhR111O7YfWDar3ROUeHymD1n/fonqdzq2h8yTlL5qwzQsAya2Iua5N76niil07prfqPiS8z44OvWykO0lMZDAJbKgHP4+tx/8lkF4j9PQNxMwC1UoH5GN2C3/rVmd6lipdN/JXxZldqEo2IxhcSzTEcoNfRGqp0nJqTVtNqew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722960162; c=relaxed/simple;
	bh=5Hspo1wRi7bgaz5mDUcuHrEK9HemY9nNPtcpwLwfDMw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mrgMacD+u0PfbWZNqbf9FTMjlJ/xAM6ldlFOyPYziEJFEJKzRW/nGWmjfs1U9W/tcjYi00hGgeOvNYRZ0zBbGleKybS/k80nr1q0EAC4D/NA49ozU174shHqMCTlIstE9W+iTNUOA0okNVXY+jz9c+LKaNrJOrXa+0Eok+VgLVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BZIZeCRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BED5C4AF0C;
	Tue,  6 Aug 2024 16:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722960161;
	bh=5Hspo1wRi7bgaz5mDUcuHrEK9HemY9nNPtcpwLwfDMw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BZIZeCRXW2F2okTSJk/92J5mdHWqHR3gkgOvDRiya+lwwPfQxD2B9SJrYeAccG/nI
	 m2v2ZOSXjFESptzma4r+k+TZIZv31ZPL7EJ9EDEaLUd4m1flH38eKut5p6wcq0gj8R
	 NSGNLDq3yXFb9a4QtGxD43NnisNMRYy6tZ79pKnMbqLdIMxPHYH1bI8QHA6wQ1ScYR
	 744rITnQXXuHQz+4Hd62Rsliaa59b74sNTYEB+1PZjKNGXAtgGIeokfg6Gc+Gi//E8
	 dToTt7zDPil/wtlExOM9mnSXj1/by26QpW7Vj6hp4iTe9W//82UHts0+UzCCdTwNu0
	 8yuv+fFjmtfag==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 06 Aug 2024 18:02:28 +0200
Subject: [PATCH RFC 2/6] proc: proc_readfdinfo() ->
 proc_fdinfo_iterate_shared()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240806-work-procfs-v1-2-fb04e1d09f0c@kernel.org>
References: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
In-Reply-To: <20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Aleksa Sarai <cyphar@cyphar.com>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-37811
X-Developer-Signature: v=1; a=openpgp-sha256; l=1063; i=brauner@kernel.org;
 h=from:subject:message-id; bh=5Hspo1wRi7bgaz5mDUcuHrEK9HemY9nNPtcpwLwfDMw=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGaySRuhJxemDHuA4tpKDax94UUdfkej7Opob9fG1NvdI3ZlZ
 4h1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmaySRsACgkQkcYbwGV43KIdOQD/Vdkq
 PRnEn6t06ri50vJjGGdoHiQOJdEcAb+gnIGdKkEA/0pQCUSbrKCCIlf9qt6YGrArYhLMU9VCvgF
 GfDiWkQAL
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Give the method to iterate through the fdinfo directory a better name.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/proc/fd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/proc/fd.c b/fs/proc/fd.c
index 41bc75d5060c..ab243caf1b71 100644
--- a/fs/proc/fd.c
+++ b/fs/proc/fd.c
@@ -407,7 +407,7 @@ proc_lookupfdinfo(struct inode *dir, struct dentry *dentry, unsigned int flags)
 	return proc_lookupfd_common(dir, dentry, proc_fdinfo_instantiate);
 }
 
-static int proc_readfdinfo(struct file *file, struct dir_context *ctx)
+static int proc_fdinfo_iterate_shared(struct file *file, struct dir_context *ctx)
 {
 	return proc_readfd_common(file, ctx,
 				  proc_fdinfo_instantiate);
@@ -421,6 +421,6 @@ const struct inode_operations proc_fdinfo_inode_operations = {
 
 const struct file_operations proc_fdinfo_operations = {
 	.read		= generic_read_dir,
-	.iterate_shared	= proc_readfdinfo,
+	.iterate_shared	= proc_fdinfo_iterate_shared,
 	.llseek		= generic_file_llseek,
 };

-- 
2.43.0


