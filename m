Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D8E6E7913
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Apr 2023 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbjDSLzb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Apr 2023 07:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjDSLy5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:54:57 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D5D612C85
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 04:54:47 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230419115446epoutp03fb1c025741c12573a46f635a1bf7fcf9~XU-JVDOjM1440614406epoutp03n
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Apr 2023 11:54:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230419115446epoutp03fb1c025741c12573a46f635a1bf7fcf9~XU-JVDOjM1440614406epoutp03n
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681905286;
        bh=V0h50UZL6Pzbltx28/YeEpk8ZPO0bBrEuep2yMzOsFA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUweP2jT4OQoaa+RyHHEwRL/MJWcI2z41IbIHIvRzYG2lt/BF6bxvs45rdk/0NpFN
         0D1oC/CSuLkNRTcYMsEBqhv5F+lNzu4TtX/xXbyQfYYvDB/8rKGUEvIyAhTfocuNRg
         IFBoIPsW5VBaotuDjjuNPhAxQdZQx0+Na0mb4cUo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230419115445epcas5p23004130fd2cf0bfe8717f938b8114447~XU-Ii0bRw1844418444epcas5p2d;
        Wed, 19 Apr 2023 11:54:45 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4Q1fNM4lj4z4x9Pr; Wed, 19 Apr
        2023 11:54:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.8D.09540.386DF346; Wed, 19 Apr 2023 20:54:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230419114743epcas5p155559f1777d242e9d68c43cb61eb5777~XU4-aDjn30344203442epcas5p1_;
        Wed, 19 Apr 2023 11:47:43 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230419114743epsmtrp1a134ebcb049f457752518b814bf27c26~XU4-Yz49h1843518435epsmtrp1V;
        Wed, 19 Apr 2023 11:47:43 +0000 (GMT)
X-AuditID: b6c32a4a-4afff70000002544-7a-643fd683b348
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        D1.93.08609.ED4DF346; Wed, 19 Apr 2023 20:47:43 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230419114739epsmtip1627264bbec8b39e9107854556df05662~XU48URkOI2496324963epsmtip1E;
        Wed, 19 Apr 2023 11:47:39 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        dlemoal@kernel.org, anuj20.g@samsung.com, joshi.k@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v10 6/9] nvmet: add copy command support for bdev and file
 ns
