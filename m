Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643D6528B51
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343990AbiEPQzV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbiEPQy4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:54:56 -0400
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6ACA3CA4B
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 09:54:39 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20220516165438euoutp01380eaa2e5ac4238fca46d29ebc120a4d~vpCewbTwr2240822408euoutp01P
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 May 2022 16:54:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20220516165438euoutp01380eaa2e5ac4238fca46d29ebc120a4d~vpCewbTwr2240822408euoutp01P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1652720078;
        bh=6O6R+aWzFD0tH6pBlgRqy5ygmaD7SLpLHM9qftmpwuQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fh6lUpOxEz1L5R0lDXKJogWDFAtYMYr19gWlbSAHU966Zw8+vMGblv2wuPQAu7a5U
         RPyQtPr0FqsXu3HlSnG97HoIFCkN3dhmm2J3ok64Z/gmmFkIebT+VLWVGYrIW4wgRg
         wCETrHorIbHw+GZ7QiTP96Jl1l5jjipFf9NzVwYk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220516165437eucas1p15eb77c4c9a68927fe7695a2e5830dcb7~vpCdkUKeT1545715457eucas1p1f;
        Mon, 16 May 2022 16:54:37 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 66.E6.10260.DC182826; Mon, 16
        May 2022 17:54:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220516165436eucas1p178d079302dae3a9fca696b13b0390deb~vpCdOIri62560525605eucas1p1b;
        Mon, 16 May 2022 16:54:36 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220516165436eusmtrp28837a89a06654af7c04d36f8d5949f97~vpCdNanu61030710307eusmtrp26;
        Mon, 16 May 2022 16:54:36 +0000 (GMT)
X-AuditID: cbfec7f5-bddff70000002814-5f-628281cdd3f8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 23.10.09404.CC182826; Mon, 16
        May 2022 17:54:36 +0100 (BST)
Received: from localhost (unknown [106.210.248.7]) by eusmtip2.samsung.com
        (KnoxPortal) with ESMTPA id
        20220516165436eusmtip27c52763e39356a08b7d9cbb75f4140dd~vpCc05sQp3184631846eusmtip2E;
        Mon, 16 May 2022 16:54:36 +0000 (GMT)
From:   Pankaj Raghav <p.raghav@samsung.com>
To:     axboe@kernel.dk, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, dsterba@suse.com, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, jiangbo.365@bytedance.com,
        linux-block@vger.kernel.org, gost.dev@samsung.com,
        p.raghav@samsung.com, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com, Luis Chamberlain <mcgrof@kernel.org>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH v4 13/13] dm-zoned: ensure only power of 2 zone sizes are
 allowed
