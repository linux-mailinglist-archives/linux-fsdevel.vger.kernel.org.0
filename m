Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0242708598
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 May 2023 18:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjERQHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 May 2023 12:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjERQHY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 May 2023 12:07:24 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FF7E5F
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 09:07:20 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230518160716euoutp022f8e9135eef86a32d1256eb5b714f369~gSI5KIbiK2879628796euoutp02N
        for <linux-fsdevel@vger.kernel.org>; Thu, 18 May 2023 16:07:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230518160716euoutp022f8e9135eef86a32d1256eb5b714f369~gSI5KIbiK2879628796euoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684426036;
        bh=qnpr39nF9J7epw6jzNpZ1fUsUk/xhReeymYBLnGVUNU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=g/cWRIEZPl7EdE1QyKqqVXWUFQUShpwy6rqNqUpns8El1+rWt7rxu/d2dE/RsL72Y
         qZt2mcjEGDKjPltZbe3MGmgJsUj3aRICpAFCH64P9CgFYKtaX2sY0IaUHEidXkjeif
         Q6foKbNDb5pPGYIJX/pbA6ZxFTQ5V406t6h2A3Hc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230518160716eucas1p27b442cd4b6e5d2f5319735d0e737b041~gSI44xGv52023320233eucas1p2t;
        Thu, 18 May 2023 16:07:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BC.AA.37758.43D46646; Thu, 18
        May 2023 17:07:16 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230518160715eucas1p200672f3771528c6f648704d1c92b578a~gSI4kUYdy1708617086eucas1p2K;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230518160715eusmtrp1a221538d408d4a49a44db986705d49a7~gSI4jzpUu0978909789eusmtrp1b;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-c9-64664d34d268
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 09.5C.14344.33D46646; Thu, 18
        May 2023 17:07:15 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230518160715eusmtip10c9856e37f1a5c03746d5fcba83b148d~gSI4T7A6a2504725047eusmtip1W;
        Thu, 18 May 2023 16:07:15 +0000 (GMT)
