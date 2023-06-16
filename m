Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFAA732ABD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jun 2023 10:59:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234125AbjFPI7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jun 2023 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245031AbjFPI7c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jun 2023 04:59:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F462D7E
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 01:59:30 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230616085928euoutp01187c3ecfe6264a4404ee5f3f6cc43430~pGApfJsmi0259202592euoutp01X
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Jun 2023 08:59:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230616085928euoutp01187c3ecfe6264a4404ee5f3f6cc43430~pGApfJsmi0259202592euoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686905968;
        bh=dg1KPdqa1g30CQqgCK1VP5CwiQO47gFwHbWyH2hvLF4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=VwbANNbpWrZru++AVnexz+2JjOlPP/TkCVDCFtPigSwiRq2kkRx0S8rDHzXNqhzeB
         y/OohgInSBnExpD7FDI5L6QXGoDAM+SbK64bDy82WpcSRdRVupbSngmhqLDegM25Ah
         UwcC8qAfCBW7bkjiYkJCbuhkUCUJa8xUxvekiDV0=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230616085928eucas1p1959b798afec98ae3b8f1a1d3426307d3~pGApXwMii0928509285eucas1p1l;
        Fri, 16 Jun 2023 08:59:28 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 77.45.42423.0742C846; Fri, 16
        Jun 2023 09:59:28 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230616085927eucas1p265c6e3512e3102a7df507da9d3f1f094~pGApH_LI40622606226eucas1p2y;
        Fri, 16 Jun 2023 08:59:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230616085927eusmtrp1dfc1ac545dffb05a28527161c9716660~pGApHafTJ0876708767eusmtrp16;
        Fri, 16 Jun 2023 08:59:27 +0000 (GMT)
X-AuditID: cbfec7f2-a51ff7000002a5b7-35-648c2470551e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 74.2B.10549.F642C846; Fri, 16
        Jun 2023 09:59:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230616085927eusmtip1b502a18d8eb5188582174eccc78b4e8e~pGAo-QwfQ0863908639eusmtip1t;
        Fri, 16 Jun 2023 08:59:27 +0000 (GMT)
Received: from localhost (106.210.248.231) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 16 Jun 2023 09:59:27 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kselftest@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v2 1/8] parport: plug a sysctl register leak
Date:   Fri, 16 Jun 2023 10:59:15 +0200
Message-ID: <20230616085922.3066990-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230616085922.3066990-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.231]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsWy7djP87oFKj0pBsdvsFjs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRXHZpKTmZJalFunbJXBl/N2/l7VghWjFlF1fmBsY
        Lwt2MXJySAiYSFx6tIi5i5GLQ0hgBaPEoi33mSCcL4wSH3dvZ4RwPjNK3Dm1gx2m5eqrJewQ
        ieWMEoe7rzKDJMCqHh9OhUhsZZSYf2sXE0iCTUBH4vybO2BFIgLiEidOb2YEsZkFJjBKzDrE
        AWILC9hIbF53mQ3EZhFQlVg2cQFYL6+ArcTLvQvYIDbLS7Rdnw7WyylgJ/F4UgM7RI2gxMmZ
        T1ggZspLNG+dzQxhS0gcfPECyOYA6lWW+PQ8AWJMrcSpLbfA3pQQOMIh0TvvL9RnLhL7/jxl
        hrCFJV4d3wIVl5E4PbmHBaJhMqPE/n8f2CGc1YwSyxq/MkFUWUu0XHkC1eEoceHXeXaIzXwS
        N94KQhzEJzFp23Sog3glOtqEJjCqzELywiwkL8xC8sICRuZVjOKppcW56anFhnmp5XrFibnF
        pXnpesn5uZsYgUnj9L/jn3Ywzn31Ue8QIxMH4yFGCQ5mJRHeZSe6UoR4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzatueTBYSSE8sSc1OTS1ILYLJMnFwSjUwNS1cZxKe7hM+LYJl++IjBp9/WYW0
        RkmtO3EmYVFgjcolZV9Xfg6TYpaKPQt/tHlOP/sqJkj7pWjF54xml1WZchVf+vP35H7yY3Y1
        YBWd59nj4j2Lzbj2sqSMm7drickkkTqJE3u1A/x9n9h/ruMr2bVcTqi7zbLqQxWvoyvjXien
        VNVTp8Nb09JTbbb7CX9glIqe/nzmh0fmZvvnMdr5SsozfN4+9wwnc8T6tb9vf0pqORjq9t2v
        yq9bcUV8meDtZTvamFqPnNy/rlgkZ/Fz7QD9RcbMer2MUSJZHzWZT6pe9Dlo+/Rz56t8geez
        VcMT93lP+PbtvXyCsLlgig67z58DSkKGa6bw2adUKrEUZyQaajEXFScCAKmkzECJAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7r5Kj0pBluvG1rs2XuSxeLyrjls
        FtPvvGezuDHhKaMDi8emVZ1sHp83yQUwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hka
        m8daGZkq6dvZpKTmZJalFunbJehl/N2/l7VghWjFlF1fmBsYLwt2MXJySAiYSFx9tYS9i5GL
        Q0hgKaPEvgdTGCESMhIbv1xlhbCFJf5c62KDKPrIKHF913lWCGcro8TL+63MIFVsAjoS59/c
        AbNFBMQlTpzeDDaJWWACo8SsQxwgtrCAjcTmdZfZQGwWAVWJZRMXMIHYvAK2Ei/3LmCD2CYv
        0XZ9Olgvp4CdxONJDewgthBQTePtfnaIekGJkzOfsEDMl5do3jqbGcKWkDj44gWQzQE0R1ni
        0/MEiJG1Ep//PmOcwCgyC0n3LCTds5B0L2BkXsUoklpanJueW2yoV5yYW1yal66XnJ+7iREY
        UduO/dy8g3Heq496hxiZOBgPMUpwMCuJ8C470ZUixJuSWFmVWpQfX1Sak1p8iNEU6M2JzFKi
        yfnAmM4riTc0MzA1NDGzNDC1NDNWEuf1LOhIFBJITyxJzU5NLUgtgulj4uCUamDyO/0pWCB+
        19eXcw/pPo/P4LV8l+xRlLLskeZa441iWjPdS7+s2bg0qu2oe1HVjkO2autlm1gSRF52h57g
        emKWrHzk8LMlC465nTW0qmv8Kly68Unz1s5KnpLWvdYxRSxNl478mnPIscGk/qpU5vp8jiD+
        1wcP/vu8xWNFl99CcdHj/rqb9BdVbzKQ4Gd1ln0elP9aftE5jVt5CbXne5QvCthLh5lds++W
        7uru/WD3cqe2+a3JvIeC2ae/2uFns3INZ/uz53+CC9l3TlKanLh/oz57afua5WkrwjdbOiQz
        TQmcWvh7WmDPardAjvobAvEppx8/DetnyRP5voj3rlb3ovXc0z29NTintJZUv1BiKc5INNRi
        LipOBADLOq60MQMAAA==
X-CMS-MailID: 20230616085927eucas1p265c6e3512e3102a7df507da9d3f1f094
X-Msg-Generator: CA
X-RootMTR: 20230616085927eucas1p265c6e3512e3102a7df507da9d3f1f094
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230616085927eucas1p265c6e3512e3102a7df507da9d3f1f094
References: <20230616085922.3066990-1-j.granados@samsung.com>
        <CGME20230616085927eucas1p265c6e3512e3102a7df507da9d3f1f094@eucas1p2.samsung.com>
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

