Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1D3737E8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjFUJLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjFUJKc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:10:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46DFB19AC
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:10:16 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091015euoutp01f2d6413b73cc7794fadbed7d50e68ac6~qoYfUQlYO1148511485euoutp01E
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 09:10:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621091015euoutp01f2d6413b73cc7794fadbed7d50e68ac6~qoYfUQlYO1148511485euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338615;
        bh=OWywfsEHW6wNB9csZSR6nbz7s47Wj0frTeIAnopGDR4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KSH/H253lKqtKFMDmm8dEdmUj6T6OKFK6Jk8h6UJtHuMTa3CciVENHtKMbLVYwTVd
         XfOJJdqx2xMDgqj3gTPSlO6avC/i7vleGoAbCN9HcZ3rhLBdLg4QxNeUPREFgUx3mn
         H3M/DG/ph+jBxp6owAHJ3aYJ1AymgZQIlf3RrZcY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621091014eucas1p1f04da8b1fb1dad1e10c0b30185138bc7~qoYez4JUH2864928649eucas1p1H;
        Wed, 21 Jun 2023 09:10:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 35.8E.11320.67EB2946; Wed, 21
        Jun 2023 10:10:14 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0~qoYeXJLcA3218932189eucas1p17;
        Wed, 21 Jun 2023 09:10:14 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091014eusmtrp258b508b40395627575162a2d27af0935~qoYeWjday2207922079eusmtrp2a;
        Wed, 21 Jun 2023 09:10:14 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-a5-6492be760730
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B9.0F.10549.67EB2946; Wed, 21
        Jun 2023 10:10:14 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230621091013eusmtip175549cf05b6fa79e82b1c8d646058274~qoYeM01d-2702427024eusmtip1e;
        Wed, 21 Jun 2023 09:10:13 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:13 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: [PATCH 05/11] sysctl: Add a size arg to __register_sysctl_table
