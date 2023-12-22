Return-Path: <linux-fsdevel+bounces-6777-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0816281C5BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 08:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701001F26105
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Dec 2023 07:35:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3274F12E4B;
	Fri, 22 Dec 2023 07:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="HQdnt7LE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD9CF9F2
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231222073236epoutp03b82982c9bb375ddb2c4e1243d0f03eaf~jFvxCIhlT3151231512epoutp03C
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Dec 2023 07:32:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231222073236epoutp03b82982c9bb375ddb2c4e1243d0f03eaf~jFvxCIhlT3151231512epoutp03C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1703230356;
	bh=p/9yh3tUv4Curw5H7Y3DMkbb1qxhGWe31pfXNHDD36M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQdnt7LExveo9gWi23t+Xe5XS+IlQxTZ+0nVye9NYm32s2ajX3fTa2m17YiEX9OOs
	 crcsUz5U3MaFCqy4lWL+CpOGotPPSE9qDZ3kwNDKeAH1jRHiYbNrMyq0HHMDG22Q4K
	 xDt+pJvJhlhzDFOmv/8ReXsqH+nzWd4h1r+dpHJE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231222073235epcas5p29cfc218b2f42d06223c8e55091a2b289~jFvvzs2Qz2132821328epcas5p2w;
	Fri, 22 Dec 2023 07:32:35 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp4.localdomain (Postfix) with ESMTP id 4SxJst1H3Zz4x9Px; Fri, 22 Dec
	2023 07:32:34 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	6E.47.10009.19B35856; Fri, 22 Dec 2023 16:32:34 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
	20231222062157epcas5p35537549a1610815931e43618e045f3ff~jEyE_mD8h0194101941epcas5p3I;
	Fri, 22 Dec 2023 06:21:57 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231222062157epsmtrp106db83d3fe8e2b7e66b731d8cdac586c~jEyE9HsE41657416574epsmtrp1C;
	Fri, 22 Dec 2023 06:21:57 +0000 (GMT)
X-AuditID: b6c32a4a-ff1ff70000002719-3e-65853b91625e
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	0B.C8.08817.50B25856; Fri, 22 Dec 2023 15:21:57 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231222062153epsmtip2458d39b115507ab8971489f478b6b9ab~jEyBP8YTh0362603626epsmtip2S;
	Fri, 22 Dec 2023 06:21:53 +0000 (GMT)
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
	<hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v19 07/12] nvme: add copy offload support
