Return-Path: <linux-fsdevel+bounces-52699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78C3DAE5F52
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 10:31:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BE7F3B2554
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jun 2025 08:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B59F825A341;
	Tue, 24 Jun 2025 08:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pW7XBaTo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE6F19D88F;
	Tue, 24 Jun 2025 08:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750753780; cv=none; b=WsSmsG0QwJY+htSDDOnQQr4OvTKs5l3TwkV5FKwiItNPDWtjVpEEAhpe24cbhtnAeNplGGTFvpl+WM6DXm6d1EqYi/rXCjS8YP/2ry/m0y/OH1qmCNwe01dLZMPjyvEumI3X4mpx9zQOu7CCLbPBrRH23nlJzct1gPLKKErqi2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750753780; c=relaxed/simple;
	bh=SP9TQRs4uydYgBdShahOfBSj6uuWIvWexNBcO0MX+ts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uQUaFGpxQW1fbi9tZ0tSKmVki6BXji+yU+swu32siMnGxxH6yB6hzzrBP6G6cBFmuNbmaUSL+o6pH8NMLWsGskSNrQSYnY2ilVt7QSfO1vv3IsHnwcvfmypgJgwsLjTJ9KSVemZckB9zTMTQccsONa9fAwC/dssSp+zs7/5/ebc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pW7XBaTo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06B9FC4CEE3;
	Tue, 24 Jun 2025 08:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750753779;
	bh=SP9TQRs4uydYgBdShahOfBSj6uuWIvWexNBcO0MX+ts=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pW7XBaToTf0XJbqpzmdCppP19+mLsF1g0OjZTR6TH7takhgUmZGCA1jpn2GCDmWk6
	 f9B8wh3AQeJ6OE/QY30cZm/7GuA8oe6O5a/zuPHtW50caWSvj4bEoMt85W8HT9/7uK
	 0Xo4ZGtEWzcPp1oX1AS+S15GOcWlxoKe8QQRlgdiChKOZmLt8AgBaL8mfZYfK9IW39
	 gGvGoQ/NcFnbD+iYdiUeY0Vvc4jsqCQ27ckF5EK7JRom5Uq55tnqggv7KLxgTrRhYj
	 61IoUFEMcmytJr07SrYPmZ7n43Qh4mNxzW/l317to/mDSwr9YT6zSyGg+Vuq07fDZH
	 kBHA2uhKiPS1A==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 24 Jun 2025 10:29:07 +0200
Subject: [PATCH v2 04/11] pidfs: add pidfs_root_path() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-work-pidfs-fhandle-v2-4-d02a04858fe3@kernel.org>
References: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
In-Reply-To: <20250624-work-pidfs-fhandle-v2-0-d02a04858fe3@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SP9TQRs4uydYgBdShahOfBSj6uuWIvWexNBcO0MX+ts=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREJb7QZbwqKXvr75agi208SXJVn9t28r3RbFc4ILri5
 kI1scXnO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbCF8zIsDyWgfml6sSNJxpU
 o+uFT3/8e1nDuG6n9hTdjn+664TWKTMy9NasKy1OkHvOV+Vsel1Rks383oO0Z3ZVXc82r2lY/zK
 EHwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow to return the root of the global pidfs filesystem.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/internal.h |  1 +
 fs/pidfs.c    | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/fs/internal.h b/fs/internal.h
index 22ba066d1dba..ad256bccdc85 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -353,3 +353,4 @@ int anon_inode_getattr(struct mnt_idmap *idmap, const struct path *path,
 		       unsigned int query_flags);
 int anon_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		       struct iattr *attr);
+void pidfs_get_root(struct path *path);
diff --git a/fs/pidfs.c b/fs/pidfs.c
index ba526fdd4c4d..69b0541042b5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -31,6 +31,14 @@
 static struct kmem_cache *pidfs_attr_cachep __ro_after_init;
 static struct kmem_cache *pidfs_xattr_cachep __ro_after_init;
 
+static struct path pidfs_root_path = {};
+
+void pidfs_get_root(struct path *path)
+{
+	*path = pidfs_root_path;
+	path_get(path);
+}
+
 /*
  * Stashes information that userspace needs to access even after the
  * process has been reaped.
@@ -1066,4 +1074,7 @@ void __init pidfs_init(void)
 	pidfs_mnt = kern_mount(&pidfs_type);
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");
+
+	pidfs_root_path.mnt = pidfs_mnt;
+	pidfs_root_path.dentry = pidfs_mnt->mnt_root;
 }

-- 
2.47.2


