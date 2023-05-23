Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F6970DC78
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236638AbjEWMW5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjEWMWi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:38 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF35118
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:36 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122235euoutp02bc9529660297c7f85948aa85bcdff46b~hxTJVAQln1933219332euoutp02Q
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230523122235euoutp02bc9529660297c7f85948aa85bcdff46b~hxTJVAQln1933219332euoutp02Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844555;
        bh=v2sIuTREWESn0gsMOClVzbRDY2pax45rUY1W/tjn7s4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=D4TtrJVdeWPayDfy7Y2mYgm5l3S8Rw83j0YPi+mqRwcosLmJfrmmipxRIY6UI6FT0
         mXrbnTtAF57ctb4P1iO2VDA36thze1OatPOoz0vCSLMzwPtHHzlXWTbsu3QEylT2w5
         PLhHsBsB2PiDWZQJ5YcQ46vUXRu3yng5zhmb6294=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122235eucas1p1381da8014c498ee425898795449b6a5f~hxTJDyHyG2656126561eucas1p1N;
        Tue, 23 May 2023 12:22:35 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FC.16.11320.B00BC646; Tue, 23
        May 2023 13:22:35 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122235eucas1p1398322259883bb53846e3445d7fd1cc6~hxTI07Co41810218102eucas1p1X;
        Tue, 23 May 2023 12:22:35 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122235eusmtrp2e8da0bab32b20140f5290240dec198ba~hxTI0YfQ-0682106821eusmtrp2Y;
        Tue, 23 May 2023 12:22:35 +0000 (GMT)
X-AuditID: cbfec7f4-97dff70000022c38-a6-646cb00b9963
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 39.81.14344.A00BC646; Tue, 23
        May 2023 13:22:34 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122234eusmtip1e769166eaaa94c9881830fb125f45785~hxTIpP3Oo1420014200eusmtip11;
        Tue, 23 May 2023 12:22:34 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:34 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 6/8] sysctl: stop exporting register_sysctl_table
Date:   Tue, 23 May 2023 14:22:18 +0200
Message-ID: <20230523122220.1610825-7-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87rcG3JSDJZ08Fu8PvyJ0eJMd67F
        nr0nWSwu75rDZnFjwlNGiwOnpzBbnP97nNVi2U4/Bw6P2Q0XWTx2zrrL7rFgU6nHplWdbB6f
        N8l5bHrylimALYrLJiU1J7MstUjfLoEr43n/QpaCzQoV/96sZG1gfCzZxcjJISFgItG3+AJ7
        FyMXh5DACkaJuRsPMEM4XxgldnXfZ4JwPjNK3Gg7xwzTcunjeUaIxHJGiS3bDrDDVV280ArV
        v4VR4s+PHawgLWwCOhLn39wBaxcREJc4cXozWDuzwE4mif7OW2wgCWEBF4m2s68YQWwWAVWJ
        nict7CA2r4CtxL5XbSwQu+Ul2q5PB6vhFLCTOPRsHytEjaDEyZlPwGqYgWqat85mhrAlJA6+
        eAF1t5LE6q4/bBB2rcSpLbeYIOwvHBLdj2wgbBeJI3/6oOqFJV4d38IOYctI/N85HxwYEgKT
        GSX2//vADuGsZpRY1vgVapK1RMuVJ1AdjhJnLjwEuo4DyOaTuPFWEOIgPolJ26YzQ4R5JTra
        hCYwqsxC8sIsJC/MQvLCAkbmVYziqaXFuempxUZ5qeV6xYm5xaV56XrJ+bmbGIEp6PS/4192
        MC5/9VHvECMTB+MhRgkOZiUR3hPl2SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEebVtTyYLCaQn
        lqRmp6YWpBbBZJk4OKUamAqe2atLJAcyZl5daTrzwZqlW1YwxjRlSdzZZvpKrGT5vvI+FaeH
        VXJ7+M6y6YQ/OfT4k9GDtA9zdB4nn2Zg7vt/YdaiYzNZr+h3y3Rk9UdXnNqqkOps/1g7w9Bl
        w4tOnr3WF0682nXY9HxGiLr035hta9v4rjS2CjJysDueb4tKaXEU8bf7Z7VG8XzAe4GovY8Z
        3y4XPfImSNArbrpOf/6i6+dmGOxZVfeZLZyDd9vXLQfiXm37t7CTjU8yYh5TnbrZpu6Jpt0J
        /F1TNuo/EPA5udH66dK9L/namhSyPF62GK+Rn7R7+aKezVNt1x7SO8QQE3J5z7PzGcK7Re4u
        VKk7vX2ex6r/lgyKjhNOlCmxFGckGmoxFxUnAgBFe09PsAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7pcG3JSDI6esLJ4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexvP+hSwFmxUq/r1ZydrA+Fiyi5GTQ0LAROLSx/OMXYxcHEICSxklFjz9ygqRkJHY
        +OUqlC0s8edaFxtE0UdGiVvbX7BAOFsYJbpPLGIGqWIT0JE4/+YOmC0iIC5x4vRmsLHMAtuZ
        JCb83cUGkhAWcJFoO/uKEcRmEVCV6HnSwg5i8wrYSux71cYCsU5eou36dLAaTgE7iUPP9oGd
        IQRU0/pqEytEvaDEyZlPwOqZgeqbt85mhrAlJA6+eMEMMUdJYnXXHzYIu1bi899njBMYRWYh
        aZ+FpH0WkvYFjMyrGEVSS4tz03OLjfSKE3OLS/PS9ZLzczcxAuNz27GfW3Ywrnz1Ue8QIxMH
        4yFGCQ5mJRHeE+XZKUK8KYmVValF+fFFpTmpxYcYTYH+nMgsJZqcD0wQeSXxhmYGpoYmZpYG
        ppZmxkrivJ4FHYlCAumJJanZqakFqUUwfUwcnFINTHN9DqwKu5Sxoddd1d7HZrbLo24xrl1/
        1EWUnI3aCzcfW+yykcX1qg2zrnCW/Txe0eonF7lW6c00W6dWdETsCVe9XJv2resXc/w1LB9/
        jjdZFBL/NuKjR9oeQS8uL2czO+X0lhVaC+zCvb7yb7Dn37Jz89Ibk1b4JH7V3r6IuUene+eZ
        YqEveyb8+dRw2GGdpepd9bA/E70OTsoS2HiOLVn80P2dWRIro+1Mrqw+K3Q1/U3SqasBPpct
        772aGHhSy0nSvXy5xw5Bi85sg+n6iqUf42+GqPBwrFziwC2j8cLgXMxyxuCHAn8StbsOPTus
        qzPp6fW8ogc3vl0y+CijEZJnfE92/1qDUmm+tR83KLEUZyQaajEXFScCAAPSXlJYAwAA
