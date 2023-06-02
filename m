Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA0C720006
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jun 2023 13:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235637AbjFBLHD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Jun 2023 07:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235054AbjFBLHA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Jun 2023 07:07:00 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7C9E5A
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 04:06:43 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230602110642euoutp02b19e8efd9398fe19450c26d69c63aa0a~k0tvts8gt3126531265euoutp02C
        for <linux-fsdevel@vger.kernel.org>; Fri,  2 Jun 2023 11:06:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230602110642euoutp02b19e8efd9398fe19450c26d69c63aa0a~k0tvts8gt3126531265euoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685704002;
        bh=dg1KPdqa1g30CQqgCK1VP5CwiQO47gFwHbWyH2hvLF4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=A5l5Dp0AsTr1RIc34FVHNsJfLaUAnmSusVxKX4qlpPDDurxAOdbh1gL/bxyZT60FW
         dRdjS4AmmB+5TM8/8NyzSsuCdKGehSeXb1pujSUbG5qikEDDFk6ZUNW3/MiShXO6cX
         CjZ9Ui6kS5VV9nwpGeUxyr6IFWJaId1SrKp8yUJw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230602110642eucas1p25278f4b80e5bc361bc1250e3a0a178a9~k0tvex7YG0783007830eucas1p2J;
        Fri,  2 Jun 2023 11:06:42 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.67.11320.24DC9746; Fri,  2
        Jun 2023 12:06:42 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110641eucas1p1e2e92293c385e8083ed104dbb96aa68b~k0tvCWeV_0085500855eucas1p1d;
        Fri,  2 Jun 2023 11:06:41 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230602110641eusmtrp19ef6e4a22f40bb673b99d0be0320a9a5~k0tvB3wJ52194821948eusmtrp1R;
        Fri,  2 Jun 2023 11:06:41 +0000 (GMT)
X-AuditID: cbfec7f4-993ff70000022c38-69-6479cd42acc8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id C3.A9.10549.14DC9746; Fri,  2
        Jun 2023 12:06:41 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230602110641eusmtip19329dc84f1680badc901c2cba72579b5~k0tu5IEoL3230032300eusmtip19;
        Fri,  2 Jun 2023 11:06:41 +0000 (GMT)
