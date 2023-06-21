Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2DC737E71
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjFUJKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 05:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjFUJKU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:10:20 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F0A1706
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 02:10:13 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230621091012euoutp02191277d8f9eab32ff07761d7ce277fd9~qoYctmGdc0948409484euoutp02u
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 09:10:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230621091012euoutp02191277d8f9eab32ff07761d7ce277fd9~qoYctmGdc0948409484euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687338612;
        bh=AoMNSAYFebvCfAbJVURrKKQ+f+N43EEZeoinYWLcJEA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dIPKQMmQ4d+pQvr+hJxudwI1UHUZ/+e3LofR3FGL74JltPYkvnSxQD0FGvLPxXkb1
         elYxI6DFohWjICGwE8FphJF39tNmwBijuTD/A6/+ev3r7AbVl0pb55FVXI0lK2G5uk
         o/fk+Dl+lFXfliOHoYQotO18nnl/VSW53pZYWVDw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230621091012eucas1p1a2f3a7d352129dc0f20ad47059407a53~qoYckoQDV1960419604eucas1p1G;
        Wed, 21 Jun 2023 09:10:12 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id E7.22.42423.47EB2946; Wed, 21
        Jun 2023 10:10:12 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091011eucas1p2116c1fb8f406bec7ca9a831f66955724~qoYcQz0oP1816318163eucas1p2w;
        Wed, 21 Jun 2023 09:10:11 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230621091011eusmtrp295fa787611dfbbdf45e99ac95838ec76~qoYcQUW1K2182221822eusmtrp2G;
        Wed, 21 Jun 2023 09:10:11 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-2f-6492be741167
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 0D.D1.14344.37EB2946; Wed, 21
        Jun 2023 10:10:11 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230621091011eusmtip2f260d25450a384653ab6d488110306ff~qoYcDyeeq1998819988eusmtip2Z;
        Wed, 21 Jun 2023 09:10:11 +0000 (GMT)
Received: from localhost (106.210.248.248) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Wed, 21 Jun 2023 10:10:11 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
CC:     Joel Granados <j.granados@samsung.com>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
Subject: [PATCH 04/11] sysctl: Add size argument to init_header
Date:   Wed, 21 Jun 2023 11:09:53 +0200
Message-ID: <20230621091000.424843-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621091000.424843-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.248]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpkleLIzCtJLcpLzFFi42LZduzned2SfZNSDPqucVmc6c612LP3JIvF
        5V1z2CxuTHjKaLFsp58Dq8fshossHgs2lXpsWtXJ5vF5k1wASxSXTUpqTmZZapG+XQJXRufe
        38wFK4Qrbuw8zdbA2C/QxcjJISFgIrGkaS1TFyMXh5DACkaJxoet7BDOF0aJ1hOXoJzPjBK3
        v/1l62LkAGs5/ZUFpFtIYDmjxLZj7hA2UM2DOQIQ9VsZJd7vv8kEkmAT0JE4/+YOM4gtIhAv
        MXvNdkYQm1kgV2LW8iVgcWEBe4kdj5+ygdgsAqoSv/Z+YAWxeQVsJN7+OsIKcaq8RNv16WC9
        nAK2Eucfv2eBqBGUODnzCQvETHmJ5q2zmSFsCYmDL14wQ/QqS1zft5gNwq6VOLXlFtjLEgJX
        OCSW9u1hgki4SJxf+xSqSFji1fEt7BC2jMT/nfOhGiYzSuz/94EdwlnNKLGs8StUt7VEy5Un
        UB2OEvOmbmCGBBefxI23ghAX8UlM2jYdKswr0dEmNIFRZRaSH2Yh+WEWkh8WMDKvYhRPLS3O
        TU8tNsxLLdcrTswtLs1L10vOz93ECEwlp/8d/7SDce6rj3qHGJk4GA8xSnAwK4nwym6alCLE
        m5JYWZValB9fVJqTWnyIUZqDRUmcV9v2ZLKQQHpiSWp2ampBahFMlomDU6qByTrL84J4imFQ
        M7/shl+HS27OOdcv9LV6vXqXm8rC66fXTTwltGV13eWyR5FFQYJq5uLvm2R8spcH/s8u7N4x
        Naz8az/fhVpprj+7X9roHdu88uT53b+93V9fmvhsVs8ah3f/7WqvSrN/Db/n+myGtKSEUnfD
        ye17bCqV5HZWq94/cctT7WDhba/8fzJyrW/1tu0SecKYq8f/35LJc4HEde59xX/OF5pyM+Qd
        vXwxxv/E727Pg0cPr99Q/LyF9cCBZXMer7RdIcmspX/9RMAs11onc8OYY4YZkzU+c3h7LmNL
        uOupOH37DvcTrE9yymwcb7qVHD2Y4f2gqGvevBLLP3/TJ4Y+3ZBwcYLU5hBXeyWW4oxEQy3m
        ouJEANabbLiUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7rF+yalGPw6q2dxpjvXYs/ekywW
        l3fNYbO4MeEpo8WynX4OrB6zGy6yeCzYVOqxaVUnm8fnTXIBLFF6NkX5pSWpChn5xSW2StGG
        FkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GZ17fzMXrBCuuLHzNFsDY79AFyMH
        h4SAicTpryxdjFwcQgJLGSU2Luxi72LkBIrLSGz8cpUVwhaW+HOtiw2i6COjxKyNvUwQzlZG
        iW+z2thAqtgEdCTOv7nDDGKLCMRLzF6znRHEZhbIlZi1fAlYXFjAXmLH46dg9SwCqhK/9n4A
        28ArYCPx9tcRqG3yEm3Xp4P1cgrYSpx//J4FxBYCqpn/4TIjRL2gxMmZT1gg5stLNG+dzQxh
        S0gcfPGCGWKOssT1fYvZIOxaic9/nzFOYBSZhaR9FpL2WUjaFzAyr2IUSS0tzk3PLTbSK07M
        LS7NS9dLzs/dxAiMtG3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeGU3TUoR4k1JrKxKLcqPLyrN
        SS0+xGgK9OdEZinR5HxgrOeVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQWwfQx
        cXBKNTClSUvO/sxxulbT/uyFANEPhpfP/J9924NBVNWb7/uqwolByjle7B8NWXv9I8LKyvXz
        0yPElotmtp5a9Ybj96q36Z0n69/9+Zsz2aRjm6Cnz5XysBSV7RqP+JRNhZUfFOgG9n0NaVzS
        P//kyjdOntP/dj/8LZj2xL4pMYjh9b6Eo2UHdh6z3deSxtzaXLX92POMtWcfhPYWMLwLZl3I
        tSvyzp3wGdeUF6qu2Z3ZVrBrkw9n7ZOsiY5LTkxbr55RXTllWtV7ccM20ZAt+gdt0jad4Nhh
        m/3Xf93f+fnqWuu32e6xD1qVetd2K/sWlquCP4W95Fsyvxycus13/tYjc/MWvrQ88jmBxbr+
        D4ORl4sSS3FGoqEWc1FxIgCCrsLJPQMAAA==
