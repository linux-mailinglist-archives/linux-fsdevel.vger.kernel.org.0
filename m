Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF9E794277
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Sep 2023 19:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238652AbjIFRzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Sep 2023 13:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbjIFRzU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Sep 2023 13:55:20 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B3E1FD3
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 10:54:38 -0700 (PDT)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230906175436epoutp04ccb5efa9f575566e24e17c7891699a84~CYNTESroo3253832538epoutp04m
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Sep 2023 17:54:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230906175436epoutp04ccb5efa9f575566e24e17c7891699a84~CYNTESroo3253832538epoutp04m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694022876;
        bh=a19feNzCM8YoC5A7Icgh5vn6F8BWUj7AdePHuFwtv5A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ittHUm8eNC+GWyWGJeGyGzbSC9GY1t4jn2kqsWuTtUNCFWIBTNb29VbsxNov1t48z
         kphoosdfkc0an+jPPnQ/ZyVSERwo/aULfwOvCX/Jx64KscHfSSOZXaL901RYdoyvdY
         Xxp2ASB3KbuV5gtxFmfRdJ73zKMcGCN4wmkxKJuA=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20230906175435epcas5p25ce2c2d2b490e17a6a84b20fd8d6bd0c~CYNSFz1eV0601706017epcas5p2I;
        Wed,  6 Sep 2023 17:54:35 +0000 (GMT)
Received: from epsmgec5p1new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4Rgqky3f2cz4x9Pq; Wed,  6 Sep
        2023 17:54:34 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmgec5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        C1.54.09023.ADCB8F46; Thu,  7 Sep 2023 02:54:34 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20230906164350epcas5p3f9b8bca1a2cb4d452e5c893cd3222418~CXPf95GiN1472314723epcas5p3e;
        Wed,  6 Sep 2023 16:43:50 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230906164350epsmtrp236e82371e2429b25ec5e9675f68097e9~CXPf83tBw1133211332epsmtrp2Y;
        Wed,  6 Sep 2023 16:43:50 +0000 (GMT)
X-AuditID: b6c32a44-c7ffa7000000233f-21-64f8bcda84ec
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        E8.0B.08742.54CA8F46; Thu,  7 Sep 2023 01:43:49 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230906164346epsmtip2326fb8f66be427002c9852de2920b333~CXPc9TPkF1883018830epsmtip2e;
        Wed,  6 Sep 2023 16:43:46 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v15 07/12] nvme: add copy offload support
