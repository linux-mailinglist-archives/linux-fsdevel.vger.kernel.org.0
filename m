Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182D770DC70
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236827AbjEWMWh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236819AbjEWMWf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:35 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9C8E118
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:31 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122230euoutp02198fa97e7655cfe800e2792a3ca7937f~hxTE1F7JP1837818378euoutp02c
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230523122230euoutp02198fa97e7655cfe800e2792a3ca7937f~hxTE1F7JP1837818378euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844550;
        bh=j+VnUb9JQ+kzpZedqCGPxjM1mMBuEtsRpF6yMVfDErY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=T49qgprvCGnQ3MLp1hms8PleBrGrtYoVAhE7XK1s+Fcwgyao2Vka+R3D0hyPrCrIn
         lGUkiUHXW1zpBuDAuy8hLy57+iu2ROAifKbBWUkgW2w1E1tjZwpfb4jnhyekctAu6U
         pO8h9jtIlyH0IcVMb3QI1nKVjcM70g2JkraF1ZM0=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230523122229eucas1p2be7fc25e0e5ea0a0ed20256ecdd12fe2~hxTD_LcMm0066500665eucas1p2w;
        Tue, 23 May 2023 12:22:29 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id BD.3E.37758.500BC646; Tue, 23
        May 2023 13:22:29 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122229eucas1p2ea47c3d872cc7dd6f52de85e2e304b8c~hxTDm4hVA3086230862eucas1p2s;
        Tue, 23 May 2023 12:22:29 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122229eusmtrp2da5183f1bf8c7967c6891bf8833301f7~hxTDmC-kG0682106821eusmtrp2K;
        Tue, 23 May 2023 12:22:29 +0000 (GMT)
X-AuditID: cbfec7f5-815ff7000002937e-4a-646cb005461e
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id F8.BF.10549.500BC646; Tue, 23
        May 2023 13:22:29 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122229eusmtip18bdb46ee0d6d94da7afbe5e83be05569~hxTDbWzc71745417454eusmtip13;
        Tue, 23 May 2023 12:22:29 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:28 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 3/8] parport: Remove register_sysctl_table from
 parport_device_proc_register
Date:   Tue, 23 May 2023 14:22:15 +0200
Message-ID: <20230523122220.1610825-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsWy7djP87qsG3JSDN7f1bF4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXxvOpd9kLZkpVrFu0krWB8ZZoFyMnh4SAiUTn73fs
        ILaQwApGickPLLsYuYDsL4wSv++1M0E4nxklHj66wg7TcfbHKhaIxHJGiZkrnrPBVe3bd54J
        YtYWRolN06JAbDYBHYnzb+4wg9giAuISJ05vZgRpYBbYySTR33mLDSQhLJAosfXbBDCbRUBV
        ovnmT7AGXgFbiZs7TrNCrJaXaLs+nRHE5hSwkzj0bB8rRI2gxMmZT1hAbGagmuats5khbAmJ
        gy9eMEP0Kkms7vrDBmHXSpzacosJwv7PIbHuczKE7SJx8Ml+RghbWOLV8S1QL8tI/N85HxwW
        EgKTGSX2//vADuGsZpRY1vgVapK1RMuVJ1AdjhLvP2wC2swBZPNJ3HgrCHEQn8SkbdOhwrwS
        HW1CExhVZiF5YRaSF2YheWEBI/MqRvHU0uLc9NRi47zUcr3ixNzi0rx0veT83E2MwPRz+t/x
        rzsYV7z6qHeIkYmD8RCjBAezkgjvifLsFCHelMTKqtSi/Pii0pzU4kOM0hwsSuK82rYnk4UE
        0hNLUrNTUwtSi2CyTBycUg1MNl7le3OcbFhmVca5CnBxP+HaLRGemV+3W/JzqeejC+5Wa9mW
        8ihrtb00OiPgL3l/xoaPymk+pcEMTxdfK57gtEj92KWGt/fPaDsaxP1f/cc5aPPVhfpHbEPP
        dny9tcXI84bSvA95nh9n/rOZ++10zqRJvxYwlPlK60RJfgrc/Clobp+cmXKksjlz54WvFRdj
        w1qPWr375b/NqERFwWbi8oTJG5XE7tvua3VY35N8I2RO6dcLJxuUgQHUabDhTVBoTNb80C31
        abuvXI1yndOwaGridSY3vU0sWxU+rRPIXrxrtrPXo8/SHXE99wvanUtbHqSsmbLj246nXnqb
        pooELqsrerLh2dWptTMLfh1XYinOSDTUYi4qTgQAw+qWx64DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7qsG3JSDG79EbF4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJexvOpd9kLZkpVrFu0krWB8ZZoFyMnh4SAicTZH6tYuhi5OIQEljJKbNtyggUiISOx
        8ctVVghbWOLPtS42iKKPjBJfvrxgBEkICWxhlLiw1ADEZhPQkTj/5g4ziC0iIC5x4vRmRpAG
        ZoHtTBIT/u5iA0kIC8RL7P65BGwqi4CqRPPNn2ANvAK2Ejd3nIbaJi/Rdn062AJOATuJQ8/2
        sUIss5VofbWJFaJeUOLkzCdglzID1Tdvnc0MYUtIHHzxghlijpLE6q4/bBB2rcTnv88YJzCK
        zELSPgtJ+ywk7QsYmVcxiqSWFuem5xYb6hUn5haX5qXrJefnbmIERue2Yz8372Cc9+qj3iFG
        Jg7GQ4wSHMxKIrwnyrNThHhTEiurUovy44tKc1KLDzGaAv05kVlKNDkfmB7ySuINzQxMDU3M
        LA1MLc2MlcR5PQs6EoUE0hNLUrNTUwtSi2D6mDg4pRqYStgk2l075E/2vFixdt57G4Hzrpum
        fhZZu/7ET/YJqbtFF1u8fLZ/m9pEl4Zv5ubz3h7ufbi86q1cfrD0sj07Z4bf+nP013L+6Pee
        XwN/OdUX3Cr1/7fhhPt0ZuaXc4uqu8uK3CdP5FHKvX7m3t78xWtO3dHed9A8kKUmW+Nknb/9
        0QYFj9mfGNjOrQva8URx2z6FkhvTWDNUK05NWjblimN8+Iwv8RfuCi0szq9h/vHtwt6q6LVH
        pv70rH99dGKWVP8f76szTi05eU5OrpIpP7q6TI61LTX62NdHRe13Xr/pvHqbs3Wes1iVRt4t
        oeIZL02ff1iqUTFx/+OXz668ONOZOPXt6+srH+83tnp2f8FSJZbijERDLeai4kQAvmmoGFcD
        AAA=
