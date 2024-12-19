Return-Path: <linux-fsdevel+bounces-37833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 455289F80EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 18:02:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D28F5167159
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2024 17:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3319ADA2;
	Thu, 19 Dec 2024 17:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZ0H2u+m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA93919995D
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Dec 2024 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734627708; cv=none; b=qt6HecJi+7Nrjn7XrUjcIZa96lM47O0oE+95JLyQtVIrbd7QgS3CRhlqkv54rVfYFUoEpFN52IDmgks5fkYQZ9ic18Ic8nojH+c8kD8PIIt/9aPg6g9wR6CFmJ8CblsDyWlFgS85cxjg2kt87uPeeeWxmoWms0n7ihlPw16nVZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734627708; c=relaxed/simple;
	bh=Tjk5xlp2zSPVAudyJaBtLb13eQBTJ0dRpAftNzQdMqE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HK5vsJltzjT7NJwHYAb1lfYU3LqEtBxt7zFGlLM3cdTb4p7zDeyA67yH0bzd8kU1fQ5Y1pfVRfJhiE3Fx/g7QacLMGJVtjO9mnmWajXztYMpj6qcT91OLMFNVKuzT2AiDIHH8qR0z1klWttc5HEdaOTbp42f5uCE6TNAyrdwKqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZ0H2u+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EAE6C4CECE;
	Thu, 19 Dec 2024 17:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734627708;
	bh=Tjk5xlp2zSPVAudyJaBtLb13eQBTJ0dRpAftNzQdMqE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UZ0H2u+mdJT6alQhuKLRClz7rxyjbB/1keQDC8SeSh3Vx8M8v6iH7uwFSJ72PuiIO
	 9Ooim7UBG/42DY3AlM5YP0/nyQm4XEjshQ4GPI8C947z5wykyz4zuOMrLSeAFae9CA
	 BJhHOxJmxQS9cJBa1SvoPs4byTSSsuj879fG78ij+OcpOH7/5DT1qPiqJRglm3OA+h
	 AfZmXmEect3RQHBQ2BJoElqR0EvqF0ncEfNspgpcZ7RT/MyCgJaCb2H3iConMwKfqC
	 FkStsXHcYq2tgjk6qJGB2byZl6t0xR5R2j/2g+bVmbv1/afdqBiTsDgFiRmd68ZH3T
	 NjYxNw1McnfOA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 19 Dec 2024 18:01:32 +0100
Subject: [PATCH RFC 1/2] pidfs: allow bind-mounts
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-work-pidfs-mount-v1-1-dbc56198b839@kernel.org>
References: <20241219-work-pidfs-mount-v1-0-dbc56198b839@kernel.org>
In-Reply-To: <20241219-work-pidfs-mount-v1-0-dbc56198b839@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 Miklos Szeredi <miklos@szeredi.hu>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2372; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Tjk5xlp2zSPVAudyJaBtLb13eQBTJ0dRpAftNzQdMqE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSnBFbIM7X+b/nRmfxTLvFPar541hoNiaLzszbImkuL5
 h6YJTK5o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLHpjD8lZucUlb4TJqh9rX8
 487YG7rFJ7fZ6ayM2nj5wPnHs48e8GNk+GZh2aZx+LvG4nfCE5fK9Ya4/fzQxjqhb5t41jOdlZa
 aDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Allow bind-mounting pidfds. Similar to nsfs let's allow bind-mounts for
pidfds. This allows pidfds to be safely recovered and checked for
process recycling.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c        | 10 ++++++++--
 fs/pidfs.c            |  2 +-
 include/linux/pidfs.h |  1 +
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 23e81c2a1e3fee7d97df2a84a69438a677933654..7baffa2ea582dacd0fa70959174fc2a47fb5de1f 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -32,6 +32,7 @@
 #include <linux/fs_context.h>
 #include <linux/shmem_fs.h>
 #include <linux/mnt_idmapping.h>
+#include <linux/pidfs.h>
 #include <linux/nospec.h>
 
 #include "pnode.h"
@@ -2732,8 +2733,13 @@ static struct mount *__do_loopback(struct path *old_path, int recurse)
 	if (IS_MNT_UNBINDABLE(old))
 		return mnt;
 
-	if (!check_mnt(old) && old_path->dentry->d_op != &ns_dentry_operations)
-		return mnt;
+	if (!check_mnt(old)) {
+		const struct dentry_operations *d_op = old_path->dentry->d_op;
+
+		if (d_op != &ns_dentry_operations &&
+		    d_op != &pidfs_dentry_operations)
+			return mnt;
+	}
 
 	if (!recurse && has_locked_children(old, old_path->dentry))
 		return mnt;
diff --git a/fs/pidfs.c b/fs/pidfs.c
index c5a51c69acc86694152ff006743bbfa516a2c1f5..049352f973de38967ad35c6440b9480e7e2e2775 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -510,7 +510,7 @@ static char *pidfs_dname(struct dentry *dentry, char *buffer, int buflen)
 	return dynamic_dname(buffer, buflen, "anon_inode:[pidfd]");
 }
 
-static const struct dentry_operations pidfs_dentry_operations = {
+const struct dentry_operations pidfs_dentry_operations = {
 	.d_delete	= always_delete_dentry,
 	.d_dname	= pidfs_dname,
 	.d_prune	= stashed_dentry_prune,
diff --git a/include/linux/pidfs.h b/include/linux/pidfs.h
index df574d6708d423e2eb2f5154b4a0ead1765d5ad2..7c830d0dec9a7c098f65f98a9b9f605e9108da96 100644
--- a/include/linux/pidfs.h
+++ b/include/linux/pidfs.h
@@ -6,5 +6,6 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags);
 void __init pidfs_init(void);
 void pidfs_add_pid(struct pid *pid);
 void pidfs_remove_pid(struct pid *pid);
+extern const struct dentry_operations pidfs_dentry_operations;
 
 #endif /* _LINUX_PID_FS_H */

-- 
2.45.2


