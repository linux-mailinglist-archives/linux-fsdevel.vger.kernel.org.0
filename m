Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFD1F444F55
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Nov 2021 07:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhKDGxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Nov 2021 02:53:17 -0400
Received: from mail-bn1nam07on2048.outbound.protection.outlook.com ([40.107.212.48]:50474
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229994AbhKDGvo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Nov 2021 02:51:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJskllJqQwotBXb3J2viKO4N6Aul5OQ2c2UVUYrEERPQWnfETlCBe47v3oWnUOJCScvXx3jumk0xyf5Lp49p3Z1j7juVWREJerTTWzYXxVAnQKFccOqtv1YVJ+g/8dlCsqgXQUiq/t+eTdo4Wx/cl2Smyu41WJKpl22NNYXNMy/LSRmb1c2ix3Bw1HxzGs8ydAYU35Mr5IbimdOV2jRilr9mx4YZ0833pn0OPn9AaUXsxEfrHZ9yfqYp210HzZkcWDCIenvXUZ+tNxAJqQDAxLCtD3eZBre+tCv8FQCyc793rpp5xiGOx5mGQLY/o5Mt3Hq/qr3fg6KB92X19ETavw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ju12ToF3CoDMSM61YGAPFWiQ1megGESJmZMzLjgYiNs=;
 b=MffrzDwlv3F/o7Nb/U9AFvPPcoXYg3DhAnztqbJV6ZJvhbjnsniDf+sam6I+Ipz+GQju3Upm5x0UKa6MoHtEalJqt6EZgkI/N9hsBP5HfRacRnZCDeX+zPDBKF2AVagCcAHZUlFoV4Hw6fU70d0b09oS8LAKuLYpVRjFpCo8tJuLen4UmJy2hYEfqOefQFvTWm8ZS15qpTtShr8qT+yqK6m2rAdCEQue92RsCn66PmwwWxDYWVQPRndxKZg1tDulwbeK6pe8FF+rVjtsZC5KrFS4HrtiwBUCxufLb+TWeISsOEX3YhtwwGnsFz+epnYIp2M0M4KYP89zBzl01ttgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=infradead.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ju12ToF3CoDMSM61YGAPFWiQ1megGESJmZMzLjgYiNs=;
 b=YI4kPyNySVCbxmD710wfEi48PEvc4fpt+iqOQ9HC8K/+6cfg9rGycvmAzTR/vQL4r9FiQdFMHJ9Ni7BVORdg0YAEcLnljJBB6fF7/zt95hIhviYsVCFPFbDHHH5fJC+ldlNEGK5ROQvSUBhXwUNIz9E9SX09wHbk5VHZKhEeZOB68cSthjD3iRfjx6Xk0OUUSS+V2QKoX0M2o4Ng+uWguq89DbSThnp0jk7PfxrPuKoHRXmdrHiL6H6S9vesz14opagNoVulqiTylTuVNGd+h1N6aOzemNeh5GYQsE0xE7LsVk/D/sWUhl4hIVaJ6pYrVzakmPjIln8yh7sbMKQz2Q==
Received: from MWHPR15CA0042.namprd15.prod.outlook.com (2603:10b6:300:ad::28)
 by SN1PR12MB2509.namprd12.prod.outlook.com (2603:10b6:802:29::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.15; Thu, 4 Nov
 2021 06:49:02 +0000
Received: from CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::b3) by MWHPR15CA0042.outlook.office365.com
 (2603:10b6:300:ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4669.10 via Frontend
 Transport; Thu, 4 Nov 2021 06:49:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT054.mail.protection.outlook.com (10.13.174.70) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4669.10 via Frontend Transport; Thu, 4 Nov 2021 06:49:01 +0000
Received: from dev.nvidia.com (172.20.187.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 4 Nov
 2021 06:48:57 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-scsi@vger.kernel.org>,
        <target-devel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <dm-devel@redhat.com>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <snitzer@redhat.com>,
        <song@kernel.org>, <djwong@kernel.org>, <kbusch@kernel.org>,
        <hch@lst.de>, <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <osandov@fb.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [RFC PATCH 6/8] nvmet: add verify emulation support for file-ns
Date:   Wed, 3 Nov 2021 23:46:32 -0700
Message-ID: <20211104064634.4481-7-chaitanyak@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20211104064634.4481-1-chaitanyak@nvidia.com>
References: <20211104064634.4481-1-chaitanyak@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a61fc49e-d383-4a8c-dfd4-08d99f5f2f86
X-MS-TrafficTypeDiagnostic: SN1PR12MB2509:
X-Microsoft-Antispam-PRVS: <SN1PR12MB2509414E229FC2A0956109C1A38D9@SN1PR12MB2509.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rnqQjkkgXo+euQ0U/XF7ZpgapkaSySwPee2l3GAUzTO2MbUOAsITMBSmaEIBLKz7qmzl6FkAsbLYgVpFdCtFQUfuUKfrke5ueMKTIcGvdzlrB4Y0t5/1dxSrLHbLMigdXUsoCdsZyPlITuGQgIzcsbg7p44TBdN5lwIPXKZrKgCfDeSZwF5N9TNi/Q9bd3w3BVHYQUDBdJoPQTRFaYLe4MCsAapvi9ZmdQYie87NaV95dEbVwHEXhPnwUV3lmuti6lnCP9NJhwALcpnjKCDHSfpZeZEMLN0Tiee8myRn6Nkg37UI5milL9fkYu3c8ITcuinQbf4WSIEPYqY32rlTE8fIQ9yef/b3GwRWUwi2kT/2pt8VuqRYmpfLnFxJW4UGHi7d+kB+QFqeULxb23JSUr0hqmlTU2ksHyXozuHjXKqrb/7EL/OmYQ6Q+37wmd6mkiayeOg2MW9WOwmlGByBVsifKGJpep9PUoM2tqJvrrn4wU+WfBdEWKyEqRTZ2MHM+w2X3z8cLIwYq7lhbQlNwDjO7OY0two9hKLf7tr0skpynbXyaKmjtW17YXxRs+lytgYBjCmZmMQ2+VU0PtQk/SMxfqGTwYKgSU0zpwaWfc9EzEB4iz1kxqP3nboLpOFyA2wZuV4f0SYzdo7VoxH0sEdIkRYhSl9wyUUwQAiNBr6DJndYycWSRrWmgj2y1h+lnm04j36WUskXMz8vLAOur28m89rXeQE3ED9wjvy+61c=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(70206006)(110136005)(356005)(316002)(86362001)(54906003)(8936002)(4326008)(15650500001)(6666004)(36860700001)(83380400001)(7696005)(7636003)(70586007)(36756003)(5660300002)(336012)(2616005)(426003)(2906002)(1076003)(508600001)(16526019)(7406005)(186003)(26005)(47076005)(107886003)(8676002)(7416002)(82310400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2021 06:49:01.6624
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61fc49e-d383-4a8c-dfd4-08d99f5f2f86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT054.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2509
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <kch@nvidia.com>

For now, there is no way to map verify operation to the VFS layer API.
This patch emulates verify operation by offloading it to the workqueue
and reading the data using vfs layer APIs for both buffered io and
direct io mode.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-file.c | 151 ++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0abbefd9925e..2b0291c4164c 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -12,6 +12,7 @@
 
 #define NVMET_MAX_MPOOL_BVEC		16
 #define NVMET_MIN_MPOOL_OBJ		16
+#define NVMET_VERIFY_BUF_LEN		(BIO_MAX_PAGES << PAGE_SHIFT)
 
 int nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
@@ -381,6 +382,153 @@ static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 	schedule_work(&req->f.work);
 }
 
+static void __nvmet_req_to_verify_offset(struct nvmet_req *req, loff_t *offset,
+		ssize_t *len)
+{
+	struct nvme_verify_cmd *verify = &req->cmd->verify;
+
+	*offset = le64_to_cpu(verify->slba) << req->ns->blksize_shift;
+	*len = (((sector_t)le16_to_cpu(verify->length) + 1) <<
+			req->ns->blksize_shift);
+}
+
+static int do_buffered_io_emulate_verify(struct file *f, loff_t offset,
+		ssize_t len)
+{
+	char *buf = NULL;
+	int ret = 0;
+	ssize_t rc;
+
+	buf = kmalloc(NVMET_VERIFY_BUF_LEN, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	while (len > 0) {
+		ssize_t curr_len = min_t(ssize_t, len, NVMET_VERIFY_BUF_LEN);
+
+		rc = kernel_read(f, buf, curr_len, &offset);
+		if (rc != curr_len) {
+			pr_err("kernel_read %lu curr_len %lu\n", rc, curr_len);
+			ret = -EINVAL;
+			break;
+		}
+
+		len -= curr_len;
+		offset += curr_len;
+		cond_resched();
+	}
+
+	kfree(buf);
+	return ret;
+}
+
+static int do_direct_io_emulate_verify(struct file *f, loff_t offset,
+		ssize_t len)
+{
+	struct scatterlist *sgl = NULL;
+	struct bio_vec *bvec = NULL;
+	struct iov_iter iter = { 0 };
+	struct kiocb iocb = { 0 };
+	unsigned int sgl_nents;
+	ssize_t ret = 0;
+	int i;
+
+	while (len > 0) {
+		ssize_t curr_len = min_t(ssize_t, len, NVMET_VERIFY_BUF_LEN);
+		struct scatterlist *sg = NULL;
+		unsigned int bv_len = 0;
+		ssize_t rc;
+
+		sgl = sgl_alloc(curr_len, GFP_KERNEL, &sgl_nents);
+		if (!sgl) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		bvec = kmalloc_array(sgl_nents, sizeof(struct bio_vec),
+				GFP_KERNEL);
+		if (!bvec) {
+			ret = -ENOMEM;
+			break;
+		}
+
+		for_each_sg(sgl, sg, sgl_nents, i) {
+			nvmet_file_init_bvec(&bvec[i], sg);
+			bv_len += sg->length;
+		}
+
+		if (bv_len != curr_len) {
+			pr_err("length mismatch sgl & bvec\n");
+			ret = -EINVAL;
+			break;
+		}
+
+		iocb.ki_pos = offset;
+		iocb.ki_filp = f;
+		iocb.ki_complete = NULL; /* Sync I/O */
+		iocb.ki_flags |= IOCB_DIRECT;
+
+		iov_iter_bvec(&iter, READ, bvec, sgl_nents, bv_len);
+
+		rc = call_read_iter(f, &iocb, &iter);
+		if (rc != curr_len) {
+			pr_err("read len mismatch expected %lu got %ld\n",
+					curr_len, rc);
+			ret = -EINVAL;
+			break;
+		}
+
+		cond_resched();
+
+		len -= curr_len;
+		offset += curr_len;
+
+		kfree(bvec);
+		sgl_free(sgl);
+		bvec = NULL;
+		sgl = NULL;
+		memset(&iocb, 0, sizeof(iocb));
+		memset(&iter, 0, sizeof(iter));
+	}
+
+	kfree(bvec);
+	sgl_free(sgl);
+	return ret;
+}
+
+static void nvmet_file_emulate_verify_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	loff_t offset;
+	ssize_t len;
+	int ret = 0;
+
+	__nvmet_req_to_verify_offset(req, &offset, &len);
+	if (!len)
+		goto out;
+
+	if (unlikely(offset + len > req->ns->size)) {
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
+		return;
+	}
+
+	if (req->ns->buffered_io)
+		ret = do_buffered_io_emulate_verify(req->ns->file, offset, len);
+	else
+		ret = do_direct_io_emulate_verify(req->ns->file, offset, len);
+out:
+	nvmet_req_complete(req, errno_to_nvme_status(req, ret));
+}
+
+static void nvmet_file_execute_verify(struct nvmet_req *req)
+{
+	if (!nvmet_check_data_len_lte(req, 0))
+		return;
+
+	INIT_WORK(&req->f.work, nvmet_file_emulate_verify_work);
+	queue_work(verify_wq, &req->f.work);
+}
+
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -399,6 +547,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_verify:
+		req->execute = nvmet_file_execute_verify;
+		return 0;
 	default:
 		pr_err("unhandled cmd for file ns %d on qid %d\n",
 				cmd->common.opcode, req->sq->qid);
-- 
2.22.1

