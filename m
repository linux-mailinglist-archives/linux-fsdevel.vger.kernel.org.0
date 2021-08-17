Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC6813EEBB5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Aug 2021 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbhHQLaE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Aug 2021 07:30:04 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:27949 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239777AbhHQLaC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:30:02 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20210817112928epoutp03bef820afcabdd245a944de3675695367~cFI6zKofK2811828118epoutp034
        for <linux-fsdevel@vger.kernel.org>; Tue, 17 Aug 2021 11:29:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20210817112928epoutp03bef820afcabdd245a944de3675695367~cFI6zKofK2811828118epoutp034
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1629199768;
        bh=2NSwAJ4QSL4cIweNj4RQY2Ku8GUcNJplrAoR+sS/NWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NivmeookvcnDZOz1ecvGDbNNhNdB7agfdaF4mN0+cEf3ZG0BjVI5inODF1AdyBfGh
         0ruH/Y2nG4sIDTLpdxImisijBre9clOv2d5hzR0cmWB2dheEDsOWrKZuN4XmwEl4/a
         72tZzQifOrxcbpdf9HGZwW/1BURoYbz0v1OhgXzM=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20210817112927epcas5p2bb2fb797e40e073a30aec8e0b6a8fcc5~cFI6FKHC-1778517785epcas5p22;
        Tue, 17 Aug 2021 11:29:27 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4Gpphg4DFzz4x9Px; Tue, 17 Aug
        2021 11:29:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.8B.09595.39D9B116; Tue, 17 Aug 2021 20:29:23 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20210817101814epcas5p41db3d7269f5139efcaf2ca685cd04a16~cEKusWySs0955209552epcas5p4P;
        Tue, 17 Aug 2021 10:18:14 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210817101814epsmtrp1e53a42834f8a0bb773c66dfd1c0ac19a~cEKurLd0y2073620736epsmtrp1c;
        Tue, 17 Aug 2021 10:18:14 +0000 (GMT)
X-AuditID: b6c32a4a-eebff7000000257b-4a-611b9d93e418
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        AA.19.32548.6EC8B116; Tue, 17 Aug 2021 19:18:14 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210817101810epsmtip206bab5a6d4d72e2cd99e1ec61c9525e6~cEKq6bEIJ0079500795epsmtip2k;
        Tue, 17 Aug 2021 10:18:10 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
Cc:     linux-api@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, dm-devel@redhat.com,
        kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        asml.silence@gmail.com, johannes.thumshirn@wdc.com, hch@lst.de,
        willy@infradead.org, kch@kernel.org, martin.petersen@oracle.com,
        mpatocka@redhat.com, bvanassche@acm.org, djwong@kernel.org,
        snitzer@redhat.com, agk@redhat.com, selvajove@gmail.com,
        joshiiitr@gmail.com, nj.shetty@samsung.com,
        nitheshshetty@gmail.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [PATCH 6/7] nvme: add simple copy support
