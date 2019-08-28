Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A239EA0CD8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 23:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfH1Vym (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 17:54:42 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46456 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727122AbfH1Vyk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 17:54:40 -0400
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35tj-00071h-NP; Wed, 28 Aug 2019 15:54:38 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1i35ti-0001Cy-Km; Wed, 28 Aug 2019 15:54:34 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Wed, 28 Aug 2019 15:54:22 -0600
Message-Id: <20190828215429.4572-7-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190828215429.4572-1-logang@deltatee.com>
References: <20190828215429.4572-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de, sagi@grimberg.me, kbusch@kernel.org, axboe@fb.com, maxg@mellanox.com, sbates@raithlin.com, Chaitanya.Kulkarni@wdc.com, chaitanya.kulkarni@wdc.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE,MYRULES_NO_TEXT autolearn=ham
        autolearn_force=no version=3.4.2
Subject: [PATCH v8 06/13] nvmet-passthru: add passthru code to process commands
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>

Add passthru command handling capability for the NVMeOF target and
export passthru APIs which are used to integrate passthru
code with nvmet-core. A passthru ns member is added to the target request
to hold the ns reference for respective commands.

The new file io-cmd-passthru.c handles passthru cmd parsing and execution.
In the passthru mode, we create a block layer request from the nvmet
request and map the data on to the block layer request. For handling the
side effects of the passthru admin commands we add two functions similar
to the nvme_passthru[start|end]() functions present in the nvme-core.
Only admin commands on a white list are let through which includes
vendor unique commands.

We introduce new passthru workqueue similar to the one we have for the
file backend for NVMeOF target to execute the NVMe Admin passthru
commands.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
[logang@deltatee.com:
   * renamed passthru-cmd.c to io-cmd-passthru.c for consistency
   * squashed "update target makefile for passthru"
   * squashed "integrate passthru request processing"
   * added appropriate CONFIG_NVME_TARGET_PASSTHRU #ifdefs
   * pushed passthru_wq into passthrtu.c and introduced
     nvmet_passthru_init() and nvmet_passthru_destroy() to avoid
     inline #ifdef mess
   * renamed nvmet_passthru_ctrl() to nvmet_req_passthru_ctrl()
     and provided nvmet_passthr_ctrl() to get the ctrl from a subsys
   * fixed failure path in nvmet_passthru_execute_cmd() to ensure
     we always complete the request (with an error when appropriate)
   * restructered out nvmet_passthru_make_request() and
     nvmet_passthru_execute_cmd() to create nvmet_passthru_map_sg()
     which makes the code simpler and more readable.
   * move call to nvme_find_get_ns() into nvmet_passthru_execute_cmd()
     to prevent a lockdep error. nvme_find_get_ns() takes a
     lock and can sleep but nvme_init_req() is called while
     hctx_lock() is held (in the loop transport) and therefore
     should not sleep.
   * added check in nvmet_passthru_execute_cmd() to ensure we don't
     violate queue_max_segments or queue_max_hw_sectors.
   * added nvmet_passthru_set_mdts() to prevent requests that
     exceed max_segments
   * convert admin command blacklist to a white list with vendor
     unique commands specifically allowed
   * force setting cmic bit to support multipath for connections
     to the target
   * dropped le16_to_cpu() conversion in nvmet_passthru_req_done() as
     it's currently already done in nvme_end_request()
   * unabbreviated 'VUC' in a comment as it's not a commonly known
     acronym
   * removed unnecessary inline tags on static functions
   * minor edits to commit message
]
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/nvme/target/Makefile          |   1 +
 drivers/nvme/target/core.c            |  11 +-
 drivers/nvme/target/io-cmd-passthru.c | 564 ++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h           |  46 +++
 include/linux/nvme.h                  |   1 +
 5 files changed, 622 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/io-cmd-passthru.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index 2b33836f3d3e..bf57799fde63 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
 			discovery.o io-cmd-file.o io-cmd-bdev.o
+nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= io-cmd-passthru.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
 nvmet-fc-y	+= fc.o
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d6dcb86d8be7..256f765e772b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -896,6 +896,8 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	if (unlikely(!req->sq->ctrl))
 		/* will return an error for any Non-connect command: */
 		status = nvmet_parse_connect_cmd(req);
+	else if (nvmet_req_passthru_ctrl(req))
+		status = nvmet_parse_passthru_cmd(req);
 	else if (likely(req->sq->qid != 0))
 		status = nvmet_parse_io_cmd(req);
 	else if (nvme_is_fabrics(req->cmd))
@@ -1463,11 +1465,15 @@ static int __init nvmet_init(void)
 
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
+	error = nvmet_passthru_init();
+	if (error)
+		goto out;
+
 	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
 			WQ_MEM_RECLAIM, 0);
 	if (!buffered_io_wq) {
 		error = -ENOMEM;
-		goto out;
+		goto out_passthru_destroy;
 	}
 
 	error = nvmet_init_discovery();