Received: from localhost (106.210.248.97) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Thu, 18 May 2023 17:07:14 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        <linux-kernel@vger.kernel.org>, Iurii Zaikin <yzaikin@google.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        <linux-fsdevel@vger.kernel.org>, Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 2/2] sysctl: Remove register_sysctl_table
Date:   Thu, 18 May 2023 18:07:05 +0200
Message-ID: <20230518160705.3888592-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518160705.3888592-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.97]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djPc7omvmkpBk13eC1eH/7EaHGmO9di
        z96TLBaXd81hs7gx4SmjxYHTU5gtzv89zmqxbKefA4fH7IaLLB47Z91l91iwqdRj06pONo/P
        m+Q8Nj15yxTAFsVlk5Kak1mWWqRvl8CVsarjMmPBNemKIwePszYwPhXrYuTkkBAwkZjx7BcT
        iC0ksIJR4ta2gC5GLiD7C6PE1atT2SGcz4wSVw72snYxcoB13L2fANGwnFGi8X4EXM2RfztZ
        IZwtjBLb1i1gBKliE9CROP/mDjOILSIgLnHi9GZGkCJmgZ1MEqdP3GIBSQgLWEqc3j0LrIhF
        QFVixo4mVhCbV8BW4k5HMxvErfISbdengw3lFLCT+L77PDtEjaDEyZlPwOYwA9U0b53NDGFL
        SBx88YIZoldJYvvtmawQdq3EqS23mECOkBD4wSFx89wRqAUuEh3LDzFB2MISr45vYYewZSRO
        T+5hgWiYzCix/98HdghnNaPEssavUB3WEi1XnkB1OErcbvvIDAkwPokbbwUhLuKTmLRtOlSY
        V6KjTWgCo8osJD/MQvLDLCQ/LGBkXsUonlpanJueWmycl1quV5yYW1yal66XnJ+7iRGYfk7/
        O/51B+OKVx/1DjEycTAeYpTgYFYS4Q3sS04R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzqttezJZ
        SCA9sSQ1OzW1ILUIJsvEwSnVwOTK90q+tVcmqubeVgf1pyoKM9rsa9js3wn73ztw1NvpQcXB
        5t1vD+m+OWJrPCPr/2+NK8mpuZFVjrKyfprNVvLL1t36aMZ90T3ijMKO0MrzRvt/BX+f9OHR
        0uYqmzsPM//sC0z4ueRsRb/A7AXdwe9uf+m6rabx76LD6yXSe4X2t63tktDxPalzPYrN3yZj
        sgCz0eFzM8o2yC5IesAoW9TlscU7ZOOy0xyTV1enquyYLDpjCUNTQ6rZBIHHjm13jPh1Ewuf
        Lopd7JGzpWaKI7N5zarU9rD2oj1Xt/y+mnLGdmb086sVwvqnC41rF5rptjxuEhGUuqX5of+z
        YoeW9mPuM0wBjnPPF9p31rw4osRSnJFoqMVcVJwIACVyTVGuAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7rGvmkpBhM/mlq8PvyJ0eJMd67F
        nr0nWSwu75rDZnFjwlNGiwOnpzBbnP97nNVi2U4/Bw6P2Q0XWTx2zrrL7rFgU6nHplWdbB6f
        N8l5bHrylimALUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7Ms
        tUjfLkEvY1XHZcaCa9IVRw4eZ21gfCrWxcjBISFgInH3fkIXIxeHkMBSRont7Z1MXYycQHEZ
        iY1frrJC2MISf651sUEUfWSUaD93lRnC2cIoMfn9LbAONgEdifNv7jCD2CIC4hInTm9mBCli
        FtjJJLHi3mSwUcIClhKnd88CK2IRUJWYsaMJLM4rYCtxp6OZDWKdvETb9emMIDangJ3E993n
        2UFsIaCaSwuXQNULSpyc+YQFxGYGqm/eOpsZwpaQOPjiBTPEHCWJ7bdnQr1QK/H57zPGCYwi
        s5C0z0LSPgtJ+wJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiB0bnt2M8tOxhXvvqod4iR
        iYPxEKMEB7OSCG9gX3KKEG9KYmVValF+fFFpTmrxIUZToD8nMkuJJucD00NeSbyhmYGpoYmZ
        pYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOTXny/D68ku8iLSRIXCu4VZccLBla1
        Zx38sM736ym3bL7pcoYsLtuZ715bs1+FdZlutqdH/KLFOz+pXnGfeqJjgq1r9587BRWTcnis
        +LeqV95YBDSqqWreLNmZnhcbW+x2B/P82rvz4KmVXvZ7+46f3DIrTJhna/DKc7e1jVdrrwzv
        nPFVxWXf11+MOSs9JBOmzJ0orDlpu/wpBznjV1LnL21q/CS6e27RpB/GorNufk+8Kn/QWcos
        /e4KDZ9vv6RPc3r/28/d9j/rU5P4btcbbJH8AadsAktkjvhw/ypTYY3Qdzi7Y6ZEWPTvZy3m
        BW29lw5n/3hZ/yxskq9Hq33x0pzX9bvuMLGJtO5qa1BiKc5INNRiLipOBAAY41eJVwMAAA==
X-CMS-MailID: 20230518160715eucas1p200672f3771528c6f648704d1c92b578a
X-Msg-Generator: CA
X-RootMTR: 20230518160715eucas1p200672f3771528c6f648704d1c92b578a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230518160715eucas1p200672f3771528c6f648704d1c92b578a
References: <20230518160705.3888592-1-j.granados@samsung.com>
        <CGME20230518160715eucas1p200672f3771528c6f648704d1c92b578a@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. After removing all the calling functions, we
remove both the register_sysctl_table function and the documentation
check that appeared in check-sysctl-docs awk script.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 fs/proc/proc_sysctl.c     | 70 ---------------------------------------
 scripts/check-sysctl-docs | 10 ------
 2 files changed, 80 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index f8f19e000d76..7bc7d3c3a215 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1574,76 +1574,6 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 	return err;
 }
 
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

