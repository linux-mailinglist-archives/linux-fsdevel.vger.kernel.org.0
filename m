Return-Path: <linux-fsdevel+bounces-68972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DF300C6A6E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 16:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9B283361381
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 15:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5F9369993;
	Tue, 18 Nov 2025 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gmu7UvuW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B174C364EB2
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763481005; cv=none; b=krsokXnFZOlpjWJbgLwsXo3qoTuxqt5Le8BDGYglX2+Yxtx8DkvMt+nV4jKn6VCeh89zFBTXLuwb7qIgVTVEcXSkkvNwEy2gcNu7i3RGq+jsGtV3USQytSk4tcveVucTOJwg/7XiTciDirK1SmFEO3ut3zL/oUTG1lXEPMNOz3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763481005; c=relaxed/simple;
	bh=dZ6+ycUR+/qkBehlOnDqV1Ur+HuI4YNVJe6s9BIQYbc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F91cnGNum4QbG1njbsfC0o2VZBcCbLGDrDC+a+R869iGOGAoZ1ph1ysf1TumugPFxjJHcA5bwywiekNTA8K+yw5NuAmaqF2TvWmR47bQqc/8Nn4ZOsT7v8o/V0OSRpMO+3L+pkoNZbWRlpNPq6bGDCyKt86znzCOV6/6+9T2VvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gmu7UvuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470E2C19424;
	Tue, 18 Nov 2025 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763481003;
	bh=dZ6+ycUR+/qkBehlOnDqV1Ur+HuI4YNVJe6s9BIQYbc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Gmu7UvuW7WheDsla1Ntwy/X7gSoxoJ+PxEnmklEjTO4sAlejM6RgbMaUbna1tDnPb
	 ioP//oj/m6k9V+1RmblG/Qp2hQh2tcCJuhtcV5adpm2XSxiEUtCiZau9pic/jFGlLD
	 XE+F2+Zf1Zdd+rNIDyClw8zP2YQskLpKHfwFBSFfzsN4Qeyl+JVO/0cQYxoUYhEp4D
	 ZhKcM5ONVwh9HL1sQigBx1AyJ0v1s2KGSMDJ5OY9I6nFPXDs14q4ZYWizOu/Rf2tLw
	 +Sl102RiVPQP2iP0ImC7K9pPm2Qtl30VNOdS1VCBSUOu/RiR8mhLCJClOia8p2UMKM
	 iKFtAPnDjLO/w==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 18 Nov 2025 16:48:53 +0100
Subject: [PATCH DRAFT RFC UNTESTED 13/18] fs: open
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251118-work-fd-prepare-v1-13-c20504d97375@kernel.org>
References: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
In-Reply-To: <20251118-work-fd-prepare-v1-0-c20504d97375@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1193; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dZ6+ycUR+/qkBehlOnDqV1Ur+HuI4YNVJe6s9BIQYbc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKTO2fdX1BC/uKM8eeB56OuiuZZPJUkifKe96SDeff9
 +1T1pA27yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIwgyG//WLzO9Yf4/Z8UFW
 V/Vltr7W2tbNsqrCqhv7t//gl6hOt2dkOB128phJcMmCgDR56dMi1ae4E/+9kXQ6PN0rdUNQ3fI
 cLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Placeholder commit message.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/open.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 3d64372ecc67..56f6b485483b 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1422,7 +1422,7 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 {
 	struct open_flags op;
 	struct filename *tmp;
-	int err, fd;
+	int err;
 
 	err = build_open_flags(how, &op);
 	if (unlikely(err))
@@ -1432,18 +1432,12 @@ static int do_sys_openat2(int dfd, const char __user *filename,
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-	fd = get_unused_fd_flags(how->flags);
-	if (likely(fd >= 0)) {
-		struct file *f = do_filp_open(dfd, tmp, &op);
-		if (IS_ERR(f)) {
-			put_unused_fd(fd);
-			fd = PTR_ERR(f);
-		} else {
-			fd_install(fd, f);
-		}
-	}
+	FD_PREPARE(fdprep, how->flags, do_filp_open(dfd, tmp, &op));
 	putname(tmp);
-	return fd;
+	if (fd_prepare_failed(fdprep))
+		return fd_prepare_error(fdprep);
+
+	return fd_publish(fdprep);
 }
 
 int do_sys_open(int dfd, const char __user *filename, int flags, umode_t mode)

-- 
2.47.3


