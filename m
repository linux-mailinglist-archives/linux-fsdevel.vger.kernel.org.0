Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407CE50FCAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 14:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350067AbiDZMTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 08:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349921AbiDZMTE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:19:04 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55B5559B;
        Tue, 26 Apr 2022 05:15:17 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220426121515epoutp0437e539ae68c2cf5fcbf9420fb22c98dd~pcU12E1P52403124031epoutp04Z;
        Tue, 26 Apr 2022 12:15:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220426121515epoutp0437e539ae68c2cf5fcbf9420fb22c98dd~pcU12E1P52403124031epoutp04Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650975315;
        bh=2/hkUw/3X2gk0+5AZSSktsabbgo+VjUMC1NDNj4AJwg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b7BND2mOow7A9UM+woTMlwKxKQ43sNOko1wuaTADg3WI5GKutE0/oJlY5S6rrYu2C
         Mv/VhpKcKxFA+4wW2QHXlzAO/aw4vjexU6MJt9ejCQ+cwXUXEAfyRB1g8uB/J2J6ad
         1k+Tyl8gMAPq4I7foLncHLOdbp827plEXeBQbBv4=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220426121515epcas5p2ce7ecf5f7bef603348cda529aab37a4b~pcU1bEt4D2624626246epcas5p2Y;
        Tue, 26 Apr 2022 12:15:15 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4KngnC6ps9z4x9Q1; Tue, 26 Apr
        2022 12:15:11 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        86.4F.09827.F42E7626; Tue, 26 Apr 2022 21:15:11 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220426102001epcas5p4e321347334971d704cb19ffa25f9d0b4~pawOYHjZy3243632436epcas5p4H;
        Tue, 26 Apr 2022 10:20:01 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220426102001epsmtrp172543dabc421aaef233c3b335d047536~pawOV5vR92263822638epsmtrp1i;
        Tue, 26 Apr 2022 10:20:01 +0000 (GMT)
X-AuditID: b6c32a4a-b3bff70000002663-2c-6267e24f133e
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        26.BA.08924.157C7626; Tue, 26 Apr 2022 19:20:01 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220426101955epsmtip13ba2f31a98b5974fda4e654680a1c4bd~pawIxZdur0427604276epsmtip10;
        Tue, 26 Apr 2022 10:19:55 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     chaitanyak@nvidia.com, linux-block@vger.kernel.org,
        linux-scsi@vger.kernel.org, dm-devel@redhat.com,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk, msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Arnav Dawn <arnav.dawn@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/10] nvme: add copy offload support
