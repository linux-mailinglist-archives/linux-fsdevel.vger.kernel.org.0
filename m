Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97C016C274F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjCUBS5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbjCUBSx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:18:53 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20605.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::605])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B270E16331
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:18:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjA9p5VYM4NN942hxzMuXZrtwGBpEun/wDuHdBKoNIpaA3/nQNxjUYMPdduR+Ovtd7OrqBeou7HZYhKIEhTYD5yaHmXVf5v1i0wDhwFbeekb4pJOzsWMTlXV4+A5iNC9aXoBPQYyS3OvyKifLtsGcg+QgXPhRF0Df5c5hiWEg9pr6w3qvw+jdlylhwNnsfmzmL4S0vCq0kjiC57jpU5YwVCUdR00nvzI1OwJ2RiGNZr82xNQ10YsQr2P80Oyq9kArTznnsyVCk81JD1H6v/RIfiKfHdZDu/ZXBvXYWgjc2Ra6AwQrGO43D1DKUEtmt9aYaXd4a5eFEZr4cCgEP2/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbaAXRrBeRFTdmTI1QI2TpMr+rQP+Ab2X/Ol4UCV7eg=;
 b=mrY1nZ/clWddRVCz4TmPlpeI8xPKLkCNK/1BRvLAPVFaCORWtI3aSXfs/TVA1/aTaaDnw3t1UoiOxH1PG+MfEqA/dCtLe37UgTh90ZSLh5MnzojZmEkKvwEqGwcg/Mgg7X60ajH2SC8fBXnYIxCvo8SVJp/NCkuCyEzn0F4BiDMCqf8Uw7A4aTn/yqxoVRSFcrH8a9tr697l+U3wcMf/8yZToc9dfslEglOVT9XQ7HsPmgVV4bEb9x+hEF5cH98+bTIz8nLyQrWiBOksqyNiatHtEMiAGBGdEixahWYvVbfXIyGLyVnf2QZyH7T9BEn6Z6OwwzMwas1ZLi07c7u/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbaAXRrBeRFTdmTI1QI2TpMr+rQP+Ab2X/Ol4UCV7eg=;
 b=pTdlyO1QcwWjrdG9wAnI2jM3M0wnyPiaaUB1hcBVP5ZDLXw5zIoHPptu34alITIBc8lDm3jsxjHW33OMLWZc6LuuAYxbNJQbembqEx1SLSzzA1Dr9xmzT5boByKc5WpUxPt1M0j7v8y6dEnGcpRORLon4701V8cKTG5dMWtLkNU=
Received: from MW4PR02CA0013.namprd02.prod.outlook.com (2603:10b6:303:16d::13)
 by IA1PR19MB6500.namprd19.prod.outlook.com (2603:10b6:208:3ac::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 21 Mar
 2023 01:11:21 +0000
Received: from MW2NAM04FT048.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:303:16d:cafe::95) by MW4PR02CA0013.outlook.office365.com
 (2603:10b6:303:16d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 MW2NAM04FT048.mail.protection.outlook.com (10.13.30.233) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:20 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 7936E20C6862;
        Mon, 20 Mar 2023 19:12:28 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 06/13] fuse: Add an interval ring stop worker/monitor
