Return-Path: <linux-fsdevel+bounces-6915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B103A81E73B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 13:09:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2561C21DE3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 12:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF39E4E618;
	Tue, 26 Dec 2023 12:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CFIunnvB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6E44E603;
	Tue, 26 Dec 2023 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703592572;
	bh=MBNVPTuPe5RQdDMZSU+PMsj2GQT1HD2VDl2L9fGdf+I=;
	h=From:Date:Subject:To:Cc:From;
	b=CFIunnvBOMZRp7rDzNobSGjsI69fb6XgLdzeWRdW0p2bo7CYt12l1nN+6Ov/ZaW3c
	 BSY5wS2sMOTgBs4vV6NfjGiBU4usMfB0Q3MKCppJl51ibV/O3dAktjSGad3q+ZetGK
	 pBhYzGNoTGanORzXKfJ3yIDR8rAxNcVRAfBmyAQY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 26 Dec 2023 13:08:48 +0100
Subject: [PATCH] sysctl: treewide: constify ctl_table_root::permissions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231226-sysctl-const-permissions-v1-1-5cd3c91f6299@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAE/CimUC/x3MMQqAMAxA0atIZgM1ggWvIg7SRg1oK42IIt7d6
 viH929QTsIKbXFD4kNUYshRlQW4eQgTo/jcQIbqiqhBvdTtC7oYdMeN0yr6GUVv3egNDbapLWS
 +JR7l/Ndd/zwvn2WHgGoAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703592571; l=3312;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=MBNVPTuPe5RQdDMZSU+PMsj2GQT1HD2VDl2L9fGdf+I=;
 b=4ugtZbdhdABoeRlJxXJ6gBFOcTeWMMONsnR+0vV3WvahrjEEIoaPiOO7QRl3tKj4kUJpIv47i
 lBDbq/STFKeCqzbvSRF6t7ex7YQacpwxu7Vvm1nVkW/6/MpOWfcAm8E
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The permissions callback is not supposed to modify the ctl_table.
Enforce this expectation via the typesystem.

The patch was created with the following coccinelle script:

  virtual patch
  virtual context
  virtual report

  @@
  identifier func, head, ctl;
  @@

  int func(
    struct ctl_table_header *head,
  - struct ctl_table *ctl)
  + const struct ctl_table *ctl)
  { ... }

(insert_entry() from fs/proc/proc_sysctl.c is a false-positive)

This change also is a step to put "struct ctl_table" into .rodata
throughout the kernel.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
The patch is meant to be merged via the sysctl tree.

This change was originally part of the sysctl-const series [0].
To slim down that series and reduce the message load on other
maintainers to a minimumble, submit this patch on its own.

[0] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/
---
 include/linux/sysctl.h | 2 +-
 ipc/ipc_sysctl.c       | 2 +-
 kernel/ucount.c        | 2 +-
 net/sysctl_net.c       | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 26a38161c28f..8ec2d742c3b4 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -207,7 +207,7 @@ struct ctl_table_root {
 	void (*set_ownership)(struct ctl_table_header *head,
 			      struct ctl_table *table,
 			      kuid_t *uid, kgid_t *gid);
-	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
+	int (*permissions)(struct ctl_table_header *head, const struct ctl_table *table);
 };
 
 /* struct ctl_path describes where in the hierarchy a table is added */
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
base-commit: de2ee5e9405e12600c81e39837362800cee433a2
change-id: 20231226-sysctl-const-permissions-d7cfd02a7637

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


