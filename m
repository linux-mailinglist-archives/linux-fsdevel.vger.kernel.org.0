Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 648AB42FB14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 20:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241209AbhJOSgU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 14:36:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238043AbhJOSgQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:36:16 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF966C061762;
        Fri, 15 Oct 2021 11:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9RF/xBkDb26d0/d/9ZXnO6GztufkDJdAq9Z00xKtzto=; b=tRH5yZ929XAkcM4IfLVtsLDdza
        Dk4q4rDNKOaoso42/j3VNFUeFWQBSeli9TgmtS+A2bHzkR+7eReA0q/ZkjiKXtG9N0AaCn8bH+ouc
        vCoak9BcPHTJChXwuSb8NVhA4kSGUfe53BcBSONoK7hlEwio6Z9lmfEn6QjTI214xRdUEP55/6uSl
        WZZFLuTIchauYq1n5ZyZ65ad3Vch7e8R0gsSTyFvfbo7928k2bzQwjNp7U4+00q7iLshz2jxmRpNC
        BJztgD1aAf7z2ggJuI+cgCIrV4zOfuzjB0K/LlARYJe6Lm1ZV6+HubzPmlQgJcWcuupXSB8nD1QQE
        RwAhjXng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbS1v-008T3z-Vm; Fri, 15 Oct 2021 18:34:07 +0000
Date:   Fri, 15 Oct 2021 11:34:07 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-raid@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
        efremov@linux.com, song@kernel.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, viro@zeniv.linux.org.uk, hare@suse.de,
        jack@suse.cz, ming.lei@redhat.com, tj@kernel.org
Subject: Re: [PATCH v2 1/2] block: make __register_blkdev() return an error
Message-ID: <YWnJnyysQQ86i5e/@bombadil.infradead.org>
References: <20210927220332.1074647-1-mcgrof@kernel.org>
 <20210927220332.1074647-2-mcgrof@kernel.org>
 <11a884b0-53f2-5174-fcb2-6247cece7104@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11a884b0-53f2-5174-fcb2-6247cece7104@i-love.sakura.ne.jp>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 09:19:47AM +0900, Tetsuo Handa wrote:
> On 2021/09/28 7:03, Luis Chamberlain wrote:
> > diff --git a/drivers/block/ataflop.c b/drivers/block/ataflop.c
> > index 5dc9b3d32415..be0627345b21 100644
> > --- a/drivers/block/ataflop.c
> > +++ b/drivers/block/ataflop.c
> > @@ -1989,24 +1989,34 @@ static int ataflop_alloc_disk(unsigned int drive, unsigned int type)
> >  
> >  static DEFINE_MUTEX(ataflop_probe_lock);
> >  
> > -static void ataflop_probe(dev_t dev)
> > +static int ataflop_probe(dev_t dev)
> >  {
> >  	int drive = MINOR(dev) & 3;
> >  	int type  = MINOR(dev) >> 2;
> > +	int err = 0;
> >  
> >  	if (type)
> >  		type--;
> >  
> > -	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS)
> > -		return;
> > +	if (drive >= FD_MAX_UNITS || type >= NUM_DISK_MINORS) {
> > +		err = -EINVAL;
> > +		goto out;
> > +	}
> > +
> >  	mutex_lock(&ataflop_probe_lock);
> >  	if (!unit[drive].disk[type]) {
> > -		if (ataflop_alloc_disk(drive, type) == 0) {
> > -			add_disk(unit[drive].disk[type]);
> > +		err = ataflop_alloc_disk(drive, type);
> > +		if (err == 0) {
> > +			err = add_disk(unit[drive].disk[type]);
> > +			if (err)
> > +				blk_cleanup_disk(unit[drive].disk[type]);
> >  			unit[drive].registered[type] = true;
> 
> Why setting registered to true despite add_disk() failed?
> del_gendisk() without successful add_disk() sounds wrong.

That was a mistake, fixed.

> Don't we need to undo ataflop_alloc_disk() because it sets
> unit[drive].disk[type] to non-NULL ?

ataflop_alloc_disk() just calls blk_mq_alloc_disk() for its
allocation, and so blk_cleanup_disk() does that for us. Please
let me know if I missed anything.

> > diff --git a/drivers/block/brd.c b/drivers/block/brd.c
> > index c2bf4946f4e3..82a93044de95 100644
> > --- a/drivers/block/brd.c
> > +++ b/drivers/block/brd.c
> > @@ -426,10 +426,11 @@ static int brd_alloc(int i)
> >  	return err;
> >  }
> >  
> > -static void brd_probe(dev_t dev)
> > +static int brd_probe(dev_t dev)
> >  {
> >  	int i = MINOR(dev) / max_part;
> >  	struct brd_device *brd;
> > +	int err = 0;
> >  
> >  	mutex_lock(&brd_devices_mutex);
> >  	list_for_each_entry(brd, &brd_devices, brd_list) {
> > @@ -437,9 +438,11 @@ static void brd_probe(dev_t dev)
> >  			goto out_unlock;
> >  	}
> >  
> > -	brd_alloc(i);
> > +	err = brd_alloc(i);
> >  out_unlock:
> >  	mutex_unlock(&brd_devices_mutex);
> > +
> > +	return err;
> >  }
> >  
> >  static void brd_del_one(struct brd_device *brd)
> 
> https://lkml.kernel.org/r/e205f13d-18ff-a49c-0988-7de6ea5ff823@i-love.sakura.ne.jp
> will require this part to be updated.

Indeed, rebased, thanks for the heads up!

> > diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
> > index 0434f28742e7..95a1c8ef62f7 100644
> > --- a/drivers/block/floppy.c
> > +++ b/drivers/block/floppy.c
> > @@ -4517,21 +4517,27 @@ static int floppy_alloc_disk(unsigned int drive, unsigned int type)
> >  
> >  static DEFINE_MUTEX(floppy_probe_lock);
> >  
> > -static void floppy_probe(dev_t dev)
> > +static int floppy_probe(dev_t dev)
> >  {
> >  	unsigned int drive = (MINOR(dev) & 3) | ((MINOR(dev) & 0x80) >> 5);
> >  	unsigned int type = (MINOR(dev) >> 2) & 0x1f;
> > +	int err = 0;
> >  
> >  	if (drive >= N_DRIVE || !floppy_available(drive) ||
> >  	    type >= ARRAY_SIZE(floppy_type))
> > -		return;
> > +		return -EINVAL;
> >  
> >  	mutex_lock(&floppy_probe_lock);
> >  	if (!disks[drive][type]) {
> > -		if (floppy_alloc_disk(drive, type) == 0)
> > -			add_disk(disks[drive][type]);
> > +		if (floppy_alloc_disk(drive, type) == 0) {
> > +			err = add_disk(disks[drive][type]);
> > +			if (err)
> > +				blk_cleanup_disk(disks[drive][type]);
> 
> This makes future floppy_probe() no-op once add_disk() failed (or maybe a bad
> thing happens somewhere else), for disks[drive][type] was set to non-NULL by
> floppy_alloc_disk() but blk_cleanup_disk() does not reset it to NULL.

Thanks!

I think just setting disks[drive][type] = NULL after the
blk_cleanup_disk() fixes that issue.

> According to floppy_module_exit() which tries to cleanup it, implementing
> undo might be complicated...

I can't see what would be missing from just setting disks[drive][type] = NULL.
Can you clarify?

  Luis
