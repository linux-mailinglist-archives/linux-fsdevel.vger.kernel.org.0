Return-Path: <linux-fsdevel+bounces-58922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEC5B3357B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C861B22CD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADC7281357;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="X/soGNog"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B4B277C8D
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097042; cv=none; b=DEtm0O7D7Iqj04Cehqe6aOJEewyPMO6POphDXwavvtOZmGmSvwQHs7hdIZG1rpMHG6eTO8GfJxrIQD9iHVf3CbEqhOhv0geEPwqNmntrYF5LXaiwn7dsOda/M+7OZ0/rNSf7m5EQokKFh7fH/RZsZ+43pPqSxtnbJu6lgOx3ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097042; c=relaxed/simple;
	bh=dmsv03gJU13lD4WXCrKBcXS54RAR2B9bWActZtKDFKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VQ5k+5aY5k8dmkBYALWuDqlrBF0xqYoAxxBrMIgzXgoiOp5SpMngGvkB7EaFwu41U/FKKWuHdK+BCLUvcUIOyFsZ4IpMqXxjwItKcFaTgGVhX7YhruRmo1gNpV4B4qr9uLzYEuO/x7a5UGTHsMYkYipVqQTGMNzV95egyPj3tvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=X/soGNog; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EcXc/lTeMX1N5UKQ7Cs00fJ2YqkYLJINtEdwwmDjth8=; b=X/soGNogJMSDdQVsNauDOYZZyX
	E4dr0xmLxWoLd6zSHj6LIvHRGLLrqWxcOk9zFbgLBxZ7u+oJ4YtWbAevWC0rl+RG9y8Nd6fgpplVx
	7uGYOC+6ke3RLv3m/bfDiAaHcdI+ny2QXjR2fCVi0D4BxU8JiOoKFmQIjKSW6XkTHdyVl8E5AZJkt
	9/J4ufrQOsCvRkd+OHFldo1xSCV6EzAdBExPp5jO/+QSq5E393ae0qEWJDoGZ5uWkn/Zbojsog61k
	JYFJFTg+DzRWUDfzmvqpg5cF8ZfLwPLVYQYhqUQlj/EJUq3q9wzg/aHZOWaQo8B1VXvYs5p4snM3K
	BBCWsPQg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TBZ-1dfK;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 23/52] pivot_root(2): use __free() to deal with struct path in it
Date: Mon, 25 Aug 2025 05:43:26 +0100
Message-ID: <20250825044355.1541941-23-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

preparations for making unlock_mount() a __cleanup();
can't have path_put() inside mount_lock scope.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 602612cbd095..892251663419 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4628,7 +4628,9 @@ EXPORT_SYMBOL(path_is_under);
 SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 		const char __user *, put_old)
 {
-	struct path new, old, root;
+	struct path new __free(path_put) = {};
+	struct path old __free(path_put) = {};
+	struct path root __free(path_put) = {};
 	struct mount *new_mnt, *root_mnt, *old_mnt, *root_parent, *ex_parent;
 	struct pinned_mountpoint old_mp = {};
 	int error;
@@ -4639,21 +4641,21 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = user_path_at(AT_FDCWD, new_root,
 			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &new);
 	if (error)
-		goto out0;
+		return error;
 
 	error = user_path_at(AT_FDCWD, put_old,
 			     LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &old);
 	if (error)
-		goto out1;
+		return error;
 
 	error = security_sb_pivotroot(&old, &new);
 	if (error)
-		goto out2;
+		return error;
 
 	get_fs_root(current->fs, &root);
 	error = lock_mount(&old, &old_mp);
 	if (error)
-		goto out3;
+		return error;
 
 	error = -EINVAL;
 	new_mnt = real_mount(new.mnt);
@@ -4711,13 +4713,6 @@ SYSCALL_DEFINE2(pivot_root, const char __user *, new_root,
 	error = 0;
 out4:
 	unlock_mount(&old_mp);
-out3:
-	path_put(&root);
-out2:
-	path_put(&old);
-out1:
-	path_put(&new);
-out0:
 	return error;
 }
 
-- 
2.47.2


