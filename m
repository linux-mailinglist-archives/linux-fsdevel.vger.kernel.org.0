Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D38992A9D4E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Nov 2020 20:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgKFTF3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Nov 2020 14:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728140AbgKFTEa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Nov 2020 14:04:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93033C0613CF;
        Fri,  6 Nov 2020 11:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=bgbs5emPj5p7gTWcmnEuks79StD6TA5roIn47mScHH4=; b=sLqpFn8MNMp2YVoGVzCC1sBIXZ
        scwxQBBRwMeOtLFZWVrnLhmqAhpHB975gQ6WhMbBX7APBR0vehT4+yU9XVRSGJ7txwf7VaLg9o6JD
        n4qb1rjrSe93F3xdo4HwsLfWw1Ux1ZKT9gBfGV4g0JQkTvIgByB0fJieiXaBI+eAOsaBPVbYBZDPK
        moYTJgW59lvKQuEcYEegtN9nvNnkj3NxbJNdENCRUI7j7M4HEcbxon2U3BQHJDMmukuCyiMp5ARdR
        N1W4pYYyu024rCnDN5Y4HDqX8OoRWdoKkyf91EigCA3QKgSODr8ohYGjl37kclee4PDOrPelHnjnO
        +OGLxhGg==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kb71v-0000xc-3a; Fri, 06 Nov 2020 19:04:11 +0000
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
Subject: [PATCH 12/24] aoe: don't call set_capacity from irq context
Date:   Fri,  6 Nov 2020 20:03:24 +0100
Message-Id: <20201106190337.1973127-13-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Updating the block device size from irq context can lead to torn
writes of the 64-bit value, and prevents us from using normal
process context locking primitives to serialize access to the 64-bit
nr_sectors value.  Defer the set_capacity to the already existing
workqueue handler, where it can be merged with the update of the
block device size by using set_capacity_and_notify.  As an extra
bonus this also adds proper uevent notifications for the resize.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/aoe/aoecmd.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/block/aoe/aoecmd.c b/drivers/block/aoe/aoecmd.c
index 313f0b946fe2b3..ac720bdcd983e7 100644
--- a/drivers/block/aoe/aoecmd.c
+++ b/drivers/block/aoe/aoecmd.c
@@ -890,19 +890,13 @@ void
 aoecmd_sleepwork(struct work_struct *work)
 {
 	struct aoedev *d = container_of(work, struct aoedev, work);
-	struct block_device *bd;
-	u64 ssize;
 
 	if (d->flags & DEVFL_GDALLOC)
 		aoeblk_gdalloc(d);
 
 	if (d->flags & DEVFL_NEWSIZE) {
-		ssize = get_capacity(d->gd);
-		bd = bdget_disk(d->gd, 0);
-		if (bd) {
-			bd_set_nr_sectors(bd, ssize);
-			bdput(bd);
-		}
+		set_capacity_and_notify(d->gd, d->ssize);
+
 		spin_lock_irq(&d->lock);
 		d->flags |= DEVFL_UP;
 		d->flags &= ~DEVFL_NEWSIZE;
@@ -971,10 +965,9 @@ ataid_complete(struct aoedev *d, struct aoetgt *t, unsigned char *id)
 	d->geo.start = 0;
 	if (d->flags & (DEVFL_GDALLOC|DEVFL_NEWSIZE))
 		return;
-	if (d->gd != NULL) {
-		set_capacity(d->gd, ssize);
+	if (d->gd != NULL)
 		d->flags |= DEVFL_NEWSIZE;
-	} else
+	else
 		d->flags |= DEVFL_GDALLOC;
 	schedule_work(&d->work);
 }
-- 
2.28.0

