Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2AF434F4E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Oct 2021 17:48:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbhJTPue (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 11:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbhJTPud (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:50:33 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAEC4C06161C;
        Wed, 20 Oct 2021 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HBm/Dqi3jW7uqk4DDOcgZCLMM+rxars2xSrNqJBELD4=; b=2Nfb8jhDT8Z/1YppkaaGzMBE5F
        7DhHQ0SucI4gkSMWSPV7qRIfV71Fm6qrfDrJmlPqzT7KRfnj1yBiDyOvhgFH59z59TYTW1kELLAVg
        mLk1u/MgB+DYSZ1pYh9quyEyxaf9eS7gY6oh1R2myWpq2f4ZN+t8O9pDmupq3jh8lU1/6coGTgRIG
        C8k2APmUBWLR1sFqAAQXTM7S5Y5k25OWJXYSBl+d9lruqyMox+TX5UmnYt1ffUmBrwhJfbE6Q8mm2
        r6X/+eHUQhd8s8zbcTZND5RIi0WiXLOOp5v6be+Wi35/qyZrcuIhl8AEJKo3MYxcs2OMjnbQngNMf
        RACz1Adg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mdDoy-0057WV-4E; Wed, 20 Oct 2021 15:48:04 +0000
Date:   Wed, 20 Oct 2021 08:48:04 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ming Lei <ming.lei@redhat.com>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YXA6NMhwoiIMeHji@bombadil.infradead.org>
References: <YWjJ0O7K+31Iz3ox@bombadil.infradead.org>
 <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7kFXlzRrvwzARP@bombadil.infradead.org>
 <YW7ygbLAwm2/LZFl@T590>
 <YW8eSq2B+5FtOLZb@bombadil.infradead.org>
 <YW9tqPunx5bssxIz@T590>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YW9tqPunx5bssxIz@T590>
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 09:15:20AM +0800, Ming Lei wrote:
> On Tue, Oct 19, 2021 at 12:36:42PM -0700, Luis Chamberlain wrote:
> > On Wed, Oct 20, 2021 at 12:29:53AM +0800, Ming Lei wrote:
> > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > index d0cae7a42f4d..a14ba3d350ea 100644
> > > --- a/drivers/block/zram/zram_drv.c
> > > +++ b/drivers/block/zram/zram_drv.c
> > > @@ -1704,12 +1704,12 @@ static void zram_reset_device(struct zram *zram)
> > >  	set_capacity_and_notify(zram->disk, 0);
> > >  	part_stat_set_all(zram->disk->part0, 0);
> > >  
> > > -	up_write(&zram->init_lock);
> > >  	/* I/O operation under all of CPU are done so let's free */
> > >  	zram_meta_free(zram, disksize);
> > >  	memset(&zram->stats, 0, sizeof(zram->stats));
> > >  	zcomp_destroy(comp);
> > >  	reset_bdev(zram);
> > > +	up_write(&zram->init_lock);
> > >  }
> > >  
> > >  static ssize_t disksize_store(struct device *dev,
> > 
> > With this, it still ends up in a state where we loop and can't get out of:
> > 
> > zram: Can't change algorithm for initialized device
> 
> Again, you are running two zram02.sh[1] on /dev/zram0, that isn't unexpected

You mean that it is not expected? If so then yes, of course.

> behavior. Here the difference is just timing.

Right, but that is what helped reproduce a difficutl to re-produce customer
bug. Once you find an easy way to reproduce a reported issue you stick
with it and try to make the situation worse to ensure no more bugs are
present.

> Also you did not answer my question about your test expected result when
> running the following script from two terminal concurrently:
> 
> 	while true; do
> 		PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh;
> 	done

If you run this, you should see no failures.

Once you start a second script that one should cause odd issues on both
sides but never crash or stall the module.

A second series of tests is hitting CTRL-C on either randonly and
restarting testing once again randomly.

Again, neither should crash the kernel or stall the module.

In the end of these tests you should be able to run the script alone
just once and not see issues.

  Luis
