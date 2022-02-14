Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C95D4B4447
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Feb 2022 09:36:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbiBNIgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Feb 2022 03:36:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242076AbiBNIgM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Feb 2022 03:36:12 -0500
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7188F5FF0B;
        Mon, 14 Feb 2022 00:36:03 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220214083601epoutp03cb7838a422ed0b459923802b93a7704a~TmiJ9miDc0925309253epoutp03I;
        Mon, 14 Feb 2022 08:36:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220214083601epoutp03cb7838a422ed0b459923802b93a7704a~TmiJ9miDc0925309253epoutp03I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644827761;
        bh=ZvNkb0zuJHNi8XxnkFtd8J/B7UB6bfOt+vOmPP9/8M4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l9SU+rybvacOePWrTuWT5NhPSZX2rvEOTuo+AL5RCHodsYFmrYt/BqK4b+E9rNZkd
         SNACwkFcp2DCInyIyC0cV3J/EP0PzLLdpdIkEVCGVPrqF8IJnqnllzzEWkzAtOCs0t
         Yow7tGqPtT1c9AcGPAPOc+3CkAnr9dOVR8yt4dgU=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20220214083601epcas5p15c66ffc22cd51e1cb1cfb18d2985b538~TmiJciE400265302653epcas5p1G;
        Mon, 14 Feb 2022 08:36:01 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JxyGx1Gn9z4x9QQ; Mon, 14 Feb
        2022 08:35:53 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CC.C7.46822.AC31A026; Mon, 14 Feb 2022 17:33:14 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220214080634epcas5p40b2c60e959b89355a25db7c69219d039~TmIcJwx7A1303713037epcas5p4k;
        Mon, 14 Feb 2022 08:06:34 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220214080634epsmtrp250835e480bc2ea21d3ba017bccabe385~TmIcIb8Iw2568325683epsmtrp29;
        Mon, 14 Feb 2022 08:06:34 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-b8-620a13ca091c
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CE.E1.29871.A8D0A026; Mon, 14 Feb 2022 17:06:34 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220214080629epsmtip2b4be61fccf0cdbc69ebf8b410989e239~TmIXUfyE72320123201epsmtip2o;
        Mon, 14 Feb 2022 08:06:29 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, hare@suse.de, kbusch@kernel.org,
        hch@lst.de, Frederick.Knight@netapp.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nitheshshetty@gmail.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/10] nvme: add copy offload support
