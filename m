Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D887B5615E3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 11:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiF3JQ2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 05:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234140AbiF3JPs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 05:15:48 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D6E12A963;
        Thu, 30 Jun 2022 02:15:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YPEWEKfMViuGgxbyiAT4nWD8hnW7v8nHgNWDKLK1dyoQFtkA7dpU9mlNP7nKZW/jJPAyiphEhyqAWUVQ5T2SiRV0Fa8Y1hvDaVQJaM6nFj4Fhgv2Ajtz8Z5yY1AUgcTA3U8P13AWiltNIpQHAUsM1iC5YU5Sd5etEoygT/wmvme+z3/Vnoq1NgEcYa+gtwMVgGLudNcuxK3Luh2OpA/KuSpXCssJd1dCo2P5+UVLiEJ6km3Avs3Po/ccqLPg2STXgVkt4qUHz0cqBxMo/vktgmIMkzlIzIqv0fgH6glGflub1xG+iKxoQaub5LgbnAqLbOCdoywyAnJ3EiqqaX1+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PH4qK27KflLRtEWi4DGfb1hzh+EOW9SDc/spTYn1upM=;
 b=WylWgtQ3kVbjLbVnJoQEuivUxWFwvOE04+/bvsyX0iB7CDblCUWz1zMK226Ud9NmEmp3/J838pPeHf8QnHoyNMkVUPK3NajRsMy/FSB1x7daWpTRXl5vZUESjwUMu5ta9zh/8sMeGm5j9H8NMwcmWOg2PjFJZY3x2k0uGZYzNcH+NMUvJHHsK6tp4rd7mRGgDWCT4PHLnpf99uMY7tV5rXuUwPZo5hLC9hHSYI9V4CFgLRn3S6EIYt0xmUSG+O1YiHSnjtwouHRJ7TIJqR1e/7URdm3PyCjIpFI+mJuQ4qJ6jKi+WaaFcOIvCMDLUmkRb2nDRpz9qshzhwAB4r1SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=grimberg.me smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PH4qK27KflLRtEWi4DGfb1hzh+EOW9SDc/spTYn1upM=;
 b=DfbUGUlue0W+01OL83P66VMV4OjYtSp76OxgwdzjYQoebqetqIXr8TDQXz57fSoQ7vYTi/K92d8vXFPKYYQPQ71xq9sG0iFLJ4UjJuuEPbJ4JvxtXD1XHB8iGLri7cuRMod4u67VcSu9Fvu2wDp4qvg6WsB6I65ItF9fzQfKO/glwumACQIDRDvLS+POTnBQVAbhOJJ+Hc/Z+VlKvY8JdWn4OEGxgDZxlkAyCxtOoB+LFbqIvCRuLBdtdhARGp19T/Qhl9S58IdJdFc+0H/j6VuXgpkUG9GnlkwroVpIGmJIxNRIIDiTppxAiBfSSV8IOYMy9SryztNeN2GvTL6QAw==
