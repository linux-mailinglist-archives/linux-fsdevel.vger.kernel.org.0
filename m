Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F74370DC79
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236890AbjEWMXA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236847AbjEWMWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:53 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA34184
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:40 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122239euoutp0140b2c7b50acd73d4670593470bcd2179~hxTNLChrc1781217812euoutp01N
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230523122239euoutp0140b2c7b50acd73d4670593470bcd2179~hxTNLChrc1781217812euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844559;
        bh=aJ50gZPCUiYPfATuPiuF3FP7jhiW9EGQQWudnikqczE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=T6CjuxuOMbY7Jn1B+Hb6y1SeOkP3MP17eYWEVKaYAmV8+noDdpm7a5i5ArPDYbHIW
         4Eh3w+0Pxc1y/d5D/zYdHry2bTJIqfg5kqOuLxN2acBT/umQg/gffYukdRPBwRAVoc
         3AoLMFYfwG+1F3ymmcckDhGslVDruTOPcuGgJeyY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122239eucas1p190560f3aae58440d1d9c7c647b95a0af~hxTM5Jkkn2688426884eucas1p1P;
        Tue, 23 May 2023 12:22:39 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id A9.C8.42423.F00BC646; Tue, 23
        May 2023 13:22:39 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122239eucas1p19c23501df7732d16422ab0489503c764~hxTMkyRy62670226702eucas1p1F;
        Tue, 23 May 2023 12:22:39 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122239eusmtrp24d64abac24d303b57ab36d8049c54933~hxTMkMy7R0682106821eusmtrp2h;
        Tue, 23 May 2023 12:22:39 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-10-646cb00f5040
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 60.CF.10549.E00BC646; Tue, 23
        May 2023 13:22:38 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122238eusmtip284f979b57f69c7f863ed642bd93cefbf~hxTMYohQE1858618586eusmtip24;
        Tue, 23 May 2023 12:22:38 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:38 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 8/8] sysctl: Remove register_sysctl_table
Date:   Tue, 23 May 2023 14:22:20 +0200
Message-ID: <20230523122220.1610825-9-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87r8G3JSDNY9ErZ4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxsa2ZqaCpeYVRw49Ym9gfKnVxcjJISFgIvHy7RW2
        LkYuDiGBFYwS+z4eZIFwvjBKTJ3+Ecr5zChx+tpmdpiWs+d/s0MkljNK7Pn/nAmu6tDrxawQ
        zhZGiek7usBa2AR0JM6/ucMMYosIiEucOL2ZEaSIWWAnk0R/5y02kISwgI3EhEu/mEBsFgFV
        iXcNf8AaeAVsJXZNm8YGsVteou36dEYQm1PATuLQs32sEDWCEidnPmEBsZmBapq3zmaGsCUk
        Dr54wQzRqySxuusP1JxaiVNbboGdLSHwg0Pi/vIGFoiEi8T5jr9MELawxKvjW6CelpH4v3M+
        VMNkRon9/z6wQzirGSWWNX6F6rCWaLnyBKrDUWL/26lAcQ4gm0/ixltBiIv4JCZtm84MEeaV
        6GgTmsCoMgvJD7OQ/DALyQ8LGJlXMYqnlhbnpqcWG+allusVJ+YWl+al6yXn525iBCah0/+O
        f9rBOPfVR71DjEwcjIcYJTiYlUR4T5RnpwjxpiRWVqUW5ccXleakFh9ilOZgURLn1bY9mSwk
        kJ5YkpqdmlqQWgSTZeLglGpgyhXs2tH39rRv/7/YN46HAjyOhu5Uvbh282addRcyvnkkTONx
        eni4uyM7geW5fn7ArDg5z7LNbQlPt+b07/nY93txccQp8y61rVsFBNOzfBbIJxzj2MG57/UK
        Vov7TnFiUzfc7fBJff5qzQbRLKPWp38qf1z+OqX9Q/ex4tRkhdtbBX5kvzlQnL57o8n7vWYq
        3K+WFTeduc4SU3/zUEDLaUMXiduyzozCN0WrVuezT+JJ5p/O8/B8foZnID/nyko2rl3375nu
        bf2yP7BpmdAu69UtStv79oqJP3ukwpK2+Hh1S+PZVzl7fsWe28TgKHeapyk5dWlB3SkLNv77
        Px8pcK9nv/klvrbGm2e2usdCJZbijERDLeai4kQAkTlGMbEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xe7p8G3JSDG79sLJ4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexsa2ZqaCpeYVRw49Ym9gfKnVxcjJISFgInH2/G/2LkYuDiGBpYwSr7raGSESMhIb
        v1xlhbCFJf5c62KDKPrIKLH00HkWCGcLo0T/9WnMIFVsAjoS59/cAbNFBMQlTpzezAhSxCyw
        nUliwt9dbCAJYQEbiQmXfjGB2CwCqhLvGv6ANfAK2ErsmjaNDWKdvETb9elgZ3AK2EkcerYP
        7AwhoJrWV5tYIeoFJU7OfMICYjMD1Tdvnc0MYUtIHHzxghlijpLE6q4/UDNrJT7/fcY4gVFk
        FpL2WUjaZyFpX8DIvIpRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwPrcd+7l5B+O8Vx/1DjEy
        cTAeYpTgYFYS4T1Rnp0ixJuSWFmVWpQfX1Sak1p8iNEU6M+JzFKiyfnABJFXEm9oZmBqaGJm
        aWBqaWasJM7rWdCRKCSQnliSmp2aWpBaBNPHxMEp1cCUO1dsvl/bf98LnD8bNwXoa/zY/nvG
        JMbXeou0V0t82da1PYmncMUXrSuqJw4x3Lr09z1bzw5XjZZz76eHVLsclhCIXXiicfZWnb/b
        9z8/ZLF9xZStnX//6i3tfmFV0scg0bN8i2tQV0CWwrm7f/MPFgVvFvTu+bfaIDxf4tKn4lfH
        7nLenq11/uBko7k7jK6ZPduzfWXF5YqYzIQfV/US9Y0eOdSX6Jvr6BZN02RXaKqc6/Nn0sv7
        PJtfPO2eqPZ+lbX3nz7rfO9PQd9KBObEvZjssOXxJLP68GCx3VM0QubU33nz1eHnzhrp0vqp
        DLxqx6J2LywU0n/IOfO3z1ODc7cWnJpVp956XGvzluDF05RYijMSDbWYi4oTAXck6/RYAwAA
