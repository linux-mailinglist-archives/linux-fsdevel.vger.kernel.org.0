Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12647225D4
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Jun 2023 14:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233332AbjFEMaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Jun 2023 08:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbjFEM3y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Jun 2023 08:29:54 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529B412A
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 05:29:47 -0700 (PDT)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230605122945epoutp047c1bcfb117469c873bbb2629b45c4629~lwyHVFQBZ1876818768epoutp04X
        for <linux-fsdevel@vger.kernel.org>; Mon,  5 Jun 2023 12:29:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230605122945epoutp047c1bcfb117469c873bbb2629b45c4629~lwyHVFQBZ1876818768epoutp04X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1685968185;
        bh=TBNd/dnNsAHe6X0oTWIBGxw9WAVD6NR0t+TrHecNZK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uKMdLDoOo+lJd7GtbnZ03O+7Rc5YKDjiPorKd8BjZbeuCHDRAk7YoBlXRbcoNxao3
         PbVJzgfpnJJLbFH4J/bYWzwqvFUgn48R48gzfWZNKo5nJzf4ukvVwzYuTK7tLDgXmJ
         ITv1tKvna3Zjausswket4K3CvqMfBKzaDZhkRqT4=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20230605122944epcas5p3f477ea1077cb5e5f3b040e4d898986b9~lwyGrZo892911529115epcas5p3C;
        Mon,  5 Jun 2023 12:29:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4QZXx34c2cz4x9Pp; Mon,  5 Jun
        2023 12:29:43 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        98.5D.16380.735DD746; Mon,  5 Jun 2023 21:29:43 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20230605122330epcas5p18a452356d5bc39b852b85304bac5b0cc~lwsqKi6O71025410254epcas5p1H;
        Mon,  5 Jun 2023 12:23:30 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230605122330epsmtrp14a9fa7dbfc34f25df40badb6d08bbe6c~lwsqJfPPq1611816118epsmtrp1E;
        Mon,  5 Jun 2023 12:23:30 +0000 (GMT)
X-AuditID: b6c32a4b-7dffd70000013ffc-fd-647dd5371884
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.D5.28392.2C3DD746; Mon,  5 Jun 2023 21:23:30 +0900 (KST)
Received: from green245.sa.corp.samsungelectronics.net (unknown
        [107.99.41.245]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230605122324epsmtip24cff4d84328f230681a4d89417d1d39f~lwskbp6ph2245922459epsmtip2P;
        Mon,  5 Jun 2023 12:23:24 +0000 (GMT)
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
        Anuj Gupta <anuj20.g@samsung.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v12 6/9] nvmet: add copy command support for bdev and file
 ns