Date:   Tue, 26 Apr 2022 15:42:33 +0530
Message-Id: <20220426101241.30100-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20220426101241.30100-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTHcx+9LRjwCqg/YDhSwhZwPMoK+8Fkusi2m+nCw6mTuNUCd4UB
        bdeWuZEpMMSM13gJg+LkoYAgAwTGG+KAAtYhsgoKjtaOMqMGKg+DBpS1FDb/+/zO+Z7nL4eF
        Wd1j2rGihDJaIuTHsAlzvKXPxcUt8G9BmOeoggvrlQMY7JpYZMArU1kELHjyHIP636cZMDer
        kAlXhkcwqNJZwu65Yga89SwJhdONayicuNaOwq7yXBRWX1Gg8EHVRQR2ls0bvH8tMuGqlgMV
        a7ME1C5N4jC3dxyBM2NyFHZP7oZd3ddxqOo4T8CSyhkmTL/TRsCex90YrBp8icKb8lUC5gw2
        MWCbLgmBLSslGOxTj+Gw7rEeh0OT9jAl4zkTjrwYZOx7g1LdPkDJNcMElZM8x6Ta5VNMakR9
        FadUw3FUY00qQTVdSqDy7lYhVOdEIkH98IcCowoXlggqM3mOoNpTNAxqfmYSp/Q9Y0TQztDo
        PZE0P4KWONLCcFFElFDgzz5wiLef5+3jyXHj+MJ32I5Cfiztzw44GOT2YVSMYaVsx2/4MXEG
        UxBfKmV7vLdHIoqT0Y6RIqnMn02LI2LEXLG7lB8rjRMK3IW0zI/j6enlbRCeiI6sV/czxRVx
        3zaoavFEpIqXhpixAMkFzcvlTCNbkZ0I0NRFpCHmBl5AQE/2S9z0WETATN8ssRlxZ/YCboro
        QEBripNJlIICZe0/BhGLRZC7wY01llFjQ+Kgenl5PRFGjrHAwC3teiJrEoLs0WHMyDjpDHpV
        K4iRLUg/cPmqej0PID1Almab0WxGvgsqFHOoSbINXC/SrfeAka+D5N+KMWN+QJaZgz7FTczU
        aACoXKximtgaPBps3mA78DDr7AafBK1nS1FT8BkEpCmVuMmxF4x2vUCNTWCkC6jv8DCZHUC+
        sg41FbYEmSs61GS3AG0XNtkJ1NaXbizLFowvJ20wBfK0C4RpWT8h4IGqmJGNOMpfGUj+ykDy
        /0uXIlgNYkuLpbECWuot9hLSJ//75HBRbCOyfmWuH7ch2vtP3HsRlIX0IoCFsW0s8p2/DLOy
        iOB/F09LRDxJXAwt7UW8DQvPwey2h4sMZyqU8ThcX0+uj48P1/dtHw57p8UNQQPfihTwZXQ0
        TYtpyWYcyjKzS0QrYbGfbHIp9XS/VXx61MOQj9QZXQk+ksldp4J2FHG8nml9E7ymE4fK3hy3
        Do+MkpTILPdRvK3j+RmXTnt4vfVV+wR3PldfFow5nPqFL3cOPv5UH1ZR06q7Vn1kpvnMOafy
        R3oRV5PiLv/stXsHgz2OFxQd0i5XdlvHhpqFNDv05mVovQJ3fGqhvRwpVNuf/9q+SXn33FyN
        cm+q2qbhe9knoZmBAz+f0NW4a4RbAn6sn92ewn5623qwOr4qdaL/4p9bdePHdn1BjqVRId62
        DdL09/s+L9Md/lXShguyo4f6Go/QAvpYQXCDELQEc5uPrrjq78uztkxZrX6QcDTErLBl/+Fw
        Ni6N5HNcMYmU/y9q74zx7gQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0xTdxiHPZeec2B0O5QG/pbEbQ2gwYDr0OwVjWzL3M42I/bTEpaJBY/o
        BOx6GY4Ps64hju5SYQ6xGHArWLmMS9mgaAuutXSIXLaOSRu5qBCSEYooG7KinYUs89ub53ny
        +/QyhMgikDBHCjW8qlCRL6UiyQ6XdEOK3JOX81KvVQIt13sJsPseCKBxzEhBxb1lAuZ/viuA
        cmMlDcGBIQK8U8+CI1AlgOGHJ3G4aw3h4LvahYP9+3Ic6hvdOMxYzBhc+W7hib31gIaV2zJw
        h+YouL3oJ6Hc+QcG0yMmHBz+zWB39JHgvXyegpqL0zR8cdNGQfesgwCL5zEOg6YVCso87QKw
        TZ3EoCNYQ4BrfISE5tl5En7xx0PJl8s0DD3yCF5N4ry/v8uZJgYorkwfoLku0xjNDY23kZx3
        QMtZG0oprr32BPfNqAXjrvh0FPfZDTfBVd5fpLiv9AGK6yqZEHAL036Sm+8eofbFZUXuPMjn
        H/mYV23ZdSDycMv4NVpZpz3e6m0idZgl24BFMIjdim7OVZMGLJIRsTYMmUN/kWtiPbr46Bqx
        dseg+scz9Fqkx1Gtq58yYAxDsZtRf4gJN2KWRPVLS6tDBBtiUOedUiosYlhAp38dWB0i2UTk
        9Aax8C1k09GltvHVHcRuQcaJ6DCOYHegOncAD2PRk2Q0eHytjkZ956bIMCbYjailWhTGBPs8
        0v9URZzGok1PVab/K9NT1QWMaMDW80p1QV6BWqZ8uZAvSlUrCtTawrzU3GMFVmz1l5KTbZi9
        4V6qE8MZzIkhhpCKhd8mHsoRCQ8qPinmVceyVdp8Xu3E4hlSGiccNvRli9g8hYY/yvNKXvWf
        xZkIiQ7X2bOyKzX6+2XT2kvK4pn2Nrz40PLurFq++sVYx2DV7nTzD5tCv23YU1OXNvZM3fWa
        xP0LHwUgbtOO1oySz+3VssnSU/b+TvTKB8WldI4nZm9ngjaqU/HGiiueyXgBDJPbzyQ0JZQ0
        V5xt+tG6Ne28pnXbQtfZd66qe/5Ma9a236DfrOgRKUnjbE+UJFPkH7ZtPJWzGH9AuL1RKU+W
        J7yd6BPzuzINxpHJv1P85svsvCtLFvX6uq+7R8X/ZJj94szWo906G9Fx4s5+uTt39n33p0mD
        Gom2TY0/lzZMbzvzIfuaNMXXW7TOsTQpiw3eavHUyt+KmksaykiPVeS+VySSkurDClkyoVIr
        /gX3jBHiugMAAA==
