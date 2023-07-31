Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18F3B768DFD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jul 2023 09:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbjGaHTe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jul 2023 03:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbjGaHTD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:19:03 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5746326B0;
        Mon, 31 Jul 2023 00:17:33 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so2733091fa.1;
        Mon, 31 Jul 2023 00:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690787851; x=1691392651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9/+5UTOZSoINBQX5Idlq9s7Q/YjlqMmFruSJ92+I5og=;
        b=aa90vhrzpcWfje6OipbZcbSYmqsQOrKCRcOH+mXZEBSAe4e9SYO9KbJpgMCHttr/yA
         zdFVQR1LOnV+D7hAiD+KrUS2ISlvjUkq+b7yUFbiR01dxQnjTtlB3gUvsDsEdzqxQBra
         VtmXCBuFRC2NHa/MDl3j3RRH7oueh+fFARArWcE6cGtzhOQHhoEyDoaWBNB9BNxyNorT
         Vsk7HiljVefekG81Lh7gDtS9SFSWp6bx3r/GStCaxRX7m39RSXK/U9SkwJ+la8Y3+Sa+
         bicaAOoBwyN9hsG7EPZFDiSfvHQfnOEmdljFsJjOX5Tmk2pevqcpTLWxI8xhB+d6ZiQD
         aq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690787851; x=1691392651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9/+5UTOZSoINBQX5Idlq9s7Q/YjlqMmFruSJ92+I5og=;
        b=A6w65cR5UG68kMWLhHCeay3MCsBgGJxPPFKt/yZEetbuQq7i2VyPMvezcKZ27NG1ad
         gIW8o66dYoQ72Va75liBzXFMjG8PyEHxRWi51Fo2KSKeFs63g6WQBs0o0aUIbZ+i+dcn
         1VcxDBZWVkONYS7gqa+D2rH4jdGzskSJbwk+MuOkP5OktXS2miEORTjbwKrYUr8iNaST
         n7+fFr50BbdpnWPlwJN4NlYTmrnhTXC4NjnrwWoGMMcm60DGzDtVYG9yl1Iu+YWo3xSq
         6wJJIJ0p1c4WR2Myxt3cfVn+oYvwD1AYL+j0NWicDpPG7yXcj8Z7Uf/Tlfeie+TM2JIP
         sO0Q==
X-Gm-Message-State: ABy/qLYy2nTCCKRUKtmA+/ZKm8SPgUFSqAQUD0CeuFsxEmu+eABUdFAt
        k2vV+EVZ4djHU/1lBqLqbTE=
X-Google-Smtp-Source: APBJJlE6KY81A+y/Zffxll1xcr19Ku9HmdfKGgsWDibukZ1vJlgJ0JdG40X5D63FdYACFRgqNamN3g==
X-Received: by 2002:a2e:8784:0:b0:2b9:ea5f:36b with SMTP id n4-20020a2e8784000000b002b9ea5f036bmr1193678lji.52.1690787851280;
        Mon, 31 Jul 2023 00:17:31 -0700 (PDT)
Received: from localhost ([165.225.194.214])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b00317495f88fasm12011116wrp.112.2023.07.31.00.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:17:30 -0700 (PDT)
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
Subject: [PATCH v2 01/14] sysctl: Prefer ctl_table_header in proc_sysctl
Date:   Mon, 31 Jul 2023 09:17:15 +0200
Message-Id: <20230731071728.3493794-2-j.granados@samsung.com>
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

This is a preparation commit that replaces ctl_table with
ctl_table_header as the pointer that is passed around in proc_sysctl.c.
This will become necessary in subsequent commits when the size of the
ctl_table array can no longer be calculated by searching for an empty
sentinel (last empty ctl_table element) but will be carried along inside
the ctl_table_header struct.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 5ea42653126e..94d71446da39 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1125,11 +1125,11 @@ static int sysctl_check_table_array(const char *path, struct ctl_table *table)
 	return err;
 }
 