Date:   Wed,  6 Sep 2023 22:08:32 +0530
Message-Id: <20230906163844.18754-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230906163844.18754-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta0xbZRj2O6ccClI9lAnfIDpyiFsYcqkr3VccajZijgEjlWiGWcLO6AkQ
        eksvzl3QArIBGTeZy9YphTEZN2ErOMulgIXJRReYcwg42AxtzMaACBsscrOlRffveZ487/O9
        7/vl5eL8bM9AboZCy6oVjIwivDnXe0NDwyc6n0qjejv9UPPQTzjKKV3DUcNkCYFmehcAsvWc
        Bsgyd9EDjfe0Yaiu4QaGpu8ueqIbG7ME+tI6CpD9jgFDlokwVHXqMgd1WgY56Hb71wQy1tg9
        0ZX+dQyNldoBur5ixFHTzDwHDUwEoeG1fo+3A+jhqWsc+vZNHW2qLyDolsuf0x3jeoKuLi73
        oIty5wj6b/sEh57vukPQxa31gF40vUKbbLNYos/HmfvSWUbKqoNZRapSmqFIi6Xik1IOpESL
        ogThAjHaSwUrGDkbS8UlJIa/kyFzTE0Ff8LIdA4pkdFoqMg396mVOi0bnK7UaGMpViWVqYSq
        CA0j1+gUaREKVhsjiIp6PdphPJyZblxrI1Tz8Z/WPckn9GAjthB4cSEphGslZlAIvLl8sgPA
        lYdWN1lwkPwHhIssATjS/QexVbJw0+R2WQDUj1W5SR4Gu6Zb8ELA5RJkGPx5g+vUt5F6HF7t
        qN404WQ5Dku/LQLOKD9SDP+xtWxiDvkqHOuxejgxj4yBK7l24AyCZCQsuefrlL3IN2BO9i3g
        svjCwQs2jhPj5A6Y+/1F3JkPySte0DB7H7hajYP3fmlwt+0HH/a3erpwIFycs7j1o7DubC3h
        Kv4CQMPvBnfxWzBvqGRzGpwMhc3tkS75ZfjVUBPmevgFWLRiw1w6D5ortnAIbGyudOdvh6PL
        2W5Mw5m78x6ubRUDOFBhJ0pBsOGZgQzPDGT4/+lKgNeD7axKI09jU6NVAgV79L9/TlXKTWDz
        FnbHmcGYcT3CCjAusALIxaltvLkdS1I+T8ocO86qlSlqnYzVWEG0Y+FleOBLqUrHMSm0KQKh
        OEooEomE4j0iARXAm8n7Rson0xgtm8myKla9VYdxvQL1WItEU1v5Q8KHUyPZc/UbzKOUQwLV
        +/t9dzluJTNrep0V919jC+7LC7gfhB9JMItDmw6tXuiaOR4SIBmf3sF7rdHnr5GDZ9oMp14k
        ag5bZk+KJkEllTx7eqCy9fF3Wv7BspD9kuWannc1q2Ixs5BhNyrKg/CGj6oe6+KyV71N5snP
        bvX2NAZQioXl2m5s55HupA7vfr30/K8rfVnzU4mj+QnJSVhBe97zKjbR/+kJ217Je/yT/WV9
        JzqlYeeuPhAVYN2ePH5yo8+Tvuql8/4aY5n8x8aO5+KL/5RJKqbPDgSRjGmX2Sg5dmBPvvqR
        IWfYXxgzuvO3M1lr2txLg5fOlVEcTToj2I2rNcy/GTIN95QEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA03RWUwTURQGYO7MdDo0VKdFw0WixRKjghQhJF5X1IQwojFoAibGINUOtUoB
        WzaXCFqDQlgKPigIVlyKFBWsCyKitYpYFQEVA7hGWjBBimDEBSs6EiNv//3Pd87LpXDxY2Ia
        pUpMYTWJ8gQpKSCu3ZVKAsPPf1PMtw6FoJqH93F0QO/CUfXrQhL13x0GyG45BFCj8zgPdVnq
        MVRV3YShnlef+ahpbIBExdYXADk6SjHU2B2AKrLPEOhmo41Az26UkchgdPBRZfMvDHXqHQBd
        GzXg6GL/IIEedPugVlczb7kX0/rmEsE8a0llzKYckrl8JpNp6MoimdMFR3hMvs5JMkOOboIZ
        vNVBMgVXTID5bJ7BmO0DWJTHRsESBZugSmM1QcviBNsMrnoyeXB1RtWXw2QWGFuaC9wpSIfC
        4RYzyAUCSkw3AHhQ30KOD7yh0XUPH8+esOpXH38c6TB4tPIdlgsoiqQD4KMxiuun0Lk4zKl3
        EtwDpw04fNfcwue2PemF8If9MuAyQc+CnRYrj8tCehEc1TkAdwjSQbDwrYir3enF8MD+9r9c
        /Ie8MvWDcS6CthI7wXGcng1rToi5GqclUHf1OK4HotIJqvS/Kp2gTgLcBLzZZK1aqdYGJwcn
        sukyrVytTU1UyrYmqc3g74f7z70O6kyfZFaAUcAKIIVLpwidkhGFWKiQ79rNapI2a1ITWK0V
        +FCE1Evo9SFfIaaV8hR2B8sms5p/U4xyn5aFrZfXjOzX73yyQNUZuSfWFbeiP8qtt3203Dlp
        iyMgMH7vMD8t+GCml6QDvAw7pZhZ52dr07clebh9EkX7lkRFOvoWWQYrh+YFTl0XV9a0J0dX
        tn2tyq++PMinZu68iucRh0aVK3nnOvPLvwPfUJmy4Geh2tj20uAYeJC9+uabomhbanhDjF3i
        dkQlOWbMmiExlN2Lj631INSbalUx7cUfD9+Zqvfb4AoRGi94fFsjcoor5FvWyJTZAhnxMOy9
        aKw1b1W8Z9Ht9hTXnZGIykjb1/O1TPp0y+lM73WFfftEdXlhXXOKLmIBCU+XZOSF9vrH2Hri
        z0523Q8pXsp6psXqGCmh3SYP9sc1WvlvTbVhxF8DAAA=
X-CMS-MailID: 20230906164350epcas5p3f9b8bca1a2cb4d452e5c893cd3222418
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230906164350epcas5p3f9b8bca1a2cb4d452e5c893cd3222418
References: <20230906163844.18754-1-nj.shetty@samsung.com>
        <CGME20230906164350epcas5p3f9b8bca1a2cb4d452e5c893cd3222418@epcas5p3.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index f3a01b79148c..ca47af74afcc 100644
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
@@ -4638,6 +4716,7 @@ static inline void _nvme_check_size(void)
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

