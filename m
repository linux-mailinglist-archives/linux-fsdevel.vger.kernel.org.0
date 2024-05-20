Return-Path: <linux-fsdevel+bounces-19790-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 876AC8C9C74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 13:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA2531C21F1E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2024 11:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D638255E74;
	Mon, 20 May 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="a9+LN0ba"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4448973199
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.254.224.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716205516; cv=none; b=FVKzWv27H8xeJ1QHx6Z4U9QN9a5yBuF1+oqZTbof8jfNE8sCBK8+WQ9UtN/lqvW2u+oSAD6aHUxnWNIKKqsgHP6PFQTS4BTsx/J1TXCuKBQP7WRy5wguMY+J9l5+jwk0zf+B2au/Vjw1zYtEKlEeuvXJlF7n54OvH+xmn+718YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716205516; c=relaxed/simple;
	bh=zbdY5tHhklQFu9SYQEcT9ClPqLcCjca9x8/uc+/Cb44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:MIME-Version:
	 Content-Type:References; b=WxdePxiYI968N/USqe7WxI5r62kqzcZVw38e/aoWoTurb5UcyZnVRb/5vC1OX0J9AQ5+K1uU0R0VneHRGKTrMoIgmSh0tuISe11uCdKpL526Fd48m+9tcN22FBOr9z9eQVhqmUYXpN7vjBCPNMHI4mLpDmdpAkIDCPWFZquxPbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=a9+LN0ba; arc=none smtp.client-ip=203.254.224.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20240520114512epoutp02e8e085be3cf678fe51fab44a674a53d4~RL9IOD1Of1003610036epoutp02_
	for <linux-fsdevel@vger.kernel.org>; Mon, 20 May 2024 11:45:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20240520114512epoutp02e8e085be3cf678fe51fab44a674a53d4~RL9IOD1Of1003610036epoutp02_
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1716205512;
	bh=UmOrteyCtGQQIJEluJXtswKB0vgH3ahj62ckBz59El4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a9+LN0baY/ri82hR+zhLMzjX49of98wRHdDkBMY8mQhuTYgBcMvczhPgcTv1wT5Jm
	 Il6pApyJ6tooctWR3yW6xJz8sRRcX9B5jSQlYdOzi9upplyMqoyJT5gQf00TbFr2oe
	 69aqQ7lZ02z3OBQtp1Nv5jsqWveVZjx4VUR2Ni4U=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20240520114511epcas5p2d4891faf656d4cb96755fcae21b857e3~RL9HoqAXU2455024550epcas5p2d;
	Mon, 20 May 2024 11:45:11 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.180]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4VjbN63Tn8z4x9Pt; Mon, 20 May
	2024 11:45:10 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	1D.E9.09665.6C73B466; Mon, 20 May 2024 20:45:10 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7~RK7L_xfHU0987709877epcas5p2p;
	Mon, 20 May 2024 10:29:40 +0000 (GMT)
