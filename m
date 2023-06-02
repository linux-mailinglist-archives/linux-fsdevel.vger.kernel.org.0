Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AED71FE90
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 12:08:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbjFBKIX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 06:08:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234328AbjFBKIS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:08:18 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD4CC0
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 03:08:16 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230602100815euoutp02d30c665d6fa84a258f1a08f6d5d03cd5~kz6tMjBgR3163431634euoutp02n
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 10:08:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230602100815euoutp02d30c665d6fa84a258f1a08f6d5d03cd5~kz6tMjBgR3163431634euoutp02n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685700495;
        bh=dg1KPdqa1g30CQqgCK1VP5CwiQO47gFwHbWyH2hvLF4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=oD7Iiq6TlKgPG5zILVOnrh701Qbaxr/VdenbG24kf6qAUKZx8YNgOc2szMKc5qwNk
         y9Dcks/iLrvnNTkjEHFpqIs4pkaKUv7G93ZanITCD/mMXDOzjpRdKrdXdM5gtPWKfW
         VhAg98YLXbdXjiF+xb16+FyzXpBTL3cw++VgsCVw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602100811eucas1p2615b62a4c0f1f1eb5c92db91a20f5a7b~kz6peCK-51569615696eucas1p2v;
        Fri,  2 Jun 2023 10:08:11 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id A2.9D.11320.B8FB9746; Fri,  2
        Jun 2023 11:08:11 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602100810eucas1p12ceafb0c85c74ad2e2e9d96db56786a5~kz6pMSS0V0575805758eucas1p1Q;
        Fri,  2 Jun 2023 10:08:10 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602100810eusmtrp17411fb21898111e0f6efc12dbe8a51a7~kz6pLrVC51803818038eusmtrp1K;
        Fri,  2 Jun 2023 10:08:10 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-f8-6479bf8b0910
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C9.34.14344.A8FB9746; Fri,  2
        Jun 2023 11:08:10 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602100810eusmtip1857d2adad3a20543cd7f090f516540a4~kz6pDIsdH0244502445eusmtip1I;
        Fri,  2 Jun 2023 10:08:10 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 11:08:10 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 1/8] parport: plug a sysctl register leak
Date:   Fri, 2 Jun 2023 12:07:58 +0200
Message-ID: <20230602100805.777917-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602100805.777917-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0iTURjGO9/3bX5bTT7n7cXCaiqSplYU2WViFyINuiATjEqnfurIG7uk
        RkFlaa6s1aTVVLLwxrxQ85KFw7Sa2SJN09aUAtEaZqWpf6goNU+B//3e93mfc97ncGhSOEN5
        0bJ0JStPl6aKuHyq2Tz7LuhaW07iprdfuKGtpi4qtO9ZCTdUN/SLG2rVjKJw6qDRUMA9OGX0
        Pkoc5+9OZFNlZ1h5SFgcP2WhzcTJrHbPLno2TV5AfS5qxKOB2Qpm+ycnNeLTQqYawZXCfA4u
        phGMF9yhcDGFwL5QT/y3XCoaX2IhU4XAPBOF+e9Q51MJNjQiaDB9IR0Cl9kI3eNDS+zGeMJr
        SwNyMMloEOg7aDWiaVdmBxT+2OFoU4wv/KwZ5DhYwOyGadMTCt+7FvI+6pasPEYMlXdHCTzj
        Al33Rih85FrIbSomMQO02+0k9vqApn6eg/k8vGm0EY49gXlJw0PdVYSF/dA0OszF7ApjnY1O
        mNeARXudwgYtgrbFCSdc1CCovDjz71l2weUPI/8ce+B7kZVwJAPGGaw/XPBGznC7WUfitgCu
        5gk1yFe/LIN+WQb9sgxliDQgT1alSEtmFVvS2axghTRNoUpPDk7ISDOivz/Dstg53YKqxiaD
        OxBBow4ENClyEwijsxKFgkRpzllWnhErV6Wyig60mqZEnoJAcVeCkEmWKtnTLJvJyv+rBM3z
        ukAcUM6tz8qUeLdGHbsdq+FIfme+KCwreM/ITio8h7TaEu3nkcVXgqQVEwlfOT0tSq17nvHU
        3B5r7b4a2ispeXvqWLyhW6arq912KmK/wSYedmm5WHxkdm7BorJLwmqr20sfOE+1iCYDbEkp
        P4nnj2729t68H2gqGj406Efbv4XwYrz9vS1BOZFreuoGcpzan9rie9Ru5ZtEde6B4r31/HDz
        4OmQnWVj836HjW0SSdCN6g1MWH7nrO8Ncf+tGL6sIlI/mds/X14z5KFVrlJR1l8R24QD4zYm
        2+g/MnliZuW58G4ftrHeFi19nO/xW73TXLFQyguMzy1YJ7EY+YY4EaVIkW4OIOUK6R99mhIu
        iAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7pd+ytTDB7ONLLYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DL+Lt/L2vBCtGKKbu+MDcwXhbsYuTkkBAwkWia8oapi5GL
        Q0hgKaNE+6Qt7BAJGYmNX66yQtjCEn+udbFBFH1klFh85TojhLOFUaLr+EVmkCo2AR2J82/u
        gNkiAuISJ05vZgSxmQUmMErMOsTRxcjBISxgKdH71hIkzCKgIvFu9W2wBbwCNhJf9m5ngVgm
        L9F2fTpYK6eArcSyGU+ZQGwhoJrzjyYxQ9QLSpyc+YQFYry8RPPW2cwQtoTEwRcvmCHmKEtM
        WPcb6oFaic9/nzFOYBSZhaR9FpL2WUjaFzAyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM
        qG3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeIXCylOEeFMSK6tSi/Lji0pzUosPMZoC/TmRWUo0
        OR8Y03kl8YZmBqaGJmaWBqaWZsZK4ryeBR2JQgLpiSWp2ampBalFMH1MHJxSDUwqMuWKVV6n
        pfxm5nFd2bWxc7nMo/XWPOteHzv3U+bqtoY1PkbhMtFrXHnPSkn4flwUnvKB56hS/99HTwpy
        0xLnZN7ZkvzhletykwaDvFfpOlXK7+tZXjpdT585XdDn3tk4f6EZzzg0zgk1zYl+5aSY/Pap
        c615tVn23eb/O5l3Rk98tafIQGZDQr3GFYWnJrdsjDlen3a4OSdxkkPV0o2vNb5odfuq62kl
        HNjMc5/3udkFxup3BwqZkr/cSGndPy3SrfruLj3HgP1alo2uZlNOnvvAvUJp3p8pxxfJC5hI
        6XQ/cJe0Msww8LeZ1KA0cU/8rKXLpBuirtjsDC28HVC/cPZk5tttb6fq8z1+6aLEUpyRaKjF
        XFScCABEFaACMQMAAA==
