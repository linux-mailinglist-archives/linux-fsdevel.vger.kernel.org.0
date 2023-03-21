Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F06C2752
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:20:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjCUBUB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjCUBTv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:19:51 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC70DBD3
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:19:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GlCdAY2mqxHLnIfYKguFjrIbepslYQLjqTY6h8aMtEgOozxGCvnXiOcetfow0/9UwscXEUJAfkMKReJ7+Sf8eXftp4pIjjMyMWKO2HPbnG339Gt0LLrUm7rqS0PjfVD6jFG3JxDDjNdwdaqXpUe3HyZUJltTZ8Cqh7QMsex1R7k3k8W/J7ceTaallupMUwHcuS+1N9cYlx/uB0MtfTccYD1qhDkDiSVQL5Rc5PPNX47scTzjIHYDpKI2mo5JkKInPC2EM3jd6yjY9I5HvVKY0EzeSXwpVGILwPOZYqBuXXrjWbfWqdXUO3hdDWSHLQZblDXvTJkLJktC9ZfvXSbzMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ld487a/V6PsM8AlzC7GQNt9Pp3M0ITbUDGyQ9k7rzzI=;
 b=M7zqjdrZi9T+z+t/QNPnsxDK21YHWNE07BAnuqEkWTbqvPO0/CmHIDcdqLbtjwCAvEoDLaW9GBUVBclv+sKldyl3pPiheaOzvw+yuUg5OtkdpyAKrHrsEISUTHzrynhx17jE2W17j2BbusvJRFMZr1OOQKNxXd+ns4UopC9EPKSeKyvlqasZYWtAAYXs2Xm2UsXYYiFVsdJ9eWhpso0wlEVO7xqDBjELWzHmjpRyDeoGJ0ioCWQj441dDxD30yYSngeGmGBLDmiLtFUUS8Mnl8xsDBp0XQTmcvGqUXIUwD2My++jm6ON04QG1i58W+3YxwsCBiLWnonNDnMXt323pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld487a/V6PsM8AlzC7GQNt9Pp3M0ITbUDGyQ9k7rzzI=;
 b=KxFsIp/AWkw7/nkh9lYjM9xirlAxEvYNbxBynCcyT1zBmdYYvcFNJKkcMU5DCSoYCF03Sb7/Jemd7CTFbqZbrmdIysSGNef3wgTcUmMsj2YIEgkZBoOodReR68m4KgLEomb3IWn3UKjPClZLqnyzTCa/WXZGxz/yxXBbBlSO4Jc=
Received: from MW4PR04CA0118.namprd04.prod.outlook.com (2603:10b6:303:83::33)
 by CY5PR19MB6291.namprd19.prod.outlook.com (2603:10b6:930:24::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.23; Tue, 21 Mar
 2023 01:11:20 +0000
Received: from MW2NAM04FT004.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::e6) by MW4PR04CA0118.outlook.office365.com
 (2603:10b6:303:83::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT004.mail.protection.outlook.com (10.13.30.182) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:20 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 821E32073545;
        Mon, 20 Mar 2023 19:12:27 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 05/13] fuse: Add a uring config ioctl and ring destruction
