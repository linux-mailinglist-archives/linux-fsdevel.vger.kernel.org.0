Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2157D7A76B1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 10:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234033AbjITI77 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 04:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjITI7U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 04:59:20 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191FBE4
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 01:58:38 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230920085836epoutp035b8b1fd140c83ec5633529ff2d29e0a4~Gj7TJsPlW1762817628epoutp03y
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 08:58:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230920085836epoutp035b8b1fd140c83ec5633529ff2d29e0a4~Gj7TJsPlW1762817628epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695200316;
        bh=9HUxsYJcUqY59rvCQaWh3ErxEvPd5vF6B6n+YdK8rBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QdG9TGW7/66r/O3y46Ise0DXwmqgH/cZVABF/GpaQCO2UuUf2ZgBRCOoUBO8WQNYZ
         coUzOOXAs2atoKnm9wwHqTL+C4XdIrD3BCTH5cuDXbiOsudKgnxtjJxhvkPWKkFeq1
         uijWZoG/nO2HxIcNTf9HlaHB1R+FSyNgf70LVUJc=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230920085835epcas5p3ce375a9c404fc7a44189faa4cd55798f~Gj7ST4FA_1154311543epcas5p3U;
        Wed, 20 Sep 2023 08:58:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4RrCB0319Vz4x9Px; Wed, 20 Sep
        2023 08:58:32 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.25.09635.834BA056; Wed, 20 Sep 2023 17:58:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230920081529epcas5p33e1ff0e22817262b1cf749616a37d8a0~GjVp1XcJj1820618206epcas5p3e;
        Wed, 20 Sep 2023 08:15:29 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230920081529epsmtrp1289506647955b558123e9cf03eee4f55~GjVp0LLws2250022500epsmtrp1f;
        Wed, 20 Sep 2023 08:15:29 +0000 (GMT)
X-AuditID: b6c32a4b-563fd700000025a3-a1-650ab4385642
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        91.0F.08742.12AAA056; Wed, 20 Sep 2023 17:15:29 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230920081525epsmtip1442b86aed4352b80f58575bee6705cb5~GjVmWJFMM2849128491epsmtip1Y;
        Wed, 20 Sep 2023 08:15:25 +0000 (GMT)
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
        nitheshshetty@gmail.com, anuj1072538@gmail.com,
        gost.dev@samsung.com, mcgrof@kernel.org,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Hannes Reinecke <hare@suse.de>,
        Kanchan Joshi <joshi.k@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v16 07/12] nvme: add copy offload support