Received: from epsmgmcp1.samsung.com (unknown [182.195.42.82]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20240520102940epsmtrp1fa8f72a8e159b4bf0fd8e9abb46225c8~RK7L9y_hp2026620266epsmtrp1d;
	Mon, 20 May 2024 10:29:40 +0000 (GMT)
X-AuditID: b6c32a4b-829fa700000025c1-08-664b37c6c0cd
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgmcp1.samsung.com (Symantec Messaging Gateway) with SMTP id
	6A.07.19234.4162B466; Mon, 20 May 2024 19:29:40 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
	[107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20240520102936epsmtip2263bba809d8095e622cf6fc493b8814e~RK7IMFrVF2247422474epsmtip26;
	Mon, 20 May 2024 10:29:36 +0000 (GMT)
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
	Shetty <nj.shetty@samsung.com>, =?UTF-8?q?Javier=20Gonz=C3=A1lez?=
	<javier.gonz@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v20 07/12] nvme: add copy offload support
Date: Mon, 20 May 2024 15:50:20 +0530
Message-Id: <20240520102033.9361-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240520102033.9361-1-nj.shetty@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xTdxjd797LbWErq0XxJ8aNlWwoBKTK48dLnWPkOhbCZrJkLlvp6BUY
	pW3aIqhZRGgBcTydI5QJFRCUjoe8xhuCvESBCcIGAjpekyLCZMtmEFhLi/O/852ck5PzffmY
	OKeSYcMMFytomVgg4pIWRO2tfXudujwCTrrkdlih8t4uHMWlr+FIO5FGooVbzwD6Yfk5jmba
	EgFa7RvAUXXXJECa/CsEGm2rx1BTfiaGbmg7MZSTFY+h6fEVBurcWCRRZvsIQLPDagw1jzmi
	qwmFBGpqvk2goYYfSZRXNMtAxd3rGMpIGsZQ3cx5gGpX83BUtrBEoJ6x3WhgrdvsyB5q6H4A
	1ZsPqXr1BIMamLxJUEN9UVRlyQWSqio8Rz2uygZU42gsSRWkXjKjUuKfklS96qEZ9efsGEEt
	tQyTVGp1CaDuajoYQVYnInzCaIGQltnS4hCJMFwc6ssNOM7/gO/m7sJz4nkiD66tWBBJ+3L9
	Pg5y8g8X6dfEtT0lEEXpqSCBXM7df8hHJolS0LZhErnCl0tLhSKpq9RZLoiUR4lDncW0wovn
	4nLATS8Mjgh7PNcHpOOBMe2l9UQsSDqSDMyZkO0KX/ytJZOBBZPDbgTwctwMZhyeAdg5nmX2
	cogdTQdbFk1xh5kBc9j1ACpHnYwiFQZLH/XjyYDJJNmO8M4G08BvZ2txeLEqgzAMOHsFh/0P
	Hm66rdiecC67BDdggv0uXLw5u5nA0vOauN9JY9rbUFvRtqkxZ3vBtpplk2YbvJ09QxgwrtfE
	1+TghgDInjOHTeuzDKPZD/aUFuBGbAV13dUm3gbOpyWYcDS88f110mhWAqj+VW3qeRiqetM2
	6+DsfbC8Yb+R3gMv95ZhxmBLmLI6gxl5FqzL3cJ28KdyjanALjjyz3kTpqBW2QmM60oB8O76
	d0Q6sFW/Ukj9SiH1/9EagJeAXbRUHhlKy92kB8V09Ms7h0giK8Hm8zgE1IGpR8vO7QBjgnYA
	mTh3O6uy+thJDksoOH2Glkn4sigRLW8HbvqNZ+A2O0Ik+u8TK/g8V08XV3d3d1fPg+487k7W
	guqKkMMOFSjoCJqW0rItH8Y0t4nFMg4rszIDClpf35bYItJZEv9e/WxaZ/mJKNghq/Qv6YN5
	VV/eabDTLvvMga+WKnL6p775emJe3VB6kcii7GMS1ppTP38r79OzpE/F1B/Buh2rbkTkE3uH
	5LkinwbNRKz/XA7nNR4W4aTzslvoDPwFOb4TcWltsKb420Tq3CLrvVMtY7XZX6gHZGXRUSte
	gYW5+EZP45tP5semjw4cH96Qvr9SsFvosbzmzT974SN+ebhnbpFFzF5f/zfiGhZajw57nYCH
	7nz5gvYeFFuPTAYKwnXOjd5PHQd/vn/tmPLetQ+Tkp5ft5a22f3W+kwyqLK2t87pDuxNs/S6
	Vx7P9FNqCWdzpZBLyMMEPAdcJhf8B28CVN3FBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCSvK6ImneawcqNGhbrTx1jtmia8JfZ
	YvXdfjaL14c/MVpM+/CT2eLJgXZGi99nzzNbbDl2j9FiwaK5LBY3D+xkstizaBKTxcrVR5ks
	Zk9vZrJ4fOczu8XR/2/ZLCYdusZo8fTqLCaLvbe0LRa2LWGx2LP3JIvF5V1z2CzmL3vKbrH8
	+D8mi4kdV5ksdjxpZLTY9ns+s8W61+9ZLE7ckrY4//c4q4Osx+Ur3h6nFkl47Jx1l93j/L2N
	LB6Xz5Z6bFrVyeaxeUm9x4vNMxk9dt9sYPNY3DeZ1aO3+R2bx87W+6weH5/eYvF4v+8qm0ff
	llWMHmcWHGEPEI7isklJzcksSy3St0vgynjx7CxjwR2/ikNrd7I0MHY4dDFyckgImEgsWH6E
	tYuRi0NIYDujxLHTH1ghEpISy/4eYYawhSVW/nvODmILCTQzSSw9JtLFyMHBJqAtcfo/B0iv
	iMB2ZomPzd1MIDXMAq0sEnefVoHYwgKWEs9mrgKbwyKgKvF241NGEJsXKL6g6SEbxHx5idUb
	DoDVcApYSRzY+oERYpelxN3rH9gg6gUlTs58wgKyl1lAXWL9PCGIVfISzVtnM09gFJyFpGoW
	QtUsJFULGJlXMYqmFhTnpucmFxjqFSfmFpfmpesl5+duYgQnDq2gHYzL1v/VO8TIxMF4iFGC
	g1lJhHfTFs80Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rzKOZ0pQgLpiSWp2ampBalFMFkmDk6p
	BqaYZ994TkRXuVxYfvjynCzdL48TxBVNL9puKpSNOyGozWtRfdfFzcP87Z/9J40E3kj93Hn9
	ysTe4Bfze5/vmxtpwPm+e1eKnGsltwa3yoSfcxRN1BpDDp+QTpcsuiZR9GL1Dk69ecF1HAw8
	t0/M/LCv+9Iu1gY2taPrdD9w2Vb67rgQG38zar/Cee7vyZsTm1Sja2YxNK3s/rHsw5vLLa09
	AW1VK7+on4n6onH7p+06px2tfru/qBgtKv1c8M7RmPfyHJ2DFzqkF9/RP3CCqzKgvuhM9PGD
	ASZbWxlS/+xx0p7KeHB5W3H56RzDVRtsXEJvTlljoXP66nava1cnHbBfFeIXzfXhwM8dDbWV
	u64psRRnJBpqMRcVJwIAO0Fg4YsDAAA=
X-CMS-MailID: 20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7
References: <20240520102033.9361-1-nj.shetty@samsung.com>
	<CGME20240520102940epcas5p2b5f38ceabe94bed3905fb386a0d65ec7@epcas5p2.samsung.com>

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
 drivers/nvme/host/core.c      | 81 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/trace.c     | 19 ++++++++
 include/linux/blkdev.h        |  1 +
 include/linux/nvme.h          | 43 +++++++++++++++++--
 5 files changed, 141 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 6f2ebb5fcdb0..01b02e76e070 100644
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
index 954f850f113a..238905f9fff6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -795,6 +795,66 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
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
+			src_lba = nvme_sect_to_lba(ns->head,
+							bio->bi_iter.bi_sector);
+			if (n_lba !=
+				bio->bi_iter.bi_size >> ns->head->lba_shift)
+				return BLK_STS_IOERR;
+		} else {
+			dst_lba = nvme_sect_to_lba(ns->head,
+							bio->bi_iter.bi_sector);
+			n_lba = bio->bi_iter.bi_size >> ns->head->lba_shift;
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
@@ -1041,6 +1101,11 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
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
@@ -1218,7 +1283,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_passthru_end, NVME_TARGET_PASSTHRU);
 
 /*
  * Recommended frequency for KATO commands per NVMe 1.4 section 7.12.1:
- * 
+ *
  *   The host should send Keep Alive commands at half of the Keep Alive Timeout
  *   accounting for transport roundtrip times [..].
  */
