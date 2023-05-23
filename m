Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772B270DC72
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 14:22:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236816AbjEWMWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 08:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjEWMWc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 08:22:32 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB166119
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 05:22:29 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230523122228euoutp010dad4ed907fea311ecce435b2e199209~hxTCq44N91725117251euoutp01O
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 12:22:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230523122228euoutp010dad4ed907fea311ecce435b2e199209~hxTCq44N91725117251euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684844548;
        bh=Gl8w8aYUi8EdP/0mI8ukz2sgnZWD5EFjBiLLXuY7rlY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=vC+fR35q0VfVR8CfpZIrd0FRtKpO9lQxzwdlL5mu67rtwO2UlFBE4CGuLwVoAWCXy
         y3WeO4MJ8nfyrsywdi98wyPZmVqYxNF0pubgFN2Uv/7RIxXvYGQPkMGACoy/twVRJ0
         WoRovUsB8ysc9KJgel+XorhpE9KpDVyhqx63bjCM=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230523122228eucas1p18d511e1ddb871c6fda4dffb6aa6e195a~hxTCcbvID2697326973eucas1p19;
        Tue, 23 May 2023 12:22:28 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 40.C8.42423.400BC646; Tue, 23
        May 2023 13:22:28 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20230523122227eucas1p2ee83e872a9a3babd1196a286a34e175a~hxTCA79VE0063100631eucas1p2c;
        Tue, 23 May 2023 12:22:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230523122227eusmtrp2ba996f327f92df18bbe2b4a04a8311de~hxTCABXxt0635006350eusmtrp2k;
        Tue, 23 May 2023 12:22:27 +0000 (GMT)
X-AuditID: cbfec7f2-a3bff7000002a5b7-e2-646cb0042352
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id B6.BF.10549.300BC646; Tue, 23
        May 2023 13:22:27 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230523122227eusmtip1cd14341a47651d0a13fc47c80a4eb32a~hxTB0pQ4h1739517395eusmtip1H;
        Tue, 23 May 2023 12:22:27 +0000 (GMT)
Received: from localhost (106.210.248.82) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 23 May 2023 13:22:26 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Joel Granados <j.granados@samsung.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH v4 2/8] parport: Remove register_sysctl_table from
 parport_proc_register
