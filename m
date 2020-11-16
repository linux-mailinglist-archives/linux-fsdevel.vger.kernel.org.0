Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DCF2B46E7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbgKPO70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730913AbgKPO7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5603FC0613CF;
        Mon, 16 Nov 2020 06:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=O5A83Oi0Xx0wCgZ53MCDk0SimnnpHqXZpeb9/Xjg+3I=; b=E7BcK9hAyDSHxcI7VinrLs/x4+
        GbPQzDVUV1gmtfeik/ecOJf1xAz9adMm1AlR5n+8pmOFubRvS/7JC38pGCYM9ZwlEJ4zvxSDihrYM
        JGQCaf5k451aQcjTbxUWntTZRSfcMeTsf8Du7UrxdxqROv2m47Q52OOrWyg+7vXskLoftSze8ezz6
        aMmgYUku1QWTkRciIOFj5T0KMfHWt98qdMt4QXSWxtgUUImsabTkg/eANqkgiZzmVtnscOj29Xw6f
        e1x2pMJGB6+SMSCN0E1pYgQM50zCWis0+N6qx617dZwyzoH0THRVg26q4h6UoR9/dNcUrYteSODTY
        uCKNHu/A==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyN-000402-5y; Mon, 16 Nov 2020 14:59:15 +0000
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
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 46/78] ide: switch to __register_blkdev for command set probing
Date:   Mon, 16 Nov 2020 15:57:37 +0100
Message-Id: <20201116145809.410558-47-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ide is the last user of the blk_register_region framework except for the
tracking of allocated gendisk.  Switch to __register_blkdev, even if that
doesn't allow us to trivially find out which command set to probe for.
That means we now always request all modules when a user tries to access
an unclaimed ide device node, but except for a few potentially loaded
modules for a fringe use case of a deprecated and soon to be removed
driver that doesn't make a difference.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/ide/ide-probe.c | 34 ++++++----------------------------
 1 file changed, 6 insertions(+), 28 deletions(-)

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 076d34b381720f..1c1567bb519429 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -902,31 +902,12 @@ static int init_irq (ide_hwif_t *hwif)
 	return 1;
 }
 
-static int ata_lock(dev_t dev, void *data)
+static void ata_probe(dev_t dev)
 {
-	/* FIXME: we want to pin hwif down */
-	return 0;
-}
-
-static struct kobject *ata_probe(dev_t dev, int *part, void *data)
-{
-	ide_hwif_t *hwif = data;
-	int unit = *part >> PARTN_BITS;
-	ide_drive_t *drive = hwif->devices[unit];
-
-	if ((drive->dev_flags & IDE_DFLAG_PRESENT) == 0)
-		return NULL;
-
-	if (drive->media == ide_disk)
-		request_module("ide-disk");
-	if (drive->media == ide_cdrom || drive->media == ide_optical)
-		request_module("ide-cd");
-	if (drive->media == ide_tape)
-		request_module("ide-tape");
-	if (drive->media == ide_floppy)
-		request_module("ide-floppy");
-
-	return NULL;
+	request_module("ide-disk");
+	request_module("ide-cd");
+	request_module("ide-tape");
+	request_module("ide-floppy");
 }
 
 void ide_init_disk(struct gendisk *disk, ide_drive_t *drive)
@@ -967,7 +948,7 @@ static int hwif_init(ide_hwif_t *hwif)
 		return 0;
 	}
 
-	if (register_blkdev(hwif->major, hwif->name))
+	if (__register_blkdev(hwif->major, hwif->name, ata_probe))
 		return 0;
 
 	if (!hwif->sg_max_nents)
@@ -989,8 +970,6 @@ static int hwif_init(ide_hwif_t *hwif)
 		goto out;
 	}
 
-	blk_register_region(MKDEV(hwif->major, 0), MAX_DRIVES << PARTN_BITS,
-			    THIS_MODULE, ata_probe, ata_lock, hwif);
 	return 1;
 
 out:
@@ -1582,7 +1561,6 @@ static void ide_unregister(ide_hwif_t *hwif)
 	/*
 	 * Remove us from the kernel's knowledge
 	 */
-	blk_unregister_region(MKDEV(hwif->major, 0), MAX_DRIVES<<PARTN_BITS);
 	kfree(hwif->sg_table);
 	unregister_blkdev(hwif->major, hwif->name);
 
-- 
2.29.2

