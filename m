Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE2C87225C7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:30:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjFEMaJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233498AbjFEM3t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:29:49 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF40DF3
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:44 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20230605122942epoutp02dca4bfc10f39cab96c66f18393a480f6~lwyE3_Ftu0553805538epoutp02R
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20230605122942epoutp02dca4bfc10f39cab96c66f18393a480f6~lwyE3_Ftu0553805538epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968183;
        bh=oy1X2h64u1n5X0mEoxDQWm1StM8EqkhjUrEzZtW2Yo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AqJC/qPmbDYM8jlQhrtMhvFXfHEItVPa7U9EkSB9QkRECGCZ5Ao2XfvmmN3FsKqUG
         FqfqWyskb86vaWBUsL4JyFROMfqK6leni5Q69pe42JmFe4sMFKfkYzBeHWH/mqLIjj
         6aHs2GqjZ58YNMVrLTgb/9FOpQzDdOup9Q9BZUHA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230605122941epcas5p43bbe345fc5ef80aa688da9862f9d2715~lwyDkFktU1407614076epcas5p4K;
        Mon,  5 Jun 2023 12:29:41 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4QZXx01WlSz4x9Pv; Mon,  5 Jun
        2023 12:29:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DF.F6.44881.435DD746; Mon,  5 Jun 2023 21:29:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494~lwsXrmMe23059130591epcas5p45;
        Mon,  5 Jun 2023 12:23:10 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230605122310epsmtrp232f613e843c1168fd0664cfa5fbb3d11~lwsXqVU8p0879508795epsmtrp2g;
        Mon,  5 Jun 2023 12:23:10 +0000 (GMT)
X-AuditID: b6c32a4a-ea9fa7000001af51-85-647dd53474a3
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        69.C5.28392.EA3DD746; Mon,  5 Jun 2023 21:23:10 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122302epsmtip22383636a4f2611013bf69e260f4ff717~lwsPwmiL42527625276epsmtip2X;
        Mon,  5 Jun 2023 12:23:02 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        willy@infradead.org, hare@suse.de, djwong@kernel.org,
        bvanassche@acm.org, ming.lei@redhat.com, dlemoal@kernel.org,
        nitheshshetty@gmail.com, gost.dev@samsung.com,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 5/9] nvme: add copy offload support
