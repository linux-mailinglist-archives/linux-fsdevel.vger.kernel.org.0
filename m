Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EF04A63F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 19:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241827AbiBASdh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 13:33:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:47576 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241833AbiBASdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643740415;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=//kog2s09td3mH9/Rkgjf+3auO0U/6/qyxFnJYJIMUo=;
        b=aXXNP4GM4X+dOVF54aG6rEdDzDlSLdDDg9Xa2tYPWpeBwteOdcEf2CsDGm/zQjEL7V166E
        +YdTlIUnfRx2GbcXt30eCAqPelfc0Z6Sil7A8bMG7ysLmD35Goh7ohgACOSTL/9dFhc1+K
        lPa6zOEGUwFyQN59HkRPCpzoMmkjjfw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-17-0hEBCDwdMPmLt4hplaJ1vA-1; Tue, 01 Feb 2022 13:33:32 -0500
X-MC-Unique: 0hEBCDwdMPmLt4hplaJ1vA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CDF811927820;
        Tue,  1 Feb 2022 18:33:20 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2752234D41;
        Tue,  1 Feb 2022 18:33:13 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 211IXCsI019523;
        Tue, 1 Feb 2022 13:33:12 -0500
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 211IXCnq019519;
        Tue, 1 Feb 2022 13:33:12 -0500
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Tue, 1 Feb 2022 13:33:12 -0500 (EST)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     =?ISO-8859-15?Q?Javier_Gonz=E1lez?= <javier@javigon.com>
cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "msnitzer@redhat.com >> msnitzer@redhat.com" <msnitzer@redhat.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "martin.petersen@oracle.com >> Martin K. Petersen" 
        <martin.petersen@oracle.com>,
        "roland@purestorage.com" <roland@purestorage.com>,
        Hannes Reinecke <hare@suse.de>,
        "kbus @imap.gmail.com>> Keith Busch" <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Frederick.Knight@netapp.com" <Frederick.Knight@netapp.com>,
        "zach.brown@ni.com" <zach.brown@ni.com>,
        "osandov@fb.com" <osandov@fb.com>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "tytso@mit.edu" <tytso@mit.edu>, "jack@suse.com" <jack@suse.com>,
        Kanchan Joshi <joshi.k@samsung.com>
Subject: [RFC PATCH 2/3] nvme: add copy offload support
In-Reply-To: <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2202011332330.22481@file01.intranet.prod.int.rdu2.redhat.com>
References: <f0e19ae4-b37a-e9a3-2be7-a5afb334a5c3@nvidia.com> <20220201102122.4okwj2gipjbvuyux@mpHalley-2> <alpine.LRH.2.02.2202011327350.22481@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds copy offload support to the nvme host driver.

The function nvme_setup_read_token stores namespace and location in the
token and the function nvme_setup_write_token retrieves information from
the token and submits the copy command to the device.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>

---
 drivers/nvme/host/core.c   |   94 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/fc.c     |    5 ++
 drivers/nvme/host/nvme.h   |    1 
 drivers/nvme/host/pci.c    |    5 ++
 drivers/nvme/host/rdma.c   |    5 ++
 drivers/nvme/host/tcp.c    |    5 ++
 drivers/nvme/target/loop.c |    5 ++
 include/linux/nvme.h       |   33 +++++++++++++++
 8 files changed, 153 insertions(+)

Index: linux-2.6/drivers/nvme/host/core.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/core.c	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/drivers/nvme/host/core.c	2022-02-01 18:34:19.000000000 +0100
@@ -975,6 +975,85 @@ static inline blk_status_t nvme_setup_rw
 	return 0;
 }
 
