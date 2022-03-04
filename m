Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF3E24CDB73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Mar 2022 18:56:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240887AbiCDR45 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Mar 2022 12:56:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230418AbiCDR44 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Mar 2022 12:56:56 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC941C468F;
        Fri,  4 Mar 2022 09:56:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=vRHrr+pFZYpBh3MfC4zmvH3GToPVOi2nkrml61HN4jc=; b=OCjXNDyCEF7fbDf8x3/awNDjSJ
        W86w8Q/nrsY1Bv2CWPdU0ruxF0yVXiN8yryLxyuxvMW2m3oSo9TQTuymIbKB6Bk6I0aa/Ip7Dlp/m
        rKDTe36Qj5uPNrL87brB1BBtl1UYAydoeg/n1PuU3XNoPReYC+9OakAt/adhPS8CrzX0lVJnWYqxD
        l7bRasFd4IvbIBCrahsnhH0DsixZzfXFWk3buGDeTa7SQT+Lh8T7hm4RGkr0ksF08u1EYrawFU45d
        LZbOOuqiR7VvQFhyj8LVRvHdePAe8UHCdp88JYcGtQX0lY4qhKmEObDEeKzGn6gfsK4VNArlfuT1J
        iH1mledQ==;
Received: from [2001:4bb8:180:5296:cded:8d4b:ace6:f3c] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQC9m-00BSPK-MU; Fri, 04 Mar 2022 17:55:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     sagi@grimberg.me, kbusch@kernel.org, song@kernel.org,
        linux-block@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/2] nvme: remove support or stream based temperature hint
Date:   Fri,  4 Mar 2022 18:55:55 +0100
Message-Id: <20220304175556.407719-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This support was added for RocksDB, but RocksDB ended up not using it.
At the same time drives on the open marked (vs those build for OEMs
for non-Linux support) that actually support streams are extremly
rare.  Don't bloat the nvme driver for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c | 140 ---------------------------------------
 1 file changed, 140 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e0bfda04bd7b..ca1504c178162 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -77,10 +77,6 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
 
-static bool streams;
-module_param(streams, bool, 0644);
-MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
-
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -714,105 +710,6 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 }
 EXPORT_SYMBOL_GPL(__nvme_check_ready);
 
