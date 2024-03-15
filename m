Return-Path: <linux-fsdevel+bounces-14522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3073587D367
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:12:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F991C20BAC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5958050A7E;
	Fri, 15 Mar 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="OD3jZxwC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07D34D13B;
	Fri, 15 Mar 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526301; cv=none; b=J7MoXq5Ubl566R1KIGIxrrpKTu5meRohbnkG1xg29HaXZPyILIgZQhQuUSpEjJIgOkTMTEURA2QLtHtOIRBFgNkNYedY+qtHp58VQk4Z5+9NWfg9Wf8tzsof1MB4LWgkD4qtCgekSxvYLtRoSKAHNMkeKiGXIjkQJietQf6oaUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526301; c=relaxed/simple;
	bh=av+LO3pCFDRpgY7P1nu9SdAbRzagRbYwt2rIz+Cgj/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nx0LZ3//Qbig3r9g8euji+kivhIgoRC10sbpSwHDdTh5p8NKNtkZXJZn0MSEzSm431UJwXYD3FgZ6Du1YsfkzgWCVA3exG34CA6JtvIqDflL4+tGboX1qG+VxqcJbyubBt0Zv7Jc0020Q8wvMYtkPHi7oD/OZMTEaHSKzj/3Pgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=OD3jZxwC; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710526295;
	bh=av+LO3pCFDRpgY7P1nu9SdAbRzagRbYwt2rIz+Cgj/8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OD3jZxwC+FqX8IcDG2x1uL6bhvabCVY1qk3pDF/wV7PcuOjIgawHBeqnUMd5XwNnk
	 XCoL9XQwy0AYlgMdrgE1fo0HBnu7rzTj+KafnRaxEbKoPWfSC2klW0x+sdfhYkZJNA
	 J0elsOmulDVo3ZeGRwQ+OVxYkZDbZe2BNQj52oMs=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 19:11:30 +0100
Subject: [PATCH v3 1/2] sysctl: treewide: drop unused argument
 ctl_table_root::set_ownership(table)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240315-sysctl-const-ownership-v3-1-b86680eae02e@weissschuh.net>
References: <20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>
In-Reply-To: <20240315-sysctl-const-ownership-v3-0-b86680eae02e@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710526294; l=3835;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=av+LO3pCFDRpgY7P1nu9SdAbRzagRbYwt2rIz+Cgj/8=;
 b=/F06c2EJiWGR1f+P1HpCb7VAwJpzrdnOwXaMr5dC/J/axq7JcENhUxIxB79TjfmogI3LQqTY2
 e4nU4U6SQfoBdvFWisQ4l4iMp/1tJkIVslkveD0MdFsz9205ZIMY9r2
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The argument is never used and can be removed.

In a future commit the sysctl core will only use
"const struct ctl_table". Removing it here is a preparation for this
consitifcation.

The patch was created with the following coccinelle script:

  @@
  identifier func, head, table, uid, gid;
  @@

  void func(
    struct ctl_table_header *head,
  - struct ctl_table *table,
    kuid_t *uid, kgid_t *gid)
  { ... }

The single changed location was validate through manual inspection and
compilation.

In addition, a search for 'set_ownership' was done over the full tree to
look for places that were missed by coccinelle.
None were found.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 fs/proc/proc_sysctl.c  | 2 +-
 include/linux/sysctl.h | 1 -
 ipc/ipc_sysctl.c       | 3 +--
 ipc/mq_sysctl.c        | 3 +--
 net/sysctl_net.c       | 1 -
 5 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 37cde0efee57..ed3a41ed9705 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -480,7 +480,7 @@ static struct inode *proc_sys_make_inode(struct super_block *sb,
 	}
 
 	if (root->set_ownership)
-		root->set_ownership(head, table, &inode->i_uid, &inode->i_gid);
+		root->set_ownership(head, &inode->i_uid, &inode->i_gid);
 	else {
 		inode->i_uid = GLOBAL_ROOT_UID;
 		inode->i_gid = GLOBAL_ROOT_GID;
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee7d33b89e9e..60333a6b9370 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -205,7 +205,6 @@ struct ctl_table_root {
 	struct ctl_table_set default_set;
 	struct ctl_table_set *(*lookup)(struct ctl_table_root *root);
 	void (*set_ownership)(struct ctl_table_header *head,
-			      struct ctl_table *table,
 			      kuid_t *uid, kgid_t *gid);
 	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
 };
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 45cb1dabce29..1a5085e5b178 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -192,7 +192,6 @@ static int set_is_seen(struct ctl_table_set *set)
 }
 
 static void ipc_set_ownership(struct ctl_table_header *head,
-			      struct ctl_table *table,
 			      kuid_t *uid, kgid_t *gid)
 {
 	struct ipc_namespace *ns =
@@ -224,7 +223,7 @@ static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *tabl
 		kuid_t ns_root_uid;
 		kgid_t ns_root_gid;
 
-		ipc_set_ownership(head, table, &ns_root_uid, &ns_root_gid);
+		ipc_set_ownership(head, &ns_root_uid, &ns_root_gid);
 
 		if (uid_eq(current_euid(), ns_root_uid))
 			mode >>= 6;
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 21fba3a6edaf..6bb1c5397c69 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -78,7 +78,6 @@ static int set_is_seen(struct ctl_table_set *set)
 }
 
 static void mq_set_ownership(struct ctl_table_header *head,
-			     struct ctl_table *table,
 			     kuid_t *uid, kgid_t *gid)
 {
 	struct ipc_namespace *ns =
@@ -97,7 +96,7 @@ static int mq_permissions(struct ctl_table_header *head, struct ctl_table *table
 	kuid_t ns_root_uid;
 	kgid_t ns_root_gid;
 
-	mq_set_ownership(head, table, &ns_root_uid, &ns_root_gid);
+	mq_set_ownership(head, &ns_root_uid, &ns_root_gid);
 
 	if (uid_eq(current_euid(), ns_root_uid))
 		mode >>= 6;
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 051ed5f6fc93..a0a7a79991f9 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -54,7 +54,6 @@ static int net_ctl_permissions(struct ctl_table_header *head,
 }
 
 static void net_ctl_set_ownership(struct ctl_table_header *head,
-				  struct ctl_table *table,
 				  kuid_t *uid, kgid_t *gid)
 {
 	struct net *net = container_of(head->set, struct net, sysctls);

-- 
2.44.0


