Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC7B42E538
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Oct 2021 02:23:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234578AbhJOAZC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Oct 2021 20:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232796AbhJOAY5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Oct 2021 20:24:57 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F35BC061570;
        Thu, 14 Oct 2021 17:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OUxfpVYwd1GISRQGHaPwsHIXWhsw5Vl+rVIwmaXqPus=; b=BWCEZGQgSTnq6IcezkJ/FcXHOX
        lTsyP6U1zNSYHW6xi0f7JJ/gCPvqj5otkDqItzlhW1Jh55zXpKcM3fMrJeRhMIuPL6+RhQ3Nqn/Kl
        uBbNmBHqO3JiXHgvV1GcTEQJZ6EY4wjDP+fTc7q6pbqMPMMfdsgp56QzmIINFg0L6V85vp8atq7fk
        8pnKiGXMngNHmU0ez9ghshWUrWlNzzWI0Q65GDzrsUu3rwz/nuVYxt0YupIpziAiygEuBaViYVohr
        w+7OjuR2T6zzzMpZXZUhn/BgTJgcOXEfmECx6G/qkn6GymAjKvvxvxVOwKeHMzxvQHh1x4Iw/9oJb
        wqMk+ESA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mbAzg-004lOG-7L; Fri, 15 Oct 2021 00:22:40 +0000
Date:   Thu, 14 Oct 2021 17:22:40 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     tj@kernel.org, gregkh@linuxfoundation.org,
        akpm@linux-foundation.org, minchan@kernel.org, jeyu@kernel.org,
        shuah@kernel.org, bvanassche@acm.org, dan.j.williams@intel.com,
        joe@perches.com, tglx@linutronix.de, keescook@chromium.org,
        rostedt@goodmis.org, linux-spdx@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
References: <20210927163805.808907-1-mcgrof@kernel.org>
 <20210927163805.808907-12-mcgrof@kernel.org>
 <YWeOJP2UJWYF94fu@T590>
 <YWeR4moCRh+ZHOmH@T590>
 <YWiSAN6xfYcUDJCb@bombadil.infradead.org>
 <YWjCpLUNPF3s4P2U@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWjCpLUNPF3s4P2U@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 15, 2021 at 07:52:04AM +0800, Ming Lei wrote:
> On Thu, Oct 14, 2021 at 01:24:32PM -0700, Luis Chamberlain wrote:
> > On Thu, Oct 14, 2021 at 10:11:46AM +0800, Ming Lei wrote:
> > > On Thu, Oct 14, 2021 at 09:55:48AM +0800, Ming Lei wrote:
> > > > On Mon, Sep 27, 2021 at 09:38:04AM -0700, Luis Chamberlain wrote:
> > > 
> > > ...
> > > 
> > > > 
> > > > Hello Luis,
> > > > 
> > > > Can you test the following patch and see if the issue can be addressed?
> > > > 
> > > > Please see the idea from the inline comment.
> > > > 
> > > > Also zram_index_mutex isn't needed in zram disk's store() compared with
> > > > your patch, then the deadlock issue you are addressing in this series can
> > > > be avoided.
> > > > 
> > > > 
> > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > index fcaf2750f68f..3c17927d23a7 100644
> > > > --- a/drivers/block/zram/zram_drv.c
> > > > +++ b/drivers/block/zram/zram_drv.c
> > > > @@ -1985,11 +1985,17 @@ static int zram_remove(struct zram *zram)
> > > >  
> > > >  	/* Make sure all the pending I/O are finished */
> > > >  	fsync_bdev(bdev);
> > > > -	zram_reset_device(zram);
> > > >  
> > > >  	pr_info("Removed device: %s\n", zram->disk->disk_name);
> > > >  
> > > >  	del_gendisk(zram->disk);
> > > > +
> > > > +	/*
> > > > +	 * reset device after gendisk is removed, so any change from sysfs
> > > > +	 * store won't come in, then we can really reset device here
> > > > +	 */
> > > > +	zram_reset_device(zram);
> > > > +
> > > >  	blk_cleanup_disk(zram->disk);
> > > >  	kfree(zram);
> > > >  	return 0;
> > > > @@ -2073,7 +2079,12 @@ static int zram_remove_cb(int id, void *ptr, void *data)
> > > >  static void destroy_devices(void)
> > > >  {
> > > >  	class_unregister(&zram_control_class);
> > > > +
> > > > +	/* hold the global lock so new device can't be added */
> > > > +	mutex_lock(&zram_index_mutex);
> > > >  	idr_for_each(&zram_index_idr, &zram_remove_cb, NULL);
> > > > +	mutex_unlock(&zram_index_mutex);
> > > > +
> > > 
> > > Actually zram_index_mutex isn't needed when calling zram_remove_cb()
> > > since the zram-control sysfs interface has been removed, so userspace
> > > can't add new device any more, then the issue is supposed to be fixed
> > > by the following one line change, please test it:
> > > 
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index fcaf2750f68f..96dd641de233 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -1985,11 +1985,17 @@ static int zram_remove(struct zram *zram)
> > >  
> > >  	/* Make sure all the pending I/O are finished */
> > >  	fsync_bdev(bdev);
> > > -	zram_reset_device(zram);
> > >  
> > >  	pr_info("Removed device: %s\n", zram->disk->disk_name);
> > >  
> > >  	del_gendisk(zram->disk);
> > > +
> > > +	/*
> > > +	 * reset device after gendisk is removed, so any change from sysfs
> > > +	 * store won't come in, then we can really reset device here
> > > +	 */
> > > +	zram_reset_device(zram);
> > > +
> > >  	blk_cleanup_disk(zram->disk);
> > >  	kfree(zram);
> > >  	return 0;
> > 
> > Sorry but nope, the cpu multistate issue is still present and we end up
> > eventually with page faults. I tried with both patches.
> 
> In theory disksize_store() can't come in after del_gendisk() returns,
> then zram_reset_device() should cleanup everything, that is the issue
> you described in commit log.
> 
> We need to understand the exact reason why there is still cpuhp node
> left, can you share us the exact steps for reproducing the issue?
> Otherwise we may have to trace and narrow down the reason.

See my commit log for my own fix for this issue.

  Luis