Received: from DS7PR03CA0306.namprd03.prod.outlook.com (2603:10b6:8:2b::14) by
 BN8PR12MB3124.namprd12.prod.outlook.com (2603:10b6:408:41::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.14; Thu, 30 Jun 2022 09:15:21 +0000
Received: from DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2b:cafe::45) by DS7PR03CA0306.outlook.office365.com
 (2603:10b6:8:2b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 09:15:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT014.mail.protection.outlook.com (10.13.173.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 09:15:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 30 Jun
 2022 09:15:20 +0000
Received: from dev.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 30 Jun
 2022 02:15:18 -0700
From:   Chaitanya Kulkarni <kch@nvidia.com>
To:     <linux-block@vger.kernel.org>, <linux-raid@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>, <linux-fsdevel@vger.kernel.org>
CC:     <axboe@kernel.dk>, <agk@redhat.com>, <song@kernel.org>,
        <djwong@kernel.org>, <kbusch@kernel.org>, <hch@lst.de>,
        <sagi@grimberg.me>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <viro@zeniv.linux.org.uk>,
        <javier@javigon.com>, <johannes.thumshirn@wdc.com>,
        <bvanassche@acm.org>, <dongli.zhang@oracle.com>,
        <ming.lei@redhat.com>, <willy@infradead.org>,
        <jefflexu@linux.alibaba.com>, <josef@toxicpanda.com>, <clm@fb.com>,
        <dsterba@suse.com>, <jack@suse.com>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <jlayton@kernel.org>,
        <idryomov@gmail.com>, <danil.kipnis@cloud.ionos.com>,
        <ebiggers@google.com>, <jinpu.wang@cloud.ionos.com>,
        Chaitanya Kulkarni <kch@nvidia.com>
Subject: [PATCH 5/6] nvmet: add verify emulation support for file-ns
Date:   Thu, 30 Jun 2022 02:14:05 -0700
Message-ID: <20220630091406.19624-6-kch@nvidia.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220630091406.19624-1-kch@nvidia.com>
References: <20220630091406.19624-1-kch@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c70b6c6-fd13-4683-9cf1-08da5a790eb5
X-MS-TrafficTypeDiagnostic: BN8PR12MB3124:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xDjc7o2clYBkb0dFtoBZraW63pH32/673Zs8NA0O/RuUJGpqNzKlYwyEnEyoHlpFmSVPhEbk+C/4HtG+gTs9LpSiAEq2vxycHjnXB8155gOvYAH6Ej01oI0ceXhzDr19MLY/pgCndOM/OrSzH2ET+EwW2VVjGiznTVMvYfvVybJb+H91Po8pDvjXHwbQOznDHfHD4UJC3o/lkg898Oo4DEERjVGMnwWarZ05QPT3S1mVfJSuHMKO3x9IOlqfzZwtbKHT0kuUjqd1UKkClT4ypiruzLgIr3La3Xpn2rIwXnK5YR/KvhfcgJRbpaOVnRY/M/xrwf4sHDC7Qp00dZ3mg9p9iEytpZGAUs6WUy90eCxN9wRLmeon4SFvUPvd19800zNq1ihdVJSaQKavmT7T8B5ZmiMLVOFdYRRSxbiexz2qG7BiX3H+7AGDuPc2mOfCJ1XFSehnh7+YCrVMEL3oFtheqjHPgWEyKF17qymaH6kyva0c5NEOhCB9UzUk+Pq2gnm3em4r8Z5C3uSFfMQKODZd2WVSd5upiw0RhJ+RZ3si1VBnWUFarlbO5YiCnFE59C7v7CS9F6IopByFElTfno4OCVMiNZOTlpmLT/o+AiBU+a+FJwb/dIu86Oyn3XffBhWmLRfsZHjCj3sRVBR/vMPLCxNPgUDOTzNAkQ1ZxwvF+EhCM2EeNygBuJVGn5RrsWug50cWfa9N/gV4d8Qx2Nf3c6i+ShGB0X7iH82dFeIkk/6X7QRA0ZYo0pNk3ihJgBFIlsZvAvZuMfgnC/xa7OPoWICE1R3jf9LDgBR8pDk2pAXCKgMKTVSOa8ueZ1fIiUUndZXXp/2ialN2DCfw4i7rD0WlIzyquZDnOb/HGWMifNYluWy3oUJHJYEAnJcf
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(36840700001)(40470700004)(46966006)(7696005)(7416002)(7406005)(5660300002)(8936002)(478600001)(26005)(356005)(40460700003)(41300700001)(15650500001)(2906002)(36860700001)(82740400003)(81166007)(426003)(336012)(6666004)(47076005)(70206006)(2616005)(82310400005)(16526019)(186003)(107886003)(1076003)(40480700001)(83380400001)(8676002)(110136005)(70586007)(36756003)(4326008)(54906003)(316002)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 09:15:20.9422
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c70b6c6-fd13-4683-9cf1-08da5a790eb5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3124
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For now, there is no way to map verify operation to the VFS layer API.
This patch emulates verify operation by offloading it to the workqueue
and reading the data using vfs layer APIs for both buffered io and
direct io mode.

Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 drivers/nvme/target/io-cmd-file.c | 152 ++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index f3d58abf11e0..287187d641ba 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -13,6 +13,7 @@
 
 #define NVMET_MAX_MPOOL_BVEC		16
 #define NVMET_MIN_MPOOL_OBJ		16
+#define NVMET_VERIFY_BUF_LEN		(BIO_MAX_VECS << PAGE_SHIFT)
 
 void nvmet_file_ns_revalidate(struct nvmet_ns *ns)
 {
@@ -376,6 +377,154 @@ static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 	queue_work(nvmet_wq, &req->f.work);
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
+
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -392,6 +541,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_verify:
+		req->execute = nvmet_file_execute_verify;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
-- 
2.29.0

