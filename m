Return-Path: <linux-fsdevel+bounces-19791-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 305618C9C79
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D251F228DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 744C174435;
	Mon, 20 May 2024 11:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="RNIegZEI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB84174429
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205521; cv=none; b=SKO7dSIITp5DAjBX47Ockppk3emmxdqotvVLvBIuo13/+BZV68T/c+fU0kwKliR+lMVXAoBAAvBa/e9wBxtxVBFCH4i9kQvoskYIcpnxGUiS2ndTIhcQQyhv9oWdDqTN3iGOQiHeYt6uxolDbyrMAugUzbwmjEiqE4dvPl8vT3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205521; c=relaxed/simple;
	bh=t2a79m2cBKYe7ckC30tK8h2A2PYq9LqU0AmskqnjpnY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:Content-Type:
	 References; b=UXA2DQN/AA+tAQEqxZQLRgKV0r37UAmhQ8si3DSBPnJm/RdbGiQoQXJLjcqgCJILUiRkBJE/SLdoCnpx/7f0kAklpHkdT/pMMGygJwbyCZATK46nZBqvqERXyeh0pZxFHEy9xN2CSy6sdnptL+GoEL3KLoY6TUuXiEH+LmU2ryA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=RNIegZEI; arc=none smtp.client-ip=203.254.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20240520114517epoutp04016fb4b4bacee29917e1705f06e6a2bf~RL9NH840c2430524305epoutp04V
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:17 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20240520114517epoutp04016fb4b4bacee29917e1705f06e6a2bf~RL9NH840c2430524305epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205517;
	bh=Mcb2IBWLoPjGcsDETrvIJf7i7Jctj2/f3RwhTuyWe0c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RNIegZEIDx4uC0K8syJwoZGloBs/VkI7BW6GKGpQ1NbQ9AvW6N2U8beZ0BREaPorY
	 Inaxid+pkuv/9PNvtbkwBxh97ZfNTbcbQPgo3dqmPCOSvKu4o9zm6Z4VZz1fAvICiN
	 Fmjsd/lcGYBNGcpjxqkUcsAut6ljA77QLY/YmM6c=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTP id
	20240520114516epcas5p32f3cc7423f12163798604815ec0b0b8b~RL9Mk1FXB0631306313epcas5p39;
	Mon, 20 May 2024 11:45:16 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VjbNC3zNnz4x9Q1; Mon, 20 May
	2024 11:45:15 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
	epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EB.2D.09666.BC73B466; Mon, 20 May 2024 20:45:15 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
	20240520102952epcas5p18716d203d1810c38397e7fcc9a26922a~RK7XIxgM10053100531epcas5p1j;
	Mon, 20 May 2024 10:29:52 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520102952epsmtrp152974acae286b3bea846aa78500e713e~RK7XHeFoA2103421034epsmtrp1F;
	Mon, 20 May 2024 10:29:52 +0000 (GMT)
X-AuditID: b6c32a49-f53fa700000025c2-fe-664b37cbe5c4
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	EE.08.08390.0262B466; Mon, 20 May 2024 19:29:52 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102948epsmtip2b62fa5b9c2a0bb655ad341d83b0431dd~RK7TX7MfH2248422484epsmtip2y;
	Mon, 20 May 2024 10:29:48 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka
	<mpatocka@redhat.com>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>
Cc: martin.petersen@oracle.com, bvanassche@acm.org, david@fromorbit.com,
	hare@suse.de, damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
	joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com, Nitesh
	Shetty <nj.shetty@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 08/12] nvmet: add copy command support for bdev and file
 ns
