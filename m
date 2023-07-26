Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12150763857
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234366AbjGZOHE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234228AbjGZOHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC69B2701
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:06:52 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140650euoutp021d5051ddfac04a1fbc239e47db38a0fb~1cAcJNYlP1595615956euoutp02D
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:06:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230726140650euoutp021d5051ddfac04a1fbc239e47db38a0fb~1cAcJNYlP1595615956euoutp02D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380410;
        bh=A0yFUtcBmjlDc/JAvy8SEl8ns1g5aFjeEqkhCY5WXnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n8Cx/zpGERpqTQz+DVg8x5GyzY6Fc3IKT5Hb3hbJUgg7v4tIJlwrAZLfv7I3PLMz6
         x+EX5jj/FNVmRuS+mWL6GeGYh8ZRXvQpJC9aPdhCQtjmhsxNz/jg/zaQnSyQHnRN/V
         oogrWrMt/08m1sQXWOfvf4KAncHKaBAGibg50ImM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140650eucas1p1b2e6fc9826d0d0732b155ab6d48adfc8~1cAb_oX8t2257522575eucas1p1v;
        Wed, 26 Jul 2023 14:06:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 27.56.37758.A7821C46; Wed, 26
        Jul 2023 15:06:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230726140650eucas1p1f5b2aa9dd8f90989c881f0a2e682b9eb~1cAbuJVld2261822618eucas1p1o;
        Wed, 26 Jul 2023 14:06:50 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140650eusmtrp1211dd44af609fa595ca6559c1464ada7~1cAbtgAVf2391823918eusmtrp1c;
        Wed, 26 Jul 2023 14:06:50 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-e3-64c1287a64e9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A9.47.14344.A7821C46; Wed, 26
        Jul 2023 15:06:50 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140649eusmtip2e2780fccf7021b940db173c2d91726aa~1cAbgzFjn3056730567eusmtip2X;
        Wed, 26 Jul 2023 14:06:49 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 01/14] sysctl: Prefer ctl_table_header in proc_sysctl