@@ -1483,6 +1489,8 @@ static int __init nvmet_init(void)
 	nvmet_exit_discovery();
 out_free_work_queue:
 	destroy_workqueue(buffered_io_wq);
+out_passthru_destroy:
+	nvmet_passthru_destroy();
 out:
 	return error;
 }
@@ -1493,6 +1501,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_discovery();
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(buffered_io_wq);
+	nvmet_passthru_destroy();
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/io-cmd-passthru.c b/drivers/nvme/target/io-cmd-passthru.c
new file mode 100644
index 000000000000..2437fc0a74a4
--- /dev/null
+++ b/drivers/nvme/target/io-cmd-passthru.c
@@ -0,0 +1,564 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe Over Fabrics Target Passthrough command implementation.
+ *
+ * Copyright (c) 2017-2018 Western Digital Corporation or its
+ * affiliates.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
+
+#include "../host/nvme.h"
+#include "nvmet.h"
+
+static struct workqueue_struct *passthru_wq;
+
+int nvmet_passthru_init(void)
+{
+	passthru_wq = alloc_workqueue("nvmet-passthru-wq", WQ_MEM_RECLAIM, 0);
+	if (!passthru_wq)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void nvmet_passthru_destroy(void)
+{
+	destroy_workqueue(passthru_wq);
+}
+
+static void nvmet_passthru_req_complete(struct nvmet_req *req,
+		struct request *rq, u16 status)
+{
+	nvmet_req_complete(req, status);
+
+	if (rq)
+		blk_put_request(rq);
+}
+
+static void nvmet_passthru_req_done(struct request *rq,
+		blk_status_t blk_status)
+{
+	struct nvmet_req *req = rq->end_io_data;
+	u16 status = nvme_req(rq)->status;
+
+	req->cqe->result.u32 = nvme_req(rq)->result.u32;
+
+	nvmet_passthru_req_complete(req, rq, status);
+}
+
+static u16 nvmet_passthru_override_format_nvm(struct nvmet_req *req)
+{
+	int lbaf = le32_to_cpu(req->cmd->format.cdw10) & 0x0000000F;
+	int nsid = le32_to_cpu(req->cmd->format.nsid);
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_id_ns *id;
+
+	id = nvme_identify_ns(nvmet_req_passthru_ctrl(req), nsid);
+	if (!id)
+		return NVME_SC_INTERNAL;
+	/*
+	 * XXX: Please update this code once NVMeOF target starts supporting
+	 * metadata. We don't support ns lba format with metadata over fabrics
+	 * right now, so report an error if format nvm cmd tries to format
+	 * a namespace with the LBA format which has metadata.
+	 */
+	if (id->lbaf[lbaf].ms)
+		status = NVME_SC_INVALID_NS;
+
+	kfree(id);
+	return status;
+}
+
+static void nvmet_passthru_set_mdts(struct nvmet_ctrl *ctrl,
+				    struct nvme_id_ctrl *id)
+{
+	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
+	u32 max_hw_sectors;
+	int page_shift;
+
+	/*
+	 * The passthru NVMe driver may have a limit on the number
+	 * of segments which depends on the host's memory fragementation.
+	 * To solve this, ensure mdts is limitted to the pages equal to
+	 * the number of segments.
+	 */
+
+	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
+				      pctrl->max_hw_sectors);
+
+	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
+
+	id->mdts = ilog2(max_hw_sectors) + 9 - page_shift;
+}
+
+static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_id_ctrl *id;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+	status = nvmet_copy_from_sgl(req, 0, id, sizeof(*id));
+	if (status)
+		goto out_free;
+
+	id->cntlid = cpu_to_le16(ctrl->cntlid);
+	id->ver = cpu_to_le32(ctrl->subsys->ver);
+
+	nvmet_passthru_set_mdts(ctrl, id);
+
+	id->acl = 3;
+	/*
+	 * We export aerl limit for the fabrics controller, update this when
+	 * passthru based aerl support is added.
+	 */
+	id->aerl = NVMET_ASYNC_EVENTS - 1;
+
+	/* emulate kas as most of the PCIe ctrl don't have a support for kas */
+	id->kas = cpu_to_le16(NVMET_KAS);
+
+	/* don't support host memory buffer */
+	id->hmpre = 0;
+	id->hmmin = 0;
+
+	id->sqes = min_t(__u8, ((0x6 << 4) | 0x6), id->sqes);
+	id->cqes = min_t(__u8, ((0x4 << 4) | 0x4), id->cqes);
+	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
+
+	/* don't support fuse commands */
+	id->fuses = 0;
+
+	id->sgls = cpu_to_le32(1 << 0); /* we always support SGLs */
+	if (ctrl->ops->has_keyed_sgls)
+		id->sgls |= cpu_to_le32(1 << 2);
+	if (req->port->inline_data_size)
+		id->sgls |= cpu_to_le32(1 << 20);
+
+	/*
+	 * When passsthru controller is setup using nvme-loop transport it will
+	 * export the passthru ctrl subsysnqn (PCIe NVMe ctrl) and will fail in
+	 * the nvme/host/core.c in the nvme_init_subsystem()->nvme_active_ctrl()
+	 * code path with duplicate ctr subsynqn. In order to prevent that we
+	 * mask the passthru-ctrl subsysnqn with the target ctrl subsysnqn.
+	 */
+	memcpy(id->subnqn, ctrl->subsysnqn, sizeof(id->subnqn));
+
+	/* use fabric id-ctrl values */
+	id->ioccsz = cpu_to_le32((sizeof(struct nvme_command) +
+				req->port->inline_data_size) / 16);
+	id->iorcsz = cpu_to_le32(sizeof(struct nvme_completion) / 16);
+
+	id->msdbd = ctrl->ops->msdbd;
+
+	/* Support multipath connections with fabrics */
+	id->cmic |= 1 << 1;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(struct nvme_id_ctrl));
+
+out_free:
+	kfree(id);
+out:
+	return status;
+}
+
+static u16 nvmet_passthru_override_id_ns(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_id_ns *id;
+	int i;
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, id, sizeof(struct nvme_id_ns));
+	if (status)
+		goto out_free;
+
+	for (i = 0; i < (id->nlbaf + 1); i++)
+		if (id->lbaf[i].ms)
+			memset(&id->lbaf[i], 0, sizeof(id->lbaf[i]));
+
+	id->flbas = id->flbas & ~(1 << 4);
+	id->mc = 0;
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+
+out_free:
+	kfree(id);
+out:
+	return status;
+}
+
+static u16 nvmet_passthru_fixup_identify(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+
+	switch (req->cmd->identify.cns) {
+	case NVME_ID_CNS_CTRL:
+		status = nvmet_passthru_override_id_ctrl(req);
+		break;
+	case NVME_ID_CNS_NS:
+		status = nvmet_passthru_override_id_ns(req);
+		break;
+	}
+	return status;
+}
+
+static u16 nvmet_passthru_admin_passthru_start(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+
+	switch (req->cmd->common.opcode) {
+	case nvme_admin_format_nvm:
+		status = nvmet_passthru_override_format_nvm(req);
+		break;
+	}
+	return status;
+}
+
+static u16 nvmet_passthru_admin_passthru_end(struct nvmet_req *req)
+{
+	u8 aer_type = NVME_AER_TYPE_NOTICE;
+	u16 status = NVME_SC_SUCCESS;
+
+	switch (req->cmd->common.opcode) {
+	case nvme_admin_identify:
+		status = nvmet_passthru_fixup_identify(req);
+		break;
+	case nvme_admin_ns_mgmt:
+	case nvme_admin_ns_attach:
+	case nvme_admin_format_nvm:
+		if (nvmet_add_async_event(req->sq->ctrl, aer_type, 0, 0))
+			status = NVME_SC_INTERNAL;
+		break;
+	}
+	return status;
+}
+
+static void nvmet_passthru_execute_admin_cmd(struct nvmet_req *req)
+{
+	u8 opcode = req->cmd->common.opcode;
+	u32 effects;
+	u16 status;
+
+	status = nvmet_passthru_admin_passthru_start(req);
+	if (status)
+		goto out;
+
+	effects = nvme_passthru_start(nvmet_req_passthru_ctrl(req), NULL,
+				      opcode);
+
+	/*
+	 * Admin Commands have side effects and it is better to handle those
+	 * side effects in the submission thread context than in the request
+	 * completion path, which is in the interrupt context. Also in this
+	 * way, we keep the passhru admin command code path consistent with the
+	 * nvme/host/core.c sync command submission APIs/IOCTLs and use
+	 * nvme_passthru_start/end() to handle side effects consistently.
+	 */
+	blk_execute_rq(req->p.rq->q, NULL, req->p.rq, 0);
+
+	nvme_passthru_end(nvmet_req_passthru_ctrl(req), effects);
+	status = nvmet_passthru_admin_passthru_end(req);
+out:
+	if (status == NVME_SC_SUCCESS) {
+		nvmet_set_result(req, nvme_req(req->p.rq)->result.u32);
+		status = nvme_req(req->p.rq)->status;
+	}
+
+	nvmet_passthru_req_complete(req, req->p.rq, status);
+}
+
+static int nvmet_passthru_map_sg(struct nvmet_req *req, struct request *rq)
+{
+	int sg_cnt = req->sg_cnt;
+	struct scatterlist *sg;
+	int op = REQ_OP_READ;
+	int op_flags = 0;
+	struct bio *bio;
+	int i, ret;
+
+	if (nvme_is_write(req->cmd)) {
+		op = REQ_OP_WRITE;
+		op_flags = REQ_SYNC | REQ_IDLE;
+	}
+
+	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	bio->bi_end_io = bio_put;
+
+	for_each_sg(req->sg, sg, req->sg_cnt, i) {
+		if (bio_add_page(bio, sg_page(sg), sg->length,
+				 sg->offset) != sg->length) {
+			ret = blk_rq_append_bio(rq, &bio);
+			if (unlikely(ret))
+				return ret;
+
+			bio_set_op_attrs(bio, op, op_flags);
+			bio = bio_alloc(GFP_KERNEL,
+					min(sg_cnt, BIO_MAX_PAGES));
+		}
+		sg_cnt--;
+	}
+
+	ret = blk_rq_append_bio(rq, &bio);
+	if (unlikely(ret))
+		return ret;
+
+	return 0;
+}
+
+static struct request *nvmet_passthru_blk_make_request(struct nvmet_req *req,
+		struct nvme_ns *ns, gfp_t gfp_mask)
+{
+	struct nvme_ctrl *passthru_ctrl = nvmet_req_passthru_ctrl(req);
+	struct nvme_command *cmd = req->cmd;
+	struct request_queue *q;
+	struct request *rq;
+	int ret;
+
+	if (ns)
+		q = ns->queue;
+	else
+		q = passthru_ctrl->admin_q;
+
+	rq = nvme_alloc_request(q, cmd, BLK_MQ_REQ_NOWAIT, NVME_QID_ANY);
+	if (unlikely(IS_ERR(rq)))
+		return rq;
+
+	if (req->sg_cnt) {
+		ret = nvmet_passthru_map_sg(req, rq);
+		if (unlikely(ret)) {
+			blk_put_request(rq);
+			return ERR_PTR(ret);
+		}
+	}
+
+	/*
+	 * We don't support fused cmds, also nvme-pci driver uses its own
+	 * sgl_threshold parameter to decide whether to use SGLs or PRPs hence
+	 * turn off those bits in the flags.
+	 */
+	req->cmd->common.flags &= ~(NVME_CMD_FUSE_FIRST | NVME_CMD_FUSE_SECOND |
+			NVME_CMD_SGL_ALL);
+	return rq;
+}
+
+
+static void nvmet_passthru_execute_admin_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, p.work);
+
+	nvmet_passthru_execute_admin_cmd(req);
+}
+
+static void nvmet_passthru_submit_admin_cmd(struct nvmet_req *req)
+{
+	INIT_WORK(&req->p.work, nvmet_passthru_execute_admin_work);
+	queue_work(passthru_wq, &req->p.work);
+}
+
+static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
+{
+	struct request *rq = NULL;
+	struct nvme_ns *ns = NULL;
+	u16 status;
+
+	if (likely(req->sq->qid != 0)) {
+		u32 nsid = le32_to_cpu(req->cmd->common.nsid);
+
+		ns = nvme_find_get_ns(nvmet_req_passthru_ctrl(req), nsid);
+		if (unlikely(!ns)) {
+			pr_err("failed to get passthru ns nsid:%u\n", nsid);
+			status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+			goto fail_out;
+		}
+	}
+
+	rq = nvmet_passthru_blk_make_request(req, ns, GFP_KERNEL);
+	if (unlikely(IS_ERR(rq))) {
+		rq = NULL;
+		status = NVME_SC_INTERNAL;
+		goto fail_out;
+	}
+
+	if (unlikely(blk_rq_nr_phys_segments(rq) > queue_max_segments(rq->q) ||
+	    (blk_rq_payload_bytes(rq) >> 9) > queue_max_hw_sectors(rq->q))) {
+		status = NVME_SC_INVALID_FIELD;
+		goto fail_out;
+	}
+
+	rq->end_io_data = req;
+	if (req->sq->qid != 0) {
+		blk_execute_rq_nowait(rq->q, NULL, rq, 0,
+				      nvmet_passthru_req_done);
+	} else {
+		req->p.rq = rq;
+		nvmet_passthru_submit_admin_cmd(req);
+	}
+
+	if (ns)
+		nvme_put_ns(ns);
+
+	return;
+
+fail_out:
+	if (ns)
+		nvme_put_ns(ns);
+	nvmet_passthru_req_complete(req, rq, status);
+}
+
+/*
+ * We emulate commands which are not routed through the existing target
+ * code and not supported by the passthru ctrl. E.g consider a scenario where
+ * passthru ctrl version is < 1.3.0. Target Fabrics ctrl version is >= 1.3.0
+ * in that case in order to be fabrics compliant we need to emulate ns-desc-list
+ * command which is 1.3.0 compliant but not present for the passthru ctrl due
+ * to lower version.
+ */
+static void nvmet_passthru_emulate_id_desclist(struct nvmet_req *req)
+{
+	int nsid = le32_to_cpu(req->cmd->common.nsid);
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_ns_ids *ids;
+	struct nvme_ns *ns;
+	off_t off = 0;
+
+	ns = nvme_find_get_ns(nvmet_req_passthru_ctrl(req), nsid);
+	if (unlikely(!ns)) {
+		pr_err("failed to get passthru ns nsid:%u\n", nsid);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+	/*
+	 * Instead of refactoring and creating helpers, keep it simple and
+	 * just re-use the code from admin-cmd.c ->
+	 * nvmet_execute_identify_ns_desclist().
+	 */
+	ids = &ns->head->ids;
+	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64))) {
+		status = nvmet_copy_ns_identifier(req, NVME_NIDT_EUI64,
+						  NVME_NIDT_EUI64_LEN,
+						  &ids->eui64, &off);
+		if (status)
+			goto out_put_ns;
+	}
+	if (memchr_inv(&ids->uuid, 0, sizeof(ids->uuid))) {
+		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
+						  NVME_NIDT_UUID_LEN,
+						  &ids->uuid, &off);
+		if (status)
+			goto out_put_ns;
+	}
+	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid))) {
+		status = nvmet_copy_ns_identifier(req, NVME_NIDT_NGUID,
+						  NVME_NIDT_NGUID_LEN,
+						  &ids->nguid, &off);
+		if (status)
+			goto out_put_ns;
+	}
+
+	if (sg_zero_buffer(req->sg, req->sg_cnt, NVME_IDENTIFY_DATA_SIZE - off,
+			off) != NVME_IDENTIFY_DATA_SIZE - off)
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+out_put_ns:
+	nvme_put_ns(ns);
+out:
+	nvmet_req_complete(req, status);
+}
+
+/*
+ * In the passthru mode we support three types for commands:-
+ * 1. Commands which are black-listed.
+ * 2. Commands which are routed through target code.
+ * 3. Commands which are emulated in the target code, since we can't rely
+ *    on passthru-ctrl and cannot route through the target code.
+ */
+static u16 nvmet_parse_passthru_admin_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+	u16 status = 0;
+
+	if (cmd->common.opcode >= nvme_admin_vendor_unique_start) {
+		/*
+		 * Passthru all vendor unique commands
+		 */
+		req->execute = nvmet_passthru_execute_cmd;
+		return status;
+	}
+
+	switch (cmd->common.opcode) {
+	/* 2. commands which are routed through target code */
+	case nvme_admin_async_event:
+	/*
+	 * Right now we don't monitor any events for the passthru controller.
+	 * Instead generate asyn event notice for the ns-mgmt/format/attach
+	 * commands so that host can update it's ns-inventory.
+	 */
+		/* fallthru */
+	case nvme_admin_keep_alive:
+	/*
+	 * Most PCIe ctrls don't support keep alive cmd, we route keep alive
+	 * to the non-passthru mode. In future please change this code when
+	 * PCIe ctrls with keep alive support available.
+	 */
+		status = nvmet_parse_admin_cmd(req);
+		break;
+	case nvme_admin_set_features:
+		switch (le32_to_cpu(req->cmd->features.fid)) {
+		case NVME_FEAT_ASYNC_EVENT:
+		case NVME_FEAT_KATO:
+		case NVME_FEAT_NUM_QUEUES:
+			status = nvmet_parse_admin_cmd(req);
+			break;
+		default:
+			req->execute = nvmet_passthru_execute_cmd;
+		}
+		break;
+	/* 3. commands which are emulated in the passthru code */
+	case nvme_admin_identify:
+		switch (req->cmd->identify.cns) {
+		case NVME_ID_CNS_NS_DESC_LIST:
+			req->execute = nvmet_passthru_emulate_id_desclist;
+			break;
+		default:
+			req->execute = nvmet_passthru_execute_cmd;
+		}
+		break;
+	/* 4. By default, blacklist all admin commands */
+	default:
+
+		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		req->execute = NULL;
+		break;
+	}
+
+	return status;
+}
+
+u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
+{
+	int ret;
+
+	if (unlikely(req->cmd->common.opcode == nvme_fabrics_command))
+		return nvmet_parse_fabrics_cmd(req);
+	else if (unlikely(req->sq->ctrl->subsys->type == NVME_NQN_DISC))
+		return nvmet_parse_discovery_cmd(req);
+
+	ret = nvmet_check_ctrl_status(req, req->cmd);
+	if (unlikely(ret))
+		return ret;
+
+	if (unlikely(req->sq->qid == 0))
+		return nvmet_parse_passthru_admin_cmd(req);
+
+	req->execute = nvmet_passthru_execute_cmd;
+	return NVME_SC_SUCCESS;
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 5dfd4e0ae096..daec1240307c 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -227,6 +227,10 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+	struct nvme_ctrl	*passthru_ctrl;
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
@@ -302,6 +306,10 @@ struct nvmet_req {
 			struct bio_vec          *bvec;
 			struct work_struct      work;
 		} f;
+		struct {
+			struct request		*rq;
+			struct work_struct      work;
+		} p;
 	};
 	int			sg_cnt;
 	/* data length as parsed from the command: */