Date:   Tue, 21 Mar 2023 02:10:39 +0100
Message-Id: <20230321011047.3425786-6-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT004:EE_|CY5PR19MB6291:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 73f29b4d-513f-40b5-1d6d-08db29a92e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p+GaF5a7nlgzDqBY1H2QaCIhr2p3/Jl4uYmPUL6bTaxshNuS5Hn+hsUHcZmPOTsJpXsXRJA55JLCt9OuEogmkzZ+1Z7iIj2DqT1/eIWE/0PrHpnQsV+5s1PloKH/Kr8C35LPXt+RW+ryqejdHqg5v8qW1zR4+bys6wchKbzdhJRyo8i1mNzsZc92kVn0b3TMUAnTOHQf+SaeZylq/s9MA7NZ6Xx334NqNAgwaBx+AMswj2iR/PkYMP3mmiXPKo8b77cY9WHKWthzGxS8tnMFLpVqb1/xsw3u1UGs5u+Rio1oXij57dYrC9kgRt1vDlnaVfLFInibBLL4T16KBVyuEdyeARXHb1idwbPVnkf37LW3xrBhC+wNPNQyoRhRFJcG3Mh8Ah08/f8uiyOvBA96SQFcu5l3mdJieSYjmAyC8UywU1wvy9ZsNfmaxWj4sbZEyxhefWZo6BVFrI2ZWsBI7wdlfP52ztQyzW5gCBflZspbI/gMy5dh5/r6f4KRKr1Cm4wM+hmRjPsp+mY7G6Zq6Hj5b2utXk+r6FZO+BzLjZuFZct/jHQQDMur4xiioHD/iU5EgUD/4E6f8zjltTVI+cHRTd4O1jdlkrb52bGuOVekEYna1nddGtmzYbSwxVaq+U0ZjoAZFrOLD6Z/eXzgWH2NeMxzrbHj1fQJHQoYVdP5X8HBAaDTu/uTC9IBHzvUh6W0vxM7oQIDWKLuW4hXQpJ0cdezsz68di+9534cd1s=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39850400004)(376002)(451199018)(36840700001)(46966006)(2616005)(8676002)(41300700001)(6916009)(86362001)(30864003)(82310400005)(186003)(2906002)(4326008)(70206006)(40480700001)(82740400003)(26005)(8936002)(316002)(54906003)(36756003)(47076005)(36860700001)(1076003)(478600001)(356005)(6666004)(70586007)(81166007)(83380400001)(336012)(5660300002)(6266002)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:20.0353
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 73f29b4d-513f-40b5-1d6d-08db29a92e04
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT004.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6291
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Ring data are created with an ioctl, destruction goes via
fuse_abort_conn(). A new module parameter is added, for
now uring defaults to disabled.

This also adds the remaining fuse ring data structures.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/Makefile      |   2 +-
 fs/fuse/dev.c         |  21 +++
 fs/fuse/dev_uring.c   | 330 ++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h |  20 +++
 fs/fuse/fuse_i.h      | 178 +++++++++++++++++++++++
 fs/fuse/inode.c       |   7 +
 6 files changed, 557 insertions(+), 1 deletion(-)
 create mode 100644 fs/fuse/dev_uring.c
 create mode 100644 fs/fuse/dev_uring_i.h

diff --git a/fs/fuse/Makefile b/fs/fuse/Makefile
index 0c48b35c058d..634d47477393 100644
--- a/fs/fuse/Makefile
+++ b/fs/fuse/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_FUSE_FS) += fuse.o
 obj-$(CONFIG_CUSE) += cuse.o
 obj-$(CONFIG_VIRTIO_FS) += virtiofs.o
 
-fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o
+fuse-y := dev.o dir.o file.o inode.o control.o xattr.o acl.o readdir.o ioctl.o dev_uring.o
 fuse-$(CONFIG_FUSE_DAX) += dax.o
 
 virtiofs-y := virtio_fs.o
diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index e0669b8e4618..07323b041377 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -8,6 +8,7 @@
 
 #include "fuse_i.h"
 #include "fuse_dev_i.h"
+#include "dev_uring_i.h"
 
 #include <linux/init.h>
 #include <linux/module.h>
@@ -2171,6 +2172,11 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		spin_unlock(&fc->lock);
 
 		fuse_dev_end_requests(&to_end);
+
+		mutex_lock(&fc->ring.start_stop_lock);
+		if (fc->ring.configured && !fc->ring.queues_stopped)
+			fuse_uring_end_requests(fc);
+		mutex_unlock(&fc->ring.start_stop_lock);
 	} else {
 		spin_unlock(&fc->lock);
 	}
