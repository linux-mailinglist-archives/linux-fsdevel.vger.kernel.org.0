Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 090BF768E37
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGaHUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbjGaHT2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0393419AF;
        Mon, 31 Jul 2023 00:17:53 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fe20e7e5caso7216895e9.3;
        Mon, 31 Jul 2023 00:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787871; x=1691392671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=34iuaq/pnuMs2SXcKWdaaZ6/HuEmqckfjuo3/acwaJw=;
        b=PzponUPBFk2Hs0THoaHMtrp0XLsI3SAU9NviDU5xgS2Wul/OtIF2ZkU0pjt2jsq7iP
         Cyw8JEkjKmwp+c5OPC46mmLkpR/UFy82+zvgKv3km3viySALc0kcHo0uLSnWUGGzVHxa
         R3VMZqVkAC8jaqsfOWsUu2WnV+kLxNaAVXoAZr6yhri3ZKkFbIi2yh3nZP4CU4ByVyTp
         CUGLqaEGd6jx2XReWhSrOWQCptRd4UfYOiUIzcr3RPysl4cr2gY+t4jUCITEq9cKZUX5
         MsUj8PN6Xle7PLToqMUtmqQwazXuMghPw1NWlScpVkSletesoApFWOXxLlPn0a+CqrNj
         +vKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787871; x=1691392671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=34iuaq/pnuMs2SXcKWdaaZ6/HuEmqckfjuo3/acwaJw=;
        b=GG4ghhnoJ0ssY5qYWg73l4B26DUjRT5LC4AmghnoX1E5zzdV40NjBa806bykSb2V9K
         zshbNTPgF9/CJgwuOcF196Nr0G4uUhyfZOdBGaMoH9mEmrK1raPoIj4pcIFTbVf0n6HD
         iNO5R5sYkDBvXAGsrpf1or8FnY/30dhkecQxf07X1EGbwYi89Ah9LqkV5EEsU0srskzF
         7BY7wBd19TSGdBwCay6wjF5oOVv7ozVyqVg5sybrjT5hsLQqCFAETCwtBq4dG68lXW3X
         C0IRrZGPz/HF2cANu/TsBXbIwjZ5tvLOUVsqBPxE/F1pV0uCoFo3OSy0vsVjsQ035mbH
         lUJw==
X-Gm-Message-State: ABy/qLZ9XJ3iZk/feoz6KJjVYkSW94wFPFQ/dpXcWPgvYw37JMONeni2
        OVGzEt9v8KlCSZvnTPUD5kA=
X-Google-Smtp-Source: APBJJlE82wLfEEQnS8QxtIuJcLr5odKtikNenp3Nq2TULTNUkfX7rMU1tz0NotUXm++oCYszvogQgA==
X-Received: by 2002:a7b:c00f:0:b0:3fb:9ef1:34ef with SMTP id c15-20020a7bc00f000000b003fb9ef134efmr8057430wmb.37.1690787871228;
        Mon, 31 Jul 2023 00:17:51 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id q10-20020a7bce8a000000b003fe1cac37d8sm3844308wmj.11.2023.07.31.00.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:50 -0700 (PDT)
From:   Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Kees Cook <keescook@chromium.org>,
        "D. Wythe" <alibuda@linux.alibaba.com>, mptcp@lists.linux.dev,
        Jakub Kicinski <kuba@kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Paolo Abeni <pabeni@redhat.com>, coreteam@netfilter.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Alexander Aring <alex.aring@gmail.com>,
        Will Deacon <will@kernel.org>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        bridge@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        Joerg Reuter <jreuter@yaina.de>, Julian Anastasov <ja@ssi.bg>,
        David Ahern <dsahern@kernel.org>,
        netfilter-devel@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>,
        linux-kernel@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-wpan@vger.kernel.org, lvs-devel@vger.kernel.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-sctp@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-rdma@vger.kernel.org, Roopa Prabhu <roopa@nvidia.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Simon Horman <horms@verge.net.au>,
        Mat Martineau <martineau@kernel.org>, josh@joshtriplett.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Eric Dumazet <edumazet@google.com>, linux-hams@vger.kernel.org,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-s390@vger.kernel.org,
        Xin Long <lucien.xin@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org, rds-devel@oss.oracle.com,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 11/14] networking: Update to register_net_sysctl_sz
