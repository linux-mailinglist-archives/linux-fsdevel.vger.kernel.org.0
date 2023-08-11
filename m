Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB478778D75
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236466AbjHKLU6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbjHKLUh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:37 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7EEF10C0
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:33 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230811112029epoutp0362baa90109e2dcc0be52de6a69ab9cf5~6UDxIBTUp0649206492epoutp03T
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:29 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230811112029epoutp0362baa90109e2dcc0be52de6a69ab9cf5~6UDxIBTUp0649206492epoutp03T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752829;
        bh=SgrrxE/DIDCUC/jKWs50cNHPDzZPDxAIGdkdosbOBe4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W7ZHc35raO0Hv9ecFOIJGGId3C4TyVdArXQEiD1yL11w4PzvtHUjEfG74VktQSs9T
         1P92oG/JqXQkpdXUgB2Q/RwuNHR2b30bbRV4mZeMYZ8HhpstLIyq/p2eed5kD+P4zG
         HiIWsmYJQJL6AAQxmuWIKDrYUVL24lwLbhbb1NJE=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230811112029epcas5p1d57cf57df7ce15f24f490864236d4202~6UDwjdodZ1522015220epcas5p16;
        Fri, 11 Aug 2023 11:20:29 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4RMhDC71Xqz4x9Q0; Fri, 11 Aug
        2023 11:20:27 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.7D.55522.B7916D46; Fri, 11 Aug 2023 20:20:27 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230811105756epcas5p46a7e3f00c33e912e76848c989fc8eac2~6TwERYjTr2396023960epcas5p4O;
        Fri, 11 Aug 2023 10:57:56 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230811105756epsmtrp223999247eaddc317989c0e9dfe7381da~6TwEQFYdS2549525495epsmtrp2e;
        Fri, 11 Aug 2023 10:57:56 +0000 (GMT)
X-AuditID: b6c32a49-67ffa7000000d8e2-fc-64d6197b7e5b
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E2.11.30535.33416D46; Fri, 11 Aug 2023 19:57:55 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105751epsmtip29fe71556c0e82a3e46ed54ea6a5a827c~6TwAFLGKd1482514825epsmtip2J;
        Fri, 11 Aug 2023 10:57:51 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 08/11] nvmet: add copy command support for bdev and file
 ns