Date:   Mon, 14 Feb 2022 13:29:56 +0530
Message-Id: <20220214080002.18381-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220214080002.18381-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeVCUdRjH5/e+y7sLufQKmD9hqp2lHJE4lgB/CEqpxTvglA02NTYFr/AG
        juwxe6Q5kxw7oHLEVQSLAaKGHInLNVzLIIQIuAGBXHEOEBQjl3IFtu2yS/nf5zm+z/N7nt88
        HNyql23LOSeSM1IRHcEnLFhVzQ4OTu3WFmddx5Z8UGn7AxzVDz41Q8UjyQTKWNzA0cL9STOU
        lpzJRj1Tlkgzn22GutajMTRZpsNQfX4ahgqLWzA0U3AToLobS/rA8FM2utbRhaGtCQFq0T0h
        UFpTH0DTj1UY0gw5onpNGwv11F4nUO5P02yU0F9NoIY5DY4KWv/B0K+qLQJVT0UDVLWZi6Pm
        0ccsdHdugYXm1tsIFKdeASg2cYONOp+3mr3zBtXTG0CpxrQElaqcZ1M1qhE21TmqZlHKvGEW
        1aNVUGVF1wiq/FYklT5QAKi6wSiCinnUglOZy88IKkk5T1BL00MsaqHhMXHqlTPnfcIZOpSR
        8hhRiDj0nCjsCD8gMOh4kIenq8BJ4IUO8XkiWsgc4Z84ecrp/XMR+k3yeV/REQq96xQtk/Fd
        jvpIxQo5wwsXy+RH+IwkNELiLnGW0UKZQhTmLGLkhwWurm4e+sTg8+Hp6hlcsiK+WJEzCKLA
        5pl4YM6BpDv8WVuCG9iKrAOw96FbPLDQ8zKAWpUSGI1VAJVxC+wdRaKunTAGNACOVlaZGY1Y
        DPatleizOByCdIQdOo5BYEOyYOHaGsvAODnKhvmphIGtSQTju38zMzCLfBNmZOi2mUsehv1x
        faZm9vDGxP1tvznpDRvnCnBjzm7YljVlqvk6VFZm44Y3QDLLAkY3LBFG8Qn4y80/MCNbw79a
        K0xFbeHTeQ1hFCQAuP5oDDMamfo5U5QmtS/srn+OGabBSQdYWutidL8Kv2+/ixk7W8KkzSlT
        Ay6sztlhe1hSmmcqs0+/lGgTU7Cpdg0zbutbALM2y4kUwFO9MJHqhYlU/7fOA3gR2MdIZMIw
        RuYhcRMxF/775hCxsAxsn9dB/2owMb7o3AQwDmgCkIPzbbhfaM3PWnFD6a8vMVJxkFQRwcia
        gId+5am47Z4Qsf4+RfIggbuXq7unp6e719ueAv5ebkfYPdqKDKPlzHmGkTDSHR3GMbeNwi67
        FfuFfaDz8LualDAm2G3XKqRuf9f80pOuko/wQyXt5eWXtwobq6veu3PcPzi9RBtpyWsZd2j0
        3tunthnKX69mF9X6lH7I764v5Vmbcy8NfnpRsal+a/+uurWte9y0K7ETs/uTf7SdXg1KHvj4
        ZqGYvj57IffAJhbpfNoqcvwH+Z4UbZpdLzv9c3XnMzK45qjL6YBjKq7jZwL3hsyEb0YqYl6z
        K1Q9HIkJFPo8J4Sf/LlxoIFJ+TJ74N2YQIsHih5/oqr8b/txgQXdPxKzarncNflyZahNTuLV
        FWtLVnSNn2Y4de5kiG/5SMIddfYu8xVnqe+s8+3f7Y95XPG2m5nTZdxa5LNk4bTgIC6V0f8C
        dY2/yecEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf1CTdRzH+z7Ps2fPpsvHQfUd3oFO/J3QrrIPgiWn5aPmHWV/2dmc8ITW
        frUJKV0xXGJMCBnEzeEJGscCPAgoRAYmI/Dm+BmiYiB4gOTtAgU5IX8sxq7L/96f9+t19/7n
        w5DSIkEIc1B7iDdoVWo5LaZqm+Vh6y0S8f7Xim2hUHm1lYSGvikBlA9k05B/f5aEiaZhAViz
        bULoGXkRGscLBNA1k0bAcLWPgIZzVgJKy1sIGHP8iMB59sEc6J8SQoani4AndxTQ4vubBqvr
        OoLRXjsBjbfWQUOjm4Ke+tM0FJaMCuHEjToaLnkbSXBceUZAh/0JDXUjaQhqHxeS0Hy7l4IK
        7wQF3hk3DelV0wiOZc4KofPpFcHmcK7n2k7OPthOcznmcSF30T4g5DpvV1Gcuaif4nrak7jq
        sgyaqylO5XJvOhDn7DPR3NG2FpKzTT6kuSzzOM09GL1FcROXeum4l/eIYxJ49cFk3hD59j7x
        gdyqMVI/rTv8y5k+ZEKP91iQiMHsGzjTd5W2IDEjZZ0IZ3dXEgEgwyVPfycDOQiXPhsTBiQz
        gWeGJuYOhqHZddjjY/xOMEvh0kePKL9Dst8xuNMxjPwgiAVs6f5D4M8UuwLn5/vms4TdiG+k
        XxcGBpbjs3ea5nsRG40vex3zw9I5x9brEgb8xdh9aoTy75LsKlx5RuqvSTYMm38tIE+ixfbn
        LPv/lv05qwiRZUjG642aRI1RoVdo+S8jjCqNMUmbGBGv01Sj+Sdau6YOXSi7H+FCBINcCDOk
        PFjySbtov1SSoDqSwht0SkOSmje60BKGkr8i6bK4lVI2UXWI/5zn9bzhP0owohATkbL56Pt/
        /WbC6bG7v/W+FbFs7w+ChLsLD6dsNcs+5gvfCz25+txSzdiRDVMyz+vimC8indWJ94ZQYUrW
        Al3TYIL6+MXwhbMhqlc7oo6N197cy47fbR2cyfloW8KHP9Wpc995Nya444NJremr0JJdmV9X
        uEc9+5Tecktxf+rKvCi5/MLutoH6Jc6O9TnpMtPk+U+jCvJPfBb9MGMlDNmbFNZrS7ktsfUL
        arlNtjWrfo6Pxot2eNpemk4eTm6W6WLDlG/uisoKt0S2Lftme8UmZ8z57Xl/itIuF+Vt2LnC
        fS8O8qy5g/GymqGc6VPfdwfXbAxq2UYsSlX+c1r5guD46v5WfdzWULecMh5QKdaSBqPqXxM/
        KmezAwAA