+struct nvme_copy_token {
+	char subsys[4];
+	struct nvme_ns *ns;
+	u64 src_sector;
+	u64 sectors;
+};
+
+static inline blk_status_t nvme_setup_read_token(struct nvme_ns *ns, struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_copy_token *token = page_to_virt(bio->bi_io_vec[0].bv_page) + bio->bi_io_vec[0].bv_offset;
+	memcpy(token->subsys, "nvme", 4);
+	token->ns = ns;
+	token->src_sector = bio->bi_iter.bi_sector;
+	token->sectors = bio->bi_iter.bi_size >> 9;
+	return 0;
+}
+
+static inline blk_status_t nvme_setup_write_token(struct nvme_ns *ns,
+		struct request *req, struct nvme_command *cmnd)
+{
+	sector_t src_sector, dst_sector, n_sectors;
+	u64 src_lba, dst_lba, n_lba;
+
+	unsigned n_descriptors, i;
+	struct nvme_copy_desc *descriptors;
+
+	struct bio *bio = req->bio;
+	struct nvme_copy_token *token = page_to_virt(bio->bi_io_vec[0].bv_page) + bio->bi_io_vec[0].bv_offset;
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
+	if (unlikely(nvme_lba_to_sect(ns, src_lba) != src_sector) ||
+	    unlikely(nvme_lba_to_sect(ns, dst_lba) != dst_sector) ||
+	    unlikely(nvme_lba_to_sect(ns, n_lba) != n_sectors))
+		return BLK_STS_NOTSUPP;
+
+	if (WARN_ON(!n_lba))
+		return BLK_STS_NOTSUPP;
+
+	n_descriptors = (n_lba + 0xffff) / 0x10000;
+	descriptors = kzalloc(n_descriptors * sizeof(struct nvme_copy_desc), GFP_ATOMIC | __GFP_NOWARN);
+	if (unlikely(!descriptors))
+		return BLK_STS_RESOURCE;
+
+	memset(cmnd, 0, sizeof(*cmnd));
+	cmnd->copy.opcode = nvme_cmd_copy;
+	cmnd->copy.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->copy.sdlba = cpu_to_le64(dst_lba);
+	cmnd->copy.length = n_descriptors - 1;
+
+	for (i = 0; i < n_descriptors; i++) {
+		u64 this_step = min(n_lba, (u64)0x10000);
+		descriptors[i].slba = cpu_to_le64(src_lba);
+		descriptors[i].length = cpu_to_le16(this_step - 1);
+		src_lba += this_step;
+		n_lba -= this_step;
+	}
+
+	req->special_vec.bv_page = virt_to_page(descriptors);
+	req->special_vec.bv_offset = offset_in_page(descriptors);
+	req->special_vec.bv_len = n_descriptors * sizeof(struct nvme_copy_desc);
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	return 0;
+}
+
 void nvme_cleanup_cmd(struct request *req)
 {
 	if (req->rq_flags & RQF_SPECIAL_PAYLOAD) {
@@ -1032,6 +1111,12 @@ blk_status_t nvme_setup_cmd(struct nvme_
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
 		break;
+	case REQ_OP_COPY_READ_TOKEN:
+		ret = nvme_setup_read_token(ns, req);
+		break;
+	case REQ_OP_COPY_WRITE_TOKEN:
+		ret = nvme_setup_write_token(ns, req, cmd);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
@@ -1865,6 +1950,8 @@ static void nvme_update_disk_info(struct
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 
+	blk_queue_max_copy_sectors(disk->queue, ns->ctrl->max_copy_sectors);
+
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
 }
@@ -2891,6 +2978,12 @@ static int nvme_init_non_mdts_limits(str
 	else
 		ctrl->max_zeroes_sectors = 0;
 
+	if (ctrl->oncs & NVME_CTRL_ONCS_COPY) {
+		ctrl->max_copy_sectors = 1U << 24;
+	} else {
+		ctrl->max_copy_sectors = 0;
+	}
+
 	if (nvme_ctrl_limited_cns(ctrl))
 		return 0;
 
@@ -4716,6 +4809,7 @@ static inline void _nvme_check_size(void
 {
 	BUILD_BUG_ON(sizeof(struct nvme_common_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_rw_command) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_identify) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_features) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
Index: linux-2.6/drivers/nvme/host/nvme.h
===================================================================
--- linux-2.6.orig/drivers/nvme/host/nvme.h	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/drivers/nvme/host/nvme.h	2022-02-01 18:34:19.000000000 +0100
@@ -277,6 +277,7 @@ struct nvme_ctrl {
 #ifdef CONFIG_BLK_DEV_ZONED
 	u32 max_zone_append;
 #endif
+	u32 max_copy_sectors;
 	u16 crdt[3];
 	u16 oncs;
 	u16 oacs;
Index: linux-2.6/include/linux/nvme.h
===================================================================
--- linux-2.6.orig/include/linux/nvme.h	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/include/linux/nvme.h	2022-02-01 18:34:19.000000000 +0100
@@ -335,6 +335,8 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_VERIFY			= 1 << 7,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
@@ -704,6 +706,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -872,6 +875,35 @@ enum {
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
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
+	__u8			length;
+	__u8			control2;
+	__le16			control;
+	__le32			dspec;
+	__le32			reftag;
+	__le16			apptag;
+	__le16			appmask;
+};
+
+struct nvme_copy_desc {
+	__u64			rsvd;
+	__le64			slba;
+	__le16			length;
+	__u16			rsvd2;
+	__u32			rsvd3;
+	__le32			reftag;
+	__le16			apptag;
+	__le16			appmask;
+};
+
 struct nvme_dsm_cmd {
 	__u8			opcode;
 	__u8			flags;
@@ -1441,6 +1473,7 @@ struct nvme_command {
 	union {
 		struct nvme_common_command common;
 		struct nvme_rw_command rw;
+		struct nvme_copy_command copy;
 		struct nvme_identify identify;
 		struct nvme_features features;
 		struct nvme_create_cq create_cq;
Index: linux-2.6/drivers/nvme/host/pci.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/pci.c	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/drivers/nvme/host/pci.c	2022-02-01 18:34:19.000000000 +0100
@@ -949,6 +949,11 @@ static blk_status_t nvme_queue_rq(struct
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
 
+	if (unlikely((req->cmd_flags & REQ_OP_MASK) == REQ_OP_COPY_READ_TOKEN)) {
+		blk_mq_end_request(req, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
 	/*
 	 * We should not need to do this, but we're still using this to
 	 * ensure we can drain requests on a dying queue.
Index: linux-2.6/drivers/nvme/host/fc.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/fc.c	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/drivers/nvme/host/fc.c	2022-02-01 18:34:19.000000000 +0100
@@ -2780,6 +2780,11 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *h
 	u32 data_len;
 	blk_status_t ret;
 
+	if (unlikely((rq->cmd_flags & REQ_OP_MASK) == REQ_OP_COPY_READ_TOKEN)) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
 	if (ctrl->rport->remoteport.port_state != FC_OBJSTATE_ONLINE ||
 	    !nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
Index: linux-2.6/drivers/nvme/host/rdma.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/rdma.c	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/drivers/nvme/host/rdma.c	2022-02-01 18:34:19.000000000 +0100
@@ -2048,6 +2048,11 @@ static blk_status_t nvme_rdma_queue_rq(s
 	blk_status_t ret;
 	int err;
 
+	if (unlikely((rq->cmd_flags & REQ_OP_MASK) == REQ_OP_COPY_READ_TOKEN)) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
 	WARN_ON_ONCE(rq->tag < 0);
 
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
Index: linux-2.6/drivers/nvme/host/tcp.c
===================================================================
--- linux-2.6.orig/drivers/nvme/host/tcp.c	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/drivers/nvme/host/tcp.c	2022-02-01 18:34:19.000000000 +0100
@@ -2372,6 +2372,11 @@ static blk_status_t nvme_tcp_queue_rq(st
 	bool queue_ready = test_bit(NVME_TCP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
+	if (unlikely((rq->cmd_flags & REQ_OP_MASK) == REQ_OP_COPY_READ_TOKEN)) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
 	if (!nvme_check_ready(&queue->ctrl->ctrl, rq, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, rq);
 
Index: linux-2.6/drivers/nvme/target/loop.c
===================================================================
--- linux-2.6.orig/drivers/nvme/target/loop.c	2022-02-01 18:34:19.000000000 +0100
+++ linux-2.6/drivers/nvme/target/loop.c	2022-02-01 18:34:19.000000000 +0100
@@ -138,6 +138,11 @@ static blk_status_t nvme_loop_queue_rq(s
 	bool queue_ready = test_bit(NVME_LOOP_Q_LIVE, &queue->flags);
 	blk_status_t ret;
 
+	if (unlikely((req->cmd_flags & REQ_OP_MASK) == REQ_OP_COPY_READ_TOKEN)) {
+		blk_mq_end_request(req, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
 	if (!nvme_check_ready(&queue->ctrl->ctrl, req, queue_ready))
 		return nvme_fail_nonready_command(&queue->ctrl->ctrl, req);
 