Date: Fri, 22 Dec 2023 11:43:01 +0530
Message-Id: <20231222061313.12260-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231222061313.12260-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1ATVxTu3d1sAjW6RqsXRGViW6oIJBrojQh1xNZtYRg6Hdsp0ykNZAUE
	kjQPseIUkIcahrcohKIIaUVAUaCUp5WXUaBSyxAaKiA1VBGpAlVnQKSEQOu/75zvfPd859w5
	HJz3PdueEy5TM0qZJJJP2hI1rZudXLI8kxjBT+MYqui4jqOJpzMEOpoxi6OygXQSjbVOAmS+
	dgygwqICApmu1WGosSgLQxfK2jF0784UG7XPjZMoq8UI0EivDkNN/c7oXLKeQI1NNwnUU/8d
	ic7+MMJGKX21JDpveImh3zNGAMo83ouhWnM8QDUzZ3F0aewxgW70r0PdswbWLge6TjfAprsH
	rxB0zy8aurL0BElX6WPpB1V5gG4wxZF0cVo2i05N+JukJ0b6Cfrx1V6STqsuBXRVZww9VbmB
	rjSPYwErAiN2hjESKaN0ZGQhcmm4LNSL7/tJkE+Qu4dA6CIUo3f5jjJJFOPF3+MX4PJBeOT8
	cviOByWRmvlUgESl4rt571TKNWrGMUyuUnvxGYU0UiFSuKokUSqNLNRVxqh3CAWCbe7zhV9F
	hL34Q6HQ+x1qLvyVHQfKvLXAhgMpEWyMP0FqgS2HRzUA+PPJM4Q1mARwurkGWINnAP6VocWW
	JG2Xn+BWognAjOpjuIXgUUkYLNb7aAGHQ1LOsHOOY0mvpspxWHdFaKnHqQQCGsvTSAuxihJD
	w62BBS1BvQXTU41sC+ZSO2D2aDFueQdSbjB9aKUlbUN5wvvTxSxryUp4M89MWDBObYQJP+Yv
	+IHUnzYwZXKCZTW6BxqH2hdNr4IPDdVsK7aHo+nJizgaXjhZQlrFiQDq+nTASrwHkzrSF0zg
	1GZYUe9mTa+HOR2XMGvj5TB1xrz4PhfWnlnCm2B5RSFpxXbQ+Dx+EdMwM/vW4uLSAMwtbmNl
	AEfdKwPpXhlI93/rQoCXAjtGoYoKZVTuim0yJvq/Tw6RR1WChXvZ8lEtGL77xLUFYBzQAiAH
	56/myrcmMjyuVPLNYUYpD1JqIhlVC3CfX3gmbv9GiHz+4GTqIKFILBB5eHiIxNs9hPy13LGk
	AimPCpWomQiGUTDKJR3GsbGPw/j1H4ovm6JZdmtsrmKkfYzA6TR+b0N3UFfb7nq/1unWKaJf
	k0jldx499WY6yCto/ScO866U+sYErGHdHqwsanoh/IxllG48HPgof9mc3fCA7WmCt89ptC/O
	MDfGEhvc9pdvv45zk7VPDWK7+3NGg++NlNeeK3O7Hj461KB6J/DrvS7HA32+PRA2FBBwfm25
	VrMibO8XrX5J8bni25+KTcMJ76OufQZTbOxF598+PgJz1p9rTxuc7XY125fEu6f6B+t7HzTz
	3z7yzMQ98LmPQ8+wCMsNrnJ4/a5/tlBfS7w0xBtzlvtH681RdM1+w8Xy3Zs8Sw6uW6YWuPXp
	TwV/eWeriE+owiTCLbhSJfkX4kWDbrgEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SaUxTaRSG/e693N6ixEtB58OimEbjpCBLY+KnA0ajwvcDUUP8Q9SxkcsS
	aekCjMuYYWBEQdkEo9QFkIpCI0irWGQRy1IWBR2HqmgxYhuGIFZgXBgGGQsx+u897/ucN+fH
	YUjBOLWEiZcncSq5NEFEu1K1LSKf1S6+x7jA0brFqLqrnURj76colJY3TSKdNZdGIy3jANma
	jwNUcvkihZ411xGo4fJpAlXo2gj0+sUED7XNjNLotMkCkL1PQ6DGfl9UmqGlUENjJ4Ue37lA
	o+JyOw+dfGKk0VXzZwI9zbMDlH+ij0BG2+8A1U4Vk6hqxEGhjn4h6p02u2z0xnUaKw/3DtRQ
	+PGDZKyvzKSxQfsb/ttQBHD9s1Qal+UUuODs9Lc0HrP3U9jR1EfjnJuVABu6j+AJ/TKst40S
	OxZGuQZHcwnxKZwqYMM+17j/nisU2vCD90oe8lKBbkMW4DOQXQNbb7wjs4ArI2DrASwfL3SZ
	C7xg+XQrOac9YMXnId4clE7A0nErkQUYhmZ9YfcM4/Q9WSMJJ6+nE86BZAsoWPOqBzi3Pdh1
	0NxjnW2i2JUwN9vCc2o3dj0sGC4jnUWQDYC5L92dNp/9CQ79WzZ7hOAL0jlkoOdwd9hZZKOc
	OMmugtWXBE6bZH1g+q3zZB5w13xHab5Rmu+oEkBWAi9OoZbFytRBComc+8VfLZWpk+Wx/vsT
	ZXow+xZisRE0VL7zNwGCASYAGVLk6Zbo9wcncIuWHjrMqRJ/ViUncGoTEDKU6Ae3DyPZ0QI2
	VprEHeA4Baf6mhIMf0kq8Wj9LlVgPeZ0mXfFZYNocGXI+TBD1YdbZmVxdO7GiJq0hm1/ja5b
	YZl4IIypiJneHXJiZjhJ+7RFNHzbGowk3jvqVj/Z2h4YNnbUUbj/rU/VgIQLixx7c+6jNvJ+
	kGgo6EW/dP68tB6PwuBLMXrvw/8U+U1cWLTXb1ISSloy3nyyyemmxIH8nZu9WiLMm67saTyl
	XGaK1DaLzy6vrb62NkZ5o0v+pw4re/ndwqmcQR+6sT0zqtNuTskQLpwXukVktJR2hUsiGGVr
	YdcCaa2KqXB0UBd74o83OTK3a/Kj1mr8kkPXOMKLNleF5PB/fe8gtknalva1yn48k9L2HBVP
	iih1nDRITKrU0v8B4p9TkYUDAAA=
