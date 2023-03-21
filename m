Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A0D6C2733
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:18:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbjCUBSG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:18:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCUBSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:18:05 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 068BBDBF4
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:17:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3W+ks799/iMgXxoaGHYX7u7+MEB8Xnk12hvuMwKU1jXArs9byAQjMSUw971BD1Owigg8mx7sDbTolPDz0gBuvW8G2X0Pz/QykBhpMy0y8B2ROKSKWSPTn4PvA1YHbqIosrzjf+qu2DT1XF9avUONT7s6q0S+D71kglC8aBSS5Fkv6/zpM8BLGoggkcJORqrA7opxTDFAfsLip4/GAr+l1ip2CEdmPZgy3Gd5lqoSUITuIYmre+1tauTd2MXIK9isXQxE4Qb8TGo1HZ86FyqJOl6LndyOpykJ6GTeNnMNJUaj4yzk6OcF6iX2l4zgoqFcFtG8dyFsIrQsfbSjVPrgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78hJln2jh4jsJYWClI9eRNbetXFdT1bYtT5zN2TTQJU=;
 b=kjNpdL+P8p7Ct2Y4k9UK661gAU/Ks56P7DrSvEOKXs1872ApfdIGJdt05JOTaHxvmgAbsXOhi3UnsP7ZE8IaixZmhgcuqHIPzOKpKDZC8UyMDhyB2/x2/tq1pbQ56ipg6Uk7G99OYIaKVKSlkyiQWb3+yWr3spryRdbDUxf8euMb83y5KI/YAUnUwQNxiFJ4NoND9gZ4iElRVipQ8B6Twav1mgMYJXsiU3wt2PYvXdKe1lg2sN0XWpjYTSAeFgl7dsiK10OskmTp6//mywjwvZjWk7FFTDpK7xjLEsCc3ejVZHQhv0Q9loj9nY7EQ/4CfOkiaddv4lJ0sOVpEOIIRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78hJln2jh4jsJYWClI9eRNbetXFdT1bYtT5zN2TTQJU=;
 b=H6fGQY0+WO1X43aqiJDGcOvTECKvORUoAl/caeboFreoyqD22KsW0IuV2pq6QYio39gj+6OKpaHOMfmt8mmhQjB39L2PgzDorGwkwAsP1TBxcRF4c8cTDPmjgg02ePd2xHpj17CFLhzrFLGSCssuJpMgQnelZ98RcV3sjTyhKWI=
Received: from DM6PR10CA0017.namprd10.prod.outlook.com (2603:10b6:5:60::30) by
 CY5PR19MB6362.namprd19.prod.outlook.com (2603:10b6:930:22::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6086.24; Tue, 21 Mar 2023 01:11:16 +0000
Received: from DM6NAM04FT054.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:60:cafe::e7) by DM6PR10CA0017.outlook.office365.com
 (2603:10b6:5:60::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT054.mail.protection.outlook.com (10.13.159.62) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Tue, 21 Mar 2023 01:11:16 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id A0A832073544;
        Mon, 20 Mar 2023 19:12:23 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 01/13] fuse: Add uring data structures and documentation