X-CMS-MailID: 20230523122239eucas1p19c23501df7732d16422ab0489503c764
X-Msg-Generator: CA
X-RootMTR: 20230523122239eucas1p19c23501df7732d16422ab0489503c764
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122239eucas1p19c23501df7732d16422ab0489503c764
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122239eucas1p19c23501df7732d16422ab0489503c764@eucas1p1.samsung.com>
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

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. After removing all the calling functions, we
remove both the register_sysctl_table function and the documentation
check that appeared in check-sysctl-docs awk script.

We save 595 bytes with this change:

./scripts/bloat-o-meter vmlinux.1.refactor-base-paths vmlinux.2.remove-sysctl-table
add/remove: 2/8 grow/shrink: 1/0 up/down: 1154/-1749 (-595)
Function                                     old     new   delta
count_subheaders                               -     983    +983
unregister_sysctl_table                       29     184    +155
__pfx_count_subheaders                         -      16     +16
__pfx_unregister_sysctl_table.part            16       -     -16
__pfx_register_leaf_sysctl_tables.constprop   16       -     -16
__pfx_count_subheaders.part                   16       -     -16
__pfx___register_sysctl_base                  16       -     -16
unregister_sysctl_table.part                 136       -    -136
__register_sysctl_base                       478       -    -478
register_leaf_sysctl_tables.constprop        524       -    -524
count_subheaders.part                        547       -    -547
Total: Before=21257652, After=21257057, chg -0.00%

Signed-off-by: Joel Granados <j.granados@samsung.com>
[mcgrof: remove register_leaf_sysctl_tables and append_path too and
 add bloat-o-meter stats]
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c     | 159 --------------------------------------
 scripts/check-sysctl-docs |  10 ---
 2 files changed, 169 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index f8f19e000d76..8873812d22f3 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1466,19 +1466,6 @@ void __init __register_sysctl_init(const char *path, struct ctl_table *table,
 	kmemleak_not_leak(hdr);
 }
 
-static char *append_path(const char *path, char *pos, const char *name)
-{
-	int namelen;
-	namelen = strlen(name);
-	if (((pos - path) + namelen + 2) >= PATH_MAX)
-		return NULL;
-	memcpy(pos, name, namelen);
-	pos[namelen] = '/';
-	pos[namelen + 1] = '\0';
-	pos += namelen + 1;
-	return pos;
-}
-
 static int count_subheaders(struct ctl_table *table)
 {
 	int has_files = 0;
@@ -1498,152 +1485,6 @@ static int count_subheaders(struct ctl_table *table)
 	return nr_subheaders + has_files;
 }
 