-static int nvme_toggle_streams(struct nvme_ctrl *ctrl, bool enable)
-{
-	struct nvme_command c = { };
-
-	c.directive.opcode = nvme_admin_directive_send;
-	c.directive.nsid = cpu_to_le32(NVME_NSID_ALL);
-	c.directive.doper = NVME_DIR_SND_ID_OP_ENABLE;
-	c.directive.dtype = NVME_DIR_IDENTIFY;
-	c.directive.tdtype = NVME_DIR_STREAMS;
-	c.directive.endir = enable ? NVME_DIR_ENDIR : 0;
-
-	return nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0);
-}
-
-static int nvme_disable_streams(struct nvme_ctrl *ctrl)
-{
-	return nvme_toggle_streams(ctrl, false);
-}
-
-static int nvme_enable_streams(struct nvme_ctrl *ctrl)
-{
-	return nvme_toggle_streams(ctrl, true);
-}
-
-static int nvme_get_stream_params(struct nvme_ctrl *ctrl,
-				  struct streams_directive_params *s, u32 nsid)
-{
-	struct nvme_command c = { };
-
-	memset(s, 0, sizeof(*s));
-
-	c.directive.opcode = nvme_admin_directive_recv;
-	c.directive.nsid = cpu_to_le32(nsid);
-	c.directive.numd = cpu_to_le32(nvme_bytes_to_numd(sizeof(*s)));
-	c.directive.doper = NVME_DIR_RCV_ST_OP_PARAM;
-	c.directive.dtype = NVME_DIR_STREAMS;
-
-	return nvme_submit_sync_cmd(ctrl->admin_q, &c, s, sizeof(*s));
-}
-
-static int nvme_configure_directives(struct nvme_ctrl *ctrl)
-{
-	struct streams_directive_params s;
-	int ret;
-
-	if (!(ctrl->oacs & NVME_CTRL_OACS_DIRECTIVES))
-		return 0;
-	if (!streams)
-		return 0;
-
-	ret = nvme_enable_streams(ctrl);
-	if (ret)
-		return ret;
-
-	ret = nvme_get_stream_params(ctrl, &s, NVME_NSID_ALL);
-	if (ret)
-		goto out_disable_stream;
-
-	ctrl->nssa = le16_to_cpu(s.nssa);
-	if (ctrl->nssa < BLK_MAX_WRITE_HINTS - 1) {
-		dev_info(ctrl->device, "too few streams (%u) available\n",
-					ctrl->nssa);
-		goto out_disable_stream;
-	}
-
-	ctrl->nr_streams = min_t(u16, ctrl->nssa, BLK_MAX_WRITE_HINTS - 1);
-	dev_info(ctrl->device, "Using %u streams\n", ctrl->nr_streams);
-	return 0;
-
-out_disable_stream:
-	nvme_disable_streams(ctrl);
-	return ret;
-}
-
-/*
- * Check if 'req' has a write hint associated with it. If it does, assign
- * a valid namespace stream to the write.
- */
-static void nvme_assign_write_stream(struct nvme_ctrl *ctrl,
-				     struct request *req, u16 *control,
-				     u32 *dsmgmt)
-{
-	enum rw_hint streamid = req->write_hint;
-
-	if (streamid == WRITE_LIFE_NOT_SET || streamid == WRITE_LIFE_NONE)
-		streamid = 0;
-	else {
-		streamid--;
-		if (WARN_ON_ONCE(streamid > ctrl->nr_streams))
-			return;
-
-		*control |= NVME_RW_DTYPE_STREAMS;
-		*dsmgmt |= streamid << 16;
-	}
-
-	if (streamid < ARRAY_SIZE(req->q->write_hints))
-		req->q->write_hints[streamid] += blk_rq_bytes(req) >> 9;
-}
-
 static inline void nvme_setup_flush(struct nvme_ns *ns,
 		struct nvme_command *cmnd)
 {
@@ -916,7 +813,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		struct request *req, struct nvme_command *cmnd,
 		enum nvme_opcode op)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
 	u16 control = 0;
 	u32 dsmgmt = 0;
 
@@ -939,9 +835,6 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 	cmnd->rw.apptag = 0;
 	cmnd->rw.appmask = 0;
 
-	if (req_op(req) == REQ_OP_WRITE && ctrl->nr_streams)
-		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
-
 	if (ns->ms) {
 		/*
 		 * If formated with metadata, the block layer always provides a
@@ -1662,9 +1555,6 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		return;
 	}
 
-	if (ctrl->nr_streams && ns->sws && ns->sgs)
-		size *= ns->sws * ns->sgs;
-
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
 
@@ -1697,31 +1587,6 @@ static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 		a->csi == b->csi;
 }
 
-static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-				 u32 *phys_bs, u32 *io_opt)
-{
-	struct streams_directive_params s;
-	int ret;
-
-	if (!ctrl->nr_streams)
-		return 0;
-
-	ret = nvme_get_stream_params(ctrl, &s, ns->head->ns_id);
-	if (ret)
-		return ret;
-
-	ns->sws = le32_to_cpu(s.sws);
-	ns->sgs = le16_to_cpu(s.sgs);
-
-	if (ns->sws) {
-		*phys_bs = ns->sws * (1 << ns->lba_shift);
-		if (ns->sgs)
-			*io_opt = *phys_bs * ns->sgs;
-	}
-
-	return 0;
-}
-
 static int nvme_configure_metadata(struct nvme_ns *ns, struct nvme_id_ns *id)
 {
 	struct nvme_ctrl *ctrl = ns->ctrl;
@@ -1814,7 +1679,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	blk_integrity_unregister(disk);
 
 	atomic_bs = phys_bs = bs;
-	nvme_setup_streams_ns(ns->ctrl, ns, &phys_bs, &io_opt);
 	if (id->nabo == 0) {
 		/*
 		 * Bit 1 indicates whether NAWUPF is defined for this namespace
@@ -3103,10 +2967,6 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
-	ret = nvme_configure_directives(ctrl);
-	if (ret < 0)
-		return ret;
-
 	ret = nvme_configure_acre(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.30.2

