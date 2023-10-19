Return-Path: <linux-fsdevel+bounces-744-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EB17CF81F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 14:05:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CA4B21702
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154F9225AC;
	Thu, 19 Oct 2023 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VuWn14vd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16373225A0
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:52 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816DD1FD2
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 05:04:26 -0700 (PDT)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231019120415epoutp04d7ea9d656668b0f6ef5492b0c830fda3~PgKq9of2T1454514545epoutp04J
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 12:04:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231019120415epoutp04d7ea9d656668b0f6ef5492b0c830fda3~PgKq9of2T1454514545epoutp04J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1697717055;
	bh=9HUxsYJcUqY59rvCQaWh3ErxEvPd5vF6B6n+YdK8rBY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VuWn14vdXddRe36URDVj4i0DNuNMIqSTjC85mT2yajib/A6aKraBeWeT0rhXHQ614
	 WsS3RJsbFlhzFWhwWIyQXW9CI11nVTqTTSBcN4U5rh13R8Q2cQz3CfXmf5SksSqVAq
	 tNnKOiejoKjOSH/870vdMi8jtlAKIjK7DthkplyI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20231019120414epcas5p23f41604468125d167e09033622acfc14~PgKqfULOv0920309203epcas5p2W;
	Thu, 19 Oct 2023 12:04:14 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.176]) by
	epsnrtp2.localdomain (Postfix) with ESMTP id 4SB5ws2S8Kz4x9Pv; Thu, 19 Oct
	2023 12:04:13 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
	90.DB.19369.D3B11356; Thu, 19 Oct 2023 21:04:13 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231019110926epcas5p231dae80a47f8e25149460e538584dd79~PfazjyXC72430724307epcas5p2T;
	Thu, 19 Oct 2023 11:09:26 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20231019110926epsmtrp2c84cc332f14c1289496b1ed2a81fe73f~Pfazin6Le1629616296epsmtrp2k;
	Thu, 19 Oct 2023 11:09:26 +0000 (GMT)
X-AuditID: b6c32a50-9e1ff70000004ba9-05-65311b3d2012
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	B2.88.08817.56E01356; Thu, 19 Oct 2023 20:09:25 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20231019110920epsmtip1a379a6a69e0f9b25335feb170883121e~Pfau2L9Lp0452004520epsmtip1o;
	Thu, 19 Oct 2023 11:09:20 +0000 (GMT)
From: Nitesh Shetty <nj.shetty@samsung.com>
To: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>, Alasdair
	Kergon <agk@redhat.com>, Mike Snitzer <snitzer@kernel.org>,
	dm-devel@lists.linux.dev, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
	<hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni
	<kch@nvidia.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
	Brauner <brauner@kernel.org>
Cc: martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
	nitheshshetty@gmail.com, anuj1072538@gmail.com, gost.dev@samsung.com,
	mcgrof@kernel.org, Nitesh Shetty <nj.shetty@samsung.com>, Hannes Reinecke
	<hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v17 07/12] nvme: add copy offload support
