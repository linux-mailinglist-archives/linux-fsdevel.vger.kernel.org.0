Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AB3740B7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 10:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232885AbjF1I3l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 04:29:41 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:14526 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjF1I1d (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 04:27:33 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230628070820epoutp04954d0adbd2260468cc97a77b439e4fb4~swPC4bCzk2165021650epoutp04R
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 07:08:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230628070820epoutp04954d0adbd2260468cc97a77b439e4fb4~swPC4bCzk2165021650epoutp04R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1687936100;
        bh=wSMlvdPvFwtAB8/e51uNbvN3bYNPRI0mv4QVH7XwV0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GtUrjkbXFwZE2Iie3Wdv5x6ajsRUyMRVGm5vN49TnOn8xFEhX4pPy61EDHbclGc4K
         gth+TY02Cf8LqAWw5cBoILQUF70QH+VXP2KqnN94DASqqJUNmVcayMtCydvC9uNiyU
         eEzPyHEKJnLuJcmNLt5PxXZuvMMfm5VsoUP95JSQ=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230628070819epcas5p3e7c2a0b2d01fb1574faeedbabeec20f4~swPCSJqi93258332583epcas5p3o;
        Wed, 28 Jun 2023 07:08:19 +0000 (GMT)
Received: from epsmgec5p1-new.samsung.com (unknown [182.195.38.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QrXjZ4RSSz4x9Q9; Wed, 28 Jun
        2023 07:08:18 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmgec5p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
        47.8E.55173.26CDB946; Wed, 28 Jun 2023 16:08:18 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20230627184039epcas5p2decb92731d3e7dfdf9f2c05309a90bd7~smCPBuM882123321233epcas5p2J;
        Tue, 27 Jun 2023 18:40:39 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230627184039epsmtrp15d4f6e80f7ce7681f39f956a2f505b85~smCPAg96I1856518565epsmtrp1S;
        Tue, 27 Jun 2023 18:40:39 +0000 (GMT)
X-AuditID: b6c32a50-df1ff7000001d785-fa-649bdc628335
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2E.08.30535.72D2B946; Wed, 28 Jun 2023 03:40:39 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230627184035epsmtip2cba789726f5463839dd350f251ac2be5~smCK8QnuT0383803838epsmtip2j;
        Tue, 27 Jun 2023 18:40:35 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
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
Subject: [PATCH v13 5/9] nvme: add copy offload support
Date:   Wed, 28 Jun 2023 00:06:19 +0530
Message-Id: <20230627183629.26571-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230627183629.26571-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02TfzBcVxTHc997+3alZZ4fTW90KmbTxqDsbli5hGqnIk+oajQ6zUyqG/uK
        Lmtnd4n+mNhESUL8ioRaP7JK6mcQQrGkipQwGVUNZUQpIhiCJJpEVK2lzX+fc+753u85587l
        4CbVbHNOqFTJyKWiMC65nahrs7ayOz6cLeb/NbILVXb9gqPTqas4KrubQqLZtiWAMhae4mii
        5QxAfRNGaPQnd9Q8n81Cgy0NGGr6/gKGSspuYmh8+CEb3VybI9GF1n6AJu+oMdQ8ZIvy4wsJ
        1NR8i0B9jTkkuvzDJBslDtSTqKjjHwy1psdiqH7iFEB1K5dxVDH7gECdQ6+hntUOFlp5kkO+
        Y0H3/e5NN6jvsumekWsEXVNsQ/fdjqSrS8+RdE1hDK0dVJF0QXI6i06KnSfpxckhgn5w4w5J
        J18vBXRN99f0w2oLunpiDvOjjkpcQxiRmJFbMtKgCHGoNNiN6+0f+F6g0IkvsBM4o31cS6ko
        nHHjevj42XmGhq3viWsZJQqLXE/5iRQKLu9tV3lEpJKxDIlQKN24jEwcJnOU2StE4YpIabC9
        lFG6CPj8vcL1ws8kIb8VP8JlsV7R57W/kirQ4pIADDiQcoTdnem4jk2oJgDnslgJYPs6LwGY
        1TyJ64NlAEvO9mJbimtjiyy9ohnA2Yz9+qI4DCb3F7ATAIdDUrawe42jy5tRKhxWaQuALsCp
        CgJeLHq+oTal9sGcpPENb4J6E9bUxZI6NqRc4FqulqW7CFI8mPKnsS5tQO2H2p52lr7EGN7K
        miB0jFO7YGxt9kankJo3gGO1JaS+Uw/YPpO2yaZwpuM6W8/mcDolfpNPwJKLxaRe/C2A6gE1
        0B+4w7iuFFzXBE5Zw8pGnj79OrzUVYHpjY1g0srE5lYMYX3eFu+G5ZWaTd+dsP/vU5tMw4GF
        BUK/rWQAp6bS2KnAUv3CQOoXBlL/b60BeCkwZ2SK8GAmSCgT2EmZE/89c1BEeDXY+Dw2fvWg
        rGrVvhVgHNAKIAfnmhnueJIpNjEUi778ipFHBMojwxhFKxCubzwNN38lKGL990mVgQJHZ76j
        k5OTo7ODk4D7quHIwXNiEypYpGQkDCNj5Fs6jGNgrsKKCg0PDgdnTEe1HFINjy6xPrmSc6TF
        /qznp85XfzxuobU//7hD4DyUf6gvuiAqKVFlPb7U9Ua+5L6NZU1lQRjjEcBjpM+ifFR7z4zZ
        WsUcnmFHa/xP8z96KV5zZf5ds7fKA7x6rNzrAuLacwmN7x6np5d6s5/1EwlL5TbPc1zbMht2
        GPtMelkfcBjkL3/3sgMYvD8d0yDUHqiSdHppMmfII0dPnhTm3ZNIMud9c298vjI7ReZqxOa9
        H74/4HvM5IPYQfTF4cht3pKPPaMa79UyvAylacyjnx/zdm5bSWv74xthiSol0XgPg46N+iQO
        pvKK8/yX7ayGdi+NLRqxb5ePXA114RKKEJHABpcrRP8CWoohbsUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrLIsWRmVeSWpSXmKPExsWy7bCSvK667uwUg42X5SzWnzrGbNE04S+z
        xeq7/WwWrw9/YrSY9uEns8WTA+2MFpef8Fk82G9vsffdbFaLmwd2MlnsWTSJyWLl6qNMFo/v
        fGa3OPr/LZvFpEPXGC2eXp3FZLH3lrbFwrYlLBZ79p5ksbi8aw6bxfxlT9ktuq/vYLNYfvwf
        k8Whyc1MFjueNDJabPs9n9li3ev3LBYnbklbnP97nNXi9485bA5yHpeveHvsnHWX3eP8vY0s
        HptXaHlcPlvqsWlVJ5vH5iX1HrtvNrB5LO6bzOrR2/yOzePj01ssHu/3XWXz6NuyitFj8+lq
        j8+b5Dw2PXnLFCAQxWWTkpqTWZZapG+XwJVxacUX5oJmz4qe3RfYGhgPWHUxcnJICJhIbHz4
        kbWLkYtDSGA3o8TruRfYIBKSEsv+HmGGsIUlVv57zg5R1MwkcfXEO5YuRg4ONgFtidP/OUDi
        IgJdzBKdO0HiXBzMAodYJO58XMgI0i0sYC4xp/cx2CQWAVWJzduawTbwClhJ/J+7mxVkkISA
        vkT/fUGQMKeAtcTu80fAwkJAJe+PB0BUC0qcnPkEbC2zgLrE+nlCIGFmAXmJ5q2zmScwCs5C
        UjULoWoWkqoFjMyrGCVTC4pz03OLDQuM8lLL9YoTc4tL89L1kvNzNzGCU4iW1g7GPas+6B1i
        ZOJgPMQowcGsJMIr9mN6ihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHeb697U4QE0hNLUrNTUwtS
        i2CyTBycUg1M9RHi0aySd9Sk777SuBQj8VBnM8M8od3fVZRaxKfl6mxxdimyNnn5arZN5781
        TR83B6pOOLOTOzX339nIZzrFLw6sMFhQnNr+YN0Mqynlyq++B8W/yclXWyfwOPjNmgvHJvRx
        vmzIuTiv9/E/lqXzl+qscZOyOVehu5tb85RelWl7oWCO4an/F1osLdV4kvcs//PY9tj/cjbZ
        WZ9uTCxwfJLy62ueyddPDLGTO/JPJAR8CcvraVhRcjJw6W7L6g9ndXa3m1f6KKikK5/aM2XN
        7gsPCmbPf7wmc7Ljg+OKVZk/2Jsv2t3P5+jZlrt3GvekzbW3Ja78zUy7tWbNJpErRX0nHp08
        OCdup2hRY6zZDCWW4oxEQy3mouJEAD5H9IaQAwAA
X-CMS-MailID: 20230627184039epcas5p2decb92731d3e7dfdf9f2c05309a90bd7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230627184039epcas5p2decb92731d3e7dfdf9f2c05309a90bd7
References: <20230627183629.26571-1-nj.shetty@samsung.com>
        <CGME20230627184039epcas5p2decb92731d3e7dfdf9f2c05309a90bd7@epcas5p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current design only supports single source range.
We receive a request with REQ_OP_COPY_DST.
Parse this request which consists of dst(1st) and src(2nd) bios.
Form a copy command (TP 4065)

trace event support for nvme_copy_cmd.
Set the device copy limits to queue limits.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/constants.c |  1 +
 drivers/nvme/host/core.c      | 79 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.c     | 19 +++++++++
 include/linux/nvme.h          | 43 +++++++++++++++++--
 4 files changed, 139 insertions(+), 3 deletions(-)

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
index 98bfb3d9c22a..d4063e981492 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -763,6 +763,60 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy_write(struct nvme_ns *ns,
+	       struct request *req, struct nvme_command *cmnd)
+{
+	struct nvme_copy_range *range = NULL;
+	struct bio *bio;
+	u64 dst_lba, src_lba, n_lba;
+	u16 nr_range = 1, control = 0;
+
+	if (blk_rq_nr_phys_segments(req) != 2)
+		return BLK_STS_IOERR;
+
+	/* +1 shift as dst+src length is added in request merging, we send copy
+	 * for half the length.
+	 */
+	n_lba = blk_rq_bytes(req) >> (ns->lba_shift + 1);
+	if (WARN_ON(!n_lba))
+		return BLK_STS_NOTSUPP;
+
+	dst_lba = nvme_sect_to_lba(ns, blk_rq_pos(req));
+	__rq_for_each_bio(bio, req) {
+		src_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+		if (n_lba != bio->bi_iter.bi_size >> ns->lba_shift)
+			return BLK_STS_IOERR;
+	}
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
+	cmnd->copy.control = cpu_to_le16(control);
+	cmnd->copy.sdlba = cpu_to_le64(dst_lba);
+	cmnd->copy.nr_range = 0;
+
+	range = kmalloc_array(nr_range, sizeof(*range),
+			GFP_ATOMIC | __GFP_NOWARN);
+	if (!range)
+		return BLK_STS_RESOURCE;
+
+	range[0].slba = cpu_to_le64(src_lba);
+	range[0].nlb = cpu_to_le16(n_lba - 1);
+
+	req->special_vec.bv_page = virt_to_page(range);
+	req->special_vec.bv_offset = offset_in_page(range);
+	req->special_vec.bv_len = sizeof(*range) * nr_range;
+	req->rq_flags |= RQF_SPECIAL_PAYLOAD;
+
+	return BLK_STS_OK;
+}
+
 static blk_status_t nvme_setup_discard(struct nvme_ns *ns, struct request *req,
 		struct nvme_command *cmnd)
 {
@@ -1005,6 +1059,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
 		break;
+	case REQ_OP_COPY_DST:
+		ret = nvme_setup_copy_write(ns, req, cmd);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
@@ -1742,6 +1799,26 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1941,6 +2018,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -4600,6 +4678,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
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