Date:   Mon,  5 Jun 2023 17:47:22 +0530
Message-Id: <20230605121732.28468-7-nj.shetty@samsung.com>
X-Mailer: git-send-email 2.35.1.500.gb896f729e2
In-Reply-To: <20230605121732.28468-1-nj.shetty@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0xTdxTH/d3bXgpb3QU0/oDgSJljQngplB9ifQTi7lYWkS1mc1uwo1dg
        lLZpCyqOyEsFlKdzcQV5CPIeZOBYec1a3tVGoQMiG48xyEQ2ngt1EHWUi5v/fc/5nc85Od9f
        Dge3qbKw50RJVbRCKpLwCCtWU8duF3e/wQSxV16xA6rXd+MoOecZjmpGswk027EE0DcL/+Bo
        SnsJIOPUVjRx5yBqn8tno0faZgy13czDUFVNF4ZaSxYxlKcbAmh6UI2h9hE3VHKxjIXa2vtY
        yNhSQKCi8mkLdHlYQ6CKnucY0l1NwZBmKgmgprUiHNXNzrNQ74gDevCsh43WnhYQhxwp489C
        Sj1uIKhm9agF9WDsexbVWOlKGQ2xVEN1OkE1lp2nWh8lElRp1lU2lZkyR1CL0yMsav6nQYLK
        ul0NqMZ756jlhp0h1iei90fSIjGtcKKl4TJxlDRCwBN+GBYY5sv38nb39kd+PCepKIYW8IKC
        Q9yPREnWLeI5xYkkseupEJFSyfM8sF8hi1XRTpEypUrAo+ViidxH7qEUxShjpREeUlq1z9vL
        a4/veuHJ6MiBH+fZ8uXDZzonM4hEYOJnAEsOJH3gr2mrWAaw4tiQrQDeLf1tM1gCMKfiIZsJ
        lgFczR0jMgBnAxkuOGqmbcgWAP/q3MHUXMBg/ZW0jRqCdIP3XnDM+W1kJQ6TTPdZ5gAne3DY
        vZiEm2lb8ihc0ZazzJpF7oIrpSsbMJfcB7sr32FmecLscWtzhSUZAGcMug2SS1rDvm+nNkic
        fBOm/JCPm9tDcsgStlbPWjBsECy5wWO2tIVPem5bMNoezmRf3NSnYdXXlQTDpgKoHlYD5uEg
        vKDPxs19cHI3rG/xZNKO8Jq+DmPmboWZa1MYk+dCTeFL7Qxr64sJRtvBIVPSpm0ULDB9yliV
        BWBeew0rBzipX1lH/co66v8nFwO8GtjRcmVMBK30le+V0qf/++JwWUwD2LgZV6EGTE4seOgA
        xgE6ADk4bxu35f1zYhuuWHQ2nlbIwhSxElqpA77rbufi9tvDZetHJ1WFefv4e/nw+Xwf/718
        b94OrougL9yGjBCp6GialtOKlxzGsbRPxCa9svsH5hLTVaSzvrGov9lP8Li+2OVPQVshlUDj
        x6XpUtMl4Red8vbar14/HveZJt31QOYhcMPxpiatBhuxbqECftEGVPvn1OkfGyqO/WH70Rsp
        M7LQs2rVJ3euV1S994SfKkx+Lhm7264qd2zWbZk+tfPagLjD9oguqNk5scKQtH2LsWhi7WR3
        2/Uup4fC5UDn7zTsv1d7x1N3SZra5qdD+yNH3w0tW0nwyxjRenygSe7NZ8dn3NrzO3dK/bTw
        zJLhlFg81KMNaqBO3DKej7OK91sLzLUKNpVKHWyj7ruVWJV+Ht34IllfO3T4Ne6XXXYDbseE
        huDUtxbsZmcE3Lc/vsxjKSNF3q64Qin6Fz4g3ma8BAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWy7bCSvO6hy7UpBv+/KFqsP3WM2aJpwl9m
        i9V3+9ksXh/+xGgx7cNPZosnB9oZLS4/4bN4sN/eYu+72awWNw/sZLLYs2gSk8XK1UeZLHYv
        /MhkMenQNUaLp1dnMVnsvaVtsbBtCYvFnr0nWSwu75rDZjF/2VN2i+7rO9gslh//x2RxaHIz
        k8WOJ42MFtt+z2e2WPf6PYvFiVvSFuf/Hme1+P1jDpuDrMflK94es+6fZfPYOesuu8f5extZ
        PDav0PK4fLbUY9OqTjaPzUvqPXbfbGDzWNw3mdWjt/kdm8fHp7dYPN7vu8rm0bdlFaPH5tPV
        Hp83yQUIRnHZpKTmZJalFunbJXBlXNr+nrXgs2PFkUddbA2M3826GDk4JARMJK7P8e9i5OIQ
        EtjBKHHg2EqWLkZOoLikxLK/R5ghbGGJlf+es0MUNTNJnHs+gQmkmU1AW+L0fw6QuIjAFmaJ
        s78ms4I0MAvcZpaYeVYGxBYW8JXYcKkHbCiLgKrEt8Xf2EB6eQWsJI6t0IC4QV+i/74gSAWn
        gLXEy7OHmEHCQkAVV9/bgIR5BQQlTs58wgIxXF6ieets5gmMArOQpGYhSS1gZFrFKJlaUJyb
        nltsWGCUl1quV5yYW1yal66XnJ+7iRGcBrS0djDuWfVB7xAjEwfjIUYJDmYlEd5dXtUpQrwp
        iZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTA1Ooc1vbZnZZ97
        5FNaTnzGzXNnLh5YHHZ9/UH5c4e/rKuefvUdg5x/gDDv/Nl3cmTe+apP+3NQW2YTZ+DqRJvn
        dY7P3GclmZ/T5N7/Nl+4PGjnotaH60Nu/Fe+5VRxXuqa/drw2ONhzmtP7a2YmfvOXGhKdZLx
        s4u5t8w3sl4MPvFX6ssi1dyUx19Slrcv02aRXn3z1Bm/Z9975jZpS+3Z5T5DyiyP/555d4HN
        udfmCkJ/+pVchHa9YZ8v5tdSdfanx4Pq/ddC5bdW7Kmf2mC0/5VZxM9QZXZ115ig/qx1Mzz+
        V9ZJl/VN18mcc3WzT+z5zskVP2KFVV7/Tsrtin3TJ/O5ME/xjszLF5beAbuUWIozEg21mIuK
        EwED+IwNcgMAAA==
