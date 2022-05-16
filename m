Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71C0528B39
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343923AbiEPQyr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343905AbiEPQyd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:33 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A081B3C71E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:29 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165427euoutp01cbe93df31ea93d6b67f8dfa9206bafa4~vpCUJdQUL2240822408euoutp01E
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:27 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516165427euoutp01cbe93df31ea93d6b67f8dfa9206bafa4~vpCUJdQUL2240822408euoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720067;
        bh=vrYMM/cTOrW0/UYYWyRRUQC9LsDHx9p6dz/qEYyG7Ug=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OcjFX/6VTfW4eS0d1ITEjlNboJdt1GniClcUR+Az5gY/MZNL620y5CjcEaJJ2aS0n
         dEJjXeVKBQ6RANh0JlY8Fy/YaLPHemEcqlWBlY5DpuISs+4iJnWSFWk8KnxHuLMoGB
         9hlAmwf6YusA6Qxs2HmYNtlftA98D7rwv+Q5MT18=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220516165425eucas1p202583878951ecf13abff73433caed273~vpCSLKaCf2458224582eucas1p2a;
        Mon, 16 May 2022 16:54:25 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id FD.3A.09887.0C182826; Mon, 16
        May 2022 17:54:25 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220516165424eucas1p2ee38cd64260539e5cac8d1fa4d0cba38~vpCRkEAod2458324583eucas1p2a;
        Mon, 16 May 2022 16:54:24 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516165424eusmtrp2e805a2cfc6551f0fbfbd804b04689d96~vpCRdqqyG1030710307eusmtrp2s;
        Mon, 16 May 2022 16:54:24 +0000 (GMT)
X-AuditID: cbfec7f4-45bff7000000269f-33-628281c097a2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9D.00.09404.0C182826; Mon, 16
        May 2022 17:54:24 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165424eusmtip1eac074d106663fe373f8f11517faf1da~vpCRLXgoG2383023830eusmtip1a;
        Mon, 16 May 2022 16:54:24 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Bart Van Assche <bvanassche@acm.org>,
        Hannes Reinecke <hare@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v4 04/13] nvmet: Allow ZNS target to support non-power_of_2
 zone sizes
