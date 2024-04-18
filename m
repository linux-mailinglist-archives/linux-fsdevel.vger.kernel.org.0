Return-Path: <linux-fsdevel+bounces-17236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E70808A9667
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 11:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C93BB245AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 09:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C628415B152;
	Thu, 18 Apr 2024 09:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="o5yFxKNH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C642915B109;
	Thu, 18 Apr 2024 09:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713433260; cv=none; b=Y44QoJGAqxsDcYsr5nyYF6a7QI3hBExLgZJozLnCwb+7P7f62dmqTsKbPqKJPvH9AJfac7m21JxniAkfeo/7d6Mvz3R3CbX0u+AXMYX8Oi0thMpW/u9AlxxFM+LTQRwZbyoVGmw02HRxyIv57FU/al9bE9yZzBhkVD0lqXUXkyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713433260; c=relaxed/simple;
	bh=ggmYbLxBBrZSM3BdcJQ5eaUGfMdTgom99+4TYUeVScI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=LDLDMDPM57FrsJvUFYKc16CCN1ykesULVZYE2lDyK1hZCVT6Pp8vbcme+OiLV/jUB9ngYuh90FMj6VxDgwj5GwPEJbdjfPcZg2QBk6g+kxc91+T2TaN8Mkdu5awp/FYndIn6R5eivspOLv8VS2JJkK0G4ZGzPX/2UlaZNsSfGJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=o5yFxKNH; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713433246;
	bh=ggmYbLxBBrZSM3BdcJQ5eaUGfMdTgom99+4TYUeVScI=;
	h=From:Date:Subject:To:Cc:From;
	b=o5yFxKNHqCAwDqoiQTi3d4vB0C/W6Fp2WM5VfWC9d03TY2FXsWvmmdZ7P1zVsFQyL
	 YCi/jr6n7iZnrY4Lj+2F2qlYGKpC09sVxqVaW3p6Wi5RvsRDrbXOxVsA+/Mi+1PTOB
	 oveJZGZZd74WFTqi7RUNRgHq9T1W7XuavP81AqH8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Thu, 18 Apr 2024 11:40:08 +0200
Subject: [PATCH v2] sysctl: treewide: constify
 ctl_table_header::ctl_table_arg
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240418-sysctl-const-table-arg-v2-1-4012abc31311@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAHfqIGYC/3WNQQqDMBBFryJZd4qZhJB21XuIC41TE5BYMqmti
 HdvdN/le/Df3wRTCsTiXm0i0RI4zLEAXirhfBdHgjAUFlijkogGeGWXJ3Bz5Ay56yeCLo2AzqK
 lGo0enCjjV6Jn+J7hpi3sA+c5refPIg97JHWtEP8lFwkSrNXKDErfjOwfHwrM7PzbXyNl0e77/
 gN8o8EGwQAAAA==
To: David Ahern <dsahern@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Luis Chamberlain <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>, 
 Joel Granados <j.granados@samsung.com>, Joerg Reuter <jreuter@yaina.de>, 
 Pablo Neira Ayuso <pablo@netfilter.org>, 
 Jozsef Kadlecsik <kadlec@netfilter.org>, Roopa Prabhu <roopa@nvidia.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>, 
 Alexander Aring <alex.aring@gmail.com>, 
 Stefan Schmidt <stefan@datenfreihafen.org>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, 
 Matthieu Baerts <matttbe@kernel.org>, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, 
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, 
 Xin Long <lucien.xin@gmail.com>, Wenjia Zhang <wenjia@linux.ibm.com>, 
 Jan Karcher <jaka@linux.ibm.com>, "D. Wythe" <alibuda@linux.alibaba.com>, 
 Tony Lu <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-hams@vger.kernel.org, 
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org, 
 bridge@lists.linux.dev, linux-wpan@vger.kernel.org, mptcp@lists.linux.dev, 
 linux-sctp@vger.kernel.org, linux-s390@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713433246; l=16165;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=ggmYbLxBBrZSM3BdcJQ5eaUGfMdTgom99+4TYUeVScI=;
 b=6Uj/KdiwVksOd4KpsyRpyU897AIDY2FonxpNJ/IdRGpzcOA4+by9ydaNEYiLUimgOwUX8mceS
 y3r/GK2FgEyBF/U9alCRY6PsH9yvBPX5URTQmwEujb1l45kR726mFxu
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To be able to constify instances of struct ctl_tables it is necessary to
remove ways through which non-const versions are exposed from the
sysctl core.
One of these is the ctl_table_arg member of struct ctl_table_header.

