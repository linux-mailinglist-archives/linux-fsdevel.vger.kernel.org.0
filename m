Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B57A562487
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jun 2022 22:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiF3UnM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jun 2022 16:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237405AbiF3UnA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jun 2022 16:43:00 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78072E87
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:59 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 25UHF2YG008879
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=LVMgK7DArspWjjYk5Pf3yLv7JuoIp2oNJy7AUsJ+42M=;
 b=FoltLSOGm4BNovgtzoBvkP56ruLvhjjiqVjNo8z4CnFZ2ZRbtgI9L/JTsS2aS4k+JZZR
 LSr1E8ixLDovKqPKh+waGA8L5Z+wtZiqoFFmFAfYlZmI82fH95M0F9FDty3UQudUzB3q
 6wScXWNzY/QV/zJ6+z0UPMKIav/Duu0MSVA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3h17gewyn9-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 30 Jun 2022 13:42:58 -0700
Received: from twshared10560.18.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 30 Jun 2022 13:42:55 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
        id CD6965932DBE; Thu, 30 Jun 2022 13:42:30 -0700 (PDT)
From:   Keith Busch <kbusch@fb.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-block@vger.kernel.org>,
        <linux-nvme@lists.infradead.org>
CC:     <axboe@kernel.dk>, Kernel Team <Kernel-team@fb.com>, <hch@lst.de>,
        <willy@infradead.org>, <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>
Subject: [PATCH 06/12] nvme: add support for bit buckets
Date:   Thu, 30 Jun 2022 13:42:06 -0700
Message-ID: <20220630204212.1265638-7-kbusch@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220630204212.1265638-1-kbusch@fb.com>
References: <20220630204212.1265638-1-kbusch@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: a6d8gm4FfmIOHMXkY59WVEXyL2nySv5m
X-Proofpoint-GUID: a6d8gm4FfmIOHMXkY59WVEXyL2nySv5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-06-30_14,2022-06-28_01,2022-06-22_01
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Keith Busch <kbusch@kernel.org>

Set the queue for bit bucket support if the hardware and driver support
it. The nvme pci driver will recognize the special bitbucket page for
read commands and set up an appropriate sg descriptor for it.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/core.c |  3 +++
 drivers/nvme/host/nvme.h |  6 ++++++
 drivers/nvme/host/pci.c  | 17 +++++++++++++++--
 include/linux/nvme.h     |  2 ++
 4 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b5b24998a5ab..211bc30bb707 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3999,6 +3999,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, u=
nsigned nsid,
 	if (ctrl->ops->flags & NVME_F_PCI_P2PDMA)
 		blk_queue_flag_set(QUEUE_FLAG_PCI_P2PDMA, ns->queue);
=20
+	if (nvme_ctrl_sgl_bb_supported(ctrl) && ctrl->ops->flags & NVME_F_BB)
+		blk_queue_flag_set(QUEUE_FLAG_BIT_BUCKET, ns->queue);
+
 	ns->ctrl =3D ctrl;
 	kref_init(&ns->kref);
=20
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0da94b233fed..7401f58fe534 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -496,6 +496,7 @@ struct nvme_ctrl_ops {
 #define NVME_F_FABRICS			(1 << 0)
 #define NVME_F_METADATA_SUPPORTED	(1 << 1)
 #define NVME_F_PCI_P2PDMA		(1 << 2)
+#define NVME_F_BB			(1 << 3)
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
@@ -991,6 +992,11 @@ static inline bool nvme_ctrl_sgl_supported(struct nv=
me_ctrl *ctrl)
 	return ctrl->sgls & ((1 << 0) | (1 << 1));
 }
=20
+static inline bool nvme_ctrl_sgl_bb_supported(struct nvme_ctrl *ctrl)
+{
+	return ctrl->sgls & (1 << 16);
+}
+
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			 u8 opcode);
 int nvme_execute_passthru_rq(struct request *rq);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 247a74aba336..32894e392142 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -535,6 +535,8 @@ static inline bool nvme_pci_use_sgls(struct nvme_dev =
*dev, struct request *req)
=20
 	avg_seg_size =3D DIV_ROUND_UP(blk_rq_payload_bytes(req), nseg);
=20
+	if (req->rq_flags & RQF_BIT_BUCKET)
+		return true;
 	if (!nvme_ctrl_sgl_supported(&dev->ctrl))
 		return false;
 	if (!iod->nvmeq->qid)
@@ -724,6 +726,13 @@ static void nvme_pci_sgl_set_data(struct nvme_sgl_de=
sc *sge,
 	sge->type =3D NVME_SGL_FMT_DATA_DESC << 4;
 }
=20
+static void nvme_pci_sgl_set_bb(struct nvme_sgl_desc *sge,
+				struct scatterlist *sg)
+{
+	sge->length =3D cpu_to_le32(sg_dma_len(sg));
+	sge->type =3D NVME_SGL_FMT_BB_DESC << 4;
+}
+
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 		dma_addr_t dma_addr, int entries)
 {
@@ -789,7 +798,10 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_=
dev *dev,
 			nvme_pci_sgl_set_seg(link, sgl_dma, entries);
 		}
=20
-		nvme_pci_sgl_set_data(&sg_list[i++], sg);
+		if (rq_data_dir(req) =3D=3D READ && blk_is_bit_bucket(sg_page(sg)))
+			nvme_pci_sgl_set_bb(&sg_list[i++], sg);
+		else
+			nvme_pci_sgl_set_data(&sg_list[i++], sg);
 		sg =3D sg_next(sg);
 	} while (--entries > 0);
=20
@@ -3003,7 +3015,8 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops=
 =3D {
 	.name			=3D "pcie",
 	.module			=3D THIS_MODULE,
 	.flags			=3D NVME_F_METADATA_SUPPORTED |
-				  NVME_F_PCI_P2PDMA,
+				  NVME_F_PCI_P2PDMA |
+				  NVME_F_BB,
 	.reg_read32		=3D nvme_pci_reg_read32,
 	.reg_write32		=3D nvme_pci_reg_write32,
 	.reg_read64		=3D nvme_pci_reg_read64,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index e3934003f239..1fae005715fc 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -835,6 +835,7 @@ enum {
  *
  * For struct nvme_sgl_desc:
  *   @NVME_SGL_FMT_DATA_DESC:		data block descriptor
+ *   @NVME_SGL_FMT_BB_DESC:		bit buckect descriptor
  *   @NVME_SGL_FMT_SEG_DESC:		sgl segment descriptor
  *   @NVME_SGL_FMT_LAST_SEG_DESC:	last sgl segment descriptor
  *
@@ -846,6 +847,7 @@ enum {
  */
 enum {
 	NVME_SGL_FMT_DATA_DESC		=3D 0x00,
+	NVME_SGL_FMT_BB_DESC		=3D 0x01,
 	NVME_SGL_FMT_SEG_DESC		=3D 0x02,
 	NVME_SGL_FMT_LAST_SEG_DESC	=3D 0x03,
 	NVME_KEY_SGL_FMT_DATA_DESC	=3D 0x04,
--=20
2.30.2