Date:   Tue, 21 Mar 2023 02:10:35 +0100
Message-Id: <20230321011047.3425786-2-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT054:EE_|CY5PR19MB6362:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7a09b57e-16a2-4a75-7ccd-08db29a92ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZcFz1wm0iV6J6P6FELdfYIo5iaPJ7XuD1ZfUVq6tHownjoMHFZMMG/7NS7OjMoKFfBVeausAJgj3OqhTsdYtOg3NZdVo//jlTDAPSjeDwvw+aVWF2O9B8CVGg+bXt4AHl0WpwWIisLU8s/hNCEt0yk7diZA9YRKnfn1CH1Jcp3YG3Y0F3+/WdFP3SBZ/OdgisqImKfmWwvewxXyqbmJaKRRdnNZdCiKGuGa1PzJbA8r9kuNtX8PfuxzK9dAVUMyROEKYLtMqjBdQh0jvGqeAtKsNugPd5OL/wo/wxOhDcwAZWEEj6IOSOfAen230TMd+5rdaLfenSU6apH462AqpmGQQ+bD6KeDRA51O7ltu34tE3L8mcQLxoD2UWmSgRw89jkBN7lh4en6AwVojjFhsi4vHn86WQELf8OkDN94o73UwUKBWDbXwkUk1/d1ip5SpirbmpkrhulBvIgvWFp0EXUEafctDBwwkfoJsKY7G+/k802f1P071vzGSBaGhgw8C8FX/AokQrcSIYGm1AEgzn2Bmmrx0CqxgE+SXGLeSvnlObxxfwZZcfP28H9sGLfuImP8NLscH/T7ZiojrJAXFtzOwgNqRl3bcWZtTqkYsf4cmjP4HiTdnBuXHikF5aXABfCE+RBf9S6iTKntA7uWIQBcCaQJGY9/g2ea/BOykxC3AhAiwSpsKwb1wTMd+hd/soQ6rUc4Or++Uhb081Vd75g==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(396003)(346002)(39850400004)(136003)(376002)(451199018)(46966006)(36840700001)(186003)(478600001)(356005)(8676002)(54906003)(41300700001)(6916009)(8936002)(5660300002)(70206006)(86362001)(6266002)(82740400003)(70586007)(40480700001)(6666004)(36756003)(4326008)(2616005)(66899018)(81166007)(316002)(26005)(47076005)(1076003)(30864003)(2906002)(83380400001)(82310400005)(36860700001)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:16.0491
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a09b57e-16a2-4a75-7ccd-08db29a92ba1
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT054.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6362
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This just adds a design document and data structures needed by later
commits to support kernel/userspace communication using the uring
IORING_OP_URING_CMD command.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 Documentation/filesystems/fuse-uring.rst | 179 +++++++++++++++++++++++
 include/uapi/linux/fuse.h                | 131 +++++++++++++++++
 2 files changed, 310 insertions(+)
 create mode 100644 Documentation/filesystems/fuse-uring.rst