X-CMS-MailID: 20230523122229eucas1p2ea47c3d872cc7dd6f52de85e2e304b8c
X-Msg-Generator: CA
X-RootMTR: 20230523122229eucas1p2ea47c3d872cc7dd6f52de85e2e304b8c
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122229eucas1p2ea47c3d872cc7dd6f52de85e2e304b8c
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122229eucas1p2ea47c3d872cc7dd6f52de85e2e304b8c@eucas1p2.samsung.com>
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

This is part of the general push to deprecate register_sysctl_paths and
register_sysctl_table. We use a temp allocation to include both port and
device name in proc. Allocated mem is freed at the end. The unused
parport_device_sysctl_template struct elements that are not used are
removed.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202305150948.pHgIh7Ql-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305150948.pHgIh7Ql-lkp@intel.com/
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/parport/procfs.c | 56 +++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 28a37e0ef98c..22d211c95168 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -384,6 +384,7 @@ parport_device_sysctl_template = {
 			.extra1		= (void*) &parport_min_timeslice_value,
 			.extra2		= (void*) &parport_max_timeslice_value
 		},
+		{}
 	},
 	{
 		{
@@ -394,22 +395,6 @@ parport_device_sysctl_template = {
 			.child		= NULL
 		},
 		{}
-	},
-	{
-		PARPORT_DEVICES_ROOT_DIR,
-		{}
-	},
-	{
-		PARPORT_PORT_DIR(NULL),
-		{}
-	},
-	{
-		PARPORT_PARPORT_DIR(NULL),
-		{}
-	},
-	{
-		PARPORT_DEV_DIR(NULL),
-		{}
 	}
 };
 
@@ -551,30 +536,53 @@ int parport_proc_unregister(struct parport *port)
 
 int parport_device_proc_register(struct pardevice *device)
 {
+	int bytes_written, err = 0;
 	struct parport_device_sysctl_table *t;
 	struct parport * port = device->port;
+	size_t port_name_len, device_name_len, tmp_dir_path_len;
+	char *tmp_dir_path;
 	
 	t = kmemdup(&parport_device_sysctl_template, sizeof(*t), GFP_KERNEL);
 	if (t == NULL)
 		return -ENOMEM;
 
-	t->dev_dir[0].child = t->parport_dir;
-	t->parport_dir[0].child = t->port_dir;
-	t->port_dir[0].procname = port->name;
-	t->port_dir[0].child = t->devices_root_dir;
-	t->devices_root_dir[0].child = t->device_dir;
+	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
+	device_name_len = strnlen(device->name, PATH_MAX);
+
+	/* Allocate a buffer for two paths: dev/parport/PORT/devices/DEVICE. */
+	tmp_dir_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len + device_name_len;
+	tmp_dir_path = kzalloc(tmp_dir_path_len, GFP_KERNEL);
+	if (!tmp_dir_path) {
+		err = -ENOMEM;
+		goto exit_free_t;
+	}
+
+	bytes_written = snprintf(tmp_dir_path, tmp_dir_path_len, "dev/parport/%s/devices/%s",
+				 port->name, device->name);
+	if (tmp_dir_path_len <= bytes_written) {
+		err = -ENOENT;
+		goto exit_free_path;
+	}
 
-	t->device_dir[0].procname = device->name;
-	t->device_dir[0].child = t->vars;
 	t->vars[0].data = &device->timeslice;
 
-	t->sysctl_header = register_sysctl_table(t->dev_dir);
+	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
 	if (t->sysctl_header == NULL) {
 		kfree(t);
 		t = NULL;
 	}
 	device->sysctl_table = t;
+
+	kfree(tmp_dir_path);
 	return 0;
+
+exit_free_path:
+	kfree(tmp_dir_path);
+
+exit_free_t:
+	kfree(t);
+
+	return err;
 }
 
 int parport_device_proc_unregister(struct pardevice *device)
-- 
2.30.2