Date:   Wed, 19 Apr 2023 17:13:11 +0530
Message-Id: <20230419114320.13674-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230419114320.13674-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxbZRT23tveli5dLgW3d0wYqS4LEKDdaPeCFEzE7UbMJJq4TFnKXXtH
        kdI2/YANp6PiUCDANlBZUUCcIuAoMqjQDjQlsFFgX3yFZRNYQLN142PgUD6cLXfo/j3nOed5
        zznPm8PFBIWcAG6axkjrNZRaiPNYtq6QXeG5I/FKkcsphFZXDwY/Pr2GwYY7JTh0dz1C4Bdz
        f2Nw4pd42DFTwYZjv7aj8FLNWRTWNXSj0PHNPAq7nzzE4VnnCAKnhy0o7LgVBi919LLgoP0r
        HFZ9P82BztJcFLZNmRFoW6nCYKN7lgWv3NoOr61dZr8CyMGhRNIyPoCT7ZY7HPLabz+xyMEB
        E9lcn4+TF8+fJB1jOThZlDuDk7OdwzhZ3FKPkBf7PiAXmoPI5qmHaNLmd9NjVTSlpPXBtEah
        VaZpUmXCxLflr8olUpE4XBwN9wqDNVQGLRMmvJEUvi9N7XFAGJxJqU0eKokyGISRcbF6rclI
        B6u0BqNMSOuUal2ULsJAZRhMmtQIDW2MEYtEuyWewpR0VdPo72zdavwx19KnnBzEJilAfLiA
        iALupat4AcLjCggHAhqrpzlM8AgB9gsWNhMsIGC0fBHfkFTfPcf2YgFhR4Ct4SRTdAoFLmux
        J8Hl4kQY6HvC9fL+RB4G5qfzWd4AI26iYLVlFvOq/Yg3gXttiOXFLGInGMivW+/AJ2LAnw2j
        HO9DgIgEJeO+XtqHeBnUdpZiTIkv6D03tS7FiB0gt7UC874PiFofcHu0H2MmTQCdTR1sBvuB
        +5dbOAwOAPdK8p7iLFBX9gPOiD9BgGXUgjCJeHDKVYJ5h8CIEGC1RzJ0IPjc1YgyjTeDopUp
        lOH5oK1yA78IfrRWP3VrGxhZMuPMLiRo79ExZhUjoGLuPHoaCbY8s4/lmX0s/3euRrB6ZBut
        M2Sk0gaJbreGzvrvlxXajGZk/SpCX29DJifmIpwIykWcCOBiQn9+/2sxSgFfSR3PpvVaud6k
        pg1OROLx+wwW8LxC6zkrjVEujooWRUml0qjoPVKxcCt/l6xXISBSKSOdTtM6Wr+hQ7k+ATlo
        Ya/z8byqrpSX4xrf7yj/duW52OQU/+Sx2SH3YHK2/9jkg6tl1ukXMiUiATdBNDJ3Iab+ndC8
        /P3OmYM/Lw7JIm53s3jXzbM7Uk64T9xc5Rdc2dIF5ETgJlvN42FJ6+R2bdfhDFZYYCO1dWYx
        y7LFHnnoBnmMV1FuLhawviw7QC2Yj3/mLI5Lte0cMSkFJTxkz1plUFxQbcVf9srDw++F//Fh
        SMm965l9q3cn5AH6t6iXEojl5aOUqj887uiNrMhD0uUse+K+fyqBNbDq4MIm3x5bv8hcmKeo
        OfDAFZR0xNIFfEjD160OOrtpsMnvo6C97xceWS2immSO+2L1hOI7IcugosShmN5A/QteINsc
        ngQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02RWUwTYRSF889Mp0MNOi2oP+ASx2AMIi5o/MWlarSO4oIxUQNxaWQsFVqa
        Vtx4EKkJAdmUSGJBrEYhlIBalLWgFEEQK8aypBSoC+CCKGIJcSmYQkx8O/d+95zzcClcVEf4
        UnLlKU6tlMYwpIAoq2fmLXW0iSOXDxdj6N7zRhwlZrpwVNSTQaLB+hGAsod/4ujNYzGq+ZrD
        Q7YnlRgy3b6KocKiBgxV3/qOoYaJIRJdNXcA1N+uw1BN1xJkqmkmkLUql0Q38/v5yJylxVBF
        30WAyn7fxFHJ4DcCNXX5oVbXM94myFrbQlmdw0KylboePtva+4BgrZY41mhIJtnSOxfYalsC
        yaZpv5Lst9p2kk1/aABsaUs8+8M4jzX2DWFh08MF6yO5GPlpTr1s4zFB1P3OAZ7qj/js87Ek
        fgIoW50CPChIr4L6d9d5KUBAiegKAC83/CKmgA/Mdz3Fp7QXLBz/wHdrEa3FoMu0LQVQFEkv
        gS0TlNvrTWfi8LUjgXQPOP0Gg60fnDy3wYveDe2mwclQgvaHluRC0q096RA4WtTJdwdBehnM
        cAjdaw96HSyozcKnukJgqnkcTJ0LYfP1vskYnJ4PtY9y8ExA6/5Duv+QHmAG4MOpNAqZQrNC
        tVLJnQnSSBWaOKUs6HiswggmvxwQUAFMhuEgM8AoYAaQwhlvzxfbQiJFnpHSc+c5dexRdVwM
        pzEDP4pgZnu+Smk+KqJl0lNcNMepOPU/ilEevglYKrd4Z2OJ05btr0hb+XKGZOehXYmx2kfE
        GmES1hC6/EZ02kFy7PfEaLqDI4KtuQMgr2WtNVk/In+lrBplkgR7a0d/tS70aiqfyY86Gy+5
        UtXUnZpncy4ynAgMlIU75+zIicgLu58vL9hRfjKZiZW/LaltPMLsqVubcUe/py3M/r345cef
        LwpKGMmGa0KbOOLKpWk9Pu38+UBcOD4yY4CN6Q6tD4zYP7JAni5B/kGbjR37otSqiHfvJWlD
        WUgfv37W59sbVVa/Un97Bt1fXZw91ms/LOt1Fnxh7METdb7YlrubOpTRTeGlQp1FlfjR5ZNL
        fuJbnjZmzd3uvW7rAYbQRElXBOBqjfQv+uYkj1QDAAA=
X-CMS-MailID: 20230419114743epcas5p155559f1777d242e9d68c43cb61eb5777
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230419114743epcas5p155559f1777d242e9d68c43cb61eb5777
References: <20230419114320.13674-1-nj.shetty@samsung.com>
        <CGME20230419114743epcas5p155559f1777d242e9d68c43cb61eb5777@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for handling target command on target.
For bdev-ns we call into blkdev_issue_copy, which the block layer
completes by a offloaded copy request to backend bdev or by emulating the
request.

For file-ns we call vfs_copy_file_range to service our request.

Currently target always shows copy capability by setting
NVME_CTRL_ONCS_COPY in controller ONCS.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/target/admin-cmd.c   |  9 +++--
 drivers/nvme/target/io-cmd-bdev.c | 58 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 52 +++++++++++++++++++++++++++
 drivers/nvme/target/loop.c        |  6 ++++
 drivers/nvme/target/nvmet.h       |  1 +
 5 files changed, 124 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..8a09f99a2185 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -433,8 +433,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
-			NVME_CTRL_ONCS_WRITE_ZEROES);
-
+			NVME_CTRL_ONCS_WRITE_ZEROES | NVME_CTRL_ONCS_COPY);
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
 
