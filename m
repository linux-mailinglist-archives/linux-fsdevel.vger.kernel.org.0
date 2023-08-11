Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6C6778D6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Aug 2023 13:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236416AbjHKLUq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Aug 2023 07:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbjHKLUd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:20:33 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5556D213B
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 04:20:28 -0700 (PDT)
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230811112026epoutp03c734cfc92e26233d4f9722c128e921c9~6UDt1vd5f0704807048epoutp030
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Aug 2023 11:20:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230811112026epoutp03c734cfc92e26233d4f9722c128e921c9~6UDt1vd5f0704807048epoutp030
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1691752826;
        bh=4Vjh8jwG0kYYQt6i9ondDdVvZ3v2Im7HOf7zw+Uj2sQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gS5PBhHK4YSaWhL5SBO/mzIGaNeleyMA1UjMbK+qR/SsONZvOV4+yNyVoF3GeKIg1
         nm6NwNjaycQBjMzMDyDPPefcDAwDb8yFSmveyxoL735BquELFwpQ7tqJtLyjMYq4wF
         Hg099C/Kb7pepOGGaqX1LT0O8auD8XxblPq5V41c=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20230811112025epcas5p15a62090dc6b698757b644199b1e0f6f4~6UDtKwger1521915219epcas5p1L;
        Fri, 11 Aug 2023 11:20:25 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.177]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4RMhD81zfFz4x9Pv; Fri, 11 Aug
        2023 11:20:24 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        92.7D.55522.87916D46; Fri, 11 Aug 2023 20:20:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230811105745epcas5p451c58384792038c13e9891fb2680050b~6Tv6X8lr02061520615epcas5p43;
        Fri, 11 Aug 2023 10:57:45 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230811105745epsmtrp1b4f6590d7b9a00ac35516901ce339344~6Tv6W8ZrF0371503715epsmtrp1a;
        Fri, 11 Aug 2023 10:57:45 +0000 (GMT)
