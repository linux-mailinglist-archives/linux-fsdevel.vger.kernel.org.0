Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DC879427E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243552AbjIFRzd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjIFRzb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:55:31 -0400
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A13C1BDC
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:50 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230906175441epoutp016fe9d9a8e275bc64f363f16167555a6e~CYNXxZ5gq0734607346epoutp01s
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230906175441epoutp016fe9d9a8e275bc64f363f16167555a6e~CYNXxZ5gq0734607346epoutp01s
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022881;
        bh=NUEUyLnst+++sbAcKuc8uJ3J6dWR/yimYG8lXPwoG9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mWLlUrxq/9kogY2kDXQBcR3M1g5YttDN1qOMR0+UVJsWvAg0chlZb9sQDcA4NOOZM
         NIF/6vzR6lIpR2+sAofxGlnqYYvRHZNlBSSS8tEvHoFhXz8ykIL3nigGXZHBWIISE1
         Zkq0r4eBdRSfiOTFo1yutrhGhc8302PiopnRJ3Eg=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230906175440epcas5p199fce2b5aa846d286bb0a3ddd4688ece~CYNWxY4cK0097300973epcas5p1R;
        Wed,  6 Sep 2023 17:54:40 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rgql33qvHz4x9Pq; Wed,  6 Sep
        2023 17:54:39 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F5.04.19094.FDCB8F46; Thu,  7 Sep 2023 02:54:39 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230906164359epcas5p326df3257e93d1f5454b8c6b6c642e61c~CXPomNWI92340723407epcas5p3c;
        Wed,  6 Sep 2023 16:43:59 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906164359epsmtrp2f8d44dbcf086fdd354014c0c65e35d3a~CXPolPKMM1133211332epsmtrp2l;
        Wed,  6 Sep 2023 16:43:59 +0000 (GMT)
X-AuditID: b6c32a50-64fff70000004a96-d3-64f8bcdf391a
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.DA.08788.F4CA8F46; Thu,  7 Sep 2023 01:43:59 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164356epsmtip2834f4876921dd7327d57d70e1083ba15~CXPl2Cr1i0395803958epsmtip2I;
        Wed,  6 Sep 2023 16:43:56 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 08/12] nvmet: add copy command support for bdev and file
 ns
