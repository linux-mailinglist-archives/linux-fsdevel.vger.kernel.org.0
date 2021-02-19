Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7166C3202CC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Feb 2021 03:02:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhBTCCv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Feb 2021 21:02:51 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:52873 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhBTCC0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Feb 2021 21:02:26 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20210220020142epoutp04e194ce7ec817bbcab5f35d684ce9362e~lUkYQuL9-3216932169epoutp04a
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Feb 2021 02:01:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20210220020142epoutp04e194ce7ec817bbcab5f35d684ce9362e~lUkYQuL9-3216932169epoutp04a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1613786502;
        bh=9q8pd5/B7g92Y17Jyin/F8kZJ4m9xmVCa64dB/aOu8c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Me1a2oQXzA7ZbMaN9a6KlXxMM8nA6oBHSZfSRwsoNu/osPPJ+G8VvBtEWcHMA8Cy6
         LKCUizA1+PqAcO3GRmaKASk3Ujb4GBkJoBGupVSq6I8AtUum3sqxpk6oU7gxBRq306
         q1ZQgLAhQ2l197S83v2agr6duggyF3TU6HCub6oU=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20210220020141epcas5p1c7952762f156ebcb262e441cb4de7b1f~lUkXuHvdV2719627196epcas5p17;
        Sat, 20 Feb 2021 02:01:41 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7B.B4.15682.58D60306; Sat, 20 Feb 2021 11:01:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98~lJtwNzm1w2970129701epcas5p2p;
        Fri, 19 Feb 2021 12:46:08 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210219124607epsmtrp1acb23657045715e9cc89c191737a5f83~lJtwGtgcX0512305123epsmtrp1R;
        Fri, 19 Feb 2021 12:46:07 +0000 (GMT)