X-CMS-MailID: 20230605122330epcas5p18a452356d5bc39b852b85304bac5b0cc
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230605122330epcas5p18a452356d5bc39b852b85304bac5b0cc
References: <20230605121732.28468-1-nj.shetty@samsung.com>
        <CGME20230605122330epcas5p18a452356d5bc39b852b85304bac5b0cc@epcas5p1.samsung.com>
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

Add support for handling nvme_cmd_copy command on target.
For bdev-ns we call into blkdev_issue_copy, which the block layer
completes by a offloaded copy request to backend bdev or by emulating the
request.

For file-ns we call vfs_copy_file_range to service our request.

Currently target always shows copy capability by setting
NVME_CTRL_ONCS_COPY in controller ONCS.

loop target has copy support, which can be used to test copy offload.

Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
---
 drivers/nvme/target/admin-cmd.c   |  9 ++++-
 drivers/nvme/target/io-cmd-bdev.c | 62 +++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-file.c | 52 ++++++++++++++++++++++++++
 drivers/nvme/target/loop.c        |  6 +++
 drivers/nvme/target/nvmet.h       |  1 +
 5 files changed, 128 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..8e644b8ec0fd 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -433,8 +433,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
-			NVME_CTRL_ONCS_WRITE_ZEROES);
-
+			NVME_CTRL_ONCS_WRITE_ZEROES | NVME_CTRL_ONCS_COPY);
 	/* XXX: don't report vwc if the underlying device is write through */
 	id->vwc = NVME_CTRL_VWC_PRESENT;
 
@@ -536,6 +535,12 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	if (req->ns->bdev)
 		nvmet_bdev_set_limits(req->ns->bdev, id);
+	else {
+		id->msrc = (__force u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16(BIO_MAX_VECS <<
+				(PAGE_SHIFT - SECTOR_SHIFT));
+		id->mcl = cpu_to_le32(le16_to_cpu(id->mssrl));
+	}
 
 	/*
 	 * We just provide a single LBA format that matches what the
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c2d6cea0236b..92b5accf0743 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -46,6 +46,18 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	id->npda = id->npdg;
 	/* NOWS = Namespace Optimal Write Size */
 	id->nows = to0based(bdev_io_opt(bdev) / bdev_logical_block_size(bdev));
+
+	if (bdev_max_copy_sectors(bdev)) {
+		id->msrc = id->msrc;
+		id->mssrl = cpu_to_le16((bdev_max_copy_sectors(bdev) <<
+				SECTOR_SHIFT) / bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32((__force u32)id->mssrl);
+	} else {
+		id->msrc = (__force u8)to0based(BIO_MAX_VECS - 1);
+		id->mssrl = cpu_to_le16((BIO_MAX_VECS << PAGE_SHIFT) /
+				bdev_logical_block_size(bdev));
+		id->mcl = cpu_to_le32((__force u32)id->mssrl);
+	}
 }
 
 void nvmet_bdev_ns_disable(struct nvmet_ns *ns)
@@ -184,6 +196,21 @@ static void nvmet_bio_done(struct bio *bio)
 	nvmet_req_bio_put(req, bio);
 }
 
+static void nvmet_bdev_copy_end_io(void *private, int comp_len)
+{
+	struct nvmet_req *req = (struct nvmet_req *)private;
+	u16 status;
+
+	if (comp_len == req->copy_len) {
+		req->cqe->result.u32 = cpu_to_le32(1);
+		status = errno_to_nvme_status(req, 0);
+	} else {
+		req->cqe->result.u32 = cpu_to_le32(0);
+		status = errno_to_nvme_status(req, (__force u16)BLK_STS_IOERR);
+	}
+	nvmet_req_complete(req, status);
+}
+
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static int nvmet_bdev_alloc_bip(struct nvmet_req *req, struct bio *bio,
 				struct sg_mapping_iter *miter)
@@ -450,6 +477,37 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 	}
 }
 
