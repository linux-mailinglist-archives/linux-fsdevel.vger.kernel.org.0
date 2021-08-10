Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF3453E8410
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Aug 2021 22:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbhHJUDW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Aug 2021 16:03:22 -0400
Received: from verein.lst.de ([213.95.11.211]:37977 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232782AbhHJUDW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:03:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id EE1306736F; Tue, 10 Aug 2021 22:02:56 +0200 (CEST)
Date:   Tue, 10 Aug 2021 22:02:56 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Qian Cai <quic_qiancai@quicinc.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Tejun Heo <tj@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: move the bdi from the request_queue to the gendisk
Message-ID: <20210810200256.GA30809@lst.de>
References: <20210809141744.1203023-1-hch@lst.de> <e5e19d15-7efd-31f4-941a-a5eb2f94b898@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5e19d15-7efd-31f4-941a-a5eb2f94b898@quicinc.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 10, 2021 at 03:36:39PM -0400, Qian Cai wrote:
> 
> 
> On 8/9/2021 10:17 AM, Christoph Hellwig wrote:
> > Hi Jens,
> > 
> > this series moves the pointer to the bdi from the request_queue
> > to the bdi, better matching the life time rules of the different
> > objects.
> 
> Reverting this series fixed an use-after-free in bdev_evict_inode().

Please try the patch below as a band-aid.  Although the proper fix is
that non-default bdi_writeback structures grab a reference to the bdi,
as this was a landmine that might have already caused spurious issues
before.

diff --git a/block/genhd.c b/block/genhd.c
index f8def1129501..2e4a9d187196 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1086,7 +1086,6 @@ static void disk_release(struct device *dev)
 
 	might_sleep();
 
-	bdi_put(disk->bdi);
 	if (MAJOR(dev->devt) == BLOCK_EXT_MAJOR)
 		blk_free_ext_minor(MINOR(dev->devt));
 	disk_release_events(disk);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7c969f81327a..c6087dbae6cf 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -849,11 +849,15 @@ static void init_once(void *data)
 
 static void bdev_evict_inode(struct inode *inode)
 {
+	struct block_device *bdev = I_BDEV(inode);
+
 	truncate_inode_pages_final(&inode->i_data);
 	invalidate_inode_buffers(inode); /* is it needed here? */
 	clear_inode(inode);
 	/* Detach inode from wb early as bdi_put() may free bdi->wb */
 	inode_detach_wb(inode);
+	if (!bdev_is_partition(bdev))
+		bdi_put(bdev->bd_disk->bdi);
 }
 
 static const struct super_operations bdev_sops = {
