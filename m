Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE909436F44
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Oct 2021 03:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232109AbhJVBJS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Oct 2021 21:09:18 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:49406 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhJVBJR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:09:17 -0400
Received: from fsav118.sakura.ne.jp (fsav118.sakura.ne.jp [27.133.134.245])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 19M16BFq093106;
        Fri, 22 Oct 2021 10:06:11 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav118.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp);
 Fri, 22 Oct 2021 10:06:11 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav118.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 19M169gp093061
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 22 Oct 2021 10:06:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH v3 0/3] last batch of add_disk() error handling
 conversions
To:     Luis Chamberlain <mcgrof@kernel.org>, schmitzmic@gmail.com
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        efremov@linux.com, song@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, hare@suse.de,
        jack@suse.cz, ming.lei@redhat.com, tj@kernel.org
References: <20211021163856.2000993-1-mcgrof@kernel.org>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <66655777-6f9b-adbc-03ff-125aecd3f509@i-love.sakura.ne.jp>
Date:   Fri, 22 Oct 2021 10:06:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211021163856.2000993-1-mcgrof@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/10/22 1:38, Luis Chamberlain wrote:
> I rebased Tetsuo Handa's patch onto the latest linux-next as this
> series depends on it, and so I am sending it part of this series as
> without it, this won't apply. Tetsuo, does the rebase of your patch
> look OK?

OK, though I wanted my fix to be sent to upstream and stable before this series.

> 
> If it is not too much trouble, I'd like to ask for testing for the
> ataflop changes from Michael Schmitz, if possible, that is he'd just
> have to merge Tetsuo's rebased patch and the 2nd patch in this series.
> This is all rebased on linux-next tag 20211020.

Yes, please.

After this series, I guess we can remove "bool registered[NUM_DISK_MINORS];" like below
due to (unit[drive].disk[type] != NULL) == (unit[drive].registered[type] == true).
Regarding this series, setting unit[drive].registered[type] = true in ataflop_probe() is
pointless because atari_floppy_cleanup() checks unit[i].disk[type] != NULL for calling
del_gendisk(). And we need to fix __register_blkdev() in driver/block/floppy.c because
floppy_probe_lock is pointless.

 drivers/block/ataflop.c | 75 +++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 47 deletions(-)

diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
index c58750dcc685..7fedf8506335 100644
--- a/drivers/block/ataflop.c
+++ b/drivers/block/ataflop.c
@@ -299,7 +299,6 @@ static struct atari_floppy_struct {
 				   disk change detection) */
 	int flags;		/* flags */
 	struct gendisk *disk[NUM_DISK_MINORS];
-	bool registered[NUM_DISK_MINORS];
 	int ref;
 	int type;
 	struct blk_mq_tag_set tag_set;
@@ -1988,41 +1987,20 @@ static int ataflop_probe(dev_t dev)
 	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
 		return -EINVAL;
 
-	if (!unit[drive].disk[type]) {
-		err = ataflop_alloc_disk(drive, type);
-		if (err == 0) {
-			err = add_disk(unit[drive].disk[type]);
-			if (err) {
-				blk_cleanup_disk(unit[drive].disk[type]);
-				unit[drive].disk[type] = NULL;
-			} else
-				unit[drive].registered[type] = true;
+	if (unit[drive].disk[type])
+		return 0;
+	err = ataflop_alloc_disk(drive, type);
+	if (err == 0) {
+		err = add_disk(unit[drive].disk[type]);
+		if (err) {
+			blk_cleanup_disk(unit[drive].disk[type]);
+			unit[drive].disk[type] = NULL;
 		}
 	}
 
 	return err;
 }
 
-static void atari_floppy_cleanup(void)
-{
-	int i;
-	int type;
-
-	for (i = 0; i < FD_MAX_UNITS; i++) {
-		for (type = 0; type < NUM_DISK_MINORS; type++) {
-			if (!unit[i].disk[type])
-				continue;
-			del_gendisk(unit[i].disk[type]);
-			blk_cleanup_queue(unit[i].disk[type]->queue);
-			put_disk(unit[i].disk[type]);
-		}
-		blk_mq_free_tag_set(&unit[i].tag_set);
-	}
-
-	del_timer_sync(&fd_timer);
-	atari_stram_free(DMABuffer);
-}
-
 static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
 {
 	int type;
@@ -2030,13 +2008,24 @@ static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
 	for (type = 0; type < NUM_DISK_MINORS; type++) {
 		if (!fs->disk[type])
 			continue;
-		if (fs->registered[type])
-			del_gendisk(fs->disk[type]);
+		del_gendisk(fs->disk[type]);
 		blk_cleanup_disk(fs->disk[type]);
 	}
 	blk_mq_free_tag_set(&fs->tag_set);
 }
 
+static void atari_floppy_cleanup(void)
+{
+	int i;
+
+	for (i = 0; i < FD_MAX_UNITS; i++)
+		atari_cleanup_floppy_disk(&unit[i]);
+
+	del_timer_sync(&fd_timer);
+	if (DMABuffer)
+		atari_stram_free(DMABuffer);
+}
+
 static int __init atari_floppy_init (void)
 {
 	int i;
@@ -2055,13 +2044,10 @@ static int __init atari_floppy_init (void)
 		unit[i].tag_set.numa_node = NUMA_NO_NODE;
 		unit[i].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 		ret = blk_mq_alloc_tag_set(&unit[i].tag_set);
-		if (ret)
-			goto err;
-
-		ret = ataflop_alloc_disk(i, 0);
 		if (ret) {
-			blk_mq_free_tag_set(&unit[i].tag_set);
-			goto err;
+			while (--i >= 0)
+				blk_mq_free_tag_set(&unit[i].tag_set);
+			return ret;
 		}
 	}
 
@@ -2090,10 +2076,9 @@ static int __init atari_floppy_init (void)
 	for (i = 0; i < FD_MAX_UNITS; i++) {
 		unit[i].track = -1;
 		unit[i].flags = 0;
-		ret = add_disk(unit[i].disk[0]);
-		if (ret)
-			goto err_out_dma;
-		unit[i].registered[0] = true;
+		ret = ataflop_probe(MKDEV(0, 1 << 2));
+		if (err)
+			goto err;
 	}
 
 	printk(KERN_INFO "Atari floppy driver: max. %cD, %strack buffering\n",
@@ -2108,12 +2093,8 @@ static int __init atari_floppy_init (void)
 	}
 	return ret;
 
-err_out_dma:
-	atari_stram_free(DMABuffer);
 err:
-	while (--i >= 0)
-		atari_cleanup_floppy_disk(&unit[i]);
-
+	atari_floppy_cleanup();
 	return ret;
 }
 
-- 
2.18.4