Date:   Mon,  5 Jun 2023 17:47:21 +0530
Message-Id: <20230605121732.28468-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230605121732.28468-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRj2O2f37IItc7iUH5jBrDIkxGVhwQ8SKbXmhDExUj/MSVzhxG7A
        7rbLeqOSi0BQXBcYXSggIW4OxEVcQIQWEUG5GIJJchthrLgvM0IB2S4Hyn/P+7zv817n5eIW
        9RwbrkQaRSukogg+YcpqaN/r4Cwc/DLUreISgaq7b+MoLmMdR5Uj6QSabtcDlLvwF44m25IA
        Gpg0Q+OtfqhlLo+NHrU1YujGD1kYKq/swFBz0SKGnjxe4qCO57MEytINATQ1qMFQy7ATKkos
        ZqEbLV0sNNCUT6CCH6c46JuHWgKVdv6DIZ06HkPayViAGlYLcFQ1Pc9Cd4Z3or71TjZaXckn
        3rKlBh4coTRjPQTVqBnhUH2jNSyqrsyRGuhRUbUVyQRVV3yBan4UQ1BX0tRsKjV+jqAWp4ZZ
        1PzNQYJKq68AVN3daGqp9rVA84/D94tpUSitsKOlIbJQiTTMl38kKPhQsKeXm8BZ4I328e2k
        okjal3/4/UDndyURhmXx7U6LIlQGKlCkVPJdD+xXyFRRtJ1Ypozy5dPy0Ai5UO6iFEUqVdIw
        Fykd5SNwc3P3NASeDBfXD3whf3D6bNJ8DDsGrAanABMuJIVwueYqYcQWZDOA6kXXFGBqwHoA
        66//ymaMJQDHMhvwLcWd2zqccTQBOJPZQzBGAgZj+0s4KYDLJUgnePc518hbkWU4jF2+xzIa
        OFnFgtmla2xjKktyHywY/Q0zClikPXzWvUHzSB/YMtZIGGlIusL0MXMjbUK+Cf/o0eFMiDns
        ujzJMmKctIXx1/I2GoKk3gTq256xGe1hWFqpYpq2hH921nMYbAOX5loIBp+B5dllBKO9CKDm
        oQYwDj+Y0J2OG/Pg5F5Y3eTK0LtgTncVxtQ1g6mrkxjD86D2+y28G16tLtzMbw2HlmM3MQVr
        +tc2d5UGYFzDMpYB7DQvzKN5YR7N/6ULAV4BrGm5MjKMVnrK3aX0mf9uHCKLrAUb7+PorwUT
        4wsuOoBxgQ5ALs634jX5R4da8EJF587TClmwQhVBK3XA07DuTNzm5RCZ4f+kUcECobeb0MvL
        S+jt4SXg7+A5+HaFWJBhoig6nKbltGJLh3FNbGKwS7/Un4o5QCVva3xpQOM/+5PFbMkr6qle
        3dKJCXsr96BbufafqUbnb76e+N0Tu8Y9T+/huSPOWanDM2/IShd8Pj1kynN+b0jd34Hf97I2
        sb31d7H4eHFGkejr7WqTVm1IQGW7sunbfJ6fXlC4ZmZ70GNXlf+2wZQCeuKC09up9i4r3J3l
        saeOyc4G9eb5bD9WEv17588FeZKZc2T7+lHhRxenQ6o1fW4HA5aSQfXjz69JOOYjzRxJftXx
        zEB94FetO3xLqA/qxGKPwndWrkd+4q5/tfRD64jMzj3ns09eScyJO5o4rN6dUzp+P8Aj60Tg
        oEMrFpab4CnpHeZ2Wl7WJnGetk9P8llKsUjgiCuUon8B5e2cnMcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgleLIzCtJLcpLzFFi42LZdlhJXnfd5doUg9VTdSzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFrsX
        fmSyeHznM7vF0f9v2SwmHbrGaPH06iwmi723tC0Wti1hsdiz9ySLxeVdc9gs5i97ym7RfX0H
        m8Xy4/+YLA5Nbmay2PGkkdFi2+/5zBbrXr9nsThxS9ri/N/jrBa/f8xhc5D3uHzF22PW/bNs
        Hjtn3WX3OH9vI4vH5hVaHpfPlnpsWtXJ5rF5Sb3H7psNbB6L+yazevQ2v2Pz+Pj0FovH+31X
        2Tz6tqxi9Nh8utrj8ya5AMEoLpuU1JzMstQifbsErowtl2sKrpRVtL9vYG1g/B3fxcjJISFg
        InHi2CHmLkYuDiGBHYwSj07/YYJISEos+3uEGcIWllj57zk7RFEzk8SWM4vZuhg5ONgEtCVO
        /+cAiYsIbGGWOPtrMiuIwyxwiEXizseFjCDdwgLmEvPv3WYCaWARUJX4dooVJMwrYCWx9/5O
        sDkSAvoS/fcFQcKcAtYSL8+CHMQBtMtK4up7G4hqQYmTM5+wgISZBdQl1s8TAgkzC8hLNG+d
        zTyBUXAWkqpZCFWzkFQtYGRexSiZWlCcm55bbFhglJdarlecmFtcmpeul5yfu4kRnEi0tHYw
        7ln1Qe8QIxMH4yFGCQ5mJRHeXV7VKUK8KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8s
        Sc1OTS1ILYLJMnFwSjUw8Rdad8syNddu7/R6ofbP13zXnITvPev3VDMULDp+5oa9+NItq03T
        3rYz6Gkx3pafz7tMMUi8qat1hdeaFwzJvkqFUUqdIjqe1beiTzXcZCw3nHaHf863Oq7ZGgZe
        3xcqSvT6ScoFL4z497/iToH1xNoy/k2lxtddcnJiDHMc57n0nm6Q9y+qL5z0duu7py23PJgN
        frMI/J+9z/TzoadKFV6vsl/KCUofjf3jtFpT9aRP8MxTz9hvv2OLUjtzUHhVT0KW2vTbEk+0
        fCxD7A8vcjhSdrn43+KHfWqckt9T+rSbLj3b4OzhE9L0wiWnNSyxSVdoVRLfxU8q1Ynv8puW
        Ksi+lvbr1LaRTF2RqcRSnJFoqMVcVJwIAEBOgpuTAwAA
