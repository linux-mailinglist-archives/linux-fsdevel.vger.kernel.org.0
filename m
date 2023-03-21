Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9296C271A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:13:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjCUBNv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:13:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbjCUBNn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:13:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on20604.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eb2::604])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90D84EF6
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oH2joCaQNKdyiqsEb+NzgxhJ/nCMVM3bwSc1H7G0gyFWUvUatKPtJYGNI3f5nPY5vB4HQkCZObZ2B+7DsY9WvSDOSQQgk2WJS7ChGfxdUWjEvMvJrlzB9Hdts590jqt8lUyc2r8nslTsIt46VgHzf+QUjwFaTFdwmCjnb290mG7IO0cCCnsPal4ToYK7a050CYN5QPOul4hWxRiJR5SUzYaLvKM0yQ1EZptqZFDZO2WCcBQLqVLrgAkjywSqxHUK0O1Sj9kTzbOlyJB54JZGPXYFeKgjKf8Ve1wbwXtsdXA9Pt+AdMOS5iuSu5MGNLnq4cdiRMA2Fkxf1uJv70qW0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwnD9Kqq4vp3ENum+LUEpmKhd0ObaWLR65m00PpF4qE=;
 b=LnFAoWsg6BTvCnyZqPE68NtvTqasjfoGG7GPklobQrtgxkVqRmoNH7+EE05dbd98PmIhkshCOkwj4PElKyftP2q2Siiy2vXUKeH39/jhXPX0NfoWGv1EZpbjeORechjtqm8qAFyZHPfuZy2OnWmIlplZc/Z+bL7eb3nIKkV4gaOrKn5NmY9ulLcGTMoIOAikn6icXwafwyxQo/Rg9hV2RZq+f7s7LEvjSU2tDLFbPQD3IzAqdXJSkwG5tEcxM7rQWIPcYATu2Egksq2nLr7sWsjHeRlSc3cY79s+lyI4+NJ1LEc8q7CECeXP6o5xmE7+QsxuY18+HdHvfvxXTZroSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwnD9Kqq4vp3ENum+LUEpmKhd0ObaWLR65m00PpF4qE=;
 b=h3LHlG4Gz5pzXAqhgdB27k2ZAtBQ+J03tzx1NxzkD01gbEe2E7wS0nI64WOJwdhM0aQH02YrPOr2LlvhA9U9AhU0uett6B6VPx4J32KDQmMKcfo2pH/7/UWashCgZi496v9BLYgrLN9X1tAAmlrZvbxFwfcbALmnO6oQmurxh8U=