Date:   Fri, 11 Aug 2023 16:22:51 +0530
Message-Id: <20230811105300.15889-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xTZxjmO6c9LSjmWJz7YJORGskA6WVS/ABRUcaOGVOIGdk12NETQEpb
        2yKOZZGLCEKEwjoX6oYyCEwwgOUyBQqkxDFxgwkDLURkk05YgSI4LjLZWgub/573ed73eS9f
        PjbOWSY82IkyNa2UiaVcwoXR3OXj4/+Z+5BEkHdDgOp6fsBRpuYZjmruFxLI0jUH0HhnDkBj
        HfuQYeYiE5k6b2DoSs1NDBUbhwAyD+owZBj2Q2VnKxiozXCLgQZavibQpUozC1V1r2LonsYM
        UPPKJRzVWqwM9OPwK6jvWTdz/1aqb/Qagxr4OYXSV58jqIaK01SrKZ2gygu+YFLns2YI6rF5
        mEFZ2wcJqqCxGlDzek9KPz6NRW38IGlPAi2W0EovWhYnlyTK4kO5bx+NPRgrChQI/YVBaDfX
        SyZOpkO54ZFR/hGJUtu+XK+TYmmKjYoSq1Rc/t49SnmKmvZKkKvUoVxaIZEqAhQ8lThZlSKL
        58lodbBQIHhDZEs8lpTw8HdPxcThU49NiyAd5IblAWc2JANgztN+LA+4sDlkK4CTBi3DLnDI
        OQAHB9McwgKAuY3jjPWK/p+0TIdgAPDR6p218mwM1i3dtQVsNkH6wdv/sO38FjIdh/Wt5cAe
        4KQRg7qyacxu5UZGw+Kylee2DHIHNGXWEHbsSgbDkZJ2YDeCJB8WPthsp53JEGjV96+lbIa3
        ShwT4eRrMKvpIm73h2SOM1ycLWc5Rg2HxnTtGnaDf3Y3rmEPOD9jIBw4FV7Rfkc4is8AqLur
        Aw5hH8zuKcTtQ+CkD6xr4TvobfDLnlrM0XgTPL8yjjl4V3i9dB1vh1frLq/5u8OhxYw1TMHW
        M/Msx7UKADT1ZTE1wEv3wkK6FxbS/d/6MsCrgTutUCXH0yqRQiijU/975Th5sh48/wO+h66D
        +2OzPCPA2MAIIBvnbnENPdov4bhKxJ+m0Up5rDJFSquMQGQ7eBHu8VKc3PaJZOpYYUCQICAw
        MDAgaFegkPuyqyX7GwmHjBer6SSaVtDK9TqM7eyRjmm1h00xBQ29HZNnU/864umd4RSyQeR2
        boyqHd3EASVHpJZXh/Xf7j5dVNpSUR/qcWhvRH0bL+yPKf7OYyOzt3tPHF9OncvVdGuUDdtY
        D34diRywurxubsosegt/mnTgk5IZp7alj6aWLM3vv1NZzDk10zq6vZd+1/c9ds3sPe9KJ95X
        qzHnhrkL5JObHQeqSis3RJS2y6ZCwljNbSe97+zSROMfBu2oWjA9vLrou9+9kR/8/VRCzPFf
        yvim/MnE/AtdTZ3TQzkf/ybK2JlX+GSkZ+Jv9Ua139a5C5Yc/2v1aeZHhIJnXWaygt4MdomO
        s4bnO7WNTcxbI9vpE136ieLPB0JiuQxVgljoiytV4n8BYdMF14wEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWy7bCSvK6xyLUUg5Y1JhbrTx1jtmia8JfZ
        YvXdfjaL14c/MVo8OdDOaPFgv73F3nezWS1uHtjJZLFy9VEmi0mHrjFaPL06i8li7y1ti4Vt
        S1gs9uw9yWJxedccNov5y56yWyw//o/J4saEp4wW237PZ7ZY9/o9i8WJW9IW5/8eZ3UQ8zh/
        byOLx+WzpR6bVnWyeWxeUu+x+2YDm8fivsmsHr3N79g8Pj69xeLxft9VNo++LasYPT5vkvPY
        9OQtUwBPFJdNSmpOZllqkb5dAlfG40dyBS/8Kj7e/M7YwNjh2MXIySEhYCJx6cwUVhBbSGA3
        o8TTnVIQcUmJZX+PMEPYwhIr/z1n72LkAqppZpL4tukUUxcjBwebgLbE6f8cIHERgS5mic6d
        71hAGpgFzjFJnLzND2ILC/hL3Ht6lh3EZhFQlbjZtJoNxOYVsJK4PXMfI8gcCQF9if77giBh
        TgFrifebLrFB3GMl8WHZQUaIckGJkzOfQI2Xl2jeOpt5AqPALCSpWUhSCxiZVjFKphYU56bn
        FhsWGOWllusVJ+YWl+al6yXn525iBMeoltYOxj2rPugdYmTiYDzEKMHBrCTCaxt8KUWINyWx
        siq1KD++qDQntfgQozQHi5I477fXvSlCAumJJanZqakFqUUwWSYOTqkGJsvrbOEPwhZ03u5T
        O1pw/IXJIy3dmZaen24IZJ4p/bs72kn4YWPb41ldR67Hihp3Ws4or+tZt61tgXSyWnb69R6/
        N+8sHj3S//RUcsnvKbWcIptzNMzjZthd0u0I3rqlmfuNTGa599a7uWzq5/XmK6hNXlg1Nf1I
        x7zIRYnnQgQ/3N374cjs3alvplb/m+g+r9TOhnHGW8ED518I5fMsn5Xglis/M4L5xrnXbBfk
        9gnW1v835mtJmbr9YPH/p0emlLc85QmW5Xj3Lvils86WWyoG14tUBbaLMYtWxibUCCiudQp+
        x1vMMbfSZO7a9LVBvSsjX04JupaRVvjKfbrc4Vmp8cGTjbjMOGxl/ujMVmIpzkg01GIuKk4E
        ADHOmd1AAwAA
X-CMS-MailID: 20230811105756epcas5p46a7e3f00c33e912e76848c989fc8eac2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105756epcas5p46a7e3f00c33e912e76848c989fc8eac2
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105756epcas5p46a7e3f00c33e912e76848c989fc8eac2@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
index 2733e0158585..3e9dfdfd6aa5 100644
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
@@ -450,6 +462,87 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
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
@@ -468,6 +561,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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

