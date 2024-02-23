Return-Path: <linux-fsdevel+bounces-12590-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B9486165B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 557021F2614C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2257784A4F;
	Fri, 23 Feb 2024 15:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fybScMnw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765E683CD3;
	Fri, 23 Feb 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703548; cv=none; b=MclbmsEylJ/+elSSdEVIs8LeZqRzamsdONGrL3BqtF17JXtYURZ0P5XotmHt9YrAq0q0fV2aUkOYv4CEZqX3pU3GET3LqHFDq9Qx1v0bIsmh4ByRKV1uhkzcKGK4HBuvfvGP1/sVeEoQCDX1HXeuwR5q0AoVgADVMGoei5Pxq9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703548; c=relaxed/simple;
	bh=AJVRV4R3xLDBDFjd+6gY0ZeJlPma3kEonzIkr6fkN2A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=M7E1kSEFYX7h+5BbeJ8UMZ7FM4E9mABG7vMMCEqowC5iXNVAY8bci+gaAt8rjPWcqvtVK3vQ0AVACec1Gc0yWGyqXECitoXuLov5GN9eP33PoO38RIJ1hnPU8P7Q8y2wec08NiyoG/VU2tx6DCy+rMgcivJKLfwhXgC9sqdR+aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fybScMnw; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708703543;
	bh=AJVRV4R3xLDBDFjd+6gY0ZeJlPma3kEonzIkr6fkN2A=;
	h=From:Date:Subject:To:Cc:From;
	b=fybScMnw6ztjnhJh6//od/yfT0jaQwnJ+PQPrEguV5qVD9RWyBY79psyKosZq0JXO
	 tdebnnV6k3r7NkArILvrTJ/AENRrjGSxtDSp8jzxOi6S452vJk666G4ScMV2OOF/JG
	 y34OmWML47curHhdHlh4EoVN3sun1gi6jf2hexns=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 23 Feb 2024 16:52:16 +0100
Subject: [PATCH v2] sysctl: treewide: constify ctl_table_root::permissions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-sysctl-const-permissions-v2-1-0f988d0a6548@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAC+/2GUC/42NQQ6CMBBFr0Jm7Rg6RAiuvIdhQdrBTqKFdCpKC
 He3cAKX7/+8/1dQjsIK12KFyLOojCEDnQqwvg8PRnGZgUqqDFGNuqhNT7Rj0IQTx5fo7ii6xg6
 upL6pqwayPkUe5HtM37vMXjSNcTmeZrOnf4zOBg1erKtsa4aa2vb24dyp9W9/Dpyg27btB1/ys
 zbFAAAA
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708703543; l=4225;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AJVRV4R3xLDBDFjd+6gY0ZeJlPma3kEonzIkr6fkN2A=;
 b=/fsXRVOZ9LM7U+KZGO0nQmlO8w3CxxklZ9vh2LP8Xz/l1wGHkXNysy0c25wf2b8XLO/onp9DA
 y3GpYbstrrqABs+tZ9Xxl5TjMASUtr/rOwQ19cJCQvnYd9ecEmRyHOX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The permissions callback is not supposed to modify the ctl_table.
Enforce this expectation via the typesystem.

The patch was created with the following coccinelle script:

  @@
  identifier func, head, ctl;
  @@

  int func(
    struct ctl_table_header *head,
  - struct ctl_table *ctl)
  + const struct ctl_table *ctl)
  { ... }

(insert_entry() from fs/proc/proc_sysctl.c is a false-positive)

The three changed locations were validated through manually inspection
and compilation.

In addition a search for '.permissions =' was done over the full tree to
look for places that were missed by coccinelle.
None were found.

This change also is a step to put "struct ctl_table" into .rodata
throughout the kernel.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
To: Luis Chamberlain <mcgrof@kernel.org>
To: Kees Cook <keescook@chromium.org>
To: Joel Granados <j.granados@samsung.com>
To: David S. Miller <davem@davemloft.net>
Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Changes in v2:
- flesh out commit messages
- Integrate changes to set_ownership and ctl_table_args into a single
  series
- Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-permissions-v1-1-5cd3c91f6299@weissschuh.net
---
The patch is meant to be merged via the sysctl tree.

There is an upcoming series that will introduce a new implementation of
.permission which would need to be adapted [0].
The adaption would be trivial as the 'table' parameter also not modified
there.

This change was originally part of the sysctl-const series [1].
To slim down that series and reduce the message load on other
maintainers to a minimumble, submit this patch on its own.

[0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com/
[1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/
---
 include/linux/sysctl.h | 2 +-
 ipc/ipc_sysctl.c       | 2 +-
 kernel/ucount.c        | 2 +-
 net/sysctl_net.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index ee7d33b89e9e..0a55b5aade16 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -207,7 +207,7 @@ struct ctl_table_root {
 	void (*set_ownership)(struct ctl_table_header *head,
 			      struct ctl_table *table,
 			      kuid_t *uid, kgid_t *gid);
-	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
+	int (*permissions)(struct ctl_table_header *head, const struct ctl_table *table);
 };
 
 #define register_sysctl(path, table)	\
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 8c62e443f78b..b087787f608f 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -190,7 +190,7 @@ static int set_is_seen(struct ctl_table_set *set)
 	return &current->nsproxy->ipc_ns->ipc_set == set;
 }
 
-static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
+static int ipc_permissions(struct ctl_table_header *head, const struct ctl_table *table)
 {
 	int mode = table->mode;
 
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 4aa6166cb856..90300840256b 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -38,7 +38,7 @@ static int set_is_seen(struct ctl_table_set *set)
 }
 
 static int set_permissions(struct ctl_table_header *head,
-				  struct ctl_table *table)
+			   const struct ctl_table *table)
 {
 	struct user_namespace *user_ns =
 		container_of(head->set, struct user_namespace, set);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 051ed5f6fc93..ba9a49de9600 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -40,7 +40,7 @@ static int is_seen(struct ctl_table_set *set)
 
 /* Return standard mode bits for table entry. */
 static int net_ctl_permissions(struct ctl_table_header *head,
-			       struct ctl_table *table)
+			       const struct ctl_table *table)
 {
 	struct net *net = container_of(head->set, struct net, sysctls);
 

---
base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
change-id: 20231226-sysctl-const-permissions-d7cfd02a7637

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


