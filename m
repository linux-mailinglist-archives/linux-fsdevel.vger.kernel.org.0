Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B0F470BB74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 13:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbjEVLRA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 07:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbjEVLPo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 07:15:44 -0400
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 696CA1B1
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 04:10:45 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20230522111043epoutp03fd6e60de23bd0187fed6670cc9281199~hcrHfDwzU1225012250epoutp03d
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 11:10:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20230522111043epoutp03fd6e60de23bd0187fed6670cc9281199~hcrHfDwzU1225012250epoutp03d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1684753843;
        bh=1WJtwnO5PvXiBgPu8IyPQ8G/PqQ97PZnyPYo9MnZUQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vdX184PH29jsk/QU5gEcZK9qXnVnTNVNtw5k97kemp3ylnZdC5VQBH4aHNX6Dd071
         P/lsge+6rzb+8S1WwXJKhmL+/MH/nahPfHIPdmKfv+w+jfVa6Dy9S7TD+javEo6uUV
         06UaMvJ6Z07kHFl6shcOLTsWqi9uhOA5CtN9koiw=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230522111043epcas5p4a30dfec100c198ec352c5e3869dd178d~hcrGv25-s2858928589epcas5p4r;
        Mon, 22 May 2023 11:10:43 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QPvrK5q8Kz4x9Pr; Mon, 22 May
        2023 11:10:41 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        58.39.16380.1BD4B646; Mon, 22 May 2023 20:10:41 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230522104628epcas5p4f5b3f3d7b080950955a127733d554753~hcV76Yjto0301703017epcas5p4p;
        Mon, 22 May 2023 10:46:28 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230522104628epsmtrp1c83ba865935ea43a74a0b42ad6ab0156~hcV73yLeM1451014510epsmtrp15;
        Mon, 22 May 2023 10:46:28 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-00-646b4db1d7a6
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.23.27706.4084B646; Mon, 22 May 2023 19:46:28 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230522104624epsmtip29890dc3f754a2a79816cc006038bc28e~hcV38iRUA1590015900epsmtip24;
        Mon, 22 May 2023 10:46:23 +0000 (GMT)
From:   Nitesh Shetty <nj.shetty@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@redhat.com,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        James Smart <james.smart@broadcom.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        James.Bottomley@HansenPartnership.com, bvanassche@acm.org,
        hare@suse.de, ming.lei@redhat.com, dlemoal@kernel.org,
        anuj20.g@samsung.com, joshi.k@samsung.com, nitheshshetty@gmail.com,
        gost.dev@samsung.com, Nitesh Shetty <nj.shetty@samsung.com>,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v11 5/9] nvme: add copy offload support