Date:   Wed, 20 Sep 2023 13:37:44 +0530
Message-Id: <20230920080756.11919-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230920080756.11919-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUdRTH+d17ubuQ61yB6gdGLOtkAfFYefiDQMgYuYOMUj7KxglWuLIE
        +5jdJSmdEeQ1UDxEjFxeqzASjyARCFxwCBIUSEwCli2UYCGMEOQhNYTEskv53+d8zzm/8/jN
        YeMWRSwbdrRYwcjEglgeaU40djg4OKN6c8atrtoC1XZ34ujJ0gqBzuWs4qhqJJtE0x3zAOna
        0gBqfVxgiobbmjHUciUXQxVVtzA0/usCC91amyFRbvsgQBMDSgy1ap3Q5dQyArW03iFQ/41C
        EpVcnWChz4eaSFTe9QxDmpwJgJp0iQA1rpTgqGZ6lkC3tdtR32qXacB2ulk5wqL7Hlwj6P4f
        4+i6ynSSvl52llYPJ5B0adYFUzoz6TFJP5nQEvTszQGSzqqvBPT1ntP0Qt2rdJ1uBgvd+mGM
        r5ARRDIyLiOOkERGi6P8ePsPhb0T5unlxnfme6PdPK5YIGL8eIEhoc77omPXV8LjfiKIjVuX
        QgVyOc91j69MEqdguEKJXOHHY6SRsVIPqYtcIJLHiaNcxIzCh+/mtstzPTA8Rvjn8g9AWhgS
        X65bZCWA8j0ZwIwNKQ+oSr8MMoA524JSA5jWNosbjHkAR7p6jcZTAGcn1aabKYvLSyyDoxXA
        DI3GmJ+CweS/S9cNNpuknGDPGluvW1EJOPxWXboRhFNJBBysziL1T1lS3jBj7uIGE9RrsL0z
        faMEh/KBukvnTfUPQcoVZj/cppfNqLfgQtkQyxCyDd65pCP0jFN2MKmhADd0d98MzszYGTgQ
        5nT8buzaEv7RVc8ysA18lJ1q5FOwIu9rUt8bpJIBVA4pgcHhD1O6s3F9DzjlAGtvuBpkW3ix
        uwYz1N0KM1d0mEHnwKbiTd4Bq2tVpIGt4eByopFpuDgzaVxpFoDFzffwHMBVPjeP8rl5lP+X
        VgG8ElgzUrkoipF7St3FzKn/vjlCIqoDG3fiuL8JjI3OubQDjA3aAWTjPCuOaKc5Y8GJFHz6
        GSOThMniYhl5O/Bc3/d53ObFCMn6oYkVYXwPbzcPLy8vD293Lz7vZc50SlGkBRUlUDAxDCNl
        ZJt5GNvMJgHrKj4q9Iq/TV6N+iqocPS33viSXTMarvVu6iH/n7ECE9ekxPwXelX5B/y6O22m
        hnPf+9LvgZnOvY+zBUYMnRPHHMrPeNTQsNp74WZAgu3S8YMmc3NTWz7eN3F60EmbN58XwglK
        rguerRT7iw4nWx5pfNd1R+PA2yfevLuX0XxEHVEUHztz4plrjf1ZcOBkjuTMF6OvfPCTXcvP
        Afj4tVaNjzqootPqm7wB+6l70iCfKnlRXjjHxvb7KQvtG4oxOtBby51tGi8m7Ii7x0st+fap
        nJa+Rl8h25E20fq8LsrcGa566T5vrffp3l8mO3uE4+pg1fBf/keDu658d/DY4f73c096ppnw
        CLlQwHfEZXLBv98vK12wBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7bCSnK7iKq5UgxU9vBbrTx1jtvj49TeL
        RdOEv8wWq+/2s1m8PvyJ0eLJgXZGi73vZrNa3Dywk8liz6JJTBYrVx9lsnh85zO7xdH/b9ks
        Jh26xmjx9OosJou9t7QtFrYtYbHYs/cki8XlXXPYLOYve8pu0X19B5vF8uP/mCxuTHjKaLHj
        SSOjxbbf85kt1r1+z2Jx4pa0xfm/x1kdpD12zrrL7nH+3kYWj8tnSz02repk89i8pN5j980G
        No/FfZNZPXqb37F5fHx6i8Xj/b6rbB59W1Yxemw+Xe3xeZOcx6Ynb5kC+KK4bFJSczLLUov0
        7RK4Mt58P8JYMMenYvmTL+wNjMvtuhg5OSQETCS+fP/K3sXIxSEksJtR4vWU50wQCUmJZX+P
        MEPYwhIr/z2HKmpmktjy+hhQEQcHm4C2xOn/HCBxEYEuZonOne9YQBxmgcksEhsfnmME6RYW
        sJTo+jCVDcRmEVCVOHSskxXE5hWwkngycyIryCAJAX2J/vuCIGFOAWuJz0uus4PYQkAlpy/M
        Z4coF5Q4OfMJC0g5s4C6xPp5QiBhZgF5ieats5knMArOQlI1C6FqFpKqBYzMqxglUwuKc9Nz
        iw0LDPNSy/WKE3OLS/PS9ZLzczcxglODluYOxu2rPugdYmTiYDzEKMHBrCTCm6vGlSrEm5JY
        WZValB9fVJqTWnyIUZqDRUmcV/xFb4qQQHpiSWp2ampBahFMlomDU6qBqXXi5uLnitqKaxeq
        BVhXC7pvYU1wzeao7v25IeBz++TU5mrOJ8p1C+O95OY39eZZdvGr7F89Q0dlvf7C1y/dt2Tc
        ltHrbXzG82aS3xpNT49H9R3zOieFdUa7nUnbszK6ltN4U/7xb82rl3z0j+AVVJJzck34wPo1
        Qm+tFmOC2vezPgzv09ZPeX6AtVy6uXoW40KjgqRPv9wkVt4yObK+4HfX9TsRXV9Fe48rr/o3
        YXJopdL2iDIn6XWbtnx8dyC3VeRyrM8hjSafD48iUru+chi/veEQaDHXqK3pt3vX3RlJ7wPe
        ash95bH4+M/F8a1h+4RcSQsPy39uB/TTRWvFV9xRqm3qcvbdsdba2F+JpTgj0VCLuag4EQBw
        0vYYfAMAAA==
X-CMS-MailID: 20230920081529epcas5p33e1ff0e22817262b1cf749616a37d8a0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230920081529epcas5p33e1ff0e22817262b1cf749616a37d8a0
References: <20230920080756.11919-1-nj.shetty@samsung.com>
        <CGME20230920081529epcas5p33e1ff0e22817262b1cf749616a37d8a0@epcas5p3.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current design only supports single source range.
We receive a request with REQ_OP_COPY_SRC.
Parse this request which consists of src(1st) and dst(2nd) bios.
Form a copy command (TP 4065)

