Return-Path: <linux-fsdevel+bounces-6916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9500781E768
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 13:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C78AC1C21E9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Dec 2023 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA5E4EB2F;
	Tue, 26 Dec 2023 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Ko4Kj/nE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850FC20307;
	Tue, 26 Dec 2023 12:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1703593963;
	bh=L9GAaUe+lSBriHrdLSPoY+6yNGsO1d1cvnSIhXdaP6Q=;
	h=From:Date:Subject:To:Cc:From;
	b=Ko4Kj/nE+JBGo7sEr9wqHwsncYVqpKmfZII3vlxhPWHDLyBMk1wdQkqpI5Ur+kwXT
	 BwE8pv3US0u1g0qDd5eDjTBpdVlbCOBWTJAQfQdSVj9hFW8jb2qcYXW2rS5etgZgLZ
	 bm9p1XdgAsMs1EsnAfxjAsZCDQwE8AOvfrG0Ghxw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 26 Dec 2023 13:32:42 +0100
Subject: [PATCH] sysctl: treewide: constify ctl_table_root::set_ownership
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAOnHimUC/x3MSwqEMBBF0a1IjS3QqBF6K40DTb9ogSSSkv4Q3
 HsHh2dwbyZFEig9qkwJb1GJoaCtK3LbHFawvIrJNKZrjbGsP3Xnzi4GPTl+ApJucrD34wA7Lj0
 wU4mPBC/fe/ycrusPFF5sEGgAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703593962; l=2286;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=L9GAaUe+lSBriHrdLSPoY+6yNGsO1d1cvnSIhXdaP6Q=;
 b=kOSizBjzR6oCvTWhrMMELhvhfemQm6x93hbVaC0+D+zdFlkTwAznHfKld2xSD4iolj5a7VJJz
 mgBsZAt3zk8CZqw5459P6az7GxW8aKyd92Wq9UIWT69/Ximetj2sSQg
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The set_ownership callback is not supposed to modify the ctl_table.
Enforce this expectation via the typesystem.

The patch was created with the following coccinelle script:

  virtual patch
  virtual context
  virtual report

  @@
  identifier func, head, table, uid, gid;
  @@

  void func(
    struct ctl_table_header *head,
  - struct ctl_table *table,
  + const struct ctl_table *table,
    kuid_t *uid, kgid_t *gid)
  { ... }

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
 net/sysctl_net.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 26a38161c28f..800154e1ff88 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -205,7 +205,7 @@ struct ctl_table_root {
 	struct ctl_table_set default_set;
 	struct ctl_table_set *(*lookup)(struct ctl_table_root *root);
 	void (*set_ownership)(struct ctl_table_header *head,
-			      struct ctl_table *table,
+			      const struct ctl_table *table,
 			      kuid_t *uid, kgid_t *gid);
 	int (*permissions)(struct ctl_table_header *head, struct ctl_table *table);
 };
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 051ed5f6fc93..1310ef8f0958 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -54,7 +54,7 @@ static int net_ctl_permissions(struct ctl_table_header *head,
 }
 
 static void net_ctl_set_ownership(struct ctl_table_header *head,
-				  struct ctl_table *table,
+				  const struct ctl_table *table,
 				  kuid_t *uid, kgid_t *gid)
 {
 	struct net *net = container_of(head->set, struct net, sysctls);

---
base-commit: de2ee5e9405e12600c81e39837362800cee433a2
change-id: 20231226-sysctl-const-ownership-ff75e67b4eea

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