Date: Thu, 19 Oct 2023 16:31:35 +0530
Message-Id: <20231019110147.31672-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20231019110147.31672-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTVxzOufdyWzAdV2DZESI2ncwAgbYC9aACSyDmDiXAli0bWYAG7oBR
	StcHOs0yHoMJyGNlbKPKYwXGeCgvh0VgMuQxIMwgCEJgm6MoWkB5ExFda2Hzv+/7fr/v9zo5
	bNymnGXPjpMqGblULOGRVkTLTedDbj4OQkagSeWg+oFeHC2tbREoNX8bR7XTeSQy3FwGSN/5
	NUBl2mICTXS2Yqhdq8ZQdW0PhmamVlio58UCidRdYwDN3tFgqGPSFf2YUUGg9o5+Ao1cv0Si
	0p9mWSh7XEeiqr7nGLqbPwuQTp8CUMtWKY6uGB4T6PdJB3Rru8/ibQe6VTPNom/92UjQI0Mq
	uqkmk6SbK76k55qLAN02kUzS5bkFFnRO2iJJL81OEvTjX++QdO7VGkA3D56jV5oc6Sb9AhZi
	HRZ/PJYRRzNyLiONSoyOk8b48E6+F+Ef4SUSCN2E3ugIjysVJzA+vIBTIW4n4iTGu/C4SWKJ
	yiiFiBUKHt/3uDxRpWS4sYkKpQ+PkUVLZJ4yd4U4QaGSxrhLGeVRoUBw2MuYGBkfO7/RDWSX
	Tp2p0q+ykkGVbxawZEPKE9Zc6CaygBXbhmoHMKO8nzSTZQCLVp9iZrIO4PMnPaxdy/ZaC24O
	dAD4rKHXwkzSMfjUkGO0sNkk5QoHX7BNuh2VjsMbU/PARHAqjYBjdbmkqZQt5Q23Wg2YCROU
	E9QYOnET5lBH4f3hOcJUCFJ8mPfXXpNsSR2DDdnanZS9sL9IT5gwTh2Aab9cfDkRpP6whJl9
	pmYmbwB88pBtntoWPuq7urOBPVxZ7CDN+DSs/vZn0uz9CkDNuAaYA34wfSAPN9XBKWdYf51v
	lvfDwoErmLnvazBnS4+ZdQ7UleziN2FdfdlO/X1wbCNlB9NwceHezrFzAdS1puD5gKt5ZR/N
	K/to/m9dBvAaYM/IFAkxTJSXTOgmZU7/985RiQlN4OVvcQnRgdqGbfcugLFBF4BsnGfHcaIF
	jA0nWvz5WUaeGCFXSRhFF/AyHvwb3P71qETjd5MqI4Se3gJPkUjk6e0hEvLe4BjSi6NtqBix
	kolnGBkj3/VhbEv7ZEy9vBLJ9fOfnfgh2CrTcdlDPDgd+vFA1ginh3vbdk9A+qawUhUmOVzx
	7B3sfI/C1yNI+352QXpd5UdRU1X+757JG6/1Ju45qWrtrCfUkyOVv01d2xPsPKzKCv+ipjAp
	lN926FoP4A/VvUWNuoUeCfYrKtYqRguQdePlB1792Z95PYworTobZCG537jPstg28m78xQ/2
	Z3R9om07uPaAfDSfmpnUET5Rqms8FnYwo3v6+09HxYEnZOdc9K5Dl2+PDaPeuX8uLFVaKzba
	w9f+DgyaXhGo15zXo+sOnJ8pmXKVidZzqBk7w3eTJSfdVmMdWzfHNiMlFhp1YKEooPrDUu4N
	fgWPUMSKhS64XCH+F4fjH0C2BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA03Sf0yMcRwHcN/neTz3XLo8XehbTea22KJLZL5IGOM70zRbDJsc97iOq85d
	KQzRFjK6heWOSH40ZdKldnU5dZQfLT/W0o9F2l3E1RV31aZdx10z/vt83p/X3n99GFJop4IZ
	eUoap0qRKES0D1X9TBQawflFcYueti9B5a+bSPRjZJxCpzUuEpV9zKOR7dlPgKz1ZwAqKi6k
	UGd9DYHqivMJdL+skUCWbgcPNboHaZRv/gBQX5uOQE+6FqBbOXcoVPfkFYVaa6/T6Oa9Ph46
	326gUcmLCQJ1aPoAMlhPAVQ9fpNED21DFHrZFYLeul5MXROCa3QfefjtpwoKt7akY33pORpX
	3jmJ+yu1ABs7s2h8++KlqfhCtp3GP/q6KDxkaqPxxcelAFc2H8MOfSjWWweJ+Ok7fWKknEJ+
	mFNFxu7xSRoYew6U1zdnllidvCxQEpsL+Axko6FrpJrMBT6MkDUC+GWwC0weguA913Nycg6A
	9ye+8iZRNgFt7iEiFzAMzS6AzW7Gk89g80hodxUQnoVkL1GwoveNtymAXQ7Ha2yEZ6bYMKiz
	1XtbBewK+OV9P+UpgmwkzOvx98R8diV8dL7YS4R/yOciC2+S+8NXWquXk+x8WH5D6IlJdg7M
	rrpGaoC/7j+l+6d0/6kiQJaCIE6pTpYlq6OUi1O4DLFakqxOT5GJ96Um64H3JcLDDaCudFhs
	BgQDzAAypGiGIAwv4oQCqeTIUU6VmqhKV3BqMwhhKFGgYNR2QSpkZZI07iDHKTnV3yvB8IOz
	iMdjDf7oan6E7rv4V22caP2OhJOrVvWMptltIxrpbXpcHuge6xjINMRkdhRYcxrOTLSYHG36
	NGmZMWyLONZi2pZ4aFrxQTvmF+ZlzPrUPXdZgyEnzri08YPINj9+tEEWg58eNUcEEEvaVpT4
	7tdpfQvloU2bD6n6E7Vlm3ZuyDR9O9vb3LnJLTKtPe5nypBcDn436jiVMOwSOALjW7YH7fs1
	ciV+Hb+d1mfdrdoY53xQ90g45UBVgrGpvMIJa/1mauNm/6zeM8+5N6mVNKwbrqiUR/N65ygs
	Mo1zYJkiNDrSdyAqJ4bZFT7c0tSz+2v71u6z274vrJEpZ6WesK62iCh1kiQqnFSpJb8BxYAz
	iIEDAAA=