Date:   Tue, 23 May 2023 14:22:14 +0200
Message-ID: <20230523122220.1610825-3-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230523122220.1610825-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.82]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djPc7osG3JSDGbMZLV4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAWxSXTUpqTmZZapG+XQJXRtu2WYwFDZoVO96eZ21gvK3YxcjJISFgIrH/YhNL
        FyMXh5DACkaJe7PWskE4XxglTk47zwrhfGaUuN87jxWm5dfkj0wQieWMEgePNCJU/fr3kB3C
        2cIosbJlMRNIC5uAjsT5N3eYQWwRAXGJE6c3M4IUMQvsZJLo77wFtJGDQ1ggSuJ6QyFIDYuA
        qsT5Z6/YQGxeAVuJN69+MEKslpdouz4dzOYUsJM49GwfK0SNoMTJmU9YQGxmoJrmrbOZIWwJ
        iYMvXjBD9CpJrO76wwZh10qc2nIL7AUJgS8cEl9PvWaHSLhIPD12AupPYYlXx7dAxWUk/u+c
        D9UwmVFi/78P7BDOakaJZY1fmSCqrCVarjyB6nCU2DzrEzvIZxICfBI33gpCXMQnMWnbdGaI
        MK9ER5vQBEaVWUh+mIXkh1lIfljAyLyKUTy1tDg3PbXYMC+1XK84Mbe4NC9dLzk/dxMjMAWd
        /nf80w7Gua8+6h1iZOJgPMQowcGsJMJ7ojw7RYg3JbGyKrUoP76oNCe1+BCjNAeLkjivtu3J
        ZCGB9MSS1OzU1ILUIpgsEwenVANTyNWJqX/9jm597cppcPTTjQzLDwUzba2P6/N0F/z/Xb76
        UWb9Q/aVHbn/hWxspn7XY7uyfv9N3Z+zl5x+dGmxf6eKz7qvSkv272i04XiW3/jKvufvz/Zy
        VyumQLOQm4s1hLJD0tq36dowpn9wKMoVfyMdXHT29JZZl8V3qyr5HK5gvsAhHrl2YvlKz48K
        H/IecF/04Ly99YHWoTuMlgUpWiGOTKoZE3c1v7Pj9Dndof7c/4T01UOlbukHBWcrtf5inqKW
        vVbB2OTfh6BMK+9vKxsj3D+0ndjnYlIZFL3XgnP687Mb2e6rXYzPvpzpGCX687jgqnyLhfZN
        jQVu1d+s3szrNJoptrLul3L3pA1KLMUZiYZazEXFiQDxKSV2sAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrKIsWRmVeSWpSXmKPExsVy+t/xu7rMG3JSDP6dV7N4ffgTo8WZ7lyL
        PXtPslhc3jWHzeLGhKeMFgdOT2G2OP/3OKvFsp1+DhwesxsusnjsnHWX3WPBplKPTas62Tw+
        b5Lz2PTkLVMAW5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZ
        apG+XYJeRtu2WYwFDZoVO96eZ21gvK3YxcjJISFgIvFr8kemLkYuDiGBpYwSN5d+Y4NIyEhs
        /HKVFcIWlvhzrYsNougjo8SEF/9ZIJwtjBLb27vBqtgEdCTOv7nDDGKLCIhLnDi9mRGkiFlg
        O5PEhL+7wMYKC0RI/G/4BNbAIqAqcf7ZK7A4r4CtxJtXPxgh1slLtF2fDmZzCthJHHq2D6xe
        CKim9dUmVoh6QYmTM5+wgNjMQPXNW2czQ9gSEgdfvGCGmKMksbrrD9Q7tRKf/z5jnMAoMgtJ
        +ywk7bOQtC9gZF7FKJJaWpybnltsqFecmFtcmpeul5yfu4kRGJ/bjv3cvINx3quPeocYmTgY
        DzFKcDArifCeKM9OEeJNSaysSi3Kjy8qzUktPsRoCvTnRGYp0eR8YILIK4k3NDMwNTQxszQw
        tTQzVhLn9SzoSBQSSE8sSc1OTS1ILYLpY+LglGpgypQSd37A3LzXMGXiox3NXBxX2/gZdR13
        5iy5dP8yd/y5zncacm1HuQ/eFLmxS7HMMtE1L0h6cVvZFj/3iUw/D+eFHFbap2C5OaG6b4q7
        12+xA857f7+fWOybkRvibxhR8bHTquytge7mXTzhJRvST9nlGf/LXevbLf9YKTXQvujCw2V7
        mgoWyplxyn7geFJ6x0NVQuT0wXsZ3Dbv5URfsx9ue73QUTfFMXLdIZ7ZU32Y9h3zM33+5ACX
        s960t/eEzTp3lwkZzu3Jfv17j/brRR6bOoWMAmYs3cFgM4GTI9xbpEX3g3bfkkeyFRwMqdse
        zLYL9555/WXHc552l+igSW8NS0Kb454yBwWwzFZiKc5INNRiLipOBAA7l7JBWAMAAA==
X-CMS-MailID: 20230523122227eucas1p2ee83e872a9a3babd1196a286a34e175a
X-Msg-Generator: CA
X-RootMTR: 20230523122227eucas1p2ee83e872a9a3babd1196a286a34e175a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230523122227eucas1p2ee83e872a9a3babd1196a286a34e175a
References: <20230523122220.1610825-1-j.granados@samsung.com>
        <CGME20230523122227eucas1p2ee83e872a9a3babd1196a286a34e175a@eucas1p2.samsung.com>
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
register_sysctl_table. Register dev/parport/PORTNAME and
dev/parport/PORTNAME/devices. Temporary allocation for name is freed at
the end of the function. Remove all the struct elements that are no
longer used in the parport_device_sysctl_template struct. Add parport
specific defines that hide the base path sizes.

To make sure the resulting directory structure did not change we
made sure that `find /proc/sys/dev/ | sha1sum` was the same before and
after the change.

Signed-off-by: Joel Granados <j.granados@samsung.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202305150948.pHgIh7Ql-lkp@intel.com/
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202305150948.pHgIh7Ql-lkp@intel.com/
Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/parport/procfs.c | 93 ++++++++++++++++++++++++++--------------
 1 file changed, 61 insertions(+), 32 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index d740eba3c099..28a37e0ef98c 100644
--- a/drivers/parport/procfs.c
+++ b/drivers/parport/procfs.c
@@ -32,6 +32,13 @@
 #define PARPORT_MAX_TIMESLICE_VALUE ((unsigned long) HZ)
 #define PARPORT_MIN_SPINTIME_VALUE 1
 #define PARPORT_MAX_SPINTIME_VALUE 1000
+/*
+ * PARPORT_BASE_* is the size of the known parts of the sysctl path
+ * in dev/partport/%s/devices/%s. "dev/parport/"(12), "/devices/"(9
+ * and null char(1).
+ */
+#define PARPORT_BASE_PATH_SIZE 13
+#define PARPORT_BASE_DEVICES_PATH_SIZE 22
 
 static int do_active_device(struct ctl_table *table, int write,
 		      void *result, size_t *lenp, loff_t *ppos)
