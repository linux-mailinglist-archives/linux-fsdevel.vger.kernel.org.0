Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9777580F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 12:50:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbjHIKul (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 06:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjHIKu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:50:28 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949BD2103;
        Wed,  9 Aug 2023 03:50:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe12820bffso56185055e9.3;
        Wed, 09 Aug 2023 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578218; x=1692183018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n8WLnI9NId3N3IQiFQMWfeeUSr/hiuHAn49PsdG5OBk=;
        b=G5UjtZWPGy6S5eNATufUnMApcMcaVXqFhOM20JKkSaaVgymfVhdqs91ExDyXsJZQZ2
         6WIhkZl5qiZ+XMOFG7HsNKewrnfixKZVTmcE/C6vRpWAGC73dBJl8R32BSB5xeFszUh7
         s0kWjTjVDfuPF3THEJLbJhiXjUlr715m1Ej7CL3B0T93D+wQO2SoFKOG7rQx/vF6WGBS
         H4FjT/JLGJbHy5Nr63+PXJWeo3+rKV9AonsSKHh9PLhA1HmoVPpqBQSwAMiqzPkJqZNL
         1GaYsLbl9RRGGmHU9YkywMyLSMw9z0q3XI31FJKM2uJlL6LAREOGqPhUAbIs7D/L7LIe
         XV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578218; x=1692183018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n8WLnI9NId3N3IQiFQMWfeeUSr/hiuHAn49PsdG5OBk=;
        b=Apo31MIIaLhG3TUQeSQGoT4T2BqJhpEMvqmngDE08IFh+3nGZitcBC/SfY71wWYIrv
         twVE4fICoZ961U83j1iuPfbBfSnysyWXmG6zu0JKvJwSmHL6Htzc1bTgeAfU33eC9nUy
         OHVCKpe58CgxdN37PYd9qiqNiUz8zsivCaKSGfHeGVoLz3cl0K1bHLrFGIsDjqYIk7Xb
         f84Mc4qLkL8R9gPBpFvyOVwvVL15K5iSsUbh4P8wCLv7SjhwM9fd2EqztXSTl6iWhUKT
         3M4x4u/vJ3VJNZmaDXZ1RnesnOfJF0ftvKRRLj/wEmehjABb0kQstYrMhsX4gK8DekJS
         LFmA==
X-Gm-Message-State: AOJu0Yz0LcKM+AUG3xJFFEN8H0jq9tf/eCRoFSK9rRatIldwMAfoqA40
        C0IF7kQMuWVM0uuCMIY+/XU=
X-Google-Smtp-Source: AGHT+IH/57yPWk/NifMUsdcRzlFAS1Fjg53aJ6vQ4JPEzLZ2XFL7yl3WCwkfMZUhxANmN8BCoOClzQ==
X-Received: by 2002:a7b:cbd6:0:b0:3fc:7eb:1119 with SMTP id n22-20020a7bcbd6000000b003fc07eb1119mr1914043wmi.15.1691578218519;
        Wed, 09 Aug 2023 03:50:18 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id c9-20020a056000104900b00317d2be2e59sm15087933wrx.73.2023.08.09.03.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:18 -0700 (PDT)
From:   Joel Granados <joel.granados@gmail.com>
X-Google-Original-From: Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org
Cc:     rds-devel@oss.oracle.com, "David S. Miller" <davem@davemloft.net>,
        Florian Westphal <fw@strlen.de>, willy@infradead.org,
        Jan Karcher <jaka@linux.ibm.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        Simon Horman <horms@verge.net.au>,
        Tony Lu <tonylu@linux.alibaba.com>, linux-wpan@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        mptcp@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Will Deacon <will@kernel.org>, Julian Anastasov <ja@ssi.bg>,
        netfilter-devel@vger.kernel.org, Joerg Reuter <jreuter@yaina.de>,
        linux-kernel@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-sctp@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-hams@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        coreteam@netfilter.org, Ralf Baechle <ralf@linux-mips.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        keescook@chromium.org, Roopa Prabhu <roopa@nvidia.com>,
        David Ahern <dsahern@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Wenjia Zhang <wenjia@linux.ibm.com>, josh@joshtriplett.org,
        linux-fsdevel@vger.kernel.org,
        Alexander Aring <alex.aring@gmail.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        netdev@vger.kernel.org,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-s390@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Eric Dumazet <edumazet@google.com>, lvs-devel@vger.kernel.org,
        linux-rdma@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        bridge@lists.linux-foundation.org,
        Karsten Graul <kgraul@linux.ibm.com>,
        Mat Martineau <martineau@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 05/14] sysctl: Add a size arg to __register_sysctl_table
Date:   Wed,  9 Aug 2023 12:49:57 +0200
Message-Id: <20230809105006.1198165-6-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230809105006.1198165-1-j.granados@samsung.com>
References: <20230809105006.1198165-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We make these changes in order to prepare __register_sysctl_table and
its callers for when we remove the sentinel element (empty element at
the end of ctl_table arrays). We don't actually remove any sentinels in
this commit, but we *do* make sure to use ARRAY_SIZE so the table_size
is available when the removal occurs.

We add a table_size argument to __register_sysctl_table and adjust
callers, all of which pass ctl_table pointers and need an explicit call
to ARRAY_SIZE. We implement a size calculation in register_net_sysctl in
order to forward the size of the array pointer received from the network
register calls.

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

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c  | 23 ++++++++++++-----------
 include/linux/sysctl.h |  2 +-
 ipc/ipc_sysctl.c       |  4 +++-
 ipc/mq_sysctl.c        |  4 +++-
 kernel/ucount.c        |  3 ++-
 net/sysctl_net.c       |  8 +++++++-
 6 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index fa1438f1a355..b8dd78e344ff 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1312,6 +1312,7 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * 	 should not be free'd after registration. So it should not be
  * 	 used on stack. It can either be a global or dynamically allocated
  * 	 by the caller and free'd later after sysctl unregistration.
+ * @table_size : The number of elements in table
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1354,27 +1355,20 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
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
 
@@ -1423,8 +1417,15 @@ struct ctl_table_header *__register_sysctl_table(
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