Date:   Wed, 21 Jun 2023 11:09:54 +0200
Message-ID: <20230621091000.424843-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djP87pl+yalGNzqlLGYc76FxeLpsUfs
        Fme6cy0ubOtjtdiz9ySLxeVdc9gsbkx4ymhxbIGYxbfTbxgtlu30c+DymN1wkcVjy8qbTB4L
        NpV6bFrVyebxft9VNo/Pm+QC2KK4bFJSczLLUov07RK4Mp6ffM9SMFOzYvOptWwNjE1KXYyc
        HBICJhKTp21j6mLk4hASWMEocXHLbVYI5wujxNK/x9lAqoQEPjNKXD6uCNMxqeklG0TRckaJ
        1f/PQzlARU+XbGeGcLYySmzaOAesnU1AR+L8mztgCRGQqsN/9zKBJJgF2hklTnzPA7GFBTwk
        Nj/YwAhiswioSjQfe8sOYvMK2EjMa7rKBLFbXqLt+nSwGk4BW4nzj9+zQNQISpyc+YQFYqa8
        RPPW2cwQtoTEwRcvmCF6lSWu71vMBmHXSpzacgvsawmBdk6JvT9fskMkXCTaH9+EsoUlXh3f
        AmXLSPzfOR+qYTKjxP5/H9ghnNWMEssav0KdZy3RcuUJVIejxJn7m4FO5QCy+SRuvBWEuIhP
        YtK26cwQYV6JjjahCYwqs5D8MAvJD7OQ/LCAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+
        7iZGYFI6/e/4lx2My1991DvEyMTBeIhRgoNZSYRXdtOkFCHelMTKqtSi/Pii0pzU4kOM0hws
        SuK82rYnk4UE0hNLUrNTUwtSi2CyTBycUg1MW1l+274InHjs+RLZOuXEvSWNdmrtPlLXe2/f
        YFf/wdpz2vNHt2P1tmwh1+cMm7jc9pltS110PeSwgfCqMx2bP/6YYTnzd8vpmCSZ5T2lRme4
        tu5POP51y7aYwkl515bM/l/0wv7v/1jlrVejrxnoPXRyOmqaeWP3hkcndji+KvbP5Hne0Mlz
        ZMNLman7uIV9Hv7RKro7tVfLem3vhSa99ef2Zwa4fyo9om7OujmIP6Hh2irzyecZTuj0hO25
        rrr5l6hxxNdFc6WLDuyxL2p8rru77OkuU6uUZQn85x7Y99oZ7FLNDOsy7pqiG2BxeX1T7ZKb
        hidaPKzmd/yJajzRlJlx9MgfFyGNJr7/UQ1qSizFGYmGWsxFxYkA+2Nb17kDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsVy+t/xu7pl+yalGFz6zGwx53wLi8XTY4/Y
        Lc5051pc2NbHarFn70kWi8u75rBZ3JjwlNHi2AIxi2+n3zBaLNvp58DlMbvhIovHlpU3mTwW
        bCr12LSqk83j/b6rbB6fN8kFsEXp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZ
        Kunb2aSk5mSWpRbp2yXoZTw/+Z6lYKZmxeZTa9kaGJuUuhg5OSQETCQmNb1k62Lk4hASWMoo
        sez3PRaIhIzExi9XWSFsYYk/17qgij4ySszfPpMdwtnKKHHn6itGkCo2AR2J82/uMIMkRAQ+
        M0oc/ruXCSTBLNDOKHHiex6ILSzgIbH5wQawBhYBVYnmY2/ZQWxeARuJeU1XmSDWyUu0XZ8O
        VsMpYCtx/vF7sJOEgGrmf7jMCFEvKHFy5hMWiPnyEs1bZzND2BISB1+8YIaYoyxxfd9iNgi7
        VuLz32eMExhFZiFpn4WkfRaS9gWMzKsYRVJLi3PTc4sN9YoTc4tL89L1kvNzNzECI3bbsZ+b
        dzDOe/VR7xAjEwfjIUYJDmYlEV7ZTZNShHhTEiurUovy44tKc1KLDzGaAv05kVlKNDkfmDLy
        SuINzQxMDU3MLA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYpt4wcW7gbtvyd5XO
        knfBGX+mJNvEPG2y1Mralmmd17wpRfDAzh1Bl3x3/r/0+Z3G75zj0ZtqdSK2ejXffCORxx/v
        F/UjrnFShJve+t/SnjvmR0+cYpjo6v78rcenfS+9k22eum//xqyaMzMs1iXyKMP+U6F5cssf
        n1oSoO2+4dvxLwazY4NmfzkaK+36LsW/+4z20kg9hxneU9Tq10+qLP4mfeWy5LW4IxM+Zm/Q
        DjJpZE3Y9e5/b3L2zWeGteclTq6zuOD9Imz+TZPQH6cK+d+ErH+m1fQzyVo6bJOYonv3nryI
        U4d26Sp/snok5qak/68o46ZXpzG3m2hOnWthdmhR2zKFZ6b970NeR3YqsRRnJBpqMRcVJwIA
        PC6WYmEDAAA=
X-CMS-MailID: 20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0
X-Msg-Generator: CA
X-RootMTR: 20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091014eucas1p1a30430568d0f7fec5ccbed31cab73aa0@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In order to remove the end element from the ctl_table struct arrays, we
explicitly define the size when registering the targets.
__register_sysctl_table is the first function to grow a size argument.
For this commit to focus only on that function, we temporarily implement
a size calculation in register_net_sysctl, which is an indirection call
for all the network register calls.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c  | 22 +++++++++++-----------
 include/linux/sysctl.h |  2 +-
 ipc/ipc_sysctl.c       |  4 +++-
 ipc/mq_sysctl.c        |  4 +++-
 kernel/ucount.c        |  3 ++-
 net/sysctl_net.c       |  8 +++++++-
 6 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 09c09c373624..8c415048d540 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1354,27 +1354,20 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  */
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table)
+	const char *path, struct ctl_table *table, size_t table_size)
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
-	struct ctl_table_header h_tmp;
 	struct ctl_dir *dir;
-	struct ctl_table *entry;
 	struct ctl_node *node;