@@ -260,9 +267,6 @@ struct parport_sysctl_table {
 	struct ctl_table_header *sysctl_header;
 	struct ctl_table vars[12];
 	struct ctl_table device_dir[2];
-	struct ctl_table port_dir[2];
-	struct ctl_table parport_dir[2];
-	struct ctl_table dev_dir[2];
 };
 
 static const struct parport_sysctl_table parport_sysctl_template = {
@@ -305,7 +309,6 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 			.mode		= 0444,
 			.proc_handler	= do_hardware_modes
 		},
-		PARPORT_DEVICES_ROOT_DIR,
 #ifdef CONFIG_PARPORT_1284
 		{
 			.procname	= "autoprobe",
@@ -355,18 +358,6 @@ static const struct parport_sysctl_table parport_sysctl_template = {
 		},
 		{}
 	},
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
-	}
 };
 
 struct parport_device_sysctl_table
@@ -473,11 +464,13 @@ parport_default_sysctl_table = {
 	}
 };
 
-
 int parport_proc_register(struct parport *port)
 {
 	struct parport_sysctl_table *t;
-	int i;
+	struct ctl_table_header *devices_h;
+	char *tmp_dir_path;
+	size_t tmp_path_len, port_name_len;
+	int bytes_written, i, err = 0;
 
 	t = kmemdup(&parport_sysctl_template, sizeof(*t), GFP_KERNEL);
 	if (t == NULL)
@@ -485,28 +478,64 @@ int parport_proc_register(struct parport *port)
 
 	t->device_dir[0].extra1 = port;
 
-	for (i = 0; i < 5; i++)
-		t->vars[i].extra1 = port;
-
 	t->vars[0].data = &port->spintime;
-	t->vars[5].child = t->device_dir;
-	
-	for (i = 0; i < 5; i++)
-		t->vars[6 + i].extra2 = &port->probe_info[i];
+	for (i = 0; i < 5; i++) {
+		t->vars[i].extra1 = port;
+		t->vars[5 + i].extra2 = &port->probe_info[i];
+	}
 
-	t->port_dir[0].procname = port->name;
+	port_name_len = strnlen(port->name, PARPORT_NAME_MAX_LEN);
+	/*
+	 * Allocate a buffer for two paths: dev/parport/PORT and dev/parport/PORT/devices.
+	 * We calculate for the second as that will give us enough for the first.
+	 */
+	tmp_path_len = PARPORT_BASE_DEVICES_PATH_SIZE + port_name_len;
+	tmp_dir_path = kzalloc(tmp_path_len, GFP_KERNEL);
+	if (!tmp_dir_path) {
+		err = -ENOMEM;
+		goto exit_free_t;
+	}
 
-	t->port_dir[0].child = t->vars;
-	t->parport_dir[0].child = t->port_dir;
-	t->dev_dir[0].child = t->parport_dir;
+	bytes_written = snprintf(tmp_dir_path, tmp_path_len,
+				 "dev/parport/%s/devices", port->name);
+	if (tmp_path_len <= bytes_written) {
+		err = -ENOENT;
+		goto exit_free_tmp_dir_path;
+	}
+	devices_h = register_sysctl(tmp_dir_path, t->device_dir);
+	if (devices_h == NULL) {
+		err = -ENOENT;
+		goto  exit_free_tmp_dir_path;
+	}
 
-	t->sysctl_header = register_sysctl_table(t->dev_dir);
+	tmp_path_len = PARPORT_BASE_PATH_SIZE + port_name_len;
+	bytes_written = snprintf(tmp_dir_path, tmp_path_len,
+				 "dev/parport/%s", port->name);
+	if (tmp_path_len <= bytes_written) {
+		err = -ENOENT;
+		goto unregister_devices_h;
+	}
+
+	t->sysctl_header = register_sysctl(tmp_dir_path, t->vars);
 	if (t->sysctl_header == NULL) {
-		kfree(t);
-		t = NULL;
+		err = -ENOENT;
+		goto unregister_devices_h;
 	}
+
 	port->sysctl_table = t;
+
+	kfree(tmp_dir_path);
 	return 0;
+
+unregister_devices_h:
+	unregister_sysctl_table(devices_h);
+
+exit_free_tmp_dir_path:
+	kfree(tmp_dir_path);
+
+exit_free_t:
+	kfree(t);
+	return err;
 }
 
 int parport_proc_unregister(struct parport *port)
-- 
2.30.2

