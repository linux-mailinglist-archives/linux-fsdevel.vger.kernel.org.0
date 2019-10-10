Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD00D298F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2019 14:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfJJMeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 10 Oct 2019 08:34:12 -0400
Received: from verein.lst.de ([213.95.11.211]:57954 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfJJMeM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 10 Oct 2019 08:34:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 40AA568C65; Thu, 10 Oct 2019 14:34:07 +0200 (CEST)
Date:   Thu, 10 Oct 2019 14:34:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [PATCH v9 05/12] Signed-off-by: Chaitanya Kulkarni
 <chaitanya.kulkarni@wdc.com> [logang@deltatee.com: fixed some of
 the wording in the help message] Signed-off-by: Logan Gunthorpe
 <logang@deltatee.com> Reviewed-by: Max Gurtovoy <maxg@mellanox.com>
Message-ID: <20191010123406.GC28921@lst.de>
References: <20191009192530.13079-1-logang@deltatee.com> <20191009192530.13079-6-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009192530.13079-6-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Just a first round of comments.

> The new file io-cmd-passthru.c handles passthru cmd parsing and execution.
> In the passthru mode, we create a block layer request from the nvmet
> request and map the data on to the block layer request. For handling the
> side effects of the passthru admin commands we add two functions similar
> to the nvme_passthru[start|end]() functions present in the nvme-core.
> Only admin commands on a white list are let through which includes
> vendor unique commands.

I think we need to do work in the core instead and offer a nvme_execute_rq
that handles all that work, and which also is used by the ioctl code.
While we're at it, nvme_submit_io seems to lack the
nvme_passthru_start/end handling, so we'd also fix that while we are at
it.

> @@ -896,6 +896,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
>  	if (unlikely(!req->sq->ctrl))
>  		/* will return an error for any Non-connect command: */
>  		status = nvmet_parse_connect_cmd(req);
> +	else if (nvmet_req_passthru_ctrl(req))
> +		status = nvmet_parse_passthru_cmd(req);
>  	else if (likely(req->sq->qid != 0))
>  		status = nvmet_parse_io_cmd(req);
>  	else if (nvme_is_fabrics(req->cmd))

This is turning into a mess (mostly not the fault of this patch, but
that is the final straw).  Moreover there is way to much magic in
nvmet_parse_passthru_cmd that we better share with the existing
code.  See the patch below for what I'd like to see.  This should
probably be split into a prep patch I can submit directly and the
passthrough bits on top of it.

> diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c

This file doesn't contains I/O command handling only, it should
be renamed to passthru.c

> +int nvmet_passthru_init(void)
> +{
> +	passthru_wq = alloc_workqueue("nvmet-passthru-wq", WQ_MEM_RECLAIM, 0);
> +	if (!passthru_wq)
> +		return -ENOMEM;
> +
> +	return 0;
> +}
> +
> +void nvmet_passthru_destroy(void)
> +{
> +	destroy_workqueue(passthru_wq);
> +}

Please keep the init/exit code at the end of the file.

> +
> +static void nvmet_passthru_req_complete(struct nvmet_req *req,
> +		struct request *rq, u16 status)
> +{
> +	nvmet_req_complete(req, status);
> +
> +	if (rq)
> +		blk_put_request(rq);
> +}

No real need for the empty line.  Also I can't see how rq could ever
be NULL here.  In fact I don't really see much of a point in this
helper - just calling the rwo functions directly makes the callers
easier to read for me personally.

> +
> +static void nvmet_passthru_req_done(struct request *rq,
> +		blk_status_t blk_status)
> +{
> +	struct nvmet_req *req = rq->end_io_data;
> +	u16 status = nvme_req(rq)->status;
> +
> +	req->cqe->result.u32 = nvme_req(rq)->result.u32;

This will lose any 64-bit results (not there yet, but we have
pending TPs).  Just assign the actual result union and we are safe
for any future additions.

> +static u16 nvmet_passthru_override_format_nvm(struct nvmet_req *req)
> +{
> +	int lbaf = le32_to_cpu(req->cmd->format.cdw10) & 0x0000000F;
> +	int nsid = le32_to_cpu(req->cmd->format.nsid);
> +	u16 status = NVME_SC_SUCCESS;
> +	struct nvme_id_ns *id;
> +	int ret;
> +
> +	ret = nvme_identify_ns(nvmet_req_passthru_ctrl(req), nsid, &id);
> +	if (ret)
> +		return NVME_SC_INTERNAL;
> +	/*
> +	 * XXX: Please update this code once NVMeOF target starts supporting
> +	 * metadata. We don't support ns lba format with metadata over fabrics
> +	 * right now, so report an error if format nvm cmd tries to format
> +	 * a namespace with the LBA format which has metadata.
> +	 */
> +	if (id->lbaf[lbaf].ms)
> +		status = NVME_SC_INVALID_NS;
> +
> +	kfree(id);
> +	return status;

We already filter out all formats with metadata in
nvmet_passthru_override_id_ns, so I see no point in rejecting
formats here that the host can't even have seen.

> +static void nvmet_passthru_set_mdts(struct nvmet_ctrl *ctrl,
> +				    struct nvme_id_ctrl *id)
> +{
> +	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
> +	u32 max_hw_sectors;
> +	int page_shift;
> +
> +	/*
> +	 * The passthru NVMe driver may have a limit on the number
> +	 * of segments which depends on the host's memory fragementation.
> +	 * To solve this, ensure mdts is limitted to the pages equal to
> +	 * the number of segments.
> +	 */
> +
> +	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
> +				      pctrl->max_hw_sectors);

No need for the blank line, and pleae use up all 80 chars for comments.

> +	nvmet_passthru_set_mdts(ctrl, id);

Any reason that is a separate function and not inlined here?

> +	/* don't support host memory buffer */
> +	id->hmpre = 0;
> +	id->hmmin = 0;

What about CMB/PMR?

> +	/*
> +	 * When passsthru controller is setup using nvme-loop transport it will
> +	 * export the passthru ctrl subsysnqn (PCIe NVMe ctrl) and will fail in
> +	 * the nvme/host/core.c in the nvme_init_subsystem()->nvme_active_ctrl()
> +	 * code path with duplicate ctr subsynqn. In order to prevent that we
> +	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
> +	 */
> +	memcpy(id->subnqn, ctrl->subsysnqn, sizeof(id->subnqn));

I don't think this is a good idea.  It will break multipathing when you
export two ports of the original controller.  The whole idea of
overwriting ctrlid and subsysnqn will also lead to huge problems with
persistent reservations.  I think we need to pass through the subnqn
and cntlid unmodified.

> +	/* Support multipath connections with fabrics */
> +	id->cmic |= 1 << 1;

I don't think we can just overwrite this, we need to use the original
controllers values.

> +	if (status)
> +		goto out_free;
> +
> +	for (i = 0; i < (id->nlbaf + 1); i++)
> +		if (id->lbaf[i].ms)
> +			memset(&id->lbaf[i], 0, sizeof(id->lbaf[i]));
> +
> +	id->flbas = id->flbas & ~(1 << 4);
> +	id->mc = 0;

This probably wants a similar annotation as all the other metadata
related bits.  Especially as Max is looking into metadata support for
RDMA, and people are working on PCIe frontends for the target code.

> +	/*
> +	 * Admin Commands have side effects and it is better to handle those
> +	 * side effects in the submission thread context than in the request
> +	 * completion path, which is in the interrupt context. Also in this
> +	 * way, we keep the passhru admin command code path consistent with the
> +	 * nvme/host/core.c sync command submission APIs/IOCTLs and use
> +	 * nvme_passthru_start/end() to handle side effects consistently.
> +	 */
> +	blk_execute_rq(req->p.rq->q, NULL, req->p.rq, 0);

Can we please only do the synchronous execution for the cases where
we actually need to override something.

> +static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
> +{
> +	int sg_cnt = req->sg_cnt;
> +	struct scatterlist *sg;
> +	int op = REQ_OP_READ;
> +	int op_flags = 0;
> +	struct bio *bio;
> +	int i, ret;
> +
> +	if (req->cmd->common.opcode == nvme_cmd_flush) {
> +		op_flags = REQ_FUA;
> +	} else if (nvme_is_write(req->cmd)) {
> +		op = REQ_OP_WRITE;
> +		op_flags = REQ_SYNC | REQ_IDLE;
> +	}

This looks weird.  Normally this should be REQ_OP_DRV_IN/REQ_OP_DRV_OUT.

> +	for_each_sg(req->sg, sg, req->sg_cnt, i) {
> +		if (bio_add_page(bio, sg_page(sg), sg->length,
> +				 sg->offset) != sg->length) {
> +			ret = blk_rq_append_bio(rq, &bio);
> +			if (unlikely(ret))
> +				return ret;
> +
> +			bio_set_op_attrs(bio, op, op_flags);

bio_set_op_attrs is deprecated, please just open code it.

> +	/*
> +	 * We don't support fused cmds, also nvme-pci driver uses its own
> +	 * sgl_threshold parameter to decide whether to use SGLs or PRPs hence
> +	 * turn off those bits in the flags.
> +	 */
> +	req->cmd->common.flags &= ~(NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND |
> +			NVME_CMD_SGL_ALL);

I think this belongs into nvme_setup_cmd as is affects all pass
through commands.

> +	rq = nvmet_passthru_blk_make_request(req, ns, GFP_KERNEL);
> +	if (unlikely(IS_ERR(rq))) {

IS_ERR contains an implicitl unlikely.  But I also don't see why
nvmet_passthru_blk_make_request even exists.  Merging it into the
caller would seems more reasonable to me.

> +	if (unlikely(blk_rq_nr_phys_segments(rq) > queue_max_segments(rq->q) ||
> +	    (blk_rq_payload_bytes(rq) >> 9) > queue_max_hw_sectors(rq->q))) {

I' split the two unrelated checks into two if statements for
readability.

> +	case nvme_admin_set_features:
> +		switch (le32_to_cpu(req->cmd->features.fid)) {
> +		case NVME_FEAT_ASYNC_EVENT:
> +		case NVME_FEAT_KATO:
> +		case NVME_FEAT_NUM_QUEUES:
> +			status = nvmet_parse_admin_cmd(req);
> +			break;
> +		default:
> +			req->execute = nvmet_passthru_execute_cmd;
> +		}
> +		break;

We'll need to treat get_features equally.

> +	/* 4. By default, blacklist all admin commands */
> +	default:
> +
> +		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
> +		req->execute = NULL;
> +		break;
> +	}

That seems odd.  There is plenty of other useful admin commands.

Yes, we need to ignore the PCIe specific ones:

 - Create I/O Completion Queue
 - Create I/O Submission Queue
 - Delete I/O Completion Queue
 - Delete I/O Submission Queue
 - Doorbell Buffer Configuration
 - Virtualization Management

but all others seem perfectly valid to pass through.

>  /* Convert a 32-bit number to a 16-bit 0's based number */
> diff --git a/include/linux/nvme.h b/include/linux/nvme.h
> index f61d6906e59d..94e730b5d0a3 100644
> --- a/include/linux/nvme.h
> +++ b/include/linux/nvme.h
> @@ -816,6 +816,7 @@ enum nvme_admin_opcode {
>  	nvme_admin_security_recv	= 0x82,
>  	nvme_admin_sanitize_nvm		= 0x84,
>  	nvme_admin_get_lba_status	= 0x86,
> +	nvme_admin_vendor_unique_start	= 0xC0,

They are called vendor specific commands.

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 67b6642bb628..de24c140b547 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -652,7 +652,7 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 	return 0;
 }
 
-static void nvmet_execute_set_features(struct nvmet_req *req)
+void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
@@ -813,10 +813,18 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	struct nvme_command *cmd = req->cmd;
 	u16 ret;
 
+	if (nvme_is_fabrics(cmd))
+		return nvmet_parse_fabrics_cmd(req);
+	if (req->sq->ctrl->subsys->type == NVME_NQN_DISC)
+		return nvmet_parse_discovery_cmd(req);
+
 	ret = nvmet_check_ctrl_status(req, cmd);
 	if (unlikely(ret))
 		return ret;
 
+	if (nvmet_req_passthru_ctrl(req))
+		return nvmet_parse_passthru_admin_cmd(req);
+
 	switch (cmd->common.opcode) {
 	case nvme_admin_get_log_page:
 		req->data_len = nvmet_get_log_page_len(cmd);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f9d46354f9ae..3a5b7e42a158 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -839,6 +839,9 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (unlikely(ret))
 		return ret;
 
+	if (nvmet_req_passthru_ctrl(req))
+		return nvmet_setup_passthru_command(req);
+
 	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
@@ -900,16 +903,10 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	}
 
 	if (unlikely(!req->sq->ctrl))
-		/* will return an error for any Non-connect command: */
+		/* will return an error for any non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
-	else if (nvmet_req_passthru_ctrl(req))
-		status = nvmet_parse_passthru_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
-	else if (nvme_is_fabrics(req->cmd))
-		status = nvmet_parse_fabrics_cmd(req);
-	else if (req->sq->ctrl->subsys->type == NVME_NQN_DISC)
-		status = nvmet_parse_discovery_cmd(req);
 	else
 		status = nvmet_parse_admin_cmd(req);
 
diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
index 37d06ebcbd0f..fbf3508ea8ea 100644
--- a/drivers/nvme/target/io-cmd-passthru.c
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -557,6 +557,12 @@ static void nvmet_passthru_emulate_id_desclist(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+u16 nvmet_setup_passthru_command(struct nvmet_req *req)
+{
+	req->execute = nvmet_passthru_execute_cmd;
+	return NVME_SC_SUCCESS;
+}
+
 /*
  * In the passthru mode we support three types for commands:-
  * 1. Commands which are black-listed.
@@ -564,84 +570,55 @@ static void nvmet_passthru_emulate_id_desclist(struct nvmet_req *req)
  * 3. Commands which are emulated in the target code, since we can't rely
  *    on passthru-ctrl and cannot route through the target code.
  */
-static u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
+u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
-	u16 status = 0;
 
-	if (cmd->common.opcode >= nvme_admin_vendor_unique_start) {
-		/*
-		 * Passthru all vendor unique commands
-		 */
-		req->execute = nvmet_passthru_execute_cmd;
-		return status;
-	}
+	/*
+	 * Passthru all vendor unique commands
+	 */
+	if (cmd->common.opcode >= nvme_admin_vendor_unique_start)
+		return nvmet_setup_passthru_command(req);
 
 	switch (cmd->common.opcode) {
-	/* 2. commands which are routed through target code */
 	case nvme_admin_async_event:
-	/*
-	 * Right now we don't monitor any events for the passthru controller.
-	 * Instead generate asyn event notice for the ns-mgmt/format/attach
-	 * commands so that host can update it's ns-inventory.
-	 */
-		/* fallthru */
+		req->execute = nvmet_execute_async_event;
+		req->data_len = 0;
+		return 0;
 	case nvme_admin_keep_alive:
-	/*
-	 * Most PCIe ctrls don't support keep alive cmd, we route keep alive
-	 * to the non-passthru mode. In future please change this code when
-	 * PCIe ctrls with keep alive support available.
-	 */
-		status = nvmet_parse_admin_cmd(req);
-		break;
+		/*
+		 * Most PCIe ctrls don't support keep alive cmd, we route keep
+		 * alive to the non-passthru mode. In future please change this
+		 * code when PCIe ctrls with keep alive support available.
+		 */
+		req->execute = nvmet_execute_keep_alive;
+		req->data_len = 0;
+		return 0;
 	case nvme_admin_set_features:
 		switch (le32_to_cpu(req->cmd->features.fid)) {
 		case NVME_FEAT_ASYNC_EVENT:
 		case NVME_FEAT_KATO:
 		case NVME_FEAT_NUM_QUEUES:
-			status = nvmet_parse_admin_cmd(req);
-			break;
+			/* XXX: we'll need to do the same for get_features! */
+			req->execute = nvmet_execute_set_features;
+			req->data_len = 0;
+			return 0;
 		default:
-			req->execute = nvmet_passthru_execute_cmd;
+			return nvmet_setup_passthru_command(req);
 		}
 		break;
-	/* 3. commands which are emulated in the passthru code */
 	case nvme_admin_identify:
 		switch (req->cmd->identify.cns) {
 		case NVME_ID_CNS_NS_DESC_LIST:
 			req->execute = nvmet_passthru_emulate_id_desclist;
-			break;
+			req->data_len = 0;
+			return 0;
 		default:
-			req->execute = nvmet_passthru_execute_cmd;
+			return nvmet_setup_passthru_command(req);
 		}
 		break;
-	/* 4. By default, blacklist all admin commands */
 	default:
-
-		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
-		req->execute = NULL;
-		break;
+		/* By default, blacklist all admin commands */
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
 	}
-
-	return status;
-}
-
-u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
-{
-	int ret;
-
-	if (unlikely(req->cmd->common.opcode == nvme_fabrics_command))
-		return nvmet_parse_fabrics_cmd(req);
-	else if (unlikely(req->sq->ctrl->subsys->type == NVME_NQN_DISC))
-		return nvmet_parse_discovery_cmd(req);
-
-	ret = nvmet_check_ctrl_status(req, req->cmd);
-	if (unlikely(ret))
-		return ret;
-
-	if (unlikely(req->sq->qid == 0))
-		return nvmet_parse_passthru_admin_cmd(req);
-
-	req->execute = nvmet_passthru_execute_cmd;
-	return NVME_SC_SUCCESS;
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ba7690979661..200ec07507cd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -390,6 +390,7 @@ void nvmet_req_complete(struct nvmet_req *req, u16 status);
 int nvmet_req_alloc_sgl(struct nvmet_req *req);
 void nvmet_req_free_sgl(struct nvmet_req *req);
 
+void nvmet_execute_set_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
 
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
@@ -508,22 +509,19 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 }
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
-
 int nvmet_passthru_init(void);
 void nvmet_passthru_destroy(void);
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
 void nvmet_passthru_ctrl_disable(struct nvmet_subsys *subsys);
-u16 nvmet_parse_passthru_cmd(struct nvmet_req *req);
+u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req);
+u16 nvmet_setup_passthru_command(struct nvmet_req *req);
 
-static inline
-struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
+static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
 {
 	return subsys->passthru_ctrl;
 }
-
 #else /* CONFIG_NVME_TARGET_PASSTHRU */
-
 static inline int nvmet_passthru_init(void)
 {
 	return 0;
@@ -541,12 +539,10 @@ static inline u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
 {
 	return 0;
 }
-static inline
-struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
+static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
 {
 	return NULL;
 }
-
 #endif /* CONFIG_NVME_TARGET_PASSTHRU */
 
 static inline struct nvme_ctrl *nvmet_req_passthru_ctrl(struct nvmet_req *req)