Date:   Mon, 31 Jul 2023 09:17:25 +0200
Message-Id: <20230731071728.3493794-12-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731071728.3493794-1-j.granados@samsung.com>
References: <20230731071728.3493794-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move from register_net_sysctl to register_net_sysctl_sz for all the
networking related files. Do this while making sure to mirror the NULL
assignments with a table_size of zero for the unprivileged users.

We need to move to the new function in preparation for when we change
SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro. Failing to do
so would erroneously allow ARRAY_SIZE() to be called on a pointer. We
hold off the SIZE_MAX to ARRAY_SIZE change until we have migrated all
the relevant net sysctl registering functions to register_net_sysctl_sz
in subsequent commits.

An additional size function was added to the following files in order to
calculate the size of an array that is defined in another file:
    include/net/ipv6.h
    net/ipv6/icmp.c
    net/ipv6/route.c
    net/ipv6/sysctl_net_ipv6.c

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 include/net/ipv6.h                  |  2 ++
 net/core/neighbour.c                |  8 ++++++--
 net/core/sysctl_net_core.c          |  3 ++-
 net/ieee802154/6lowpan/reassembly.c |  8 ++++++--
 net/ipv4/devinet.c                  |  3 ++-
 net/ipv4/ip_fragment.c              |  3 ++-
 net/ipv4/route.c                    |  8 ++++++--
 net/ipv4/sysctl_net_ipv4.c          |  3 ++-
 net/ipv4/xfrm4_policy.c             |  3 ++-
 net/ipv6/addrconf.c                 |  3 ++-
 net/ipv6/icmp.c                     |  5 +++++
 net/ipv6/reassembly.c               |  3 ++-
 net/ipv6/route.c                    | 13 +++++++++----
 net/ipv6/sysctl_net_ipv6.c          | 16 +++++++++++-----
 net/ipv6/xfrm6_policy.c             |  3 ++-
 net/mpls/af_mpls.c                  |  6 ++++--
 net/mptcp/ctrl.c                    |  3 ++-
 net/rds/tcp.c                       |  3 ++-
 net/sctp/sysctl.c                   |  4 +++-
 net/smc/smc_sysctl.c                |  3 ++-
 net/unix/sysctl_net_unix.c          |  3 ++-
 net/xfrm/xfrm_sysctl.c              |  8 ++++++--
 22 files changed, 82 insertions(+), 32 deletions(-)

diff --git a/include/net/ipv6.h b/include/net/ipv6.h
index 7332296eca44..63ba68536a20 100644
--- a/include/net/ipv6.h
+++ b/include/net/ipv6.h
@@ -1274,7 +1274,9 @@ static inline int snmp6_unregister_dev(struct inet6_dev *idev) { return 0; }
 
 #ifdef CONFIG_SYSCTL
 struct ctl_table *ipv6_icmp_sysctl_init(struct net *net);
+size_t ipv6_icmp_sysctl_table_size(void);
 struct ctl_table *ipv6_route_sysctl_init(struct net *net);
+size_t ipv6_route_sysctl_table_size(struct net *net);
 int ipv6_sysctl_register(void);
 void ipv6_sysctl_unregister(void);
 #endif
diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index ddd0f32de20e..adc7fc4ff9bf 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -3779,6 +3779,7 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 	const char *dev_name_source;
 	char neigh_path[ sizeof("net//neigh/") + IFNAMSIZ + IFNAMSIZ ];
 	char *p_name;
+	size_t neigh_vars_size;
 
 	t = kmemdup(&neigh_sysctl_template, sizeof(*t), GFP_KERNEL_ACCOUNT);
 	if (!t)
@@ -3790,11 +3791,13 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 		t->neigh_vars[i].extra2 = p;
 	}
 
