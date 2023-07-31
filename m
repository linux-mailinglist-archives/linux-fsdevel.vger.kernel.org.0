Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C76768E1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:20:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbjGaHU2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjGaHT1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:27 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A50C919A5;
        Mon, 31 Jul 2023 00:17:47 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso60442301fa.3;
        Mon, 31 Jul 2023 00:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787866; x=1691392666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0Ehqjwr7n7aalL24v3eoFH6zkXkMLmEA1uyOzpkdUI=;
        b=MMJ3zmlm+ZJSjUcgcBWQWrwaggsjh94Z2AR980Bf99gKqQJUyC2ds+8t0ZeFBA6SE5
         24bUAx+92gKv6CUrTwCkMK8kfM+dwMVGnHaj/AIXPoADG9x3rQAur+o+St1Eok7ymlce
         AF4RpYKX37AcRilTHnU72J6udZJqoz3jQg/7wCljI1W/KcTklcvbrGsKWCJv+nVB8G5x
         hEp+AlCxMyzzLla50oNzqDrTH/0qUVyZK/xeXS7jSsjAu2wovGv41EdSJWQh2uoqZ6Vt
         jmE7aEISXo5G9dsumdaGNwwcCF3PIOj/Z3gamIsUiNsCIUgk2qMpgg40uc6qs9aYb63F
         3W6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787866; x=1691392666;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y0Ehqjwr7n7aalL24v3eoFH6zkXkMLmEA1uyOzpkdUI=;
        b=gOUUcx64+gig0JANCEtmN+Fs2mi3c4LR0gRv7vzVgulV67NygQZISCKrw6kvwkChua
         blsvNM5cmDX6wiD26ZOouI7KgA7jHTHP0GD6oc9qlxS2Ac9NM6aSZgrGz3nIyNI5ozij
         opN4qjSP7Wjwj7iZFsr9K55EzdaxcB9v0dBlZuBnmNBw/Gb0SHhFhu1zt7ZuV1ohiA57
         OG8BOwDadwwLvvenyAaV4bMBDw7w5FVNUogHhIchkrYN1Mqt5KSIXPsUbUy610NEQjxR
         l0hbtdXyHvG+e+qgnBPMOyhgDYAzdtM0Pi/WLuneJ5WePTEcqHT6DdHjN7bQwHe0SRNU
         x0ZA==
X-Gm-Message-State: ABy/qLYIhLadKasLW2NPecIy5ZbHi7a8izrcWmhGm0Ir2El6H3s9wDhd
        I4POEWO8nKyjJKeErQZfWus=
X-Google-Smtp-Source: APBJJlFF1k1XPdJyinXXL06Hcxxg+HVkyLmTOsHve4wKOdZvgvUFkTAe++yLIQ35HRVigMBvfSHChA==
X-Received: by 2002:a2e:3e17:0:b0:2b6:e2cd:20f5 with SMTP id l23-20020a2e3e17000000b002b6e2cd20f5mr6347509lja.9.1690787865727;
        Mon, 31 Jul 2023 00:17:45 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c22c300b003fe13c3ece7sm6432930wmg.10.2023.07.31.00.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:45 -0700 (PDT)
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
        Joel Granados <j.granados@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 08/14] sysctl: Add size to register_net_sysctl function
Date:   Mon, 31 Jul 2023 09:17:22 +0200
Message-Id: <20230731071728.3493794-9-j.granados@samsung.com>
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

