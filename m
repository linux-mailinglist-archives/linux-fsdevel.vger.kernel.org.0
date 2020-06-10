Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B621F4E5F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jun 2020 08:43:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFJGnQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Jun 2020 02:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgFJGnQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Jun 2020 02:43:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E39E4C03E96B;
        Tue,  9 Jun 2020 23:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=O6XB3y7iP5PElbqh7ZAm6TiDYuBfIirIuSUwEnknJtQ=; b=tL4wIK6N92i3MrpckN6LKQJmtz
        HdOLmmacDx4TQJx7NZ1wtwJmRMbrEvWM/7DgvnDBHitLelejf0E/4FoxicSG3aCXwjNbwGyIG3JJb
        YEneEhXFkPw812wSmWIOpgq5Js7sm1i0ycjVzAjjbnFm/jMROmTVezHTNeufrtAisMQBOnRkCsqiL
        nqEwd0Jk5eoIMSzYNbtf8bekmCAnAnNWWFh8QMtdktZZpLiT6M7O+DuHFSk6e3oveqYQiG1fu/vj/
        mK72cRmhmqmoNcVsZM5uw3fbT2zET0MwA4197fkVb1lKzjYm+W5IldS6izcMgX63ykGOhyMFYdj+e
        dai4OkOw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiuRW-0001at-Eh; Wed, 10 Jun 2020 06:42:34 +0000
Date:   Tue, 9 Jun 2020 23:42:34 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, bvanassche@acm.org,
        gregkh@linuxfoundation.org, rostedt@goodmis.org, mingo@redhat.com,
        ming.lei@redhat.com, nstange@suse.de, akpm@linux-foundation.org,
        mhocko@suse.com, yukuai3@huawei.com, martin.petersen@oracle.com,
        jejb@linux.ibm.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Hannes Reinecke <hare@suse.com>,
        Michal Hocko <mhocko@kernel.org>,
        syzbot+603294af2d01acfdd6da@syzkaller.appspotmail.com
Subject: Re: [PATCH v6 6/6] blktrace: fix debugfs use after free
Message-ID: <20200610064234.GB24975@infradead.org>
References: <20200608170127.20419-1-mcgrof@kernel.org>
 <20200608170127.20419-7-mcgrof@kernel.org>
 <20200609150602.GA7111@infradead.org>
 <20200609172922.GP11244@42.do-not-panic.com>
 <20200609173218.GA7968@infradead.org>
 <20200609175359.GR11244@42.do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609175359.GR11244@42.do-not-panic.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 09, 2020 at 05:53:59PM +0000, Luis Chamberlain wrote:
> > Feel free to add more comments, but please try to keep them short
> > and crisp.  At the some point long comments really distract from what
> > is going on.
> 
> Sure.
> 
> Come to think of it, given the above, I think we can also do way with
> the the partition stuff too, and rely on the buts->name too. I'll try
> this out, and test it.

Yes, the sg path should work for partitions as well.  That should not
only simplify the code, but also the comments, we can do something like
the full patch below (incorporating your original one).  This doesn't
include the error check on the creation - I think that check probably
is a good idea for this case based on the comments in the old patch, but
also a separate issue that should go into another patch on top.

diff --git a/block/blk-mq-debugfs.c b/block/blk-mq-debugfs.c
index 15df3a36e9fa43..a2800bc56fb4d3 100644
--- a/block/blk-mq-debugfs.c
+++ b/block/blk-mq-debugfs.c
@@ -824,9 +824,6 @@ void blk_mq_debugfs_register(struct request_queue *q)
 	struct blk_mq_hw_ctx *hctx;
 	int i;
 
-	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
-					    blk_debugfs_root);
-
 	debugfs_create_files(q->debugfs_dir, q, blk_mq_debugfs_queue_attrs);
 
 	/*
@@ -857,9 +854,7 @@ void blk_mq_debugfs_register(struct request_queue *q)
 
 void blk_mq_debugfs_unregister(struct request_queue *q)
 {
-	debugfs_remove_recursive(q->debugfs_dir);
 	q->sched_debugfs_dir = NULL;
-	q->debugfs_dir = NULL;
 }
 
 static void blk_mq_debugfs_register_ctx(struct blk_mq_hw_ctx *hctx,
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 561624d4cc4e7f..4e9909e1b25736 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -11,6 +11,7 @@
 #include <linux/blktrace_api.h>
 #include <linux/blk-mq.h>
 #include <linux/blk-cgroup.h>
+#include <linux/debugfs.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -918,6 +919,7 @@ static void blk_release_queue(struct kobject *kobj)
 
 	blk_trace_shutdown(q);
 
+	debugfs_remove_recursive(q->debugfs_dir);
 	if (queue_is_mq(q))
 		blk_mq_debugfs_unregister(q);
 
@@ -989,6 +991,9 @@ int blk_register_queue(struct gendisk *disk)
 		goto unlock;
 	}
 
+	q->debugfs_dir = debugfs_create_dir(kobject_name(q->kobj.parent),
+					    blk_debugfs_root);
+
 	if (queue_is_mq(q)) {
 		__blk_mq_register_dev(dev, q);
 		blk_mq_debugfs_register(q);
diff --git a/block/blk.h b/block/blk.h
index b5d1f0fc6547c7..499308c6ab3b0f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -14,9 +14,7 @@
 /* Max future timer expiry for timeouts */
 #define BLK_MAX_TIMEOUT		(5 * HZ)
 
-#ifdef CONFIG_DEBUG_FS
 extern struct dentry *blk_debugfs_root;
-#endif
 
 struct blk_flush_queue {
 	unsigned int		flush_pending_idx:1;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index fc88330a3d97ed..b49c7c741bc9f3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -574,8 +574,8 @@ struct request_queue {
 	struct list_head	tag_set_list;
 	struct bio_set		bio_split;
 
-#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*debugfs_dir;
+#ifdef CONFIG_BLK_DEBUG_FS
 	struct dentry		*sched_debugfs_dir;
 	struct dentry		*rqos_debugfs_dir;
 #endif
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index fee5c8d8916690..6eb364b393714f 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -509,10 +509,15 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 	if (!bt->msg_data)
 		goto err;
 
-	ret = -ENOENT;
-
-	dir = debugfs_lookup(buts->name, blk_debugfs_root);
-	if (!dir)
+	/*
+	 * When tracing a whole block device, reuse the existing debugfs
+	 * directory created by the block layer.  For partitions or character
+	 * devices (e.g. /dev/sg), create a new debugfs directory that will be
+	 * removed once the trace ends.
+	 */
+	if (bdev && bdev == bdev->bd_contains)
+		dir = q->debugfs_dir;
+	else
 		bt->dir = dir = debugfs_create_dir(buts->name, blk_debugfs_root);
 
 	bt->dev = dev;
@@ -553,8 +558,6 @@ static int do_blk_trace_setup(struct request_queue *q, char *name, dev_t dev,
 
 	ret = 0;
 err:
-	if (dir && !bt->dir)
-		dput(dir);
 	if (ret)
 		blk_trace_free(bt);
 	return ret;
