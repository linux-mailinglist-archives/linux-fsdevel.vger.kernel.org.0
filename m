Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31281768E23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjGaHUa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231895AbjGaHT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:27 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8665719AC;
        Mon, 31 Jul 2023 00:17:51 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so34348621fa.1;
        Mon, 31 Jul 2023 00:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787870; x=1691392670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwBOPTRg/ixTL80VmebTXSLlDx0EjleTiSta/enZ0MQ=;
        b=MioizldJtzYyFM8fT/qRqCJ0/CjctsqnSH0k3cEfmrLcwzbKUd3/a7FibDvZOUeqHr
         CNn6eDjqFMUzZN3BjE+0fwUq6l9tGnys0JPfy/a96wh1yE+zxnI+ats2UApCpt8zFeGZ
         SbjwP3l4j0iFYhcoiomUMzX/SGAvTmimLUctQ5cC1n0LH2vxL6S4c19Ta1ZAE2LZxvF7
         DK8hcEFexsYWrx4rCJcea7GPTFa91ji0kF7S9aInAlwqgdJFHRaJ/etWjlzGJM386xy5
         t6mhQKzeRCghmF14N+qcPoBiTeqXPQFUAZQ8vs1cNT3zlb10a4q5c/HnmhR8nhtmJGRW
         t9AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787870; x=1691392670;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwBOPTRg/ixTL80VmebTXSLlDx0EjleTiSta/enZ0MQ=;
        b=ILifGX1jfbvweYLSvDzt+YZxuPmBhNILx+01/0v5VItjbIK2FIl/XoKPIVuY44b4hg
         pC/Vesg1KypOOdlQV9K+cGl2AdfEeztO2gxVluPFxg6yM5pCrEEwrsBmCAgHQi6odvRJ
         xV6u0p8Fc52bwovt9tePzRoVLjrY8Q3BGqeSw8g4pDsGPrnKiet0AVqK5n8JhFwh1z4B
         kgeTeGPCZB+f38dnwNO71rWPeIQDi5VYD2lTSFiqRIQvwXb1uHXknYS75gZ+O083bZDQ
         llF7zyBM4wONuMvlqivefaGNHNG2YP0Zt4DLWHaD8Y18l2UqKqi4/RB9nnfCJrLcNMfR
         Lo2g==
X-Gm-Message-State: ABy/qLY0rpx4pxCzWygk6yv0fHSRr+SVLAHtNuvyoX49HuCVEtfXmEJf
        Sno1VSo+brsu2gdVN5OSoyc=
X-Google-Smtp-Source: APBJJlGqCi9j5QGN4uPvR6N+rIkRlmGaOmThikAqjJ5JSam2jN9u636C4rfI/XmZvG+R89U2vR12Cw==
X-Received: by 2002:a2e:86d8:0:b0:2b9:eb9d:cc51 with SMTP id n24-20020a2e86d8000000b002b9eb9dcc51mr1133211ljj.49.1690787869690;
        Mon, 31 Jul 2023 00:17:49 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id m9-20020a7bce09000000b003fe1ddd6ac0sm3226163wmc.35.2023.07.31.00.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:49 -0700 (PDT)
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
Subject: [PATCH v2 10/14] netfilter: Update to register_net_sysctl_sz
Date:   Mon, 31 Jul 2023 09:17:24 +0200
Message-Id: <20230731071728.3493794-11-j.granados@samsung.com>
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
netfilter related files. Do this while making sure to mirror the NULL
assignments with a table_size of zero for the unprivileged users.

