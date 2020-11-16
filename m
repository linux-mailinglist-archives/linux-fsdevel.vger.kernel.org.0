Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5BF2B4792
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 16:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730881AbgKPO7U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 09:59:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730846AbgKPO7S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 09:59:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01C12C0613D2;
        Mon, 16 Nov 2020 06:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=9MasGm4sRMlqjIfBzvyRbCzoZ9vCizFcPgSc5rhaRew=; b=uXQm/yyIiJQnYODeCv7tLBroh6
        arXMrp0Tk+2mkvK5mlMoVYQZhqOzsPFVFoVsNhqaXKjdbjxT6ddIFdHimSsiofqQFd042iVeyoPjf
        kjJVvZC7dJvRJWgFk5vnXEzcfiS2wRI+9CAHzFb6PaF2pf3aK/Vv/y+iBA3+wNlveiknIb+cM4k72
        sy6+79pc3yQnXdRLw5qP9MUrMQWCUQr94hrqb0BHYJRuZX0RRf1WPApUNdGnDYjJKsodIy93uSBGl
        mXFAo94CwxYf32WkNugPW9wMsBEd2E2lCs3nmZ+m6b8g/Nfawh6vTjWCNJv2VNFFCFBCwJLajvHZl
        HFZ0RH2Q==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kefyA-0003wx-DT; Mon, 16 Nov 2020 14:59:02 +0000
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
Subject: [PATCH 37/78] block: split block_class_lock
Date:   Mon, 16 Nov 2020 15:57:28 +0100
Message-Id: <20201116145809.410558-38-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split the block_class_lock mutex into one each to protect bdev_map
and major_names.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 block/genhd.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 482f7b89802010..2a20372756625e 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -25,7 +25,6 @@
 
 #include "blk.h"
 
-static DEFINE_MUTEX(block_class_lock);
 static struct kobject *block_depr;
 
 struct bdev_map {
@@ -37,6 +36,7 @@ struct bdev_map {
 	int (*lock)(dev_t, void *);
 	void *data;
 } *bdev_map[255];
+static DEFINE_MUTEX(bdev_map_lock);
 
 /* for extended dynamic devt allocation, currently only one major is used */
 #define NR_EXT_DEVT		(1 << MINORBITS)
@@ -400,6 +400,7 @@ static struct blk_major_name {
 	int major;
 	char name[16];
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
+static DEFINE_MUTEX(major_names_lock);
 
 /* index in the above - for now: assume no multimajor ranges */
 static inline int major_to_index(unsigned major)
@@ -412,11 +413,11 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 {
 	struct blk_major_name *dp;
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&major_names_lock);
 	for (dp = major_names[major_to_index(offset)]; dp; dp = dp->next)
 		if (dp->major == offset)
 			seq_printf(seqf, "%3d %s\n", dp->major, dp->name);
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&major_names_lock);
 }
 #endif /* CONFIG_PROC_FS */
 
@@ -445,7 +446,7 @@ int register_blkdev(unsigned int major, const char *name)
 	struct blk_major_name **n, *p;
 	int index, ret = 0;
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&major_names_lock);
 
 	/* temporary */
 	if (major == 0) {
@@ -498,7 +499,7 @@ int register_blkdev(unsigned int major, const char *name)
 		kfree(p);
 	}
 out:
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&major_names_lock);
 	return ret;
 }
 
@@ -510,7 +511,7 @@ void unregister_blkdev(unsigned int major, const char *name)
 	struct blk_major_name *p = NULL;
 	int index = major_to_index(major);
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&major_names_lock);
 	for (n = &major_names[index]; *n; n = &(*n)->next)
 		if ((*n)->major == major)
 			break;
@@ -520,7 +521,7 @@ void unregister_blkdev(unsigned int major, const char *name)
 		p = *n;
 		*n = p->next;
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&major_names_lock);
 	kfree(p);
 }
 
@@ -671,7 +672,7 @@ void blk_register_region(dev_t devt, unsigned long range, struct module *module,
 		p->data = data;
 	}
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&bdev_map_lock);
 	for (i = 0, p -= n; i < n; i++, p++, index++) {
 		struct bdev_map **s = &bdev_map[index % 255];
 		while (*s && (*s)->range < range)
@@ -679,7 +680,7 @@ void blk_register_region(dev_t devt, unsigned long range, struct module *module,
 		p->next = *s;
 		*s = p;
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&bdev_map_lock);
 }
 EXPORT_SYMBOL(blk_register_region);
 
@@ -690,7 +691,7 @@ void blk_unregister_region(dev_t devt, unsigned long range)
 	unsigned i;
 	struct bdev_map *found = NULL;
 
-	mutex_lock(&block_class_lock);
+	mutex_lock(&bdev_map_lock);
 	for (i = 0; i < min(n, 255u); i++, index++) {
 		struct bdev_map **s;
 		for (s = &bdev_map[index % 255]; *s; s = &(*s)->next) {
@@ -703,7 +704,7 @@ void blk_unregister_region(dev_t devt, unsigned long range)
 			}
 		}
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&bdev_map_lock);
 	kfree(found);
 }
 EXPORT_SYMBOL(blk_unregister_region);
@@ -1034,7 +1035,7 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 	unsigned long best = ~0UL;
 
 retry:
-	mutex_lock(&block_class_lock);
+	mutex_lock(&bdev_map_lock);
 	for (p = bdev_map[MAJOR(dev) % 255]; p; p = p->next) {
 		struct kobject *(*probe)(dev_t, int *, void *);
 		struct module *owner;
@@ -1055,7 +1056,7 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 			module_put(owner);
 			continue;
 		}
-		mutex_unlock(&block_class_lock);
+		mutex_unlock(&bdev_map_lock);
 		kobj = probe(dev, partno, data);
 		/* Currently ->owner protects _only_ ->probe() itself. */
 		module_put(owner);
@@ -1063,7 +1064,7 @@ static struct gendisk *lookup_gendisk(dev_t dev, int *partno)
 			return dev_to_disk(kobj_to_dev(kobj));
 		goto retry;
 	}
-	mutex_unlock(&block_class_lock);
+	mutex_unlock(&bdev_map_lock);
 	return NULL;
 }
 
-- 
2.29.2