+/* At present we handle only one range entry, since copy offload is aligned with
+ * copy_file_range, only one entry is passed from block layer.
+ */
+static void nvmet_bdev_execute_copy(struct nvmet_req *req)
+{
+	struct nvme_copy_range range;
+	struct nvme_command *cmd = req->cmd;
+	ssize_t ret;
+	u16 status;
+
+	status = nvmet_copy_from_sgl(req, 0, &range, sizeof(range));
+	if (status)
+		goto out;
+
+	ret = blkdev_copy_offload(req->ns->bdev,
+		le64_to_cpu(cmd->copy.sdlba) << req->ns->blksize_shift,
+		req->ns->bdev,
+		le64_to_cpu(range.slba) << req->ns->blksize_shift,
+		(le16_to_cpu(range.nlb) + 1) << req->ns->blksize_shift,
+		nvmet_bdev_copy_end_io, (void *)req, GFP_KERNEL);
+	if (ret) {
+		req->cqe->result.u32 = cpu_to_le32(0);
+		status = blk_to_nvme_status(req, BLK_STS_IOERR);
+		goto out;
+	}
+
+	return;
+out:
+	nvmet_req_complete(req, errno_to_nvme_status(req, status));
+}
+
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 {
 	switch (req->cmd->common.opcode) {
@@ -468,6 +526,10 @@ u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_bdev_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_bdev_execute_copy;
+		return 0;
+
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..f61aa834f7a5 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -322,6 +322,49 @@ static void nvmet_file_dsm_work(struct work_struct *w)
 	}
 }
 
+static void nvmet_file_copy_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+	int nr_range = req->cmd->copy.nr_range + 1;
+	u16 status = 0;
+	int src, id;
+	ssize_t len, ret;
+	loff_t pos;
+
+	pos = le64_to_cpu(req->cmd->copy.sdlba) << req->ns->blksize_shift;
+	if (unlikely(pos + req->transfer_len > req->ns->size)) {
+		nvmet_req_complete(req, errno_to_nvme_status(req, -ENOSPC));
+		return;
+	}
+
+	for (id = 0 ; id < nr_range; id++) {
+		struct nvme_copy_range range;
+
+		status = nvmet_copy_from_sgl(req, id * sizeof(range), &range,
+					sizeof(range));
+		if (status)
+			goto out;
+
+		src = (le64_to_cpu(range.slba) << (req->ns->blksize_shift));
+		len = (le16_to_cpu(range.nlb) + 1) << (req->ns->blksize_shift);
+		ret = vfs_copy_file_range(req->ns->file, src, req->ns->file,
+					pos, len, 0);
+		if (ret != len) {
+			pos += ret;
+			req->cqe->result.u32 = cpu_to_le32(id);
+			if (ret < 0)
+				status = errno_to_nvme_status(req, ret);
+			else
+				status = errno_to_nvme_status(req, -EIO);
+			goto out;
+		} else
+			pos += len;
+	}
+
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_file_execute_dsm(struct nvmet_req *req)
 {
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
@@ -330,6 +373,12 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
 	queue_work(nvmet_wq, &req->f.work);
 }
 
+static void nvmet_file_execute_copy(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_copy_work);
+	queue_work(nvmet_wq, &req->f.work);
+}
+
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
@@ -376,6 +425,9 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_write_zeroes:
 		req->execute = nvmet_file_execute_write_zeroes;
 		return 0;
+	case nvme_cmd_copy:
+		req->execute = nvmet_file_execute_copy;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index f2d24b2d992f..d18ed8067a15 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -146,6 +146,12 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		return ret;
 
 	nvme_start_request(req);
+	if (unlikely((req->cmd_flags & REQ_COPY) &&
+				(req_op(req) == REQ_OP_READ))) {
+		blk_mq_set_request_complete(req);
+		blk_mq_end_request(req, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
 	iod->cmd.common.flags |= NVME_CMD_SGL_METABUF;
 	iod->req.port = queue->ctrl->port;
 	if (!nvmet_req_init(&iod->req, &queue->nvme_cq,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index dc60a22646f7..1615dc9194ba 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -393,6 +393,7 @@ struct nvmet_req {
 	struct device		*p2p_client;
 	u16			error_loc;
 	u64			error_slba;
+	size_t			copy_len;
 };
 
 #define NVMET_MAX_MPOOL_BVEC		16
-- 
2.35.1.500.gb896f729e2

