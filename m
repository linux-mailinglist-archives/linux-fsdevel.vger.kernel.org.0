Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1769CB60
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjBTMt5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:49:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232177AbjBTMtZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:49:25 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1241D913
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:47 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20230220124845epoutp01bff818fdbb3f264ac79d437d314738e4~FiTuu92k41416414164epoutp016
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20230220124845epoutp01bff818fdbb3f264ac79d437d314738e4~FiTuu92k41416414164epoutp016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897325;
        bh=hlngMEoG/BfQdcVrdcgCbSfAL4Q2ta3nA5lHwKWrJg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qW4/OU0DaggEAB7BRVgLTbPl0se+L6Nw4vgR7NB8iym+pXXNxEawTt52UAEr6rhOz
         6ER0q6VWU6dR1r373613/rzTOW+aC1T23pbp+QMhv3WU0ywNPDYolTO933OJnbmvHa
         9XN2WKjmALS3hd7PHapMiPNiETY92Ah6Rl+ijmN8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230220124844epcas5p4e8f677be24951b53fbcd1d1a74a7926b~FiTtzMczc2866528665epcas5p4I;
        Mon, 20 Feb 2023 12:48:44 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PL2KQ4WLhz4x9Pr; Mon, 20 Feb
        2023 12:48:42 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.A6.55678.A2C63F36; Mon, 20 Feb 2023 21:48:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230220105520epcas5p34fe94decec6573d9b7b3df5df9286ef7~FgwtH6krJ2350123501epcas5p35;
        Mon, 20 Feb 2023 10:55:20 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230220105520epsmtrp127665fdad1b26414bdde90921e6badbc~FgwtGvynU2386223862epsmtrp1-;
        Mon, 20 Feb 2023 10:55:20 +0000 (GMT)
X-AuditID: b6c32a4a-6a3ff7000000d97e-9f-63f36c2a3b30
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4E.8C.05839.89153F36; Mon, 20 Feb 2023 19:55:20 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105517epsmtip2c9ff687be9db028018092cc6b781f914~Fgwp2VCrY0503205032epsmtip2f;
        Mon, 20 Feb 2023 10:55:17 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 6/8] nvmet: add copy command support for bdev and file ns