We need to move to the new function in preparation for when we change
SIZE_MAX to ARRAY_SIZE() in the register_net_sysctl macro. Failing to do
so would erroneously allow ARRAY_SIZE() to be called on a pointer. We
hold off the SIZE_MAX to ARRAY_SIZE change until we have migrated all
the relevant net sysctl registering functions to register_net_sysctl_sz
in subsequent commits.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 net/bridge/br_netfilter_hooks.c         |  3 ++-
 net/ipv6/netfilter/nf_conntrack_reasm.c |  3 ++-
 net/netfilter/ipvs/ip_vs_ctl.c          |  8 ++++++--
 net/netfilter/ipvs/ip_vs_lblc.c         | 10 +++++++---
 net/netfilter/ipvs/ip_vs_lblcr.c        | 10 +++++++---
 net/netfilter/nf_conntrack_standalone.c |  4 +++-
 net/netfilter/nf_log.c                  |  7 ++++---
 7 files changed, 31 insertions(+), 14 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 1a801fab9543..15186247b59a 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -1135,7 +1135,8 @@ static int br_netfilter_sysctl_init_net(struct net *net)
 
 	br_netfilter_sysctl_default(brnet);
 
-	brnet->ctl_hdr = register_net_sysctl(net, "net/bridge", table);
+	brnet->ctl_hdr = register_net_sysctl_sz(net, "net/bridge", table,
+						ARRAY_SIZE(brnf_table));
 	if (!brnet->ctl_hdr) {
 		if (!net_eq(net, &init_net))
 			kfree(table);
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index d13240f13607..b2dd48911c8d 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -87,7 +87,8 @@ static int nf_ct_frag6_sysctl_register(struct net *net)
 	table[2].data	= &nf_frag->fqdir->high_thresh;
 	table[2].extra1	= &nf_frag->fqdir->low_thresh;
 
-	hdr = register_net_sysctl(net, "net/netfilter", table);
+	hdr = register_net_sysctl_sz(net, "net/netfilter", table,
+				     ARRAY_SIZE(nf_ct_frag6_sysctl_table));
 	if (hdr == NULL)
 		goto err_reg;
 
diff --git a/net/netfilter/ipvs/ip_vs_ctl.c b/net/netfilter/ipvs/ip_vs_ctl.c
index 62606fb44d02..8d69e4c2d822 100644
--- a/net/netfilter/ipvs/ip_vs_ctl.c
+++ b/net/netfilter/ipvs/ip_vs_ctl.c
@@ -4266,6 +4266,7 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 	struct net *net = ipvs->net;
 	struct ctl_table *tbl;
 	int idx, ret;
+	size_t ctl_table_size = ARRAY_SIZE(vs_vars);
 
 	atomic_set(&ipvs->dropentry, 0);
 	spin_lock_init(&ipvs->dropentry_lock);
@@ -4282,8 +4283,10 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			tbl[0].procname = NULL;
+			ctl_table_size = 0;
+		}
 	} else
 		tbl = vs_vars;
 	/* Initialize sysctl defaults */
@@ -4353,7 +4356,8 @@ static int __net_init ip_vs_control_net_init_sysctl(struct netns_ipvs *ipvs)
 #endif
 
 	ret = -ENOMEM;
-	ipvs->sysctl_hdr = register_net_sysctl(net, "net/ipv4/vs", tbl);
+	ipvs->sysctl_hdr = register_net_sysctl_sz(net, "net/ipv4/vs", tbl,
+						  ctl_table_size);
 	if (!ipvs->sysctl_hdr)
 		goto err;
 	ipvs->sysctl_tbl = tbl;
diff --git a/net/netfilter/ipvs/ip_vs_lblc.c b/net/netfilter/ipvs/ip_vs_lblc.c
index 1b87214d385e..cf78ba4ce5ff 100644
--- a/net/netfilter/ipvs/ip_vs_lblc.c
+++ b/net/netfilter/ipvs/ip_vs_lblc.c
@@ -550,6 +550,7 @@ static struct ip_vs_scheduler ip_vs_lblc_scheduler = {
 static int __net_init __ip_vs_lblc_init(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
+	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
 
 	if (!ipvs)
 		return -ENOENT;
@@ -562,16 +563,19 @@ static int __net_init __ip_vs_lblc_init(struct net *net)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			ipvs->lblc_ctl_table[0].procname = NULL;
+			vars_table_size = 0;
+		}
 
 	} else
 		ipvs->lblc_ctl_table = vs_vars_table;
 	ipvs->sysctl_lblc_expiration = DEFAULT_EXPIRATION;
 	ipvs->lblc_ctl_table[0].data = &ipvs->sysctl_lblc_expiration;
 
