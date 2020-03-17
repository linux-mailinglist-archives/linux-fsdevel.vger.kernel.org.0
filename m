Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E130188470
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Mar 2020 13:42:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgCQMmt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Mar 2020 08:42:49 -0400
Received: from verein.lst.de ([213.95.11.211]:59628 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgCQMmt (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:42:49 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BBA8C68CEC; Tue, 17 Mar 2020 13:42:44 +0100 (CET)
Date:   Tue, 17 Mar 2020 13:42:44 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     He Zhe <zhe.he@windriver.com>
Cc:     Christoph Hellwig <hch@lst.de>, jack@suse.cz,
        Jens Axboe <axboe@kernel.dk>, viro@zeniv.linux.org.uk,
        bvanassche@acm.org, keith.busch@intel.com, tglx@linutronix.de,
        mwilck@suse.com, yuyufen@huawei.com, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: disk revalidation updates and OOM
Message-ID: <20200317124244.GA12316@lst.de>
References: <93b395e6-5c3f-0157-9572-af0f9094dbd7@windriver.com> <20200310074018.GB26381@lst.de> <75865e17-48f8-a63a-3a29-f995115ffcfc@windriver.com> <20200310162647.GA6361@lst.de> <f48683d9-7854-ba5f-da3a-7ef987a539b8@windriver.com> <20200311155458.GA24376@lst.de> <18bbb6cd-578e-5ead-f2cd-a8a01db17e29@windriver.com> <20200316113746.GA15930@lst.de> <4215351e-89ac-4969-1d52-e2ff5c064d7d@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4215351e-89ac-4969-1d52-e2ff5c064d7d@windriver.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Mar 17, 2020 at 04:50:11PM +0800, He Zhe wrote:
> >> With my build fix applied, the issue is triggered since 142fe8f.
> >> And I can see the endless loop of invalidate and revalidate...
> > Thanks.  Can you test the patch below that restores the previous
> > rather odd behavior of not clearing the capacity to 0 if partition
> > scanning is not enabled?
> 
> This fixes the issue. I also validated it on v5.6-rc6.

Can you check this slight variant that only skips the capacity
change for removable devices given that IIRC you reported the problem
with a legacy ide-cd device?


diff --git a/fs/block_dev.c b/fs/block_dev.c
index 69bf2fb6f7cd..3212ac85d493 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1520,10 +1520,14 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	if (ret)
 		return ret;
 
-	if (invalidate)
-		set_capacity(disk, 0);
-	else if (disk->fops->revalidate_disk)
-		disk->fops->revalidate_disk(disk);
+	if (invalidate) {
+		if (!(disk->flags & GENHD_FL_REMOVABLE) ||
+		    disk_part_scan_enabled(disk))
+			set_capacity(disk, 0);
+	} else {
+		if (disk->fops->revalidate_disk)
+			disk->fops->revalidate_disk(disk);
+	}
 
 	check_disk_size_change(disk, bdev, !invalidate);
 