X-CMS-MailID: 20231222062157epcas5p35537549a1610815931e43618e045f3ff
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231222062157epcas5p35537549a1610815931e43618e045f3ff
References: <20231222061313.12260-1-nj.shetty@samsung.com>
	<CGME20231222062157epcas5p35537549a1610815931e43618e045f3ff@epcas5p3.samsung.com>

Current design only supports single source range.
We receive a request with REQ_OP_COPY_DST.
Parse this request which consists of dst(1st) and src(2nd) bios.
Form a copy command (TP 4065)

trace event support for nvme_copy_cmd.
Set the device copy limits to queue limits.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/constants.c |  1 +
 drivers/nvme/host/core.c      | 79 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.c     | 19 +++++++++
 include/linux/blkdev.h        |  1 +
 include/linux/nvme.h          | 43 +++++++++++++++++--
 5 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 20f46c230885..2f504a2b1fe8 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -19,6 +19,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_report] = "Reservation Report",
 	[nvme_cmd_resv_acquire] = "Reservation Acquire",
 	[nvme_cmd_resv_release] = "Reservation Release",
+	[nvme_cmd_copy] = "Copy Offload",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
 	[nvme_cmd_zone_append] = "Zone Append",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8ebdfd623e0f..c398546e4edc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -765,6 +765,63 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy_offload(struct nvme_ns *ns,
+						   struct request *req,
+						   struct nvme_command *cmnd)
+{
+	struct nvme_copy_range *range = NULL;
+	struct bio *bio;
+	u64 dst_lba = 0, src_lba = 0, n_lba = 0;
+	u16 nr_range = 1, control = 0, seg = 1;
+
+	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
+		return BLK_STS_IOERR;
+
+	/*
+	 * First bio contains information about destination and last bio
+	 * contains information about source.
+	 */
+	__rq_for_each_bio(bio, req) {
+		if (seg == blk_rq_nr_phys_segments(req)) {
+			src_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			if (n_lba != bio->bi_iter.bi_size >> ns->lba_shift)
+				return BLK_STS_IOERR;
+		} else {
+			dst_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			n_lba = bio->bi_iter.bi_size >> ns->lba_shift;
+		}
+		seg++;
+	}
+
+	if (req->cmd_flags & REQ_FUA)
+		control |= NVME_RW_FUA;
+
+	if (req->cmd_flags & REQ_FAILFAST_DEV)
+		control |= NVME_RW_LR;
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->copy.opcode = nvme_cmd_copy;
+	cmnd->copy.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->copy.control = cpu_to_le16(control);
+	cmnd->copy.sdlba = cpu_to_le64(dst_lba);
+	cmnd->copy.nr_range = 0;
+
+	range = kmalloc_array(nr_range, sizeof(*range),
+			      GFP_ATOMIC | __GFP_NOWARN);
+	if (!range)
+		return BLK_STS_RESOURCE;
+
+	range[0].slba = cpu_to_le64(src_lba);
+	range[0].nlb = cpu_to_le16(n_lba - 1);
+
+	req->special_vec.bv_page = virt_to_page(range);
+	req->special_vec.bv_offset = offset_in_page(range);
+	req->special_vec.bv_len = sizeof(*range) * nr_range;
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -1007,6 +1064,11 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
 		break;
+	case REQ_OP_COPY_DST:
+		ret = nvme_setup_copy_offload(ns, req, cmd);
+		break;
+	case REQ_OP_COPY_SRC:
+		return BLK_STS_IOERR;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
@@ -1758,6 +1820,21 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
+		struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *q = disk->queue;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
+		blk_queue_max_copy_hw_sectors(q, 0);
+		return;
+	}
+
+	blk_queue_max_copy_hw_sectors(q, nvme_lba_to_sect(ns,
+				      le16_to_cpu(id->mssrl)));
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -1961,6 +2038,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -4708,6 +4786,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 1c36fcedea20..82c6aef77c31 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -150,6 +150,23 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_copy(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 sdlba = get_unaligned_le64(cdw10);
+	u8 nr_range = get_unaligned_le16(cdw10 + 8);
+	u16 control = get_unaligned_le16(cdw10 + 10);
+	u32 dsmgmt = get_unaligned_le32(cdw10 + 12);
+	u32 reftag = get_unaligned_le32(cdw10 + 16);
+
+	trace_seq_printf(p,
+		"sdlba=%llu, nr_range=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+		sdlba, nr_range, control, dsmgmt, reftag);
+	trace_seq_putc(p, 0);
+
+	return ret;
+}
+
 static const char *nvme_trace_dsm(struct trace_seq *p, u8 *cdw10)
 {
 	const char *ret = trace_seq_buffer_ptr(p);
@@ -243,6 +260,8 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_zone_mgmt_send(p, cdw10);
 	case nvme_cmd_zone_mgmt_recv:
 		return nvme_trace_zone_mgmt_recv(p, cdw10);
+	case nvme_cmd_copy:
+		return nvme_trace_copy(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 80867c9fd602..24016fbcd409 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1226,6 +1226,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 
 /* maximum copy offload length, this is set to 128MB based on current testing */
 #define BLK_COPY_MAX_BYTES		(1 << 27)
+#define BLK_COPY_MAX_SEGMENTS		2
 
 static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 44325c068b6a..4afd2cd1a629 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -344,7 +344,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -372,6 +372,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -421,7 +422,10 @@ struct nvme_id_ns {
 	__le16			npdg;
 	__le16			npda;
 	__le16			nows;
-	__u8			rsvd74[18];
+	__le16			mssrl;
+	__le32			mcl;
+	__u8			msrc;
+	__u8			rsvd91[11];
 	__le32			anagrpid;
 	__u8			rsvd96[3];
 	__u8			nsattr;
@@ -838,6 +842,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -861,7 +866,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -1038,6 +1044,36 @@ struct nvme_dsm_range {
 	__le64			slba;
 };
 
+struct nvme_copy_command {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2;
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le64			sdlba;
+	__u8			nr_range;
+	__u8			rsvd12;
+	__le16			control;
+	__le16			rsvd13;
+	__le16			dspec;
+	__le32			ilbrt;
+	__le16			lbat;
+	__le16			lbatm;
+};
+
+struct nvme_copy_range {
+	__le64			rsvd0;
+	__le64			slba;
+	__le16			nlb;
+	__le16			rsvd18;
+	__le32			rsvd20;
+	__le32			eilbrt;
+	__le16			elbat;
+	__le16			elbatm;
+};
+
 struct nvme_write_zeroes_cmd {
 	__u8			opcode;
 	__u8			flags;
@@ -1802,6 +1838,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.35.1.500.gb896f729e2