-	ipvs->lblc_ctl_header =
-		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblc_ctl_table);
+	ipvs->lblc_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
+						       ipvs->lblc_ctl_table,
+						       vars_table_size);
 	if (!ipvs->lblc_ctl_header) {
 		if (!net_eq(net, &init_net))
 			kfree(ipvs->lblc_ctl_table);
diff --git a/net/netfilter/ipvs/ip_vs_lblcr.c b/net/netfilter/ipvs/ip_vs_lblcr.c
index ad8f5fea6d3a..9eddf118b40e 100644
--- a/net/netfilter/ipvs/ip_vs_lblcr.c
+++ b/net/netfilter/ipvs/ip_vs_lblcr.c
@@ -736,6 +736,7 @@ static struct ip_vs_scheduler ip_vs_lblcr_scheduler =
 static int __net_init __ip_vs_lblcr_init(struct net *net)
 {
 	struct netns_ipvs *ipvs = net_ipvs(net);
+	size_t vars_table_size = ARRAY_SIZE(vs_vars_table);
 
 	if (!ipvs)
 		return -ENOENT;
@@ -748,15 +749,18 @@ static int __net_init __ip_vs_lblcr_init(struct net *net)
 			return -ENOMEM;
 
 		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
+		if (net->user_ns != &init_user_ns) {
 			ipvs->lblcr_ctl_table[0].procname = NULL;
+			vars_table_size = 0;
+		}
 	} else
 		ipvs->lblcr_ctl_table = vs_vars_table;
 	ipvs->sysctl_lblcr_expiration = DEFAULT_EXPIRATION;
 	ipvs->lblcr_ctl_table[0].data = &ipvs->sysctl_lblcr_expiration;
 
-	ipvs->lblcr_ctl_header =
-		register_net_sysctl(net, "net/ipv4/vs", ipvs->lblcr_ctl_table);
+	ipvs->lblcr_ctl_header = register_net_sysctl_sz(net, "net/ipv4/vs",
+							ipvs->lblcr_ctl_table,
+							vars_table_size);
 	if (!ipvs->lblcr_ctl_header) {
 		if (!net_eq(net, &init_net))
 			kfree(ipvs->lblcr_ctl_table);
diff --git a/net/netfilter/nf_conntrack_standalone.c b/net/netfilter/nf_conntrack_standalone.c
index 169e16fc2bce..0ee98ce5b816 100644
--- a/net/netfilter/nf_conntrack_standalone.c
+++ b/net/netfilter/nf_conntrack_standalone.c
@@ -1106,7 +1106,9 @@ static int nf_conntrack_standalone_init_sysctl(struct net *net)
 		table[NF_SYSCTL_CT_BUCKETS].mode = 0444;
 	}
 
-	cnet->sysctl_header = register_net_sysctl(net, "net/netfilter", table);
+	cnet->sysctl_header = register_net_sysctl_sz(net, "net/netfilter",
+						     table,
+						     ARRAY_SIZE(nf_ct_sysctl_table));
 	if (!cnet->sysctl_header)
 		goto out_unregister_netfilter;
 
diff --git a/net/netfilter/nf_log.c b/net/netfilter/nf_log.c
index 8a29290149bd..8cc52d2bd31b 100644
--- a/net/netfilter/nf_log.c
+++ b/net/netfilter/nf_log.c
@@ -487,9 +487,10 @@ static int netfilter_log_sysctl_init(struct net *net)
 	for (i = NFPROTO_UNSPEC; i < NFPROTO_NUMPROTO; i++)
 		table[i].extra2 = net;
 
-	net->nf.nf_log_dir_header = register_net_sysctl(net,
-						"net/netfilter/nf_log",
-						table);
+	net->nf.nf_log_dir_header = register_net_sysctl_sz(net,
+							   "net/netfilter/nf_log",
+							   table,
+							   ARRAY_SIZE(nf_log_sysctl_table));
 	if (!net->nf.nf_log_dir_header)
 		goto err_reg;
 
-- 
2.30.2