Date:   Tue, 21 Mar 2023 02:10:40 +0100
Message-Id: <20230321011047.3425786-7-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW2NAM04FT048:EE_|IA1PR19MB6500:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3c3dba3b-5021-4f13-6136-08db29a92e8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mazH7BlEhfo1wvJuwmhylMjIdeybA6RQvtBFjUHHKQj+XvHZfALHUyuOWyr1Ko7HNog+j8742eW2HZxqaB7kQeFvSocbvFGNBtHIfzk/tmko9tL3hWzN3NZuMUziT+FC8MzBPXq001JHtCsO115AkM5rqdhD6G9tVm9OGgTpaMP7itTpLR5MGcIZOdJ2vng6bifbQITuRVrMsx7dxUzAEy+Nj1BYhmJQEPy5WMFt2ENJY31/1NoeuWig7IeMny+1YP9P26sFOMY62uWsR7eqEeHl6/sh9jtivc5AI7s3mGyCHEqR3wC3nk5z79RmM8vQ/4+bVDrQY3MnFbMwy8jFSOEGanp1Vs5BprWC9x2njUVafZaClEjBDPgBO6Oh6pqrVtQJDcHxCQEisOYpY7VXZptFhMCJyYg4y81tQuazAcAPkfHB5ajBUAvmd9DOyNAaCefTRYsYDytv+2pTM3pfZCiAbdynRh57PpefJbXz/nVCqM+iO0HIEesmTJqNjEQFcqEbQGZNfhdllJ/vzF45gYYdfaWx9e8JvFLoXlMxU9+nO7Un2B63gM5kojcTXDai0yMXfh1I+3tROd/yonCtdZUBNsZ8AypV4ZZeWkvTYgh9/8eYBZ0FhQqR/bOr11FpWdgt6bCdJoSwLLm2cv8IZCk+5kH9LCEcz8F/E+j+qeZKuilpegLp01cM/BQxnP0ESVHHtwWdo3937PmugXz//4B+vD7FssOUunlqzD6Jmw=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(376002)(39850400004)(346002)(136003)(451199018)(46966006)(36840700001)(6916009)(26005)(81166007)(6266002)(8676002)(2906002)(1076003)(54906003)(316002)(5660300002)(356005)(41300700001)(82740400003)(4326008)(186003)(6666004)(336012)(40480700001)(70206006)(36860700001)(8936002)(70586007)(36756003)(47076005)(478600001)(86362001)(82310400005)(83380400001)(2616005)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:20.9348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c3dba3b-5021-4f13-6136-08db29a92e8d
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM04FT048.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR19MB6500
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds a delayed work queue that runs in intervals
to check and to stop the ring if needed. Fuse connection
abort now waits for this worker to complete.

On stop the worker iterates over all queues and their ring
entries and tries to release entries when they are in the
right' state.

FRRS_INIT - the ring entry is not used at all yet, nothing
to be done.

FRRS_FUSE_WAIT - a CQE needs to be send. This is really important
to do, as uring other keeps workers in D state and prints a warning.

FRRS_USERSPACE bit set - a CQE was already sent and must not be
send again from shutdown code, but typically a fuse request
needs to be completed.

Any other state - the ring entry is currently worked on, shutdown
has to wait until this is completed.

Also, the queue lock is held on any queue entry state change,
shutdown handling is the main reason for that.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c         |  12 ++-
 fs/fuse/dev_uring.c   | 168 ++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h |   2 +-
 fs/fuse/inode.c       |   3 +
 4 files changed, 183 insertions(+), 2 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 07323b041377..d9c40d782c94 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2174,9 +2174,12 @@ void fuse_abort_conn(struct fuse_conn *fc)
 		fuse_dev_end_requests(&to_end);
 
 		mutex_lock(&fc->ring.start_stop_lock);
-		if (fc->ring.configured && !fc->ring.queues_stopped)
+		if (fc->ring.configured && !fc->ring.queues_stopped) {
 			fuse_uring_end_requests(fc);
+			schedule_delayed_work(&fc->ring.stop_monitor, 0);
+		}
 		mutex_unlock(&fc->ring.start_stop_lock);
+
 	} else {
 		spin_unlock(&fc->lock);
 	}
@@ -2187,7 +2190,14 @@ void fuse_wait_aborted(struct fuse_conn *fc)
 {
 	/* matches implicit memory barrier in fuse_drop_waiting() */
 	smp_mb();
+
 	wait_event(fc->blocked_waitq, atomic_read(&fc->num_waiting) == 0);
+
+	/* XXX use struct completion? */
+	if (fc->ring.daemon != NULL) {
+		schedule_delayed_work(&fc->ring.stop_monitor, 0);
+		wait_event(fc->ring.stop_waitq, fc->ring.queues_stopped == 1);
+	}
 }
 
 int fuse_dev_release(struct inode *inode, struct file *file)
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 12fd21526b2b..44ff23ce5ebf 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -26,6 +26,9 @@
 #include <linux/io_uring.h>
 #include <linux/topology.h>
 
+/* default monitor interval for a dying daemon */
+#define FURING_DAEMON_MON_PERIOD (5 * HZ)
+
 static bool __read_mostly enable_uring;
 module_param(enable_uring, bool, 0644);
 MODULE_PARM_DESC(enable_uring,
@@ -44,6 +47,15 @@ fuse_uring_get_queue(struct fuse_conn *fc, int qid)
 	return (struct fuse_ring_queue *)(ptr + qid * fc->ring.queue_size);
 }
 
