Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E353D7025D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 May 2023 09:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240614AbjEOHO5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 May 2023 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238046AbjEOHOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 May 2023 03:14:54 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B09F10D0
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 00:14:51 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230515071449euoutp0169c7ae168f13c5a41c703af9f093ed49~fP8JpDPdc1812418124euoutp01c
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 May 2023 07:14:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230515071449euoutp0169c7ae168f13c5a41c703af9f093ed49~fP8JpDPdc1812418124euoutp01c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684134889;
        bh=VAk6TpM5IbKUpQQhFBk2UGIdnFppAQ7wqb8uoAZJtes=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=f66YVTCPlN0DaQXaZ7ajyLmTl6XlYQBRBi6kCseq//I6Pcj/Jz0Xr77i0IxHg9lLI
         hzkK6fL1JAn7nlSjXtXPYwQkxyu3H0VIy7XDjYMVmiozz+grv46ptRm0vwcQaleqC8
         ve9TnNU4VXju9iEx3zwZyWDtmcIvK7kVmKDeHo4g=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230515071449eucas1p13f9ff6100ef94d232dbaec876abe4e16~fP8JewOjz1419414194eucas1p1m;
        Mon, 15 May 2023 07:14:49 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0C.71.42423.9EBD1646; Mon, 15
        May 2023 08:14:49 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230515071449eucas1p172217753f35fed55c4d2f0a419e258dd~fP8JMgkGj1418614186eucas1p1o;
        Mon, 15 May 2023 07:14:49 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230515071449eusmtrp15af38073a005c64773a77ba07a6d3b0a~fP8JL4N8v2274622746eusmtrp1f;
        Mon, 15 May 2023 07:14:49 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-8a-6461dbe913b4
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 1D.07.10549.9EBD1646; Mon, 15
        May 2023 08:14:49 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230515071449eusmtip2c42180c0ac1a13a187e028aedc62234b~fP8I_nN8T2082520825eusmtip2-;
        Mon, 15 May 2023 07:14:49 +0000 (GMT)
Received: from localhost (106.110.32.133) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Mon, 15 May 2023 08:14:48 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Iurii Zaikin <yzaikin@google.com>,
        Kees Cook <keescook@chromium.org>,
        <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 1/6] parport: Move magic number "15" to a define
