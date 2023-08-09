Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95ADA7757F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Aug 2023 12:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232354AbjHIKua (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Aug 2023 06:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbjHIKuP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Aug 2023 06:50:15 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4E4B1BFE;
        Wed,  9 Aug 2023 03:50:14 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe5eb84dceso23303845e9.1;
        Wed, 09 Aug 2023 03:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691578213; x=1692183013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rF1J0XzJl2jEuCsHx7nkNs1OdRX43SORnh/9oIIv32k=;
        b=kBzWMSXu3PkjQikKnYHW4SplaSkbLTtRx+DN3V+kDSETGfMSAK/sSp6mSJ+8nqx3lI
         2qwj1SV/t13/4GvrKi8RJqLKnU26roaWkF8nqLehWjxDX9STMR4Zh4ESxSV6APNRMk/+
         quYAmnTAFA8y+/bXjvkUBcL+dhPTRXOvh1SwZmXZjI/dGG1EtkYG8fKiUw6qSsLcLQ5+
         oRZAKCQozDGbW5swn3ez1hu/auV2uwXt8dgk6+kTN+Yl3sG2BELBTq+GfwArQCaLc7M0
         N/BbKFfJs7jb7VHcsgWQGQ2bbcZWDQvbdYebZLe3N/r/nMOUCYKubQzNxmMqo6wMYA29
         bBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691578213; x=1692183013;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rF1J0XzJl2jEuCsHx7nkNs1OdRX43SORnh/9oIIv32k=;
        b=D7x3Tn5AylyJBah/BhOxFr2ln6ynnla/hjJFgblPqaEi8eOKtYCRZj77V8wFfwQ4Id
         N5PTYGzns8xsu+uZ0PtRINsg5ZhwF5dIRKZdjQCdrnfwcJ8i5PYk09aqU19ENXFYes29
         Lm9OBAD9gvmVflgFZpIJ3k+p957Qq1BgOz1NOzxzKXvj9PPinIOjXyXOfUN9xk30Qowi
         KOcXmNuiqRqhB00OU/0IDBC7ixb1aeFu5uaZaSAhfx2ekKlsbN4hOkVv/akCSVkv9Sm+
         7Bw7FBFDvN6qhOeav+kREBqQn3QG85DMVRIVGvmluKIGZFFSt96pjE7LqUqhux5fxgqb
         CfuA==
X-Gm-Message-State: AOJu0Ywz/7HDGNItZ9laCycIQqiMUAmS2JVTH9nULpdvCDJ5p1ml9cP2
        OyaXGPoxxiW+KZfvDE/+74M=
X-Google-Smtp-Source: AGHT+IHzkdrGMhVAoZDxUZFB0Z2R2PNXWStlC6lOO2IAWFPrNF4jmDXuRcZN/7k3MZRz3tuxtO09GQ==
X-Received: by 2002:a05:600c:204f:b0:3f6:9634:c8d6 with SMTP id p15-20020a05600c204f00b003f69634c8d6mr1961846wmg.18.1691578212840;
        Wed, 09 Aug 2023 03:50:12 -0700 (PDT)
Received: from localhost ([165.225.194.193])
        by smtp.gmail.com with ESMTPSA id a7-20020adfed07000000b00317f01fa3c4sm7592578wro.112.2023.08.09.03.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:50:12 -0700 (PDT)
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
Subject: [PATCH v3 02/14] sysctl: Use ctl_table_header in list_for_each_table_entry
Date:   Wed,  9 Aug 2023 12:49:54 +0200
Message-Id: <20230809105006.1198165-3-j.granados@samsung.com>
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

We replace the ctl_table with the ctl_table_header pointer in
list_for_each_table_entry which is the macro responsible for traversing
the ctl_table arrays. This is a preparation commit that will make it
easier to add the ctl_table array size (that will be added to
ctl_table_header in subsequent commits) to the already existing loop
logic based on empty ctl_table elements (so called sentinels).

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 94d71446da39..884460b0385b 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -19,8 +19,8 @@
 #include <linux/kmemleak.h>
 #include "internal.h"
 
-#define list_for_each_table_entry(entry, table) \
-	for ((entry) = (table); (entry)->procname; (entry)++)
+#define list_for_each_table_entry(entry, header) \
+	for ((entry) = (header->ctl_table); (entry)->procname; (entry)++)
 
 static const struct dentry_operations proc_sys_dentry_operations;
 static const struct file_operations proc_sys_file_operations;
@@ -204,7 +204,7 @@ static void init_header(struct ctl_table_header *head,
 	if (node) {
 		struct ctl_table *entry;
 
-		list_for_each_table_entry(entry, table) {
+		list_for_each_table_entry(entry, head) {
 			node->header = head;
 			node++;
 		}
@@ -215,7 +215,7 @@ static void erase_header(struct ctl_table_header *head)
 {
 	struct ctl_table *entry;
 
-	list_for_each_table_entry(entry, head->ctl_table)
+	list_for_each_table_entry(entry, head)
 		erase_entry(head, entry);
 }
 
@@ -242,7 +242,7 @@ static int insert_header(struct ctl_dir *dir, struct ctl_table_header *header)
 	err = insert_links(header);
 	if (err)
 		goto fail_links;
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		err = insert_entry(header, entry);
 		if (err)
 			goto fail;
@@ -1129,7 +1129,7 @@ static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
 	struct ctl_table *entry;
 	int err = 0;
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
@@ -1169,7 +1169,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 
 	name_bytes = 0;
 	nr_entries = 0;
-	list_for_each_table_entry(entry, head->ctl_table) {
+	list_for_each_table_entry(entry, head) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
@@ -1188,7 +1188,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 	link_name = (char *)&link_table[nr_entries + 1];
 	link = link_table;
 
-	list_for_each_table_entry(entry, head->ctl_table) {
+	list_for_each_table_entry(entry, head) {
 		int len = strlen(entry->procname) + 1;
 		memcpy(link_name, entry->procname, len);
 		link->procname = link_name;
@@ -1211,7 +1211,7 @@ static bool get_links(struct ctl_dir *dir,
 	struct ctl_table *entry, *link;
 
 	/* Are there links available for every entry in table? */
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;
 		link = find_entry(&tmp_head, dir, procname, strlen(procname));
 		if (!link)
@@ -1224,7 +1224,7 @@ static bool get_links(struct ctl_dir *dir,
 	}
 
 	/* The checks passed.  Increase the registration count on the links */
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		const char *procname = entry->procname;
 		link = find_entry(&tmp_head, dir, procname, strlen(procname));
 		tmp_head->nreg++;
@@ -1356,12 +1356,14 @@ struct ctl_table_header *__register_sysctl_table(
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
+	struct ctl_table_header h_tmp;
 	struct ctl_dir *dir;
 	struct ctl_table *entry;
 	struct ctl_node *node;
 	int nr_entries = 0;
 
-	list_for_each_table_entry(entry, table)
+	h_tmp.ctl_table = table;
+	list_for_each_table_entry(entry, (&h_tmp))
 		nr_entries++;
 
 	header = kzalloc(sizeof(struct ctl_table_header) +
@@ -1471,7 +1473,7 @@ static void put_links(struct ctl_table_header *header)
 	if (IS_ERR(core_parent))
 		return;
 
-	list_for_each_table_entry(entry, header->ctl_table) {
+	list_for_each_table_entry(entry, header) {
 		struct ctl_table_header *link_head;
 		struct ctl_table *link;
 		const char *name = entry->procname;
-- 
2.30.2