@@ -2247,6 +2253,7 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 	int res;
 	int oldfd;
 	struct fuse_dev *fud = NULL;
+	struct fuse_uring_cfg ring_conf;
 
 	switch (cmd) {
 	case FUSE_DEV_IOC_CLONE:
@@ -2271,6 +2278,20 @@ static long fuse_dev_ioctl(struct file *file, unsigned int cmd,
 				fput(old);
 			}
 		}
+		break;
+	case FUSE_DEV_IOC_URING:
+		/* XXX fud ensures fc->ring.start_stop_lock is initialized? */
+		fud = fuse_get_dev(file);
+		if (fud) {
+			res = copy_from_user(&ring_conf, (void *)arg,
+					     sizeof(ring_conf));
+			if (res == 0)
+				res = fuse_uring_ioctl(file, &ring_conf);
+			else
+				res = -EFAULT;
+		} else
+			pr_info("%s: Did not get fud\n", __func__);
+
 		break;
 	default:
 		res = -ENOTTY;
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
new file mode 100644
index 000000000000..12fd21526b2b
--- /dev/null
+++ b/fs/fuse/dev_uring.c
@@ -0,0 +1,330 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+ */
+
+#include "fuse_i.h"
+#include "fuse_dev_i.h"
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/poll.h>
+#include <linux/sched/signal.h>
+#include <linux/uio.h>
+#include <linux/miscdevice.h>
+#include <linux/pagemap.h>
+#include <linux/file.h>
+#include <linux/slab.h>
+#include <linux/pipe_fs_i.h>
+#include <linux/swap.h>
+#include <linux/splice.h>
+#include <linux/sched.h>
+#include <linux/io_uring.h>
+#include <linux/mm.h>
+#include <linux/io.h>
+#include <linux/io_uring.h>
+#include <linux/topology.h>
+
+static bool __read_mostly enable_uring;
+module_param(enable_uring, bool, 0644);
+MODULE_PARM_DESC(enable_uring,
+	"Enable uring userspace communication through uring.");
+
+static struct fuse_ring_queue *
+fuse_uring_get_queue(struct fuse_conn *fc, int qid)
+{
+	char *ptr = (char *)fc->ring.queues;
+
+	if (unlikely(qid > fc->ring.nr_queues)) {
+		WARN_ON(1);
+		qid = 0;
+	}
+
+	return (struct fuse_ring_queue *)(ptr + qid * fc->ring.queue_size);
+}
+
+/* Abort all list queued request on the given ring queue */
+static void fuse_uring_end_queue_requests(struct fuse_ring_queue *queue)
+{
+	spin_lock(&queue->lock);
+	queue->aborted = 1;
+	fuse_dev_end_requests(&queue->fg_queue);
+	fuse_dev_end_requests(&queue->bg_queue);
+	spin_unlock(&queue->lock);
+}
+
+void fuse_uring_end_requests(struct fuse_conn *fc)
+{
+	int qid;
+
+	for (qid = 0; qid < fc->ring.nr_queues; qid++) {
+		struct fuse_ring_queue *queue =
+			fuse_uring_get_queue(fc, qid);
+
+		if (!queue->configured)
+			continue;
+
+		fuse_uring_end_queue_requests(queue);
+	}
+}
+
+/**
+ * use __vmalloc_node_range() (needs to be
+ * exported?) or add a new (exported) function vm_alloc_user_node()
+ */
+static char *fuse_uring_alloc_queue_buf(int size, int node)
+{
+	char *buf;
+
+	if (size <= 0) {
+		pr_info("Invalid queue buf size: %d.\n", size);
+		return ERR_PTR(-EINVAL);
+	}
+
+	buf = vmalloc_node_user(size, node);
+	return buf ? buf : ERR_PTR(-ENOMEM);
+}
+
+/**
+ * Ring setup for this connection
+ */
+static int fuse_uring_conn_cfg(struct fuse_conn *fc,
+			       struct fuse_uring_cfg *cfg)
+__must_hold(fc->ring.stop_waitq.lock)
+{
+	size_t queue_sz;
+
+	if (cfg->nr_queues == 0) {
+		pr_info("zero number of queues is invalid.\n");
+		return -EINVAL;
+	}
+
+	if (cfg->nr_queues > 1 &&
+	    cfg->nr_queues != num_present_cpus()) {
+		pr_info("nr-queues (%d) does not match nr-cores (%d).\n",
+			cfg->nr_queues, num_present_cpus());
+		return -EINVAL;
+	}
+
+	if (cfg->qid > cfg->nr_queues) {
+		pr_info("qid (%d) exceeds number of queues (%d)\n",
+			cfg->qid, cfg->nr_queues);
+		return -EINVAL;
+	}
+
+	if (cfg->req_arg_len < FUSE_RING_MIN_IN_OUT_ARG_SIZE) {
+		pr_info("Per req buffer size too small (%d), min: %d\n",
+			cfg->req_arg_len, FUSE_RING_MIN_IN_OUT_ARG_SIZE);
+		return -EINVAL;
+	}
+
+	if (unlikely(fc->ring.queues)) {
+		WARN_ON(1);
+		return -EINVAL;
+	}
+
+	fc->ring.daemon = current;
+	get_task_struct(fc->ring.daemon);
+
+	fc->ring.nr_queues = cfg->nr_queues;
+	fc->ring.per_core_queue = cfg->nr_queues > 1;
+
+	fc->ring.max_fg = cfg->fg_queue_depth;
+	fc->ring.max_bg = cfg->bg_queue_depth;
+	fc->ring.queue_depth = cfg->fg_queue_depth + cfg->bg_queue_depth;
+
+	fc->ring.req_arg_len = cfg->req_arg_len;
+	fc->ring.req_buf_sz =
+		round_up(sizeof(struct fuse_ring_req) + fc->ring.req_arg_len,
+			 PAGE_SIZE);
+
+	/* verified during mmap that kernel and userspace have the same
+	 * buffer size
+	 */
+	fc->ring.queue_buf_size = fc->ring.req_buf_sz * fc->ring.queue_depth;
+
+	queue_sz = sizeof(*fc->ring.queues) +
+			fc->ring.queue_depth * sizeof(struct fuse_ring_ent);
+	fc->ring.queues = kcalloc(cfg->nr_queues, queue_sz, GFP_KERNEL);
+	if (!fc->ring.queues)
+		return -ENOMEM;
+	fc->ring.queue_size = queue_sz;
+
+	fc->ring.queue_refs = 0;
+
+	return 0;
+}
+
+static int fuse_uring_queue_cfg(struct fuse_conn *fc, unsigned int qid,
+				unsigned int node_id)
+__must_hold(fc->ring.stop_waitq.lock)
+{
+	int tag;
+	struct fuse_ring_queue *queue;
+	char *buf;
+
+	if (qid >= fc->ring.nr_queues) {
+		pr_info("fuse ring queue config: qid=%u >= nr-queues=%zu\n",
+			qid, fc->ring.nr_queues);
+		return -EINVAL;
+	}
+	queue = fuse_uring_get_queue(fc, qid);
+
+	if (queue->configured) {
+		pr_info("fuse ring qid=%u already configured!\n", qid);
+		return -EALREADY;
+	}
+
+	queue->qid = qid;
+	queue->fc = fc;
+	queue->req_fg = 0;
+	bitmap_zero(queue->req_avail_map, fc->ring.queue_depth);
+	spin_lock_init(&queue->lock);
+	INIT_LIST_HEAD(&queue->fg_queue);
+	INIT_LIST_HEAD(&queue->bg_queue);
+
+	buf = fuse_uring_alloc_queue_buf(fc->ring.queue_buf_size, node_id);
+	queue->queue_req_buf = buf;
+	if (IS_ERR(queue->queue_req_buf)) {
+		int err = PTR_ERR(queue->queue_req_buf);
+
+		queue->queue_req_buf = NULL;
+		return err;
+	}
+
+	for (tag = 0; tag < fc->ring.queue_depth; tag++) {
+		struct fuse_ring_ent *ent = &queue->ring_ent[tag];
+
+		ent->queue = queue;
+		ent->tag = tag;
+		ent->fuse_req = NULL;
+		ent->rreq = (struct fuse_ring_req *)buf;
+
+		pr_devel("initialize qid=%d tag=%d queue=%p req=%p",
+			 qid, tag, queue, ent);
+
+		ent->rreq->flags = 0;
+
+		ent->state = FRRS_INIT;
+		ent->need_cmd_done = 0;
+		ent->need_req_end = 0;
+		fc->ring.queue_refs++;
+		buf += fc->ring.req_buf_sz;
+	}
+
+	queue->configured = 1;
+	queue->aborted = 0;
+	fc->ring.nr_queues_ioctl_init++;
+	if (fc->ring.nr_queues_ioctl_init == fc->ring.nr_queues) {
+		fc->ring.configured = 1;
+		pr_devel("fc=%p nr-queues=%zu depth=%zu ioctl ready\n",
+			fc, fc->ring.nr_queues, fc->ring.queue_depth);
+	}
+
+	return 0;
+}
+
+/**
+ * Configure the queue for t he given qid. First call will also initialize
+ * the ring for this connection.
+ */
+static int fuse_uring_cfg(struct fuse_conn *fc, unsigned int qid,
+			  struct fuse_uring_cfg *cfg)
+{
+	int rc;
+
+	/* The lock is taken, so that user space may configure all queues
+	 * in parallel
+	 */
+	mutex_lock(&fc->ring.start_stop_lock);
+
+	if (fc->ring.configured) {
+		rc = -EALREADY;
+		goto unlock;
+	}
+
+	if (fc->ring.daemon == NULL) {
+		rc = fuse_uring_conn_cfg(fc, cfg);
+		if (rc != 0)
+			goto unlock;
+	}
+
+	rc = fuse_uring_queue_cfg(fc, qid, cfg->numa_node_id);
+
+unlock:
+	mutex_unlock(&fc->ring.start_stop_lock);
+
+	return rc;
+}
+
+int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg)
+{
+	struct fuse_dev *fud = fuse_get_dev(file);
+	struct fuse_conn *fc;
+
+	if (fud == NULL)
+		return -ENODEV;
+
+	fc = fud->fc;
+
+	pr_devel("%s fc=%p flags=%x cmd=%d qid=%d nq=%d fg=%d bg=%d\n",
+		 __func__, fc, cfg->flags, cfg->cmd, cfg->qid, cfg->nr_queues,
+		 cfg->fg_queue_depth, cfg->bg_queue_depth);
+
+
+	switch (cfg->cmd) {
+	case FUSE_URING_IOCTL_CMD_QUEUE_CFG:
+		return fuse_uring_cfg(fc, cfg->qid, cfg);
+	default:
+		return -EINVAL;
+	}
+
+	/* no cmd flag set */
+	return -EINVAL;
+}
+
+/**
+ * Finalize the ring destruction when queue ref counters are zero.
+ */
+void fuse_uring_ring_destruct(struct fuse_conn *fc)
+{
+	unsigned int qid;
+
+	if (READ_ONCE(fc->ring.queue_refs) != 0) {
+		pr_info("fc=%p refs=%d configured=%d",
+			fc, fc->ring.queue_refs, fc->ring.configured);
+		WARN_ON(1);
+		return;
+	}
+
+	put_task_struct(fc->ring.daemon);
+	fc->ring.daemon = NULL;
+
+	for (qid = 0; qid < fc->ring.nr_queues; qid++) {
+		int tag;
+		struct fuse_ring_queue *queue = fuse_uring_get_queue(fc, qid);
+
+		if (!queue->configured)
+			continue;
+
+		for (tag = 0; tag < fc->ring.queue_depth; tag++) {
+			struct fuse_ring_ent *ent = &queue->ring_ent[tag];
+
+			if (ent->need_cmd_done) {
+				pr_warn("fc=%p qid=%d tag=%d cmd not done\n",
+					fc, qid, tag);
+				io_uring_cmd_done(ent->cmd, -ENOTCONN, 0);
+				ent->need_cmd_done = 0;
+			}
+		}
+
+		vfree(queue->queue_req_buf);
+	}
+
+	kfree(fc->ring.queues);
+	fc->ring.queues = NULL;
+	fc->ring.nr_queues_ioctl_init = 0;
+	fc->ring.queue_depth = 0;
+	fc->ring.nr_queues = 0;
+}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
new file mode 100644
index 000000000000..4ab440ee00f2
--- /dev/null
+++ b/fs/fuse/dev_uring_i.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * FUSE: Filesystem in Userspace
+ * Copyright (C) 2001-2008  Miklos Szeredi <miklos@szeredi.hu>
+ */
+
+#ifndef _FS_FUSE_DEV_URING_I_H
+#define _FS_FUSE_DEV_URING_I_H
+
+#include "fuse_i.h"
+
+void fuse_uring_end_requests(struct fuse_conn *fc);
+void fuse_uring_ring_destruct(struct fuse_conn *fc);
+int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg);
+#endif
+
+
+
+
+
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 46797a171a84..634d90084690 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -529,6 +529,177 @@ struct fuse_sync_bucket {
 	struct rcu_head rcu;
 };
 
