Return-Path: <linux-fsdevel+bounces-17477-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB668ADEE7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 09:58:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6BF41C22006
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 07:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51145D8EE;
	Tue, 23 Apr 2024 07:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iLEuUiqm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04604F8BC;
	Tue, 23 Apr 2024 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858977; cv=none; b=JMeqtoAS62CFDmT6thCibRcyxyU7rau9p9i38rJz29v6YxSEm4BtNzpSrrw6a2peuDddWkhDIflJQYHqiuX295VmOEFKbPDRCmkXw4yx3obLNmpFewv5ZWXwQERnxRGfhZxkEXF3HwQWDuBjV7guYEbWxGnVWiNCmJ0Kzr4Oob8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858977; c=relaxed/simple;
	bh=odMbVtXputh1B0wvO7gtV7cKLTLD5qqVWgyPwr4fby8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=N5w/iDqhzoGvXQyJD0qotO1wpTEDvocGAFsCfhUMX/tXbh99MAfVidiauk3ocp97QWMxK/nKzVZRXzohcrY2u8TXj+l9Ra0Y1YTiQ7p76xnEd+/GahLdhCYxjcdaj3MSi2dOKjLdQnfpm6FGbYdShe4HqWX0o+zwfd5ebWrkpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iLEuUiqm; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=odMbVtXputh1B0wvO7gtV7cKLTLD5qqVWgyPwr4fby8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iLEuUiqmghQTs4TpLEBZo8gm3hwwbmMwVh4LjetW99mef7fnKS1+JFbAcu6CXN+nU
	 Qkeg3C6Dg8GVXnY7Yt7xJGc6b7m/FkLbHyvle0PIjuq8AhNHSJZCZpA5JwOewu8BaK
	 /noyOblAFfy+/YF6CCqIRarm1v2eXbwf+FU797II=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:44 +0200
Subject: [PATCH v3 09/11] ipvs: constify ctl_table arguments of utility
 functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-9-e0beccb836e2@weissschuh.net>
References: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
In-Reply-To: <20240423-sysctl-const-handler-v3-0-e0beccb836e2@weissschuh.net>
To: Luis Chamberlain <mcgrof@kernel.org>, 
 Joel Granados <j.granados@samsung.com>, Kees Cook <keescook@chromium.org>
Cc: Eric Dumazet <edumazet@google.com>, Dave Chinner <david@fromorbit.com>, 
 linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 linux-mm@kvack.org, linux-security-module@vger.kernel.org, 
 bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
 linux-xfs@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, netfilter-devel@vger.kernel.org, 
 coreteam@netfilter.org, kexec@lists.infradead.org, 
 linux-hardening@vger.kernel.org, bridge@lists.linux.dev, 
 lvs-devel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org, 
 linux-nfs@vger.kernel.org, apparmor@lists.ubuntu.com, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=1292;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=odMbVtXputh1B0wvO7gtV7cKLTLD5qqVWgyPwr4fby8=;
 b=HGS1kdZAsaJZKpg4r6Gy7F4xJbcNv2yq+KS0wT9dr5GDwl8/cNzV2zronax9Lbe4GmE5G3NOC
 F+TpiwFZuPaBZHHRsyNSIMTh2HPxXZ0cjduuz09UV7awWr9POrydgh8
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helpers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/netfilter/ipvs/ip_vs_ctl.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 143a341bbc0a..689ac521ea2d 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -1924,7 +1924,8 @@ proc_do_sync_ports(struct ctl_table *table, int write,
 	return rc;
 }
 
-static int ipvs_proc_est_cpumask_set(struct ctl_table *table, void *buffer)
+static int ipvs_proc_est_cpumask_set(const struct ctl_table *table,
+				     void *buffer)
 {
 	struct netns_ipvs *ipvs = table->extra2;
 	cpumask_var_t *valp = table->data;
@@ -1962,8 +1963,8 @@ static int ipvs_proc_est_cpumask_set(struct ctl_table *table, void *buffer)
 	return ret;
 }
 
-static int ipvs_proc_est_cpumask_get(struct ctl_table *table, void *buffer,
-				     size_t size)
+static int ipvs_proc_est_cpumask_get(const struct ctl_table *table,
+				     void *buffer, size_t size)
 {
 	struct netns_ipvs *ipvs = table->extra2;
 	cpumask_var_t *valp = table->data;

-- 
2.44.0