@@ -497,6 +505,44 @@ static inline u32 nvmet_rw_len(struct nvmet_req *req)
 			req->ns->blksize_shift;
 }
 
+#ifdef CONFIG_NVME_TARGET_PASSTHRU
+
+int nvmet_passthru_init(void);
+void nvmet_passthru_destroy(void);
+u16 nvmet_parse_passthru_cmd(struct nvmet_req *req);
+
+static inline
+struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
+{
+	return subsys->passthru_ctrl;
+}
+
+#else /* CONFIG_NVME_TARGET_PASSTHRU */
+
+static inline int nvmet_passthru_init(void)
+{
+	return 0;
+}
+static inline void nvmet_passthru_destroy(void)
+{
+}
+static inline u16 nvmet_parse_passthru_cmd(struct nvmet_req *req)
+{
+	return 0;
+}
+static inline
+struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
+{
+	return NULL;
+}
+
+#endif /* CONFIG_NVME_TARGET_PASSTHRU */
+
+static inline struct nvme_ctrl *nvmet_req_passthru_ctrl(struct nvmet_req *req)
+{
+	return nvmet_passthru_ctrl(req->sq->ctrl->subsys);
+}
+
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 
 /* Convert a 32-bit number to a 16-bit 0's based number */
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6c241d..ecbf9d9485b5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -814,6 +814,7 @@ enum nvme_admin_opcode {
 	nvme_admin_security_send	= 0x81,
 	nvme_admin_security_recv	= 0x82,
 	nvme_admin_sanitize_nvm		= 0x84,
+	nvme_admin_vendor_unique_start	= 0xC0,
 };
 
 #define nvme_admin_opcode_name(opcode)	{ opcode, #opcode }
-- 
2.20.1

