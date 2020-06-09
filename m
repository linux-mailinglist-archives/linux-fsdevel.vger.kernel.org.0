Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D67481F3EDC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jun 2020 17:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgFIPGq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Jun 2020 11:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbgFIPGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:06:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6025AC05BD1E;
        Tue,  9 Jun 2020 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Sijyqf5Wrq6MRvgpiyONAL7g60SU+r119SO1Vhd8DOA=; b=k61HwdJGwgp0qZ1U+fWmP3TZH8
        88wpoQek7G6c0RFX/ViENSEgNErMlPXnzvJQuJEf4mPRaJPFurIiDpCZ0TRY652BM+trKa81+5Wzf
        9KXNCXzlcoVrAM5FyfSif0Q4B/Z7DoWkBIH2Tf2JhE5xOSGmCzRbL/1V884rzU8EA8diBZmxNizPb
        SzI8RGY+5y3XVuhU1lBHMfON2mqLAukH9Ow0gTS/2SHcoGYKAuyJO2bdUKEHaUl0RX8rlgd2ZyTvd
        9BAU3WnA7f89ELuunHS3B7tJRSqf9xjnewKhkDXUV9I00+dFZvfb2+EyFV2dULF7wQJw/tfobddZM
        W/1g4QPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jifpC-0005Qr-93; Tue, 09 Jun 2020 15:06:02 +0000
Date:   Tue, 9 Jun 2020 08:06:02 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        martin.petersen@oracle.com, jejb@linux.ibm.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200609150602.GA7111@infradead.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200608170127.20419-7-mcgrof@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

All the complicated code to deal with delayed creation of the debugfs
directory was only needed for sg.  With sg handled speparately that
can go away.  Also I think the sg handling can be cleaned up by:

 a) checking for a NULL block_devic instead of the major, especially as
    majors can be used independently for character and block devices
 b) just keeping the old method of creating the entry on demand for the
    sg devices, as no one shares the debugfs directory in that case.

Untested patch on top of your series below:

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 70168435f07983..4e9909e1b25736 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -920,8 +920,6 @@ static void blk_release_queue(struct kobject *kobj)
 	blk_trace_shutdown(q);
 
 	debugfs_remove_recursive(q->debugfs_dir);
-	if (IS_ENABLED(CONFIG_CHR_DEV_SG))
-		debugfs_remove_recursive(q->sg_debugfs_dir);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -941,20 +939,6 @@ struct kobj_type blk_queue_ktype = {
 	.release	= blk_release_queue,
 };
 
-/**
- * blk_sg_debugfs_init - initialize debugfs for scsi-generic
- * @q: the associated queue
- * @name: name of the scsi-generic device
- *
- * To be used by scsi-generic for allowing it to use blktrace.
- */
-void blk_sg_debugfs_init(struct request_queue *q, const char *name)
-{
-	if (IS_ENABLED(CONFIG_CHR_DEV_SG))
-		q->sg_debugfs_dir = debugfs_create_dir(name, blk_debugfs_root);
-}
-EXPORT_SYMBOL_GPL(blk_sg_debugfs_init);
-
 /**
  * blk_register_queue - register a block layer queue with sysfs
  * @disk: Disk of which the request queue should be registered with sysfs.
@@ -1007,27 +991,8 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
-	/*
-	 * Blktrace needs a debugfs name even for queues that don't register
-	 * a gendisk, so it lazily registers the debugfs directory.  But that
-	 * can get us into a situation where a SCSI device is found, with no
-	 * driver for it (yet).  Then blktrace is used on the device, creating
-	 * the debugfs directory, and only after that a driver is loaded. In
-	 * that case we might already have a debugfs directory registered here.
-	 * Even worse we could be racing with blktrace to register it.
-	 */
-#ifdef CONFIG_BLK_DEV_IO_TRACE
-	mutex_lock(&q->blk_trace_mutex);
-	if (!q->debugfs_dir) {
-		q->debugfs_dir =
-			debugfs_create_dir(kobject_name(q->kobj.parent),
-				blk_debugfs_root);
-	}
-	mutex_unlock(&q->blk_trace_mutex);
-#else
 	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
 					    blk_debugfs_root);
