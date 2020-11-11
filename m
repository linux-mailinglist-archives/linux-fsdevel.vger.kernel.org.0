Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288012AEB51
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Nov 2020 09:28:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgKKI12 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Nov 2020 03:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726416AbgKKI10 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Nov 2020 03:27:26 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24450C0613D4;
        Wed, 11 Nov 2020 00:27:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=msAxRVgou3+s48HjnTxbv/pHmvKh+OTllxGOwTa9PDs=; b=HtE3Jf5Vbg9BUyHuOP4LioCkGM
        D5RSbkrHUpDFKIQjTw/EK4TzE+8HC7HKkeSRDQ5TzvYLeD176nt7vURqsS/VEBAOA0ZGVp2Hfk4BA
        FS2uNGpdT5zytQL6JfJub2kZpw2LjaJ9Qgw8NxRTfmPK2IU9L78Jw1VK21pEcdjuzr8xdUwVC1AG8
        FZzij4ATCs/rSb1EzfUVneXPwEq9nYX5eNo+i9hTfvU1x/iEwjUiJQP7bXoR4lZCu9eKsU3Nd9Bq0
        Kq770Jj2OBzqFQPHPMIVFh4h4EqCewYZ87onZqxTquG/UH1fcZ9aZrou8dZ3Mf5neqm7MQBxdmEx8
        6E4xnYtg==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kclT8-0007aM-Pa; Wed, 11 Nov 2020 08:27:06 +0000
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
Subject: [PATCH 06/24] block: add a return value to set_capacity_and_notify
Date:   Wed, 11 Nov 2020 09:26:40 +0100
Message-Id: <20201111082658.3401686-7-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return if the function ended up sending an uevent or not.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c         | 7 +++++--
 include/linux/genhd.h | 2 +-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index d8d9d6c1c916e1..8c350fecfe8bfe 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -47,9 +47,9 @@ static void disk_release_events(struct gendisk *disk);
 
 /*
  * Set disk capacity and notify if the size is not currently zero and will not
- * be set to zero.
+ * be set to zero.  Returns true if a uevent was sent, otherwise false.
  */
-void set_capacity_and_notify(struct gendisk *disk, sector_t size)
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size)
 {
 	sector_t capacity = get_capacity(disk);
 
@@ -60,7 +60,10 @@ void set_capacity_and_notify(struct gendisk *disk, sector_t size)
 		char *envp[] = { "RESIZE=1", NULL };
 
 		kobject_uevent_env(&disk_to_dev(disk)->kobj, KOBJ_CHANGE, envp);
+		return true;
 	}
+
+	return false;
 }
 EXPORT_SYMBOL_GPL(set_capacity_and_notify);
 
diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 596f31b5a3e133..4b22bfd9336e1a 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -315,7 +315,7 @@ static inline int get_disk_ro(struct gendisk *disk)
 extern void disk_block_events(struct gendisk *disk);
 extern void disk_unblock_events(struct gendisk *disk);
 extern void disk_flush_events(struct gendisk *disk, unsigned int mask);
-void set_capacity_and_notify(struct gendisk *disk, sector_t size);
+bool set_capacity_and_notify(struct gendisk *disk, sector_t size);
 
 /* drivers/char/random.c */
 extern void add_disk_randomness(struct gendisk *disk) __latent_entropy;
-- 
2.28.0