Received: from localhost (106.210.248.205) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Fri, 2 Jun 2023 12:06:41 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kselftest@vger.kernel.org>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH 1/8] parport: plug a sysctl register leak
Date:   Fri, 2 Jun 2023 13:06:31 +0200
Message-ID: <20230602110638.789426-2-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602110638.789426-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.205]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7djPc7pOZytTDL4f5LPYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgiuKySUnNySxLLdK3S+DK+Lt/L2vBCtGKKbu+MDcw
        XhbsYuTkkBAwkeg9OYm1i5GLQ0hgBaPEge4LTBDOF0aJNW9Ps0M4nxklNjYcYIZpmfEDpmU5
        o8TK53fY4KpefV/LDOFsYZRoWf+IFaSFTUBH4vybO2DtIgLiEidOb2YEKWIWmMAo0bfuF0sX
        IweHsIClRO9bSxCTRUBF4uo/H5ByXgEbiSfr37JBbJaXaLs+nRHE5hSwlTh0+gwbRI2gxMmZ
        T1hAbGagmuats5khbAmJgy9eQF2tLDFh3W9WCLtW4tSWW2B/Sggc4ZCY83ceE0TCRaL51AZ2
        CFtY4tXxLVC2jMTpyT0sEA2TGSX2//vADuGsZpRY1vgVqttaouXKE6gOR4kn/9ezg3wjIcAn
        ceOtIMRFfBKTtk1nhgjzSnS0CU1gVJmF5IdZSH6YheSHBYzMqxjFU0uLc9NTi43yUsv1ihNz
        i0vz0vWS83M3MQLTxul/x7/sYFz+6qPeIUYmDsZDjBIczEoivEJh5SlCvCmJlVWpRfnxRaU5
        qcWHGKU5WJTEebVtTyYLCaQnlqRmp6YWpBbBZJk4OKUamKyaXGtTZaV2vc42NbX4mdexpFko
        zX3WX237EpNMTz3XhuuPRVavvxBgt4z34KdI/qsdbxTumCoYvFo/dcI9rbm9FmEOmf8YVsrV
        Ln/G93FDbOXHmxq7Inads7nS1LlZpMF6u8dS29RdyguvPFmp5PO9u/POu1u25SYHzSXv/frU
        lPw7WXH+3Wf7du+Rn3lY22RVQUXZRquvx1bFnl908J7pqT8RX/+8W+rwTvFT56UlgYKLs4Mv
        npzMbp5konxg8b9mRnv9XD/ZE0UJUzjztxksj34k9/Sdrzvn7luMudlMmrdZ+abwr53y0eC+
        wZWT2b//HBSuucx1N6zt7GWPa+aR7CFPrW6evjp9Xs9S9zIlluKMREMt5qLiRACIk5eWigMA
        AA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHIsWRmVeSWpSXmKPExsVy+t/xu7qOZytTDP5ONrDYs/cki8XlXXPY
        LKbfec9mcWPCU0YHFo9NqzrZPD5vkgtgitKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx1DM0
        No+1MjJV0rezSUnNySxLLdK3S9DL+Lt/L2vBCtGKKbu+MDcwXhbsYuTkkBAwkZjxYxJrFyMX
        h5DAUkaJvtPn2CESMhIbv1xlhbCFJf5c62KDKPrIKNE48yALhLOFUeJ+4yFGkCo2AR2J82/u
        MIPYIgLiEidOb2YEKWIWmAA0dt0voA4ODmEBS4net5YgJouAisTVfz4g5bwCNhJP1r9lg1gm
        L9F2fTrYSE4BW4lDp8+AxYWAatafucAOUS8ocXLmExYQmxmovnnrbGYIW0Li4IsXzBBzlCUm
        rPsN9UCtxOe/zxgnMIrMQtI+C0n7LCTtCxiZVzGKpJYW56bnFhvqFSfmFpfmpesl5+duYgRG
        1LZjPzfvYJz36qPeIUYmDsZDjBIczEoivEJh5SlCvCmJlVWpRfnxRaU5qcWHGE2B3pzILCWa
        nA+M6bySeEMzA1NDEzNLA1NLM2MlcV7Pgo5EIYH0xJLU7NTUgtQimD4mDk6pBqbJBevyHnhH
        Rb2W3iZ7I2nd0+43/8NXrijguFnDlf555kSvHunHriv3qIV6rWLMu3uqwFJMYL+TSwb7+eba
        Y7O3h7S+7fskMKOgIkx5Z4KlqsHb2g0G08pdsg0aVk82WeauGf591272Lc1xHx7oT9jzoTT9
        fUZg3h7bqxEa6+Q/HvjxVOeJ+XOv5SuaGjLOLNlvynVmlxPvUuVW+wCd2eYzdUS2LpOYJVBw
        JW2KzI5zj289XvmvewvPsVaT/4d8K/v4yhQ+x9hNi2PsvSq87LBBgIcv+/LYg9Y+pseCxbia
        J700mpd7zNqOnd/zFg+rxpm5v/bvvNI9PTZm+rQAuSxtxxOmznckPP+kKc5QYVFiKc5INNRi
        LipOBADcb+IRMQMAAA==
X-CMS-MailID: 20230602110641eucas1p1e2e92293c385e8083ed104dbb96aa68b
X-Msg-Generator: CA
X-RootMTR: 20230602110641eucas1p1e2e92293c385e8083ed104dbb96aa68b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230602110641eucas1p1e2e92293c385e8083ed104dbb96aa68b
References: <20230602110638.789426-1-j.granados@samsung.com>
        <CGME20230602110641eucas1p1e2e92293c385e8083ed104dbb96aa68b@eucas1p1.samsung.com>
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

