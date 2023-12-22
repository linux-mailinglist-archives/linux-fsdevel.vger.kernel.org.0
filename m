Return-Path: <linux-fsdevel+bounces-6778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 377A581C5BF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BE331C219F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 631BF17745;
	Fri, 22 Dec 2023 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FplPGCKR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB40F14F60
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231222073240epoutp04799d60d54c72f63949ca425719694b4c~jFv0N42Sf1733517335epoutp04Q
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231222073240epoutp04799d60d54c72f63949ca425719694b4c~jFv0N42Sf1733517335epoutp04Q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230360;
	bh=vH0s1GVcNF5IA3K6MXsproiU6tEBb+c/9OtwFqb8YN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FplPGCKR029A4lfxdOC+GddH0APSg6svbDnNIZR3sS97/Gy9XougBczm2xFGJdEkW
	 deJ6j7Fnybm1uxPVJWhAbed8IshbiwcheX9JU98o97RenB7Fb6RG7Jhbmu20vkWP6b
	 QgNSNp+sGEY2QXshxR5Y3gFONEwHPEwlaSMWNmtM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20231222073239epcas5p373b8f0edde693b3ef67ca791b2c270db~jFvzYYFg51077210772epcas5p3C;
	Fri, 22 Dec 2023 07:32:39 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.182]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SxJsx6LPqz4x9Pr; Fri, 22 Dec
	2023 07:32:37 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
	epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	F9.64.08567.59B35856; Fri, 22 Dec 2023 16:32:37 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
	20231222062207epcas5p4a5e0db868dd96cf4ed614a0283d11c7e~jEyOfFzYV2962329623epcas5p4a;
	Fri, 22 Dec 2023 06:22:07 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222062207epsmtrp1c653c77027174202dee60229bbf4fedd~jEyOcuX9p1657416574epsmtrp1Y;
	Fri, 22 Dec 2023 06:22:07 +0000 (GMT)
X-AuditID: b6c32a44-617fd70000002177-c5-65853b9595a8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.93.08755.F0B25856; Fri, 22 Dec 2023 15:22:07 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062204epsmtip2614200aae659e182071c956838100583~jEyK_zSUv0303503035epsmtip2K;
	Fri, 22 Dec 2023 06:22:03 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
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
Subject: [PATCH v19 08/12] nvmet: add copy command support for bdev and file
 ns
