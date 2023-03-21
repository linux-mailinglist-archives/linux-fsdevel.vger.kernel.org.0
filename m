Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93A26C2726
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Mar 2023 02:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbjCUBPZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Mar 2023 21:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231158AbjCUBOy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:14:54 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20624.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::624])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33C92D7C
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Mar 2023 18:14:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JLv9s36E8fFPy7AB5RfkXW2oraQlCyE0Au/2Wpm3Pe8OCnPIUy7aCqcr4d3ufslbq3OZ7H3JCPz25Er42a84nsBECqxFOyVAMeDkAwU1VhfuPrVxtcPl0q+6u+VUIovnC3ZUeITuAgVqRvBi013lhlYrxc+P0H7G9Pam7hm4eFBBQM7GKLu0OvYUrjUSvLVPfvxbprFwuCUK6YkVnDmAC2xdCOOy7/xngs5oH2mfcOoiG0PaBn9TU4++kNRAJgmss2usg1ekTxntTMuK4dbeot8k4XjsvWbp+0iMflLQAnxhI0K3y7omSqhaXcDh6vlqBzfpPcfucgTDGjlVFwuNcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcxezTrh/jK5QFpKBGlsQNKm/Ua7K5degHFq9iDqo2c=;
 b=MnO5zZsUu260iNshUPJ/e7MPI7LIQXug96haQhkNCW7vFI5aEwioUh3E2zMohOtMuWi10a5TcltpzPljk9qi/sGuhgQ1sE1s0lR3eLgEfrDpKCUycg2AhodP08jZR0kaOzCDlOdgmJNwvifsmmrVL5Z4hIkJGnCzKwXbE7WkGEd/geXOq9u1zl9cR8vCHNXqbQ5YT5GbrhFtdY2BYeZDn4G53EXswIHTbDBtz7rHInwM0U7GyKjIVlM35DnaDmXNQqAWEZQrdMRhTS/dliD+j1qxoPwRf4OF4KWYPNhbX/jPpUresY/uidiz6b8lJYehLLWMjOFI0QES1uDCJse6oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 50.222.100.11) smtp.rcpttodomain=ddn.com smtp.mailfrom=ddn.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=ddn.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcxezTrh/jK5QFpKBGlsQNKm/Ua7K5degHFq9iDqo2c=;
 b=bZ9NgxYbQqiv664PiTkV/Mk+1klRDLIwSI35BnfF9E7wIgbzrDz0yMSq2kF01ma0v2hPeQ0hRMePGPBVgNrK8lE6Kro097n1pR9Vgs+DFf1j1fk4ANvTD/VQ5zVgMZI8bRbsyg67WigyEkPk8bHXiHH1ERVx02a4TAMG3FDXTXo=
