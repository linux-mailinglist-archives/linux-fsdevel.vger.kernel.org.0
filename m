Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E9E6CD449
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Mar 2023 10:17:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjC2IRP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Mar 2023 04:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbjC2IQ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:16:26 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2849C4C19
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 01:16:21 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230329081619epoutp031e61fe80a5c042494da09ab33a36909f~Q1dbI-jgj0422704227epoutp03A
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 Mar 2023 08:16:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230329081619epoutp031e61fe80a5c042494da09ab33a36909f~Q1dbI-jgj0422704227epoutp03A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1680077779;
        bh=wfIShqGRwy8zbWXdhjKiAuBZYfQu+83aAnldtDJI0aM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ps/Y+y09r386qqNImV95D3afT7nFYAOcjAKvNB3TQJKpYAu+TkgOQ+YTPqcALC1hL
         vxaRTzflt8iL4TFE27CZo9524GYH7CrEm9uBUKVSstUxCnOWQMEcsdOFfqzguWkYwA
         Sci3dE0xfFYDKfT520INlkyr/DwUH5Lx3nvntECE=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230329081618epcas5p49a981c0219f0702b8b4e1ca7bca29f56~Q1daWVRVl0904209042epcas5p4p;
        Wed, 29 Mar 2023 08:16:18 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4PmfX10952z4x9Px; Wed, 29 Mar
        2023 08:16:17 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        7E.8D.10528.0D3F3246; Wed, 29 Mar 2023 17:16:16 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230327084254epcas5p4c5f324c1501062f743895273c302c0a4~QOiDroNmb1029410294epcas5p4r;
        Mon, 27 Mar 2023 08:42:54 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230327084254epsmtrp17f8b55ecd893d4cfccb9d8d41b09877e~QOiDqVzDB3087530875epsmtrp1B;
        Mon, 27 Mar 2023 08:42:54 +0000 (GMT)
X-AuditID: b6c32a49-e75fa70000012920-b8-6423f3d0ad11
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DB.C5.31821.D0751246; Mon, 27 Mar 2023 17:42:53 +0900 (KST)
Received: from green5.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230327084250epsmtip18b195389784bd7a60d495205c2edc92c~QOiASmib92502425024epsmtip1X;
        Mon, 27 Mar 2023 08:42:50 +0000 (GMT)
From:   Anuj Gupta <anuj20.g@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     bvanassche@acm.org, hare@suse.de, ming.lei@redhat.com,
        damien.lemoal@opensource.wdc.com, anuj20.g@samsung.com,
        joshi.k@samsung.com, nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v8 5/9] nvme: add copy offload support