-static int sysctl_check_table(const char *path, struct ctl_table *table)
+static int sysctl_check_table(const char *path, struct ctl_table_header *header)
 {
 	struct ctl_table *entry;
 	int err = 0;
-	list_for_each_table_entry(entry, table) {
+	list_for_each_table_entry(entry, header->ctl_table) {
 		if ((entry->proc_handler == proc_dostring) ||
 		    (entry->proc_handler == proc_dobool) ||
 		    (entry->proc_handler == proc_dointvec) ||
@@ -1159,8 +1159,7 @@ static int sysctl_check_table(const char *path, struct ctl_table *table)
 	return err;
 }
 
-static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table *table,
-	struct ctl_table_root *link_root)
+static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_header *head)
 {
 	struct ctl_table *link_table, *entry, *link;
 	struct ctl_table_header *links;
@@ -1170,7 +1169,7 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 
 	name_bytes = 0;
 	nr_entries = 0;
-	list_for_each_table_entry(entry, table) {
+	list_for_each_table_entry(entry, head->ctl_table) {
 		nr_entries++;
 		name_bytes += strlen(entry->procname) + 1;
 	}
@@ -1189,12 +1188,12 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 	link_name = (char *)&link_table[nr_entries + 1];
 	link = link_table;
 
-	list_for_each_table_entry(entry, table) {
+	list_for_each_table_entry(entry, head->ctl_table) {
 		int len = strlen(entry->procname) + 1;
 		memcpy(link_name, entry->procname, len);
 		link->procname = link_name;
 		link->mode = S_IFLNK|S_IRWXUGO;
-		link->data = link_root;
+		link->data = head->root;
 		link_name += len;
 		link++;
 	}
@@ -1205,15 +1204,16 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table
 }
 
 static bool get_links(struct ctl_dir *dir,
-	struct ctl_table *table, struct ctl_table_root *link_root)
+		      struct ctl_table_header *header,
+		      struct ctl_table_root *link_root)
 {
-	struct ctl_table_header *head;
+	struct ctl_table_header *tmp_head;
 	struct ctl_table *entry, *link;
 
 	/* Are there links available for every entry in table? */
-	list_for_each_table_entry(entry, table) {
+	list_for_each_table_entry(entry, header->ctl_table) {
 		const char *procname = entry->procname;
-		link = find_entry(&head, dir, procname, strlen(procname));
+		link = find_entry(&tmp_head, dir, procname, strlen(procname));
 		if (!link)
 			return false;
 		if (S_ISDIR(link->mode) && S_ISDIR(entry->mode))
@@ -1224,10 +1224,10 @@ static bool get_links(struct ctl_dir *dir,
 	}
 
 	/* The checks passed.  Increase the registration count on the links */
-	list_for_each_table_entry(entry, table) {
+	list_for_each_table_entry(entry, header->ctl_table) {
 		const char *procname = entry->procname;
-		link = find_entry(&head, dir, procname, strlen(procname));
-		head->nreg++;
+		link = find_entry(&tmp_head, dir, procname, strlen(procname));
+		tmp_head->nreg++;
 	}
 	return true;
 }
@@ -1246,13 +1246,13 @@ static int insert_links(struct ctl_table_header *head)
 	if (IS_ERR(core_parent))
 		return 0;
 
-	if (get_links(core_parent, head->ctl_table, head->root))
+	if (get_links(core_parent, head, head->root))
 		return 0;
 
 	core_parent->header.nreg++;
 	spin_unlock(&sysctl_lock);
 
-	links = new_links(core_parent, head->ctl_table, head->root);
+	links = new_links(core_parent, head);
 
 	spin_lock(&sysctl_lock);
 	err = -ENOMEM;
@@ -1260,7 +1260,7 @@ static int insert_links(struct ctl_table_header *head)
 		goto out;
 
 	err = 0;
-	if (get_links(core_parent, head->ctl_table, head->root)) {
+	if (get_links(core_parent, head, head->root)) {
 		kfree(links);
 		goto out;
 	}
@@ -1371,7 +1371,7 @@ struct ctl_table_header *__register_sysctl_table(
 
 	node = (struct ctl_node *)(header + 1);
 	init_header(header, root, set, node, table);
-	if (sysctl_check_table(path, table))
+	if (sysctl_check_table(path, header))
 		goto fail;
 
 	spin_lock(&sysctl_lock);
-- 
2.30.2