+/* dummy function will be replaced in later commits */
+static void fuse_uring_bit_set(struct fuse_ring_ent *ent, bool is_bg,
+			       const char *str)
+{
+	(void)ent;
+	(void)is_bg;
+	(void)str;
+}
+
 /* Abort all list queued request on the given ring queue */
 static void fuse_uring_end_queue_requests(struct fuse_ring_queue *queue)
 {
@@ -69,6 +81,156 @@ void fuse_uring_end_requests(struct fuse_conn *fc)
 	}
 }
 
+/**
+ * Simplified ring-entry release function, for shutdown only
+ */
+static void _fuse_uring_shutdown_release_ent(struct fuse_ring_ent *ent)
+__must_hold(&queue->lock)
+{
+	bool is_bg = !!(ent->rreq->flags & FUSE_RING_REQ_FLAG_BACKGROUND);
+
+	ent->state |= FRRS_FUSE_REQ_END;
+	ent->need_req_end = 0;
+	fuse_request_end(ent->fuse_req);
+	ent->fuse_req = NULL;
+	fuse_uring_bit_set(ent, is_bg, __func__);
+}
+
+/*
+ * Release a request/entry on connection shutdown
+ */
+static void fuse_uring_shutdown_release_ent(struct fuse_ring_ent *ent)
+__must_hold(&fc->ring.start_stop_lock)
+__must_hold(&queue->lock)
+{
+	struct fuse_ring_queue *queue = ent->queue;
+	struct fuse_conn *fc = queue->fc;
+	bool may_release = false;
+	int state;
+
+	pr_devel("%s fc=%p qid=%d tag=%d state=%llu\n",
+		 __func__, fc, queue->qid, ent->tag, ent->state);
+
+	if (ent->state & FRRS_FREED)
+		goto out; /* no work left, freed before */
+
+	state = ent->state;
+
+	if (state == FRRS_INIT || state == FRRS_FUSE_WAIT ||
+	    ((state & FRRS_USERSPACE) && queue->aborted)) {
+		ent->state |= FRRS_FREED;
+
+		if (ent->need_cmd_done) {
+			pr_devel("qid=%d tag=%d sending cmd_done\n",
+				queue->qid, ent->tag);
+			io_uring_cmd_done(ent->cmd, -ENOTCONN, 0);
+			ent->need_cmd_done = 0;
+		}
+
+		if (ent->need_req_end)
+			_fuse_uring_shutdown_release_ent(ent);
+		may_release = true;
+	} else {
+		/* somewhere in between states, another thread should currently
+		 * handle it
+		 */
+		pr_devel("%s qid=%d tag=%d state=%llu\n",
+			 __func__, queue->qid, ent->tag, ent->state);
+	}
+
+out:
+	/* might free the queue - needs to have the queue waitq lock released */
+	if (may_release) {
+		int refs = --fc->ring.queue_refs;
+
+		pr_devel("free-req fc=%p qid=%d tag=%d refs=%d\n",
+			 fc, queue->qid, ent->tag, refs);
+		if (refs == 0) {
+			fc->ring.queues_stopped = 1;
+			wake_up_all(&fc->ring.stop_waitq);
+		}
+	}
+}
+
+static void fuse_uring_stop_queue(struct fuse_ring_queue *queue)
+__must_hold(&fc->ring.start_stop_lock)
+__must_hold(&queue->lock)
+{
+	struct fuse_conn *fc = queue->fc;
+	int tag;
+	bool empty =
+		(list_empty(&queue->fg_queue) && list_empty(&queue->fg_queue));
+
+	if (!empty && !queue->aborted)
+		return;
+
+	for (tag = 0; tag < fc->ring.queue_depth; tag++) {
+		struct fuse_ring_ent *ent = &queue->ring_ent[tag];
+
+		fuse_uring_shutdown_release_ent(ent);
+	}
+}
+
+/*
+ *  Stop the ring queues
+ */
+static void fuse_uring_stop_queues(struct fuse_conn *fc)
+__must_hold(fc->ring.start_stop_lock)
+{
+	int qid;
+
+	if (fc->ring.daemon == NULL)
+		return;
+
+	fc->ring.stop_requested = 1;
+	fc->ring.ready = 0;
+
+	for (qid = 0; qid < fc->ring.nr_queues; qid++) {
+		struct fuse_ring_queue *queue =
+			fuse_uring_get_queue(fc, qid);
+
+		if (!queue->configured)
+			continue;
+
+		spin_lock(&queue->lock);
+		fuse_uring_stop_queue(queue);
+		spin_unlock(&queue->lock);
+	}
+}
+
+/*
+ * monitoring functon to check if fuse shall be destructed, run
+ * as delayed task
+ */
+static void fuse_uring_stop_mon(struct work_struct *work)
+{
+	struct fuse_conn *fc = container_of(work, struct fuse_conn,
+					    ring.stop_monitor.work);
+	struct fuse_iqueue *fiq = &fc->iq;
+
+	pr_devel("fc=%p running stop-mon, queues-stopped=%u queue-refs=%d\n",
+		fc, fc->ring.queues_stopped, fc->ring.queue_refs);
+
+	mutex_lock(&fc->ring.start_stop_lock);
+
+	if (!fiq->connected || fc->ring.stop_requested ||
+	    (fc->ring.daemon->flags & PF_EXITING)) {
+		pr_devel("%s Stopping queues connected=%d stop-req=%d exit=%d\n",
+			__func__, fiq->connected, fc->ring.stop_requested,
+			(fc->ring.daemon->flags & PF_EXITING));
+		fuse_uring_stop_queues(fc);
+	}
+
+	if (!fc->ring.queues_stopped)
+		schedule_delayed_work(&fc->ring.stop_monitor,
+				      FURING_DAEMON_MON_PERIOD);
+	else
+		pr_devel("Not scheduling work queues-stopped=%u queue-refs=%d.\n",
+			fc->ring.queues_stopped,  fc->ring.queue_refs);
+
+	mutex_unlock(&fc->ring.start_stop_lock);
+}
+
 /**
  * use __vmalloc_node_range() (needs to be
  * exported?) or add a new (exported) function vm_alloc_user_node()
@@ -127,6 +289,11 @@ __must_hold(fc->ring.stop_waitq.lock)
 	fc->ring.daemon = current;
 	get_task_struct(fc->ring.daemon);
 
+	INIT_DELAYED_WORK(&fc->ring.stop_monitor,
+			  fuse_uring_stop_mon);
+	schedule_delayed_work(&fc->ring.stop_monitor,
+			      FURING_DAEMON_MON_PERIOD);
+
 	fc->ring.nr_queues = cfg->nr_queues;
 	fc->ring.per_core_queue = cfg->nr_queues > 1;
 
@@ -298,6 +465,7 @@ void fuse_uring_ring_destruct(struct fuse_conn *fc)
 		return;
 	}
 
+	cancel_delayed_work_sync(&fc->ring.stop_monitor);
 	put_task_struct(fc->ring.daemon);
 	fc->ring.daemon = NULL;
 
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index 4ab440ee00f2..d5cb9bdca64e 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -10,8 +10,8 @@
 #include "fuse_i.h"
 
 void fuse_uring_end_requests(struct fuse_conn *fc);
-void fuse_uring_ring_destruct(struct fuse_conn *fc);
 int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg);
+void fuse_uring_ring_destruct(struct fuse_conn *fc);
 #endif
 
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3f765e65a7b0..91c912793dca 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -856,6 +856,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct fuse_mount *fm,
 	fc->max_pages = FUSE_DEFAULT_MAX_PAGES_PER_REQ;
 	fc->max_pages_limit = FUSE_MAX_MAX_PAGES;
 
+	init_waitqueue_head(&fc->ring.stop_waitq);
 	mutex_init(&fc->ring.start_stop_lock);
 	fc->ring.daemon = NULL;
 
@@ -1792,6 +1793,8 @@ void fuse_conn_destroy(struct fuse_mount *fm)
 
 	if (fc->ring.daemon != NULL)
 		fuse_uring_ring_destruct(fc);
+
+	mutex_destroy(&fc->ring.start_stop_lock);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_destroy);
 
-- 
2.37.2

