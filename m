Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1CA763862
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jul 2023 16:07:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjGZOHX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jul 2023 10:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234359AbjGZOHD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:07:03 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC752737
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 07:06:57 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230726140655euoutp01255dd84244a51f63c42e42034ddd307f~1cAhAJUeB3202132021euoutp01Q
        for <linux-fsdevel@vger.kernel.org>; Wed, 26 Jul 2023 14:06:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230726140655euoutp01255dd84244a51f63c42e42034ddd307f~1cAhAJUeB3202132021euoutp01Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690380415;
        bh=ZlhOJ8Gab+MSzPX9ZYs0a+yISdusJpdPSBybk1+HDeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GuLU8TiCaK8j7Z+zJmcO10ZpiLOMKNN761O2CbK3hV+PXUd/Ql3B5DaT473GZAWj3
         SHLnHi/mjS21xdHNW+B1MYqpMnj5jFWfANQcl7aMsuoYslVvIuRHe4NQoOnNgKadB3
         FqOrOKQC2byGoLn/naNabpDU0kY8svh+VnD2+wbg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230726140655eucas1p1716d7debd87fd6db1c31cda39504208a~1cAgzGlbb2260622606eucas1p1t;
        Wed, 26 Jul 2023 14:06:55 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 10.F6.11320.F7821C46; Wed, 26
        Jul 2023 15:06:55 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230726140655eucas1p1c71c8de9edc8441b5262c936731b91a2~1cAghMaJC1812118121eucas1p1A;
        Wed, 26 Jul 2023 14:06:55 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230726140655eusmtrp146bf937793ee3ac7ee9b51f49865bd32~1cAgggVUt2391823918eusmtrp19;
        Wed, 26 Jul 2023 14:06:55 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-25-64c1287f3c72
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id D3.C7.10549.F7821C46; Wed, 26
        Jul 2023 15:06:55 +0100 (BST)
Received: from localhost (unknown [106.210.248.223]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20230726140655eusmtip12a0effc937e26b573d01a29cbefa6ae5~1cAgTexk92869028690eusmtip1e;
        Wed, 26 Jul 2023 14:06:55 +0000 (GMT)
From:   Joel Granados <j.granados@samsung.com>
To:     mcgrof@kernel.org, Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>
Cc:     willy@infradead.org, josh@joshtriplett.org,
        Joel Granados <j.granados@samsung.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 04/14] sysctl: Add size argument to init_header