Date: Fri, 22 Dec 2023 11:43:02 +0530
Message-Id: <20231222061313.12260-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTZxT3u/fSFreOS9H4Uac2dVtEhLZCy8dLF+ngJm4ZhixuhAUaekMJ
	0HZ9TJ1s42F5RkDQbZQ36MbDwHgMi4AayGBiRAwDBKNuSHUMAZFJDQiupWXzv9855/f7fuec
	L4eFc0qZXFa8UkdrlLJEPmMz0d7r4eF1LtBAC2tnBKhpoA9HC89XCJRWsIqjhnv5DDTT+wyg
	qWuZAFVWlxFo/FoHhrqqCzFU1/Arhgp7RgEyjxgx1D3hiaoyzhOoq/s6gYYvlzJQxY9mJsod
	MzHQT/1rGLpTYAboTNYIhkxTqQC1r1TgqHFmnkC/TWxHt1b7nd7nUh3Ge0zq1v1mghq+qada
	6rMZVOv5b6m/WosB1TmewqBq8oqcqNPpcwxqwTxBUPNXRhhUXls9oFpvnKQWW3ZSLVOzWLhL
	ZEKQgpbJaQ2PVsaq5PHKuGD+4YjokGixRCjyEvkjPz5PKUuig/nSD8O9QuMTrSvh876UJeqt
	qXCZVssXHAjSqPQ6mqdQaXXBfFotT1T7qr21siStXhnnraR1ASKhcL/YSoxJUFT3DjHVg2HH
	LZ3qFNAcmAOcWZD0habMS0QO2MzikJ0ALk08drIHzwAc6sx2VJYAnP2jj9iQzP8+6WB1A5jd
	dJZpDwwYTJ8bAjmAxWKQnvDGK5ZNsIW8iMOOZpGNg5PlOGyd7MdsBTfyCCwrfrb+KkG+C3Nr
	anEbZpMB8Ha7zYFldRPA/AeutrQzGQgfL9c42Smu8Hrx1LoUJ3fB9F9KcNv7kLzkDLOqJhn2
	TqXwyVwN047d4N/9bQ7MhdP5GQ58DNadrWXYxacANI4Zgb1wEBoG8nFbEzjpAZsuC+zpHfDc
	QCNmN34Lnl6Zwux5NjSVb+Dd8GJTpaMHdzhqSXVgCl7JvuBYVh6AY8vPsQLAM742kPG1gYz/
	W1cCvB6402ptUhwdK1aLlPSx/345VpXUAtbPZK/UBO5UrHn3AIwFegBk4fwtbNW+UzSHLZed
	+IrWqKI1+kRa2wPE1oWfwblbY1XWO1PqokW+/kJfiUTi6+8jEfG3sWcMZXIOGSfT0Qk0raY1
	GzqM5cxNweoqO/a88UVx21Gx2nny0Ue6NS+x6pNcJ2zTTqZ08U/ODumj+m+CZn22pxXNWUbr
	7i6/zJRGeflEFpJ+qVyLqvH+qsJ116LhxWdhVZ8fKp+NyhntDk2+2tY/KIogoWRy+ISufQU+
	9XRJiGKXFPwjYBueLlgiY64Kkruaf6B6TKXk9NJD9fSBd2JWsp54t2PmcTkv133fBxmfHucP
	MIVJES4g8yWfSC6qn4Otd4tjXDkhr0o+frHHb5v+dp3b7qMPFXrOoaitbwZ63PT53uj6gPvd
	4d6GC1k/h71dqm/5GoT0Go4EDBR4HxwU+mRNmvra3psNpS2MoBRzBOWWtinoZPh+PqFVyER7
	cY1W9i+HOC9KrwQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWy7bCSvC6/dmuqweIeZYv1p44xW3z8+pvF
	omnCX2aL1Xf72SxeH/7EaPHkQDujxYJFc1ksbh7YyWSxZ9EkJouVq48yWUw6dI3R4unVWUwW
	e29pWyxsW8JisWfvSRaLy7vmsFnMX/aU3aL7+g42i+XH/zFZ3JjwlNFiYsdVJosdTxoZLbb9
	ns9sse71exaLE7ekLc7/Pc7qIOWxc9Zddo/z9zayeFw+W+qxaVUnm8fmJfUeLzbPZPTYfbOB
	zWNx32RWj97md2weH5/eYvF4v+8qm0ffllWMHptPV3t83iTnsenJW6YA/igum5TUnMyy1CJ9
	uwSujEWHL7AXnHOv+L67oIFxo3UXIyeHhICJxPsrj1i7GLk4hAR2M0p82PKZBSIhKbHs7xFm
	CFtYYuW/5+wQRc1MEhebfwB1cHCwCWhLnP7PARIXEdjBLPFzbTMTSAOzwBpmiS1zeUFsYQF/
	idfbpzGC2CwCqhLdi1eADeUVsJK4uO0R2BwJAX2J/vuCIGFOAWuJ578Ws4LYQkAlJ59vZoMo
	F5Q4OfMJC8R4eYnmrbOZJzAKzEKSmoUktYCRaRWjZGpBcW56brFhgWFearlecWJucWleul5y
	fu4mRnCsa2nuYNy+6oPeIUYmDsZDjBIczEoivPk6LalCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
	ecVf9KYICaQnlqRmp6YWpBbBZJk4OKUamJS8Yk/HzgjoEDrOEmWouFrf/hL/7IzqLV0VxaWf
	m50/V0ts0YxMLin0iVs1UfyhAvf+Qttj2em6fJVPGrZqX78pmvHJa9f9mHWB/0M/XG8rkvPJ
	5W+6cJXJvzihuCpZSuCQtmdMhXSz6KyHLFOepcgutK5ivxL7a4FMhrhcsfrkpm+S52+3HPs7
	b9VGfsaSl+9P2EXHWaa/WahioDRRsNo7zHGSA9dJkc/3Xp/5brNy19G9kss0D83k3KoY/ydn
	BuMX6ZypXz3+Z+1aJVZzXmtn0zS5l0//nFLyP8VQWLF0yf7wW75evyozfkun7Jiz+M5dvdtr
	A8Q/vt84WaXWXmf7spjF9eHqMziWBO9foMRSnJFoqMVcVJwIAHdlVgtkAwAA
X-CMS-MailID: 20231222062207epcas5p4a5e0db868dd96cf4ed614a0283d11c7e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062207epcas5p4a5e0db868dd96cf4ed614a0283d11c7e
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062207epcas5p4a5e0db868dd96cf4ed614a0283d11c7e@epcas5p4.samsung.com>

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


