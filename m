Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C23737EB9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230449AbjFUJKQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbjFUJKK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:10:10 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB93E69
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:10:08 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091007euoutp02ea37d24455004ae4db9223fa4a704921~qoYYfYznF1099310993euoutp02R
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 09:10:07 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621091007euoutp02ea37d24455004ae4db9223fa4a704921~qoYYfYznF1099310993euoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338607;
        bh=Oc8NXUYQnci0z8MHHacFs01L4f2k2FJZpxQf2DbJLIg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=oF60GRFyLGioSYdHBD75k6ZdUU7iMlKwRgEYt94crclGVD57S7dTyydhs3IjDQfXX
         KclHb7wnR27A+mH9vtdnQYKGZTpC4/TfDAe/4rNpqZn2VhkytAbs3xrBji9wzy9K7k
         IPqv3BtRigv2BsTbQSYZxOZjI2Vpkp1REGcLaTbY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621091007eucas1p1501f747bc667f973f0ba906980aa1a8d~qoYYYuuHd3044930449eucas1p1B;
        Wed, 21 Jun 2023 09:10:07 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.7E.11320.F6EB2946; Wed, 21
        Jun 2023 10:10:07 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091007eucas1p2271595a5889075994e8dceb0c06ae7cc~qoYYCN1e70334003340eucas1p2B;
        Wed, 21 Jun 2023 09:10:07 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091007eusmtrp280b3641910623ae8b14f3a748d75609f~qoYX1LJzl2207922079eusmtrp2H;
        Wed, 21 Jun 2023 09:10:07 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-80-6492be6f72e2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 35.0F.10549.E6EB2946; Wed, 21
        Jun 2023 10:10:07 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091006eusmtip2bbde996bf92d6f74889637872fbdd379~qoYXpJ5FV1360013600eusmtip2f;
        Wed, 21 Jun 2023 09:10:06 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:06 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 02/11] sysctl: Use the ctl header in list ctl_table macro
Date:   Wed, 21 Jun 2023 11:09:51 +0200
Message-ID: <20230621091000.424843-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOd38fZNSDB5OUbU4051rsWfvSRaL
        y7vmsFncmPCU0WLZTj8HVo/ZDRdZPBZsKvXYtKqTzePzJrkAligum5TUnMyy1CJ9uwSujOO3
        1rIVLFCumPH3HmsD4zzZLkZODgkBE4lFty6zdDFycQgJrGCUmHp1BzOE84VRYtK6+ewQzmdG
        ifePHzPDtJzfOAuqZTmjxNKZk1ngqvYcPcsI4WxllDh5bzcTSAubgI7E+Td3wNpFBOIlZq/Z
        zghiMwvkSsxavgQsLizgKbHq7EEwm0VAVeLepH9gNq+AjUTf1NfsEKvlJdquTwfr5RSwlTj/
        +D0LRI2gxMmZT1ggZspLNG+dzQxhS0gcfPEC6mxliev7FrNB2LUSp7bcYoKwL3BIPG+ygLBd
        JI4d3s0KYQtLvDq+BWqvjMT/nfOZQB6TEJjMKLH/3wd2CGc1o8Syxq9Qk6wlWq48gepwlPh1
        qBtoGweQzSdx460gxEF8EpO2TWeGCPNKdLQJTWBUmYXkhVlIXpiF5IUFjMyrGMVTS4tz01OL
        jfJSy/WKE3OLS/PS9ZLzczcxAtPJ6X/Hv+xgXP7qo94hRiYOxkOMEhzMSiK8spsmpQjxpiRW
        VqUW5ccXleakFh9ilOZgURLn1bY9mSwkkJ5YkpqdmlqQWgSTZeLglGpgWjZ9v/BkHv4Jux6s
        aonts7k6z+7DesaQ+KkaZzK7Zt32NlSQ8PX4yCE+bYmUuc3S2CnPXe4GPGd99uzl+4p9x1qE
        EksfujpXGzrxXGxY25xxnlnn+rEHStFzps32T1ycd/GVk9T26zK2E4/0nrRd0Kgmt7vDr7S+
        pfrt8+/Xv8mZ9t7L272VedOEq8d+tE2tV93Ytzurb+HMjrt5m/YVW+2c+thswaqkohfrpTls
        2uztHI0yZ504wsHzo+Lpa8mW4k+7gzetOWdX68j15++5zXM5XxaHrHaZMttSuUzvxse5Cevf
        ab1e+d405vpf+ZkMHy9MmWnT+TvRc61KSpZU2rJbzLcW9+9VZzlWNZ9RXFKJpTgj0VCLuag4
        EQDBTLualgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7r5+yalGDw7wGRxpjvXYs/ekywW
        l3fNYbO4MeEpo8WynX4OrB6zGy6yeCzYVOqxaVUnm8fnTXIBLFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GcdvrWUrWKBcMePvPdYGxnmyXYyc
        HBICJhLnN85i6WLk4hASWMoo8WxGMztEQkZi45errBC2sMSfa11sEEUfGSU2f7nLApIQEtjK
        KLH0vRuIzSagI3H+zR1mEFtEIF5i9prtjCA2s0CuxKzlS8DiwgKeEqvOHgSzWQRUJe5N+gdm
        8wrYSPRNfQ21WF6i7fp0sF5OAVuJ84/fQ+2ykZj/4TIjRL2gxMmZT1gg5stLNG+dzQxhS0gc
        fPGCGWKOssT1fYvZIOxaic9/nzFOYBSZhaR9FpL2WUjaFzAyr2IUSS0tzk3PLTbUK07MLS7N
        S9dLzs/dxAiMtG3Hfm7ewTjv1Ue9Q4xMHIyHGCU4mJVEeGU3TUoR4k1JrKxKLcqPLyrNSS0+
        xGgK9OdEZinR5HxgrOeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQxcXBK
        NTCdmGA3/5KC3cutB2490Wj9sGma/PK9kesjlmxW15fbu+S4ytTWz9c4fn5NEGIxchR5f+R9
        nbHNzxdSLX/Xp/Zt2chZ7mayTJ6pInz9aj+NF/FP/3XfurHWcp1l4HvfqHs6X5cLVJ6/c5TX
        tdj8ouAZvq9Ghro7Txp+NvpWeLdxXRLfguIPjxT2BZZEps8TeXb6W2jEeTm1R3Ubnm5Y16u2
        3NQzuGml4NadG1ZaH6nJPeUS8F/9Wr6a1lnX2ckJBw9fvqnTJz6hxN2ZN2h71cFoAZ7zk3vq
        Xk1au6F542QrnWuabuVVAnG3y0XDQzqLXx0PkAnnsVJv3H/g/DsP7elXmV8xfrKrT5y1uC5z
        /m5VJZbijERDLeai4kQAXbWZ1T0DAAA=
X-CMS-MailID: 20230621091007eucas1p2271595a5889075994e8dceb0c06ae7cc
X-Msg-Generator: CA
X-RootMTR: 20230621091007eucas1p2271595a5889075994e8dceb0c06ae7cc
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091007eucas1p2271595a5889075994e8dceb0c06ae7cc
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091007eucas1p2271595a5889075994e8dceb0c06ae7cc@eucas1p2.samsung.com>
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

Now that the ctl_header is the preferred way of passing the ctl_table
pointer around, we can just use it (the header) as input to the list
ctl_table macro.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 1d9f42840518..93f50570eab4 100644
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

