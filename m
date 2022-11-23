Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C07635030
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Nov 2022 07:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiKWGOJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Nov 2022 01:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiKWGNs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Nov 2022 01:13:48 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F22F391E
        for <linux-fsdevel@vger.kernel.org>; Tue, 22 Nov 2022 22:13:32 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221123061330epoutp0330a807f563418b874b4dab564bdde3a5~qIgOkxAR-0804208042epoutp03R
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Nov 2022 06:13:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221123061330epoutp0330a807f563418b874b4dab564bdde3a5~qIgOkxAR-0804208042epoutp03R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1669184010;
        bh=wixPQbOeqA/8VL7y5AaQHTHqg3E2g4wO+mQ7p/uHXA0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=djbIGFtgq1hVPUV6mpRbpTXU3yxI2/glnXXjjMNEuNPbAq+jLStUQ2IKVj7X8seqx
         xIoA6Zly/6LgWZRImqGe/jDUZmRB2f/VCO54eEHF9oO44SdBqbht5JVDzmQzZuQPmy
         INkScdvWueNAE6llNvu5OCw9zSjkuCnvFXgB2Qz8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20221123061330epcas5p3a3dc532a95135f8efcab3c1d537a55b1~qIgN8Kw_U1162011620epcas5p3G;
        Wed, 23 Nov 2022 06:13:30 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4NH9mS0rXMz4x9Pv; Wed, 23 Nov
        2022 06:13:28 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.81.01710.70ABD736; Wed, 23 Nov 2022 15:13:27 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061028epcas5p1aecd27b2f4f694b5a18b51d3df5d7432~qIdkRaBU-1477114771epcas5p1z;
        Wed, 23 Nov 2022 06:10:28 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20221123061028epsmtrp1cfd31646264591325c4f7ace998d2661~qIdkQSnO71958719587epsmtrp1L;
        Wed, 23 Nov 2022 06:10:28 +0000 (GMT)
X-AuditID: b6c32a49-c9ffa700000006ae-c6-637dba07ebd0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        8F.B2.18644.359BD736; Wed, 23 Nov 2022 15:10:27 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20221123061024epsmtip1eee71df6bc660545a51ff2a4c5239c0e~qIdhOmlWl2539625396epsmtip1b;
        Wed, 23 Nov 2022 06:10:24 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     axboe@kernel.dk, agk@redhat.com, snitzer@kernel.org,
        dm-devel@redhat.com, kbusch@kernel.org, hch@lst.de,
        sagi@grimberg.me, james.smart@broadcom.com, kch@nvidia.com,
        damien.lemoal@opensource.wdc.com, naohiro.aota@wdc.com,
        jth@kernel.org, viro@zeniv.linux.org.uk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, p.raghav@samsung.com,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH v5 05/10] nvme: add copy offload support