+	neigh_vars_size = ARRAY_SIZE(t->neigh_vars);
 	if (dev) {
 		dev_name_source = dev->name;
 		/* Terminate the table early */
 		memset(&t->neigh_vars[NEIGH_VAR_GC_INTERVAL], 0,
 		       sizeof(t->neigh_vars[NEIGH_VAR_GC_INTERVAL]));
+		neigh_vars_size = NEIGH_VAR_BASE_REACHABLE_TIME_MS;
 	} else {
 		struct neigh_table *tbl = p->tbl;
 		dev_name_source = "default";
@@ -3841,8 +3844,9 @@ int neigh_sysctl_register(struct net_device *dev, struct neigh_parms *p,
 
 	snprintf(neigh_path, sizeof(neigh_path), "net/%s/neigh/%s",
 		p_name, dev_name_source);
-	t->sysctl_header =
-		register_net_sysctl(neigh_parms_net(p), neigh_path, t->neigh_vars);
+	t->sysctl_header = register_net_sysctl_sz(neigh_parms_net(p),
+						  neigh_path, t->neigh_vars,
+						  neigh_vars_size);
 	if (!t->sysctl_header)
 		goto free;
 
diff --git a/net/core/sysctl_net_core.c b/net/core/sysctl_net_core.c
index 782273bb93c2..03f1edb948d7 100644
--- a/net/core/sysctl_net_core.c
+++ b/net/core/sysctl_net_core.c
@@ -712,7 +712,8 @@ static __net_init int sysctl_core_net_init(struct net *net)
 			tmp->data += (char *)net - (char *)&init_net;
 	}
 
-	net->core.sysctl_hdr = register_net_sysctl(net, "net/core", tbl);
+	net->core.sysctl_hdr = register_net_sysctl_sz(net, "net/core", tbl,
+						      ARRAY_SIZE(netns_core_table));
 	if (net->core.sysctl_hdr == NULL)
 		goto err_reg;
 
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index a91283d1e5bf..6dd960ec558c 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -360,6 +360,7 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 	struct ctl_table_header *hdr;
 	struct netns_ieee802154_lowpan *ieee802154_lowpan =
 		net_ieee802154_lowpan(net);
+	size_t table_size = ARRAY_SIZE(lowpan_frags_ns_ctl_table);
 
 	table = lowpan_frags_ns_ctl_table;
 	if (!net_eq(net, &init_net)) {
@@ -369,8 +370,10 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 			goto err_alloc;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			table[0].procname = NULL;
+			table_size = 0;
+		}
 	}
 
 	table[0].data	= &ieee802154_lowpan->fqdir->high_thresh;
@@ -379,7 +382,8 @@ static int __net_init lowpan_frags_ns_sysctl_register(struct net *net)
 	table[1].extra2	= &ieee802154_lowpan->fqdir->high_thresh;
 	table[2].data	= &ieee802154_lowpan->fqdir->timeout;
 
-	hdr = register_net_sysctl(net, "net/ieee802154/6lowpan", table);
+	hdr = register_net_sysctl_sz(net, "net/ieee802154/6lowpan", table,
+				     table_size);
 	if (hdr == NULL)
 		goto err_reg;
 
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index 5deac0517ef7..89087844ea6e 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -2720,7 +2720,8 @@ static __net_init int devinet_init_net(struct net *net)
 		goto err_reg_dflt;
 
 	err = -ENOMEM;
-	forw_hdr = register_net_sysctl(net, "net/ipv4", tbl);
+	forw_hdr = register_net_sysctl_sz(net, "net/ipv4", tbl,
+					  ARRAY_SIZE(ctl_forward_entry));
 	if (!forw_hdr)
 		goto err_reg_ctl;
 	net->ipv4.forw_hdr = forw_hdr;
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 69c00ffdcf3e..a4941f53b523 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -615,7 +615,8 @@ static int __net_init ip4_frags_ns_ctl_register(struct net *net)
 	table[2].data	= &net->ipv4.fqdir->timeout;
 	table[3].data	= &net->ipv4.fqdir->max_dist;
 
