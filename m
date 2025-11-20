Return-Path: <linux-fsdevel+bounces-69315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDA9C76873
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 23:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D422B4E3EB0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Nov 2025 22:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A025362135;
	Thu, 20 Nov 2025 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQiYI7tJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 942FE27B349
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Nov 2025 22:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763678010; cv=none; b=pTiQTAw4pGi27ZfEWM9jg9uDISIw1PE9AcoCKuW5W+vcz0M6p+UeD5rrgI7PLry7eNXY4HncDuy+plU3HfWvuakkvUqoN3pPuh+SKNmfXSTQ1b/s8ADzQJObKmzzph1pUVVnYYsloRzHDoJPNNOP7HAuYdmYYONI9kBkzSBa75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763678010; c=relaxed/simple;
	bh=DfuHXRuHCVnXkLlaz1aCPb6tk7fmY18KDZ+JnX7muXQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QpTw0YnQwkJ4XQMrBimskf4Ft6PUGIxFyKMPTVmjjlEeA9s/qoimMmhh6fDbO0x4sLyq1yViG7LPekjFrkapIemKsYFSA9VA19D5o+WQksWXTFSKFdKg5bq/P/IKQLWl9MURoLtc/NE8+WO9pw3zsPEpYe5Ob+hLH1zk/t6hndA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQiYI7tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D107C116B1;
	Thu, 20 Nov 2025 22:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763678010;
	bh=DfuHXRuHCVnXkLlaz1aCPb6tk7fmY18KDZ+JnX7muXQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pQiYI7tJgs7XTUdBJLvmKMew1YoTDzxBj4xaYXkHAnzxxtvVNbpdUeW483YcRLXuA
	 qLT7mNy0zv6uUtfesW/iTdXTYXRS4/AChVzKuN7xszsY509jr/fQoyiKkObDM/MAlk
	 G1lHrrgLfJrReftqKFqxddvXORtEviEkT/e3GJeqKBlis4hBr83btapOaJSEZzayOA
	 8hJHvIGJ5+u4/xEuGW8fH7CEpV3yK7YqxuXF7TCOeoxaVClx49akVTuCTzPk9xbdU/
	 abxNruA6JlfhjjKd0+b8VirfgznXXN4peY3Id1DJPE6ykRM+UrQaodMQBZpVCfCVzS
	 8N2Na0E8uk6ig==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 20 Nov 2025 23:32:32 +0100
Subject: [PATCH RFC v2 35/48] spufs: convert spufs_gang_open() to
 FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-work-fd-prepare-v2-35-fef6ebda05d3@kernel.org>
References: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
In-Reply-To: <20251120-work-fd-prepare-v2-0-fef6ebda05d3@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Jens Axboe <axboe@kernel.dk>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1278; i=brauner@kernel.org;
 h=from:subject:message-id; bh=DfuHXRuHCVnXkLlaz1aCPb6tk7fmY18KDZ+JnX7muXQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTKT3vX9iracn5LRQ1L2yN/c6UTxaa7lxUJPWxJvrb2M
 vddE9GLHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPR72dk+Nsobrbj84u6rZPv
 P7wnUHuqf7rM+/mzF96YWXuqa/m/YxyMDHOWzCjMYNh0zmTepMlmNrvEd27ZzaO0SGqL/GZ9CT3
 Gn/wA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 arch/powerpc/platforms/cell/spufs/inode.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/cell/spufs/inode.c b/arch/powerpc/platforms/cell/spufs/inode.c
index 856f62aba854..5c3bb53820cb 100644
--- a/arch/powerpc/platforms/cell/spufs/inode.c
+++ b/arch/powerpc/platforms/cell/spufs/inode.c
@@ -499,26 +499,17 @@ static const struct file_operations spufs_gang_fops = {
 
 static int spufs_gang_open(const struct path *path)
 {
-	int ret;
-	struct file *filp;
-
-	ret = get_unused_fd_flags(0);
-	if (ret < 0)
-		return ret;
-
 	/*
 	 * get references for dget and mntget, will be released
 	 * in error path of *_open().
 	 */
-	filp = dentry_open(path, O_RDONLY, current_cred());
-	if (IS_ERR(filp)) {
-		put_unused_fd(ret);
-		return PTR_ERR(filp);
-	}
+	FD_PREPARE(fdf, 0, dentry_open(path, O_RDONLY, current_cred())) {
+		if (fd_prepare_failed(fdf))
+			return fd_prepare_error(fdf);
 
-	filp->f_op = &spufs_gang_fops;
-	fd_install(ret, filp);
-	return ret;
+		fd_prepare_file(fdf)->f_op = &spufs_gang_fops;
+		return fd_publish(fdf);
+	}
 }
 
 static int spufs_create_gang(struct inode *inode,

-- 
2.47.3