Received: from DM6PR02CA0070.namprd02.prod.outlook.com (2603:10b6:5:177::47)
 by MW4PR19MB6862.namprd19.prod.outlook.com (2603:10b6:303:1ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 21 Mar
 2023 01:11:22 +0000
Received: from DM6NAM04FT012.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::58) by DM6PR02CA0070.outlook.office365.com
 (2603:10b6:5:177::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 DM6NAM04FT012.mail.protection.outlook.com (10.13.159.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.15 via Frontend Transport; Tue, 21 Mar 2023 01:11:21 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 6FF5E2073544;
        Mon, 20 Mar 2023 19:12:29 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 07/13] fuse: Add uring mmap method
Date:   Tue, 21 Mar 2023 02:10:41 +0100
Message-Id: <20230321011047.3425786-8-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM04FT012:EE_|MW4PR19MB6862:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 2ad5efde-0081-4f2d-8d23-08db29a92f10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TjglvgW8U/Xl+8Bhaa2M494e5G4SlnXej07jBvLaKGBycKrmT4NfVIg/MQ/cDo6GQcK2MXSMfxF4t4VfTQnqze+OnbaTiJ/L58pvmdM37gfaMo7THZ2+p6cmvbnsMFWc3LXc6ND2peK3KcOUm8VBHjOtPmpi20f+VAbUzfuka9h19J5jeLV6zHO7EjloU9Rkwavsb0en7vKiU0ecjyUtI6P3B/NnHHlfy6mEu+rWreYYDJPQgWue4hvp/gglL6joMmcd81sXMprLJ0YR04AsyaWhxyU3bRDoowOIs2VNFTN/4yBiyn+PER7QT2l6CE4QpI/8eMIq4A/gGlz1pT5yo0wB5DC3qh2ohB6rrgaNyUHX4gAjDszjItSWYKOTMft7PfCqzJ8+Po9zkzNs6Xp92hEe32msH3AZUdj39iofOcVZebYsJatERnxiiASG8n22195q+cjMlg1pk8rQxy1VEUcyLJcMFHOuE3tMjFBCCjK5+FX0jTbigCCEP6NgBDgXAowleSwkK6ilYmcRrszFlJc+PuIVCDM82QrZhfICxW7QjxIqka4P4flzDHCYS0dFebuVPBxflF2J/8Kb3r7MufY8XBelQWoLqU6mm0S9M8Bd7ZJVAi/VIf1sc1IzO/Q4CaRkiw6/zU+2uwk4HeOOecKcbu5tUN+hewaSvsR18KiT19rjR6mpJW9AVWCSCBA0w9S1ciwXyjBcS9rwK9VkU43KXo31cmXhjxco1Bcae7c=
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(136003)(396003)(39850400004)(451199018)(36840700001)(46966006)(6666004)(81166007)(478600001)(336012)(70206006)(47076005)(186003)(2616005)(6266002)(26005)(83380400001)(54906003)(8676002)(1076003)(41300700001)(316002)(82740400003)(6916009)(4326008)(356005)(70586007)(82310400005)(2906002)(8936002)(36860700001)(40480700001)(5660300002)(36756003)(86362001)(21314003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:21.8101
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ad5efde-0081-4f2d-8d23-08db29a92f10
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM04FT012.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB6862
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds the uring mmap method. Mmap is currently done per ring queue,
the queue is identified using the offset parameter. Reason to have an
mmap per queue is to have a numa aware allocation per queue.
Trade off is that the offset limits the number of possible queues
(although a very high number) and it might cause issues if another
mmap is later on needed.

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c         |  1 +
 fs/fuse/dev_uring.c   | 49 +++++++++++++++++++++++++++++++++++++++++++
 fs/fuse/dev_uring_i.h |  1 +
 3 files changed, 51 insertions(+)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index d9c40d782c94..256936af4f2e 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -2323,6 +2323,7 @@ const struct file_operations fuse_dev_operations = {
 	.fasync		= fuse_dev_fasync,
 	.unlocked_ioctl = fuse_dev_ioctl,
 	.compat_ioctl   = compat_ptr_ioctl,
+	.mmap		= fuse_uring_mmap,
 };
 EXPORT_SYMBOL_GPL(fuse_dev_operations);
 
diff --git a/fs/fuse/dev_uring.c b/fs/fuse/dev_uring.c
index 44ff23ce5ebf..ade341d86c03 100644
--- a/fs/fuse/dev_uring.c
+++ b/fs/fuse/dev_uring.c
@@ -496,3 +496,52 @@ void fuse_uring_ring_destruct(struct fuse_conn *fc)
 	fc->ring.queue_depth = 0;
 	fc->ring.nr_queues = 0;
 }
+
+/**
+ * fuse uring mmap, per ring qeuue. The queue is identified by the offset
+ * parameter
+ */
+int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct fuse_dev *fud = fuse_get_dev(filp);
+	struct fuse_conn *fc = fud->fc;
+	size_t sz = vma->vm_end - vma->vm_start;
+	unsigned int qid;
+	int ret;
+	loff_t off;
+	struct fuse_ring_queue *queue;
+
+	/* check if uring is configured and if the requested size matches */
+	if (fc->ring.nr_queues == 0 || fc->ring.queue_depth == 0) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (sz != fc->ring.queue_buf_size) {
+		ret = -EINVAL;
+		pr_devel("mmap size mismatch, expected %zu got %zu\n",
+			 fc->ring.queue_buf_size, sz);
+		goto out;
+	}
+
+	/* XXX: Enforce a cloned session per ring and assign fud per queue
+	 * and use fud as key to find the right queue?
+	 */
+	off = (vma->vm_pgoff << PAGE_SHIFT) / PAGE_SIZE;
+	qid = off / (fc->ring.queue_depth);
+
+	queue = fuse_uring_get_queue(fc, qid);
+
+	if (queue == NULL) {
+		pr_devel("fuse uring mmap: invalid qid=%u\n", qid);
+		return -ERANGE;
+	}
+
+	ret = remap_vmalloc_range(vma, queue->queue_req_buf, 0);
+out:
+	pr_devel("%s: pid %d qid: %u addr: %p sz: %zu  ret: %d\n",
+		 __func__, current->pid, qid, (char *)vma->vm_start,
+		 sz, ret);
+
+	return ret;
+}
diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
index d5cb9bdca64e..4032dccca8b6 100644
--- a/fs/fuse/dev_uring_i.h
+++ b/fs/fuse/dev_uring_i.h
@@ -12,6 +12,7 @@
 void fuse_uring_end_requests(struct fuse_conn *fc);
 int fuse_uring_ioctl(struct file *file, struct fuse_uring_cfg *cfg);
 void fuse_uring_ring_destruct(struct fuse_conn *fc);
+int fuse_uring_mmap(struct file *filp, struct vm_area_struct *vma);
 #endif
 
 
-- 
2.37.2