X-CMS-MailID: 20231019110926epcas5p231dae80a47f8e25149460e538584dd79
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231019110926epcas5p231dae80a47f8e25149460e538584dd79
References: <20231019110147.31672-1-nj.shetty@samsung.com>
	<CGME20231019110926epcas5p231dae80a47f8e25149460e538584dd79@epcas5p2.samsung.com>

Current design only supports single source range.
We receive a request with REQ_OP_COPY_SRC.
Parse this request which consists of src(1st) and dst(2nd) bios.
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
index 21783aa2ee8e..4522c702610b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -763,6 +763,63 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy_offload(struct nvme_ns *ns,
+						   struct request *req,
+						   struct nvme_command *cmnd)
+{
+	struct nvme_copy_range *range = NULL;
+	struct bio *bio;
+	u64 dst_lba = 0, src_lba, n_lba;
+	u16 nr_range = 1, control = 0, seg = 1;
+
+	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
+		return BLK_STS_IOERR;
+
+	/*
+	 * First bio contains information about source and last bio contains
+	 * information about destination.
+	 */
+	__rq_for_each_bio(bio, req) {
+		if (seg == blk_rq_nr_phys_segments(req)) {
+			dst_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			if (n_lba != bio->bi_iter.bi_size >> ns->lba_shift)
+				return BLK_STS_IOERR;
+		} else {
+			src_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
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
@@ -1005,6 +1062,11 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
 		break;
+	case REQ_OP_COPY_SRC:
+		ret = nvme_setup_copy_offload(ns, req, cmd);
+		break;
+	case REQ_OP_COPY_DST:
+		return BLK_STS_IOERR;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
@@ -1745,6 +1807,21 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1944,6 +2021,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -4654,6 +4732,7 @@ static inline void _nvme_check_size(void)
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
index e0a832a1c3a7..ce2009b693c8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1226,6 +1226,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 
 /* maximum copy offload length, this is set to 128MB based on current testing */
 #define BLK_COPY_MAX_BYTES		(1 << 27)
+#define BLK_COPY_MAX_SEGMENTS		2
 
 static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26dd3f859d9d..7744538c4ca4 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -337,7 +337,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -365,6 +365,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -414,7 +415,10 @@ struct nvme_id_ns {
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
@@ -831,6 +835,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -854,7 +859,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -1031,6 +1037,36 @@ struct nvme_dsm_range {
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
@@ -1792,6 +1828,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.35.1.500.gb896f729e2


