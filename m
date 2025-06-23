Return-Path: <linux-fsdevel+bounces-52500-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6C8AE3953
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:03:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0EC73A542B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDFD235041;
	Mon, 23 Jun 2025 09:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcH2friP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B804823026B;
	Mon, 23 Jun 2025 09:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750669305; cv=none; b=JLk6lRcOMWjGn4yo9Ud+xqo+Bz9VgRWzWBx+mdrxep5dBb1OPFgwIszXinVHDXwwu2Z/xuVxuPL5b0KiaZrNVIZd2i1MARaWcUSkEiVsR0wrNMqP3KxelK3RQeIImjJ/GsMpuQclxXVAqf//oCHhpj8SH3XydC0G+0qto3BQK4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750669305; c=relaxed/simple;
	bh=ARob3MxlwDJhO90EpUhcCvz/Odz1epB9ZJ0UB1eI46w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q9wNeF5LhAKXUIAP5oGw3R2sr1X3QeJGWzMGCs53xYdUk4j4oVwm0Uql8GOiIMKv0d+Qd1Q3Uh6nxw30hxeZ9v728RYp11ogvx7o+ZZv35AvFecG0k3XLh/TUeknFmvNST5yYqeSDwPsPKCUcu+9KB25XbrUA8M9igR9WE7yJK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcH2friP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54EEDC4CEEA;
	Mon, 23 Jun 2025 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750669305;
	bh=ARob3MxlwDJhO90EpUhcCvz/Odz1epB9ZJ0UB1eI46w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rcH2friPJsPUXaHY5NqmG2jfOYc4HgQmPuteaJ42ht3TlBGNGaB/tEmmSYLtW9x5j
	 H4t2jNX4dH/t1LTBIGni6f3+fn+MVVo195KEqs9ukPHFA0kk276ece1JCa8bTV0wCz
	 XjeDQUG+3SVedID2eO7lmmmotZVMtmEpKLaHhUX6ijXJzO48nWGeSUAwgZ8WFGRO5/
	 rEd9Uh33UjnNWrOXOk4OdxBdCIhB0P7TRVCzEa1yG5O8Lt4hVUF13EeaLkP80TU8bl
	 BrYbC+VIJQRzTfd/nASDsbGTQoI2sB8Ad+0uUXhZ2kEYx9Zhjgrmv4dcqGfmggjNMM
	 6CprZYj8SsNNg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 23 Jun 2025 11:01:26 +0200
Subject: [PATCH 4/9] pidfs: add pidfs_root_path() helper
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250623-work-pidfs-fhandle-v1-4-75899d67555f@kernel.org>
References: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
In-Reply-To: <20250623-work-pidfs-fhandle-v1-0-75899d67555f@kernel.org>
To: Jeff Layton <jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, 
 Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1415; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ARob3MxlwDJhO90EpUhcCvz/Odz1epB9ZJ0UB1eI46w=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWREir9eJrHyXksg6z7FLVYqzYFS1y4cNNFaMGVS1zwZ7
 1/CFzRzO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay/QjDP2Wfiwu2rtxeUcr3
 wTvjwA7T734/1x380fFPiif6uI/JkfeMDE8tJtZomSguV9Xa/mbLhz9PbWU1tE8bHdNLzv/Fbi5
 zgRcA
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
index 1cf66fd9961e..1b7bd14366dc 100644
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
@@ -1065,4 +1073,7 @@ void __init pidfs_init(void)
 	pidfs_mnt = kern_mount(&pidfs_type);
 	if (IS_ERR(pidfs_mnt))
 		panic("Failed to mount pidfs pseudo filesystem");
+
+	pidfs_root_path.mnt = pidfs_mnt;
+	pidfs_root_path.dentry = pidfs_mnt->mnt_root;
 }

-- 
2.47.2