Date:   Mon, 22 May 2023 16:11:36 +0530
Message-Id: <20230522104146.2856-6-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230522104146.2856-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te1BUVRzHO/de7i5Mi1fAOouRdNUcQB6LPM6agIyOcwMNgoZpnBzYYW9A
        wLLtspLlFAsoBQGCCbkwPIohXkI8WnktEIi8YigRSIxHAqEhz0pTAmK5UP73+X1/33N+jzOH
        j5vU8cz5YbJoViGTRNCkEaFttzpgW3UqXOqQqbZClT03cZRTWU6iuEurOCobTSPRbPsyQJmL
        T3A00eKBdPPZBuhOaz2Gmr7KwFBJWQeGqtL4qLFgCUOTv/zBQx3rcyTKaBsCaHpQgyHdiA1q
        0nUTaKAhh0Rj5esGKK9omoeSh+tI9E3nGobaLsdjqG5KDZB2JQ9HFbMLBOoa2Y36VzsN0Mrf
        OeTRPczAbW9GM95HMvWaUR7TP1ZFMJkZPSRTU2zNDPSpmOrSz0imejmDx3R9uUIwNYWfMI13
        YkkmJX6eZJamRwhmoXmQZFJrS4Gv6enwI6GsRMoqLFlZcJQ0TBbiRnv7Bx4LdHZxENmKxMiV
        tpRJIlk3+vhJX9sTYREb66Itz0oiVBuSr0SppO3djyiiVNGsZWiUMtqNZuXSCLmT3E4piVSq
        ZCF2Mjb6sMjBwdF5wxgUHrrU/wOQj539YGV6xCAWJAQlAUM+pJzguq4IJAEjvgnVCODVijke
        FywDOBFbjHPBIwDX1PkG20cqbnURXEIH4OerWVuuCxi8npW9cRmfT1I2sHedr9fNqCkczjU8
        3DThVCIBtQNqQm8ypVzh18lm+lsJaj/smPwT6FlAieHgg7FNC6TsYdr4Tr1sSB2G93/S4Jxl
        J+y+OkXoGaf2wPjvsnGuuUeGMPOKEcfHYdPlNR7HpvD3ztotNocP0i5ucQws+aKY1LcGqQQA
        NcMawCU84IWeNFzfA05ZwcoGe062gFd6KjCurjFMWZnCOF0A63K3eS8sr8wnORbCocfqLWag
        dlRNcrtKAfDnwlGDS8BS88w8mmfm0fxfOh/gpUDIypWRIazSWX5Ixsb898rBUZHVYPMLWXvX
        gXsTi3ZtAOODNgD5OG0meDM1WGoikErOfcgqogIVqghW2QacN/adjpvvCo7a+IOy6ECRk9jB
        ycXFxUl8yEVEvyg44NYdbEKFSKLZcJaVs4rtcxjf0DwWo0sG199+6rjQV2sUGSpszfvntdHc
        Ne9YTdwNZZzmr/n3TeXFrRb7dzz/8H5Zfor7gqOcvE5nL73u5+k58UJzblmhT/n3p56zCHjZ
        YvHYRwNkVvWsn0AkTrzbLjdm5gp/FRamis/9xtzS2brv4Hn1xLy1VyD41qfP40RiT5LwncVr
        M+FP7VPwV1+iD0pqyALxzdrOizPO9z6e8x9/r/m0F5vidU2dbr1LhQekZrieGRavmh/1O2O8
        b8gtU0vlT9qY345lVOf3LZwUlxBDxkHvTh3sfQUE1Pe2PJF6ztwIEvarZ1vOJ9tma3d3Cj9N
        VrfKkrzjQx8XvZF+t7AguTHwRx//hEaaUIZKRNa4Qin5F88i9NXLBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpileLIzCtJLcpLzFFi42LZdlhJXpfFIzvFYONUTov1p44xW8xZv4bN
        omnCX2aL1Xf72SxeH/7EaDHtw09miwf77S32vpvNanHzwE4miz2LJjFZrFx9lMliYz+Hxe6F
        H5ksHt/5zG5x9P9bNotJh64xWjy9OovJYu8tbYs9e0+yWFzeNYfN4t6a/6wW85c9Zbfovr6D
        zWL58X9MFocmNzNZ7HjSyGix7fd8Zot1r9+zWJy4JW1x/u9xVovfP+awOch7XL7i7THr/lk2
        j52z7rJ7nL+3kcVj2qRTbB6bV2h5XD5b6rFpVSebx6ZPk9g9Tsz4zeKxeUm9x+6bDWwevc3v
        2Dw+Pr3F4vF+31U2j74tqxgDhKO4bFJSczLLUov07RK4Mj6eP8NYcK+s4vfTW6wNjC0JXYyc
        HBICJhLrLp1g6WLk4hAS2M0ocWvlPDaIhKTEsr9HmCFsYYmV/56zQxQ1M0kcnvCQsYuRg4NN
        QFvi9H8OkLiIwAdmifVbFjGCNDALzGaR6O93A6kRFjCXWNwtAhJmEVCVOPr4C1gJr4ClxNWX
        91hASiQE9CX67wuChDkFrCReXJzFDBIWAiqZsMwIolpQ4uTMJ2DVzALqEuvnCUHskZdo3jqb
        eQKj4CwkVbMQqmYhqVrAyLyKUTK1oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4mWhp7mDc
        vuqD3iFGJg7GQ4wSHMxKIryBfckpQrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJ
        zU5NLUgtgskycXBKNTB5Fm9WuTPN5sbU4htZN6es/rzd/EPOh31HflaWhNlt+clSGudbYleS
        OttE2cORfe2b7xPKNCpnKyzWuv0n9mCOzxOv+WXcrzd28EpsTWo1rHn9sle5oWBFntvLyS/m
        zbuo9CjzOKdQV8Mvj3tb5BMcu47dvxosOjPCZHlx6lP7+1ZbA28HiehfVS/cMPWkbUKh7Npj
        s/my9nrWVga5PXmi/ZKxImR59b21UnnhGZZr9l0UkfO4Umk/99FRk66nt6SOy0mnrVZOv31t
        XX6FxZTb01/dtWyLc7FhcLttnONyTu74724doamfNrpwiHhrWf345bzyd9yjVQtuqU9pYlEU
        rf9/Ra3t/MdD8XqneU4osRRnJBpqMRcVJwIAXAt8NJUDAAA=
X-CMS-MailID: 20230522104628epcas5p4f5b3f3d7b080950955a127733d554753
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230522104628epcas5p4f5b3f3d7b080950955a127733d554753
References: <20230522104146.2856-1-nj.shetty@samsung.com>
        <CGME20230522104628epcas5p4f5b3f3d7b080950955a127733d554753@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
index ccb6eb1282f8..aef7b59dbd61 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -754,6 +754,77 @@ static inline void nvme_setup_flush(struct nvme_ns *ns,
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
@@ -988,10 +1059,16 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req)
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
@@ -1698,6 +1775,26 @@ static void nvme_config_discard(struct gendisk *disk, struct nvme_ns *ns)
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
@@ -1897,6 +1994,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity_and_notify(disk, capacity);
 
 	nvme_config_discard(disk, ns);
+	nvme_config_copy(disk, ns, id);
 	blk_queue_max_write_zeroes_sectors(disk->queue,
 					   ns->ctrl->max_zeroes_sectors);
 }
@@ -5343,6 +5441,7 @@ static inline void _nvme_check_size(void)
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
index bf46f122e9e1..66af37170bff 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -500,6 +500,13 @@ struct nvme_ns {
 
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
index 7f25c0fe3a0b..d5d094fa2fd1 100644
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