+enum fuse_ring_req_state {
+
+	FRRS_INVALD = 0,
+
+	/* request is basially initialied */
+	FRRS_INIT = 1u << 0,
+
+	/* request is committed from user space and waiting for a new fuse req */
+	FRRS_FUSE_FETCH_COMMIT = 1u << 1,
+
+	/* The ring request waits for a new fuse request */
+	 FRRS_FUSE_WAIT = 1u << 2,
+
+	/* The ring req got assigned a fuse req */
+	FRRS_FUSE_REQ = 1u << 3,
+
+	/* request is in or on the way to user space */
+	FRRS_USERSPACE = 1u << 4,
+
+	/* process is in the process to get freed */
+	FRRS_FREEING   = 1u << 5,
+
+	/* fuse_req_end was already done */
+	FRRS_FUSE_REQ_END = 1u << 6,
+
+	/* And error in the uring cmd command receiving function
+	 * request will then go back to user space
+	 */
+	FRRS_CMD_ERR      = 1u << 7,
+
+	/* request is released */
+	FRRS_FREED = 1u << 8,
+};
+
+/** A fuse ring entry, part of the ring queue */
+struct fuse_ring_ent {
+	/* pointer to kernel request buffer, userspace side has direct access
+	 * to it through the mmaped buffer
+	 */
+	struct fuse_ring_req *rreq;
+
+	int tag;
+
+	struct fuse_ring_queue *queue;
+
+	/* state the request is currently in */
+	u64 state;
+
+	int need_cmd_done:1;
+	int need_req_end:1;
+
+	struct fuse_req *fuse_req; /* when a list request is handled */
+
+	struct io_uring_cmd *cmd;
+};
+
+/* IORING_MAX_ENTRIES */
+#define FUSE_URING_MAX_QUEUE_DEPTH 32768
+
+struct fuse_ring_queue {
+	unsigned long flags;
+
+	struct fuse_conn *fc;
+
+	int qid;
+
+	/* This bitmap holds, which entries are available in the fuse_ring_ent
+	 * array.
+	 * XXX: Is there a way to make this dynamic
+	 */
+	DECLARE_BITMAP(req_avail_map, FUSE_URING_MAX_QUEUE_DEPTH);
+
+	/* available number of foreground requests  */
+	int req_fg;
+
+	/* available number of background requests */
+	int req_bg;
+
+	/* queue lock, taken when any value in the queue changes _and_ also
+	 * a ring entry state changes.
+	 */
+	spinlock_t lock;
+
+	/* per queue memory buffer that is divided per request */
+	char *queue_req_buf;
+
+	struct list_head bg_queue;
+	struct list_head fg_queue;
+
+	int configured:1;
+	int aborted:1;
+
+	/* size depends on queue depth */
+	struct fuse_ring_ent ring_ent[] ____cacheline_aligned_in_smp;
+};
+
+/**
+ * Describes if uring is for communication and holds alls the data needed
+ * for uring communication
+ */
+struct fuse_ring {
+
+	/* number of ring queues */
+	size_t nr_queues;
+
+	/* number of entries per queue */
+	size_t queue_depth;
+
+	/* max arg size for a request */
+	size_t req_arg_len;
+
+	/* req_arg_len + sizeof(struct fuse_req) */
+	size_t req_buf_sz;
+
+	/* max number of background requests per queue */
+	size_t max_bg;
+
+	/* max number of foreground requests */
+	size_t max_fg;
+
+	/* size of struct fuse_ring_queue + queue-depth * entry-size */
+	size_t queue_size;
+
+	/* buffer size per queue, that is used per queue entry */
+	size_t queue_buf_size;
+
+	/* When zero the queue can be freed on destruction */
+	int queue_refs;
+
+	/* Hold ring requests */
+	struct fuse_ring_queue *queues;
+
+	/* number of initialized queues with the ioctl */
+	int nr_queues_ioctl_init;
+
+	/* number of initialized queues with the uring cmd */
+	atomic_t nr_queues_cmd_init;
+
+	/* one queue per core or a single queue only ? */
+	unsigned int per_core_queue:1;
+
+	/* userspace sent a stop ioctl */
+	unsigned int stop_requested:1;
+
+	/* Is the ring completely iocl configured */
+	unsigned int configured:1;
+
+	/* Is the ring read to take requests */
+	unsigned int ready:1;
+
+	/* used on shutdown */
+	unsigned int queues_stopped:1;
+
+	/* userspace process */
+	struct task_struct *daemon;
+
+	struct mutex start_stop_lock;
+
+	/* userspace has a special thread that exists only to wait
+	 * in the kernel for process stop, to release uring
+	 */
+	wait_queue_head_t stop_waitq;
+
+	/* The daemon might get killed and uring then needs
+	 * to be released without getting a umount notification, this
+	 * workqueue exists to release uring even without a process
+	 * being hold in the stop_waitq
+	 */
+	struct delayed_work stop_monitor;
+};
+
 /**
  * A Fuse connection.
  *
@@ -836,6 +1007,13 @@ struct fuse_conn {
 
 	/* New writepages go into this bucket */
 	struct fuse_sync_bucket __rcu *curr_bucket;
+
+	/*
+	 * XXX Move to struct fuse_dev?
+	 * XXX Allocate dynamically?
+	 */
+	/**  uring connection information*/
+	struct fuse_ring ring;
 };
 
 /*
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index de9b9ec5ce81..3f765e65a7b0 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -7,6 +7,7 @@
 */
 
 #include "fuse_i.h"
+#include "dev_uring_i.h"
 
 #include <linux/pagemap.h>
 #include <linux/slab.h>
@@ -855,6 +856,9 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
 
+	mutex_init(&fc->ring.start_stop_lock);
+	fc->ring.daemon = NULL;
+
 	INIT_LIST_HEAD(&fc->mounts);
 	list_add(&fm->fc_entry, &fc->mounts);
 	fm->fc = fc;
@@ -1785,6 +1789,9 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 		fuse_ctl_remove_conn(fc);
 		mutex_unlock(&fuse_mutex);
 	}
+
+	if (fc->ring.daemon != NULL)
+		fuse_uring_ring_destruct(fc);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_destroy);
 
-- 
2.37.2

