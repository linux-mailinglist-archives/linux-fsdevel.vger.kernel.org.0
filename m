Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4D2F2B4815
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731251AbgKPPB1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 10:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731036AbgKPO7x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31353C0613D1;
        Mon, 16 Nov 2020 06:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IuZ426HAkGqkpmUmDFrK/jtW75cQ9xEgfhlt4WVjI90=; b=FbV09+iwI8V/pddqU1sEXr5MRG
        2LGeCEdJzbpooxAikaWsNr5YfxH34ymPyuCnSJiwiRrphkz09RICgAbMVyHqGKWH6sHHkHvoruwW2
        nCorG1tvxjOd6vHnEE7swqUtKyD+8syeAG7c9+VEIxM/4sCmK8n7wJLvPzvcwP62k5ghl2GH7p6CA
        bmJY/GpCYWKc3Q69Wkb4Pf5N62nndPgbrmqv4yTNQic3S4e4YxaEGByMc1ZRJgWTOUB49DbdAAXXh
        7s2MiZc7fa4gFYEJLSLS59VU/0nxQ+mwt1zxXN8laEEd1sAgMYK6+cPM77anChY7SAPVWwdnlrtv1
        YRLIq+dw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyn-0004Cl-AQ; Mon, 16 Nov 2020 14:59:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Justin Sanders <justin@coraid.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Minchan Kim <minchan@kernel.org>,
        Mike Snitzer <snitzer@redhat.com>, Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        dm-devel@redhat.com, linux-block@vger.kernel.org,
        drbd-dev@lists.linbit.com, nbd@other.debian.org,
        ceph-devel@vger.kernel.org, xen-devel@lists.xenproject.org,
        linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 63/78] bcache: remove a superflous lookup_bdev all
Date:   Mon, 16 Nov 2020 15:57:54 +0100
Message-Id: <20201116145809.410558-64-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Don't bother to call lookup_bdev for just a slightly different error
message without any functional change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 10 +---------
 1 file changed, 1 insertion(+), 9 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 46a00134a36ae1..d36ccdda16ed2e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -2538,15 +2538,7 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 				  sb);
 	if (IS_ERR(bdev)) {
 		if (bdev == ERR_PTR(-EBUSY)) {
-			bdev = lookup_bdev(strim(path));
-			mutex_lock(&bch_register_lock);
-			if (!IS_ERR(bdev) && bch_is_open(bdev))
-				err = "device already registered";
-			else
-				err = "device busy";
-			mutex_unlock(&bch_register_lock);
-			if (!IS_ERR(bdev))
-				bdput(bdev);
+			err = "device busy";
 			if (attr == &ksysfs_register_quiet)
 				goto done;
 		}
-- 
2.29.2

