Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740BB2B46B2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 15:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730747AbgKPO66 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730719AbgKPO6y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:58:54 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C0FC0613D2;
        Mon, 16 Nov 2020 06:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=IMIzlncMGNKmllwIOsfxmrv0eLBvrluJTUMF3jTpuQU=; b=k9I9MrkYIIqQ7JqFNAj/ZM1V4q
        fnRQw9pHyuYdosXzcTsUpct/APGHyHZ7nQCzDTPBYWKb7HrWsqQXDORjJYWy8OjQdicyYdW3PlxPu
        wqMi0Vhywi7qganw7NsAbQv4gOag+5ar1NaSXq2fKhYuZd8FwIJVH3dH1drAnztP4skkRRCgtIYLj
        Pjw8ksGMPtkHYf08cbb503DDj0v+MfWTUIREPU72v6YjjL9QwNBor49syaMVeLgCn3qZSFU6g/s8L
        U3jj6Zs9nBEf9ztd5cWkrrCJejXKia3qXo3DpHT4vJ84+lcQrWfocMAg1qs7gQeMEKKfZSWOVRuBo
        VJid72pg==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefxm-0003qi-1m; Mon, 16 Nov 2020 14:58:38 +0000
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
Subject: [PATCH 20/78] md: use set_capacity_and_notify
Date:   Mon, 16 Nov 2020 15:57:11 +0100
Message-Id: <20201116145809.410558-21-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use set_capacity_and_notify to set the size of both the disk and block
device.  This also gets the uevent notifications for the resize for free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Song Liu <song@kernel.org>
---
 drivers/md/md-cluster.c |  6 ++----
 drivers/md/md-linear.c  |  3 +--
 drivers/md/md.c         | 24 ++++++++++--------------
 3 files changed, 13 insertions(+), 20 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 4aaf4820b6f625..87442dc59f6ca3 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -581,8 +581,7 @@ static int process_recvd_msg(struct mddev *mddev, struct cluster_msg *msg)
 		process_metadata_update(mddev, msg);
 		break;
 	case CHANGE_CAPACITY:
-		set_capacity(mddev->gendisk, mddev->array_sectors);
-		revalidate_disk_size(mddev->gendisk, true);
+		set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
 		break;
 	case RESYNCING:
 		set_bit(MD_RESYNCING_REMOTE, &mddev->recovery);
@@ -1296,8 +1295,7 @@ static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
 		if (ret)
 			pr_err("%s:%d: failed to send CHANGE_CAPACITY msg\n",
 			       __func__, __LINE__);
-		set_capacity(mddev->gendisk, mddev->array_sectors);
-		revalidate_disk_size(mddev->gendisk, true);
+		set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
 	} else {
 		/* revert to previous sectors */
 		ret = mddev->pers->resize(mddev, old_dev_sectors);
diff --git a/drivers/md/md-linear.c b/drivers/md/md-linear.c
index 5ab22069b5be9c..98f1b4b2bdcef8 100644
--- a/drivers/md/md-linear.c
+++ b/drivers/md/md-linear.c
@@ -200,9 +200,8 @@ static int linear_add(struct mddev *mddev, struct md_rdev *rdev)
 		"copied raid_disks doesn't match mddev->raid_disks");
 	rcu_assign_pointer(mddev->private, newconf);
 	md_set_array_sectors(mddev, linear_size(mddev, 0, 0));
-	set_capacity(mddev->gendisk, mddev->array_sectors);
+	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
 	mddev_resume(mddev);
-	revalidate_disk_size(mddev->gendisk, true);
 	kfree_rcu(oldconf, rcu);
 	return 0;
 }
diff --git a/drivers/md/md.c b/drivers/md/md.c
index 98bac4f304ae26..32e375d50fee17 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -5355,10 +5355,9 @@ array_size_store(struct mddev *mddev, const char *buf, size_t len)
 
 	if (!err) {
 		mddev->array_sectors = sectors;
-		if (mddev->pers) {
-			set_capacity(mddev->gendisk, mddev->array_sectors);
-			revalidate_disk_size(mddev->gendisk, true);
-		}
+		if (mddev->pers)
+			set_capacity_and_notify(mddev->gendisk,
+						mddev->array_sectors);
 	}
 	mddev_unlock(mddev);
 	return err ?: len;
@@ -6107,8 +6106,7 @@ int do_md_run(struct mddev *mddev)
 	md_wakeup_thread(mddev->thread);
 	md_wakeup_thread(mddev->sync_thread); /* possibly kick off a reshape */
 
-	set_capacity(mddev->gendisk, mddev->array_sectors);
-	revalidate_disk_size(mddev->gendisk, true);
+	set_capacity_and_notify(mddev->gendisk, mddev->array_sectors);
 	clear_bit(MD_NOT_READY, &mddev->flags);
 	mddev->changed = 1;
 	kobject_uevent(&disk_to_dev(mddev->gendisk)->kobj, KOBJ_CHANGE);
@@ -6423,10 +6421,9 @@ static int do_md_stop(struct mddev *mddev, int mode,
 			if (rdev->raid_disk >= 0)
 				sysfs_unlink_rdev(mddev, rdev);
 
-		set_capacity(disk, 0);
+		set_capacity_and_notify(disk, 0);
 		mutex_unlock(&mddev->open_mutex);
 		mddev->changed = 1;
-		revalidate_disk_size(disk, true);
 
 		if (mddev->ro)
 			mddev->ro = 0;
@@ -7257,8 +7254,8 @@ static int update_size(struct mddev *mddev, sector_t num_sectors)
 		if (mddev_is_clustered(mddev))
 			md_cluster_ops->update_size(mddev, old_dev_sectors);
 		else if (mddev->queue) {
-			set_capacity(mddev->gendisk, mddev->array_sectors);
-			revalidate_disk_size(mddev->gendisk, true);
+			set_capacity_and_notify(mddev->gendisk,
+						mddev->array_sectors);
 		}
 	}
 	return rv;
@@ -9035,10 +9032,9 @@ void md_do_sync(struct md_thread *thread)
 		mddev_lock_nointr(mddev);
 		md_set_array_sectors(mddev, mddev->pers->size(mddev, 0, 0));
 		mddev_unlock(mddev);
-		if (!mddev_is_clustered(mddev)) {
-			set_capacity(mddev->gendisk, mddev->array_sectors);
-			revalidate_disk_size(mddev->gendisk, true);
-		}
+		if (!mddev_is_clustered(mddev))
+			set_capacity_and_notify(mddev->gendisk,
+						mddev->array_sectors);
 	}
 
 	spin_lock(&mddev->lock);
-- 
2.29.2

