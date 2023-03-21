Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1B6C2714
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjCUBNU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229971AbjCUBNR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:17 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20601.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::601])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3406FD32D
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:12:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PL01c6qvKdJ7y8Qwhmlmo9LCkl2JZ5dmCQXgAknKSZwBZXvtC24s74QpWNP+E+Pxs07YYEC3yEr5qjEHidkUcZWB6va72lcIYtcNc5YXC7Lov60RacwYbflK4HCs0by2ROnjXKMhFx5xUy4pXFsLeD7dWK4iKpL+FvxvXVBHK/rLE180YP1TdhpcgFOpwUgojYIbRjAU9sJC/KJU80MQu99zqMP384Y26xCiW86HBL0yooq8DNk8joHY+QVd0Q+vzv2p1RmGamtA4PO7nlttQe3cu0UXpzKf571ai++Pf9/MY74FTmcwfHxYIG4OvN8f+v82FVjnj0OgbTgeaz9QFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0ENGCL4ebjTWPcJYa92CBA0rB60GzhmFD2YxkER8FE=;
 b=MmQyFVnwb6tFTckeI6wRM79HB1MIqPO+XRpr14+y/7efsGxa80jE4iySjbFXa/RtK+lLQ+chbdFMWeERxU/EUGy6kBTU1I9cddhnrxUIYuAfxX4vAymRGe78e4bpytHuLSselPTwdbo7PC9+QzFMSGNietft00ielk3rGnrnn1eD9sWgEfSfezwtq0JV1XTry7MYstoZ8DA2Zbic9DcsOems8Bp4vIcGoC1ve2xwIDEMIK8jvIgAZKu0SvaXtEQ2moFWrBTJjyiX1eyhS8gjtNXR5EJDHiUfPw+W4mzjzBsD6MZI8QbQCxoDF8Pn4vFe/IJPPdvnECPfAMVHgwhODw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0ENGCL4ebjTWPcJYa92CBA0rB60GzhmFD2YxkER8FE=;
 b=dz2HuQ4gkY/zqoGp3qIug0wTtUWSw6MsyBRE/ZcNMnmck/D4AGVJecryX5KAWmjgxTz+m0Qwy1/r18U/E5Jrx1gF9s/fSSHBM8VSf/AOuGcn0zHqZOuOZ/ES+dhxUyxESpCCxlKZC1nKh/fBSb/ELWJTbUOXkCvHkkFi/DIeKrw=
Received: from DS7PR05CA0008.namprd05.prod.outlook.com (2603:10b6:5:3b9::13)
 by CO6PR19MB4787.namprd19.prod.outlook.com (2603:10b6:5:350::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Tue, 21 Mar
 2023 01:11:23 +0000
Received: from DM6NAM04FT028.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:3b9:cafe::dd) by DS7PR05CA0008.outlook.office365.com
 (2603:10b6:5:3b9::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.15 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT028.mail.protection.outlook.com (10.13.159.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Tue, 21 Mar 2023 01:11:23 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 5E3ED2073544;
        Mon, 20 Mar 2023 19:12:31 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 09/13] fuse: Add wait stop ioctl support to the ring
Date:   Tue, 21 Mar 2023 02:10:43 +0100
Message-Id: <20230321011047.3425786-10-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT028:EE_|CO6PR19MB4787:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0d8b046a-8d0b-4921-4ff1-08db29a93038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y27kJP5pOT2/6TgbWHlDpXS+PYNCh8hts9BYbwLUWNj2eJEOIm+GcCYPRRA2lmj3rX83eHm/9ox1iVmpb6994rGeOG5KrCAwgu8hMEcEYdUPJq1j5bprzlFtLQp+3i9IBTKlDf2yBpED1adamfy3QAV6PTe0jLveJm8bKy8y1ADuncKV4FzP0v+5fYDUGvsConyxpM6DRdCZ9sE7tF9+Hck+4IP/LcKGY/CUmXJbyBomVOFXS2GTlmwOD4DFUC4Gtc5bMo04QS2PNue8CGD2t7UPjH0qr2b5rdgpbaDQRPMV9VNt5yOJh2vdroMlb/0zRcYXLGjccD6w5nr7PCxjAyj1SHKNCM9SBoM6FBVDtukk1jUz2LggkkBkj4csJpgWgT5KASGAvcjY45fB4AgJYb/zez3S7SzJ3Wzz/g+isq02bCiFasBN6BYiz5B3SpdnVa/O97GAwIHmInRFlmDz5Epsf1cEewJK5dGDXXvc6Sb95aGrqOO4Ut8Xhoeyw59ogZ2aNlVhW5yXj6WkqXnV7g7YTnZN3S427Mv/1MhFBX6lwoqC2Ai0Zo7J2Ee/RDBRZSLXzcbn3Y3jLr5wxo1mQJE1YY9iKxgQEg2x/mutWMRkiuxcIaUYF49W+lfacU42zHdBuO5H/0i3ejHOaj/fGxrtW6nhtvi2rpb4O64G5879WuCcB9ItrTBxJJAWmQxYgZlb/KJMKUmtbhqmzMUWhg==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39850400004)(136003)(376002)(451199018)(46966006)(36840700001)(186003)(478600001)(356005)(8676002)(54906003)(41300700001)(6916009)(8936002)(5660300002)(70206006)(86362001)(6266002)(82740400003)(70586007)(40480700001)(6666004)(36756003)(4326008)(2616005)(81166007)(316002)(26005)(47076005)(1076003)(2906002)(83380400001)(82310400005)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:23.7484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d8b046a-8d0b-4921-4ff1-08db29a93038
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT028.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR19MB4787
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is an optional ioctl to avoid running the stop monitor
(delayed workq) at run time in intervals - saves cpu cycles.
When the FUSE_DEV_IOC_URING ioctl with subcommand
FUSE_URING_IOCTL_CMD_WAIT is received it cancels the stop monitor
(delayed workq) and then goes into a an interruptible waitq - on
process termination it gets woken up and schedules the stop monitor
again.
As the submitting thread is waiting forever in a waitq,
userspace daemon side has to create a separate thread for it.