X-CMS-MailID: 20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122310epcas5p4aaebfc26fe5377613a36fe50423cf494@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/constants.c |   1 +
 drivers/nvme/host/core.c      | 103 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c        |   5 ++
 drivers/nvme/host/nvme.h      |   7 +++
 drivers/nvme/host/pci.c       |  27 ++++++++-
 drivers/nvme/host/rdma.c      |   7 +++
 drivers/nvme/host/tcp.c       |  16 ++++++
 drivers/nvme/host/trace.c     |  19 +++++++
 include/linux/nvme.h          |  43 +++++++++++++-
 9 files changed, 220 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 5e4f8848dce0..311ad67e9cf3 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -19,6 +19,7 @@ static const char * const nvme_ops[] = {
 	[nvme_cmd_resv_report] = "Reservation Report",
 	[nvme_cmd_resv_acquire] = "Reservation Acquire",
 	[nvme_cmd_resv_release] = "Reservation Release",
+	[nvme_cmd_copy] = "Copy Offload",
 	[nvme_cmd_zone_mgmt_send] = "Zone Management Send",
 	[nvme_cmd_zone_mgmt_recv] = "Zone Management Receive",
 	[nvme_cmd_zone_append] = "Zone Append",
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1715a508496c..ce1fec07dda6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -763,6 +763,77 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline void nvme_setup_copy_read(struct nvme_ns *ns, struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_copy_token *token = bvec_kmap_local(&bio->bi_io_vec[0]);
+
+	token->subsys = "nvme";
+	token->ns = ns;
+	token->src_sector = bio->bi_iter.bi_sector;
+	token->sectors = bio->bi_iter.bi_size >> 9;
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
@@ -997,10 +1068,16 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 		ret = nvme_setup_discard(ns, req, cmd);
 		break;
 	case REQ_OP_READ:
-		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_read);
+		if (unlikely(req->cmd_flags & REQ_COPY))
+			nvme_setup_copy_read(ns, req);
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
@@ -1742,6 +1819,26 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1941,6 +2038,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -5244,6 +5342,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 691f2df574ce..702965f5047f 100644
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
index 8f07aee68d59..a10bb80faa9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -508,6 +508,13 @@ struct nvme_ns {
 
 };
 
+struct nvme_copy_token {
+	char *subsys;
+	struct nvme_ns *ns;
+	sector_t src_sector;
+	sector_t sectors;
+};
+
 /* NVMe ns supports metadata actions by the controller (generate/strip) */
 static inline bool nvme_ns_has_pi(struct nvme_ns *ns)
 {
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 492f319ebdf3..c231565b69cf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -495,16 +495,19 @@ static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
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
@@ -848,6 +851,12 @@ static blk_status_t nvme_prep_rq(struct nvme_dev *dev, struct request *req)
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
@@ -894,6 +903,18 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
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
index 0eb79696fb73..be1d20ac8bb0 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -2038,6 +2038,13 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 
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
index bf0230442d57..5ba1bb35c557 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2373,6 +2373,11 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
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
@@ -2441,6 +2446,17 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 
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
index 182b6d614eb1..bbd877111b57 100644
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
@@ -831,6 +835,7 @@ enum nvme_opcode {
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
 	nvme_cmd_resv_release	= 0x15,
+	nvme_cmd_copy		= 0x19,
 	nvme_cmd_zone_mgmt_send	= 0x79,
 	nvme_cmd_zone_mgmt_recv	= 0x7a,
 	nvme_cmd_zone_append	= 0x7d,
@@ -854,7 +859,8 @@ enum nvme_opcode {
 		nvme_opcode_name(nvme_cmd_resv_release),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_send),	\
 		nvme_opcode_name(nvme_cmd_zone_mgmt_recv),	\
-		nvme_opcode_name(nvme_cmd_zone_append))
+		nvme_opcode_name(nvme_cmd_zone_append),		\
+		nvme_opcode_name(nvme_cmd_copy))
 
 
 
@@ -1031,6 +1037,36 @@ struct nvme_dsm_range {
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
@@ -1792,6 +1828,7 @@ struct nvme_command {
 		struct nvme_download_firmware dlfw;
 		struct nvme_format_cmd format;
 		struct nvme_dsm_cmd dsm;
+		struct nvme_copy_command copy;
 		struct nvme_write_zeroes_cmd write_zeroes;
 		struct nvme_zone_mgmt_send_cmd zms;
 		struct nvme_zone_mgmt_recv_cmd zmr;
-- 
2.35.1.500.gb896f729e2