Date:   Wed, 23 Nov 2022 11:28:22 +0530
Message-Id: <20221123055827.26996-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20221123055827.26996-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVCTdRy/3/OMZ8MOexh6/liWu3FwBwZstM0fCKYX1YNxF6HXm+xwN57G
        67bbS1CHJ+jQwtgQy3Ikg8sMMaE24mWA0IgQFNEz5BhvlqwDEwzRMJBo44Hyv8/3+/18vi+f
        3/04OPcTNo+TodLTWpU8W0CsYzV0hoaGsx0HFEJnjwTV9f6Mo0OlSzg6P2om0GJfP47aZsp9
        0FBHM4bOne/CUEvVLIZuj8yxUdfyNIF+feBioTLnTYDcAxYMtbm2ota2Hha64fiSQNazbjY6
        3m33QU0ThQA1LFpxNPe1kY1q/7jHQpdcz6D+pW6fnZCyjPcRVLNllE31j33Pom70GShbzccE
        ZT9zkGoZKiCoksMzHkLRuA917+IAQZnqawA1Z3uOOtpxDKNsE9NY0vp3s2LTaXkareXTKoU6
        LUOljBO8tif1pVSJVCgKF0WjbQK+Sp5DxwniE5PCX8nI9pgg4L8vzzZ4UklynU4QuSNWqzbo
        aX66WqePE9CatGyNWBOhk+foDCplhIrWx4iEwiiJh7g/K720YYytKdPljUxbWQXALCsGvhxI
        iqGtYZBdDNZxuGQLgJfO9ONMcB9A9+dzgAnmAPyp8RtiTTLdObIqcQBouXV2pcAlizBYP6ws
        BhwOQW6Fl5c5Xs4G0oTBj1o6cC8HJ4cx2NMW7MUBJIJDj2d8vJhFBsPb9mW2F/uRMdBxbRjz
        9oFkJDSP+3vTvuR2eOW6A2Mo/rDn1ASLabkFHv6hfGVrSDb6wqVFM5vRxsPvZmOYnQPgne56
        NoN5cMp8ZBXnwnOfVhOM1ui5ZdACmMKLsKjXjHv74GQorHNEMuln4We9tRgzdz0sWZzAmLwf
        bKpYw0Hw27rKVa8C4c35QoJZh4J9lRzGNhOAhb1ToBTwLU+cY3niHMv/kysBXgMCaY0uR0nr
        JBqRis79740V6hwbWPkWYQlNYPTWnxFOgHGAE0AOLtjgdzAhX8H1S5N/8CGtVadqDdm0zgkk
        HruP47yNCrXnX6n0qSJxtFAslUrF0S9IRYJNfl99Eabgkkq5ns6iaQ2tXdNhHF9eAcZpfyPx
        rbjG+hN7fhNN5O2az6991SJ9qi/o4UjCUbWF5+rowoy04OlTwseuSXem6YCc+/f1hZroaVL2
        tuxywpEi/pZjFfYTVe3VUXubHlSPRfCXeXVRCwspsdfuxtvbg/8yLwWoePMyWGJ2t+a7C8o3
        X60wslo2K990lJw0/WI/eXry+ZhGSwgYm4pMNAw25V280r2pfd5dnvRPjPXqdmLf7vRZu/gd
        Wag5RLmv8cLQIfvv9yVlxgspKCj54c69mcbAwrTobftzJa13QfLr4e3CIIsrcKDqToirLYWU
        YbmzptOZya1iedmul52PrDves+bwNtoeTf6I3BnNmRr/zt0Cli5dLgrDtTr5v/87K+2fBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWy7bCSnG7wztpkg6atNhbrTx1jtmia8JfZ
        YvXdfjaL32fPM1vsfTeb1eLmgZ1MFitXH2Wy2L3wI5PF4zuf2S2O/n/LZvHwyy0Wi0mHrjFa
        PL06i8li7y1tiz17T7JYXN41h81i/rKn7BYTj29mtdjxpJHRYtvv+cwWn5e2sFuse/2exeLE
        LWmL83+PszpIeMy6f5bNY+esu+we5+9tZPG4fLbUY9OqTjaPzUvqPXbfbGDz6G1+B1TQep/V
        4/2+q2wefVtWMXp83iTn0X6gm8lj05O3TAF8UVw2Kak5mWWpRfp2CVwZE7bdYy+YVFxx5+18
        lgbG/tguRk4OCQETibeH77B3MXJxCAnsYJT4/2MeO0RCUmLZ3yPMELawxMp/z8HiQgLNTBIz
        m0K6GDk42AS0JU7/5wDpFRFYwCRx+d4rsHpmgadMEmefeIPYwgIWEjf/vGMFsVkEVCUeb/4P
        NodXwEpi14XbTCBzJAT0JfrvC4KEOQWsJc5c3AUWFgIq2bNMB6JaUOLkzCcsIGFmAXWJ9fOE
        IBbJSzRvnc08gVFwFpKqWQhVs5BULWBkXsUomVpQnJueW2xYYJSXWq5XnJhbXJqXrpecn7uJ
        ERz5Wlo7GPes+qB3iJGJg/EQowQHs5IIb71nTbIQb0piZVVqUX58UWlOavEhRmkOFiVx3gtd
        J+OFBNITS1KzU1MLUotgskwcnFINTIZ8oWoe2v5LCop/WpVFu/H6NCZt7lXuao+V8nkZ0HZ/
        w9t96qlLeS3rjU6far4dvW3hR8e5UqzCP8x/njtUI9Dfk1jWV/Oqpztvav8pldDEEz/6zx/d
        OmX6HmdD0eeanwQyz5jdTNN8YP2+q2avXneV/oxPOkFhCa83v9378ZG86/q8X36THgmmiFvf
        uHPr7+tffxM5fL9E7SpfP9HtgOds+/Nek1seF1469v9Xh2uJ863+4LjTR+z9JutlP6pfvsu+
        8LTdhUWWXb+z/L+niF+fpvziWFXs3KUvD31a5reud5GrscfppZcCFu0v3edty8px+ZL7Te7N
        m5uVrF1X7rqwc8NfR9EzXDd4LSJPNyqxFGckGmoxFxUnAgBsRPyUawMAAA==
X-CMS-MailID: 20221123061028epcas5p1aecd27b2f4f694b5a18b51d3df5d7432
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221123061028epcas5p1aecd27b2f4f694b5a18b51d3df5d7432
References: <20221123055827.26996-1-nj.shetty@samsung.com>
        <CGME20221123061028epcas5p1aecd27b2f4f694b5a18b51d3df5d7432@epcas5p1.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 drivers/nvme/host/core.c  | 106 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c    |   5 ++
 drivers/nvme/host/nvme.h  |   7 +++
 drivers/nvme/host/pci.c   |  28 ++++++++--
 drivers/nvme/host/rdma.c  |   7 +++
 drivers/nvme/host/tcp.c   |  16 ++++++
 drivers/nvme/host/trace.c |  19 +++++++
 include/linux/nvme.h      |  43 ++++++++++++++--
 8 files changed, 223 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4423ccd0b0b1..26ce482ac112 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -751,6 +751,80 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
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
@@ -974,10 +1048,16 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
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
@@ -1704,6 +1784,26 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1903,6 +2003,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -5228,6 +5329,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5d57a042dbca..b2a1cf37cd92 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2794,6 +2794,11 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
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
index f9df10653f3c..17cfcfc58346 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -495,6 +495,13 @@ struct nvme_ns {
 
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
index 0163bfa925aa..eb1ed2c8b3a2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -503,16 +503,19 @@ static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
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
@@ -900,6 +903,12 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
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
@@ -913,6 +922,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	}
 
 	blk_mq_start_request(req);
+
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -946,6 +956,18 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
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
index 6e079abb22ee..693865139e3c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2040,6 +2040,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) &&
+				(req_op(rq) == REQ_OP_READ))) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		ret = BLK_STS_OK;
+		goto unmap_qe;
+	}
+
 	blk_mq_start_request(rq);
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9b47dcb2a7d9..e42fb53e9dc2 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2348,6 +2348,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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
@@ -2416,6 +2421,17 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
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
index 050d7d0cd81b..41349d78d410 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -336,7 +336,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -364,6 +364,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -413,7 +414,10 @@ struct nvme_id_ns {
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
@@ -794,6 +798,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -815,7 +820,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -991,6 +997,36 @@ struct nvme_dsm_range {
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
@@ -1748,6 +1784,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.35.1.500.gb896f729e2

