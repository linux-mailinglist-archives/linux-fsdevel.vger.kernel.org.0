Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE6469CB5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Feb 2023 13:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232183AbjBTMtd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Feb 2023 07:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbjBTMtO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Feb 2023 07:49:14 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7B91CF79
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 04:48:41 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230220124839epoutp033afbe2d10ed2e91cdb8a9c1b0ebc44cf~FiTpIxX-12509725097epoutp03c
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 12:48:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230220124839epoutp033afbe2d10ed2e91cdb8a9c1b0ebc44cf~FiTpIxX-12509725097epoutp03c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676897319;
        bh=bVQ7kicVZIOPaeJOrYYdOYdwRoFGTReeAtGN5nn3CRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NDfONTj1XfFVgo5RJ6h6ZCg+Vmjt8M/+HBUbZMHfqoEKXD3azqLiQXzsh6LXLpejf
         NFb7+91ytcZv/bQiba+tE0aqZEOnsvHV7kFjB59eixTMOYvJl+qEA2NM26l8K1Z6h5
         CnM60FJ2wGUmJVbz1nP7G7AJ/NdI0lXD6Kfmau48=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230220124838epcas5p3dcf70f2b730e00dd49ee1752af5fa9c5~FiToHmIjm1791917919epcas5p3T;
        Mon, 20 Feb 2023 12:48:38 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PL2KK0Qzsz4x9Pp; Mon, 20 Feb
        2023 12:48:37 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        34.A6.55678.42C63F36; Mon, 20 Feb 2023 21:48:36 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230220105512epcas5p15e1171c05e5ceda614d4f196672ad678~FgwlA0KTy1670816708epcas5p1N;
        Mon, 20 Feb 2023 10:55:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220105512epsmtrp2889425e694cd431aaa5daf1cb3c64625~Fgwk-_7pQ1664116641epsmtrp2d;
        Mon, 20 Feb 2023 10:55:12 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-94-63f36c247ede
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        4C.8C.05839.F8153F36; Mon, 20 Feb 2023 19:55:11 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220105508epsmtip29ca3624ae0ed188e3d91fa3ca62445f2~FgwhyO3SW0727007270epsmtip2o;
        Mon, 20 Feb 2023 10:55:08 +0000 (GMT)
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
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v7 5/8] nvme: add copy offload support
Date:   Mon, 20 Feb 2023 16:23:28 +0530
Message-Id: <20230220105336.3810-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230220105336.3810-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Te0xbZRTfvbf0saRweUw/QBy7my4UgRahfkVwxi3zVjQi6hIXJ63lCgi0
        TUsFZrKV8UYZbAqyIgUmewCuSJkEBhVWhI02DAVaHgGZE2Zk4yF1WxAbbCno/vv9zvn9zvnO
        +XKYmFcZw4+ZIs2gFFJxGkHfSWvvC+KE7EuzSbh3hqNgi2kAg6fK7Rhsnimjw8qVNQyuDw1j
        0LBU7QYneztR2H3+LAobm/tR2FX/Jwp/m7YxYP/GIh2eNVoROG/RoNAwFQy7DYM0OHrtazqs
        vTjPgMYvclHYMZeDwPb1Wgzq7i3T4M0pfzhsv+H2MiBHx2JJzewQnezUzDDI4V9aaeTokIrU
        NxXTybaGk2TXpJpOluYuOQT5s27k8g8WOnn6ahNCtpk/JW36p0n93CIa53E0NTqZEidSikBK
        KpElpkiTYojYtxMOJkTyubwQngC+QARKxelUDHHo9biQwylpjj0QgZ+I01SOUJxYqSTCXopW
        yFQZVGCyTJkRQ1DyxDR5hDxUKU5XqqRJoVIqI4rH5YZHOoSi1OSiW7do8pLMrHq7UI3oRCUI
        iwnwCFBVVuxWguxkeuFdCBioXqO7yCoC2sx1qIs8RID5fim6bVm//gBxJQwIaLCatkguChom
        Vh2EyaTjwcC8wXQafPBpFHSa9zo1GF6HgSFLN82Z8Mb5YE1nYzgxDX8GnCtZxJyYjQuArrzV
        zVkH4GGgbNbTCVl4FHiUl+1SeILBc3ObVTB8N8j9vhpzlgd4FwtocyboroceAnZtDc2FvcHC
        jasMF/YDtiXDliYTNH55me4y5yFAM65BXIkDIN9UhjkbY3gQaLkW5goHgAqTDnU1dgel63Nb
        S2GDDu023gu+banbqu8LrI9ytjAJfqwxb2IvvBQB9vnj5Uig5rF5NI/No/m/cx2CNSG+lFyZ
        nkQpI+XhUirzvz+WyNL1yOZlcF7rQH69vRJqRFAmYkQAEyN82Btsm8SLnSjOPk4pZAkKVRql
        NCKRjnWfwfx2SWSO05JmJPAiBNwIPp8fIXiezyOeZO+PGZR44UniDCqVouSUYtuHMll+arSi
        OCrM753n4k8SU9nsAMlP+lMxI8jIs/LdT/T8fS+g9OKR2AVVJj7w16vvR3H2X6/sz5kQsT6K
        nDSK1g2CAmFC28GxC9WWFcmMtaLd2jP2cEXeu/C79wViYKiquUDN+Wf07vCR+GXh7cOFvZ2v
        DEbgb35c83mBKX+Hj7DyMw9m63f7RMd0l9w73vP944rlpjog3DuveGMlSL9H2LMc+wbBvqtl
        xX4wFi9S/6ydLtJWdRSOZz114itmsPWMb9/pO8f8z48oBf5vVbrPc4U7li95cvqWHuzJMued
        +LC2fpem7OhskeXFbxYmV01N2YWNHmHv2oUc8YHoK5fFQWvj3oz7rbPWYIKmTBbzOJhCKf4X
        a9tDxKIEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03Se1BMcRQHcL/7u3v3tmN1d/P4edasIWpEmJ1fJsZ4zFzErMGM5+hO7rRo
        s/YWYSjWcw0lNFqP5Jliadejp8dSSbWhZdTIzlBiqDY7ZDVbXDH89z3nfM7569BQ+ZocQq+N
        T+AN8VycipKRtx+qAselLvTETLj5IQJff1IO8a40H8R5jakUznB7Ie6qqYW4tO2kBNffLyRw
        ybl0Al/JKyNwcXYHgd+99khxWU8rhdPtLwFufmEmcGlDKC4prSRxXdEpCmddapZi+1EjgQua
        dgJ8uysLYsundhI/bhiKa30VkumIrXPOY82uGootNDdK2do3+SRbV5PIWnMPUKztQjJbXJ9C
        sYeMbb/AHpeEbb/7gmIP38wFrK1qG+uxjmCtTa2Exn+5LHINH7d2E28YPy1apt3vcJB60+ak
        bN+cFGCJNgE/GjGTUdeDr8AEZLSSKQbIcaQO9g4Go0u+R39yALrS3SLtRTsJ5O3cR5kATVNM
        KKrqocV+f+Y9gWrevIViARkLRNeMFyXidgCjRl6LRypmkhmFMk2tv6/KmQhkScuXiIcQMx6l
        uhRi9GOmoM7dW0Sh/CUep9tAr1agyswmUiSQCUbXzyjFNmQCkfHWSZgGFOb/lPmfMv+nzgKY
        CwbzekEXqxPC9eHx/OYwgdMJifGxYTEbdFbw+wFCxhaAO7nuMDsgaGAHiIaq/vIeuSdGKV/D
        bdnKGzasNiTG8YIdDKVJ1SD5U1PlaiUTyyXw63lezxv+Tgnab0gKMfPgV+ewvCVvv3WMlm7t
        yJj0XKMLcMh6Qr3y2c9fhQgLqrPz+racjVQUDGjbqNa5vmcdHN2dMGZy2LWGw00TT2dFjVg/
        UOgz3DglfBWnvfrlRHXydKX7sps5UfKp+of3eLflicM/pdw/w9keFFukuXd1bwcXsWLs/ejA
        yMaKHWou4cacZ93VzuBMv4pNpxwrFy1122bMt5qSNTky9dRzLt+SkTkf8/stnpuzvSjxhnRB
        Z2FBy7Ao5zpYxkxqKwd39PpMY5X8R5TtvHqhJjBoR3bSimWKmae/vbocjB3zm/X1i8FUlvZv
        WEl53S+TPhNnat+la4/tXzprXs7dY7sHHjdqD6lIQcuFh0CDwP0Eoub2L28DAAA=