Date:   Wed, 26 Jul 2023 16:06:24 +0200
Message-Id: <20230726140635.2059334-5-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230726140635.2059334-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFKsWRmVeSWpSXmKPExsWy7djPc7r1GgdTDGY1qlos3f+Q0eL/gnyL
        M925Fnv2nmSxuLxrDpvFjQlPGS1+/wCylu30c+DwmN1wkcVjwaZSj80rtDxuvbb12LSqk82j
        b8sqRo/Pm+QC2KO4bFJSczLLUov07RK4Mj52b2EseCFcsW3iRbYGxiMCXYycHBICJhI7Zy5i
        BbGFBFYwSrxeHNHFyAVkf2GUaFpwnR3C+cwocaD3IxNMR+/pBywQieWMEuuP3maCcF4ySmz/
        vJYdpIpNQEfi/Js7zF2MHBwiArESi6ekgISZBaYzSiyZIwNiCwvYS1xZeQ5sNYuAqsSMgysZ
        QWxeAVuJzitPmSGWyUu0XZ8OFucUsJNYufY7K0SNoMTJmU9YIGbKSzRvnc0McoOEwAkOiS/d
        bewQzS4Spze/hrpaWOLV8S1QcRmJ05N7WCAaJjNK7P/3gR3CWc0osazxK1SHtUTLlSfsIB8w
        C2hKrN+lDxF2lPg7/xkrSFhCgE/ixltBiCP4JCZtm84MEeaV6GgTgqhWkehbOoUFwpaSuH55
        JxuE7SGx9NdH1gmMirOQvDMLyTuzEPYuYGRexSieWlqcm55abJSXWq5XnJhbXJqXrpecn7uJ
        EZh8Tv87/mUH4/JXH/UOMTJxMB5ilOBgVhLhNYzZlyLEm5JYWZValB9fVJqTWnyIUZqDRUmc
        V9v2ZLKQQHpiSWp2ampBahFMlomDU6qBKdx5morVoagfMw7kf51uvSRlvq2z+O2yw68NKr/M
        PXlIcMlMx4y5Thsb5v8UP8YWt1AvZ/IB5mjfr5tnLll29dK6+RPk9efvTt9639NfMbb1oaOn
        Lp/Ycy6Bp/YiKbPcbD2NWQ/+XdvB0b/0UcYajnnS4Vriqo6911uu+0fafFnIF2X9scml023e
        VWHtKft7br8N3/gp4Y3ohiVOEqcWH5p6J1rYpKTbN8v5+gkerm4G1b+LpOb365TGb56SyfTi
        RPX7F9LeUmWbNpscjd/E8cCYx2Gn7o2UC24qK1K2fTmcaxRyzDstMumn/INnwlzHu9XlpFTO
        dBzinvv/cpzlvW8TDwRonfHNT3Wp1tlaocRSnJFoqMVcVJwIANzkUuStAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4Xd16jYMpBi1ThC2W7n/IaPF/Qb7F
        me5ciz17T7JYXN41h83ixoSnjBa/fwBZy3b6OXB4zG64yOKxYFOpx+YVWh63Xtt6bFrVyebR
        t2UVo8fnTXIB7FF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZll
        qUX6dgl6GR+7tzAWvBCu2DbxIlsD4xGBLkZODgkBE4ne0w9Yuhi5OIQEljJKHJ/WDORwACWk
        JL4v44SoEZb4c62LDaLmOaPE84nHmUASbAI6Euff3GEGsUUE4iVmPr7PBFLELDCbUWL1yUNg
        CWEBe4krK8+xgtgsAqoSMw6uZASxeQVsJTqvPGWG2CAv0XZ9OlicU8BOYuXa72D1QkA1PVOf
        skPUC0qcnPmEBcRmBqpv3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem5xYb6hUn5haX5qXrJefn
        bmIExsm2Yz8372Cc9+qj3iFGJg7GQ4wSHMxKIryGMftShHhTEiurUovy44tKc1KLDzGaAt09
        kVlKNDkfGKl5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TBycUg1MtUkb
        4jfuLX+nGb44uf32h7fZazhnXChmkO6Lry3WiD97Yf50F5PdaQm7bDjC+Nzml/ren7TVLmNP
        y2+D/Q85/+ZM1JFxuOcZpTA/UtluAUvnZ/vzOnybC+as8z//iy2AY2nvNeuNPybuqSurfSSs
        aW+6J+NCX33POskVj6/ZqL6Je7V+0iWLpuUfrBOKI94IvNaN0L9zZ+7e0wqrZy3TE54mG+6s
        6vb730OJBr3TBW9Yv5YmzVp3/r5WkflWJZsXbr/U+PaLOUnf/eyzbwFv4apjPaL+QZH+R2o/
        Vy7kfLrku8W2eQ8ONK80dii4aPeI72bpjqemRx+flftsrPJNtPyMtG/L21jFe6JLf7BfVmIp
        zkg01GIuKk4EAH43s0ocAwAA
X-CMS-MailID: 20230726140655eucas1p1c71c8de9edc8441b5262c936731b91a2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230726140655eucas1p1c71c8de9edc8441b5262c936731b91a2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230726140655eucas1p1c71c8de9edc8441b5262c936731b91a2
References: <20230726140635.2059334-1-j.granados@samsung.com>
        <CGME20230726140655eucas1p1c71c8de9edc8441b5262c936731b91a2@eucas1p1.samsung.com>
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

In this commit, the size of the ctl_table array is passed to initialize
the ctl_table_size element in the ctl_table_header struct. Although
ctl_table_size is not currently used, this step prepares us for when we
begin traversing the ctl_table array with it. In __register_sysctl_table
we use a calculated size until we add the size argument to that
function.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 884460b0385b..fa1438f1a355 100644
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