Date:   Mon, 27 Mar 2023 14:10:53 +0530
Message-Id: <20230327084103.21601-6-anuj20.g@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230327084103.21601-1-anuj20.g@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xbdRTHvff2uQheCrIf6FhzF4NggFZK9yvC2ISZu+AMcSZbiAlc2zte
        pW362AQzRQoMcMhjbssKG4/NGdgD5ZXy6MRWNmBD5B2IwKY0imxlPN1Wcba06P77nHO+53ce
        vxwOxvuK7c9JU2hptYKSE6xtjDZL0OshP6/skgkulklgY/8tDOaWbWDw6nQpCy5YlhF49tET
        DNoHBjFoslUy4WR3Owq76ipQWH+1B4WdtUso/O2XFTbsefaQBSvM4wi0jhlQaJp6A3aZ+hhw
        pKOKBauvWNnQfFqPQuPc5whss1dj8MbCIgP2Tr0CBzduM/f6kSOj8aRhdoBFthum2eTgzHcM
        cmRARzY1FLHI5sufkZ2TOSyyRG9zCPJnmeTizTEW+WVLA0I23/mEXGkKIJvmHqIJLyVmRKXS
        lIxW82mFVClLU6REE/GHkmKTIsQCYYhQAncTfAWVSUcTce8mhLyTJncsg+Afo+Q6hyuB0miI
        sD1RaqVOS/NTlRptNEGrZHKVSBWqoTI1OkVKqILWRgoFgjcjHMLkjNTT6/NMlfH4x2unclk5
        yN3kYoTLAbgI3OlrxoqRbRwe3omAwVor02UsI6C7pBJxGSsIGFg+z9pK+Xt53h3oQMD9hWK2
        M8DD9SiYGDnhZBYeCH78PX9T5IMXYGDJWsRwGhheg4GBsS6GU+WNi8FGwbcOFYfDwF8DT/LS
        neiBS4B56IATAR4GSme9nGIuHgmqjP1MJ3vgXqDv/NzmIxi+E+hbKzFXbxYuuFfu7eI4cOXZ
        ZYaLvcGft1vYLvYH86UFbk4Bj0esqItVQH/rJuLiGJDfX4o5W8DwINDYEeZy7wBn+m+grrKe
        oMQ+5071AMaLW0yAk/VVbgbA9FOOm0nw1GJxb7rEsenvS5llCN/w3DiG58Yx/F+6BsEaED9a
        pclMoTURKqGCPv7fH0uVmU3I5nkEHzAi0/cehZoRlIOYEcDBCB8P+zgh43nIqKxsWq1MUuvk
        tMaMRDiWXY75vyxVOu5LoU0SiiQCkVgsFknCxUJiu0dgdJ+Uh6dQWjqDplW0eisP5XD9c9D0
        F5hjj9Ns62y1yRSia0QT27i+E9Kj4+f+OSHwsYNe+1DtmA3/wdztdfCjXbap/NVjsRHDw6Oi
        5YLmKEbkRqvsTHvui4c9Jx5MzuzXURYR0RlUEX8XZD/YZ/6j+sj1znS/v4Zysvb181e/KQwI
        5137tTDTFHs/LuvC3jXfJtmOs6sG83xytl6qbfFVhzLUtnOBPd5JdVVZMU/z5HHSI6GJB8en
        1i5QhaMdPjtt6xODeG9dkedbfel7Zg6PBn+qrPeeMIcravJO1nywlIFc6104eumU6NBigHX4
        a/q65P0vLgV9OFNd7v92pTX9vTzhVM/ucV9jRjP1KoMbWJ03H9O6nWBoUilhMKbWUP8C6tbM
        CacEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrEIsWRmVeSWpSXmKPExsWy7bCSnC5vuGKKwcEPZhbrTx1jtmia8JfZ
        YvXdfjaL14c/MVpM+/CT2eL32fPMFnvfzWa1uHlgJ5PFnkWTmCxWrj7KZLF74Ucmi8d3PrNb
        HP3/ls1i0qFrjBZPr85isth7S9tiz96TLBaXd81hs5i/7Cm7xaHJzUwWO540Mlps+z2f2WLd
        6/csFiduSVuc/3uc1UHS4/IVb49Z98+yeeycdZfd4/y9jSwel8+Wemxa1cnmsXlJvcfumw1s
        Hr3N74AKWu+zerzfd5XNo2/LKkaPzaerPT5vkvPY9OQtUwB/FJdNSmpOZllqkb5dAlfG5G8v
        WQt2lFd87Wlia2A8k9DFyMkhIWAi8efTS8YuRi4OIYEdjBLXry5lgkhISJx6uYwRwhaWWPnv
        OTtEUSOTxIqtW9lAEmwC6hJHnreCdYsITGCWuHS/gQ3EYRZYxyyxtnkpK0iVsICZxN+2DUBV
        HBwsAqoSP1uyQExeAUuJQxc9QUwJAX2J/vuCIMWcAlYSc3acAmsUAqrob98Fdg+vgKDEyZlP
        WEDKmYHWrp8nBBJmFpCXaN46m3kCo+AsJFWzEKpmIalawMi8ilEytaA4Nz232LDAKC+1XK84
        Mbe4NC9dLzk/dxMjOBloae1g3LPqg94hRiYOxkOMEhzMSiK8m70VU4R4UxIrq1KL8uOLSnNS
        iw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgStRP3zHp1c3HM4P0j00OLUj5GNld
        Iz5jx/353QEbZx897qfx0U6mbI7zfNXP8/y1GHlfbUpNePSy9NaM++cyrXnWvZRmfjnJk9Ni
        z02TG/OqpfVkdnLOr1h8Zv1NJ0Xjjubd57KXFrlG5IttcTBh7IjOLpPNjjgn8Ik/pGSXkMol
        brNzZ3Oyu9p0CxUMd+adDdLbtVO/Z/3ro6+TLPsMteZLyuo7TXUvUXW+z3w6dmlV2ort00V0
        Hu/m4ZS7PjGWY92xgE2/5e9KG6TyfOD9/Whyi9PuLb0yelKMYukSc8yr96w7tO1Bl7TaU7Hn
        Ew+HSstdOtlgvTjJMfzK/MjASAVma6FffkXTeP08V7oqsRRnJBpqMRcVJwIAV+kfhXUDAAA=