X-CMS-MailID: 20230602100810eucas1p12ceafb0c85c74ad2e2e9d96db56786a5
X-Msg-Generator: CA
X-RootMTR: 20230602100810eucas1p12ceafb0c85c74ad2e2e9d96db56786a5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602100810eucas1p12ceafb0c85c74ad2e2e9d96db56786a5
References: <20230602100805.777917-1-j.granados@samsung.com>
        <CGME20230602100810eucas1p12ceafb0c85c74ad2e2e9d96db56786a5@eucas1p1.samsung.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

parport registers two sysctl directories in the parport_proc_register
function but only one of them was getting unregistered in
parport_proc_unregister. Keep track of both sysctl table headers and
handle them together when (un)registering.

Signed-off-by: Joel Granados <j.granados@samsung.com>
---
 drivers/parport/procfs.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index cbb1fb5127ce..0f2d2e1ee28e 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -257,14 +257,16 @@ PARPORT_MAX_SPINTIME_VALUE;
 
 
 struct parport_sysctl_table {
-	struct ctl_table_header *sysctl_header;
+	struct ctl_table_header *port_header;
+	struct ctl_table_header *devices_header;
 	struct ctl_table vars[12];
 	struct ctl_table device_dir[2];
 };
 
 static const struct parport_sysctl_table parport_sysctl_template = {
-	.sysctl_header = NULL,
-        {
+	.port_header = NULL,
+	.devices_header = NULL,
+	{
 		{
 			.procname	= "spintime",
 			.data		= NULL,
@@ -429,7 +431,6 @@ parport_default_sysctl_table = {
 int parport_proc_register(struct parport *port)
 {
 	struct parport_sysctl_table *t;
-	struct ctl_table_header *devices_h;
 	char *tmp_dir_path;
 	size_t tmp_path_len, port_name_len;
 	int bytes_written, i, err = 0;
@@ -464,8 +465,8 @@ int parport_proc_register(struct parport *port)
 		err = -ENOENT;
 		goto exit_free_tmp_dir_path;
 	}
-	devices_h = register_sysctl(tmp_dir_path, t->device_dir);
-	if (devices_h == NULL) {
+	t->devices_header = register_sysctl(tmp_dir_path, t->device_dir);
+	if (t->devices_header == NULL) {
 		err = -ENOENT;
 		goto  exit_free_tmp_dir_path;
 	}
@@ -478,8 +479,8 @@ int parport_proc_register(struct parport *port)
 		goto unregister_devices_h;
 	}
 
-	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
-	if (t->sysctl_header == NULL) {
+	t->port_header = register_sysctl(tmp_dir_path, t->vars);
+	if (t->port_header == NULL) {
 		err = -ENOENT;
 		goto unregister_devices_h;
 	}
@@ -490,7 +491,7 @@ int parport_proc_register(struct parport *port)
 	return 0;
 
 unregister_devices_h:
-	unregister_sysctl_table(devices_h);
+	unregister_sysctl_table(t->devices_header);
 
 exit_free_tmp_dir_path:
 	kfree(tmp_dir_path);
@@ -505,7 +506,8 @@ int parport_proc_unregister(struct parport *port)
 	if (port->sysctl_table) {
 		struct parport_sysctl_table *t = port->sysctl_table;
 		port->sysctl_table = NULL;
-		unregister_sysctl_table(t->sysctl_header);
+		unregister_sysctl_table(t->devices_header);
+		unregister_sysctl_table(t->port_header);
 		kfree(t);
 	}
 	return 0;
-- 
2.30.2