-static int register_leaf_sysctl_tables(const char *path, char *pos,
-	struct ctl_table_header ***subheader, struct ctl_table_set *set,
-	struct ctl_table *table)
-{
-	struct ctl_table *ctl_table_arg = NULL;
-	struct ctl_table *entry, *files;
-	int nr_files = 0;
-	int nr_dirs = 0;
-	int err = -ENOMEM;
-
-	list_for_each_table_entry(entry, table) {
-		if (entry->child)
-			nr_dirs++;
-		else
-			nr_files++;
-	}
-
-	files = table;
-	/* If there are mixed files and directories we need a new table */
-	if (nr_dirs && nr_files) {
-		struct ctl_table *new;
-		files = kcalloc(nr_files + 1, sizeof(struct ctl_table),
-				GFP_KERNEL);
-		if (!files)
-			goto out;
-
-		ctl_table_arg = files;
-		new = files;
-
-		list_for_each_table_entry(entry, table) {
-			if (entry->child)
-				continue;
-			*new = *entry;
-			new++;
-		}
-	}
-
-	/* Register everything except a directory full of subdirectories */
-	if (nr_files || !nr_dirs) {
-		struct ctl_table_header *header;
-		header = __register_sysctl_table(set, path, files);
-		if (!header) {
-			kfree(ctl_table_arg);
-			goto out;
-		}
-
-		/* Remember if we need to free the file table */
-		header->ctl_table_arg = ctl_table_arg;
-		**subheader = header;
-		(*subheader)++;
-	}
-
-	/* Recurse into the subdirectories. */
-	list_for_each_table_entry(entry, table) {
-		char *child_pos;
-
-		if (!entry->child)
-			continue;
-
-		err = -ENAMETOOLONG;
-		child_pos = append_path(path, pos, entry->procname);
-		if (!child_pos)
-			goto out;
-
-		err = register_leaf_sysctl_tables(path, child_pos, subheader,
-						  set, entry->child);
-		pos[0] = '\0';
-		if (err)
-			goto out;
-	}
-	err = 0;
-out:
-	/* On failure our caller will unregister all registered subheaders */
-	return err;
-}
-
-/**
- * register_sysctl_table - register a sysctl table hierarchy
- * @table: the top-level table structure
- *
- * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array. A completely 0 filled entry terminates the table.
- * We are slowly deprecating this call so avoid its use.
- */
-static struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
-{
-	struct ctl_table *ctl_table_arg = table;
-	int nr_subheaders = count_subheaders(table);
-	struct ctl_table_header *header = NULL, **subheaders, **subheader;
-	char *new_path, *pos;
-
-	pos = new_path = kmalloc(PATH_MAX, GFP_KERNEL);
-	if (!new_path)
-		return NULL;
-
-	pos[0] = '\0';
-	while (table->procname && table->child && !table[1].procname) {
-		pos = append_path(new_path, pos, table->procname);
-		if (!pos)
-			goto out;
-		table = table->child;
-	}
-	if (nr_subheaders == 1) {
-		header = __register_sysctl_table(&sysctl_table_root.default_set, new_path, table);
-		if (header)
-			header->ctl_table_arg = ctl_table_arg;
-	} else {
-		header = kzalloc(sizeof(*header) +
-				 sizeof(*subheaders)*nr_subheaders, GFP_KERNEL);
-		if (!header)
-			goto out;
-
-		subheaders = (struct ctl_table_header **) (header + 1);
-		subheader = subheaders;
-		header->ctl_table_arg = ctl_table_arg;
-
-		if (register_leaf_sysctl_tables(new_path, pos, &subheader,
-						&sysctl_table_root.default_set, table))
-			goto err_register_leaves;
-	}
-
-out:
-	kfree(new_path);
-	return header;
-
-err_register_leaves:
-	while (subheader > subheaders) {
-		struct ctl_table_header *subh = *(--subheader);
-		struct ctl_table *table = subh->ctl_table_arg;
-		unregister_sysctl_table(subh);
-		kfree(table);
-	}
-	kfree(header);
-	header = NULL;
-	goto out;
-}
-
-int __register_sysctl_base(struct ctl_table *base_table)
-{
-	struct ctl_table_header *hdr;
-
-	hdr = register_sysctl_table(base_table);
-	kmemleak_not_leak(hdr);
-	return 0;
-}
-
 static void put_links(struct ctl_table_header *header)
 {
 	struct ctl_table_set *root_set = &sysctl_table_root.default_set;
diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index edc9a629d79e..4f163e0bf6a4 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -146,16 +146,6 @@ curtable && /\.procname[\t ]*=[\t ]*".+"/ {
     children[curtable][curentry] = child
 }
 
-/register_sysctl_table\(.*\)/ {
-    match($0, /register_sysctl_table\(([^)]+)\)/, tables)
-    if (debug) print "Registering table " tables[1]
-    if (children[tables[1]][table]) {
-	for (entry in entries[children[tables[1]][table]]) {
-	    printentry(entry)
-	}
-    }
-}
-
 END {
     for (entry in documented) {
 	if (!seen[entry]) {
-- 
2.30.2