Date:   Wed,  6 Sep 2023 22:08:33 +0530
Message-Id: <20230906163844.18754-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfUxTVxTffe/10TLZnhX0rtNJuk0HDGgHdLdMRKPTN8oaFucSWAhreC8U
        gbZri7AtmXzI2DB8b5oWGA6Y8hWKfDgE6hgNgoDBSUAhE9jSxkwCxA8ER4C1PNz873d+v3vO
        +Z1z7+XjwkVSxE/UGFm9RpUsJt2Jyzafvf7T3cuMpLhUhCyD13CUVbSKo4a7hSSatT0EyN6T
        C5B1voyHJnquYKiuoQ9DJb3jADnGzBiyTvqhn76pIVC39TqBRjvLSVR5weGGLvavYehOkQOg
        yyuVOGqaXSDQwOSraGS1n3fAix6ZukTQozdS6Zb670i6teYU3TWRQdLVBaU8Oj97nqQfOCYJ
        euHqGEkXtNUD+lHLa3SLfQ6L2hKTtE/NqhhW781q4rVMoiYhTKw4FncoLkQmkfpL5ehdsbdG
        lcKGiQ9HRvkfSUx2zir2PqlKTnVSUSqDQRy4f59em2pkvdVagzFMzOqYZF2wLsCgSjGkahIC
        NKwxVCqRvBPiPPhZktp6o4DU3VOm90x2ERng24N5gM+HVDC80P1JHnDnC6luAOtHZnh5QOAM
        HgL4tFrBCU8AnFwrx12CK+H+LxkkJ1gBdLRdxLkgB4NTP1/FXGVJyg8OrfNdvCeVgcPmrmrg
        CnCqCYOmmlsbpbZRH0FLddtGP4J6E9oWVtxc2IMKhV0lJoLzFwgLp7e6aAH1HszK/B1wR7bC
        6yY74cI4tRtmt5dtmIBUrgCers0lOKuHYX7J2KbtbfB+f5sbh0Xw0byV5HAarPu+luSSTwNo
        vm0GnBAOcwYLcZcJnPKBls5Ajt4FfxhswrjGL8H8FTvG8R6w48dn+HXYaDm/Wf8VOL6UuYlp
        eKZ9BOf2WwDgUpWwCHibn5vH/Nw85v87nwd4PRCxOkNKAhsfopP6a9i0/245XpvSAjbev29U
        B2hoXg3oBRgf9ALIx8WeHvO7nzBCD0b1xZesXhunT01mDb0gxLnwYlzkFa91fiCNMU4aLJcE
        y2SyYHmQTCre4TGbU8EIqQSVkU1iWR2rf5aH8QWiDOytPoEyvYPhWVIaq7L+WN6u3FU7Vla3
        PvB3TfWfihcVc9NBB3mBsWU7VO8rE9X+fpVfY7F5J9b3U1P2itBad/m0JLvdNLFoKhrN21tj
        iLad1L19aU9lSK91+zGLZ7FJM2O3Xdkz3PpCpOweD748ftvc+mtEYXgVdu0rpjmfKRq7xYwq
        Pn/j8XKEsX8ZK1P7ji/m7uyLsc3+9kF66Z2zZwLSBwqPp+eeYqMFw13HrfE+nw4cWiIbhxMj
        52JEJz48UHdXWWr0FM6cmxENM8tNQeEPbh79J2doWtHj7tYmL79p4pVEPJav7USddtYQPd7k
        pXw6dOQvxzn+x+ItaRWxQZlJYsKgVkl9cb1B9S8JCfJMiAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDIsWRmVeSWpSXmKPExsWy7bCSvK7/mh8pBntXs1usP3WM2aJpwl9m
        i9V3+9ksXh/+xGjx5EA7o8Xed7NZLW4e2MlksXL1USaLSYeuMVo8vTqLyWLvLW2LhW1LWCz2
        7D3JYnF51xw2i/nLnrJbLD/+j8nixoSnjBbbfs9ntlj3+j2LxYlb0hbn/x5ndRD1OH9vI4vH
        5bOlHptWdbJ5bF5S77H7ZgObx+K+yawevc3v2Dw+Pr3F4vF+31U2j74tqxg9Pm+S89j05C1T
        AE8Ul01Kak5mWWqRvl0CV8bes31sBc/9Kg7c2s3SwNjh2MXIySEhYCLxansDWxcjF4eQwG5G
        iSMrf7BCJCQllv09wgxhC0us/PecHaKomUli1esVTF2MHBxsAtoSp/9zgMRFBLqYJTp3vmMB
        cZgFdjBJPP/fxg7SLSzgL7HsfjMjiM0ioCpx+P1vsDivgJXE7kkzWUAGSQjoS/TfFwQJcwpY
        SzQ1XgQrFwIqubPqNSNEuaDEyZlPWEBsZgF5ieats5knMArMQpKahSS1gJFpFaNkakFxbnpu
        sWGBUV5quV5xYm5xaV66XnJ+7iZGcIRqae1g3LPqg94hRiYOxkOMEhzMSiK87+S/pQjxpiRW
        VqUW5ccXleakFh9ilOZgURLn/fa6N0VIID2xJDU7NbUgtQgmy8TBKdXAFBj/N5ipK3Px9sp6
        3QyvsF+TUn0i3PX3S+UtuntmrkeIbnHk4omvew3LHIxOuK0XfWkyO9jIIvSAnsXtrb1HHgac
        fzfXU4xVVjk3dd+a2Cfu3Vpf6rTEKkNeGCyaID7r2pJpqdlZBuUTejTuMV96MWP+xUeHFJ5z
        teybxVVtwuTGs8xqg2/4oupU4QhpNtPFz8qztMtNnwksf7fw8vZDIT/Ks6UvXlG75Tl15qfD
        087OCd6yd23FTzvd10pPdqz+/HuqhIjY3+vH9L7kCFte3zr3aAZ7DN8D7e2p2fMskxdfva5W
        LfK0eN0BbcEl2lFbiznW6jBvP3Q+csW7vUkqCncK4vqbXt84lLBcrt/VV4mlOCPRUIu5qDgR
        AMYrJho/AwAA
