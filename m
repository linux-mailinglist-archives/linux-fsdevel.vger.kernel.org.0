Return-Path: <linux-fsdevel+bounces-68964-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DECBC6A6CE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E40C64F447B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A83E6368289;
	Tue, 18 Nov 2025 15:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paiJtI+7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088B13002B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763480988; cv=none; b=NE2IzyYmkaFRCb662dExk1lt68qlTIMFFKYG20oTwFEKmhjw9zqruqhVuAp8DJwhl1DHMX8OK1IEGJHNmYsnLR5sSA9LhQU/gFCckdwz08YrviMKKYp1C9Mb5g4dJcbey59JEImkb067azFu+uaSuVPWpc9tqTnAUpSzrPGZTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763480988; c=relaxed/simple;
	bh=qwRfNYDLIVh3GuPJCimlfcVvtjn+Dumr6mB8LAOqaqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwnvXpt8JXrqFdHB/FMIx6+OFB1XkyCbrXe9pq+gfVo8uMkm/w17QaqxHVALLImtIsOgbRT9Q3OdUKZkU6WVua9nBOp7OXkLmLxO+KZOS71vbPGQi9v07W2I3531dmq6iGbi0l27mUv+FubJGLXrfiBD/GMctJh95kxXU7Bn4jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paiJtI+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E47C4CEF5;
	Tue, 18 Nov 2025 15:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763480987;
	bh=qwRfNYDLIVh3GuPJCimlfcVvtjn+Dumr6mB8LAOqaqQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=paiJtI+7mGP8VLltw25qnCA8XnsC5FCXWJ01RQ51EvfDlkPeNQGTmEszVZOzchobb
	 Dq8snpusvXtiQBvadLeo6KOGWG/4/ECqjkiklD2QmRNjGzswyIWcS7bpI8joXmdqur
	 gnqPewV+iozGDqx4qhY9HLEyZ/0eh5SHHoAfgtHq+VZXV0DSXrWtfcciC8WE3NH3Tn
	 1//XMzaedwAyDX63UoOn1CDrt5JY92fNhDqc01KdAuiAEbKhgq1EbWzA0ddzhgsuhO
	 myCZw7CmJXlq6ae6vqQJy8SWzp8g/nXNB9F3q5YZB8EXdxZ2mBU7Fblp6si+IcKFAI
	 s7zWAjHg/D37A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:45 +0100
Subject: [PATCH DRAFT RFC UNTESTED 05/18] fs: open_tree()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-5-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=995; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qwRfNYDLIVh3GuPJCimlfcVvtjn+Dumr6mB8LAOqaqQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO2LLdfYFNFyXOTcw7nsvcerHe8Z/nzB81chObyOo
 3vaje3TOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay8SjDf5//yg7zVnQv6FSK
 sk7StHxU1P3B86x58TNvYb8bWt9mqzMynAuufHODK65nwwvRrfpT3/Mzc0vLGy//YpeSsMyqV0q
 PEwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 25289b869be1..a6e170d6692d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3103,19 +3103,11 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 
 SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
 {
-	int fd;
-	struct file *file __free(fput) = NULL;
-
-	file = vfs_open_tree(dfd, filename, flags);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
+	FD_PREPARE(fdprep, flags, vfs_open_tree(dfd, filename, flags));
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
 
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+	return fd_publish(fdprep);
 }
 
 /*

-- 
2.47.3