Date:   Mon, 16 May 2022 18:54:16 +0200
Message-Id: <20220516165416.171196-14-p.raghav@samsung.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516165416.171196-1-p.raghav@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djP87pnG5uSDLb9FbJYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTRc+BDywWe29pW1x6vILdYs/ekywWl3fNYbOY
        v+wpu8WNCU8ZLT4vbWG3WHPzKYuDgMe/E2vYPHbOusvucflsqcemVZ1sHpuX1HvsvtkAFG69
        z+rxft9VNo++LasYPdZvucrisfl0tcfnTXIBPFFcNimpOZllqUX6dglcGT277jEVzOCquHX2
        AGsD4yqOLkZODgkBE4npK7YydzFycQgJrGCUOPphLRuE84VR4tflmUwQzmdGiVNPTrDAtOyZ
        fBkqsZxRonXqK3YI5zmjRMOWaYxdjBwcbAJaEo2d7CANIgJZEtNOPGQEqWEWOMwk8fzofFaQ
        hLBAsMSqZ7fYQGwWAVWJztfPwOK8AtYSr1a8ZoXYJi8x89J3dpCZnEDx1V3cECWCEidnPgE7
        iBmopHnrbLAfJASWc0q0Hj4KVi8h4CLRedYHYoywxKvjW9ghbBmJ/zvnM0HY1RJPb/yG6m1h
        lOjfuZ4Notdaou9MDojJLKApsX6XPkS5o8TWLytZISr4JG68FYS4gE9i0rbpzBBhXomONiGI
        aiWJnT+fQC2VkLjcNAcagh4S99d/YJ/AqDgLyS+zkPwyC2HvAkbmVYziqaXFuempxcZ5qeV6
        xYm5xaV56XrJ+bmbGIHp7/S/4193MK549VHvECMTB+MhRgkOZiURXoOKhiQh3pTEyqrUovz4
        otKc1OJDjNIcLErivMmZGxKFBNITS1KzU1MLUotgskwcnFINTEE/cltaBJZybQq4ve86NzeT
        VsGkKjd2sZ22K8P8759Y+qz3xz4bkY9dmtyd4jGs2+5rhDmlVKxL3z9T3b3OfbVggsbU5QcY
        3/+56/HP6Ed60qln1ZMVV1f8j55/UehI/AW93O4jSeznVgdVvHuR9vr0QjdJhQ1Gh1/eZV3e
        8E7s64SSitWaLjx3VrimPebbt+7VvoWpp9PWRO7rnXObS7B1MdOKRoPTPCa2h5qvRxyM2MM9
        P25955LzhvxfXGWc7A6t0z39MnL+vtPLk7OzzyptnCIe+kuwX07RTXePS/r0h3P5K3eYq8kx
        7xbgOCRn/shmDu995+d7L2S+zQrI0/X2Wc7v2LRoObPOsbfTK5VYijMSDbWYi4oTAX69IDHu
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xe7pnGpuSDO5tN7ZYfbefzeL32fPM
        FnvfzWa1uPCjkcni5oGdTBZ7Fk1isli5+iiTRc+BDywWe29pW1x6vILdYs/ekywWl3fNYbOY
        v+wpu8WNCU8ZLT4vbWG3WHPzKYuDgMe/E2vYPHbOusvucflsqcemVZ1sHpuX1HvsvtkAFG69
        z+rxft9VNo++LasYPdZvucrisfl0tcfnTXIBPFF6NkX5pSWpChn5xSW2StGGFkZ6hpYWekYm
        lnqGxuaxVkamSvp2NimpOZllqUX6dgl6GT277jEVzOCquHX2AGsD4yqOLkZODgkBE4k9ky8z
        dTFycQgJLGWUOLjjKQtEQkLi9sImRghbWOLPtS42iKKnjBInJxwHSnBwsAloSTR2soPUiAgU
        SMzp3wLWyyxwnkli/3p3EFtYIFBi0rZmJhCbRUBVovP1M1YQm1fAWuLVitesEPPlJWZe+s4O
        MpITKL66ixskLCRgJfH1yS12iHJBiZMzn0CNl5do3jqbeQKjwCwkqVlIUgsYmVYxiqSWFuem
        5xYb6RUn5haX5qXrJefnbmIERuq2Yz+37GBc+eqj3iFGJg7GQ4wSHMxKIrwGFQ1JQrwpiZVV
        qUX58UWlOanFhxhNgc6eyCwlmpwPTBV5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6Yklqdmp
        qQWpRTB9TBycUg1Mk6fvdjfa5ON/83dYHLet8aHDRgZJm/7YMf6cwtBzuV9CcP2hI984F6z/
        seXGjM/F12TvZ65qnTA74+361NWKzd1vUmt975ZEH01/uWZJ6bX7DEdaLcJcd29JOizBtSrp
        /ZxYBjkRM9OMFQYs7780Rlw1CcpKK14we0//w40XXTsfr6lyDPmRmXv+6+q8JsuPd7iq890/
        NKztO32j2k/8xM/V/+43BTOsWGIi95gla1/szVtnXB6FxSsd47z/WPRCpMyzahaujsfW23oZ
        FLZ0GJYLeLIIOs7s2Z5f0ST/oPfmzT8XwhN95j1bnOKeecU2YY39l+OzpF49miMRb77ok5qX
        ycEXx+bd+KtxtLG5XYmlOCPRUIu5qDgRAFdHucBdAwAA
X-CMS-MailID: 20220516165436eucas1p178d079302dae3a9fca696b13b0390deb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220516165436eucas1p178d079302dae3a9fca696b13b0390deb
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220516165436eucas1p178d079302dae3a9fca696b13b0390deb
References: <20220516165416.171196-1-p.raghav@samsung.com>
        <CGME20220516165436eucas1p178d079302dae3a9fca696b13b0390deb@eucas1p1.samsung.com>
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

From: Luis Chamberlain <mcgrof@kernel.org>

Today dm-zoned relies on the assumption that you have a zone size
with a power of 2. Even though the block layer today enforces this
requirement, these devices do exist and so provide a stop-gap measure
to ensure these devices cannot be used by mistake

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
---
 drivers/md/dm-zone.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/md/dm-zone.c b/drivers/md/dm-zone.c
index 3e7b1fe15..f0c588c02 100644
--- a/drivers/md/dm-zone.c
+++ b/drivers/md/dm-zone.c
@@ -231,6 +231,18 @@ static int dm_revalidate_zones(struct mapped_device *md, struct dm_table *t)
 	struct request_queue *q = md->queue;
 	unsigned int noio_flag;
 	int ret;
+	struct block_device *bdev = md->disk->part0;
+	sector_t zone_sectors;
+	char bname[BDEVNAME_SIZE];
+
+	zone_sectors = bdev_zone_sectors(bdev);
+
+	if (!is_power_of_2(zone_sectors)) {
+		DMWARN("%s: %s only power of two zone size supported",
+		       dm_device_name(md),
+		       bdevname(bdev, bname));
+		return -EINVAL;
+	}
 
 	/*
 	 * Check if something changed. If yes, cleanup the current resources
-- 
2.25.1

