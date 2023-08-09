Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF947757FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 12:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232421AbjHIKug (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 06:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbjHIKua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:50:30 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C258B2115;
        Wed,  9 Aug 2023 03:50:26 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fe426b8583so58425975e9.2;
        Wed, 09 Aug 2023 03:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578225; x=1692183025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0Ehqjwr7n7aalL24v3eoFH6zkXkMLmEA1uyOzpkdUI=;
        b=H2CgJ05O88mtUkv8Ftw6TkmecV0v7sKcIi3Tsn9GBrQX05jqDPhbD2B/ScxcMO29RM
         Lj6x0UzluUoOPs98f6Tlr+Tk8cGJaXK6l+9ZOTDUmVPUSgcWt30XAdDS43WgFLBBaExy
         98susFYk9dmGQlPIVAf3Nbucn1IQCKFadE8y8S5N2AQhSJCuQMHeZhgnicADH0kuanTH
         4QycPhkp2niM9RbeZNtJ03nQE1qAuEoo0lyE0g8KEHFXcIx+jfcEIKnvHU/7dm6jE4RQ
         na8Dh+Z2zcd3s79bUfBxcF4kRpNxRKt7x1KPsfrKIp8ELBr/vYWA2+4F7+Hg2zmMT0S6
         ILQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578225; x=1692183025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0Ehqjwr7n7aalL24v3eoFH6zkXkMLmEA1uyOzpkdUI=;
        b=N+bzRV496nN2a8mcCZTQ6zgl55e+OlsP7Af4hfgzm7J9LHJv2yys4Ydy7HZ6Ujob+J
         /ny8X7Z0qanjy+ibYY8ceYRkqwH+ZhE8U6QcMYyfu4eQm60RKdvxJt5vrYgqxT5sEFfW
         QrLM6SzJXay0uWv1p3wjPRsyQIQu4QTa0/EXQpHYDZorX50o7580SdcxOgwiKZRku4rw
         apW8KZJVznLz0H/PdgcJSFuoXh6Nzxr6KWLU1rmfj4sf9zjp/WF3/WzlmXZu3e/qwc0u
         BhXevaqQz7EwC0szDRPsrG5UY0PetGfJ4aa0A5oPxHEzMSRa6/g2l7WTeVTyuMWkyx+1
         bgoQ==
X-Gm-Message-State: AOJu0YxZUZsjwiWNDlhj8ceOsiDnlOaBDJTl1J8rOtBVJ3gQH0LNRAui
        sZyNk9wAASGGf7BqHrBLil4=
X-Google-Smtp-Source: AGHT+IHEeEglo5LhHGUpUuq/IXS9fGqSeTWQOlite0naxpQ3XTrjhX/iV+hbWKqEZ5QUPsVeyJCTcA==
X-Received: by 2002:a7b:ca4c:0:b0:3fb:415a:d07 with SMTP id m12-20020a7bca4c000000b003fb415a0d07mr1774295wml.36.1691578225183;
        Wed, 09 Aug 2023 03:50:25 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id n12-20020a7bcbcc000000b003fe557829ccsm1602527wmi.28.2023.08.09.03.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:24 -0700 (PDT)
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
Subject: [PATCH v3 08/14] sysctl: Add size to register_net_sysctl function
Date:   Wed,  9 Aug 2023 12:50:00 +0200
Message-Id: <20230809105006.1198165-9-j.granados@samsung.com>
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

This commit adds size to the register_net_sysctl indirection function to
facilitate the removal of the sentinel elements (last empty markers)
from the ctl_table arrays. Though we don't actually remove any sentinels
in this commit, register_net_sysctl* now has the capability of
forwarding table_size for when that happens.

We create a new function register_net_sysctl_sz with an extra size
argument. A macro replaces the existing register_net_sysctl. The size in
the macro is SIZE_MAX instead of ARRAY_SIZE to avoid compilation errors
while we systematically migrate to register_net_sysctl_sz. Will change
to ARRAY_SIZE in subsequent commits.

Care is taken to add table_size to the stopping criteria in such a way
that when we remove the empty sentinel element, it will continue
stopping in the last element of the ctl_table array.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/net/net_namespace.h | 10 ++++++----
 net/sysctl_net.c            | 22 +++++++++++++---------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 78beaa765c73..e4e5fe75a281 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -469,15 +469,17 @@ void unregister_pernet_device(struct pernet_operations *);
 
 struct ctl_table;
 
+#define register_net_sysctl(net, path, table)	\
+	register_net_sysctl_sz(net, path, table, SIZE_MAX)
 #ifdef CONFIG_SYSCTL
 int net_sysctl_init(void);
-struct ctl_table_header *register_net_sysctl(struct net *net, const char *path,
-					     struct ctl_table *table);
+struct ctl_table_header *register_net_sysctl_sz(struct net *net, const char *path,
+					     struct ctl_table *table, size_t table_size);
 void unregister_net_sysctl_table(struct ctl_table_header *header);
 #else
 static inline int net_sysctl_init(void) { return 0; }
-static inline struct ctl_table_header *register_net_sysctl(struct net *net,
-	const char *path, struct ctl_table *table)
+static inline struct ctl_table_header *register_net_sysctl_sz(struct net *net,
+	const char *path, struct ctl_table *table, size_t table_size)
 {
 	return NULL;
 }
diff --git a/net/sysctl_net.c b/net/sysctl_net.c
index d9cbbb51b143..051ed5f6fc93 100644
--- a/net/sysctl_net.c
+++ b/net/sysctl_net.c
@@ -122,12 +122,13 @@ __init int net_sysctl_init(void)
  *    allocated.
  */
 static void ensure_safe_net_sysctl(struct net *net, const char *path,
-				   struct ctl_table *table)
+				   struct ctl_table *table, size_t table_size)
 {
 	struct ctl_table *ent;
 
 	pr_debug("Registering net sysctl (net %p): %s\n", net, path);
-	for (ent = table; ent->procname; ent++) {
+	ent = table;
+	for (size_t i = 0; i < table_size && ent->procname; ent++, i++) {
 		unsigned long addr;
 		const char *where;
 
@@ -160,21 +161,24 @@ static void ensure_safe_net_sysctl(struct net *net, const char *path,
 	}
 }
 
-struct ctl_table_header *register_net_sysctl(struct net *net,
-	const char *path, struct ctl_table *table)
+struct ctl_table_header *register_net_sysctl_sz(struct net *net,
+						const char *path,
+						struct ctl_table *table,
+						size_t table_size)
 {
-	int count = 0;
+	int count;
 	struct ctl_table *entry;
 
 	if (!net_eq(net, &init_net))
-		ensure_safe_net_sysctl(net, path, table);
+		ensure_safe_net_sysctl(net, path, table, table_size);
 
-	for (entry = table; entry->procname; entry++)
-		count++;
+	entry = table;
+	for (count = 0 ; count < table_size && entry->procname; entry++, count++)
+		;
 
 	return __register_sysctl_table(&net->sysctls, path, table, count);
 }
-EXPORT_SYMBOL_GPL(register_net_sysctl);
+EXPORT_SYMBOL_GPL(register_net_sysctl_sz);
 
 void unregister_net_sysctl_table(struct ctl_table_header *header)
 {
-- 
2.30.2

