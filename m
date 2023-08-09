Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED23775804
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 12:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjHIKui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 06:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjHIKua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:50:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EE4210D;
        Wed,  9 Aug 2023 03:50:22 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-31751d7d96eso5003387f8f.1;
        Wed, 09 Aug 2023 03:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578221; x=1692183021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jc/kMJ2DPFYVg7IBTR4njcXwjXlJ4l2BnySUNEp3oa4=;
        b=ZrEKDiJHGQ5/dr7OKRfXsJCsgSJpcnxTM5si5Nic39v6KHOyXLbemrwE267SkiiECs
         Euupg+AbXcQfEcDDKDwXcqU3nX88C1jMyTwgsY+EU/3nqUcCE80Uug04nB5mlBI9JOOA
         m09LhW7d5q3R98tQbhdTUv67IkAr75rHut+GKyweoebD6ad+gzOjS1ZSrEjokIYBkwUm
         fj82P2Ppv7NC9/cLDUlf7rEgnCOvs/LUU1COnhpL1FlSeQjN2sOItsNptHrEztMwyG74
         xXhYJESg761GIrtisGj/YPS+mB/qtXMHp96ZnheFDHrHryoKmTOMk252TDpNPbopLOdQ
         Ehxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578221; x=1692183021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jc/kMJ2DPFYVg7IBTR4njcXwjXlJ4l2BnySUNEp3oa4=;
        b=l3xYG9oFqAFx8kZ1dVKy0asOm6luwpiqZoiSXmCD2QyN7RIWYiE7e+sFzzabTrcPTe
         FtTrxFtAwCH2BwDvBe7Jcnjc24UX4hYOX5hLnBLUc2IopyocdJAZyeQo5ivuRScCj7Tt
         3iL7Z0vxm2ua7g0DBT8b663Iu4GzTk21k4Wkz8Qix9BfUWwaKtD/eg9b+EmGvqDyUfr4
         gz4vsvNmYd16aRNP+Zu0O062izPOSfCRkZf8YvVIkjE5Qg9hZuN9wKQwsBIus5W8guA5
         GSm8bI3HECkX/VYuDAxbl6FWBLmcWHrIlplJ91cAFfbxrwFeJ/AblkT/tLSqIF9AvWrb
         So3Q==
X-Gm-Message-State: AOJu0Yw1FydMhvsiTNlPjgG3QFqDzgbgSiV8NR5eD3+V1S1kioCKfaO5
        wMOW9bMmXV74i5TBf0QKArY=
X-Google-Smtp-Source: AGHT+IFRpJ69EzHYimaTsWMcO+t8ZetcphxcGiKKb0MaYUWCV65H7GsD+Mc9YEFF2yTU28aVQWgv+w==
X-Received: by 2002:a5d:6781:0:b0:313:f1c8:a968 with SMTP id v1-20020a5d6781000000b00313f1c8a968mr1370094wru.2.1691578221020;
        Wed, 09 Aug 2023 03:50:21 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id d2-20020a5d4f82000000b0031784ac0babsm16531954wru.28.2023.08.09.03.50.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:20 -0700 (PDT)
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
        Joel Granados <j.granados@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v3 06/14] sysctl: Add size to register_sysctl
Date:   Wed,  9 Aug 2023 12:49:58 +0200
Message-Id: <20230809105006.1198165-7-j.granados@samsung.com>
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

This commit adds table_size to register_sysctl in preparation for the
removal of the sentinel elements in the ctl_table arrays (last empty
markers). And though we do *not* remove any sentinels in this commit, we
set things up by either passing the table_size explicitly or using
ARRAY_SIZE on the ctl_table arrays.

We replace the register_syctl function with a macro that will add the
ARRAY_SIZE to the new register_sysctl_sz function. In this way the
callers that are already using an array of ctl_table structs do not
change. For the callers that pass a ctl_table array pointer, we pass the
table_size to register_sysctl_sz instead of the macro.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/kernel/armv8_deprecated.c |  2 +-
 arch/s390/appldata/appldata_base.c   |  2 +-
 fs/proc/proc_sysctl.c                | 30 +++++++++++++++-------------
 include/linux/sysctl.h               | 10 ++++++++--
 kernel/ucount.c                      |  2 +-
 net/sysctl_net.c                     |  2 +-
 6 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/kernel/armv8_deprecated.c b/arch/arm64/kernel/armv8_deprecated.c
index 1febd412b4d2..e459cfd33711 100644
--- a/arch/arm64/kernel/armv8_deprecated.c
+++ b/arch/arm64/kernel/armv8_deprecated.c
@@ -569,7 +569,7 @@ static void __init register_insn_emulation(struct insn_emulation *insn)
 		sysctl->extra2 = &insn->max;
 		sysctl->proc_handler = emulation_proc_handler;
 