The additional ioctl subcommand FUSE_URING_IOCTL_CMD_STOP exits
to let userspace explicitly initiate fuse uring shutdown and to wake up
the FUSE_URING_IOCTL_CMD_WAIT waiting thread.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev_uring.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index ade341d86c03..e19c652e7071 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -425,6 +425,49 @@ static int fuse_uring_cfg(struct fuse_conn *fc, unsigned int qid,
 	return rc;
 }
 
+/**
+ * Wait until uring shall be destructed and then release uring resources
+ */
+static int fuse_uring_wait_stop(struct fuse_conn *fc)
+{
+	struct fuse_iqueue *fiq = &fc->iq;
+
+	pr_devel("%s stop_requested=%d", __func__, fc->ring.stop_requested);
+
+	if (fc->ring.stop_requested)
+		return -EINTR;
+
+	/* This userspace thread can stop uring on process stop, no need
+	 * for the interval worker
+	 */
+	pr_devel("%s cancel stop monitor\n", __func__);
+	cancel_delayed_work_sync(&fc->ring.stop_monitor);
+
+	wait_event_interruptible(fc->ring.stop_waitq,
+				 !fiq->connected ||
+				 fc->ring.stop_requested);
+
+	/* The userspace task gets scheduled to back userspace, we need
+	 * the interval worker again. It runs immediately for quick cleanup
+	 * in shutdown/process kill.
+	 */
+
+	mutex_lock(&fc->ring.start_stop_lock);
+	if (!fc->ring.queues_stopped)
+		mod_delayed_work(system_wq, &fc->ring.stop_monitor, 0);
+	mutex_unlock(&fc->ring.start_stop_lock);
+
+	return 0;
+}
+
+static int fuse_uring_shutdown_wakeup(struct fuse_conn *fc)
+{
+	fc->ring.stop_requested = 1;
+	wake_up_all(&fc->ring.stop_waitq);
+
+	return 0;
+}
+
 int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg)
 {
 	struct fuse_dev *fud = fuse_get_dev(file);
@@ -443,6 +486,10 @@ int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg)
 	switch (cfg->cmd) {
 	case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
 		return fuse_uring_cfg(fc, cfg->qid, cfg);
+	case FUSE_URING_IOCTL_CMD_WAIT:
+		return fuse_uring_wait_stop(fc);
+	case FUSE_URING_IOCTL_CMD_STOP:
+		return fuse_uring_shutdown_wakeup(fc);
 	default:
 		return -EINVAL;
 	}
-- 
2.37.2