trace event support for nvme_copy_cmd.
Set the device copy limits to queue limits.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/host/constants.c |  1 +
 drivers/nvme/host/core.c      | 79 +++++++++++++++++++++++++++++++++++
 drivers/nvme/host/trace.c     | 19 +++++++++
 include/linux/blkdev.h        |  1 +
 include/linux/nvme.h          | 43 +++++++++++++++++--
 5 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index 20f46c230885..2f504a2b1fe8 100644
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
index 21783aa2ee8e..4522c702610b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -763,6 +763,63 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
 	cmnd->common.nsid = cpu_to_le32(ns->head->ns_id);
 }
 
+static inline blk_status_t nvme_setup_copy_offload(struct nvme_ns *ns,
+						   struct request *req,
+						   struct nvme_command *cmnd)
+{
+	struct nvme_copy_range *range = NULL;
+	struct bio *bio;
+	u64 dst_lba = 0, src_lba, n_lba;
+	u16 nr_range = 1, control = 0, seg = 1;
+
+	if (blk_rq_nr_phys_segments(req) != BLK_COPY_MAX_SEGMENTS)
+		return BLK_STS_IOERR;
+
+	/*
+	 * First bio contains information about source and last bio contains
+	 * information about destination.
+	 */
+	__rq_for_each_bio(bio, req) {
+		if (seg == blk_rq_nr_phys_segments(req)) {
+			dst_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			if (n_lba != bio->bi_iter.bi_size >> ns->lba_shift)
+				return BLK_STS_IOERR;
+		} else {
+			src_lba = nvme_sect_to_lba(ns, bio->bi_iter.bi_sector);
+			n_lba = bio->bi_iter.bi_size >> ns->lba_shift;
+		}
+		seg++;
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
+			      GFP_ATOMIC | __GFP_NOWARN);
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
@@ -1005,6 +1062,11 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
 	case REQ_OP_ZONE_APPEND:
 		ret = nvme_setup_rw(ns, req, cmd, nvme_cmd_zone_append);
 		break;
+	case REQ_OP_COPY_SRC:
+		ret = nvme_setup_copy_offload(ns, req, cmd);
+		break;
+	case REQ_OP_COPY_DST:
+		return BLK_STS_IOERR;
 	default:
 		WARN_ON_ONCE(1);
 		return BLK_STS_IOERR;
@@ -1745,6 +1807,21 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
 }
 
+static void nvme_config_copy(struct gendisk *disk, struct nvme_ns *ns,
+		struct nvme_id_ns *id)
+{
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *q = disk->queue;
+
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_COPY)) {
+		blk_queue_max_copy_hw_sectors(q, 0);
+		return;
+	}
+
+	blk_queue_max_copy_hw_sectors(q, nvme_lba_to_sect(ns,
+				      le16_to_cpu(id->mssrl)));
+}
+
 static bool nvme_ns_ids_equal(struct nvme_ns_ids *a, struct nvme_ns_ids *b)
 {
 	return uuid_equal(&a->uuid, &b->uuid) &&
@@ -1944,6 +2021,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -4654,6 +4732,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 1c36fcedea20..82c6aef77c31 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -150,6 +150,23 @@ static const char *nvme_trace_read_write(struct trace_seq *p, u8 *cdw10)
 	return ret;
 }
 
+static const char *nvme_trace_copy(struct trace_seq *p, u8 *cdw10)
+{
+	const char *ret = trace_seq_buffer_ptr(p);
+	u64 sdlba = get_unaligned_le64(cdw10);
+	u8 nr_range = get_unaligned_le16(cdw10 + 8);
+	u16 control = get_unaligned_le16(cdw10 + 10);
+	u32 dsmgmt = get_unaligned_le32(cdw10 + 12);
+	u32 reftag = get_unaligned_le32(cdw10 + 16);
+
+	trace_seq_printf(p,
+		"sdlba=%llu, nr_range=%u, ctrl=0x%x, dsmgmt=%u, reftag=%u",
+		sdlba, nr_range, control, dsmgmt, reftag);
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
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index e0a832a1c3a7..ce2009b693c8 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1226,6 +1226,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 
 /* maximum copy offload length, this is set to 128MB based on current testing */
 #define BLK_COPY_MAX_BYTES		(1 << 27)
+#define BLK_COPY_MAX_SEGMENTS		2
 
 static inline unsigned int bdev_max_copy_sectors(struct block_device *bdev)
 {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 26dd3f859d9d..7744538c4ca4 100644
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
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u64			rsvd2;
+	__le64			metadata;
+	union nvme_data_ptr	dptr;
+	__le64			sdlba;
+	__u8			nr_range;
+	__u8			rsvd12;
+	__le16			control;
+	__le16			rsvd13;
+	__le16			dspec;
+	__le32			ilbrt;
+	__le16			lbat;
+	__le16			lbatm;
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