Date:   Tue, 17 Aug 2021 15:44:22 +0530
Message-Id: <20210817101423.12367-7-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817101423.12367-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1AbZRR1d8MSGMElvD4DamahD6hAAgQ/aqFOH3ZHoGV02qow4g6swBCS
        mISiVUq0tQE6QHmFQqEogzyChRYiUhpAkikdYBxKoVTb8tIgg52SFlqhUooJSbX/zpzvnHvu
        vd9cNsYpteeyU8UKRiamRSTuyOow+G0JKKn2ovljWk/YOtiPwSpNBwKbJwpxqL7/GIPfqP5G
        4ajRGXYvnLWDTc1XUPjHnSV7uJY3icIr6/dwOHzPgMJi/TgCdW2lLNi+nIPD7lvboK57gAVr
        6mft4ambnThsuPoUhUU5N1DYafwKgR2rNRgcK63F4LTppj28uzKAw5MXHyFwdaUKf8ubGh2L
        oi5VTthT7Y3+1OgvGVSbJhen2uuyqcu/KXHqwewtFmXquYFTBVoNQi21vUqpfj6Fxr74YdqO
        FIZOYmQ8RpwoSUoVJ0eQUe8l7E4QhvEFAYJw+AbJE9PpTAS5Jzo24O1UkXkZJO8ILcowU7G0
        XE4GRe6QSTIUDC9FIldEkIw0SSQNlQbK6XR5hjg5UMwotgv4/GChWfhxWsrxvgJMqt73Wa2u
        H1MiCzAPcWADIhSoSrrwPMSRzSEuI6DfoLOzPHCIRQRcmHS3PiwhQG0y2D9zaB5W2xxdCFA9
        0bKsDrNKVUJZME4EgPG6tg3ejdgJmh5r7CwGjBhkgXJT7UYlVyIYlC9UYhbMIjaBoeYpxIKd
        iAhwvuwfzJr2Gqi4vmzWs9kORCToWtxklbiAgQrjRn3MLDn+41nMUh8QBgdQOdKAW717wKjm
        tq1rV/DXVa0Nc8F84UkbzgR/5qpRK1YioMCUacU7wYhuDbXkYoQfaO0KstKvgLLBFtSa6wzy
        V402qxPoPGfckANiMxj8KcxKe4P7hi5bNxTIne9ErXsrQsBQ6wLrNMKrfG6cyufGqfw/+VsE
        0yAvM1J5ejIjF0qDxUzmf3+cKElvQzbOw/+dTmRm+n6gHkHZiB4BbIx0c9rC5tIcpyT686OM
        TJIgyxAxcj0iNK+7COO6J0rM9yVWJAhCw/mhYWFhoeEhYQLS0yk+2ovmEMm0gkljGCkje+ZD
        2Q5cJep7bC1ruXM2psa5z3dAETnaIJzb9YDX11hgfLN5pSf74Hdsnwv5WlXOfo9PXmL6HuWX
        a3ILd2/OWyy/tDVGPDQed90lML7x2BHhiQVptLvLfFPJnI/f6xAdixE1zDO64nVGnlU/vG3u
        wNILu+7O7P9APxTb46o8NxwRr3QeMf16eC/5Ud2JfYKvod2TdUXkUV+/lTPxnvkqDjd6b28L
        r98td8I3ruzgl1nXqlhbf59WD38/PARmjKTX+eJ6/aGotOzq6L6pse3lI1Nq+PRQUJxjSG+Q
        84Fr1RVfTHl7MbrJlpDe97UeJaDIlX/nBx+tx0Ppu+vLfrfPfLqaeVFxWCJkB5AseQot8Mdk
        cvpfaDbvJqcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCSvO6zHulEg3lH5C3WnzrGbDFn1TZG
        i9V3+9kspn34yWzR2v6NyeLyEz6Lve9ms1qsXH2UyeLxnc/sFn+77jFZHP3/ls3i/NvDTBaT
        Dl1jtNizaQqLxebvHWwWe29pW+zZe5LFYv6yp+wW3dd3sFksP/6PyWJix1Umix1PGhkttv2e
        z2xxZcoiZosH76+zW7z+cZLNom3jV0aL3z/msDnIeFy+4u2xc9Zddo/NK7Q8Lp8t9di0qpPN
        Y/OSeo/dNxvYPD4+vcXi8X7fVTaPvi2rGD0+b5LzaD/QzRTAE8Vlk5Kak1mWWqRvl8CV0Xyw
        j7lgmnvFoj3HmBsY31l0MXJySAiYSKz6Mpeti5GLQ0hgB6PEz9UzWCASMhJr73ayQdjCEiv/
        PWeHKPrIKHFkSQcrSIJNQFfi2pJNYA0iAo4Spz9tYwIpYhZ4xSJx7+5uZpCEsICRxPR3s8Bs
        FgFVidOr7zOC2LwCthJrp/5ihtggLzHz0negDRwcnAJ2Ers+qYKEhYBK9u+Zyg5RLihxcuYT
        FpASZgF1ifXzhEDCzECdzVtnM09gFJyFpGoWQtUsJFULGJlXMUqmFhTnpucWGxYY5aWW6xUn
        5haX5qXrJefnbmIEpwMtrR2Me1Z90DvEyMTBeIhRgoNZSYRXnUMqUYg3JbGyKrUoP76oNCe1
        +BCjNAeLkjjvha6T8UIC6YklqdmpqQWpRTBZJg5OqQamHS8yH3zmirnTP9PXuXfxlIl3uMSk
        N921z27g6jJ5469aeiXi36K6C/b/fUP07my2u8fG1vKfpfrseRN3/xuFn9V+mlXu6p6y8LBe
        6Gr1ddzKBeG9T/47bM7cwFZxbDrTytrA/q++h4N2CZmKVoYu4XzyPidn00TPqw9UVrqJ7XbS
        Zk8WFXzzhV907qZp4v8japMsHLPEb08qvK90euadhz335v7Zq2582YWp7YLe7nMpi60W9nnp
        zVf4W3tAjd+rjo2v7P0hNkcjlg0zrfQ/Zvlauy+PzN8benVKR1/G43iDFpn1ZduP6mTXXmnk
        y519SpTpdF2XwibfDZX2lzlEfm58u5bx3AX9n4FLXugrsRRnJBpqMRcVJwIAwmWwxXYDAAA=
