Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9A2737E54
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjFUJKO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjFUJKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:10:08 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85631BC
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:10:06 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091005euoutp012f9a0fc3181d64013c076cdd172a21c9~qoYWDTDri1411514115euoutp01O
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 09:10:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230621091005euoutp012f9a0fc3181d64013c076cdd172a21c9~qoYWDTDri1411514115euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338605;
        bh=FxyVOFyTHFtuUAVqnN0MhLQUu0/hLv8Fe5NlXqOf4FY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QKXiIykPOo6YENoZDCPepN7Tcz2fjjq1jLpHTB9X9LBFen8BVAJymIL7B7xQzbr5/
         s0IcPJjbWAJTFzcD2BFIHP5nO9ayRkiH3VKO8iY9DYRmZXTfYqTVFciF+Kuhlhcb9r
         hjcHPqcknsKKTf8j3Uog63D0oc51PbqxZRJIB3as=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230621091005eucas1p222a9a1c2c24e02667da5c986e8d42516~qoYV4KXSZ2539725397eucas1p2r;
        Wed, 21 Jun 2023 09:10:05 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 51.74.37758.C6EB2946; Wed, 21
        Jun 2023 10:10:04 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091004eucas1p2e53ad3001cdaef7b3c44555653bbec37~qoYVV9zXR2952429524eucas1p2k;
        Wed, 21 Jun 2023 09:10:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091004eusmtrp2914d66a59410a1e2d2a8e39aacb9e44e~qoYVVHJLe2182221822eusmtrp2r;
        Wed, 21 Jun 2023 09:10:04 +0000 (GMT)
X-AuditID: cbfec7f5-7ffff7000002937e-15-6492be6c4aa7
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 42.0F.10549.C6EB2946; Wed, 21
        Jun 2023 10:10:04 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091004eusmtip2fe807757ae6939c118df2a2567566edd~qoYVLt4xF1982119821eusmtip20;
        Wed, 21 Jun 2023 09:10:04 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:03 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 01/11] sysctl: Prefer ctl_table_header in proc_sysctl
Date:   Wed, 21 Jun 2023 11:09:50 +0200
Message-ID: <20230621091000.424843-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOd2cfZNSDCZ9N7M4051rsWfvSRaL
        y7vmsFncmPCU0WLZTj8HVo/ZDRdZPBZsKvXYtKqTzePzJrkAligum5TUnMyy1CJ9uwSujKc9
        z5gKpqpVLPv5j72B8YB8FyMnh4SAicTu1euYuxi5OIQEVjBKHGi4yAbhfGGUOPmglRHC+QyU
        6bsFVMYB1rJ0ChdEfDmjRPuJi0xwRX+/trBDOFsZJa5cmcMGsoRNQEfi/Js7zCC2iEC8xOw1
        2xlBbGaBXIlZy5eAxYUFXCXmXP3JCmKzCKhK/N7YD9bLK2Aj8f3rHFaIY+Ul2q5PB+vlFLCV
        OP/4PQtEjaDEyZlPWCBmyks0b53NDGFLSBx88YIZoldZ4vq+xWwQdq3EqS23wK6WELjAIbHn
        6XGoIheJj3/uMEHYwhKvjm9hh7BlJP7vnA/VMJlRYv+/D+wQzmpGiWWNX6E6rCVarjyB6nCU
        +P30IyskwPgkbrwVhLiIT2LStunQcOSV6GgTmsCoMgvJD7OQ/DALyQ8LGJlXMYqnlhbnpqcW
        G+ellusVJ+YWl+al6yXn525iBKaT0/+Of93BuOLVR71DjEwcjIcYJTiYlUR4ZTdNShHiTUms
        rEotyo8vKs1JLT7EKM3BoiTOq217MllIID2xJDU7NbUgtQgmy8TBKdXANE/hE8v+p4zXtRin
        vJvwzvZL9f4ZZeWqYuuKhTl+mJ+X3dsQ99Wv87maSuJ5xzQ2/iDDlywNzr9Fi0+e3y9tfnZ3
        Z2ljilQuo91aH69Er6h7Bevswj9Is/36m+j96nHNKR0vr4f9+1Wvue2rbW5LvifFvpcj5Rvf
        /zTvrqDDZ2XfiS7o7t0vbqv8NpEnbMb2B29m3b8ddPnijN/lHtFnr+6rWH2icaqlU5Nm94WF
        tzarnbp57rzYjltujlc/fN0nGtv9O8tLZMuvgCTh6jN/Eo/7zNe8EWqiJ3b8lrfm+XqmZqZN
        K5ombr6alqN7I+VYTbOfkO0z2VknXrIXL2V/1MywOmpW4i+VHdxV6yyslViKMxINtZiLihMB
        75WrgZYDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7o5+yalGMxZLm5xpjvXYs/ekywW
        l3fNYbO4MeEpo8WynX4OrB6zGy6yeCzYVOqxaVUnm8fnTXIBLFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GU97njEVTFWrWPbzH3sD4wH5LkYO
        DgkBE4mlU7i6GLk4hASWMkqc336TuYuREyguI7Hxy1VWCFtY4s+1LjaIoo+MEvOnnWWEcLYy
        Sqw7cBKsik1AR+L8mztg3SIC8RKz12xnBLGZBXIlZi1fAhYXFnCVmHP1J1g9i4CqxO+N/Wwg
        Nq+AjcT3r3OgtslLtF2fDtbLKWArcf7xexYQWwioZv6Hy4wQ9YISJ2c+YYGYLy/RvHU2M4Qt
        IXHwxQuoD5Qlru9bzAZh10p8/vuMcQKjyCwk7bOQtM9C0r6AkXkVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYKRtO/Zz8w7Gea8+6h1iZOJgPMQowcGsJMIru2lSihBvSmJlVWpRfnxRaU5q
        8SFGU6A/JzJLiSbnA2M9ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mD
        U6qBSfrFqk/xc35EXWX1mMAT2jjNrWUKV4bmq+m1Vmcldp0pZ73cfL4v9EL2gl2yjsUdfjG9
        iys/mu1VnjLd0GfSvtnv3cozgwQ2bZi5SUHozKnIt8WPLUqrXlf/WVmya4qCNYOZf7vU+dP/
        /+tyHF4ZGnxDaes6kXJRFwONIIXzRzy/yp1c9FLxUWiHhWO1vbi0XvHJRauqb+vu9HSMKPB9
        ER9SMSftfo6l6wujy1tufp2gPHnv+fzQ0hez3jW3cOXcadhuVrdltfPc3JtZj3foBj29H/Bk
        KXveoo2r/+Qe+LzOc1NptH/coq4tvWufKAffvVv5cEVOyeyc2XMLl1d9u7Q0emvDmlQnv/0p
        zVqLTZRYijMSDbWYi4oTAWh2O4o9AwAA
X-CMS-MailID: 20230621091004eucas1p2e53ad3001cdaef7b3c44555653bbec37
X-Msg-Generator: CA
X-RootMTR: 20230621091004eucas1p2e53ad3001cdaef7b3c44555653bbec37
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091004eucas1p2e53ad3001cdaef7b3c44555653bbec37
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091004eucas1p2e53ad3001cdaef7b3c44555653bbec37@eucas1p2.samsung.com>
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

This is a preparation commit to use ctl_table_header instead of
ctl_table as the pointer that is passed around in proc_sysctl.c. This is
necessary as the size of the ctl_table array moved from the ctl_table
pointer to the ctl_table_header. The functions changed are
sysctl_check_table, get_links and new_links.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index c4ea804d862b..1d9f42840518 100644
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