Date:   Mon, 16 May 2022 18:54:07 +0200
Message-Id: <20220516165416.171196-5-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMKsWRmVeSWpSXmKPExsWy7djPc7oHG5uSDG6rW6y+289mMe3DT2aL
        32fPM1vsfTeb1eLCj0Ymi5sHdjJZ7Fk0icli5eqjTBY9Bz6wWOy9pW1x6fEKdos9e0+yWFze
        NYfNYv6yp+wWNyY8ZbT4vLSF3WLNzacsDoIel694e/w7sYbNY+esu+wel8+Wemxa1cnmsXlJ
        vcfumw1A4db7rB7v911l8+jbsorRY/2Wqywem09Xe3zeJBfAG8Vlk5Kak1mWWqRvl8CVcf7t
        BaaC/3wVM2/eY2xgvMnTxcjJISFgIjGzYx57FyMXh5DACkaJRXf6mCGcL4wSXdvPskA4nxkl
        dix9xgzTcnb2XyaIxHJGibmfj0E5zxklvp6YBORwcLAJaEk0drKDNIgIZElMO/GQEaSGWeA1
        k8SZzjusIAlhgQiJHW8bWEDqWQRUJf5syQMJ8wpYSTS+WAy1TF5i5qXv7CAlnALWEqu7uCFK
        BCVOznzCAmIzA5U0b50NdrWEwGZOibsLZ7ND9LpINE87AmULS7w6vgXKlpH4v3M+E4RdLfH0
        xm+o5hZGif6d69lAlkkALes7kwNiMgtoSqzfpQ9R7iix8c4JqAo+iRtvBSFO4JOYtG06M0SY
        V6KjTQiiWkli588nUEslJC43zWGBsD0kPiy7yTSBUXEWkmdmIXlmFsLeBYzMqxjFU0uLc9NT
        i43yUsv1ihNzi0vz0vWS83M3MQLT4el/x7/sYFz+6qPeIUYmDsZDjBIczEoivAYVDUlCvCmJ
        lVWpRfnxRaU5qcWHGKU5WJTEeZMzNyQKCaQnlqRmp6YWpBbBZJk4OKUamHLub8+u6LkkKWbr
        GhFVcifi2jWhhQdclB8uWjTvTf1KB28WNd5brpOyP8olVTnoljJIuk/n7/lbbRjA7c07M+0p
        065lB/7Y/F62K3ZtXn/S15P6opd+yPHc1n927KS4u7aIdWFYQJff5fNRE/fyOPcozr0nEiKd
        rJn36rdcN2Moh5JMfO/fnScXhHMuTHuyd9rGJEa76vb2lMVPPLaHV90Umr/twHy1KRsfRV1i
        tNnKk8B50viXSJ7lPF/9Eq67FSk8ClJz2e853gk0LZ30bfXpqucvAlizdvEvquPd+lmxuv1K
        W4ufWGzDAVU5UcX9GxSeuDxyY9hx6nVfYqNIR+w89gVVh6eYWFi7iVYqsRRnJBpqMRcVJwIA
        Hj+Oz/YDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsVy+t/xu7oHGpuSDOZ8FrRYfbefzWLah5/M
        Fr/Pnme22PtuNqvFhR+NTBY3D+xkstizaBKTxcrVR5kseg58YLHYe0vb4tLjFewWe/aeZLG4
        vGsOm8X8ZU/ZLW5MeMpo8XlpC7vFmptPWRwEPS5f8fb4d2INm8fOWXfZPS6fLfXYtKqTzWPz
        knqP3TcbgMKt91k93u+7yubRt2UVo8f6LVdZPDafrvb4vEkugDdKz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL+P82wtMBf/5KmbevMfYwHiTp4uR
        k0NCwETi7Oy/TF2MXBxCAksZJQ7fa2eBSEhI3F7YxAhhC0v8udbFBlH0lFHi6JtvrF2MHBxs
        AloSjZ3sIDUiAgUSc/q3gPUyC3xnkpj6sgCkRFggTOLDB18Qk0VAVeLPljyQCl4BK4nGF4uZ
        IabLS8y89J0dpIRTwFpidRc3SFgIqOTrk1vsEOWCEidnPoEaLi/RvHU28wRGgVlIUrOQpBYw
        Mq1iFEktLc5Nzy020itOzC0uzUvXS87P3cQIjNttx35u2cG48tVHvUOMTByMhxglOJiVRHgN
        KhqShHhTEiurUovy44tKc1KLDzGaAl09kVlKNDkfmDjySuINzQxMDU3MLA1MLc2MlcR5PQs6
        EoUE0hNLUrNTUwtSi2D6mDg4pRqYuL75WAmfOFCabszqIbKKT+eu9cGyAzP25tguja7YNclD
        3tYrrTCq2u2jki2P7i9N5qw5MxsyXdaLKG+Q6ymKTND02CVw+dL/qV+m87Te6Hmy799kfrFr
        Lx7u6lvIbiO87Zi+exVDg/7uyCUSr9e1ysxZmT3JyzHq6z6ZF8fm3V62zSCq0rJ3op7p+3mr
        3619dvjAtqc8orKnlq+6HjbhnmrwNabgrUH+6xZrtUxvqHl6x9/87qsvIS1GzcKOf9/wb5un
        +ZBp027PlrRpx5JVX/6Pe2U8e5XaMkZn99y6liaBkyfka19och3wfrlh15IJ1ftYWjifbLOJ
        5pefbF658qeYdn2oxePzExYFui/7qMRSnJFoqMVcVJwIAGIunbBkAwAA
X-CMS-MailID: 20220516165424eucas1p2ee38cd64260539e5cac8d1fa4d0cba38
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165424eucas1p2ee38cd64260539e5cac8d1fa4d0cba38
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165424eucas1p2ee38cd64260539e5cac8d1fa4d0cba38
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165424eucas1p2ee38cd64260539e5cac8d1fa4d0cba38@eucas1p2.samsung.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A generic bdev_zone_no helper is added to calculate zone number for a given
sector in a block device. This helper internally uses blk_queue_zone_no to
find the zone number.

Use the helper bdev_zone_no() to calculate nr of zones. This let's us
make modifications to the math if needed in one place and adds now
support for npo2 zone devices.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/nvme/target/zns.c | 2 +-
 include/linux/blkdev.h    | 7 +++++++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 82b61acf7..5516dd6cc 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -242,7 +242,7 @@ static unsigned long nvmet_req_nr_zones_from_slba(struct nvmet_req *req)
 	unsigned int sect = nvmet_lba_to_sect(req->ns, req->cmd->zmr.slba);
 
 	return blkdev_nr_zones(req->ns->bdev->bd_disk) -
-		(sect >> ilog2(bdev_zone_sectors(req->ns->bdev)));
+	       bdev_zone_no(req->ns->bdev, sect);
 }
 
 static unsigned long get_nr_zones_from_buf(struct nvmet_req *req, u32 bufsize)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 32d7bd7b1..967790f51 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1370,6 +1370,13 @@ static inline sector_t bdev_zone_sectors(struct block_device *bdev)
 	return 0;
 }
 
+static inline unsigned int bdev_zone_no(struct block_device *bdev, sector_t sec)
+{
+	struct request_queue *q = bdev_get_queue(bdev);
+
+	return blk_queue_zone_no(q, sec);
+}
+
 static inline unsigned int bdev_max_open_zones(struct block_device *bdev)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
-- 
2.25.1