X-CMS-MailID: 20230523122235eucas1p1398322259883bb53846e3445d7fd1cc6
X-Msg-Generator: CA
X-RootMTR: 20230523122235eucas1p1398322259883bb53846e3445d7fd1cc6
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122235eucas1p1398322259883bb53846e3445d7fd1cc6
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122235eucas1p1398322259883bb53846e3445d7fd1cc6@eucas1p1.samsung.com>
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

We make register_sysctl_table static because the only function calling
it is in fs/proc/proc_sysctl.c (__register_sysctl_base). We remove it
from the sysctl.h header and modify the documentation in both the header
and proc_sysctl.c files to mention "register_sysctl" instead of
"register_sysctl_table".

This plus the commits that remove register_sysctl_table from parport
save 217 bytes:

./scripts/bloat-o-meter .bsysctl/vmlinux.old .bsysctl/vmlinux.new
add/remove: 0/1 grow/shrink: 5/1 up/down: 458/-675 (-217)
Function                                     old     new   delta
__register_sysctl_base                         8     286    +278
parport_proc_register                        268     379    +111
parport_device_proc_register                 195     247     +52
kzalloc.constprop                            598     608     +10
parport_default_proc_register                 62      69      +7
register_sysctl_table                        291       -    -291
parport_sysctl_template                     1288     904    -384
Total: Before=8603076, After=8602859, chg -0.00%

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c  | 5 ++---
 include/linux/sysctl.h | 8 +-------
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 8038833ff5b0..f8f19e000d76 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1582,7 +1582,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  * array. A completely 0 filled entry terminates the table.
  * We are slowly deprecating this call so avoid its use.
  */
-struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
+static struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 {
 	struct ctl_table *ctl_table_arg = table;
 	int nr_subheaders = count_subheaders(table);
@@ -1634,7 +1634,6 @@ struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 	header = NULL;
 	goto out;
 }
-EXPORT_SYMBOL(register_sysctl_table);
 
 int __register_sysctl_base(struct ctl_table *base_table)
 {
@@ -1700,7 +1699,7 @@ static void drop_sysctl_table(struct ctl_table_header *header)
 
 /**
  * unregister_sysctl_table - unregister a sysctl table hierarchy
- * @header: the header returned from register_sysctl_table
+ * @header: the header returned from register_sysctl or __register_sysctl_table
  *
  * Unregisters the sysctl table and all children. proc entries may not
  * actually be removed until they are no longer used by anyone.
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 3d08277959af..218e56a26fb0 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -89,7 +89,7 @@ int proc_do_static_key(struct ctl_table *table, int write, void *buffer,
 		size_t *lenp, loff_t *ppos);
 
 /*
- * Register a set of sysctl names by calling register_sysctl_table
+ * Register a set of sysctl names by calling register_sysctl
  * with an initialised array of struct ctl_table's.  An entry with 
  * NULL procname terminates the table.  table->de will be
  * set up by the registration and need not be initialised in advance.
@@ -222,7 +222,6 @@ struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, struct ctl_table *table);
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
-struct ctl_table_header *register_sysctl_table(struct ctl_table * table);
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
@@ -257,11 +256,6 @@ static inline int __register_sysctl_base(struct ctl_table *base_table)
 
 #define register_sysctl_base(table) __register_sysctl_base(table)
 
-static inline struct ctl_table_header *register_sysctl_table(struct ctl_table * table)
-{
-	return NULL;
-}
-
 static inline void register_sysctl_init(const char *path, struct ctl_table *table)
 {
 }
-- 
2.30.2

