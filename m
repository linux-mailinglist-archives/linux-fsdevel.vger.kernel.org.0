Return-Path: <linux-fsdevel+bounces-69432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C24AC7B325
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 19:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D94274EDEC5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Nov 2025 18:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389DC350A21;
	Fri, 21 Nov 2025 18:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAUJWfYU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976C6351FBA
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Nov 2025 18:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763748123; cv=none; b=BAGkWlzYQxfOZiR8pHgk+LOOzlQ0DrYpFdZ4MHpCPdt4sNiQogE3R1H4l+QPqTESFrxSs5yrP0RUXkM0U8TI1NB3Mel/ZxlWsuoCkh5ENfYLrjcy1hpmnskk3jme/pLT/9P3H2IMPatUG6p71yOGQF089bXdELGbBhmN8snLKjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763748123; c=relaxed/simple;
	bh=ioXwu9U6XQtNUTtCZeXPt6EFuORvWUGiMv6CD0QJdy8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p51dObWPep9NLXjgyvHmWQjc5soN+Fm2ZOkwG+cTdMdzx7hpRWUkTvrWt+aOCVg/PKvkbR4IZg4ykx+yptcrXHMgVhz8ngzt4ZluMvZ9RbOTQ5uE9xp4EaY3/4n4E46Xzzul7sdrYoxwgLpd6CVG6ny22TZdJ2/VZ9Ps2utuyNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAUJWfYU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A069C116C6;
	Fri, 21 Nov 2025 18:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763748123;
	bh=ioXwu9U6XQtNUTtCZeXPt6EFuORvWUGiMv6CD0QJdy8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BAUJWfYUpr4Snio9JRYstwIPdSp8yKEldiUneZewJFdN7SYtqPYdb87GeyAq4KrFp
	 kJjmAfiWEFVUGxAmdrP6Le+zc1RFCgNcCqQl7UIjTQKogkANeCcLNYAtAgSlURPVOF
	 OhIuueEP2Gug6ZpZabqgkAWFderdGHU1kSGMCie3l1VQDlZihYIuRVvuSELrfK9uBe
	 wYoW/UgUOtzz2TuuocIreL0Lj22NTB6IWwwAXUIGm7SHqSne65MLZ1qzuOKUtWKOF2
	 IdaJYI9vSTWBWbF+fqnfyB7e0SNVghYFslZNSkc73AsHCNd9Zhy1UXYfjpkln2YSFP
	 Upjg06izZYPOQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Nov 2025 19:01:13 +0100
Subject: [PATCH RFC v3 34/47] spufs: convert spufs_gang_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251121-work-fd-prepare-v3-34-2c6444d13e0e@kernel.org>
References: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
In-Reply-To: <20251121-work-fd-prepare-v3-0-2c6444d13e0e@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ioXwu9U6XQtNUTtCZeXPt6EFuORvWUGiMv6CD0QJdy8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqrLh4pszpVg+nnINWxhLnrvD/B17eL9p4805f237hj
 N/MNj/cO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay+xrDX6GFP16YTOLkNdsx
 RUH2QutVtTTG6CLfXsM9znPYFjw5m8PI0DmLb3sbe5XunQbPRcd3mqput7Au2JnnVzTT6EPm3PA
 3jAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 413076bc7e3f..1ce66b8ffed9 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -501,25 +501,17 @@ static const struct file_operations spufs_gang_fops = {
 static int spufs_gang_open(const struct path *path)
 {
 	int ret;
-	struct file *filp;
-
-	ret = get_unused_fd_flags(0);
-	if (ret < 0)
-		return ret;
 
 	/*
 	 * get references for dget and mntget, will be released
 	 * in error path of *_open().
 	 */
-	filp = dentry_open(path, O_RDONLY, current_cred());
-	if (IS_ERR(filp)) {
-		put_unused_fd(ret);
-		return PTR_ERR(filp);
-	}
-
-	filp->f_op = &spufs_gang_fops;
-	fd_install(ret, filp);
-	return ret;
+	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred()));
+	ret = ACQUIRE_ERR(fd_prepare, &fdf);
+	if (ret)
+		return ret;
+	fd_prepare_file(fdf)->f_op = &spufs_gang_fops;
+	return fd_publish(fdf);
 }
 
 static int spufs_create_gang(struct inode *inode,

-- 
2.47.3


