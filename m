Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECEBA4AC1ED
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Feb 2022 15:56:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386953AbiBGOxo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Feb 2022 09:53:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1392429AbiBGOaf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:30:35 -0500
Received: from mailout1.samsung.com (mailout1.samsung.com [203.254.224.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA69C0401C3
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 06:30:33 -0800 (PST)
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220207142305epoutp019d1466e8108ec0ab0a4bdc2f748554ea~RhwMEOlmX2820228202epoutp01r
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Feb 2022 14:23:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220207142305epoutp019d1466e8108ec0ab0a4bdc2f748554ea~RhwMEOlmX2820228202epoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1644243786;
        bh=xOhC5Z0mtqhR3NOPY9is4yrUyzdDDxaTQICw09I93/Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t4LQWxu018h53AaUQW1d7vj0Ccynl6Qdt9b9nkquo/J8PcwYoM4OZQChQHg1jefIG
         mmBGH7OPQNvTsPAwpyYwqCGGD8klV5N1K9bAbclwo71EvaYiOnDHGtS58UIvt2DHDz
         WHHBwCZTRfgUmYPWLd/XsMUd9dpcZdjbUJOvuLC4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220207142305epcas5p2ff4e4b06df080e3d375108412dc39c23~RhwLLTSvz2954829548epcas5p2w;
        Mon,  7 Feb 2022 14:23:05 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.174]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4JspJg5nj9z4x9Pp; Mon,  7 Feb
        2022 14:22:59 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FA.C5.05590.8FA21026; Mon,  7 Feb 2022 23:21:44 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20220207141937epcas5p2bd57ae35056c69b3e2f9ee2348d6af19~RhtKA1RZ63251132511epcas5p2W;
        Mon,  7 Feb 2022 14:19:37 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220207141937epsmtrp242a585e677152566b2dc96fea631dfa3~RhtJ-UHAa0819908199epsmtrp2g;
        Mon,  7 Feb 2022 14:19:37 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-7c-62012af80248
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        61.04.29871.97A21026; Mon,  7 Feb 2022 23:19:37 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220207141933epsmtip179dc5ee3f0ab749ff8c5fd23d7d0fe41~RhtF70vg90564005640epsmtip1K;
        Mon,  7 Feb 2022 14:19:33 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     mpatocka@redhat.com
Cc:     javier@javigon.com, chaitanyak@nvidia.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        dm-devel@redhat.com, linux-nvme@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        msnitzer@redhat.com, bvanassche@acm.org,
        martin.petersen@oracle.com, roland@purestorage.com, hare@suse.de,
        kbusch@kernel.org, hch@lst.de, Frederick.Knight@netapp.com,
        zach.brown@ni.com, osandov@fb.com,
        lsf-pc@lists.linux-foundation.org, djwong@kernel.org,
        josef@toxicpanda.com, clm@fb.com, dsterba@suse.com, tytso@mit.edu,
        jack@suse.com, joshi.k@samsung.com, arnav.dawn@samsung.com,
        nj.shetty@samsung.com, SelvaKumar S <selvakuma.s1@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>
Subject: [PATCH v2 06/10] nvme: add copy support
Date:   Mon,  7 Feb 2022 19:43:44 +0530
Message-Id: <20220207141348.4235-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.30.0-rc0
In-Reply-To: <20220207141348.4235-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01Ta1BUZRjuO+dwdsFgjgvFB9VAizEDCO7msn0gaBfNM8IITjNZTCMcluPC
        ALvbnqXIGkEXEEREoIyLKRQD426FQ0AEu6ggMSARgYAQRchtxOQixEW5xLJL+e95n/d9n2ee
        95uPjwvqeM78GIWGVSuYOCFpQ9Q0eXh4L3mCSNFAvhsy9M9ZIf0f2SS6OLOMo+mbI1YoNzuf
        h7pH7ZBxqsgKdS6dwtBI5TqGDF/nYuiqvhlDE+XfADQyOMdDGbc7MbQyLEbN6w9JlNvYC5Bx
        wAsZjK0EulI2xkOZfbUkanhgxFF5yxqGctJ7MNRRuEKimidXcNT0Zw+B9CsIPVhqJVHquWUe
        mrx+7HUXuvtOEJ2jneLR2uJBgu7+JYGu1GWQ9A+lSXTe3XJA1/cnk/Tp9maczn80T9J97T9i
        dJZ2iqRnxwYIumY4i0dPN/SQ9PkqHQh1CIsNiGaZKFbtyipkyqgYhTxQGPRO+FvhvlKR2Fvs
        h14TuiqYeDZQuD841PvtmLiNcwldP2LiEjaoUIbjhLv2BqiVCRrWNVrJaQKFrCoqTiVR+XBM
        PJegkPsoWI2/WCR61XdjMCI2er5siVBNRCSOd83wkkHZ4bPAmg8pCcw4M2B1FtjwBVQ9gKmG
        ZsxcPAKwKWURmIsFAB/fzSW3VlbzblimjACmtXURpoaASsXg5bbAs4DPJykveHudb6IdKEe4
        0lmzKYRTg1Yw7cw0MDXsKRH8sli7KUpQr8DaiT7MhG0pP9hWks8zm7nBkuGbViZsTfnDhZWL
        hHlmO2wtGN3EOOUCtdVFuMkAUgvW8P53XwHz8n5Y1FNtEbKHky1VFuwM56aMpHkhE8Cl9iHM
        XOQDqL2gteTcB38zrGKmODjlASvqdpnpl+AXbd9jZmc7mPVkFDPztrD28hZ2g99WFFtknGDv
        4ikLpmFBWbHldHcAPFeaTVwAroVPJSp8KlHh/9bFANcBJ1bFxctZzle1W8F+/N87y5TxlWDz
        E3kG1YJ7f834NAKMDxoB5ONCB9sXM9cZgW0U88kJVq0MVyfEsVwj8N04eQ7u/JxMufELFZpw
        scRPJJFKpRK/3VKx0NG2TX6NEVByRsPGsqyKVW/tYXxr52SsgTio5z5N8viJi7znc/6FX4dm
        BvumAxnh6hLRu+3ngxMZVS12grWerOAIDAX7vlH32XGJ0klzQPJPNXdy0stwdPFZ2XhB2+m4
        l+vmU6UegllRvwC67cyp1onfNySWREr3jR0pehj2HpBNuljvaUeCQ1d95vXbZ91XEmvu9wQc
        l9OX/u4Vh4T01WWePGGUfe5ya+D3PHfmUFfFePCOnKRLrW8upJfuuFZy/cNt9lCfNRhW6jma
        3qH/wN8zM1bwzM69w8/vSSmZg47jvjYzzUc7mrDQw6GzuthWV4E2Jcj9WGt3wXIus6arToue
        OjCZCGSPV1PQrXp5e+W7R+aGot1uhAgJLpoRe+JqjvkX3knPCs0EAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sb0xTdxSG87v39vbSDXepbP3xJ6Ili7Eo0v1JDhtRN+J2IwvxAx8YY2qd
        N0CE0rSAo87YcWdDq4wJiUDNEDZSBDQzbFYMVG0Zc1WKDayrEkAarHUjAp1s4lbsUptlfntz
        3uec58thSKlRlMyUqat4rVpVLqcllG1Yvm5LrQLtzzLelcHQnUci6JtupOHU0hMSFh1zImhq
        bBXDxL01YF84LQLPyucEzPVHCBj6pomAnr4RAoLd3yKYm3okBtNNDwFhvxJGIg9paHL+isA+
        mQFDdhcFZ6wBMRz3DdBwZd5OQvf1pwScrPcSMGYJ02D75wwJwzNeCvrCAPMrLhqOnXgiht+v
        7tmRxk38ksedFBbEnNAxRXET7mquv9dEc993HeWab3cjbvCOgebqRkdIrvWPZZrzjV4iuAZh
        geZCgUmKs/kbxNziFS/NfflDL9qdWCTJOcCXl9Xw2q3b9klKl60rlCa479P740tiA7Lmm1Ec
        g9k38GrzNcKMJIyUHUTYN2imY0UStq7+SMbyWtzzNCiOQQKBhXojMiOGodkMfDPCRJlEVobD
        HhuKMiRbR+PGlmkqWqxls3BLh/DsKMW+igeCPiKa49lsfKOzVRwTpONOv0MUzXHsW/iv8Ckq
        JjMgbBg7K4otJGBX2z0qKibZjfi7dml0TLJpWLh4mvwKJVieoyz/U5bnqA5E9qIkXqOrKKnQ
        KTVKNX8oU6eq0FWrSzI/qazoR89eRbFpAF3qXcp0IoJBToQZUp4Yn3o8opLGH1DV6nlt5V5t
        dTmvc6IUhpLL4j1m114pW6Kq4g/yvIbX/tcSTFyygRibGTDeulC5UZ/PryF6Xt8uRHLTUxO+
        MMnWDW9+2LqrZSY3tBgq+rBQr6+ayrlhLpCkCHd/Mnh/e+Du6H7xdmeGcqeoPJD1vj99xlL8
        0d/jgXHbY69xNu+c0aheTrFfHk1bdpP30XnnS0fKBo/4feccX1/P0eI6qWJ2u3XLiWKD/b3h
        YEFpomlrzTVXTW4eXHzFtD6w7UI7tKTLC7si9DvztXveHDn6GuU+tjl3U1FOY9s0rP7s2VD/
        2fn9lw876B2TO/vyP/7gQXthERs4tH5D5y1FcleDzLSkSQrpX+avzo7Sf7YddEvedWS/kPrY
        HJKrC94GOqX4cLLNl90cksopXalKqSC1OtW/lQLtEJkDAAA=
X-CMS-MailID: 20220207141937epcas5p2bd57ae35056c69b3e2f9ee2348d6af19
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220207141937epcas5p2bd57ae35056c69b3e2f9ee2348d6af19
References: <CAOSviJ0HmT9iwdHdNtuZ8vHETCosRMpR33NcYGVWOV0ki3EYgw@mail.gmail.com>
        <20220207141348.4235-1-nj.shetty@samsung.com>
        <CGME20220207141937epcas5p2bd57ae35056c69b3e2f9ee2348d6af19@epcas5p2.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: SelvaKumar S <selvakuma.s1@samsung.com>

Add support for Copy command
For device supporting native copy, nvme driver receives read and
write request with BLK_COPY op flags.
For read request the nvme driver populates the payload with source
information.
For write request the driver converts it to nvme copy command using the
source information in the payload and submits to the device.
current design only supports single source range.
Ths design is courtsey Mikulas Patocka's token based copy

trace event support for nvme_copy_cmd.
Set the device copy limits to queue limits. By default copy_offload
is disabled.

Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Javier González <javier.gonz@samsung.com>
---
 drivers/nvme/host/core.c  | 121 +++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h  |   7 +++
 drivers/nvme/host/pci.c   |   9 +++
 drivers/nvme/host/trace.c |  19 ++++++
 include/linux/nvme.h      |  43 +++++++++++++-
 5 files changed, 194 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e0bfda04bd7..49458001472e 100644
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
@@ -1682,6 +1772,31 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
+		blk_queue_flag_clear(QUEUE_FLAG_COPY, queue);
+		return;
+	}
+
+	/* setting copy limits */
+	blk_queue_flag_test_and_set(QUEUE_FLAG_COPY, queue);
+	queue->limits.copy_offload = 0;
+	queue->limits.max_copy_sectors = le64_to_cpu(id->mcl) *
+		(1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_range_sectors = le32_to_cpu(id->mssrl) *
+		(1 << (ns->lba_shift - 9));
+	queue->limits.max_copy_nr_ranges = id->msrc + 1;
+}
+
 static bool nvme_ns_ids_valid(struct nvme_ns_ids *ids)
 {
 	return !uuid_is_null(&ids->uuid) ||
@@ -1864,6 +1979,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	nvme_config_discard(disk, ns);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
+	nvme_config_copy(disk, ns, id);
 
 	set_disk_ro(disk, (id->nsattr & NVME_NS_ATTR_RO) ||
 		test_bit(NVME_NS_FORCE_RO, &ns->flags));
@@ -4721,6 +4837,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_download_firmware) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_format_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_dsm_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_copy_command) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_write_zeroes_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_abort_cmd) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_get_log_page_command) != 64);
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