X-AuditID: b6c32a49-8d5ff70000013d42-83-60306d855f68
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.FC.08745.F03BF206; Fri, 19 Feb 2021 21:46:07 +0900 (KST)
Received: from localhost.localdomain (unknown [107.110.206.5]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210219124605epsmtip2be52bd49832c51a02a929d81b88f8b0c~lJttfzUfr1656916569epsmtip26;
        Fri, 19 Feb 2021 12:46:05 +0000 (GMT)
From:   SelvaKumar S <selvakuma.s1@samsung.com>
To:     linux-nvme@lists.infradead.org
Cc:     kbusch@kernel.org, axboe@kernel.dk, damien.lemoal@wdc.com,
        hch@lst.de, sagi@grimberg.me, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, dm-devel@redhat.com,
        snitzer@redhat.com, selvajove@gmail.com, joshiiitr@gmail.com,
        nj.shetty@samsung.com, joshi.k@samsung.com,
        javier.gonz@samsung.com, kch@kernel.org,
        linux-fsdevel@vger.kernel.org,
        SelvaKumar S <selvakuma.s1@samsung.com>
Subject: [RFC PATCH v5 3/4] nvme: add simple copy support
Date:   Fri, 19 Feb 2021 18:15:16 +0530
Message-Id: <20210219124517.79359-4-selvakuma.s1@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219124517.79359-1-selvakuma.s1@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7bCmlm5rrkGCwbwfmhar7/azWbS2f2Oy
        2PtuNqvFytVHmSwe3/nMbnH0/1s2i/NvDzNZTDp0jdFiz6YpLBZ7b2lb7Nl7ksXi8q45bBbz
        lz1lt9j2ez6zxZUpi5gt1r1+z2Lx4P11dovXP06yWbRt/MroIOyxc9Zddo/z9zayeFw+W+qx
        aVUnm8fmJfUeu282sHm833eVzaNvyypGj8+b5DzaD3QzBXBFcdmkpOZklqUW6dslcGXMP7eZ
        peCSTcWe/fOZGxh/6HcxcnJICJhILG/6ztbFyMUhJLCbUeLn6nPsIAkhgU+MEi+e1UEkPgPZ
        Lx6ywnQcnLeaFaJoF6NE5w91uKKNV/sYQRJsAroS15ZsYgGxRQSUJP6ub2IBKWIWmMAs0Xt9
        LjNIQljAUuLCxfNgNouAqsSMnf/BbF4BW4kjb3cyQWyTl5h56TvYSZwCdhLb3lyDqhGUODnz
        CdgCZqCa5q2zmUEWSAh84ZC4dvMZ0HkcQI6LxKHlmhBzhCVeHd/CDmFLSbzsb4OyyyWedU6D
        2tXAKNH3vhzCtpe4uOcvE8gYZgFNifW7oMElKzH11DomiLV8Er2/n0C18krsmPeECWKrmsSp
        7WYQYRmJD4d3sUHYHhK9K38wQsJqIqPEpmtLWCcwKsxC8s0sJN/MQti8gJF5FaNkakFxbnpq
        sWmBYV5quV5xYm5xaV66XnJ+7iZGcErU8tzBePfBB71DjEwcjIcYJTiYlUR4tz/XSxDiTUms
        rEotyo8vKs1JLT7EKM3BoiTOu8PgQbyQQHpiSWp2ampBahFMlomDU6qBaWnV3yD3z41FC3YK
        xq59oLJE8srjIwYz/Vn27QzOO7HkrNZXkWO3jpUZX97rWzahIoBns9PEJdM9q1+wKc6ayGuf
        drJ3UeKl9R61chW/nPuNUo9/uvq7dPuh+pvH1YLe/fvE3HTodvL25Oi7CV/qO/jirvA5Cq3K
        39C35NK7hRpByq2Xtv/v2120TGLuTwm/S4mS9+4Lznm2jGFO/IUZK481O9tMX3pXIHvW/w3B
        q0SuuevOl7h78M20Tu7+2Ia9Wx8+8gyZy+Dkv8j5+dKHT79YSIkvi/nWOqXlzP7GI/6TZrf1
        sBTfdf5qHuzy8eJMhdP7uj51TwsoXFta/+hQlUTV/csZGb3sTqpiJ1smaqxTYinOSDTUYi4q
        TgQAS4Xot/gDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPIsWRmVeSWpSXmKPExsWy7bCSvC7/Zv0Eg037DCxW3+1ns2ht/8Zk
        sffdbFaLlauPMlk8vvOZ3eLo/7dsFuffHmaymHToGqPFnk1TWCz23tK22LP3JIvF5V1z2Czm
        L3vKbrHt93xmiytTFjFbrHv9nsXiwfvr7Bavf5xks2jb+JXRQdhj56y77B7n721k8bh8ttRj
        06pONo/NS+o9dt9sYPN4v+8qm0ffllWMHp83yXm0H+hmCuCK4rJJSc3JLEst0rdL4MqYf24z
        S8Elm4o9++czNzD+0O9i5OSQEDCRODhvNWsXIxeHkMAORonXM/czQyRkJNbe7WSDsIUlVv57
        zg5R9JFRovH2VlaQBJuArsS1JZtYQGwRASWJv+ubwGxmgWXMEo9mKoLYwgKWEhcungcbyiKg
        KjFj538wm1fAVuLI251MEAvkJWZe+s4OYnMK2Else3MNrEYIqObD92lsEPWCEidnPgGazwE0
        X11i/TwhiFXyEs1bZzNPYBSchaRqFkLVLCRVCxiZVzFKphYU56bnFhsWGOWllusVJ+YWl+al
        6yXn525iBMepltYOxj2rPugdYmTiYDzEKMHBrCTCu/25XoIQb0piZVVqUX58UWlOavEhRmkO
        FiVx3gtdJ+OFBNITS1KzU1MLUotgskwcnFINTNG/liitzT5zvNb3zLQHv9LfcT/pmbB2XrxG
        vdumvA7NE+cKH3q3HnO15HnFO2tV1jejwKnmdwsXr4h9/VY+7cTPT6ILufNYTl8oP/P82Jt8
        Xvv4gOA9zBMf8DJJp3f95PJ8n8ZoXz97x8vQmIpLVy2XMPFkPcvg/rPb5etSEVXds0tvFyya
        F7D2oqWRu21LvpmM7qW/Ar8TnU4ahC1ZkOIg+GvejFlLb/R7Kpy9Js5re/2IjPxZlxf7lxtu
        WJjMr7NC6pSXjfLdtj5hb/vD/yZUbcqYtWLhE8uu2c5ifZJM0Z4lxTEv2Z6oi126vzxaYEnP
        QXYRI8bAu+eOqWpHBdy6tiRphuWqgstH1reaPVJiKc5INNRiLipOBAAPMgp5QgMAAA==
X-CMS-MailID: 20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98
References: <20210219124517.79359-1-selvakuma.s1@samsung.com>
        <CGME20210219124608epcas5p2a673f9e00c3e7b5352f115497b0e2d98@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add support for  TP 4065a ("Simple Copy Command"), v2020.05.04
("Ratified")

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
 drivers/nvme/host/core.c | 87 ++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     | 43 ++++++++++++++++++--
 2 files changed, 127 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f13eb4ded95f..ba4de2f36cd5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -706,6 +706,63 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
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
+		slba = payload->range[i].src;
+		slba = slba >> (ns->lba_shift - 9);
+
+		ssrl = payload->range[i].len;
+		ssrl = ssrl >> (ns->lba_shift - 9);
+
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
@@ -888,6 +945,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	case REQ_OP_DISCARD:
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
+	case REQ_OP_COPY:
+		ret = nvme_setup_copy(ns, req, cmd);
+		break;
 	case REQ_OP_READ:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
 		break;
@@ -1928,6 +1988,31 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
 static void nvme_config_write_zeroes(struct gendisk *disk, struct nvme_ns *ns)
 {
 	u64 max_blocks;
@@ -2123,6 +2208,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	nvme_config_write_zeroes(disk, ns);
 
 	if ((id->nsattr & NVME_NS_ATTR_RO) ||
@@ -4705,6 +4791,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bfed36e342cc..c36e486cbe18 100644
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
@@ -679,6 +683,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -697,7 +702,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
-		nvme_opcode_name(nvme_cmd_resv_release))
+		nvme_opcode_name(nvme_cmd_resv_release),	\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 /*
@@ -869,6 +875,36 @@ struct nvme_dsm_range {
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
@@ -1406,6 +1442,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.25.1