X-CMS-MailID: 20230220105512epcas5p15e1171c05e5ceda614d4f196672ad678
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220105512epcas5p15e1171c05e5ceda614d4f196672ad678
References: <20230220105336.3810-1-nj.shetty@samsung.com>
        <CGME20230220105512epcas5p15e1171c05e5ceda614d4f196672ad678@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For device supporting native copy, nvme driver receives read and
write request with BLK_COPY op flags.
For read request the nvme driver populates the payload with source
information.
For write request the driver converts it to nvme copy command using the
source information in the payload and submits to the device.
current design only supports single source range.
This design is courtesy Mikulas Patocka's token based copy

trace event support for nvme_copy_cmd.
Set the device copy limits to queue limits.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/constants.c |   1 +
 drivers/nvme/host/core.c      | 106 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c        |   5 ++
 drivers/nvme/host/nvme.h      |   7 +++
 drivers/nvme/host/pci.c       |  27 ++++++++-
 drivers/nvme/host/rdma.c      |   7 +++
 drivers/nvme/host/tcp.c       |  16 +++++
 drivers/nvme/host/trace.c     |  19 ++++++
 include/linux/nvme.h          |  43 +++++++++++++-
 9 files changed, 223 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index e958d5015585..4e60946d3aa8 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -19,6 +19,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_report] = "Reservation Report",
 	[nvme_cmd_resv_acquire] = "Reservation Acquire",
 	[nvme_cmd_resv_release] = "Reservation Release",