-		register_sysctl("abi", sysctl);
+		register_sysctl_sz("abi", sysctl, 1);
 	}
 }
 
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index bbefe5e86bdf..3b0994625652 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -365,7 +365,7 @@ int appldata_register_ops(struct appldata_ops *ops)
 	ops->ctl_table[0].proc_handler = appldata_generic_handler;
 	ops->ctl_table[0].data = ops;
 
-	ops->sysctl_header = register_sysctl(appldata_proc_name, ops->ctl_table);
+	ops->sysctl_header = register_sysctl_sz(appldata_proc_name, ops->ctl_table, 1);
 	if (!ops->sysctl_header)
 		goto out;
 	return 0;
diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index b8dd78e344ff..80d3e2f61947 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -43,7 +43,7 @@ static struct ctl_table sysctl_mount_point[] = {
  */
 struct ctl_table_header *register_sysctl_mount_point(const char *path)
 {
-	return register_sysctl(path, sysctl_mount_point);
+	return register_sysctl_sz(path, sysctl_mount_point, 0);
 }
 EXPORT_SYMBOL(register_sysctl_mount_point);
 
@@ -1399,7 +1399,7 @@ struct ctl_table_header *__register_sysctl_table(
 }
 
 /**
- * register_sysctl - register a sysctl table
+ * register_sysctl_sz - register a sysctl table
  * @path: The path to the directory the sysctl table is in. If the path
  * 	doesn't exist we will create it for you.
  * @table: the table structure. The calller must ensure the life of the @table
@@ -1409,25 +1409,20 @@ struct ctl_table_header *__register_sysctl_table(
  * 	to call unregister_sysctl_table() and can instead use something like
  * 	register_sysctl_init() which does not care for the result of the syctl
  * 	registration.
+ * @table_size: The number of elements in table.
  *
  * Register a sysctl table. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
+struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+					    size_t table_size)
 {
-	int count = 0;
-	struct ctl_table *entry;
-	struct ctl_table_header t_hdr;
-
-	t_hdr.ctl_table = table;
-	list_for_each_table_entry(entry, (&t_hdr))
-		count++;
 	return __register_sysctl_table(&sysctl_table_root.default_set,
-					path, table, count);
+					path, table, table_size);
 }
-EXPORT_SYMBOL(register_sysctl);
+EXPORT_SYMBOL(register_sysctl_sz);
 
 /**
  * __register_sysctl_init() - register sysctl table to path
@@ -1452,10 +1447,17 @@ EXPORT_SYMBOL(register_sysctl);
 void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 				 const char *table_name)
 {
-	struct ctl_table_header *hdr = register_sysctl(path, table);
+	int count = 0;
+	struct ctl_table *entry;
+	struct ctl_table_header t_hdr, *hdr;
+
+	t_hdr.ctl_table = table;
+	list_for_each_table_entry(entry, (&t_hdr))
+		count++;
+	hdr = register_sysctl_sz(path, table, count);
 
 	if (unlikely(!hdr)) {
-		pr_err("failed when register_sysctl %s to %s\n", table_name, path);
+		pr_err("failed when register_sysctl_sz %s to %s\n", table_name, path);
 		return;
 	}
 	kmemleak_not_leak(hdr);
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 0495c858989f..b1168ae281c9 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -215,6 +215,9 @@ struct ctl_path {
 	const char *procname;
 };
 
+#define register_sysctl(path, table)	\
+	register_sysctl_sz(path, table, ARRAY_SIZE(table))
+
 #ifdef CONFIG_SYSCTL
 
 void proc_sys_poll_notify(struct ctl_table_poll *poll);
@@ -227,7 +230,8 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, struct ctl_table *table, size_t table_size);
-struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
+struct ctl_table_header *register_sysctl_sz(const char *path, struct ctl_table *table,
+					    size_t table_size);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
@@ -262,7 +266,9 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 	return NULL;
 }
 
-static inline struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
+static inline struct ctl_table_header *register_sysctl_sz(const char *path,
+							  struct ctl_table *table,
+							  size_t table_size)
 {
 	return NULL;
 }
diff --git a/kernel/ucount.c b/kernel/ucount.c
index 2b80264bb79f..4aa6166cb856 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -365,7 +365,7 @@ static __init int user_namespace_sysctl_init(void)
 	 * default set so that registrations in the child sets work
 	 * properly.
 	 */
-	user_header = register_sysctl("user", empty);
+	user_header = register_sysctl_sz("user", empty, 0);
 	kmemleak_ignore(user_header);
 	BUG_ON(!user_header);
 	BUG_ON(!setup_userns_sysctls(&init_user_ns));
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index 8ee4b74bc009..d9cbbb51b143 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -101,7 +101,7 @@ __init int net_sysctl_init(void)
 	 * registering "/proc/sys/net" as an empty directory not in a
 	 * network namespace.
 	 */
-	net_header = register_sysctl("net", empty);
+	net_header = register_sysctl_sz("net", empty, 0);
 	if (!net_header)
 		goto out;
 	ret = register_pernet_subsys(&sysctl_pernet_ops);
-- 
2.30.2

