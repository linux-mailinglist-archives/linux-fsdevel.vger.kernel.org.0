Return-Path: <linux-fsdevel+bounces-4974-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4388806C37
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07A03B208AB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B192E3F3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="L6bKngid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F8A8D4D
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:12:23 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231206101221epoutp04e983ec0c922afbfea8dc7ca0417c69ae~eNmrO3KAP1647316473epoutp04X
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:12:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231206101221epoutp04e983ec0c922afbfea8dc7ca0417c69ae~eNmrO3KAP1647316473epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857541;
	bh=uOAKePf/EC3LoZnFEX09yOYQgAaLwiBeLuJB0GWSSoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6bKngidO1Tuve/sM0yGzW4aHSvJ4V8zR65igPFyX04th1v/DVpinxheb80zFGx1q
	 +LLk5iRa+j2rigQFDStB1DggeOGZAxb6LtK64w2XM+zcsHq2GIc3lCmb2B4lyuTDnI
	 pfm9Y0ynPIF1LRf/a3jXIHYchL9PLVnfzb0l5iwc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231206101220epcas5p35bbaf46727278f8d48a5fe4d6be0f5c4~eNmqZcRLT0789207892epcas5p3j;
	Wed,  6 Dec 2023 10:12:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SlY9b22qSz4x9Pw; Wed,  6 Dec
	2023 10:12:19 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	7E.D6.10009.30940756; Wed,  6 Dec 2023 19:12:19 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231206101218epcas5p3bd5005a84adf67a80d394c3e05796bd7~eNmomUm130791407914epcas5p3g;
	Wed,  6 Dec 2023 10:12:18 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231206101218epsmtrp217a2e5b0a9cb015fb653b55a7c6ddaed~eNmolF_vN1007210072epsmtrp2O;
	Wed,  6 Dec 2023 10:12:18 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-aa-6570490359be
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	80.62.08817.20940756; Wed,  6 Dec 2023 19:12:18 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101214epsmtip248d44b17f67df20f2c2e9a1abb6e15b2~eNmkNOL7S1181011810epsmtip2L;
	Wed,  6 Dec 2023 10:12:13 +0000 (GMT)
From: Kanchan Joshi <joshi.k@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, dm-devel@lists.linux.dev, Keith Busch
	<kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 08/12] nvmet: add copy command support for bdev and file
 ns