+	[nvme_cmd_copy] = "Copy Offload",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
 	[nvme_cmd_zone_append] = "Zone Management Append",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8b6421141162..4b1a1a3fad83 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -753,6 +753,80 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy_read(struct nvme_ns *ns,
+		struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
+
+	memcpy(token->subsys, "nvme", 4);
+	token->ns = ns;
+	token->src_sector = bio->bi_iter.bi_sector;
+	token->sectors = bio->bi_iter.bi_size >> 9;
+
+	return BLK_STS_OK;
+}
+
+static inline blk_status_t nvme_setup_copy_write(struct nvme_ns *ns,
+	       struct request *req, struct nvme_command *cmnd)
+{
+	struct nvme_copy_range *range = NULL;
+	struct bio *bio = req->bio;
+	struct nvme_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
+	sector_t src_sector, dst_sector, n_sectors;
+	u64 src_lba, dst_lba, n_lba;
+	unsigned short nr_range = 1;
+	u16 control = 0;
+
+	if (unlikely(memcmp(token->subsys, "nvme", 4)))
+		return BLK_STS_NOTSUPP;
+	if (unlikely(token->ns != ns))
+		return BLK_STS_NOTSUPP;
+
+	src_sector = token->src_sector;
+	dst_sector = bio->bi_iter.bi_sector;
+	n_sectors = token->sectors;
+	if (WARN_ON(n_sectors != bio->bi_iter.bi_size >> 9))
+		return BLK_STS_NOTSUPP;
+
+	src_lba = nvme_sect_to_lba(ns, src_sector);
+	dst_lba = nvme_sect_to_lba(ns, dst_sector);
+	n_lba = nvme_sect_to_lba(ns, n_sectors);
+
+	if (WARN_ON(!n_lba))
+		return BLK_STS_NOTSUPP;
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
+	cmnd->copy.sdlba = cpu_to_le64(dst_lba);
+
+	range = kmalloc_array(nr_range, sizeof(*range),
+			GFP_ATOMIC | __GFP_NOWARN);
+	if (!range)
+		return BLK_STS_RESOURCE;
+
+	range[0].slba = cpu_to_le64(src_lba);
+	range[0].nlb = cpu_to_le16(n_lba - 1);
+
+	cmnd->copy.nr_range = 0;
+
+	req->special_vec.bv_page = virt_to_page(range);
+	req->special_vec.bv_offset = offset_in_page(range);
+	req->special_vec.bv_len = sizeof(*range) * nr_range;
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	cmnd->copy.control = cpu_to_le16(control);
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -979,10 +1053,16 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
 	case REQ_OP_READ:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
+		if (unlikely(req->cmd_flags & REQ_COPY))
+			ret = nvme_setup_copy_read(ns, req);
+		else
+			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
 		break;
 	case REQ_OP_WRITE:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
+		if (unlikely(req->cmd_flags & REQ_COPY))
+			ret = nvme_setup_copy_write(ns, req, cmd);
+		else
+			ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_write);
 		break;
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
@@ -1731,6 +1811,26 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
+				       struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *q = disk->queue;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
+		blk_queue_max_copy_sectors_hw(q, 0);
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		return;
+	}
+
+	/* setting copy limits */
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, q))
+		return;
+
+	blk_queue_max_copy_sectors_hw(q,
+		nvme_lba_to_sect(ns, le16_to_cpu(id->mssrl)));
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -1930,6 +2030,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -5323,6 +5424,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 456ee42a6133..0ec8f9cd0e09 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2807,6 +2807,11 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) &&
+				(req_op(rq) == REQ_OP_READ))) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
 	/*
 	 * nvme core doesn't quite treat the rq opaquely. Commands such
 	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 424c8a467a0c..6e282956deb4 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -500,6 +500,13 @@ struct nvme_ns {
 
 };
 
+struct nvme_copy_token {
+	char subsys[4];
+	struct nvme_ns *ns;
+	u64 src_sector;
+	u64 sectors;
+};
+
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
 static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
 {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6d88ddd35565..0b1dc5c457ad 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -499,16 +499,19 @@ static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
 		nvmeq->sq_tail = 0;
 }
 
-static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
+static inline void nvme_commit_sq_db(struct nvme_queue *nvmeq)
 {
-	struct nvme_queue *nvmeq = hctx->driver_data;
-
 	spin_lock(&nvmeq->sq_lock);
 	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
 		nvme_write_sq_db(nvmeq, true);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
+static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	nvme_commit_sq_db(hctx->driver_data);
+}
+
 static void **nvme_pci_iod_list(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -898,6 +901,12 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	if (ret)
 		return ret;
 
+	if (unlikely((req->cmd_flags & REQ_COPY) &&
+				(req_op(req) == REQ_OP_READ))) {
+		blk_mq_start_request(req);
+		return BLK_STS_OK;
+	}
+
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
@@ -944,6 +953,18 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ret = nvme_prep_rq(dev, req);
 	if (unlikely(ret))
 		return ret;
+	if (unlikely((req->cmd_flags & REQ_COPY) &&
+				(req_op(req) == REQ_OP_READ))) {
+		blk_mq_set_request_complete(req);
+		blk_mq_end_request(req, BLK_STS_OK);
+		/* Commit the sq if copy read was the last req in the list,
+		 * as copy read deoesn't update sq db
+		 */
+		if (bd->last)
+			nvme_commit_sq_db(nvmeq);
+		return ret;
+	}
+
 	spin_lock(&nvmeq->sq_lock);
 	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
 	nvme_write_sq_db(nvmeq, bd->last);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index bbad26b82b56..a8bf2a87f42a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2043,6 +2043,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) &&
