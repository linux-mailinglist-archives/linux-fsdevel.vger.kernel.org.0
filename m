Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA271EA81A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Jun 2020 19:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgFARFE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Jun 2020 13:05:04 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39609 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFARFD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:05:03 -0400
Received: by mail-pf1-f193.google.com with SMTP id d66so3770635pfd.6;
        Mon, 01 Jun 2020 10:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SqGvEuB0dFlcyyOSkJr50JgBdhkSQyFc3GUwrr5SVgo=;
        b=a4EHHrJBATDdyjGwKrNre1MUeVtBXz6ysCqST6eBGYsS9djGuOe577cwMuU8COwAvN
         62QqlMN1xcE7rIKixVyHXEYR7sahHah39Fx243GdGMM92UugozriD2pJYIHqzanIP62i
         TczoTa/puq5bz4XOL+hNBV6pZlm5R9D3gEMSYbV3WhgkXlC8gOnWoeUTm1PJb5ojviJ4
         CZiqyOB8j1kfLmX29Gw3jugwBN17gdvBGZUJzlTnFvpswCOSiHmGGgffFUZNIVgJ6g/F
         ovt7S8DgHOp21fJHo3+WrDxqhFFk6JCtNXzNI+qs9pTdImwYnM8yBrPh9KthaAxwq2qU
         UUjQ==
X-Gm-Message-State: AOAM530eahe8l4zDvgUdY01jd/AMN3xwv6ZQA3Jothd6RmJgQrTydMpt
        VYcGCMIJDVhUnB7ZkyQKAsU=
X-Google-Smtp-Source: ABdhPJz0ib7h9telSiaQOJsAqtZNR0bvb+tdnQXKTIJD1pbCWADiC0oB625tI++TmThx78YyDXczZQ==
X-Received: by 2002:a63:205d:: with SMTP id r29mr11424078pgm.367.1591031102551;
        Mon, 01 Jun 2020 10:05:02 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c123sm8680pfb.102.2020.06.01.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 10:05:01 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 39CD640251; Mon,  1 Jun 2020 17:05:00 +0000 (UTC)
Date:   Mon, 1 Jun 2020 17:05:00 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        jack@suse.cz, ming.lei@redhat.com, nstange@suse.de,
        akpm@linux-foundation.org, mhocko@suse.com, yukuai3@huawei.com,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 5/7] blktrace: fix debugfs use after free
Message-ID: <20200601170500.GF13911@42.do-not-panic.com>
References: <20200516031956.2605-1-mcgrof@kernel.org>
 <20200516031956.2605-6-mcgrof@kernel.org>
 <20200519163713.GA29944@infradead.org>
 <20200527031202.GT11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527031202.GT11244@42.do-not-panic.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 27, 2020 at 03:12:02AM +0000, Luis Chamberlain wrote:
> You forgot to deal with partitions. Putting similar lipstick on the pig,
> this is what I end up with, let me know if this seems agreeable:

So even with the partition stuff in place, this approach still don't
allow multiple uses of blktrace against a scsi-generic device and its
backend real block device, say TYPE_DISK. A simple example is a scsi
drive hooked up used to allow users to do blktrace /dev/sda *and*
blktrace /dev/sg0, but with the proposed change /dev/sg0 no longer
works beacuse the dentry pertains to the '/dev/sda' name, not
'/dev/sg0'.

We can shoehorn in a solution following the style proposed as follows.
We can keep this only slightly cleaner if we don't care about the
extra dentry even if a user disables CONFIG_CHR_DEV_SG. The cost
would just be an extra dentry on the request_queue.

I'll run this through 0-day and then post a new hopefully final series,
but if you don't think this or would prefer something lease please let
me know.

diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 86c107de2836..f46bdc7f6509 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -920,6 +920,9 @@ static void blk_release_queue(struct kobject *kobj)
 	blk_trace_shutdown(q);
 
 	debugfs_remove_recursive(q->debugfs_dir);
+#if defined(CONFIG_CHR_DEV_SG) || defined(CONFIG_CHR_DEV_SG_MODULE)
+	debugfs_remove_recursive(q->sg_debugfs_dir);
+#endif
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -939,6 +942,21 @@ struct kobj_type blk_queue_ktype = {
 	.release	= blk_release_queue,
 };
 
+#if defined(CONFIG_CHR_DEV_SG) || defined(CONFIG_CHR_DEV_SG_MODULE)
+/**
+ * blk_sg_debugfs_init - initialize debugs for scsi-generic
+ * @q: the associated queue
+ * @name: name of the scsi-generic device
+ *
+ * To be used by scsi-generic for allowing it to use blktrace.
+ */
+void blk_sg_debugfs_init(struct request_queue *q, const char *name)
+{
+	q->sg_debugfs_dir = debugfs_create_dir(name, blk_debugfs_root);
+}
+EXPORT_SYMBOL_GPL(blk_sg_debugfs_init);
+#endif
+
 /**
  * blk_register_queue - register a block layer queue with sysfs
  * @disk: Disk of which the request queue should be registered with sysfs.
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 20472aaaf630..c87fe1923f3d 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1519,6 +1519,7 @@ static int
 sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 {
 	struct scsi_device *scsidp = to_scsi_device(cl_dev->parent);
+	struct request_queue *q = scsidp->request_queue;
 	struct gendisk *disk;
 	Sg_device *sdp = NULL;
 	struct cdev * cdev = NULL;
@@ -1573,6 +1574,7 @@ sg_add_device(struct device *cl_dev, struct class_interface *cl_intf)
 	} else
 		pr_warn("%s: sg_sys Invalid\n", __func__);
 
+	blk_sg_debugfs_init(q, disk->disk_name);
 	sdev_printk(KERN_NOTICE, scsidp, "Attached scsi generic sg%d "
 		    "type %d\n", sdp->index, scsidp->type);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5877b03b8117..be5a40d59f60 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -575,6 +575,9 @@ struct request_queue {
 	struct bio_set		bio_split;
 
 	struct dentry		*debugfs_dir;
+#if defined(CONFIG_CHR_DEV_SG) || defined(CONFIG_CHR_DEV_SG_MODULE)
+	struct dentry		*sg_debugfs_dir;
+#endif
 #ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
@@ -858,6 +861,14 @@ static inline void rq_flush_dcache_pages(struct request *rq)
 
 extern int blk_register_queue(struct gendisk *disk);
 extern void blk_unregister_queue(struct gendisk *disk);
+#if defined(CONFIG_CHR_DEV_SG) || defined(CONFIG_CHR_DEV_SG_MODULE)
+extern void blk_sg_debugfs_init(struct request_queue *q, const char *name);
+#else
+static inline void blk_sg_debugfs_init(struct request_queue *q,
+				       const char *name)
+{
+}
+#endif
 extern blk_qc_t generic_make_request(struct bio *bio);
 extern blk_qc_t direct_make_request(struct bio *bio);
 extern void blk_rq_init(struct request_queue *q, struct request *rq);
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index a55cbfd060f5..5b0310f38e11 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -511,6 +511,11 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	 */
 	if (bdev && bdev != bdev->bd_contains) {
 		dir = bdev->bd_part->debugfs_dir;
+	} else if (q->sg_debugfs_dir &&
+		   strlen(buts->name) == strlen(q->sg_debugfs_dir->d_name.name)
+		   && strcmp(buts->name, q->sg_debugfs_dir->d_name.name) == 0) {
+		/* scsi-generic requires use of its own directory */
+		dir = q->sg_debugfs_dir;
 	} else {
 		/*
 		 * For queues that do not have a gendisk attached to them, that
