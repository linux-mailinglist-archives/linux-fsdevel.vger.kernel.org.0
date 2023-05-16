Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7601A7053CB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 May 2023 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjEPQ3u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 May 2023 12:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjEPQ3m (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 May 2023 12:29:42 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C911BCD
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 09:29:22 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230516162921euoutp026e1d2d78bc386a991c9ca625a062bc02~frJmXm2Dm2772727727euoutp02a
        for <linux-fsdevel@vger.kernel.org>; Tue, 16 May 2023 16:29:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230516162921euoutp026e1d2d78bc386a991c9ca625a062bc02~frJmXm2Dm2772727727euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684254561;
        bh=CjqRXAToz0uQhFB7WWJPv1LFocOxn4EdbByLvmL1pCg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jHcsE7RlRqRyc1IC+bNY9meFWObVv4QpRQYLPT3KKMyh93ZggAv3+zumSHuGHjIU8
         fyxaR87mlajAEi7ldEt1LkhS3qT1cpBFO6uGb2Mu1JXTJhzPyIPWggLXNDJodx7uQG
         Wy0Sx/6fIirnF9UtqcdgnT3coZGq8iyLaJAp8Ek0=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230516162921eucas1p2164dd6a56618c37a4aae1ad0d0c0ecf9~frJmOGBNV2230122301eucas1p2i;
        Tue, 16 May 2023 16:29:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 22.FF.35386.16FA3646; Tue, 16
        May 2023 17:29:21 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162920eucas1p124a6d49b54e72998eb7be57ff9d17c8a~frJleNpJw2040720407eucas1p17;
        Tue, 16 May 2023 16:29:20 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230516162920eusmtrp1e9ca749058287e081294fcefd9ec79bc~frJldwd8P2056220562eusmtrp1E;
        Tue, 16 May 2023 16:29:20 +0000 (GMT)
X-AuditID: cbfec7f4-cdfff70000028a3a-4a-6463af612e47
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.57.10549.06FA3646; Tue, 16
        May 2023 17:29:20 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230516162920eusmtip16916338117813cb97c6be51139fe89cd~frJlTc_8B1297312973eusmtip1F;
        Tue, 16 May 2023 16:29:20 +0000 (GMT)
Received: from localhost (106.210.248.56) by CAMSVWEXC02.scsc.local
        (2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
        Tue, 16 May 2023 17:29:19 +0100
From:   Joel Granados <j.granados@samsung.com>
To:     <mcgrof@kernel.org>
CC:     Kees Cook <keescook@chromium.org>, <linux-fsdevel@vger.kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        <linux-kernel@vger.kernel.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Joel Granados <j.granados@samsung.com>
Subject: [PATCH v3 3/6] parport: Remove register_sysctl_table from
 parport_device_proc_register
Date:   Tue, 16 May 2023 18:29:00 +0200
Message-ID: <20230516162903.3208880-4-j.granados@samsung.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516162903.3208880-1-j.granados@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [106.210.248.56]
X-ClientProxiedBy: CAMSVWEXC01.scsc.local (2002:6a01:e347::6a01:e347) To
        CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTYRzt2727uxtNbtPwl0Xaekhm62V0s9SCsBk9tAiy98VdLJpWu/mq
        BmY1l5r5qmxF+o86Z6KsaTO0dKKmM8Yqyt5mmmZFhSkkpG1eC/875zvn8J3z8ZGY7LLQhzwa
        f4rVxDNqOSHBa1t/O5YyVTGq5b2NIrozM46ub2jH6af3bxF0V04fohvtBRhdWrd9A6G8merE
        lXWGtyJlsTlBaTZdIpRD5rmRwr2S9SpWfTSR1SwLPSw5UtRiJU70zkrWNz3AU5FpZgYSk0AF
        QU76PTwDSUgZZURQ0OMmYhf5haDesZkXhhA8HO0i/iVMI98xXihDUNjRT/x3jTSWCnlicZGx
        kokIQQWC4+sbzI29KG94ZL+L3CaM6kPwrqHCZSJJT4qB+mvb3R6cWggVhlGhG0upENDlNAv4
        q31B9+I6cmMxFQrf75gFvGcGtN/oneiNuTzna25iPAZoGhjA+Kwc0nO7hTzWQofllcDdAag3
        JJx7XzEpbILyat0k9oTBNouIx3PAnp+F84F812OM/RDxpAJB6bnhyXrr4MKz3snERijMPT+x
        DCgP6Po2g2/kAXm11zH+WAp6nSwHLTBM2WCYssEwZUMxwkzIm03g4mJZbmU8m6TgmDguIT5W
        EXM8zoxcP8Y+1vbLisoGfypsSEAiGwISk3tJo7JjVDKpikk5zWqOH9IkqFnOhmaTuNxbuiSk
        PUZGxTKn2GMse4LV/FMFpNgnVRAdMfz6NeIy03Qvm3oKse6yHcNdn/ud5tAxUfDowRdpESGW
        6cF0IF3b2onB1msOra1G/+fALiooq9yYEeVs7kmsxVdvCOa22L3TxCkti9rWUsYlyXbr7tbo
        1Wssz0v6O+n9AY5tn8YVVc+1Vx4mR2E7/VKS1yoMrYNXlY9/qPyCgquZ8cAk/YfB6umhdUUX
        TbhxY9YH1aGO8vIz2V8+lfj/YQu0hGSVNT9Mm5e7JzzWP7zK65WxYLFz4YGPPdF5P4s2P1lV
        eaF71BcfqLzd4PG4b+kNW+K89PGvp8eH1IZ9kbhzxVnOJxsqw7BCzYjeMt9LaI2Y5ldzS30S
        zX0ix7kjzIoATMMxfwHB+x/moAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCIsWRmVeSWpSXmKPExsVy+t/xu7oJ65NTDI79ELI4051rsWfvSRaL
        y7vmsFncmPCU0eLA6SnMFst2+jmwecxuuMjisXPWXXaPBZtKPTat6mTz+LxJLoA1Ss+mKL+0
        JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j/tEdbAVPJCs6
        Du5jaWBcJdrFyMkhIWAiserbe+YuRi4OIYGljBL3nq5ghUjISGz8chXKFpb4c62LDaLoI6NE
        z9V7rBDOFkaJVUc3gVWxCehInH9zhxnEFhEQlzhxejMjiM0s8JhRYs5B2S5GDg5hgXiJSwfB
        SlgEVCVWz/oF1sorYCvRNuEwE8QyeYm269PBWjkF7CTer9kEFhcCqpm4vIcFol5Q4uTMJywQ
        4+UlmrfOZoawJSQOvnjBDDFHSaJ94gOoB2olPv99xjiBUWQWkvZZSNpnIWlfwMi8ilEktbQ4
        Nz232FCvODG3uDQvXS85P3cTIzD6th37uXkH47xXH/UOMTJxMB5ilOBgVhLhDexLThHiTUms
        rEotyo8vKs1JLT7EaAr050RmKdHkfGD855XEG5oZmBqamFkamFqaGSuJ83oWdCQKCaQnlqRm
        p6YWpBbB9DFxcEo1MO168dF3+s0nS6L8VS/amk3o3Tt1uvHNh27aj78eOrnzQXBnxk7thg+p
        G9MF7QLdvBJ+JjwOvMfM6fe2MTzaTJ91VuEZo7wv8ubPjS2y1ZgT1jeUlyy86xW78Kd5jZ64
        yfS++W/+TuM6m/NCu0yURdBXY6Gi8953+834/X83BYepRwRMf3qG3/tLqheL2f45IYzvJiht
        nrld874Cx+e82zl8dhXs8vb/r1SdUBBMrYm9Uub28Xze3arK1Zsvl/8+u7Pr04wL/01f6K54
        GCK4OfrZlz2LzvHna/lxScytck17+dTrYv/Tnw41V+6uzbyfsWc1T2RNhaHzAc/X7k92bezw
        r7W6bLo5piSnLC5nuRJLcUaioRZzUXEiAHGKkGtHAwAA
X-CMS-MailID: 20230516162920eucas1p124a6d49b54e72998eb7be57ff9d17c8a
X-Msg-Generator: CA
X-RootMTR: 20230516162920eucas1p124a6d49b54e72998eb7be57ff9d17c8a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230516162920eucas1p124a6d49b54e72998eb7be57ff9d17c8a
References: <20230516162903.3208880-1-j.granados@samsung.com>
        <CGME20230516162920eucas1p124a6d49b54e72998eb7be57ff9d17c8a@eucas1p1.samsung.com>
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
---
 drivers/parport/procfs.c | 56 +++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/drivers/parport/procfs.c b/drivers/parport/procfs.c
index 02c52de6e640..a2b58da1fe86 100644
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
 
@@ -546,30 +531,53 @@ int parport_proc_unregister(struct parport *port)
 
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