-	hdr = register_net_sysctl(net, "net/ipv4", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
+				     ARRAY_SIZE(ip4_frags_ns_ctl_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 98d7e6ba7493..e7e9fba0357a 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -3592,6 +3592,7 @@ static struct ctl_table ipv4_route_netns_table[] = {
 static __net_init int sysctl_route_net_init(struct net *net)
 {
 	struct ctl_table *tbl;
+	size_t table_size = ARRAY_SIZE(ipv4_route_netns_table);
 
 	tbl = ipv4_route_netns_table;
 	if (!net_eq(net, &init_net)) {
@@ -3603,8 +3604,10 @@ static __net_init int sysctl_route_net_init(struct net *net)
 
 		/* Don't export non-whitelisted sysctls to unprivileged users */
 		if (net->user_ns != &init_user_ns) {
-			if (tbl[0].procname != ipv4_route_flush_procname)
+			if (tbl[0].procname != ipv4_route_flush_procname) {
 				tbl[0].procname = NULL;
+				table_size = 0;
+			}
 		}
 
 		/* Update the variables to point into the current struct net
@@ -3615,7 +3618,8 @@ static __net_init int sysctl_route_net_init(struct net *net)
 	}
 	tbl[0].extra1 = net;
 
-	net->ipv4.route_hdr = register_net_sysctl(net, "net/ipv4/route", tbl);
+	net->ipv4.route_hdr = register_net_sysctl_sz(net, "net/ipv4/route",
+						     tbl, table_size);
 	if (!net->ipv4.route_hdr)
 		goto err_reg;
 	return 0;
diff --git a/net/ipv4/sysctl_net_ipv4.c b/net/ipv4/sysctl_net_ipv4.c
index 2afb0870648b..6ac890b4073f 100644
--- a/net/ipv4/sysctl_net_ipv4.c
+++ b/net/ipv4/sysctl_net_ipv4.c
@@ -1519,7 +1519,8 @@ static __net_init int ipv4_sysctl_init_net(struct net *net)
 		}
 	}
 
-	net->ipv4.ipv4_hdr = register_net_sysctl(net, "net/ipv4", table);
+	net->ipv4.ipv4_hdr = register_net_sysctl_sz(net, "net/ipv4", table,
+						    ARRAY_SIZE(ipv4_net_table));
 	if (!net->ipv4.ipv4_hdr)
 		goto err_reg;
 
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 9403bbaf1b61..57ea394ffa8c 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -178,7 +178,8 @@ static __net_init int xfrm4_net_sysctl_init(struct net *net)
 		table[0].data = &net->xfrm.xfrm4_dst_ops.gc_thresh;
 	}
 
-	hdr = register_net_sysctl(net, "net/ipv4", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv4", table,
+				     ARRAY_SIZE(xfrm4_policy_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index e5213e598a04..d615a84965c2 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -7085,7 +7085,8 @@ static int __addrconf_sysctl_register(struct net *net, char *dev_name,
 
 	snprintf(path, sizeof(path), "net/ipv6/conf/%s", dev_name);
 
-	p->sysctl_header = register_net_sysctl(net, path, table);
+	p->sysctl_header = register_net_sysctl_sz(net, path, table,
+						  ARRAY_SIZE(addrconf_sysctl));
 	if (!p->sysctl_header)
 		goto free;
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 65fa5014bc85..a76b01b41b57 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -1229,4 +1229,9 @@ struct ctl_table * __net_init ipv6_icmp_sysctl_init(struct net *net)
 	}
 	return table;
 }
+
+size_t ipv6_icmp_sysctl_table_size(void)
+{
+	return ARRAY_SIZE(ipv6_icmp_table_template);
+}
 #endif
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 5bc8a28e67f9..5ebc47da1000 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -470,7 +470,8 @@ static int __net_init ip6_frags_ns_sysctl_register(struct net *net)
 	table[1].extra2	= &net->ipv6.fqdir->high_thresh;
 	table[2].data	= &net->ipv6.fqdir->timeout;
 
-	hdr = register_net_sysctl(net, "net/ipv6", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
+				     ARRAY_SIZE(ip6_frags_ns_ctl_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 64e873f5895f..51c6cdae8723 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -6447,14 +6447,19 @@ struct ctl_table * __net_init ipv6_route_sysctl_init(struct net *net)
 		table[8].data = &net->ipv6.sysctl.ip6_rt_min_advmss;
 		table[9].data = &net->ipv6.sysctl.ip6_rt_gc_min_interval;
 		table[10].data = &net->ipv6.sysctl.skip_notify_on_dev_down;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			table[1].procname = NULL;
 	}
 
 	return table;
 }
+
+size_t ipv6_route_sysctl_table_size(struct net *net)
+{
+	/* Don't export sysctls to unprivileged users */
+	if (net->user_ns != &init_user_ns)
+		return 0;
+
+	return ARRAY_SIZE(ipv6_route_table_template);
+}
 #endif
 
 static int __net_init ip6_route_net_init(struct net *net)
diff --git a/net/ipv6/sysctl_net_ipv6.c b/net/ipv6/sysctl_net_ipv6.c
index 94a0a294c6a1..888676163e90 100644
--- a/net/ipv6/sysctl_net_ipv6.c
+++ b/net/ipv6/sysctl_net_ipv6.c
@@ -275,17 +275,23 @@ static int __net_init ipv6_sysctl_net_init(struct net *net)
 	if (!ipv6_icmp_table)
 		goto out_ipv6_route_table;
 
-	net->ipv6.sysctl.hdr = register_net_sysctl(net, "net/ipv6", ipv6_table);
+	net->ipv6.sysctl.hdr = register_net_sysctl_sz(net, "net/ipv6",
+						      ipv6_table,
+						      ARRAY_SIZE(ipv6_table_template));
 	if (!net->ipv6.sysctl.hdr)
 		goto out_ipv6_icmp_table;
 
-	net->ipv6.sysctl.route_hdr =
-		register_net_sysctl(net, "net/ipv6/route", ipv6_route_table);
+	net->ipv6.sysctl.route_hdr = register_net_sysctl_sz(net,
+							    "net/ipv6/route",
+							    ipv6_route_table,
+							    ipv6_route_sysctl_table_size(net));
 	if (!net->ipv6.sysctl.route_hdr)
 		goto out_unregister_ipv6_table;
 
-	net->ipv6.sysctl.icmp_hdr =
-		register_net_sysctl(net, "net/ipv6/icmp", ipv6_icmp_table);
+	net->ipv6.sysctl.icmp_hdr = register_net_sysctl_sz(net,
+							   "net/ipv6/icmp",
+							   ipv6_icmp_table,
+							   ipv6_icmp_sysctl_table_size());
 	if (!net->ipv6.sysctl.icmp_hdr)
 		goto out_unregister_route_table;
 
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index eecc5e59da17..8f931e46b460 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -205,7 +205,8 @@ static int __net_init xfrm6_net_sysctl_init(struct net *net)
 		table[0].data = &net->xfrm.xfrm6_dst_ops.gc_thresh;
 	}
 
-	hdr = register_net_sysctl(net, "net/ipv6", table);
+	hdr = register_net_sysctl_sz(net, "net/ipv6", table,
+				     ARRAY_SIZE(xfrm6_policy_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index bf6e81d56263..1af29af65388 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1419,7 +1419,8 @@ static int mpls_dev_sysctl_register(struct net_device *dev,
 
 	snprintf(path, sizeof(path), "net/mpls/conf/%s", dev->name);
 
-	mdev->sysctl = register_net_sysctl(net, path, table);
+	mdev->sysctl = register_net_sysctl_sz(net, path, table,
+					      ARRAY_SIZE(mpls_dev_table));
 	if (!mdev->sysctl)
 		goto free;
 
@@ -2689,7 +2690,8 @@ static int mpls_net_init(struct net *net)
 	for (i = 0; i < ARRAY_SIZE(mpls_table) - 1; i++)
 		table[i].data = (char *)net + (uintptr_t)table[i].data;
 
-	net->mpls.ctl = register_net_sysctl(net, "net/mpls", table);
+	net->mpls.ctl = register_net_sysctl_sz(net, "net/mpls", table,
+					       ARRAY_SIZE(mpls_table));
 	if (net->mpls.ctl == NULL) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/mptcp/ctrl.c b/net/mptcp/ctrl.c
index ae20b7d92e28..43e540328a52 100644
--- a/net/mptcp/ctrl.c
+++ b/net/mptcp/ctrl.c
@@ -150,7 +150,8 @@ static int mptcp_pernet_new_table(struct net *net, struct mptcp_pernet *pernet)
 	table[4].data = &pernet->stale_loss_cnt;
 	table[5].data = &pernet->pm_type;
 
-	hdr = register_net_sysctl(net, MPTCP_SYSCTL_PATH, table);
+	hdr = register_net_sysctl_sz(net, MPTCP_SYSCTL_PATH, table,
+				     ARRAY_SIZE(mptcp_sysctl_table));
 	if (!hdr)
 		goto err_reg;
 
diff --git a/net/rds/tcp.c b/net/rds/tcp.c
index c5b86066ff66..2dba7505b414 100644
--- a/net/rds/tcp.c
+++ b/net/rds/tcp.c
@@ -565,7 +565,8 @@ static __net_init int rds_tcp_init_net(struct net *net)
 	}
 	tbl[RDS_TCP_SNDBUF].data = &rtn->sndbuf_size;
 	tbl[RDS_TCP_RCVBUF].data = &rtn->rcvbuf_size;
-	rtn->rds_tcp_sysctl = register_net_sysctl(net, "net/rds/tcp", tbl);
+	rtn->rds_tcp_sysctl = register_net_sysctl_sz(net, "net/rds/tcp", tbl,
+						     ARRAY_SIZE(rds_tcp_sysctl_table));
 	if (!rtn->rds_tcp_sysctl) {
 		pr_warn("could not register sysctl\n");
 		err = -ENOMEM;
diff --git a/net/sctp/sysctl.c b/net/sctp/sysctl.c
index a7a9136198fd..f65d6f92afcb 100644
--- a/net/sctp/sysctl.c
+++ b/net/sctp/sysctl.c
@@ -612,7 +612,9 @@ int sctp_sysctl_net_register(struct net *net)
 	table[SCTP_PF_RETRANS_IDX].extra2 = &net->sctp.ps_retrans;
 	table[SCTP_PS_RETRANS_IDX].extra1 = &net->sctp.pf_retrans;
 
-	net->sctp.sysctl_header = register_net_sysctl(net, "net/sctp", table);
+	net->sctp.sysctl_header = register_net_sysctl_sz(net, "net/sctp",
+							 table,
+							 ARRAY_SIZE(sctp_net_table));
 	if (net->sctp.sysctl_header == NULL) {
 		kfree(table);
 		return -ENOMEM;
diff --git a/net/smc/smc_sysctl.c b/net/smc/smc_sysctl.c
index b6f79fabb9d3..3ab2d8eefc55 100644
--- a/net/smc/smc_sysctl.c
+++ b/net/smc/smc_sysctl.c
@@ -81,7 +81,8 @@ int __net_init smc_sysctl_net_init(struct net *net)
 			table[i].data += (void *)net - (void *)&init_net;
 	}
 
-	net->smc.smc_hdr = register_net_sysctl(net, "net/smc", table);
+	net->smc.smc_hdr = register_net_sysctl_sz(net, "net/smc", table,
+						  ARRAY_SIZE(smc_table));
 	if (!net->smc.smc_hdr)
 		goto err_reg;
 
diff --git a/net/unix/sysctl_net_unix.c b/net/unix/sysctl_net_unix.c
index 500129aa710c..3e84b31c355a 100644
--- a/net/unix/sysctl_net_unix.c
+++ b/net/unix/sysctl_net_unix.c
@@ -36,7 +36,8 @@ int __net_init unix_sysctl_register(struct net *net)
 		table[0].data = &net->unx.sysctl_max_dgram_qlen;
 	}
 
-	net->unx.ctl = register_net_sysctl(net, "net/unix", table);
+	net->unx.ctl = register_net_sysctl_sz(net, "net/unix", table,
+					      ARRAY_SIZE(unix_table));
 	if (net->unx.ctl == NULL)
 		goto err_reg;
 
diff --git a/net/xfrm/xfrm_sysctl.c b/net/xfrm/xfrm_sysctl.c
index 0c6c5ef65f9d..7fdeafc838a7 100644
--- a/net/xfrm/xfrm_sysctl.c
+++ b/net/xfrm/xfrm_sysctl.c
@@ -44,6 +44,7 @@ static struct ctl_table xfrm_table[] = {
 int __net_init xfrm_sysctl_init(struct net *net)
 {
 	struct ctl_table *table;
+	size_t table_size = ARRAY_SIZE(xfrm_table);
 
 	__xfrm_sysctl_init(net);
 
@@ -56,10 +57,13 @@ int __net_init xfrm_sysctl_init(struct net *net)
 	table[3].data = &net->xfrm.sysctl_acq_expires;
 
 	/* Don't export sysctls to unprivileged users */
-	if (net->user_ns != &init_user_ns)
+	if (net->user_ns != &init_user_ns) {
 		table[0].procname = NULL;
+		table_size = 0;
+	}
 
-	net->xfrm.sysctl_hdr = register_net_sysctl(net, "net/core", table);
+	net->xfrm.sysctl_hdr = register_net_sysctl_sz(net, "net/core", table,
+						      table_size);
 	if (!net->xfrm.sysctl_hdr)
 		goto out_register;
 	return 0;
-- 
2.30.2