diff --git a/Documentation/filesystems/fuse-uring.rst b/Documentation/filesystems/fuse-uring.rst
new file mode 100644
index 000000000000..088b97bbc289
--- /dev/null
+++ b/Documentation/filesystems/fuse-uring.rst
@@ -0,0 +1,179 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===============================
+FUSE Uring design documentation
+==============================
+
+This documentation covers basic details how the fuse
+kernel/userspace communication through uring is configured
+and works. For generic details about FUSE see fuse.rst.
+
+This document also covers the current interface, which is
+still in development and might change.
+
+Limitations
+===========
+As of now not all requests types are supported through uring, userspace
+side is required to also handle requests through /dev/fuse after
+uring setup is complete. These are especially notifications (initiated
+from daemon side), interrupts and forgets.
+Interrupts are probably not working at all when uring is used. At least
+current state of libfuse will not be able to handle those for requests
+on ring queues.
+All these limitation will be addressed later.
+
+Fuse uring configuration
+========================
+
+Fuse kernel requests are queued through the classical /dev/fuse
+read/write interface - until uring setup is complete.
+
+IOCTL configuration
+-------------------
+
+Userspace daemon side has to initiate ring confuration through
+the FUSE_DEV_IOC_URING ioctl, with cmd FUSE_URING_IOCTL_CMD_QUEUE_CFG.
+
+Number of queues can be
+    - 1
+        - One ring for all cores and all requests.
+    - Number of cores
+        - One ring per core, requests are queued on the ring queue
+          that is submitting the request. Especially for background
+          requests we might consider to use queues of other cores
+          as well - future work.
+        - Kernel and userspace have to agree on the number of cores,
+          on mismatch the ioctl is rejected.
+        - For each queue a separate ioctl needs to be send.
+
+Example:
+
+fuse_uring_configure_kernel_queue()
+{
+	struct fuse_uring_cfg ioc_cfg = {
+		.cmd = FUSE_URING_IOCTL_CMD_QUEUE_CFG,
+		.qid = 2,
+		.nr_queues = 3,
+		.fg_queue_depth = 16,
+		.bg_queue_depth = 4,
+		.req_arg_len = 1024 * 1024,
+		.numa_node_id = 1,
+	};
+
+    rc = ioctl(se->fd, FUSE_DEV_IOC_URING, &ioc_cfg);
+}
+
+
+On kernel side the first ioctl that arrives configures the basic fuse ring
+and then its queue id. All further ioctls only their queue. Each queue gets
+a memory allocation that is then assigned per queue entry.
+
+MMAP
+====
+
+For shared memory communication allocated memory per queue is mmaped with
+mmap. The corresponding queue is identified with the offset parameter.
+Important is a strict agreement between kernel and userspace daemon side
+on memory assignment per queue entry - a mismatch would lead to data
+corruption.
+Ideal would be an mmap per ring entry and to verify the pointer on SQE
+submission, but the result obtained in the file_operations::mmap method
+is scrambled further down the stack - fuse kernel does not know the exact
+pointer value returned to mmap initiated by userspace.
+
+
+Kernel - userspace interface using uring
+========================================
+
+After queue ioctl setup and memory mapping userspace submits
+SQEs (opcode = IORING_OP_URING_CMD) in order to fetch
+fuse requests. Initial submit is with the sub command
+FUSE_URING_REQ_FETCH, which will just register entries
+to be available on the kernel side - it sets the according
+entry state and marks the entry as available in the queue bitmap.
+
+Once all entries for all queues are submitted kernel side starts
+to enqueue to ring queue(s). The request is copied into the shared
+memory queue entry buffer and submitted as CQE to the userspace
+side.
+Userspace side handles the CQE and submits the result as subcommand
+FUSE_URING_REQ_COMMIT_AND_FETCH - kernel side does completes the requests
+and also marks the queue entry as available again. If there are
+pending requests waiting the request will be immediately submitted
+to userspace again.
+
+Initial SQE
+-----------
+
+ |                                    |  FUSE filesystem daemon
+ |                                    |
+ |                                    |  >io_uring_submit()
+ |                                    |   IORING_OP_URING_CMD /
+ |                                    |   FUSE_URING_REQ_FETCH
+ |                                    |  [wait cqe]
+ |                                    |   >io_uring_wait_cqe() or
+ |                                    |   >io_uring_submit_and_wait()
+ |                                    |
+ |  >fuse_uring_cmd()                 |
+ |   >fuse_uring_fetch()              |
+ |    >fuse_uring_ent_release()       |
+
+
+Sending requests with CQEs
+--------------------------
+
+ |                                         |  FUSE filesystem daemon
+ |                                         |  [waiting for CQEs]
+ |  "rm /mnt/fuse/file"                    |
+ |                                         |
+ |  >sys_unlink()                          |
+ |    >fuse_unlink()                       |
+ |      [allocate request]                 |
+ |      >__fuse_request_send()             |
+ |        ...                              |
+ |       >fuse_uring_queue_fuse_req        |
+ |        [queue request on fg or          |
+ |          bg queue]                      |
+ |         >fuse_uring_assign_ring_entry() |
+ |         >fuse_uring_send_to_ring()      |
+ |          >fuse_uring_copy_to_ring()     |
+ |          >io_uring_cmd_done()           |
+ |          >request_wait_answer()         |
+ |           [sleep on req->waitq]         |
+ |                                         |  [receives and handles CQE]
+ |                                         |  [submit result and fetch next]
+ |                                         |  >io_uring_submit()
+ |                                         |   IORING_OP_URING_CMD/
+ |                                         |   FUSE_URING_REQ_COMMIT_AND_FETCH
+ |  >fuse_uring_cmd()                      |
+ |   >fuse_uring_commit_and_release()      |
+ |    >fuse_uring_copy_from_ring()         |
+ |     [ copy the result to the fuse req]  |
+ |     >fuse_uring_req_end_and_get_next()  |
+ |      >fuse_request_end()                |
+ |       [wake up req->waitq]              |
+ |      >fuse_uring_ent_release_and_fetch()|
+ |       [wait or handle next req]         |
+ |                                         |
+ |                                         |
+ |       [req->waitq woken up]             |
+ |    <fuse_unlink()                       |
+ |  <sys_unlink()                          |
+
+
+Shutdown
+========
+
+A dayled workqueue is started when the ring gets configured with ioctls and
+runs periodically to complete ring entries on umount or daemon stop.
+See fuse_uring_stop_mon() and subfunctions for details - basically it needs
+to run io_uring_cmd_done() for waiting SQEs and fuse_request_end() for
+queue entries that have a fuse request assigned.
+
+In order to avoid periodic cpu cycles for shutdown the userspace daemon can
+create a thread and submit that thread into a waiting state with the
+FUSE_DEV_IOC_URING ioctl and FUSE_URING_IOCTL_CMD_WAIT subcommand.
+Kernel side will stop the periodic waiter on receiving this ioctl
+and will go into a waitq. On umount or daemon termination it will
+wake up and start the delayed stop workq again before returning to
+userspace.
diff --git a/include/uapi/linux/fuse.h b/include/uapi/linux/fuse.h
index e3c54109bae9..0f59507b4b18 100644
--- a/include/uapi/linux/fuse.h
+++ b/include/uapi/linux/fuse.h
@@ -966,9 +966,64 @@ struct fuse_notify_retrieve_in {
 	uint64_t	dummy4;
 };
 