Date:   Mon, 20 Feb 2023 16:23:29 +0530
Message-Id: <20230220105336.3810-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230220105336.3810-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbdRTO795yW0iqF4bhN5ax5i7LBMaj2NbLpBvioneDOcKi0aFh13Kl
        SGlrH244F6C8hMk6QBZX2OiQoTAEBKx0HThRLNAQNDAQkAGRLoAZFNE9YBPbtej++84533ee
        ORzU7ww7kJMu1zAqOS0jMB+W6YfgkLAQ2aok0n5jO9ky8BNK6s49QsmrU3qMPO94gJLrg0Mo
        2bVU5UWO3zAj5PXacoRsuNqLkJbLKwjZu3EHI8t7RgFpv2lAyK6JUPJ6Vz+LHL5WjZE19XY2
        2VORh5Cdc7mANK3XoGTzH8sssm9iGzn0yOoVG0ANj8RThulBjDIbptjU0K2vWdTwoJZqayzG
        qPa6bMoynoNRpXlLTkLBtBe13H0To852NAKq3XaKWm0Lotrm7iCJTx/LiJEydCqj4jFyiSI1
        XZ4mJuKPpryUIhRF8sP40eTzBE9OZzJi4kBCYtjL6TLnCgjeB7RM63Ql0mo1EbEvRqXQahie
        VKHWiAlGmSpTCpThajpTrZWnhcsZzV5+ZGSU0Ek8niFtXrGhyof7T3Yv2r1ygElYArw5EBfA
        9oXfsRLgw/HDLQDOTK55jD8B/GXYgriNuwD+tdaHbUqu/Kz3BLoA1K9Y2W4jD4G1rausEsDh
        YHgotG1wXAJ//DcEmm07XRwUn0Fgja4OuAJb8AS4dnGR7cIsfBesaFxiuTAXj4YXBxrZrjwQ
        j4D6aV8X9Mb3wnv5WW6GL+y/MPeYjeI7YN43VagrPcS/8IZ3y+o8jR6A1spyxI23wEVrB9uN
        A+GCvtCDT8CGT7/E3OJ8AA1jBuAO7IcFA3rUVRjFg2HLtQi3ezusHGhG3IWfgqXrc578XNh5
        aRPvhE0tRk8PW+HovVzMPQoFh6wS96pKAWy1ziHnAM/wxDyGJ+Yx/F/ZCNBGsJVRqjPTGLVQ
        GSVnTvx3ZIkisw08/oqQQ51gdsYR3gMQDugBkIMS/twN7qrEj5tKZ33IqBQpKq2MUfcAoXPd
        ZWjgMxKF863kmhS+IDpSIBKJBNHPifhEAHe3uF/ih6fRGiaDYZSMalOHcLwDc5DQ0NjTV4ou
        2L2lTaIXb1U4xtXiSV394YkjvW+98/ex4jPvFVSPnJ5psCT3OUbqjiYIPznLvp8xchv49Ask
        xWnZJr/Ln6lUr+he6Hgz2BLwY1xL+0d0VKW/4/7YtspVh/Z9pDToNqUd/bw6+dd8cdK3WbuM
        D4IJrXV+ut4WdLLz2bE1NHa+UsErahvc4SWdzx04NDXL2HT1E/ETrXt27S6K0X23Qn+80RzI
        Dor7vnypatJssvcqil49ePi8rmTfKEM8jP1q9t3sJHC8e6l22Zz0ujL5bew186nC0tzs2VCJ
        KbPpks63Kqwsbk+Aztdox42Di8axQvaRN/6xzosWmiPWZwiWWkrzQ1CVmv4Xvlng5p4EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Re0hTYRjG+845Ozsaq+OU/FTSWEVl5ZSyvqKmFdWJMiqIblItO5nk5trR
        zPojb0Eq5dC8tHkrauisSTNveSFWs3kZWlp0dVQuKdlUVpiamVOC/nve9/k97wvvS+FCI+FL
        xcjjWaVcGisi3Ynap6KA1YX7nVHB1nIRqmpvxVGqahJHlR+zSZQ/PIajCUsXjpodGh56+6QB
        Q013cjBUUWnCUOPtEQyZpuwkyjG+Bsj2So2h5ncrUVNzG4F6HheRqFRr4yNjbhqG6vtTAKqd
        KMWRfnCIQOZ3fqhr8jkv3Jvp6d3NqK0WkmlQf+QzXX0PCabHksAYdBkkU333CtP4Nplkrqc5
        poGrVh4z1PKKZG480gGmuuMy4zT4M4Z+O7Zv/lH3TafZ2JgLrFIsOel+Vj/SgSt+h11s+W7j
        JYPa0EzgRkF6LbzXnY1lAndKSDcCqDHoiVnDB2onn+Gz2hNW/Bngz0IpGDQXVYJMQFEkvRJ2
        TFGuvhf9FYOWvs+4q8BpBwZ1n7Q8V9qT3gPHi7/zXZqgl8JcnWNmg4DeAIvbdXzXIEiLYbbV
        wyXd6I1wND3JRQinCXNONZilPWDbrf6ZJE4HwLQaDa4CtPo/S/2fVQYwHfBhFZwsWsaFKELk
        bGIQJ5VxCfLooKg4mQHMvDlwRT2o0w0HGQFGASOAFC7yEkwJnFFCwWlp0iVWGXdCmRDLckbg
        RxEib0F3ZtsJIR0tjWfPsayCVf5zMcrNNxkTh450VmWLnEsaHd/2PymSdBMl6/Xyz3nbxr8E
        SyWaHarhVrttRViiWum7mm1wHFx/7VBfzd5Ibe+iNf6nthR6HUvviGjPfRCnWHXbrEr/PX1O
        +4GSrHHfNVbT9sjRn6ZOznozPSLUmVCsOX9o7MvkvAFQHrg561dLU3DBuUudVeLB5Un8rIwP
        vUfaLPpUbaGy1+PlxHOwwCdgzta6+7Gpywr8dxE/TM0DXja3uWrFEvnOM4fzU6bK/caOV9R9
        kuTM2ffm0ULDcH2wSbZ5Ez7+MN473EyGqY++r4lp9eRkaWWR9xZXSAoW5O1+nNxEcuKIdS+2
        UQWqIt4BPOSqvSxMRHBnpSGBuJKT/gVUrOT4VQMAAA==
X-CMS-MailID: 20230220105520epcas5p34fe94decec6573d9b7b3df5df9286ef7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105520epcas5p34fe94decec6573d9b7b3df5df9286ef7
References: <20230220105336.3810-1-nj.shetty@samsung.com>
        <CGME20230220105520epcas5p34fe94decec6573d9b7b3df5df9286ef7@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 6a54ed6fb121..66a45121f5a0 100644
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
index 871c4f32f443..76db307f5b30 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -328,6 +328,49 @@ static void nvmet_file_dsm_work(struct work_struct *w)
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
@@ -336,6 +379,12 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
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
@@ -382,6 +431,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
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
index 89bedfcd974c..69ed4c8469e5 100644
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