Date: Wed,  6 Dec 2023 15:32:40 +0530
Message-Id: <20231206100253.13100-9-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVBTVxTG57738pLQiU2DHW/jTAmvwzBgWWIhvSh0UcY+u4HTzbbTgUje
	AJKtWYq2MqKMIBjZUh1Jla1oKahUAkyQTaHsBSyILC1M0aRQEAFRawWkCYmt//3OPd83Z75z
	53BwQRZbyIlX6hiNUiqnSDeipsXH2w/fqWYCr8+xUEVXG44W7i8R6HD2Co7Kx7JINNNyFyDr
	lTSACovPEGjkSi2G6otzMfRjeSuGcptvAGQbNGGoYXQTKkotIVB9QyeBBi6fJlHBORsbHRuy
	kOiH9scYGs62AZRzdBBDFushgGqWCnB0cWaOQB2jG1HfSjvrDSFdaxpj033jlwh6oEdPV5al
	k7S55CA9Zc4DdN1IMkl/n2lk0cdT7pD0gm2UoOcaB0k6s6oM0Obub+jFyhfpSussFvnsZwmh
	cYxUxmhEjDJGJYtXxoZR73wQtT0qWBIo9hOHoFcpkVKqYMKo8Hcj/XbEy+0roURfSeV6+1Ok
	VKulAl4L1aj0OkYUp9LqwihGLZOrg9T+WqlCq1fG+isZ3RZxYODmYLswOiFu6oSJpV55a1/3
	xWZWMhjZmgG4HMgPgv+cbmNnADeOgF8H4NDtacJZ3AXw0MlO0lk8APDX9A78iWUy/RzubDQA
	+KjjKHAWiwC2ZUzaLRwOyfeB14x6h2E9/zwOay+JHRqcn49D8812zNFw5++C5ZnGNSb4XnBo
	Nm1tAo+P4NipXtc0D5jX/zfbwVx+CDROFrs0z8HOPCvhYNyuSan+zqU3c6HFFu3kcNhbXc92
	sjucbq9ysRAu3mkgnRwD+/N6MSfr4K36qy5+HR7pysIdWXB7lorLAc5R6+DxJSvmeIZ8Hjya
	KnCqPeF4ro3l5A1w4lSJi2m4kFvi2pUBwIdNtXg28DA9lcD0VALT/9MKAV4GXmDUWkUsow1W
	b1Yyif99bIxKUQnWLsP3bQuY+GPevxlgHNAMIAen1vPkfSpGwJNJ93/NaFRRGr2c0TaDYPuK
	c3Dh8zEq+2kpdVHioJDAIIlEEhTyikRMbeDNHDkjE/BjpTomgWHUjOaJD+NwhckY+3NbOHe5
	2hIqyxhpOtByU8UpldvCuCM+6WRFkpsgvWhf4liKovUjr9/H0wL0ewr0XfNJ7z3w33r4ZGPh
	2Y2d+lRvQ+Evnn37/bv2nk8ZBDI3fdJP5ZI9J7wOrOK2VTKfKBpdKfRsXfx5Sw2W3ZdIf/Ib
	DB/YPvzho2DR3r/4UztFEfcUuzzyL4BYWjz+6b0bMyaN+ury/Lbll67tPthIVmWLjvlGZO0W
	eVPRPfc1mjr3WWvPt13W5QvPrGuiAtyn/+xcNrxf2i8c8lr98vrZiNtk/sOZ9oQJcwFza/7l
	KKOl0WZo25HzhXEuQrXNQL8ZU5on6daG+RQYHidu+piXOEwR2jip2BfXaKX/AvwJ/J6iBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra0hTYRjHe895d3ZmnTytsjdXSetCTfJG0RtdIcMTREqRRAS58jStTdeW
	VlZkjm4zTVtRrtRaZWZWOC9Z04jZbZqaiZepC5ItV2Jq0Q2dlY6gbz/+v//zPB8emhQ3Q386
	PmE/r0mQK6WUD6yokQYsItar+ZBqx2z8oPYFiQe/DUGcluUh8V3HOQr31nwB2Pn0FMDXTLkQ
	258+InCV6TyB79x9TuDz1laAXS1GAld3BOLrJ29CXFVtg7j58VUK5xe4hDi9rZLCt1+OELg9
	ywVw9ukWAlc6jwNcMZRP4vu9/RC/6pDgRs9LwRp/7pHRIeQa35VArrk+iTMXnaG40pvHOHdp
	DuAs9lSKu5FpEHAZus8UN+jqgFz/kxaKyywrAlxp3WHuq3kWZ3b2EVG+23xWxPLK+GReE7wq
	xifOfdEoUHsiDtbdtwpSgX25HohoxC5GPWcKSD3wocWsBaDu4WHgFdOQrvWn0MuT0Z2RHqG3
	NAiQ3lgL9YCmKXYhemNIGs2nsJUk+nVPR4wOkGwxicpymVGezEaivlsl5ChDdh5q6zs1xgyL
	keNyA+k9EIBy3v4YOyZilyFDj2ksF//tPDl+CXr7k5Atxwm9+wOQrvwKmQVY43/K+J+6Bogi
	MJ1Xa1UKlTZUHZbAHwjSylXapARF0K5ElRmM/V0mqwRVRQNBVkDQwAoQTUqnMMrGRF7MxMoP
	pfCaxB2aJCWvtQIJDaXTmO+9GbFiViHfz+/leTWv+WcJWuSfSqgF4rpXaPxKOniiIvWL343n
	TaLVSt2m4hhT4+uS3p65Z9MeZttTVq3rCmeEfsPPGGk9nufosxwoZiw1uzdKLLnEjKjuH7kb
	DB/7yzPTrOajwU6bUJU3VDgQUZZyjlo5J1LmiW3VJrc3bU0u6LKta+iw7YjrHNpOLI9ksvvj
	00LCfX3XaNySPV0lnR8UBk+0M15XvoCE/nlnjcMZM/XQLXEfUiqiVm/eNS4mLzoqzDVVtv3W
	6++7j+wrLgs/8T5wrshlbvpUG1gxNfDDQL3kmH2prLMzfUEYSeJvDTFBS9q5nW9Me+enTJ/Q
	nY7rA7pCfx9Zq3OtHWm7EPH49pZCKdTGyUNlpEYr/wMbdITmZgMAAA==
X-CMS-MailID: 20231206101218epcas5p3bd5005a84adf67a80d394c3e05796bd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101218epcas5p3bd5005a84adf67a80d394c3e05796bd7
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101218epcas5p3bd5005a84adf67a80d394c3e05796bd7@epcas5p3.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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
index f11400a908f2..f974858ae5a0 100644
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
@@ -451,6 +463,61 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
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
+	rq->copy_len = ((__force size_t)range.nlb + 1) << rq->ns->blksize_shift;
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
+	status = errno_to_nvme_status(rq, ret);
+err_rq_complete:
+	nvmet_req_complete(rq, status);
+}
+
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -469,6 +536,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
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
index 2d068439b129..0a8337596f0c 100644
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
+					  pos, len, COPY_FILE_SPLICE);
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
index 6c8acebe1a1a..b648baeb52cf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -405,6 +405,7 @@ struct nvmet_req {
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


