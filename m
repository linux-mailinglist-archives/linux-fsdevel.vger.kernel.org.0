Return-Path: <linux-fsdevel+bounces-14521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 881B987D366
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 19:12:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FCC81F24666
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Mar 2024 18:12:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524E150A72;
	Fri, 15 Mar 2024 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ucF35Ds0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9934D9F5;
	Fri, 15 Mar 2024 18:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710526301; cv=none; b=SDbTg++xmng4DnVZwovCtvt4oGM3u3KMQfPe5BPv4UJjcb7ZSFeU2w1Q+AWE9FfmCw/5Pl4MLMLdGLzWxKnf8eYsIwViYTTmDZsX0kyaElwB+Gt+9JT+6ALwKn6GS54XRdf2vgbov7QlSmOYmk1WkdcEgUvys3wSZK8/1OloPXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710526301; c=relaxed/simple;
	bh=yZAVxfJujoi4wcGgrDoEtqKa9Pt1OYmQDrNQKqMs0s4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DjnUkxoGkzVk+ZX6ZzVDxSbopppy9wLXxkB4T7eiDJjciYd29YB3UPjr8KtsG99SbIYxzd8cJGcauMJwQACwhqlr4yF+hhkPie3qiDiOxz+bew40E2ZjzpxV3Tp5N04YSny2NSYuw5yvFk2hkqjGLs6JGVccytqPVdo3xlwPG8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ucF35Ds0; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1710526295;
	bh=yZAVxfJujoi4wcGgrDoEtqKa9Pt1OYmQDrNQKqMs0s4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ucF35Ds0DIHLCoevee8XQOvskfRQ3rlnOnUnTs1Hvt5UDuGZML+Xfq8Pcgbu4/6hA
	 ogYGa9fK3A0W8USkUaPtdJsAzKTFJuXP4kRKmgvmUavhB/enUmSQmQDexsagojcsTE
	 oWZ8NEU3nCLIr/tG2puHOitgwNCO247mQLs+EaaQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 15 Mar 2024 19:11:31 +0100
Subject: [PATCH v3 2/2] sysctl: treewide: constify argument
 ctl_table_root::permissions(table)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240315-sysctl-const-ownership-v3-2-b86680eae02e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1710526294; l=3547;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=yZAVxfJujoi4wcGgrDoEtqKa9Pt1OYmQDrNQKqMs0s4=;
 b=VkF+cll2VnMifjDikxSZHzdX0SlbUsfl03rU48ltG+5ANjQmVNJFm297JBiHElG0ojh4ptCFg
 6g/xnUHmT8KAtlfPMwo0rC96BlF/0PaGQDX3Wd1To46bM3xgD2OeIjM
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
 include/linux/sysctl.h | 2 +-
 ipc/ipc_sysctl.c       | 2 +-
 ipc/mq_sysctl.c        | 2 +-
 kernel/ucount.c        | 2 +-
 net/sysctl_net.c       | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 60333a6b9370..f9214de0490c 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -206,7 +206,7 @@ struct ctl_table_root {
 	struct ctl_table_set *(*lookup)(struct ctl_table_root *root);
 	void (*set_ownership)(struct ctl_table_header *head,
 			      kuid_t *uid, kgid_t *gid);
-	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
+	int (*permissions)(struct ctl_table_header *head, const struct ctl_table *table);
 };
 
 #define register_sysctl(path, table)	\
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 1a5085e5b178..19b2a67aef40 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -204,7 +204,7 @@ static void ipc_set_ownership(struct ctl_table_header *head,
 	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
 }
 
-static int ipc_permissions(struct ctl_table_header *head, struct ctl_table *table)
+static int ipc_permissions(struct ctl_table_header *head, const struct ctl_table *table)
 {
 	int mode = table->mode;
 
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 6bb1c5397c69..43c0825da9e8 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -90,7 +90,7 @@ static void mq_set_ownership(struct ctl_table_header *head,
 	*gid = gid_valid(ns_root_gid) ? ns_root_gid : GLOBAL_ROOT_GID;
 }
 
-static int mq_permissions(struct ctl_table_header *head, struct ctl_table *table)
+static int mq_permissions(struct ctl_table_header *head, const struct ctl_table *table)
 {
 	int mode = table->mode;
 	kuid_t ns_root_uid;
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
index a0a7a79991f9..f5017012a049 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -40,7 +40,7 @@ static int is_seen(struct ctl_table_set *set)
 
 /* Return standard mode bits for table entry. */
 static int net_ctl_permissions(struct ctl_table_header *head,
-			       struct ctl_table *table)
+			       const struct ctl_table *table)
 {
 	struct net *net = container_of(head->set, struct net, sysctls);
 

-- 
2.44.0