Date:   Wed, 26 Jul 2023 16:06:21 +0200
Message-Id: <20230726140635.2059334-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsWy7djP87pVGgdTDLruS1ks3f+Q0eL/gnyL
        M925Fnv2nmSxuLxrDpvFjQlPGS1+/wCylu30c+DwmN1wkcVjwaZSj80rtDxuvbb12LSqk82j
        b8sqRo/Pm+QC2KO4bFJSczLLUov07RK4MtpOXmUuaFWraFjYxNLAuE6+i5GTQ0LARGJe+yzW
        LkYuDiGBFYwSnf1f2CGcL4wSizfuZYRwPjNK/Fv4gh2m5fT+HawgtpDAckaJu1PNIYpeMkrc
        +jyXESTBJqAjcf7NHeYuRg4OEYFYicVTUkDCzALTGSWWzJEBsYUFXCWWbNnIDGKzCKhKrO+5
        yQ5SzitgK9G/2BpilbxE2/XpYBM5BewkVq79DraWV0BQ4uTMJywQI+UlmrfOZgY5QULgDIfE
        gr7tjBDNLhKHfy6BsoUlXh3fAnW/jMTpyT0sEA2TGSX2//vADuGsZpRY1viVCaLKWqLlyhOw
        i5gFNCXW79KHCDtKnN66BewvCQE+iRtvBSGO4JOYtG06VJhXoqNNCKJaRaJv6RQWCFtK4vrl
        nWwQtofEjdMXmSYwKs5C8s4sJO/MQti7gJF5FaN4amlxbnpqsXFearlecWJucWleul5yfu4m
        RmDqOf3v+NcdjCtefdQ7xMjEwXiIUYKDWUmE1zBmX4oQb0piZVVqUX58UWlOavEhRmkOFiVx
        Xm3bk8lCAumJJanZqakFqUUwWSYOTqkGpqhy+dxNR9/82crntnlZ5F+vkxHKB7YceR/slPh6
        Rvae2K0lzWWRs97cF713Kmm93pQXTrPaVFglPT8677d7/13F5axvB4P/jhm7+V7Pv3dfzv+5
        NZ/G7mv7+KeGTnW0TPd7zTpt116PHfZJqooshq95js2wv6Fy/uLhLs233xk2ea7mKjtpckwg
        Z9l2X/5ozhwmL9ajFhPdWpeu/zxvrmek53Rz47TVclacMj+4upT7vJsUv0w2+PraXTWIY6/N
        9QNpO2U2dLL07zGqnveqkceQ+cisdI0TqzdNjt/gn/Lva4Xn/HsbtoRO5nz493Klpevpak2R
        rhs/85ZcNf17be6vaRIx2/34bmlxeL6su63EUpyRaKjFXFScCABBuNxDrAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Pd0qjYMpBgcncFgs3f+Q0eL/gnyL
        M925Fnv2nmSxuLxrDpvFjQlPGS1+/wCylu30c+DwmN1wkcVjwaZSj80rtDxuvbb12LSqk82j
        b8sqRo/Pm+QC2KP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLL
        Uov07RL0MtpOXmUuaFWraFjYxNLAuE6+i5GTQ0LAROL0/h2sXYxcHEICSxklfhy+DORwACWk
        JL4v44SoEZb4c62LDaLmOaPEx8lrWUESbAI6Euff3GEGsUUE4iVmPr7PBFLELDCbUWL1yUNg
        CWEBV4klWzaC2SwCqhLre26ygyzgFbCV6F9sDbFAXqLt+nRGEJtTwE5i5drvYPOFgEp6pj5l
        B7F5BQQlTs58wgJiMwPVN2+dzTyBUWAWktQsJKkFjEyrGEVSS4tz03OLjfSKE3OLS/PS9ZLz
        czcxAqNk27GfW3Ywrnz1Ue8QIxMH4yFGCQ5mJRFew5h9KUK8KYmVValF+fFFpTmpxYcYTYHO
        nsgsJZqcD4zTvJJ4QzMDU0MTM0sDU0szYyVxXs+CjkQhgfTEktTs1NSC1CKYPiYOTqkGpqjl
        OYvTlU5WSci8mTDZXli91GTpqgvnwu5vzOl7/THhjT6nG9cPV5NJHtLBk6Qnbrq8o/0+++zl
        Ww8qeG5JTCtf3Dpje+fJtNZLcms2LDN5XJEq0GCS5HTQf9eXZ/Z3s0uy61+t3Hp2q8FV5jm7
        H9mpT6zJ8X4x+fpsyV2e53wXfJouFXrB9MgkVgUja+Hy6A+vt2sbuN9lFmkysr2eM7k+miu0
        /kRAk907l7VzbrclhQYv/3nxS3eD8Z2XdtMSe91KNQ3upS+Zu3iZ7o5ngVmPT2zgPG/Tbpgk
        usT5yzZJp/diiS7Xtq76s1nbyk7Q97TU3reGHT3uWeo9fEc7dV9ZTNX4tzRiwcZTs62Y1iqx
        FGckGmoxFxUnAgCTiEtOGwMAAA==
X-CMS-MailID: 20230726140650eucas1p1f5b2aa9dd8f90989c881f0a2e682b9eb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140650eucas1p1f5b2aa9dd8f90989c881f0a2e682b9eb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140650eucas1p1f5b2aa9dd8f90989c881f0a2e682b9eb
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140650eucas1p1f5b2aa9dd8f90989c881f0a2e682b9eb@eucas1p1.samsung.com>
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

This is a preparation commit to use ctl_table_header instead of
ctl_table as the element that is passed around in proc_sysctl.c.
This will become necessary when the size can no longer be calculated
by searching for an empty sentinel in the ctl_table array and
will live in the ctl_table_header.

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