X-CMS-MailID: 20230621091011eucas1p2116c1fb8f406bec7ca9a831f66955724
X-Msg-Generator: CA
X-RootMTR: 20230621091011eucas1p2116c1fb8f406bec7ca9a831f66955724
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230621091011eucas1p2116c1fb8f406bec7ca9a831f66955724
References: <20230621091000.424843-1-j.granados@samsung.com>
        <CGME20230621091011eucas1p2116c1fb8f406bec7ca9a831f66955724@eucas1p2.samsung.com>
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

Pass the size of the ctl_table to properly initialize the
ctl_table_header struct. This is a preparation commit for when we start
traversing the ctl_table array with the size in ctl_table_header.
In __register_sysctl_table we use a calculated size until we add the
size argument to that function

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 93f50570eab4..09c09c373624 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -188,9 +188,10 @@ static void erase_entry(struct ctl_table_header *head, struct ctl_table *entry)
 
 static void init_header(struct ctl_table_header *head,
 	struct ctl_table_root *root, struct ctl_table_set *set,
-	struct ctl_node *node, struct ctl_table *table)
+	struct ctl_node *node, struct ctl_table *table, size_t table_size)
 {
 	head->ctl_table = table;
+	head->ctl_table_size = table_size;
 	head->ctl_table_arg = table;
 	head->used = 0;
 	head->count = 1;
@@ -973,7 +974,7 @@ static struct ctl_dir *new_dir(struct ctl_table_set *set,
 	memcpy(new_name, name, namelen);
 	table[0].procname = new_name;
 	table[0].mode = S_IFDIR|S_IRUGO|S_IXUGO;
-	init_header(&new->header, set->dir.header.root, set, node, table);
+	init_header(&new->header, set->dir.header.root, set, node, table, 1);
 
 	return new;
 }
@@ -1197,7 +1198,8 @@ static struct ctl_table_header *new_links(struct ctl_dir *dir, struct ctl_table_
 		link_name += len;
 		link++;
 	}
-	init_header(links, dir->header.root, dir->header.set, node, link_table);
+	init_header(links, dir->header.root, dir->header.set, node, link_table,
+		    head->ctl_table_size);
 	links->nreg = nr_entries;
 
 	return links;
@@ -1372,7 +1374,7 @@ struct ctl_table_header *__register_sysctl_table(
 		return NULL;
 
 	node = (struct ctl_node *)(header + 1);
-	init_header(header, root, set, node, table);
+	init_header(header, root, set, node, table, nr_entries);
 	if (sysctl_check_table(path, header))
 		goto fail;
 
@@ -1537,7 +1539,7 @@ void setup_sysctl_set(struct ctl_table_set *set,
 {
 	memset(set, 0, sizeof(*set));
 	set->is_seen = is_seen;
-	init_header(&set->dir.header, root, set, NULL, root_table);
+	init_header(&set->dir.header, root, set, NULL, root_table, 1);
 }
 
 void retire_sysctl_set(struct ctl_table_set *set)
-- 
2.30.2

