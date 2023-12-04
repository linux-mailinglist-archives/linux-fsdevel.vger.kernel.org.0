Return-Path: <linux-fsdevel+bounces-4739-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F6F802D35
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8A11F210CA
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC76FBE8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 08:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="NpAknuE+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0A7198;
	Sun,  3 Dec 2023 23:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1701676352;
	bh=v0MXLGIsisRjyz+2q8S4lNJCjp7Kc1OsT9OWJgMTDC0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NpAknuE+SwTyR4zjPUm2h6dHi5u3Il/bBsvGZ3mlpPxjGYT2t7M7Y6Un/IYoB0iMK
	 ReELEAwm3nZ5LEAMS3pGHH6hUh0PA0DFKWC8yDLs/wr4zGuRlSqCiFv1jPLY3p3kgC
	 VDAFEp/kkHjLix6w3AIf0+hmrAH5OnqMB4G+JvZQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 04 Dec 2023 08:52:22 +0100
Subject: [PATCH v2 09/18] sysctl: treewide: constify
 ctl_table_root::set_ownership
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231204-const-sysctl-v2-9-7a5060b11447@weissschuh.net>
References: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
In-Reply-To: <20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net>
To: Kees Cook <keescook@chromium.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Iurii Zaikin <yzaikin@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Joel Granados <j.granados@samsung.com>
Cc: linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701676350; l=1372;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=v0MXLGIsisRjyz+2q8S4lNJCjp7Kc1OsT9OWJgMTDC0=;
 b=36piJllEmuNADES2V+irUyjSXbQwWiVHfuHvaVtX4ZUFuaW3bGFv0NxakonPgvNZa1veydxZy
 r6beTa7NJ3SCdG+Ab8rKNLOvH7rjBf1WSb68bEFxJ4QKHESQJbBmCiq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the sysctl core will only use
"const struct ctl_table". As a preparation for that adapt the
set_ownership callbacks.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
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

-- 
2.43.0