X-CMS-MailID: 20220214080634epcas5p40b2c60e959b89355a25db7c69219d039
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220214080634epcas5p40b2c60e959b89355a25db7c69219d039
References: <20220214080002.18381-1-nj.shetty@samsung.com>
        <CGME20220214080634epcas5p40b2c60e959b89355a25db7c69219d039@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SelvaKumar S <selvakuma.s1@samsung.com>

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

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Arnav Dawn <arnav.dawn@samsung.com>
---
 drivers/nvme/host/core.c  | 119 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c    |   4 ++
 drivers/nvme/host/nvme.h  |   7 +++
 drivers/nvme/host/pci.c   |   9 +++
 drivers/nvme/host/rdma.c  |   6 ++
 drivers/nvme/host/tcp.c   |   8 +++
 drivers/nvme/host/trace.c |  19 ++++++
 include/linux/nvme.h      |  43 +++++++++++++-
 8 files changed, 210 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 961a5f8a44d2..731a091f4bc3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -821,6 +821,90 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
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
+	return 0;
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
+	cmnd->copy.sdlba = cpu_to_le64(blk_rq_pos(req) >> (ns->lba_shift - 9));
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
+	if (ctrl->nr_streams)
+		nvme_assign_write_stream(ctrl, req, &control, &dsmgmt);
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
@@ -1024,10 +1108,16 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
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
@@ -1682,6 +1772,29 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
 {
 	return !uuid_is_null(&ids->uuid) ||
@@ -1864,6 +1977,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
+	nvme_config_copy(disk, ns, id);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
@@ -4728,6 +4842,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 71b3108c22f0..5057ab1a1875 100644
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
index a162f6c6da6e..117658a8cf5f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -474,6 +474,13 @@ struct nvme_ns {
 
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
index 6a99ed680915..a7b0f129a19d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -916,6 +916,11 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	if (ret)
 		return ret;
 
+	if (unlikely((req->cmd_flags & REQ_COPY) && (req_op(req) == REQ_OP_READ))) {
+		blk_mq_end_request(req, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
 	if (blk_rq_nr_phys_segments(req)) {
 		ret = nvme_map_data(dev, req, &iod->cmd);
 		if (ret)
@@ -929,6 +934,7 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
 	}
 
 	blk_mq_start_request(req);
+
 	return BLK_STS_OK;
 out_unmap_data:
 	nvme_unmap_data(dev, req);
@@ -962,6 +968,9 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	ret = nvme_prep_rq(dev, req);
 	if (unlikely(ret))
 		return ret;
+	if (unlikely((req->cmd_flags & REQ_COPY) && (req_op(req) == REQ_OP_READ)))
+		return ret;
+
 	spin_lock(&nvmeq->sq_lock);
 	nvme_sq_copy_cmd(nvmeq, &iod->cmd);
 	nvme_write_sq_db(nvmeq, bd->last);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9c55e4be8a39..060abf310fb8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2070,6 +2070,12 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
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
index 01e24b5703db..c36b727384a8 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2315,6 +2315,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 	if (ret)
 		return ret;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) && (req_op(rq) == REQ_OP_READ))) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
 	req->offset = 0;
@@ -2380,6 +2385,9 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(ret))
 		return ret;
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) && (req_op(rq) == REQ_OP_READ)))
+		return ret;
+
 	blk_mq_start_request(rq);
 
 	nvme_tcp_queue_request(req, true, bd->last);
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
index 855dd9b3e84b..7ed966058f4c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -309,7 +309,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -335,6 +335,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
@@ -383,7 +384,10 @@ struct nvme_id_ns {
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
@@ -704,6 +708,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -725,7 +730,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -898,6 +904,36 @@ struct nvme_dsm_range {
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
@@ -1449,6 +1485,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.30.0-rc0

