Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6DB3E8FD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Aug 2021 13:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232160AbhHKLwO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Aug 2021 07:52:14 -0400
Received: from verein.lst.de ([213.95.11.211]:40261 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229836AbhHKLwO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Aug 2021 07:52:14 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C07CA67373; Wed, 11 Aug 2021 13:51:47 +0200 (CEST)
Date:   Wed, 11 Aug 2021 13:51:47 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>,
        linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: move the bdi from the request_queue to the gendisk
Message-ID: <20210811115147.GA27860@lst.de>
References: <20210809141744.1203023-1-hch@lst.de> <e5e19d15-7efd-31f4-941a-a5eb2f94b898@quicinc.com> <20210810200256.GA30809@lst.de> <20210811112514.GC14725@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210811112514.GC14725@quack2.suse.cz>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 11, 2021 at 01:25:14PM +0200, Jan Kara wrote:
> Well, non-default bdi_writeback structures do hold bdi reference - see
> wb_exit() which drops the reference. I think the problem rather was that a
> block device's inode->i_wb was pointing to the default bdi_writeback
> structure and that got freed after bdi_put() before block device inode was
> shutdown through bdput()... So what I think we need is that if the inode
> references the default writeback structure, it actually holds a reference
> to the bdi.

Qian, can you test the patch below instead of the one I sent yesterday?

diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index cd06dca232c3..edfb7ce2cc93 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -283,8 +283,7 @@ static int wb_init(struct bdi_writeback *wb, struct backing_dev_info *bdi,
 
 	memset(wb, 0, sizeof(*wb));
 
-	if (wb != &bdi->wb)
-		bdi_get(bdi);
+	bdi_get(bdi);
 	wb->bdi = bdi;
 	wb->last_old_flush = jiffies;
 	INIT_LIST_HEAD(&wb->b_dirty);
@@ -362,8 +361,7 @@ static void wb_exit(struct bdi_writeback *wb)
 		percpu_counter_destroy(&wb->stat[i]);
 
 	fprop_local_destroy_percpu(&wb->completions);
-	if (wb != &wb->bdi->wb)
-		bdi_put(wb->bdi);
+	bdi_put(wb->bdi);
 }
 
 #ifdef CONFIG_CGROUP_WRITEBACK