X-CMS-MailID: 20230906164359epcas5p326df3257e93d1f5454b8c6b6c642e61c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164359epcas5p326df3257e93d1f5454b8c6b6c642e61c
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164359epcas5p326df3257e93d1f5454b8c6b6c642e61c@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for handling nvme_cmd_copy command on target.

For bdev-ns if backing device supports copy offload we call device copy
offload (blkdev_copy_offload).
In case of partial completion from above or absence of device copy offload
capability, we fallback to copy emulation (blkdev_copy_emulation)

For file-ns we call vfs_copy_file_range to service our request.

Currently target always shows copy capability by setting
NVME_CTRL_ONCS_COPY in controller ONCS.

loop target has copy support, which can be used to test copy offload.
trace event support for nvme_cmd_copy.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/target/admin-cmd.c   |  9 ++-
 drivers/nvme/target/io-cmd-bdev.c | 97 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 50 ++++++++++++++++
 drivers/nvme/target/nvmet.h       |  4 ++
 drivers/nvme/target/trace.c       | 19 ++++++
 5 files changed, 177 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..4e1a6ca09937 100644
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
+		id->msrc = (__force u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16(BIO_MAX_VECS <<
+					(PAGE_SHIFT - SECTOR_SHIFT));
+		id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl));
+	}
 
 	/*
 	 * We just provide a single LBA format that matches what the
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 468833675cc9..444447df9222 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,18 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
 	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
+
+	if (bdev_max_copy_sectors(bdev)) {
+		id->msrc = id->msrc;
+		id->mssrl = cpu_to_le16((bdev_max_copy_sectors(bdev) <<
+				SECTOR_SHIFT) /	bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32((__force u32)id->mssrl);
+	} else {
+		id->msrc = (__force u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16((BIO_MAX_VECS << PAGE_SHIFT) /
+					bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32((__force u32)id->mssrl);
+	}
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -449,6 +461,87 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_bdev_copy_emulation_endio(void *private, int status,
+					    ssize_t copied)
+{
+	struct nvmet_req *rq = (struct nvmet_req *)private;
+	u16 nvme_status;
+
+	if (rq->copied + copied == rq->copy_len)
+		rq->cqe->result.u32 = cpu_to_le32(1);
+	else
+		rq->cqe->result.u32 = cpu_to_le32(0);
+
+	nvme_status = errno_to_nvme_status(rq, status);
+	nvmet_req_complete(rq, nvme_status);
+}
+
+static void nvmet_bdev_copy_offload_endio(void *private, int status,
+					  ssize_t copied)
+{
+	struct nvmet_req *rq = (struct nvmet_req *)private;
+	u16 nvme_status;
+	ssize_t ret;
+
+	if (copied == rq->copy_len) {
+		rq->cqe->result.u32 = cpu_to_le32(1);
+		nvme_status = errno_to_nvme_status(rq, status);
+	} else {
+		rq->copied = copied;
+		ret = blkdev_copy_emulation(rq->ns->bdev, rq->copy_dst + copied,
+					    rq->ns->bdev, rq->copy_src + copied,
+					    rq->copy_len - copied,
+					    nvmet_bdev_copy_emulation_endio,
+					    (void *)rq, GFP_KERNEL);
+		if (ret == -EIOCBQUEUED)
+			return;
+		rq->cqe->result.u32 = cpu_to_le32(0);
+		nvme_status = errno_to_nvme_status(rq, status);
+	}
+	nvmet_req_complete(rq, nvme_status);
+}
+
+/*
+ * At present we handle only one range entry, since copy offload is aligned with
+ * copy_file_range, only one entry is passed from block layer.
+ */
+static void nvmet_bdev_execute_copy(struct nvmet_req *rq)
+{
+	struct nvme_copy_range range;
+	struct nvme_command *cmd = rq->cmd;
+	ssize_t ret;
+	u16 status;
+
+	status = nvmet_copy_from_sgl(rq, 0, &range, sizeof(range));
+	if (status)
+		goto err_rq_complete;
+
+	rq->copy_dst = le64_to_cpu(cmd->copy.sdlba) << rq->ns->blksize_shift;
+	rq->copy_src = le64_to_cpu(range.slba) << rq->ns->blksize_shift;
+	rq->copy_len = (range.nlb + 1) << rq->ns->blksize_shift;
+	rq->copied = 0;
+
+	if (bdev_max_copy_sectors(rq->ns->bdev)) {
+		ret = blkdev_copy_offload(rq->ns->bdev, rq->copy_dst,
+					  rq->copy_src, rq->copy_len,
+					  nvmet_bdev_copy_offload_endio,
+					  (void *)rq, GFP_KERNEL);
+		if (ret == -EIOCBQUEUED)
+			return;
+	}
+	ret = blkdev_copy_emulation(rq->ns->bdev, rq->copy_dst, rq->ns->bdev,
+				    rq->copy_src, rq->copy_len,
+				    nvmet_bdev_copy_emulation_endio, (void *)rq,
+				    GFP_KERNEL);
+	if (ret == -EIOCBQUEUED)
+		return;
+
+	rq->cqe->result.u32 = cpu_to_le32(0);
+	status = blk_to_nvme_status(rq, ret);
+err_rq_complete:
+	nvmet_req_complete(rq, status);
+}
+
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -467,6 +560,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
index 2d068439b129..4524cfffa4c6 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -322,6 +322,47 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 	}
 }
 