@@ -1802,6 +1867,18 @@ static void nvme_config_discard(struct nvme_ns *ns, struct queue_limits *lim)
 		lim->max_discard_segments = NVME_DSM_MAX_RANGES;
 }
 
+static void nvme_config_copy(struct nvme_ns *ns, struct nvme_id_ns *id,
+			     struct queue_limits *lim)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (ctrl->oncs & NVME_CTRL_ONCS_COPY)
+		lim->max_copy_hw_sectors =
+			nvme_lba_to_sect(ns->head, id->mssrl);
+	else
+		lim->max_copy_hw_sectors = 0;
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -2098,6 +2175,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 	if (!nvme_update_disk_info(ns, id, &lim))
 		capacity = 0;
 	nvme_config_discard(ns, &lim);
+	nvme_config_copy(ns, id, &lim);
 	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
 	    ns->head->ids.csi == NVME_CSI_ZNS)
 		nvme_update_zone_info(ns, &lim, &zi);
@@ -4833,6 +4911,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 0288315f0050..dfc97fff886b 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -153,6 +153,23 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
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
@@ -340,6 +357,8 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_resv_rel(p, cdw10);
 	case nvme_cmd_resv_report:
 		return nvme_trace_resv_report(p, cdw10);
+	case nvme_cmd_copy:
+		return nvme_trace_copy(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8b1edb46880a..1c5974bb23d5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1287,6 +1287,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 
 /* maximum copy offload length, this is set to 128MB based on current testing */
 #define BLK_COPY_MAX_BYTES		(1 << 27)
+#define BLK_COPY_MAX_SEGMENTS		2
 
 static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 425573202295..5275a0962a02 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -341,7 +341,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -369,6 +369,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -418,7 +419,10 @@ struct nvme_id_ns {
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
@@ -830,6 +834,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -853,7 +858,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -1030,6 +1036,36 @@ struct nvme_dsm_range {
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
@@ -1794,6 +1830,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.17.1


