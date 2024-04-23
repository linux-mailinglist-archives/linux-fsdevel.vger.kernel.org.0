Return-Path: <linux-fsdevel+bounces-17473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A19998ADED1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 09:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 410CAB23821
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Apr 2024 07:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9480E5579F;
	Tue, 23 Apr 2024 07:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Jh4kHqKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219CB4CDF9;
	Tue, 23 Apr 2024 07:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713858976; cv=none; b=qTqKVK4QplRoX22fdwUY0wMCJrziQb0ZBlJfz1yfw7if6/jRzOkNGnebci7dm59g8njd/ohJK19J77XzYGcEYaq5N9GOY+5hjX1sITAAW+NF7PnoeT22h8isTEtbtehn7UwFqKozNr+0WxqdNOff/hqX5TCsJDtGhjIVgiz5lEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713858976; c=relaxed/simple;
	bh=rhTtJbRFTTDD/EEuqh+xmQGgJG7l1CgJQWXHlODBL5I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qm96t/1+h/2dALNfImfZmQxqYh5lHZheJ4Fd9pvb4QxMaXdGV/pnxvwQmV0Lywu0ToE+0f02FZIPFH/EeXeelZEY7gbFZvm5eb8meGnV1rJ7LqlJ8wEpeU3COh5jonq5iOGf10BAeVPiVjRHduHqc/7EcCKnLBjDms5/91eFHN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Jh4kHqKR; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713858962;
	bh=rhTtJbRFTTDD/EEuqh+xmQGgJG7l1CgJQWXHlODBL5I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jh4kHqKR8uFfgbO8D9WK1hxUfjPm8iO4Tj/1g9oqbdvZsvOO7NNctmOr5j9hI/VKE
	 pHafcxJ8BdeddjSts/bMxWLccdEWmQmje38r1ok3DoPkrNGs3KG6i7U8YJpR6imRw2
	 VR1iTBJjamva0pTfL/MxJ99YyYItdDSAEsnB8hOA=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 09:54:41 +0200
Subject: [PATCH v3 06/11] ipv4/sysctl: constify ctl_table arguments of
 utility functions
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-sysctl-const-handler-v3-6-e0beccb836e2@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713858961; l=1269;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=rhTtJbRFTTDD/EEuqh+xmQGgJG7l1CgJQWXHlODBL5I=;
 b=xkBxm95PFV9biLBQXL/jnQoslPWOqeiKfLilfo9X0/w/rpk96uwZ6XcT8dAItQlTvocuJZiXJ
 AWgjsh5bK7RD2GBrU5dFR8YS1o9Y0qoHpG5ydJoQPSEwJ0OoCUdGv/k
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

In a future commit the proc_handlers themselves will change to
"const struct ctl_table". As a preparation for that adapt the internal
helpers.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 net/ipv4/sysctl_net_ipv4.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index ce5d19978a26..fc4c001bf72a 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -130,7 +130,8 @@ static int ipv4_privileged_ports(struct ctl_table *table, int write,
 	return ret;
 }
 
-static void inet_get_ping_group_range_table(struct ctl_table *table, kgid_t *low, kgid_t *high)
+static void inet_get_ping_group_range_table(const struct ctl_table *table,
+					    kgid_t *low, kgid_t *high)
 {
 	kgid_t *data = table->data;
 	struct net *net =
@@ -145,7 +146,8 @@ static void inet_get_ping_group_range_table(struct ctl_table *table, kgid_t *low
 }
 
 /* Update system visible IP port range */
-static void set_ping_group_range(struct ctl_table *table, kgid_t low, kgid_t high)
+static void set_ping_group_range(const struct ctl_table *table,
+				 kgid_t low, kgid_t high)
 {
 	kgid_t *data = table->data;
 	struct net *net =

-- 
2.44.0