X-CMS-MailID: 20230327084254epcas5p4c5f324c1501062f743895273c302c0a4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230327084254epcas5p4c5f324c1501062f743895273c302c0a4
References: <20230327084103.21601-1-anuj20.g@samsung.com>
        <CGME20230327084254epcas5p4c5f324c1501062f743895273c302c0a4@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Nitesh Shetty <nj.shetty@samsung.com>

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
 drivers/nvme/host/constants.c |   1 +
 drivers/nvme/host/core.c      | 106 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c        |   5 ++
 drivers/nvme/host/nvme.h      |   7 +++
 drivers/nvme/host/pci.c       |  27 ++++++++-
 drivers/nvme/host/rdma.c      |   7 +++
 drivers/nvme/host/tcp.c       |  16 +++++
 drivers/nvme/host/trace.c     |  19 ++++++
 include/linux/nvme.h          |  43 +++++++++++++-
 9 files changed, 223 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index bc523ca02254..01be882b726f 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -19,6 +19,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_report] = "Reservation Report",
 	[nvme_cmd_resv_acquire] = "Reservation Acquire",
 	[nvme_cmd_resv_release] = "Reservation Release",
+	[nvme_cmd_copy] = "Copy Offload",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
 	[nvme_cmd_zone_append] = "Zone Management Append",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4eb62a7dac44..e0b5381d572b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -754,6 +754,80 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
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
@@ -988,10 +1062,16 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
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
@@ -1698,6 +1778,26 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1897,6 +1997,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -5345,6 +5446,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2ed75923507d..db2e22b4ca7f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2807,6 +2807,11 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
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
index bf46f122e9e1..257f91ee1f2d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -500,6 +500,13 @@ struct nvme_ns {
 
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
index b615906263f3..d30816533922 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -496,16 +496,19 @@ static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
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
 static inline bool nvme_pci_use_sgls(struct nvme_dev *dev, struct request *req,
 				     int nseg)
 {
@@ -849,6 +852,12 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
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
@@ -895,6 +904,18 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
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
index bbad26b82b56..a8bf2a87f42a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2043,6 +2043,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
+	if (unlikely((rq->cmd_flags & REQ_COPY) &&
+				(req_op(rq) == REQ_OP_READ))) {
+		blk_mq_end_request(rq, BLK_STS_OK);
+		ret = BLK_STS_OK;
+		goto unmap_qe;
+	}
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_INTEGRITY) &&
 	    queue->pi_support &&
 	    (c->common.opcode == nvme_cmd_write ||
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 42c0598c31f2..3c238e07b05c 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2364,6 +2364,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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
@@ -2432,6 +2437,17 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 	nvme_start_request(rq);
 
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
index 779507ac750b..6582b26e532c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -337,7 +337,7 @@ struct nvme_id_ctrl {
 	__u8			nvscc;
 	__u8			nwpc;
 	__le16			acwu;
-	__u8			rsvd534[2];
+	__le16			ocfs;
 	__le32			sgls;
 	__le32			mnan;
 	__u8			rsvd544[224];
@@ -365,6 +365,7 @@ enum {
 	NVME_CTRL_ONCS_WRITE_ZEROES		= 1 << 3,
 	NVME_CTRL_ONCS_RESERVATIONS		= 1 << 5,
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
+	NVME_CTRL_ONCS_COPY			= 1 << 8,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
 	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
@@ -414,7 +415,10 @@ struct nvme_id_ns {
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
@@ -796,6 +800,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -819,7 +824,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -996,6 +1002,36 @@ struct nvme_dsm_range {
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
@@ -1757,6 +1793,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.35.1.500.gb896f729e2