-	int nr_entries = 0;
-
-	h_tmp.ctl_table = table;
-	list_for_each_table_entry(entry, (&h_tmp))
-		nr_entries++;
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
-			 sizeof(struct ctl_node)*nr_entries, GFP_KERNEL_ACCOUNT);
+			 sizeof(struct ctl_node)*table_size, GFP_KERNEL_ACCOUNT);
 	if (!header)
 		return NULL;
 
 	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table, nr_entries);
+	init_header(header, root, set, node, table, table_size);
 	if (sysctl_check_table(path, header))
 		goto fail;
 
@@ -1423,8 +1416,15 @@ struct ctl_table_header *__register_sysctl_table(
  */
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
 {
+	int count = 0;
+	struct ctl_table *entry;
+	struct ctl_table_header t_hdr;
+
+	t_hdr.ctl_table = table;
+	list_for_each_table_entry(entry, (&t_hdr))
+		count++;
 	return __register_sysctl_table(&sysctl_table_root.default_set,
-					path, table);
+					path, table, count);
 }
 EXPORT_SYMBOL(register_sysctl);
 
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 33252ad58ebe..0495c858989f 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -226,7 +226,7 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
-	const char *path, struct ctl_table *table);
+	const char *path, struct ctl_table *table, size_t table_size);
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
diff --git a/ipc/ipc_sysctl.c b/ipc/ipc_sysctl.c
index ef313ecfb53a..8c62e443f78b 100644
--- a/ipc/ipc_sysctl.c
+++ b/ipc/ipc_sysctl.c
@@ -259,7 +259,9 @@ bool setup_ipc_sysctls(struct ipc_namespace *ns)
 				tbl[i].data = NULL;
 		}
 
-		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set, "kernel", tbl);
+		ns->ipc_sysctls = __register_sysctl_table(&ns->ipc_set,
+							  "kernel", tbl,
+							  ARRAY_SIZE(ipc_sysctls));
 	}
 	if (!ns->ipc_sysctls) {
 		kfree(tbl);
diff --git a/ipc/mq_sysctl.c b/ipc/mq_sysctl.c
index fbf6a8b93a26..ebb5ed81c151 100644
--- a/ipc/mq_sysctl.c
+++ b/ipc/mq_sysctl.c
@@ -109,7 +109,9 @@ bool setup_mq_sysctls(struct ipc_namespace *ns)
 				tbl[i].data = NULL;
 		}
 
-		ns->mq_sysctls = __register_sysctl_table(&ns->mq_set, "fs/mqueue", tbl);
+		ns->mq_sysctls = __register_sysctl_table(&ns->mq_set,
+							 "fs/mqueue", tbl,
+							 ARRAY_SIZE(mq_sysctls));
 	}
 	if (!ns->mq_sysctls) {
 		kfree(tbl);
diff --git a/kernel/ucount.c b/kernel/ucount.c
index ee8e57fd6f90..2b80264bb79f 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -104,7 +104,8 @@ bool setup_userns_sysctls(struct user_namespace *ns)
 		for (i = 0; i < UCOUNT_COUNTS; i++) {
 			tbl[i].data = &ns->ucount_max[i];
 		}
-		ns->sysctls = __register_sysctl_table(&ns->set, "user", tbl);
+		ns->sysctls = __register_sysctl_table(&ns->set, "user", tbl,
+						      ARRAY_SIZE(user_table));
 	}
 	if (!ns->sysctls) {
 		kfree(tbl);
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 4b45ed631eb8..8ee4b74bc009 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -163,10 +163,16 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 struct ctl_table_header *register_net_sysctl(struct net *net,
 	const char *path, struct ctl_table *table)
 {
+	int count = 0;
+	struct ctl_table *entry;
+
 	if (!net_eq(net, &init_net))
 		ensure_safe_net_sysctl(net, path, table);
 
-	return __register_sysctl_table(&net->sysctls, path, table);
+	for (entry = table; entry->procname; entry++)
+		count++;
+
+	return __register_sysctl_table(&net->sysctls, path, table, count);
 }
 EXPORT_SYMBOL_GPL(register_net_sysctl);
 
-- 
2.30.2