X-CMS-MailID: 20210817101814epcas5p41db3d7269f5139efcaf2ca685cd04a16
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20210817101814epcas5p41db3d7269f5139efcaf2ca685cd04a16
References: <20210817101423.12367-1-selvakuma.s1@samsung.com>
        <CGME20210817101814epcas5p41db3d7269f5139efcaf2ca685cd04a16@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for TP 4065a ("Simple Copy Command"), v2020.05.04 ("Ratified")

For device supporting native simple copy, this implementation accepts
the payload passed from the block layer and convert payload to form
simple copy command and submit to the device.

Set the device copy limits to queue limits. By default copy_offload
is disabled.

End-to-end protection is done by setting both PRINFOR and PRINFOW
to 0.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c  | 83 +++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.c | 19 +++++++++
 include/linux/nvme.h      | 43 ++++++++++++++++++--
 3 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5aabbb4a00f..41f02ee8c0d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -825,6 +825,59 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy(struct nvme_ns *ns,
+	       struct request *req, struct nvme_command *cmnd)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_copy_range *range = NULL;
+	struct blk_copy_payload *payload;
+	unsigned short nr_range = 0;
+	u16 control = 0, ssrl;
+	u32 dsmgmt = 0;
+	u64 slba;
+	int i;
+
+	payload = bio_data(req->bio);
+	nr_range = payload->copy_nr_ranges;
+
+	if (req->cmd_flags & REQ_FUA)
+		control |= NVME_RW_FUA;
+
+	if (req->cmd_flags & REQ_FAILFAST_DEV)
+		control |= NVME_RW_LR;
+
+	cmnd->copy.opcode = nvme_cmd_copy;
+	cmnd->copy.nsid = cpu_to_le32(ns->head->ns_id);
+	cmnd->copy.sdlba = cpu_to_le64(blk_rq_pos(req) >> (ns->lba_shift - 9));
+
+	range = kmalloc_array(nr_range, sizeof(*range),
+			GFP_ATOMIC | __GFP_NOWARN);
+	if (!range)
+		return BLK_STS_RESOURCE;
+
+	for (i = 0; i < nr_range; i++) {
+		slba = (payload->range[i].src) >> (ns->lba_shift - 9);
+		ssrl = (payload->range[i].len) >> (ns->lba_shift - 9);
+		range[i].slba = cpu_to_le64(slba);
+		range[i].nlb = cpu_to_le16(ssrl - 1);
+	}
+
+	cmnd->copy.nr_range = nr_range - 1;
+
+	req->special_vec.bv_page = virt_to_page(range);
+	req->special_vec.bv_offset = offset_in_page(range);
+	req->special_vec.bv_len = sizeof(*range) * nr_range;
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	if (ctrl->nr_streams)
+		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
+
+	cmnd->rw.control = cpu_to_le16(control);
+	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -1012,6 +1065,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	case REQ_OP_DISCARD:
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
+	case REQ_OP_COPY:
+		ret = nvme_setup_copy(ns, req, cmd);
+		break;
 	case REQ_OP_READ:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
 		break;
@@ -1640,6 +1696,31 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
+				       struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *queue = disk->queue;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
+		queue->limits.copy_offload = 0;
+		queue->limits.max_copy_sectors = 0;
+		queue->limits.max_copy_range_sectors = 0;
+		queue->limits.max_copy_nr_ranges = 0;
+		blk_queue_flag_clear(QUEUE_FLAG_SIMPLE_COPY, queue);
+		return;
+	}
+
+	/* setting copy limits */
+	blk_queue_flag_test_and_set(QUEUE_FLAG_SIMPLE_COPY, queue);
+	queue->limits.copy_offload = 0;
+	queue->limits.max_copy_sectors = le64_to_cpu(id->mcl) *
+		(1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_range_sectors = le32_to_cpu(id->mssrl) *
+		(1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_nr_ranges = id->msrc + 1;
+}
+
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
 {
 	return !uuid_is_null(&ids->uuid) ||
@@ -1811,6 +1892,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
+	nvme_config_copy(disk, ns, id);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
@@ -4564,6 +4646,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 6543015b6121..0e7db7ad5ed3 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -136,6 +136,23 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
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
@@ -227,6 +244,8 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 		return nvme_trace_zone_mgmt_send(p, cdw10);
 	case nvme_cmd_zone_mgmt_recv:
 		return nvme_trace_zone_mgmt_recv(p, cdw10);
+	case nvme_cmd_copy:
+		return nvme_trace_copy(p, cdw10);
 	default:
 		return nvme_trace_common(p, cdw10);
 	}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b7c4c4130b65..4f79f223c9eb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -295,7 +295,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -320,6 +320,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
@@ -368,7 +369,10 @@ struct nvme_id_ns {
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
@@ -689,6 +693,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -710,7 +715,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -883,6 +889,36 @@ struct nvme_dsm_range {
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
@@ -1427,6 +1463,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.25.1