X-AuditID: b6c32a49-419ff7000000d8e2-f5-64d619783b61
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        60.11.30535.92416D46; Fri, 11 Aug 2023 19:57:45 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230811105740epsmtip24f524394f030b1378699f705026e5d1a~6Tv2OJhKW1206312063epsmtip2n;
        Fri, 11 Aug 2023 10:57:40 +0000 (GMT)
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
Cc:     martin.petersen@oracle.com, mcgrof@kernel.org, dlemoal@kernel.org,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v14 07/11] nvme: add copy offload support
Date:   Fri, 11 Aug 2023 16:22:50 +0530
Message-Id: <20230811105300.15889-8-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230811105300.15889-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01TfVCTdRzn9zzj2QCnD4jnD4qaQ04mDJgN/IEsoDx7av3BhWcoXDTZ0+AY
        224vqF0vIO94wgBNmxmYFg2Il2kciCRChsKh1xACCuICDJq8d3AeKTGfUf73+X6+38/39b4c
        3COH7c1JVelprUqm5BOurKZOgb/wuNeAPKSwnoPqu3/C0UnjExzVjJQQyNa5CNBEez5AYzej
        UNvsBWc01N6CIXPNbQyN/7bERrfXZghU1jEA0GS/CUNtwwHoUt4VFrrRdpeF+q5/QaCKbybZ
        qKrrKYYGjZMANa1W4KjONsdCd4ZfQPefdDlHQ+r+aCOL6us1UJbqQoK6euVTqnUok6AuF5c7
        U6ezZwlqYXKYRc390E9QxdeqAbVkeYmyTMxgsZuOpEWm0DI5reXRqmS1PFWlkPClcUmvJ4WG
        hYiEonC0l89TydJpCX//27HCA6nK9cn5vAyZ0rBOxcp0On7wq5FatUFP81LUOr2ET2vkSo1Y
        E6STpesMKkWQitZHiEJC9oSuB76fltJYYyM0o9LjpTWfgUywICkCLhxIiuHKSDdWBFw5HmQr
        gD//YWMxxiKA1pFCwBjLAJ5fMBIbknONN3DG0QbgpfEChz4Xg/W1RnYR4HAIMgD2rHHsvCeZ
        icOG1svArsZJMw7zb/rZ8VYyHBpXrmJ2zCL94OPaMbYdc8kI2FCWBex5IBkMS353t9Mu5D44
        Z7ESTIg7vPv5BItJ+TLM/v7Cs4YgWeUC83Om2Eyn++Hsw2UWg7fCv7quOXhvOF2S58DHoPnM
        twQjzgHQ9IsJMI4omNtdgtubwEkBrL8ezNA+8Gx3HcYU3gxPr05gDM+FzV9uYF9YW1/p2JYX
        HFjJcmAKPuh+5FhpMYBfDZUTRsAzPTeQ6bmBTP+XrgR4NfCiNbp0Ba0L1YhU9LH/zpysTreA
        Z++w+81mMDI2H9QBMA7oAJCD8z25kjir3IMrl534kNaqk7QGJa3rAKHrCy/Fvbclq9f/SaVP
        EonDQ8RhYWHi8FfCRPztXFvuRbkHqZDp6TSa1tDaDR3GcfHOxEKn2xM+2iVIiMl2WpWpM04s
        v3Voj49526bAqN6zbu/FmeNn438dt2rLB01uDxSJqXeOSqWHg3yJj/ufOiW+e2vB32Pw8dy0
        dMfOSDa965z1x1PNA32Cus0Hwd7ARpXPYun2UVPMP28ECngByYZO4ZKt5euoR4SwZ36oalCg
        uJiXJbN62nrxUzuph/6InsQEza+dvLWa8M4Z18q1Qy7fzayYznO78uVOFUlb9MrU6M0qeVlM
        T/50fHPTwCdzLRHAfYeb0wzWajl45APJPY1z64tTpWk5fx4o6D0svmeOliQ2bimY2DdKZdRJ
        p4RT/AYnbX9e7rBf199H5/044b5FPQ39fJYuRSbajWt1sn8BmBDGp5cEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Ra1BMYRiA5zvn7NnTUTptzfgqo7GY2MbmNnxSacwYx8hg+KN+ZLWnwm7W
        7uayGCWTaYesapgu7tmoFe1WpIvVXYSxmGrYXWzMWNuGISYrjsbw73mf93m/Px+Fix4SYdS2
        TC2nzpQpxCRNNLSLI+bOCXkun3fLFIiu93bh6LDBh6PqlydI5G7/BJDLehQg553lqGW4TIAG
        rI0YulrdiaE3Lz4LUee4h0SFbc8BGnpWiqGWwSh0Ia+CQM0t9whku11OonPGISGq7P6JoX7D
        EEANY+dwVOP2EqhnMBw98nULEiD7yF5LsLa+LNZclU+ylopDbNNANsleKigSsMdzh0n249Ag
        wXpbn5FsQV0VYD+bp7Fmlwdb759Ex8o5xbbdnDo6fgudUVvtJlX2NXtPVp8C2eBjnB74UZBZ
        BE/XNuN6QFEipgnAUcWEDoVGXwc+wcHw6s93Qj2gfye5GOz2OP/0JBMF749TvA9h9DjMbxwm
        +AFn6nHY4RgF/HUwsxQaRi0YzwQzC343OYU8BzAx8EZhDuAfgkw0POEI4rUfswx6zU9InkW/
        kxHjXTCRB8F7JS6Cz3EmEl4/K+I1zkTA3Poy3ACCSv+rSv9Vpf9V5wFeBUI5lUaZrtTMVy3I
        5PZINTKlJiszXZq6U2kGf75cIrkFmqtGpG0Ao0AbgBQuDgmI2/hELgqQy/bpOPXOFHWWgtO0
        gXCKEE8J+Oo+Lhcx6TItt4PjVJz67xaj/MKysQIJkdWRQhf2TY7WDfQlmw4mWPovRPnXHRoe
        S11cHHlHkiwM3miHCavSlsz4kWE51Vt2oMlp6JmunbQd++IxFXWN0zY6tNUe23jTf67XUvdl
        17cSry88sEKfp7Yf2fxKfbl4iU6vtGiDnz6It461nw/7wDlm396T6NwU5n5v7H+ZU7K1KI9+
        60i8fPF1zqyZaQs2JO9vjbcpXGnLlo/Q446Um2eP5b1ZK90sXbG+5Eg4d2n17oRUPCSy8mtN
        XG+Ss3Pdg87YKNWZi8YY3cokX2yK8fG1Llu+y5uYU7zwfqKuxb26MqLHWmndCsfq66deEQRG
        C/SemIYacbno8CeTVkxoMmTzJbhaI/sF1dTTHWEDAAA=
X-CMS-MailID: 20230811105745epcas5p451c58384792038c13e9891fb2680050b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230811105745epcas5p451c58384792038c13e9891fb2680050b
References: <20230811105300.15889-1-nj.shetty@samsung.com>
        <CGME20230811105745epcas5p451c58384792038c13e9891fb2680050b@epcas5p4.samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
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
index 37b6fa746662..214628356e44 100644
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
+	u64 dst_lba, src_lba, n_lba;
+	u16 nr_range = 1, control = 0, seg = 1;
+
+	if (blk_rq_nr_phys_segments(req) != COPY_MAX_SEGMENTS)
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
@@ -4634,6 +4712,7 @@ static inline void _nvme_check_size(void)
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
index 67eab354592c..a31e0ba5badd 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1226,6 +1226,7 @@ static inline unsigned int bdev_discard_granularity(struct block_device *bdev)
 
 /* maximum copy offload length, this is set to 128MB based on current testing */
 #define COPY_MAX_BYTES		(1 << 27)
+#define COPY_MAX_SEGMENTS	2
 
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

