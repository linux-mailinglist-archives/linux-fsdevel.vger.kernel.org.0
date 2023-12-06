Return-Path: <linux-fsdevel+bounces-4973-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EBE1806C36
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 11:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFAD51C2097C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C632DF8F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Dec 2023 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="b1RAZUC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ACFAD50
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 02:12:12 -0800 (PST)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout2.samsung.com (KnoxPortal) with ESMTP id 20231206101210epoutp0293fe1c1f0bc6f062cb4434430f3cb987~eNmhHssUR2309923099epoutp02O
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 10:12:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20231206101210epoutp0293fe1c1f0bc6f062cb4434430f3cb987~eNmhHssUR2309923099epoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1701857530;
	bh=fYNdJcNvOYM0NikPBiyxDw367vizzK5VGaV1CjKZzsI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b1RAZUC8uO+8AzUpXOoPd6YsuspSU01uOumAgQ0kn+cHuuOcnOh+0osIYCLCGBAyP
	 CPzQPUJjVVzYbTLI+b3H+LifExzahj74iTM8BeUOHarqmY/i1tBnpcjyWYxFAA24bX
	 4NyTrvg9VLU+aIXhe+1jV6F6syG1s1VcxGqQxeMM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas5p4.samsung.com (KnoxPortal) with ESMTP id
	20231206101209epcas5p4ba8098a79c211d36797ac54c3af58367~eNmga0QOd2550525505epcas5p4b;
	Wed,  6 Dec 2023 10:12:09 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.183]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SlY9L0zWRz4x9Pw; Wed,  6 Dec
	2023 10:12:06 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	22.12.09672.5F840756; Wed,  6 Dec 2023 19:12:05 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101205epcas5p2f156e36e10cb0a75d1752e5390c27021~eNmcYTQdD2757427574epcas5p2j;
	Wed,  6 Dec 2023 10:12:05 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20231206101205epsmtrp1abfb1a8c2c8cb5f73f8c5ab5ed8eed3a~eNmcWzAB31127111271epsmtrp1M;
	Wed,  6 Dec 2023 10:12:05 +0000 (GMT)
X-AuditID: b6c32a4b-39fff700000025c8-3b-657048f5260d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
	epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
	2D.52.08817.5F840756; Wed,  6 Dec 2023 19:12:05 +0900 (KST)
Received: from localhost.localdomain (unknown [107.99.41.245]) by
	epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20231206101158epsmtip2827fe373811b8fab3d4dd523fa802b94~eNmVS4cJa1205412054epsmtip2K;
	Wed,  6 Dec 2023 10:11:57 +0000 (GMT)
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
	<hare@suse.de>, Kanchan Joshi <joshi.k@samsung.com>,
	=?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>, Anuj Gupta
	<anuj20.g@samsung.com>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v18 07/12] nvme: add copy offload support