@@ -536,6 +535,12 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (req->ns->bdev)
 		nvmet_bdev_set_limits(req->ns->bdev, id);
+	else {
+		id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16(BIO_MAX_VECS <<
+				(PAGE_SHIFT - SECTOR_SHIFT));
+		id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl));
+	}
 
 	/*
 	 * We just provide a single LBA format that matches what the
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c2d6cea0236b..0af273097aa4 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,19 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
 	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
+
+	/*Copy limits*/
+	if (bdev_max_copy_sectors(bdev)) {
+		id->msrc = id->msrc;
+		id->mssrl = cpu_to_le16((bdev_max_copy_sectors(bdev) <<
+				SECTOR_SHIFT) / bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32(id->mssrl);
+	} else {
+		id->msrc = (u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16((BIO_MAX_VECS << PAGE_SHIFT) /
+				bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32(id->mssrl);
+	}
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -184,6 +197,19 @@ static void nvmet_bio_done(struct bio *bio)
 	nvmet_req_bio_put(req, bio);
 }
 
+static void nvmet_bdev_copy_end_io(void *private, int comp_len)
+{
+	struct nvmet_req *req = (struct nvmet_req *)private;
+
+	if (comp_len == req->copy_len) {
+		req->cqe->result.u32 = cpu_to_le32(1);
+		nvmet_req_complete(req, errno_to_nvme_status(req, 0));
+	} else {
+		req->cqe->result.u32 = cpu_to_le32(0);
+		nvmet_req_complete(req, blk_to_nvme_status(req, BLK_STS_IOERR));
+	}
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 				struct sg_mapping_iter *miter)
@@ -450,6 +476,34 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+/* At present we handle only one range entry */
+static void nvmet_bdev_execute_copy(struct nvmet_req *req)
+{
+	struct nvme_copy_range range;
+	struct nvme_command *cmnd = req->cmd;
+	int ret;
+
+
+	ret = nvmet_copy_from_sgl(req, 0, &range, sizeof(range));
+	if (ret)
+		goto out;
+
+	ret = blkdev_issue_copy(req->ns->bdev,
+		le64_to_cpu(cmnd->copy.sdlba) << req->ns->blksize_shift,
+		req->ns->bdev,
+		le64_to_cpu(range.slba) << req->ns->blksize_shift,
+		(le16_to_cpu(range.nlb) + 1) << req->ns->blksize_shift,
+		nvmet_bdev_copy_end_io, (void *)req, GFP_KERNEL);
+	if (ret) {
+		req->cqe->result.u32 = cpu_to_le32(0);
+		nvmet_req_complete(req, blk_to_nvme_status(req, BLK_STS_IOERR));
+	}
+
+	return;
+out:
+	nvmet_req_complete(req, errno_to_nvme_status(req, ret));
+}
+
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -468,6 +522,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_bdev_execute_copy;
+		return 0;
+
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..69f198ecec77 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -322,6 +322,49 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 	}
 }
 
+static void nvmet_file_copy_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int nr_range;
+	loff_t pos;
+	struct nvme_command *cmnd = req->cmd;
+	int ret = 0, len = 0, src, id;
+
+	nr_range = cmnd->copy.nr_range + 1;
+	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
+	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
+		return;
+	}
+
+	for (id = 0 ; id < nr_range; id++) {
+		struct nvme_copy_range range;
+
+		ret = nvmet_copy_from_sgl(req, id * sizeof(range), &range,
+					sizeof(range));
+		if (ret)
+			goto out;
+
+		len = (le16_to_cpu(range.nlb) + 1) << (req->ns->blksize_shift);
+		src = (le64_to_cpu(range.slba) << (req->ns->blksize_shift));
+		ret = vfs_copy_file_range(req->ns->file, src, req->ns->file,
+					pos, len, 0);
+out:
+		if (ret != len) {
+			pos += ret;
+			req->cqe->result.u32 = cpu_to_le32(id);
+			nvmet_req_complete(req, ret < 0 ?
+					errno_to_nvme_status(req, ret) :
+					errno_to_nvme_status(req, -EIO));
+			return;
+
+		} else
+			pos += len;
+	}
+
+	nvmet_req_complete(req, 0);
+
+}
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
@@ -330,6 +373,12 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
 	queue_work(nvmet_wq, &req->f.work);
 }
 
+static void nvmet_file_execute_copy(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_copy_work);
+	queue_work(nvmet_wq, &req->f.work);
+}
+
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
@@ -376,6 +425,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_file_execute_copy;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f2d24b2d992f..d18ed8067a15 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -146,6 +146,12 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return ret;
 
 	nvme_start_request(req);
+	if (unlikely((req->cmd_flags & REQ_COPY) &&
+				(req_op(req) == REQ_OP_READ))) {
+		blk_mq_set_request_complete(req);
+		blk_mq_end_request(req, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = queue->ctrl->port;
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc60a22646f7..1615dc9194ba 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -393,6 +393,7 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	size_t			copy_len;
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
-- 
2.35.1.500.gb896f729e2

