Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932C3763865
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:07:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233183AbjGZOHm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233868AbjGZOHG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:06 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6847F2D4E
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:06:59 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140658euoutp01274db3e1f2b51bae8604f0dfded62239~1cAjD1xYX3211332113euoutp01U
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:06:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230726140658euoutp01274db3e1f2b51bae8604f0dfded62239~1cAjD1xYX3211332113euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380418;
        bh=uk1lVMRV3vGO5Qj9WjqlASY9SYqLs0/HcEQUQxX19Rw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EKAmgduM7qzb2gIDDmckuuVzf25+OAdO4ayEbPOT+yir3pA0BER3a2MX63wSH3eWW
         sTNl5PPj29iH8ZzwTXL49RvffUsKQElqVXaniGzXlxgnx2bmdqJoyALh2F8SDKbDF3
         jtpD0M5ya253gi1NtX8OVUVfiSY8PkAwyBN2gLRI=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140657eucas1p15c9fb223083bdcc0cb2e453039297ba1~1cAicl1Jr2260622606eucas1p1v;
        Wed, 26 Jul 2023 14:06:57 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 23.F6.11320.18821C46; Wed, 26
        Jul 2023 15:06:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55~1cAh7604I0631806318eucas1p2d;
        Wed, 26 Jul 2023 14:06:56 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230726140656eusmtrp27aa5978c675164d2f45044b932f3fabb~1cAh7N5a32014720147eusmtrp2X;
        Wed, 26 Jul 2023 14:06:56 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-2c-64c12881da24
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 41.57.14344.08821C46; Wed, 26
        Jul 2023 15:06:56 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140656eusmtip1bd0558d02c1d90789e02183fa3849da1~1cAhrKSyu0800208002eusmtip1X;
        Wed, 26 Jul 2023 14:06:56 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 05/14] sysctl: Add a size arg to __register_sysctl_table