Date: Wed,  6 Dec 2023 15:32:39 +0530
Message-Id: <20231206100253.13100-8-joshi.k@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231206100253.13100-1-joshi.k@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUZRjG5zvn7NldZpZWoOGTHNlWs5S4rCz4IaAWDJ1Gm6isiElhgzNA
	sBf3oiVUFAELyMVlYtrlGqLIJRgu2iJgXCWgolghYZAEFi8QEBBBMmC77Fr+93vfed7vmef9
	5mXhdlqmEytGoqTlElEcn7Qhrnbufd51hZLRHsVNvqi27waOFlfWCfRFzgaOqm5nk2i2cwkg
	Y1sqQCWlhQQaaWvCUEupBkMVVd0YmhpbZqLuR3Mk0nQMAzQ9pMNQ66gL+ialjEAtrb0EMlwr
	IFHxpWkmyvhNT6Lynk0M3cqZBui8eghDeuPnAF1dL8ZRzewCgX4YfQYNbPQwjuygmnS3mdTA
	eB1BGX5SUfWVaSTVUPYZdb9BC6jmkUSSupCVy6Ayk+ZJanF6lKAWrg+RVFZjJaAa+uOp5fqd
	VL1xDgt+KjTWL5oWRdJyHi2JkEbGSKL8+UffCgsI8/L2ELgKfNABPk8iEtP+/MBjwa5BMXGm
	5fB5p0VxKlMrWKRQ8N0P+cmlKiXNi5YqlP58WhYZJxPK3BQisUIliXKT0MqDAg+P/V4mYXhs
	tLavipQZjn3Urz+HJwLDoXTAZkGuEKb/WsJIBzYsO24zgJtX1khLsQRgWVcDYSn+BrBQrSMf
	j7RvjFtHWgFMmjer2KZiGcDk1jPpgMUiuXvhL7kqc9uBW43DpjqBWY9zkwg4XJ219ZA91weW
	zdwFZia4z8G6la9wM3O4CM72P2BYzJyhdnCVaWa2SZ97r9Sq2QZ7tcYtX9ykSbqSj5sNIHec
	DQ3GNWAZDoQFminrQ/ZwpqeRaWEn+CA7xcoRcFD7M2ZhJZxqabfyYZjcl42bw+CmMLXX3C1e
	tjBz3YiZ25DLgeoUO4v6WTiumbY6OcKJr8usTMHfM82u5l2dA7C9O5WRA5x1T0TQPRFB979b
	CcArwXZaphBH0QovmaeEPvPfx0ZIxfVg60b2HdWDyTt/unUAjAU6AGThfAdO3ICUtuNEij4+
	S8ulYXJVHK3oAF6mHZ/HnZ6OkJqOTKIMEwh9PITe3t5CH09vAd+RM5tcGGnHjRIp6VialtHy
	x3MYi+2UiBn9C34sp7xOqP65IPMZOmU79+47b55qq3V2Y7ZuL7qY212hj6nS57vrJl9TJ5xs
	PBz03VxD14eX99w8GZ3lcOPmvXhne5nab/hRYedx44n9b/9BGKI++KTlIp3kWcnIuGwDqgMC
	2Lfii3if5l8XaXpeN347ET6ywLtftKe3Bfi+sm2XY+NqCCd8h1h4NvFIUGAIc/zlnvHTad2Y
	wwst32e8upnmq44QgDGNk0bNrEjd2Zw+svTliwe8EuYS7uaOBi7O6O7kvMfME+92GVsLq1qt
	9rOtB6XzeV0uNcl98e+XlocSwS8V7rKdXLk0SB9nToQErryROhoi/iv0YZ4k82DbwxohyScU
	0SLBPlyuEP0LZ37jYKwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCIsWRmVeSWpSXmKPExsWy7bCSvO5Xj4JUgx//JC3WnzrGbPHx628W
	i6YJf5ktVt/tZ7N4ffgTo8WTA+2MFgsWzWWxuHlgJ5PFnkWTmCxWrj7KZPH4zmd2i6P/37JZ
	TDp0jdHi6dVZTBZ7b2lbLGxbwmKxZ+9JFovLu+awWcxf9pTdovv6DjaL5cf/MVncmPCU0WJi
	x1Umix1PGhkttv2ez2yx7vV7FosTt6Qtzv89zuog47Fz1l12j/P3NrJ4XD5b6rFpVSebx+Yl
	9R4vNs9k9Nh9s4HNY3HfZFaP3uZ3bB4fn95i8Xi/7yqbR9+WVYwem09Xe3zeJOex6clbpgD+
	KC6blNSczLLUIn27BK6MmadWsxVc9qk4vaOHuYHxsl0XIyeHhICJxMG/91i7GLk4hAR2M0pc
	mH+HCSIhLtF87Qc7hC0ssfLfc3aIoo+MEt//tLF1MXJwsAloSlyYXAoSFxHYwSzxc20zE4jD
	LDCZRWLjw3OMIN3CApYSS149A7NZBFQlNn6dygxi8wpYSLw+/ZIVYoO8xMxL38G2cQLVT36+
	CKxGCKhmX+N0Foh6QYmTM5+wgCxmFlCXWD9PCCTMDNTavHU28wRGwVlIqmYhVM1CUrWAkXkV
	o2RqQXFuem6xYYFRXmq5XnFibnFpXrpecn7uJkZwwtDS2sG4Z9UHvUOMTByMhxglOJiVRHhz
	zuenCvGmJFZWpRblxxeV5qQWH2KU5mBREuf99ro3RUggPbEkNTs1tSC1CCbLxMEp1cAk8aPA
	/NGmVqnL+r35TdLJzfVcH6MTOE9P+MTdZ7r2+9K27AWCOxhszBXnd5Van+ZXe3Klve5NwSVn
	ucdP4swzEmTeJees7XZtuPRctV89QevKLtnH/9+tVV6wOM86yrdy16uXRsIpivt0I2I02Mu+
	WBn7fvBcJXWkc/XUsAlHp9Q9LNLMZuGaLyEdOiWvYHMhy9/7HsJqC7TS4rhCzT+9W51x/7GJ
	9KaF+t9bT6VO3bPgX6/9Bw7l+bM9DjtfX79wHv+6aVzaYRP231j3u6bcwJmnak1x4umZC17r
	PG59rHugKV3HJG6qRpmeHoNGC+8ilZ9673xOh+9apmAw21fn8duIlvabr6zKW6Ym/1diKc5I
	NNRiLipOBADj7z7UhwMAAA==
X-CMS-MailID: 20231206101205epcas5p2f156e36e10cb0a75d1752e5390c27021
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231206101205epcas5p2f156e36e10cb0a75d1752e5390c27021
References: <20231206100253.13100-1-joshi.k@samsung.com>
	<CGME20231206101205epcas5p2f156e36e10cb0a75d1752e5390c27021@epcas5p2.samsung.com>

From: Nitesh Shetty <nj.shetty@samsung.com>

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
index 1be1ce522896..0ef218d5c2f5 100644
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
+	u64 dst_lba = 0, src_lba = 0, n_lba = 0;
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
@@ -1756,6 +1818,21 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1959,6 +2036,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -4696,6 +4774,7 @@ static inline void _nvme_check_size(void)
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
index 9fa1ad68beb5..25a71944c5cb 100644
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