+
+enum fuse_uring_ioctl_cmd {
+	/* not correctly initialized when set */
+	FUSE_URING_IOCTL_CMD_INVALID    = 0,
+
+	/* The ioctl is a queue configuration command */
+	FUSE_URING_IOCTL_CMD_QUEUE_CFG = 1,
+
+	/* Wait in the kernel until the process gets terminated, process
+	 * termination will wake up the waitq and initiate ring shutdown.
+	 * This avoids the need to run a check in intervals if ring termination
+	 * should be started (less cpu cycles) and also helps for faster ring
+	 * shutdown.
+	 */
+	FUSE_URING_IOCTL_CMD_WAIT      = 2,
+
+	/* Daemon side wants to explicitly stop the waiter thread. This will
+	 * restart the interval termination checker.
+	 */
+	FUSE_URING_IOCTL_CMD_STOP      = 3,
+};
+
+struct fuse_uring_cfg {
+	/* currently unused */
+	uint32_t flags;
+
+	/* configuration command */
+	uint16_t cmd;
+
+	uint16_t padding;
+
+	/* qid the config command is for */
+	uint32_t qid;
+
+	/* number of queues */
+	uint32_t nr_queues;
+
+	/* number of foreground entries per queue */
+	uint32_t fg_queue_depth;
+
+	/* number of background entries per queue */
+	uint32_t bg_queue_depth;
+
+	/* argument (data length) of a request */
+	uint32_t req_arg_len;
+
+	/* numa node this queue runs on; UINT32_MAX if any*/
+	uint32_t numa_node_id;
+
+	/* reserved space for future additions */
+	uint64_t reserve[8];
+};
+
 /* Device ioctls: */
 #define FUSE_DEV_IOC_MAGIC		229
 #define FUSE_DEV_IOC_CLONE		_IOR(FUSE_DEV_IOC_MAGIC, 0, uint32_t)
+#define FUSE_DEV_IOC_URING		_IOR(FUSE_DEV_IOC_MAGIC, 1, \
+					     struct fuse_uring_cfg)
 
 struct fuse_lseek_in {
 	uint64_t	fh;
@@ -1047,4 +1102,80 @@ struct fuse_secctx_header {
 	uint32_t	nr_secctx;
 };
 
+
+/**
+ * Size of the ring buffer header
+ */
+#define FUSE_RING_HEADER_BUF_SIZE 4096
+#define FUSE_RING_MIN_IN_OUT_ARG_SIZE 4096
+
+enum fuse_ring_req_cmd {
+	FUSE_RING_BUF_CMD_INVALID = 0,
+
+	/* return an iovec pointer */
+	FUSE_RING_BUF_CMD_IOVEC = 1,
+
+	/* report an error */
+	FUSE_RING_BUF_CMD_ERROR = 2,
+};
+
+/* Request is background type. Daemon side is free to use this information
+ * to handle foreground/background CQEs with different priorities.
+ */
+#define FUSE_RING_REQ_FLAG_BACKGROUND (1ull << 0)
+
+/**
+ * This structure mapped onto the
+ */
+struct fuse_ring_req {
+
+	union {
+		/* The first 4K are command data */
+		char ring_header[FUSE_RING_HEADER_BUF_SIZE];
+
+		struct {
+			uint64_t flags;
+
+			/* enum fuse_ring_buf_cmd */
+			uint32_t cmd;
+			uint32_t in_out_arg_len;
+
+			/* kernel fills in, reads out */
+			union {
+				struct fuse_in_header in;
+				struct fuse_out_header out;
+			};
+		};
+	};
+
+	char in_out_arg[];
+};
+
+/**
+ * sqe commands to the kernel
+ */
+enum fuse_uring_cmd {
+	FUSE_URING_REQ_INVALID = 0,
+
+	/* submit sqe to kernel to get a request */
+	FUSE_URING_REQ_FETCH = 1,
+
+	/* commit result and fetch next request */
+	FUSE_URING_REQ_COMMIT_AND_FETCH = 2,
+};
+
+/**
+ * In the 80B command area of the SQE.
+ */
+struct fuse_uring_cmd_req {
+	/* queue the command is for (queue index) */
+	uint16_t qid;
+
+	/* queue entry (array index) */
+	uint16_t tag;
+
+	/* pointer to struct fuse_uring_buf_req */
+	uint32_t padding;
+};
+
 #endif /* _LINUX_FUSE_H */
-- 
2.37.2

