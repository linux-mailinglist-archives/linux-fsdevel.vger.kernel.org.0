Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C90276385C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbjGZOHK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:07:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234194AbjGZOHC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:02 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE3B271B
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:06:54 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140652euoutp02207eb5fa95c1595f7b9cc46927d5c634~1cAeE7dZr1252612526euoutp02e
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:06:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140652euoutp02207eb5fa95c1595f7b9cc46927d5c634~1cAeE7dZr1252612526euoutp02e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380412;
        bh=flcxV7zco8XJiJ2V96AVTp6oAIKfZxtHk3BJJ+2+M8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mcLqRmS6ZLlH2oQRKCUVtg+WARwN/pLwwFg7Pen7U4jJMWmEabZTu7+dO78AQGgbZ
         w4P5PpkhAjstc/u4x3uKv5NBHThJAW0HysSZuABeOWlzZOhCwiYmRjfthKkcVQl6Da
         9k1m24sqEn5cT+iEh1IGfR1X3x3KvfmKLmDF4RUE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230726140652eucas1p25eee8581f80f6eda839e6cef29d7bacb~1cAd0V_7C0710907109eucas1p2i;
        Wed, 26 Jul 2023 14:06:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 9A.56.37758.C7821C46; Wed, 26
        Jul 2023 15:06:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230726140652eucas1p2a2ac2dd74986bd9ace8380d6f51024ff~1cAdizv1z0711407114eucas1p2S;
        Wed, 26 Jul 2023 14:06:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140652eusmtrp136a75f69eb7237d97cd29d9ac83bcb36~1cAdiGwzm2391823918eusmtrp11;
        Wed, 26 Jul 2023 14:06:52 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-ee-64c1287c59be
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D0.C7.10549.C7821C46; Wed, 26
        Jul 2023 15:06:52 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140651eusmtip159fbf6fc3a9deef8313d0d29dfb7a087~1cAdXKVMW1545915459eusmtip1J;
        Wed, 26 Jul 2023 14:06:51 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 02/14] sysctl: Use ctl_table_header in
 list_for_each_table_entry
Date:   Wed, 26 Jul 2023 16:06:22 +0200
Message-Id: <20230726140635.2059334-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Sf1CLcRy+79637W3uzdsqffqBjA7RqsOZS52ceJ3j0jl3OY6dvVJti60h
        15HToZBUTMsfIzEl1Sopv3eV1pxFaLGcyK/yo2iYH8V65/jv+Tyf5/l+nufuS2ACrZs/kaRI
        Y5QKiUzI5eOXWhyW0Ixpt6ThlmY/cemNHiQe0aWK7xyUi69eM+HijsaTXLE17yUS//j2B51t
        WLGAoIsz7+G0zqCma/Qh9OP+KNpQls2lc2vLEP3ZMCGOt4Y/X8rIkrYxyrDoDfzNmveCLccn
        73B8P49lIu34HOROADUb7lo/4TmITwgoPYLuNzYuOwwh+Kgv47DDZwSVh7u4fy015i4euziH
        oPDHM5f/LYKHe7NHVVxqJlje2bAcRBDe1DooKZQ6aYzSIDhzMtCJvah4KO7+gJwYp4Lhyekj
        o5ikosCSlYWzxybCvk7NKO9ORcP5iq9urMYTTEW9OPvmRNhbV4w5MwDVSkBuyQUea14E9qEW
        V2ov6Ltd6+IDwVxwCGcNBQhuDA/w2KEcwdk9dg6rioSsB708ZwOMmg6VjWEsHQOt/XY3Jw2U
        B1jfe7IhPCD/kgZjaRIO7BOw6imQW1ro6uIPnR0Nrjg02BqruHlokva/Otr/6mj/3dUhrAz5
        MmqVPJFRzVIw20UqiVylViSKNqbKDejP9zEP37ZfRvq+QZERcQhkREBgQm8yYu11qYCUStJ3
        MsrU9Uq1jFEZUQCBC33JGVGmjQIqUZLGpDDMFkb5d8sh3P0zOZGPBs8cHMDJzPwTRVuDFt98
        W/di3UKHBx3tHZdfcSRmQUvI5A7b1W157XRKxpLYT3Oq5jH1AUez55+zDhv5GjTEu942LYFY
        2pBwD/NpCDpVWrJstU/zkuhdw8FTVo0d7Mni4DPICe2O1/HMsk4dzM2VDviV2gWaerlsf1NG
        nHaTj+GV0DrwKyYsO6C6qcpvZx9/HPYu8KnoSuJrj/RksyKy0rwppWf91PgxZHdXeHjec3Fa
        /09RsuO4qOly79LC/Y1PibW9tvqRY8gyMt24PDTiWnKBIfK+b9tX1czW5SvrTeW3vuzWy+xy
        9YPns1+OP1qDqptjk3R+Bkl7+kWSGyjEVZslESGYUiX5DQoeJYGtAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnkeLIzCtJLcpLzFFi42I5/e/4Xd0ajYMpBo/XsFos3f+Q0eL/gnyL
        M925Fnv2nmSxuLxrDpvFjQlPGS1+/wCylu30c+DwmN1wkcVjwaZSj80rtDxuvbb12LSqk82j
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0Mqa/FSqYplzx89dK5gbGWbJdjJwcEgImEptP32TvYuTiEBJYyihx+EUvYxcjB1BC
        SuL7Mk6IGmGJP9e62CBqnjNK7Lw4nw0kwSagI3H+zR1mEFtEIF5i5uP7TCBFzAKzGSVWnzzE
        DDJIWCBAYkN/IUgNi4CqxO1F/YwgNq+ArcT5lhYWiAXyEm3Xp4PFOQXsJFau/c4KYgsB1fRM
        fcoOUS8ocXLmE7B6ZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5xaV66XnJ+
        7iZGYIxsO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMJrGLMvRYg3JbGyKrUoP76oNCe1+BCjKdDd
        E5mlRJPzgVGaVxJvaGZgamhiZmlgamlmrCTO61nQkSgkkJ5YkpqdmlqQWgTTx8TBKdXAtHy6
        SJxA0pepvaLywXvsp69oN0+a/+zF3vDKTfvTT9oeVI+c0KbYLLX/RKLXdb+v+vv/qq7LXHD7
        Ae/l4OC7MeKOFmzf5lf2hvXcm3Zweq1T6W2X+40/3ncFvwk6e9BV9GfER+0NJvqpzZNvZ/xv
        /J3qa+ESMuW23Av/uGrBt7XcNWF+cUfYpOf337nP8m6ZfEWa3YIni1cb53tIXuC8cm9Nvt7j
        fFvWE2YJvhHLJH65aq0wUi+9K1z7svDorS9p4qX7o/8xcVgz9ulmXJxhJNv1drXiN5+atxbf
        9erUtsUWuK06zOdQ+kg9789mVddSyW4W+e66JMnW7ptMt7fsNvZW1klb0HVNuOzn4wVKLMUZ
        iYZazEXFiQD46aWHGgMAAA==
X-CMS-MailID: 20230726140652eucas1p2a2ac2dd74986bd9ace8380d6f51024ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140652eucas1p2a2ac2dd74986bd9ace8380d6f51024ff
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140652eucas1p2a2ac2dd74986bd9ace8380d6f51024ff
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140652eucas1p2a2ac2dd74986bd9ace8380d6f51024ff@eucas1p2.samsung.com>
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

Now that the ctl_header is the preferred way of passing ctl_table
elements around, we use it (the header) in the list_for_each_table_entry
macro.

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

