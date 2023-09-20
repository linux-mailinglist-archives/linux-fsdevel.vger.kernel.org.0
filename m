Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECBA37A76AE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbjITI74 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbjITI7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:59:21 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97DCF2
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:39 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230920085838epoutp039ac2821633ed0035f0a5c9729e4dc2b3~Gj7UtPpgb1763017630epoutp030
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230920085838epoutp039ac2821633ed0035f0a5c9729e4dc2b3~Gj7UtPpgb1763017630epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200318;
        bh=ffw02p9pmXuydxofYTTqZSKySXsPh7qWn6KVyBPXmgo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qerXwVLYehJATb1o2MdytLOh6L2CWwaHbQ6B3RfoSoeGo9A6tiTbh8wkkXZR27KyM
         pGn5Z4mRbj4sB6WQWZhok+R87z6eq23YHZCI5Rt67JUFWzLNRSH61M83eSi6h4laM3
         a0ZORpfSztTnhTQYyBKBBKJ3U4KJcp21tcybwbRQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230920085837epcas5p17cf144a4b2b35fdf44e2ac3be7dcef1a~Gj7UHaeTi0342303423epcas5p1F;
        Wed, 20 Sep 2023 08:58:37 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.183]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RrCB40W9dz4x9Q0; Wed, 20 Sep
        2023 08:58:36 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.F1.19094.B34BA056; Wed, 20 Sep 2023 17:58:35 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230920081539epcas5p23035fe3e03eeb7848a40aff580e5cdbf~GjVy5NaBp1340213402epcas5p24;
        Wed, 20 Sep 2023 08:15:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230920081539epsmtrp1ee11ca2f1b8c10ec528e1803f5e22428~GjVy4Lj-L2250122501epsmtrp1i;
        Wed, 20 Sep 2023 08:15:39 +0000 (GMT)
X-AuditID: b6c32a50-64fff70000004a96-be-650ab43b700f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        99.9E.08788.A2AAA056; Wed, 20 Sep 2023 17:15:38 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081535epsmtip1784cc8d37f19d0276b5712c51437ec8b~GjVvpi5ow3071830718epsmtip1U;
        Wed, 20 Sep 2023 08:15:35 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 08/12] nvmet: add copy command support for bdev and file
 ns
Date:   Wed, 20 Sep 2023 13:37:45 +0530
Message-Id: <20230920080756.11919-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TbUxTVxjeube0haTmyoc7dLo1ZXMTA7RSygFkGgG9DNxYTCSaLHiBO4qU
        tustOrcYYVAXNBYoYlyZ4ITJAAH5lI+CyscQEDohgDZjbKRsbAScsK0hiK704ua/533O85zn
        vO/Jy8fdC3lCfqpKR2tVlFLMdeO09Ozw9QtrcqMl7XY5qhv8HkdP/l7loC/y13BUPZXHRfM9
        SwDZ7nwJUOdisQt6dKcNQ+ZrRgxVVvdhyNg9AdDsuAlDndad6Juz5Rxk7hzgoLH2r7mo9Pos
        D52fbOWiiv5nGHqYPwtQqy0LoJbVUhzVzj/moHvW15Blrd9lrzfZZprikZaf6jnk2HAG2VCV
        yyUby8+QHY8yuWSZodCFvJC9yCWfzFo55OOucS5paKoCZOPQ5+Ryw+tkg20Bi9t0NG23gqaS
        aa2IViWpk1NVKeHimEMJEQlBconUTxqCgsUiFZVOh4sjY+P89qcqHYMQi05QygwHFUcxjDjg
        3d1adYaOFinUjC5cTGuSlRqZxp+h0pkMVYq/itaFSiWSXUEO4bE0RUtTG9DUHPjUOPcMzwQF
        YeeAKx8SMtg83IufA258d8IMoGW4GGOLJQB/We4FbPEPgD8+zXLI+E5LYccRlu8EsH2lfMOu
        x6C9psop4hI74dBz/jrvSWTi8GZHmfMmnCjBYeNMP7Ye7kF8CC8NjuPrmEO8BStHxpxYQITC
        36yNG2kBMG968zrtSoTB5fJJHivZDAe+snHWMU68AbObi52PgES1K1y5UbfhjYSTrdFsnx7w
        j/4mHouF8Pe8sxv4JKy8+B2X9eYAaJo0AfZgD9QP5jnvwYkdsK49gKW3waLBWozN3QQvrNow
        lhfA1pIX2AfeqLvKZbE3nLBnbWAS/mpu47HDMgDYW7GI5wOR6aV+TC/1Y/o/+irAq4CQ1jDp
        KXRSkEbqp6JP/vfNSer0BuDcDt+4VlB9c82/G2B80A0gHxd7CtK3u9HugmTq1Ge0Vp2gzVDS
        TDcIcgy8ABd6Jakd66XSJUhlIRKZXC6XhQTKpeJXBfP6K8nuRAqlo9NoWkNrX/gwvqswE4v2
        Ueq7+D+XhJx5c+a9xJVRKZoIcTn5CWbfQ031v11Wb/Ia2Dd8sKCHqX/wgdTSbY1bMG8p8jrh
        P2ZXLk7OJR4/HT9RKLKlHG2I+nY1sqb0cGLElNvxiPtbjXuvpwVfHjnm09WrPyUbvbvVP6rg
        9EexzEHtO0OXbksKLxqPtJX69W7vEmxLak+0W/ZFFt+/p7gS4Ln08WiltT7eULHLRdFY25eL
        3T50LdNQO/M0Cnoyf4UvWMzPedHNnQduxYize14Jnuvx2HI5dn+ALSdyBOv6U1yZMP4wzXBr
        vIh6oL7L+0Hf3DdgnNZa4mMCdaG5h2Pfz5kW+pLx8vbzmHd5XqooUMxhFJTUF9cy1L/CKy38
        pgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrOIsWRmVeSWpSXmKPExsWy7bCSnK7WKq5Ug6UvrC3WnzrGbPHx628W
        i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZDHp0DVGi6dXZzFZ
        7L2lbbGwbQmLxZ69J1ksLu+aw2Yxf9lTdovu6zvYLJYf/8dkcWPCU0aLHU8aGS22/Z7PbLHu
        9XsWixO3pC3O/z3O6iDpsXPWXXaP8/c2snhcPlvqsWlVJ5vH5iX1HrtvNrB5LO6bzOrR2/yO
        zePj01ssHu/3XWXz6NuyitFj8+lqj8+b5Dw2PXnLFMAXxWWTkpqTWZZapG+XwJWxbctOxoK1
        7hWTXvxjbmCcaN3FyMEhIWAiMXl3ZBcjF4eQwG5GiX0H/jN2MXICxSUllv09wgxhC0us/Pec
        HaKomUni/8YLbCDNbALaEqf/c4DERQS6mCU6d75jAWlgFljDLLFlLi+ILSzgL/H7VQs7iM0i
        oCqx8txlsKG8AlYSz29tZoY4Ql+i/74gSJhTwFri85LrYOVCQCWnL8xnhygXlDg58wnUeHmJ
        5q2zmScwCsxCkpqFJLWAkWkVo2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwXGtp7WDc
        s+qD3iFGJg7GQ4wSHMxKIry5alypQrwpiZVVqUX58UWlOanFhxilOViUxHm/ve5NERJITyxJ
        zU5NLUgtgskycXBKNTCdXLO5IzL8R+xOoeWTYqf3y1taay0Rb4xPL3Hd6vxpsljgTp3buy8y
        Mc/XnVkrsKOUefO8n/d+3NRRObAi9vdh7itHfqYeSzY6FinpZ1ajKL3qGcO6WdcLjA6r1mvc
        r37jfGkz781zl4//1/RYaeIZd8DoSqH5H3XW/0XnfGZYNDiUshvllcz97DLTZXVpYGHwLfNq
        /bmpYR6mB+R/dqk9yoltCbc6K2N98sVyvYWpOpZ2YVenOcvyXD307pP95a1fertj1Aok6ssE
        NhqwMO4o2Ry6Re6weQjjD9Pg0/9UK/JEr6RUGl+4bsXxfrOH6uTgb1t+Gz3TZwhjlrYM1Ds0
        0cfufej1x8+//dXeKanEUpyRaKjFXFScCADPl5/zWgMAAA==