X-CMS-MailID: 20220426102001epcas5p4e321347334971d704cb19ffa25f9d0b4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426102001epcas5p4e321347334971d704cb19ffa25f9d0b4
References: <20220426101241.30100-1-nj.shetty@samsung.com>
        <CGME20220426102001epcas5p4e321347334971d704cb19ffa25f9d0b4@epcas5p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 drivers/nvme/host/core.c  | 116 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c    |   4 ++
 drivers/nvme/host/nvme.h  |   7 +++
 drivers/nvme/host/pci.c   |  25 ++++++++
 drivers/nvme/host/rdma.c  |   6 ++
 drivers/nvme/host/tcp.c   |  14 +++++
 drivers/nvme/host/trace.c |  19 +++++++
 include/linux/nvme.h      |  43 +++++++++++++-
 8 files changed, 229 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b9b0fbde97c8..9cbc8faace78 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -724,6 +724,87 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy_read(struct nvme_ns *ns, struct request *req)
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
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct nvme_copy_range *range = NULL;
+	struct bio *bio = req->bio;
+	struct nvme_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
+	sector_t src_sector, dst_sector, n_sectors;
+	u64 src_lba, dst_lba, n_lba;
+	unsigned short nr_range = 1;
+	u16 control = 0;
+	u32 dsmgmt = 0;
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
+	if (unlikely(nvme_lba_to_sect(ns, src_lba) != src_sector) ||
+			unlikely(nvme_lba_to_sect(ns, dst_lba) != dst_sector) ||
+			unlikely(nvme_lba_to_sect(ns, n_lba) != n_sectors))
+		return BLK_STS_NOTSUPP;
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
+	cmnd->copy.dspec = cpu_to_le32(dsmgmt);
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -947,10 +1028,16 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
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
@@ -1642,6 +1729,29 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
+				       struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *q = disk->queue;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
+		blk_queue_max_copy_sectors(q, 0);
+		blk_queue_max_copy_range_sectors(q, 0);
+		blk_queue_max_copy_nr_ranges(q, 0);
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, q);
+		return;
+	}
+
+	/* setting copy limits */
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, q))
+		return;
+
+	blk_queue_max_copy_sectors(q, nvme_lba_to_sect(ns, le32_to_cpu(id->mcl)));
+	blk_queue_max_copy_range_sectors(q, nvme_lba_to_sect(ns, le16_to_cpu(id->mssrl)));
+	blk_queue_max_copy_nr_ranges(q, id->msrc + 1);
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -1841,6 +1951,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -4833,6 +4944,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 080f85f4105f..0fea231b7ccb 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2788,6 +2788,10 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) && (req_op(rq) == REQ_OP_READ))) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
 	/*
 	 * nvme core doesn't quite treat the rq opaquely. Commands such
 	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a2b53ca63335..dc51fc647f23 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -482,6 +482,13 @@ struct nvme_ns {
 
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
index 3aacf1c0d5a5..b9081c983b6f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -511,6 +511,14 @@ static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
 		nvmeq->sq_tail = 0;
 }
 
+static void nvme_commit_sqdb(struct nvme_queue *nvmeq)
+{
+	spin_lock(&nvmeq->sq_lock);
+	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
+		nvme_write_sq_db(nvmeq, true);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
 static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 {
 	struct nvme_queue *nvmeq = hctx->driver_data;
@@ -918,6 +926,11 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	if (ret)
 		return ret;
 
+	if (unlikely((req->cmd_flags & REQ_COPY) && (req_op(req) == REQ_OP_READ))) {
+		blk_mq_start_request(req);
+		return BLK_STS_OK;
+	}
+
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
@@ -931,6 +944,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	}
 
 	blk_mq_start_request(req);
+
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -964,6 +978,17 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ret = nvme_prep_rq(dev, req);
 	if (unlikely(ret))
 		return ret;
+	if (unlikely((req->cmd_flags & REQ_COPY) && (req_op(req) == REQ_OP_READ))) {
+		blk_mq_set_request_complete(req);
+		blk_mq_end_request(req, BLK_STS_OK);
+		/* Commit the sq if copy read was the last req in the list,
+		 * as copy read deoesn't update sq db
+		 */
+		if (bd->last)
+			nvme_commit_sqdb(nvmeq);
+		return ret;
+	}
+
 	spin_lock(&nvmeq->sq_lock);
 	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
 	nvme_write_sq_db(nvmeq, bd->last);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5a69a45c5bd6..78af337c51bb 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2087,6 +2087,12 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		goto unmap_qe;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) && (req_op(rq) == REQ_OP_READ))) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		ret = BLK_STS_OK;
+		goto unmap_qe;
+	}
+
 	blk_mq_start_request(rq);
 
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ad3a2bf2f1e9..4e4cdcf8210a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2394,6 +2394,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) && (req_op(rq) == REQ_OP_READ))) {
+		blk_mq_start_request(req);
+		return BLK_STS_OK;
+	}
+
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2462,6 +2467,15 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	blk_mq_start_request(rq);
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) && (req_op(rq) == REQ_OP_READ))) {
+		blk_mq_set_request_complete(rq);
+		blk_mq_end_request(rq, BLK_STS_OK);
+		/* if copy read is the last req queue tcp reqs */
+		if (bd->last && nvme_tcp_queue_more(queue))
+			queue_work_on(queue->io_cpu, nvme_tcp_wq, &queue->io_work);
+		return ret;
+	}
+
 	nvme_tcp_queue_request(req, true, bd->last);
 
 	return BLK_STS_OK;
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 2a89c5aa0790..ab72bf546a13 100644
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
index f626a445d1a8..ec12492b3063 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -316,7 +316,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -344,6 +344,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -393,7 +394,10 @@ struct nvme_id_ns {
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
@@ -750,6 +754,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -771,7 +776,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -945,6 +951,36 @@ struct nvme_dsm_range {
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
@@ -1499,6 +1535,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.35.1.500.gb896f729e2