Date:   Mon, 15 May 2023 09:14:41 +0200
Message-ID: <20230515071446.2277292-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230515071446.2277292-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.110.32.133]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzned2XtxNTDFq/qVuc6c612LP3JIvF
        5V1z2CxuTHjKaHHg9BRmi2U7/RzYPGY3XGTx2DnrLrvHgk2lHptWdbJ5fN4kF8AaxWWTkpqT
        WZZapG+XwJXx61pZwRrOigXLj7E2MN5l72Lk4JAQMJGYvTqii5GLQ0hgBaPEiR3trBDOF0aJ
        LVOnskM4nxkl2ietZe5i5ATruP93DVRiOaPE0genWeCqGpctZgKpEhLYwiixZCIviM0moCNx
        /s0dsG4RAXGJE6c3M4I0MAs8ZZSY+68XrEFYwEFiweqbLCA2i4CqxKs/J9hAbF4BW4mjx1sZ
        IVbLS7Rdnw5mcwrYSazbf5QJokZQ4uTMJ2C9zEA1zVtnM0PYEhIHX7yAOltJ4uubXlYIu1bi
        1JZbTCBHSAjc4ZCYcHoCO0TCReL1x9tQRcISr45vgYrLSJye3MMC0TCZUWL/vw/sEM5qRoll
        jV+ZIKqsJVquPIHqcJSY//4TKySM+SRuvBWEuIhPYtK26cwQYV6JjjahCYwqs5D8MAvJD7OQ
        /LCAkXkVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYII5/e/4px2Mc1991DvEyMTBeIhR
        goNZSYS3fWZ8ihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFebduTyUIC6YklqdmpqQWpRTBZJg5O
        qQYmj81GDf5+UTNvZew6JzJNg3nilpmL3itaJ62eaim+89GDbWmMPEHKE5j8tG4qVcYtY0uW
        2bfZ4F3Fo6IF/X5SrrlpTH2Lq/IM91scVS1frDdt/RO7kLyOX0qFBzpzT/GdeO7K89pnk9Lh
        l5UmLwxF1kZasigbzT5q2K2dPefVHatWxaXzE84HrXyf7xO+4qFQwqQ/70/mt3GpzDjllyc4
        eYrr//PzVi58ucHF6/sBX+Xp31XmvS5R4Jz8IdBszikbzpM+e7WEEq93OAbve1qiyqDl6R60
        2dX/xYVyoYseMacVio/dMFa4L1p16edkh3T7Bf7Cuv8l5tt5yPhsnTvHzFf/W+6BCQnfZs8M
        P1WsxFKckWioxVxUnAgAympLQJ8DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xe7ovbyemGDStELE4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS/j17WygjWcFQuW
        H2NtYLzL3sXIySEhYCJx/+8aIJuLQ0hgKaPE/PvnoRIyEhu/XGWFsIUl/lzrYgOxhQQ+Mkpc
        3ykA0bCFUeLG1OXMIAk2AR2J82/ugNkiAuISJ05vZgQpYhZ4yigx89BTJpCEsICDxILVN1lA
        bBYBVYlXf06ATeUVsJU4eryVEWKbvETb9elgNqeAncS6/UeZIDbbSpzetY0Vol5Q4uTMJ2Bz
        mIHqm7fOZoawJSQOvnjBDDFHSeLrm16oD2olPv99xjiBUWQWkvZZSNpnIWlfwMi8ilEktbQ4
        Nz232FCvODG3uDQvXS85P3cTIzD6th37uXkH47xXH/UOMTJxMB5ilOBgVhLhbZ8ZnyLEm5JY
        WZValB9fVJqTWnyI0RToz4nMUqLJ+cD4zyuJNzQzMDU0MbM0MLU0M1YS5/Us6EgUEkhPLEnN
        Tk0tSC2C6WPi4JRqYOKQT7yzum7p69SYnqtBRVcf7ot22JNVwfFJn+nK2bASS/WTNydnyc6O
        n7hh4t4n6wvsitIP3H0hdJb94twEy36/Sae4Osusvqb6KF8OjagrO1+xnfn5uUOzd/7L+D9J
        5sf6vcJW1qnuF5Zo6Sel2wZ/Cdmmvmntm4r4Fblf7kR7dosEXOm+bhOp1dd41Xvu0W79CXIq
        ZhuCGjZVL9GX89f5uVyoiud+bGngnrDyUzKKk2xldvmL2XH1N9X/mac2S+N7fYw+o61x/2b2
        DzN5vabvYi7fkJzLZSd3I9ZxReDpYJdv75bN/NASuKjWyDS8WO8Jw4POefXGJxiE3tROvZDf
        94Kj5Mu7g4v2cCm2K7EUZyQaajEXFScCAA+kUmFHAwAA
X-CMS-MailID: 20230515071449eucas1p172217753f35fed55c4d2f0a419e258dd
X-Msg-Generator: CA
X-RootMTR: 20230515071449eucas1p172217753f35fed55c4d2f0a419e258dd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230515071449eucas1p172217753f35fed55c4d2f0a419e258dd
References: <20230515071446.2277292-1-j.granados@samsung.com>
        <CGME20230515071449eucas1p172217753f35fed55c4d2f0a419e258dd@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Put the size of a parport name behind a define so we can use it in other
files. This is a preparation patch to be able to use this size in
parport/procfs.c.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/share.c | 2 +-
 include/linux/parport.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/parport/share.c b/drivers/parport/share.c
index 62f8407923d4..2d46b1d4fd69 100644
--- a/drivers/parport/share.c
+++ b/drivers/parport/share.c
@@ -467,7 +467,7 @@ struct parport *parport_register_port(unsigned long base, int irq, int dma,
 	atomic_set(&tmp->ref_count, 1);
 	INIT_LIST_HEAD(&tmp->full_list);
 
-	name = kmalloc(15, GFP_KERNEL);
+	name = kmalloc(PARPORT_NAME_MAX_LEN, GFP_KERNEL);
 	if (!name) {
 		kfree(tmp);
 		return NULL;
diff --git a/include/linux/parport.h b/include/linux/parport.h
index a0bc9e0267b7..243c82d7f852 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -180,6 +180,8 @@ struct ieee1284_info {
 	struct semaphore irq;
 };
 
+#define PARPORT_NAME_MAX_LEN 15
+
 /* A parallel port */
 struct parport {
 	unsigned long base;	/* base address */
-- 
2.30.2