Date:   Wed, 26 Jul 2023 16:06:25 +0200
Message-Id: <20230726140635.2059334-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUwTURDG87rbdkFqtoXYEVEjnqBWMRrXA7x1NV6EaOIVaegGOVpMS/E2
        KJeCNlhUQsVQL44qEGtFMVoQBayoKFBBPBBjNQoeCHIHbLsY/W/mm9+8b77kEZjIzPUkwhTR
        jFIhjfTmueJFFT3Pph+Zcl82M9cqpDKr43HKVvGBT10paUbUoD6KepIip54XabjU3XsWnKq9
        k8mjGlJtiKrQj6A6q1oR1ddtl7KL1y8W0OdiX+C0Ke8Vh9Yb1fSNXF+6scWfNhqO8+gfZiuP
        1pgMiG43jtnostV1oYyJDIthlDMCgl13vcqxYLsrJXvTU6y8WGSelIxcCCBng6FJjyUjV0JE
        5iLQPj6B2KYDQZdJN9S0IyhLvMD/u6JLiMMctYjMQZBVx7DQFwQFpflcx4BHToPq1jfOdz3I
        NgSajMd8R4ORhQisHReRg3InabjcU+DcwMmJkJFqcVoISH/ozG/HWbuxkFif7uRdyADIy+/i
        sowQLBkfnQxmZ+JunsNYvpuAgevBbL0cas0ViK3d4WulaSiCFwwWZ3EcBwGZhqBk4Cefba4i
        yD7ym8NSCyC+7qN9QNgdfKDwzgxWXgK1318ihwzkcGj4JmRvGA7aonSMlQVwLFHE0hNAc+X0
        UBRPqK8t5rE1DSXZCdxUNE73Xxrdf2l0/3z1CDMgMaNWyUMZ1SwFs0eikspVakWoJCRKbkT2
        L1Y1UNlxG+V8bZOUIQ6ByhAQmLeHwG+7WSYSyKT79jPKqJ1KdSSjKkOjCNxbLJjqbwkRkaHS
        aCaCYXYzyr9TDuHiGcuBvoIw8Y60/vPJKTM1/NmTNcmTQdSyuWbt2ftJamEpc2zYA02P7UV5
        eMqeLeMnrHy2LSP0/aWkwM8+h87k1/g++tRt9FgTzfk1JzPiMml4HV9K3E0YG5R0c564+mFx
        d8M6/YO61sq+H/vT621yqdesg37aXnz9p/nf322zBvfb8qo+lyiqjvK313fG+MSeiFKHXCRG
        rtAv9u8PzDRf61VsahI2nvrgfnT5gfPySKMlQHB4wegDEXE+I+Pn4uLmwvD5ppinUoliaVCN
        29YWbZCbV9etwCbfwZVxstVvrwlt2qxhi5a1hee8LX+oXKUWbOh162PIiQHZ0cTv5h0nX5df
        YBqXeOOqXVI/X0ypkv4BDrPZ4tEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsVy+t/xu7oNGgdTDLrv6lnMOd/CYvH02CN2
        i6X7HzJa/F+Qb3GmO9fiwrY+Vos9e0+yWFzeNYfN4saEp4wWxxaIWXw7/YbR4vcPoNCynX4O
        vB6zGy6yeGxZeZPJY8GmUo/NK7Q8br229di0qpPN4/2+q2wefVtWMXp83iQXwBmlZ1OUX1qS
        qpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwea2VkqqRvZ5OSmpNZllqkb5egl3Fz+UnmguN6FdO7
        r7I1MO5T62Lk5JAQMJGY1drM3MXIxSEksJRR4kP/NdYuRg6ghJTE92WcEDXCEn+udbFB1Dxn
        lHiy7xQrSIJNQEfi/Js7YM0iAt8ZJTp6V4A5zAJbGSU6d71nA6kSFvCQWPJzHVgHi4CqxMwJ
        J9lBbF4BW4lvaz+zQKyQl2i7Pp0RxOYUsJNYufY7WL0QUE3P1KdQ9YISJ2c+AatnBqpv3jqb
        eQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6RUn5haX5qXrJefnbmIERtu2Yz+37GBc+eqj3iFG
        Jg7GQ4wSHMxKIryGMftShHhTEiurUovy44tKc1KLDzGaAt09kVlKNDkfGO95JfGGZgamhiZm
        lgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1Mm6ampZy1cZC48CS01en3rhtv7Vsy
        T5V6nSn4carQOPS98Js4e7ncTVvNv0ZaVR7c8c5CM8051n3KzpPzP22X9dPbw9QVavfG4aqo
        qvpRQfepbAteXWX/urXifKH79zc5J4o01R6fvch7slf3l+OE/VYu5tN29DdrS24KTa71MZZn
        cpHlTVbK9imfqRJ6pkpn0kWLO4cbPBylX/CJsEtsiMh7n9D5tdBiW1ble9X6x2czT/0sv27l
        uijshOeCjLL7W4oEoieJq6qELuac058fpCagzW9mGf/vhu8q9g37KzpSZpqa17/Q5HoR0ssc
        eWCOQ8Zla505xdsWlc1lyuh/JlL6xdlxcv2JacG3TyqxFGckGmoxFxUnAgDdHjk0PwMAAA==
X-CMS-MailID: 20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140656eucas1p26cd9da21663d25b51dda75258aaa3b55@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the effort to remove the sentinel element in the
ctl_table arrays. We add a table_size argument to
__register_sysctl_table and adjust callers, all of which pass ctl_table
pointers and need an explicit call to ARRAY_SIZE.

The new table_size argument does not yet have any effect in the
init_header call which is still dependent on the sentinel's presence.
table_size *does* however drive the `kzalloc` allocation in
__register_sysctl_table with no adverse effects as the allocated memory
is either one element greater than the calculated ctl_table array (for
the calls in ipc_sysctl.c, mq_sysctl.c and ucount.c) or the exact size
of the calculated ctl_table array (for the call from sysctl_net.c and
register_sysctl). This approach will allows us to "just" remove the
sentinel without further changes to __register_sysctl_table as
table_size will represent the exact size for all the callers at that
point.

Temporarily implement a size calculation in register_net_sysctl, which
is an indirection call for all the network register calls.

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
index fa1438f1a355..8d04f01a89c1 100644
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