Constify this reference as a prerequisite for the full constification of
struct ctl_table instances.
No functional change.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Add link to original monolithic series
- Send to all maintainers again
- Link to v1: https://lore.kernel.org/r/20240322-sysctl-const-table-arg-v1-1-88436d34961b@weissschuh.net
---
This is a standalone version of PATCH 11 from my original const-sysctl
series at
https://lore.kernel.org/lkml/20231204-const-sysctl-v2-0-7a5060b11447@weissschuh.net/

It is based upon the branch constfy of
https://git.kernel.org/pub/scm/linux/kernel/git/sysctl/sysctl.git/

This patch is meant to be applied through the sysctl tree.

It was implemented by manually searching for "ctl_table_arg"
throughout the tree and inspecing each found site.

If somebody comes up with a cocciscript for this, I'll be happy to use
that.
---
 drivers/net/vrf.c                       | 2 +-
 include/linux/sysctl.h                  | 2 +-
 ipc/ipc_sysctl.c                        | 2 +-
 ipc/mq_sysctl.c                         | 2 +-
 kernel/ucount.c                         | 2 +-
 net/ax25/sysctl_net_ax25.c              | 2 +-
 net/bridge/br_netfilter_hooks.c         | 2 +-
 net/core/sysctl_net_core.c              | 2 +-
 net/ieee802154/6lowpan/reassembly.c     | 2 +-
 net/ipv4/devinet.c                      | 2 +-
 net/ipv4/ip_fragment.c                  | 2 +-
 net/ipv4/route.c                        | 2 +-
 net/ipv4/sysctl_net_ipv4.c              | 2 +-
 net/ipv4/xfrm4_policy.c                 | 2 +-
 net/ipv6/addrconf.c                     | 2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 2 +-
 net/ipv6/reassembly.c                   | 2 +-
 net/ipv6/sysctl_net_ipv6.c              | 6 +++---
 net/ipv6/xfrm6_policy.c                 | 2 +-
 net/mpls/af_mpls.c                      | 4 ++--
 net/mptcp/ctrl.c                        | 2 +-
 net/netfilter/nf_conntrack_standalone.c | 2 +-
 net/netfilter/nf_log.c                  | 2 +-
 net/sctp/sysctl.c                       | 2 +-
 net/smc/smc_sysctl.c                    | 2 +-
 net/unix/sysctl_net_unix.c              | 2 +-
 net/xfrm/xfrm_sysctl.c                  | 2 +-
 27 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index bb95ce43cd97..66f8542f3b18 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -1971,7 +1971,7 @@ static int vrf_netns_init_sysctl(struct net *net, struct netns_vrf *nn_vrf)
 static void vrf_netns_exit_sysctl(struct net *net)
 {
 	struct netns_vrf *nn_vrf = net_generic(net, vrf_net_id);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = nn_vrf->ctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(nn_vrf->ctl_hdr);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 47bd28ffa88f..09db2f2e6488 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -171,7 +171,7 @@ struct ctl_table_header {
 		struct rcu_head rcu;
 	};
 	struct completion *unregistering;
-	struct ctl_table *ctl_table_arg;
+	const struct ctl_table *ctl_table_arg;
 	struct ctl_table_root *root;
 	struct ctl_table_set *set;
 	struct ctl_dir *parent;
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index 19b2a67aef40..113452038303 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -305,7 +305,7 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 
 void retire_ipc_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = ns->ipc_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->ipc_sysctls);
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index 43c0825da9e8..068e7d5aa42b 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -159,7 +159,7 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
 
 void retire_mq_sysctls(struct ipc_namespace *ns)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = ns->mq_sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->mq_sysctls);
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 90300840256b..366a2c1971f5 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -119,7 +119,7 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 void retire_userns_sysctls(struct user_namespace *ns)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = ns->sysctls->ctl_table_arg;
 	unregister_sysctl_table(ns->sysctls);
diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index db66e11e7fe8..e0128dc9def3 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -171,7 +171,7 @@ int ax25_register_dev_sysctl(ax25_dev *ax25_dev)
 void ax25_unregister_dev_sysctl(ax25_dev *ax25_dev)
 {
 	struct ctl_table_header *header = ax25_dev->sysheader;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (header) {
 		ax25_dev->sysheader = NULL;
diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 35e10c5a766d..a09118c56c7d 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1268,7 +1268,7 @@ static int br_netfilter_sysctl_init_net(struct net *net)
 static void br_netfilter_sysctl_exit_net(struct net *net,
 					 struct brnf_net *brnet)
 {
-	struct ctl_table *table = brnet->ctl_hdr->ctl_table_arg;
+	const struct ctl_table *table = brnet->ctl_hdr->ctl_table_arg;
 
 	unregister_net_sysctl_table(brnet->ctl_hdr);
 	if (!net_eq(net, &init_net))
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 6973dda3abda..903ab4a51c17 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -743,7 +743,7 @@ static __net_init int sysctl_core_net_init(struct net *net)
 
 static __net_exit void sysctl_core_net_exit(struct net *net)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = net->core.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->core.sysctl_hdr);
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 6dd960ec558c..2a983cf450da 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -399,7 +399,7 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 
 static void __net_exit lowpan_frags_ns_sysctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 7a437f0d4190..7592f242336b 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2749,7 +2749,7 @@ static __net_init int devinet_init_net(struct net *net)
 static __net_exit void devinet_exit_net(struct net *net)
 {
 #ifdef CONFIG_SYSCTL
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = net->ipv4.forw_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.forw_hdr);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index a4941f53b523..6b9285fd6f06 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -632,7 +632,7 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
 
 static void __net_exit ip4_frags_ns_ctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->ipv4.frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.frags_hdr);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index c8f76f56dc16..af30b5942ba4 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3590,7 +3590,7 @@ static __net_init int sysctl_route_net_init(struct net *net)
 
 static __net_exit void sysctl_route_net_exit(struct net *net)
 {
-	struct ctl_table *tbl;
+	const struct ctl_table *tbl;
 
 	tbl = net->ipv4.route_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv4.route_hdr);
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 7e4f16a7dcc1..ce5d19978a26 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1554,7 +1554,7 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 
 static __net_exit void ipv4_sysctl_exit_net(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	kfree(net->ipv4.sysctl_local_reserved_ports);
 	table = net->ipv4.ipv4_hdr->ctl_table_arg;
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index c33bca2c3841..1dda59e0aeab 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -186,7 +186,7 @@ static __net_init int xfrm4_net_sysctl_init(struct net *net)
 
 static __net_exit void xfrm4_net_sysctl_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!net->ipv4.xfrm4_hdr)
 		return;
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 247bd4d8ee45..9c34a351f115 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7235,7 +7235,7 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 static void __addrconf_sysctl_unregister(struct net *net,
 					 struct ipv6_devconf *p, int ifindex)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!p->sysctl_header)
 		return;
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 1a51a44571c3..98809f846229 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -105,7 +105,7 @@ static int nf_ct_frag6_sysctl_register(struct net *net)
 static void __net_exit nf_ct_frags6_sysctl_unregister(struct net *net)
 {
 	struct nft_ct_frag6_pernet *nf_frag = nf_frag_pernet(net);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = nf_frag->nf_frag_frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(nf_frag->nf_frag_frags_hdr);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index acb4f119e11f..ee95cdcc8747 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -487,7 +487,7 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
 
 static void __net_exit ip6_frags_ns_sysctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->ipv6.sysctl.frags_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->ipv6.sysctl.frags_hdr);
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 888676163e90..75de55f907b0 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -313,9 +313,9 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 
 static void __net_exit ipv6_sysctl_net_exit(struct net *net)
 {
-	struct ctl_table *ipv6_table;
-	struct ctl_table *ipv6_route_table;
-	struct ctl_table *ipv6_icmp_table;
+	const struct ctl_table *ipv6_table;
+	const struct ctl_table *ipv6_route_table;
+	const struct ctl_table *ipv6_icmp_table;
 
 	ipv6_table = net->ipv6.sysctl.hdr->ctl_table_arg;
 	ipv6_route_table = net->ipv6.sysctl.route_hdr->ctl_table_arg;
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 42fb6996b077..4891012b692f 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -218,7 +218,7 @@ static int __net_init xfrm6_net_sysctl_init(struct net *net)
 
 static void __net_exit xfrm6_net_sysctl_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!net->ipv6.sysctl.xfrm6_hdr)
 		return;
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index 6dab883a08dd..973881b8faa3 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1438,7 +1438,7 @@ static void mpls_dev_sysctl_unregister(struct net_device *dev,
 				       struct mpls_dev *mdev)
 {
 	struct net *net = dev_net(dev);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	if (!mdev->sysctl)
 		return;
@@ -2706,7 +2706,7 @@ static void mpls_net_exit(struct net *net)
 {
 	struct mpls_route __rcu **platform_label;
 	size_t platform_labels;
-	struct ctl_table *table;
+	const struct ctl_table *table;
 	unsigned int index;
 
 	table = net->mpls.ctl->ctl_table_arg;
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index 13fe0748dde8..8d661156ab8c 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -198,7 +198,7 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 
 static void mptcp_pernet_del_table(struct mptcp_pernet *pernet)
 {
-	struct ctl_table *table = pernet->ctl_table_hdr->ctl_table_arg;
+	const struct ctl_table *table = pernet->ctl_table_hdr->ctl_table_arg;
 
 	unregister_net_sysctl_table(pernet->ctl_table_hdr);
 
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 0ee98ce5b816..bb9dea676ec1 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1122,7 +1122,7 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
 static void nf_conntrack_standalone_fini_sysctl(struct net *net)
 {
 	struct nf_conntrack_net *cnet = nf_ct_pernet(net);
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = cnet->sysctl_header->ctl_table_arg;
 	unregister_net_sysctl_table(cnet->sysctl_header);
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 370f8231385c..efedd2f13ac7 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -514,7 +514,7 @@ static int netfilter_log_sysctl_init(struct net *net)
 
 static void netfilter_log_sysctl_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->nf.nf_log_dir_header->ctl_table_arg;
 	unregister_net_sysctl_table(net->nf.nf_log_dir_header);
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index f65d6f92afcb..25bdf17c7262 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -624,7 +624,7 @@ int sctp_sysctl_net_register(struct net *net)
 
 void sctp_sysctl_net_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->sctp.sysctl_header->ctl_table_arg;
 	unregister_net_sysctl_table(net->sctp.sysctl_header);
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index a5946d1b9d60..4e8baa2e7ea4 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -133,7 +133,7 @@ int __net_init smc_sysctl_net_init(struct net *net)
 
 void __net_exit smc_sysctl_net_exit(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->smc.smc_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->smc.smc_hdr);
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 3e84b31c355a..44996af61999 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -52,7 +52,7 @@ int __net_init unix_sysctl_register(struct net *net)
 
 void unix_sysctl_unregister(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->unx.ctl->ctl_table_arg;
 	unregister_net_sysctl_table(net->unx.ctl);
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 7fdeafc838a7..e972930c292b 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -76,7 +76,7 @@ int __net_init xfrm_sysctl_init(struct net *net)
 
 void __net_exit xfrm_sysctl_fini(struct net *net)
 {
-	struct ctl_table *table;
+	const struct ctl_table *table;
 
 	table = net->xfrm.sysctl_hdr->ctl_table_arg;
 	unregister_net_sysctl_table(net->xfrm.sysctl_hdr);

---
base-commit: 48a8b5270db856be233021e47a5f1dc02d47ed0d
change-id: 20231226-sysctl-const-table-arg-2c828e0264dc

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


