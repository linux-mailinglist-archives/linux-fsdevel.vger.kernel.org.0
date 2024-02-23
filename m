Return-Path: <linux-fsdevel+bounces-12589-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBB13861649
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 16:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58D33282E87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Feb 2024 15:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682BA839E9;
	Fri, 23 Feb 2024 15:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="uCXeGtEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D425D750;
	Fri, 23 Feb 2024 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708703410; cv=none; b=PPA/ahZ6HIIkrO0rhv+KMdTFuIva2TvwNpox4Ob0QDYFB/rosNdznCO5STc3jjacq5HBqweKxE/gyIiN6r/BCIBZJAH8fcydTRDOT7LRTVXfG2fv6vm2p0qYnQe5yG5bGbXTARTP+i+SYI6VUYfWe2davHh9kiLX1ihM40Ht5ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708703410; c=relaxed/simple;
	bh=tyETEbR7y+fCOoobG2K+nu8VTcN0oxz5rQtx8OA5KUk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jyDSQ4vbDl6u/xuWNYIcJcH7zEOyb+YM9133W6N+vFGfqmAxn4gcEWlHu4qTN2KqA4Su2Ne17Il2au/HoJ8VTfkOZzqKLnceEytPZvWxHa8P3KzHE+1mkHyjen4Aer5TdKvnT85dQSYp0mYmDgBRrITzNishbowT7yK+/a9Axo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=uCXeGtEZ; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1708703403;
	bh=tyETEbR7y+fCOoobG2K+nu8VTcN0oxz5rQtx8OA5KUk=;
	h=From:Date:Subject:To:Cc:From;
	b=uCXeGtEZzroTdP5F3EgwnV/9r5jb3mECsYnkrkoiVPFfk5dX309CR/ZFKVaFleYhl
	 3Bc2tP6plSprHaHfy77ExL6bALxxQnHRCzxsqigHn8I1Ln5eeMPAG/EWWqS6g0DkJ7
	 Q1PuD6hwL1rB3n92v/WgoHgUZ5Uc+dZ6DMm7sAtA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 23 Feb 2024 16:50:00 +0100
Subject: [PATCH v2] sysctl: drop unused argument set_ownership()::table
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240223-sysctl-const-ownership-v2-1-f9ba1795aaf2@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAKe+2GUC/4WNQQ7CIBBFr9KwdoxgLcaV9zBdtDDIJAYaBlubh
 ruLvYDL95L//iYYEyGLW7OJhDMxxVBBHRph/BCeCGQrC3VSZ6lUB7yyyS8wMXCGuARM7GkC5/Q
 FOz22iIOo4ymho88efvSVPXGOad1/Zvmzf5OzBAlWX521um3HQd4XJGY2/u2PAbPoSylf1Cg1r
 sEAAAA=
To: Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 netdev@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708703403; l=2870;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=tyETEbR7y+fCOoobG2K+nu8VTcN0oxz5rQtx8OA5KUk=;
 b=55T87RfeQlY2dMtq34biKke5IZh5vjxkIusRfnsZtUvEAalULFoFQ19w3FnAO9YXnrp1B3JTe
 L/WtK/lIM8fBsw5sX3tT0iy7Rtk3IZyJ+0huJuGHcFt5iRzdJbHF6jj
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
Changes in v2:
- Rework commit message
- Mention potential conflict with upcoming per-namespace kernel.pid_max
  sysctl
- Delete unused parameter table
- Link to v1: https://lore.kernel.org/r/20231226-sysctl-const-ownership-v1-1-d78fdd744ba1@weissschuh.net
---
The patch is meant to be merged via the sysctl tree.

There is an upcoming series that will introduce a new implementation of
.set_ownership which would need to be adapted [0].
The adaption would be trivial as the 'table' parameter also unused
there.

This change was originally part of the sysctl-const series [1].
To slim down that series and reduce the message load on other
maintainers to a minimumble, submit this patch on its own.

[0] https://lore.kernel.org/lkml/20240222160915.315255-1-aleksandr.mikhalitsyn@canonical.com/
[1] https://lore.kernel.org/lkml/20231204-const-sysctl-v2-2-7a5060b11447@weissschuh.net/
---
 include/linux/sysctl.h | 1 -
 net/sysctl_net.c       | 1 -
 2 files changed, 2 deletions(-)

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

---
base-commit: ffd2cb6b718e189e7e2d5d0c19c25611f92e061a
change-id: 20231226-sysctl-const-ownership-ff75e67b4eea

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