-#endif
 
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 5f6ccf4ba4d907..20472aaaf630a4 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1117,9 +1117,6 @@ sg_ioctl_common(struct file *filp, Sg_device *sdp, Sg_fd *sfp,
 		return put_user(max_sectors_bytes(sdp->device->request_queue),
 				ip);
 	case BLKTRACESETUP:
-		if (!sdp->device->request_queue->sg_debugfs_dir)
-			blk_sg_debugfs_init(sdp->device->request_queue,
-					    sdp->disk->disk_name);
 		return blk_trace_setup(sdp->device->request_queue,
 				       sdp->disk->disk_name,
 				       MKDEV(SCSI_GENERIC_MAJOR, sdp->index),
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05a929329157fa..b49c7c741bc9f3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -575,7 +575,6 @@ struct request_queue {
 	struct bio_set		bio_split;
 
 	struct dentry		*debugfs_dir;
-	struct dentry		*sg_debugfs_dir;
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
@@ -859,7 +858,6 @@ static inline void rq_flush_dcache_pages(struct request *rq)
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
-extern void blk_sg_debugfs_init(struct request_queue *q, const char *name);
 extern blk_qc_t generic_make_request(struct bio *bio);
 extern blk_qc_t direct_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
diff --git a/include/linux/blktrace_api.h b/include/linux/blktrace_api.h
index eb6db276e29310..3b6ff5902edce6 100644
--- a/include/linux/blktrace_api.h
+++ b/include/linux/blktrace_api.h
@@ -22,6 +22,7 @@ struct blk_trace {
 	u64 end_lba;
 	u32 pid;
 	u32 dev;
+	struct dentry *dir;
 	struct dentry *dropped_file;
 	struct dentry *msg_file;
 	struct list_head running_list;
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index 432fa60e7f8808..44239f603379d5 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -311,6 +311,7 @@ static void blk_trace_free(struct blk_trace *bt)
 	debugfs_remove(bt->msg_file);
 	debugfs_remove(bt->dropped_file);
 	relay_close(bt->rchan);
+	debugfs_remove(bt->dir);
 	free_percpu(bt->sequence);
 	free_percpu(bt->msg_data);
 	kfree(bt);
@@ -492,34 +493,23 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	strreplace(buts->name, '/', '_');
 
-	/*
-	 * We have to use a partition directory if a partition is being worked
-	 * on. The same request_queue is shared between all partitions.
-	 */
-	if (bdev && bdev != bdev->bd_contains) {
-		dir = bdev->bd_part->debugfs_dir;
-	} else if (IS_ENABLED(CONFIG_CHR_DEV_SG) &&
-		   MAJOR(dev) == SCSI_GENERIC_MAJOR) {
+	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
+	if (!bt)
+		return -ENOMEM;
+
+	if (unlikely(!bdev)) {
 		/*
-		 * scsi-generic exposes the request_queue through the /dev/sg*
-		 * interface but since that uses a different path than whatever
-		 * the respective scsi driver device name may expose and use
-		 * for the request_queue debugfs_dir. We have a dedicated
-		 * dentry for scsi-generic then.
+		 * When tracing something that is not a block device (e.g. the
+		 * /dev/sg nodes), create debugfs directory on demand.  This
+		 * directory will be remove when stopping the trace.
 		 */
-		dir = q->sg_debugfs_dir;
+		dir = debugfs_create_dir(buts->name, blk_debugfs_root);
+		bt->dir = dir;
 	} else {
-		/*
-		 * Drivers which do not use the *add_disk*() interfaces will
-		 * not have their debugfs_dir created for them automatically,
-		 * so we must create it for them.
-		 */
-		if (!q->debugfs_dir) {
-			q->debugfs_dir =
-				debugfs_create_dir(buts->name,
-						   blk_debugfs_root);
-		}
-		dir = q->debugfs_dir;
+		if (bdev != bdev->bd_contains)
+			dir = bdev->bd_part->debugfs_dir;
+		else
+			dir = q->debugfs_dir;
 	}
 
 	/*
@@ -530,12 +520,10 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (IS_ERR_OR_NULL(dir)) {
 		pr_warn("debugfs_dir not present for %s so skipping\n",
 			buts->name);
-		return -ENOENT;
+		ret = -ENOENT;
+		goto err;
 	}
 
-	bt = kzalloc(sizeof(*bt), GFP_KERNEL);
-	if (!bt)
-		return -ENOMEM;
 
 	ret = -ENOMEM;
 	bt->sequence = alloc_percpu(unsigned long);