X-CMS-MailID: 20230920081539epcas5p23035fe3e03eeb7848a40aff580e5cdbf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081539epcas5p23035fe3e03eeb7848a40aff580e5cdbf
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081539epcas5p23035fe3e03eeb7848a40aff580e5cdbf@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for handling nvme_cmd_copy command on target.

For bdev-ns if backing device supports copy offload we call device copy
offload (blkdev_copy_offload).
In case of absence of device copy offload capability, we use copy emulation
(blkdev_copy_emulation)

For file-ns we call vfs_copy_file_range to service our request.

Currently target always shows copy capability by setting
NVME_CTRL_ONCS_COPY in controller ONCS.

loop target has copy support, which can be used to test copy offload.
trace event support for nvme_cmd_copy.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/target/admin-cmd.c   |  9 +++-
 drivers/nvme/target/io-cmd-bdev.c | 71 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 50 ++++++++++++++++++++++
 drivers/nvme/target/nvmet.h       |  1 +
 drivers/nvme/target/trace.c       | 19 +++++++++
 5 files changed, 148 insertions(+), 2 deletions(-)

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
index 468833675cc9..2d5cef6788be 100644
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
@@ -449,6 +461,61 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+static void nvmet_bdev_copy_endio(void *private, int status,
+					    ssize_t copied)
+{
+	struct nvmet_req *rq = (struct nvmet_req *)private;
+	u16 nvme_status;
+
+	if (copied == rq->copy_len)
+		rq->cqe->result.u32 = cpu_to_le32(1);
+	else
+		rq->cqe->result.u32 = cpu_to_le32(0);
+
+	nvme_status = errno_to_nvme_status(rq, status);
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
+	off_t dst, src;
+
+	u16 status;
+
+	status = nvmet_copy_from_sgl(rq, 0, &range, sizeof(range));
+	if (status)
+		goto err_rq_complete;
+
+	dst = le64_to_cpu(cmd->copy.sdlba) << rq->ns->blksize_shift;
+	src = le64_to_cpu(range.slba) << rq->ns->blksize_shift;
+	rq->copy_len = (range.nlb + 1) << rq->ns->blksize_shift;
+
+	if (bdev_max_copy_sectors(rq->ns->bdev)) {
+		ret = blkdev_copy_offload(rq->ns->bdev, dst, src, rq->copy_len,
+					  nvmet_bdev_copy_endio,
+					  (void *)rq, GFP_KERNEL);
+	} else {
+		ret = blkdev_copy_emulation(rq->ns->bdev, dst,
+					    rq->ns->bdev, src, rq->copy_len,
+					    nvmet_bdev_copy_endio,
+					    (void *)rq, GFP_KERNEL);
+	}
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
@@ -467,6 +534,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
index 8cfd60f3b564..395f3af28413 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -393,6 +393,7 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	size_t			copy_len;
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