+				(req_op(rq) == REQ_OP_READ))) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		ret = BLK_STS_OK;
+		goto unmap_qe;
+	}
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 8cedc1ef496c..776e2ba84911 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2346,6 +2346,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) &&
+				(req_op(rq) == REQ_OP_READ))) {
+		return BLK_STS_OK;
+	}
+
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2414,6 +2419,17 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) &&
+				(req_op(rq) == REQ_OP_READ))) {
+		blk_mq_set_request_complete(rq);
+		blk_mq_end_request(rq, BLK_STS_OK);
+		/* if copy read is the last req queue tcp reqs */
+		if (bd->last && nvme_tcp_queue_more(queue))
+			queue_work_on(queue->io_cpu, nvme_tcp_wq,
+					&queue->io_work);
+		return ret;
+	}
+
 	nvme_tcp_queue_request(req, true, bd->last);
 
 	return BLK_STS_OK;
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 1c36fcedea20..da4a7494e5a7 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -150,6 +150,23 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_copy(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 slba = get_unaligned_le64(cdw10);
+	u8 nr_range = get_unaligned_le16(cdw10 + 8);
+	u16 control = get_unaligned_le16(cdw10 + 10);
+	u32 dsmgmt = get_unaligned_le32(cdw10 + 12);
+	u32 reftag = get_unaligned_le32(cdw10 +  16);
+
+	trace_seq_printf(p,
+			 "slba=%llu, nr_range=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+			 slba, nr_range, control, dsmgmt, reftag);
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
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4fad4aa245fb..e92dd69c745a 100644
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
@@ -796,6 +800,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -818,7 +823,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -995,6 +1001,36 @@ struct nvme_dsm_range {
 	__le64			slba;
 };
 
+struct nvme_copy_command {
+	__u8                    opcode;
+	__u8                    flags;
+	__u16                   command_id;
+	__le32                  nsid;
+	__u64                   rsvd2;
+	__le64                  metadata;
+	union nvme_data_ptr     dptr;
+	__le64                  sdlba;
+	__u8			nr_range;
+	__u8			rsvd12;
+	__le16                  control;
+	__le16                  rsvd13;
+	__le16			dspec;
+	__le32                  ilbrt;
+	__le16                  lbat;
+	__le16                  lbatm;
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
@@ -1752,6 +1788,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.35.1.500.gb896f729e2

