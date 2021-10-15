Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52ED642FB3A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241496AbhJOSpl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Oct 2021 14:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241405AbhJOSpd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Oct 2021 14:45:33 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E19CC061570;
        Fri, 15 Oct 2021 11:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CrScqNKMgRV1rKvxe0whCx/+ah432GRzJ6rU4W802Bg=; b=e8yUBc7VImD8hMVZvoak5LZiI0
        XuCa4kRJ/sMe0/AKP6Y7pUNQlINfWnpN48qy1UcXov5eBZRHO42yaD7EiJ8GfcsupZTucc7gp4uCI
        RLRoYivgL3qydgIg9R0ydVOVNVoiooG2WZrbzU+52LgTABMGTysGTfVTuhhL/13yiC4IDQlEPOWoq
        CFYEiCaUApfdlh4TZ3+gP7/ylAPPxxuF1xvYQ9Zs5PKvWttP8FrzuwGgkHyYsqTKzRe6SSMeqN+qg
        03/46Fc11IfcngA7KSMUqv2x56TGi1o6PrzyiD4dLVRZSA4p7HU5f4IbPzDZ8+8W+C7GMQdtF8E4D
        pc7XbnUw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbSAn-008U2u-6D; Fri, 15 Oct 2021 18:43:17 +0000
Date:   Fri, 15 Oct 2021 11:43:17 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Finn Thain <fthain@linux-m68k.org>
Cc:     axboe@kernel.dk, hch@lst.de, efremov@linux.com, song@kernel.org,
        jejb@linux.ibm.com, martin.petersen@oracle.com,
        viro@zeniv.linux.org.uk, hare@suse.de, jack@suse.cz,
        ming.lei@redhat.com, tj@kernel.org, linux-raid@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: [PATCH v2 1/2] block: make __register_blkdev() return an error
Message-ID: <YWnLxahmHK5hDm2y@bombadil.infradead.org>
References: <20210927220332.1074647-1-mcgrof@kernel.org>
 <20210927220332.1074647-2-mcgrof@kernel.org>
 <2ac2e05f-327a-b66f-aaa0-276db2e46730@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2ac2e05f-327a-b66f-aaa0-276db2e46730@linux-m68k.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 28, 2021 at 10:57:18AM +1000, Finn Thain wrote:
> On Mon, 27 Sep 2021, Luis Chamberlain wrote:
> 
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
> >  		}
> >  	}
> >  	mutex_unlock(&ataflop_probe_lock);
> > +
> > +out:
> > +	return err;
> >  }
> >  
> >  static void atari_cleanup_floppy_disk(struct atari_floppy_struct *fs)
> 
> I think the change to ataflop_probe() would be more clear without adding 
> an 'out' label, like your change to floppy.c:

Good point! Fixed.

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
> > +		}
> >  	}
> >  	mutex_unlock(&floppy_probe_lock);
> > +
> > +	return err;
> >  }
> >  
> >  static int __init do_floppy_init(void)
> 
> In floppy_probe(), I think you should return the potential error result 
> from floppy_alloc_disk(), like you did in ataflop.c.

Indeed, thanks, fixed.

  Luis