Received: from BN9PR03CA0177.namprd03.prod.outlook.com (2603:10b6:408:f4::32)
 by MW4PR19MB5607.namprd19.prod.outlook.com (2603:10b6:303:16a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Tue, 21 Mar
 2023 01:11:26 +0000
Received: from BN8NAM04FT029.eop-NAM04.prod.protection.outlook.com
 (2603:10b6:408:f4:cafe::76) by BN9PR03CA0177.outlook.office365.com
 (2603:10b6:408:f4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.37 via Frontend
 Transport; Tue, 21 Mar 2023 01:11:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 50.222.100.11)
 smtp.mailfrom=ddn.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ddn.com;
Received-SPF: Pass (protection.outlook.com: domain of ddn.com designates
 50.222.100.11 as permitted sender) receiver=protection.outlook.com;
 client-ip=50.222.100.11; helo=uww-mx01.datadirectnet.com; pr=C
Received: from uww-mx01.datadirectnet.com (50.222.100.11) by
 BN8NAM04FT029.mail.protection.outlook.com (10.13.161.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6222.16 via Frontend Transport; Tue, 21 Mar 2023 01:11:25 +0000
Received: from localhost (unknown [10.68.0.8])
        by uww-mx01.datadirectnet.com (Postfix) with ESMTP id 4D0BC2073544;
        Mon, 20 Mar 2023 19:12:33 -0600 (MDT)
From:   Bernd Schubert <bschubert@ddn.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Dharmendra Singh <dsingh@ddn.com>,
        Bernd Schubert <bschubert@ddn.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        fuse-devel@lists.sourceforge.net
Subject: [PATCH 11/13] fuse: Add support to copy from/to the ring buffer
Date:   Tue, 21 Mar 2023 02:10:45 +0100
Message-Id: <20230321011047.3425786-12-bschubert@ddn.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230321011047.3425786-1-bschubert@ddn.com>
References: <20230321011047.3425786-1-bschubert@ddn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM04FT029:EE_|MW4PR19MB5607:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a688f10f-5432-4a91-6ec1-08db29a93190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tpWtj2i71l4YqCfcrSKc7/gq1lITAZOFXaNOe30S9qvcpFIXj7m/5cSts12zDP8vF1DtsoY/1TJQ3YN0kY435LnA2Xq7Ud+Ke90NFF55CBKof9p0VX8AbF+IBi1b0xo5G/x2JiqZhid9v8B1jNNND+Abo3YiOHeAILJ7rc492AkKRf+wUUbBNYjUJGwTD0QsiS7z55Q304W6AV6PCA3Vl1VdYsXZB/sOWQMs5oXyJQl+hpJEf8Wzn8/uled/mit476oV4YEQS00qnhB6RibjS89mIkY48BRTbudgy0u6+blFbxA1Al87djyYzw1I75dzI+xWJQIAOULNZDfVLoaatwKFAEWvVX8slWMEA78NgSYg/kOCMMTxjO/Ky7xYgWoUiee9pn9DaDSQyCU/eRVTYn9WSyb2grt/TQsfayoHIVboq7vhESy0OtNuCc+CsnamU75RqJkllOBkruVdBsdfhOkxhu9lGzA/ZUC75TPJjw2FiXrKjihnye3SFTQoo8g7iLbf1ZJY47lyubZMV5MhUJesHykvoCc1iRHXkZLPzHI+fS14CS8P930SVuyT7UWWm29ghQg2BNLuT+z04VBE7ku7MZvyfTcl5UwUT+bovQuZW4hHkk1GWnG3kWICm/S0OquWmSMoyZ7fIyn3g3dWpsRoM/LSBrM9V3RiG6u6c+eXe4WFQJy6GF74xcboJL4pmul4qHgL/okWw3aOZIrsVw==
X-Forefront-Antispam-Report: CIP:50.222.100.11;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:uww-mx01.datadirectnet.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(376002)(346002)(396003)(136003)(39850400004)(451199018)(36840700001)(46966006)(6266002)(86362001)(41300700001)(47076005)(8676002)(2906002)(82310400005)(6916009)(356005)(36756003)(54906003)(478600001)(336012)(6666004)(83380400001)(2616005)(1076003)(186003)(26005)(8936002)(316002)(70206006)(70586007)(36860700001)(81166007)(82740400003)(40480700001)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2023 01:11:25.9411
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a688f10f-5432-4a91-6ec1-08db29a93190
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=753b6e26-6fd3-43e6-8248-3f1735d59bb4;Ip=[50.222.100.11];Helo=[uww-mx01.datadirectnet.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM04FT029.eop-NAM04.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR19MB5607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support to existing fuse copy code to copy
from/to the ring buffer. The ring buffer is here mmaped
shared between kernel and userspace.

This also fuse_ prefixes the copy_out_args function

Signed-off-by: Bernd Schubert <bschubert@ddn.com>
cc: Miklos Szeredi <miklos@szeredi.hu>
cc: linux-fsdevel@vger.kernel.org
cc: Amir Goldstein <amir73il@gmail.com>
cc: fuse-devel@lists.sourceforge.net
---
 fs/fuse/dev.c        | 60 ++++++++++++++++++++++++++------------------
 fs/fuse/fuse_dev_i.h | 35 ++++++++++++++++++++++++++
 2 files changed, 70 insertions(+), 25 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index 4e79cdba540c..de9193f66c8b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -628,21 +628,7 @@ static int unlock_request(struct fuse_req *req)
 	return err;
 }
 
-struct fuse_copy_state {
-	int write;
-	struct fuse_req *req;
-	struct iov_iter *iter;
-	struct pipe_buffer *pipebufs;
-	struct pipe_buffer *currbuf;
-	struct pipe_inode_info *pipe;
-	unsigned long nr_segs;
-	struct page *pg;
-	unsigned len;
-	unsigned offset;
-	unsigned move_pages:1;
-};
-
-static void fuse_copy_init(struct fuse_copy_state *cs, int write,
+void fuse_copy_init(struct fuse_copy_state *cs, int write,
 			   struct iov_iter *iter)
 {
 	memset(cs, 0, sizeof(*cs));
@@ -653,6 +639,7 @@ static void fuse_copy_init(struct fuse_copy_state *cs, int write,
 /* Unmap and put previous page of userspace buffer */
 static void fuse_copy_finish(struct fuse_copy_state *cs)
 {
+
 	if (cs->currbuf) {
 		struct pipe_buffer *buf = cs->currbuf;
 
@@ -717,6 +704,10 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 			cs->pipebufs++;
 			cs->nr_segs++;
 		}
+	} else if (cs->is_uring) {
+		if (cs->ring.offset > cs->ring.buf_sz)
+			return -ERANGE;
+		cs->len = cs->ring.buf_sz - cs->ring.offset;
 	} else {
 		size_t off;
 		err = iov_iter_get_pages2(cs->iter, &page, PAGE_SIZE, 1, &off);
@@ -735,21 +726,35 @@ static int fuse_copy_fill(struct fuse_copy_state *cs)
 static int fuse_copy_do(struct fuse_copy_state *cs, void **val, unsigned *size)
 {
 	unsigned ncpy = min(*size, cs->len);
+
 	if (val) {
-		void *pgaddr = kmap_local_page(cs->pg);
-		void *buf = pgaddr + cs->offset;
+
+		void *pgaddr;
+		void *buf;
+
+		if (cs->is_uring) {
+			buf = cs->ring.buf + cs->ring.offset;
+			cs->ring.offset += ncpy;
+
+		} else {
+			pgaddr = kmap_local_page(cs->pg);
+			buf = pgaddr + cs->offset;
+		}
 
 		if (cs->write)
 			memcpy(buf, *val, ncpy);
 		else
 			memcpy(*val, buf, ncpy);
 
-		kunmap_local(pgaddr);
+		if (pgaddr)
+			kunmap_local(pgaddr);
+
 		*val += ncpy;
 	}
 	*size -= ncpy;
 	cs->len -= ncpy;
 	cs->offset += ncpy;
+
 	return ncpy;
 }
 
@@ -997,9 +1002,9 @@ static int fuse_copy_one(struct fuse_copy_state *cs, void *val, unsigned size)
 }
 
 /* Copy request arguments to/from userspace buffer */
-static int fuse_copy_args(struct fuse_copy_state *cs, unsigned numargs,
-			  unsigned argpages, struct fuse_arg *args,
-			  int zeroing)
+int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
+		   unsigned int argpages, struct fuse_arg *args,
+		   int zeroing)
 {
 	int err = 0;
 	unsigned i;
@@ -1806,10 +1811,15 @@ static struct fuse_req *request_find(struct fuse_pqueue *fpq, u64 unique)
 	return NULL;
 }
 
-static int copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
-			 unsigned nbytes)
+int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
+		       unsigned int nbytes)
 {
-	unsigned reqsize = sizeof(struct fuse_out_header);
+
+	unsigned int reqsize = 0;
+
+	/* Uring has the out header outside of args */
+	if (!cs->is_uring)
+		reqsize = sizeof(struct fuse_out_header);
 
 	reqsize += fuse_len_args(args->out_numargs, args->out_args);
 
@@ -1909,7 +1919,7 @@ static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
 	if (oh.error)
 		err = nbytes != sizeof(oh) ? -EINVAL : 0;
 	else
-		err = copy_out_args(cs, req->args, nbytes);
+		err = fuse_copy_out_args(cs, req->args, nbytes);
 	fuse_copy_finish(cs);
 
 	spin_lock(&fpq->lock);
diff --git a/fs/fuse/fuse_dev_i.h b/fs/fuse/fuse_dev_i.h
index aea1f3f7aa5d..ccd128f81628 100644
--- a/fs/fuse/fuse_dev_i.h
+++ b/fs/fuse/fuse_dev_i.h
@@ -11,6 +11,33 @@
 #define FUSE_INT_REQ_BIT (1ULL << 0)
 #define FUSE_REQ_ID_STEP (1ULL << 1)
 
+struct fuse_copy_state {
+	int write;
+	struct fuse_req *req;
+	struct iov_iter *iter;
+	struct pipe_buffer *pipebufs;
+	struct pipe_buffer *currbuf;
+	struct pipe_inode_info *pipe;
+	unsigned long nr_segs;
+	struct page *pg;
+	unsigned int len;
+	unsigned int offset;
+	unsigned int move_pages:1, is_uring:1;
+	struct {
+		/* pointer into the ring buffer */
+		char *buf;
+
+		/* for copy to the ring request buffer, the buffer size - must
+		 * not be exceeded, for copy from the ring request buffer,
+		 * the size filled in by user space
+		 */
+		unsigned int buf_sz;
+
+		/* offset within buf while it is copying from/to the buf */
+		unsigned int offset;
+	} ring;
+};
+
 static inline struct fuse_dev *fuse_get_dev(struct file *file)
 {
 	/*
@@ -22,6 +49,14 @@ static inline struct fuse_dev *fuse_get_dev(struct file *file)
 
 void fuse_dev_end_requests(struct list_head *head);
 
+void fuse_copy_init(struct fuse_copy_state *cs, int write,
+			   struct iov_iter *iter);
+int fuse_copy_args(struct fuse_copy_state *cs, unsigned int numargs,
+		   unsigned int argpages, struct fuse_arg *args,
+		   int zeroing);
+int fuse_copy_out_args(struct fuse_copy_state *cs, struct fuse_args *args,
+		       unsigned int nbytes);
+
 #endif
 
 
-- 
2.37.2