Date: Mon, 20 May 2024 15:50:21 +0530
Message-Id: <20240520102033.9361-9-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WTe1BUdRTH+927e1nIhSvI9ONhwVpTgOCu8fhBkoUOXoemQbCY6Q9phSsQ
	u3e3XR5GjvIQeTg8S4jlvWgmmzwXBBFZQKB4xBRvAmQEJpOAdamgCIllsf77fM/vfM85c35z
	OLj5BmHNiWCiaBkjFPEIE1Zjp4Ojc5+H3zn+er8Nqu7txlFi9iaOVNNZBFrs1AGUp/0LR/Oa
	FIA2BgZxpO6eAahMWcxCE5pmDN1T5mLolqoLQ4X5SRjq2loiUG7HKEALIwoMtU46ofIr11no
	Xuv3LDR0t4hApV8vGKGbPc8wlJM6gqGm+QSAGjdKcVS1uMJC303aoMHNHvY7ttTQsB/Vq4RU
	s2LaiBqcqWVRQwPRVF1lGkHVX79EPa4vAFTLRDxBVWR+waYykpYJqjn5IZt6ujDJolbujxBU
	proSUP1lD4z8LT6KPBJOC0NpmR3NhEhCI5gwb55fYPCxYDd3vsBZ4Ik8eHaMUEx7846/5+/s
	GyHa3hDPLkYoit4O+Qvlct6ht4/IJNFRtF24RB7lzaOloSKpq9RFLhTLo5kwF4aO8hLw+Yfd
	thM/jgwf3lrDpeMnzq+rRkE8aHkrHRhzIOkKdakz7HRgwjEnWwD8p/E+bhA6APvU60YG8SeA
	V2bntgVnx5LfedoQbwVQVf7brj0ZgwMjW0CfRJBOsG+Lo4/vI1U4vFqfw9ILnKzHYUKnBtM3
	tyBPwZLlHwg9s8jXYGX6ZZaeuaQnfNZUyjYM+ApU1WhwPRuTXlDToAX6QpBUGcO18lXMkHQc
	pv+UuWuwgE961EYGtoa/Zl3Z5Vh468tvCIP5MoCKMQUwPByFyb1ZuH5snHSA1XcPGcL74bXe
	qp36OGkKMzbmd3txYVPJcz4Av60uIwxsBUfXEnaZgimP2tj6kuZkBoBTIdngZcX/DcoAqARW
	tFQuDqPlblIBQ8f+92shEnEd2LkCx5NNYHpW69IBMA7oAJCD8/Zx69Qnz5lzQ4WfxdEySbAs
	WkTLO4Db9v5ycGvLEMn2GTFRwQJXT76ru7u7q+eb7gLeS9zF5OJQczJMGEVH0rSUlj33YRxj
	63iMef3MRMXE+3tFDnKT2gcBGUvXVD6WsjzrBB/PHz20eIOLvTJw/AOg/CPxRlVSe3tB0NED
	9qkBF8KHg87WSMVTpsV/Gz+6c+bUxlIprt1/evJJz+/dpqTtrC5w1nZMdpGY+tlxb0MF8i20
	cPj085tOt098xe996nPwFybMjbmg3rzzyeO0Vdke3UBKpde0VvbGXJaS/65P4ZBvnstDxUFN
	S1/J7Wx/yxi6Y63/hlkCNzF8I/t8ROS639yLVodr0mKVK/iYbYfZ1dXqV1+4aMU2O/Zh3CXn
	xi7LtgD7riSxPGbQrCiCtkktyIhjj48EtZ1NrV3O1frXt+cXOXo37hGl60QcHkseLhQ44jK5
	8F9ogvJnjgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAAzWRa0hTYRzGe885Ox4ni8Mm+Walue6K2sQPb5ZlRXrCoEIpiEKXHk1yaltq
	RhdtXRfaMlBSS5tmObNSl21typza1sWsvJSmBqXM0Lx3MXHWrL79+P2fh+fDn8L5lYQrFZdw
	lJUmiOOFJJeoaRC6ey9dGRqztjdjOXrw/CmOzihncFTec4VEgw3jAOWMTuGoz3gBoOnmFhxp
	nvYCVKS6QaBOow5DBlU2hsrKmzCUnyvHUNPsVxJlmzoA6m/Pw1Btlxe6db6EQIbaZwRqfVJA
	osLSfgd0x2zD0NWL7RjS9mUAVDNdiKP7gyMEsnQtQi0zZk7QYqa1LZR5roKMLq/HgWnprSSY
	1uZkpkp9iWSqS04zA9XXAaPvTCeZ4qxrHCZTPkwyunMfOcxYfxfBjNS1k0yWRg2Yl0WNDrsE
	+7gbotn4uBRW6rsxknuobfYHnvQ+5NjP8g6QDvTrFYCiIO0PcxvCFYBL8Wk9gLe1Bo4COP7x
	C2HpTCP+lwWwzGZ1+BuSY1Bu0XDsZZL2gi9mKbt3ph/jcEx+GbMXcLoJh6/vITsL6J1w6lXd
	nCfoFVCtOEvYmUevgzZt4b8xd1j+0Dg35kgHQOOjUWBn/p9Mz7tRUgnmF4F5arCQTZJJYiUy
	UZJfApvqIxNLZMkJsT5RiZIqMPdVT08tMKhHfUwAo4AJQAoXOvOqNNtj+LxocdpxVpoYIU2O
	Z2UmsIgihC6874OZ0Xw6VnyUPcyySaz0/xWjHF3TsYqTfn7e1t0ZBokmc+O2NamRHVFXB+on
	Z5YoAypC6z99cVe6Bntd8v4VxT+t8unecd514vCzLb1uTgFh+RPRmbO6BYtbd1TtaeaXUQey
	7xaMYCIPs0biWPdm3tcpgUe3OPhNV9ve8dc3fC2/Tui0w4FXehqDAicfFWQt2e+fb/UIq+9+
	XyzqzPsxNLnbxfxt4GZIrKVQ4RSUETGU4tZm/bAyuA6vlhgnL37yn6j0srwtKuMeMU3jr7rN
	p2SJOdP6arf7LmlC/X6R52bxMt5nv7i7OXC1wlmxtdmpIqU2ZJPAVvxNFTJ1iz44sWrdNYzl
	eWyKSFWl5T20KUOtNeGsb4SQkB0SizxxqUz8G/MofhNEAwAA
X-CMS-MailID: 20240520102952epcas5p18716d203d1810c38397e7fcc9a26922a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102952epcas5p18716d203d1810c38397e7fcc9a26922a
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102952epcas5p18716d203d1810c38397e7fcc9a26922a@epcas5p1.samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>

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
index f5b7054a4a05..59021552084f 100644
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
index 6426aac2634a..4c2c1784fec9 100644
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
index 2f22b07eab29..480e4ffa01fd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -406,6 +406,7 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	size_t			copy_len;
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
diff --git a/drivers/nvme/target/trace.c b/drivers/nvme/target/trace.c
index 8d1806a82887..8be6f77ebfd8 100644
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
@@ -195,6 +212,8 @@ const char *nvmet_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvmet_trace_zone_mgmt_send(p, cdw10);
 	case nvme_cmd_zone_mgmt_recv:
 		return nvmet_trace_zone_mgmt_recv(p, cdw10);
+	case nvme_cmd_copy:
+		return nvmet_trace_copy(p, cdw10);
 	default:
 		return nvmet_trace_common(p, cdw10);
 	}
-- 
2.17.1