+static void nvmet_file_copy_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int nr_range = req->cmd->copy.nr_range + 1;
+	u16 status = 0;
+	int src, id;
+	ssize_t len, ret;
+	loff_t pos;
+
+	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
+	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
+		return;
+	}
+
+	for (id = 0 ; id < nr_range; id++) {
+		struct nvme_copy_range range;
+
+		status = nvmet_copy_from_sgl(req, id * sizeof(range), &range,
+					     sizeof(range));
+		if (status)
+			break;
+
+		src = (le64_to_cpu(range.slba) << (req->ns->blksize_shift));
+		len = (le16_to_cpu(range.nlb) + 1) << (req->ns->blksize_shift);
+		ret = vfs_copy_file_range(req->ns->file, src, req->ns->file,
+					  pos, len, 0);
+		pos += ret;
+		if (ret != len) {
+			req->cqe->result.u32 = cpu_to_le32(id);
+			if (ret < 0)
+				status = errno_to_nvme_status(req, ret);
+			else
+				status = errno_to_nvme_status(req, -EIO);
+			break;
+		}
+	}
+
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
@@ -330,6 +371,12 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
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
@@ -376,6 +423,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_file_execute_copy;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8cfd60f3b564..42aa7bac6f7a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -393,6 +393,10 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	off_t			copy_dst;
+	off_t			copy_src;
+	size_t			copy_len;
+	size_t			copied;
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index bff454d46255..551fdf029381 100644
--- a/drivers/nvme/target/trace.c
+++ b/drivers/nvme/target/trace.c
@@ -92,6 +92,23 @@ static const char *nvmet_trace_dsm(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvmet_trace_copy(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 sdlba = get_unaligned_le64(cdw10);
+	u8 nr_range = get_unaligned_le16(cdw10 + 8);
+	u16 control = get_unaligned_le16(cdw10 + 10);
+	u32 dsmgmt = get_unaligned_le32(cdw10 + 12);
+	u32 reftag = get_unaligned_le32(cdw10 +  16);
+
+	trace_seq_printf(p,
+		"sdlba=%llu, nr_range=%u, ctrl=1x%x, dsmgmt=%u, reftag=%u",
+		sdlba, nr_range, control, dsmgmt, reftag);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvmet_trace_common(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -129,6 +146,8 @@ const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvmet_trace_read_write(p, cdw10);
 	case nvme_cmd_dsm:
 		return nvmet_trace_dsm(p, cdw10);
+	case nvme_cmd_copy:
+		return nvmet_trace_copy(p, cdw10);
 	default:
 		return nvmet_trace_common(p, cdw10);
 	}
-- 
2.35.1.500.gb896f729e2

