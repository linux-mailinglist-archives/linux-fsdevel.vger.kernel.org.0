Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 566574357E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Oct 2021 02:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbhJUAmH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Oct 2021 20:42:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231199AbhJUAmG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Oct 2021 20:42:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634776791;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nINcHNP1LunHuFgS+T7bSGFWStA5gFA7A821E6TM/8E=;
        b=a9Zv1rn/GXs0jDPu1oIgn9ZYIy6qwQSyUVPpGp8vhlgwX41y6yarKinqp5hqn5Ej98tE63
        DZDwdMBupspCMpk/upzH4UlFCWKYHm9x0j3osc8TagzFDdF1w/FT52P4dMduW0pASQ87dQ
        QUE9Am7NeeZubgZMRc+VXHvKCEZWJlM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-c3Q0yG6OP5e-tVuS9OPEsw-1; Wed, 20 Oct 2021 20:39:45 -0400
X-MC-Unique: c3Q0yG6OP5e-tVuS9OPEsw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AFD5A1006AA2;
        Thu, 21 Oct 2021 00:39:42 +0000 (UTC)
Received: from T590 (ovpn-8-19.pek2.redhat.com [10.72.8.19])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2231319D9B;
        Thu, 21 Oct 2021 00:39:10 +0000 (UTC)
Date:   Thu, 21 Oct 2021 08:39:05 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, tj@kernel.org,
        gregkh@linuxfoundation.org, akpm@linux-foundation.org,
        minchan@kernel.org, jeyu@kernel.org, shuah@kernel.org,
        bvanassche@acm.org, dan.j.williams@intel.com, joe@perches.com,
        tglx@linutronix.de, keescook@chromium.org, rostedt@goodmis.org,
        linux-spdx@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com
Subject: Re: [PATCH v8 11/12] zram: fix crashes with cpu hotplug multistate
Message-ID: <YXC2qcx/RlLwjrKx@T590>
References: <YWk9e957Hb+I7HvR@T590>
 <YWm68xUnAofop3PZ@bombadil.infradead.org>
 <YWq3Z++uoJ/kcp+3@T590>
 <YW3LuzaPhW96jSBK@bombadil.infradead.org>
 <YW4uwep3BCe9Vxq8@T590>
 <YW7kFXlzRrvwzARP@bombadil.infradead.org>
 <YW7ygbLAwm2/LZFl@T590>
 <YW8eSq2B+5FtOLZb@bombadil.infradead.org>
 <YW9tqPunx5bssxIz@T590>
 <YXA6NMhwoiIMeHji@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YXA6NMhwoiIMeHji@bombadil.infradead.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 20, 2021 at 08:48:04AM -0700, Luis Chamberlain wrote:
> On Wed, Oct 20, 2021 at 09:15:20AM +0800, Ming Lei wrote:
> > On Tue, Oct 19, 2021 at 12:36:42PM -0700, Luis Chamberlain wrote:
> > > On Wed, Oct 20, 2021 at 12:29:53AM +0800, Ming Lei wrote:
> > > > diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
> > > > index d0cae7a42f4d..a14ba3d350ea 100644
> > > > --- a/drivers/block/zram/zram_drv.c
> > > > +++ b/drivers/block/zram/zram_drv.c
> > > > @@ -1704,12 +1704,12 @@ static void zram_reset_device(struct zram *zram)
> > > >  	set_capacity_and_notify(zram->disk, 0);
> > > >  	part_stat_set_all(zram->disk->part0, 0);
> > > >  
> > > > -	up_write(&zram->init_lock);
> > > >  	/* I/O operation under all of CPU are done so let's free */
> > > >  	zram_meta_free(zram, disksize);
> > > >  	memset(&zram->stats, 0, sizeof(zram->stats));
> > > >  	zcomp_destroy(comp);
> > > >  	reset_bdev(zram);
> > > > +	up_write(&zram->init_lock);
> > > >  }
> > > >  
> > > >  static ssize_t disksize_store(struct device *dev,
> > > 
> > > With this, it still ends up in a state where we loop and can't get out of:
> > > 
> > > zram: Can't change algorithm for initialized device
> > 
> > Again, you are running two zram02.sh[1] on /dev/zram0, that isn't unexpected
> 
> You mean that it is not expected? If so then yes, of course.

My meaning is clear: it is not unexpected, so it is expected.

> 
> > behavior. Here the difference is just timing.
> 
> Right, but that is what helped reproduce a difficutl to re-produce customer
> bug. Once you find an easy way to reproduce a reported issue you stick
> with it and try to make the situation worse to ensure no more bugs are
> present.
> 
> > Also you did not answer my question about your test expected result when
> > running the following script from two terminal concurrently:
> > 
> > 	while true; do
> > 		PATH=$PATH:$PWD:$PWD/../../../lib/ ./zram02.sh;
> > 	done
> 
> If you run this, you should see no failures.

OK, not see any failure when running single zram02.sh after applying my
patch V2.

> 
> Once you start a second script that one should cause odd issues on both
> sides but never crash or stall the module.

crash can't be observed with my patch V2, what do you mean 'stall'
the module? Is that 'zram' can't be unloaded after the test is
terminated via multiple 'ctrl-c'?

> 
> A second series of tests is hitting CTRL-C on either randonly and
> restarting testing once again randomly.

ltp/zram02.sh has cleanup handler via trap to clean everything(swapoff/umount/reset/
rmmod), ctrl-c will terminate current forground task and cause shell to run the
cleanup handler first, but further 'ctrl-c' will terminate the cleanup handler,
then the cleanup won't be done completely, such as zram disk is left as swap
device and zram can't be unloaded. The idea can be observed via the following
script:

	#!/bin/bash
	trap 'echo "enter trap"; sleep 20; echo "exit trap";' INT
	sleep 30

After the above script is run foreground, when 1st ctrl-c is pressed, 'sleep 30'
is terminated, then the trap command is run, so you can see "enter trap"
dumped. Then if you pressed 2nd ctrl-c, 'sleep 20' is terminated immediately.
So 'swapoff' from zram02.sh's trap function can be terminated in this way.

zram disk being left as swap disk can be observed with your patch too
after terminating via multiple ctrl-c which has to be done this way because
the test is dead loop.

So it is hard to cleanup everything completely after multiple 'CTRL-C' is
involved, and it should be impossible. It needs violent multiple ctrl-c to
terminate the dealoop test.

So it isn't reasonable to expect that zram can be always unloaded successfully
after the test script is terminated via multiple ctrl-c.

But zram can be unloaded after running swapoff manually, from driver
viewpoint, nothing is wrong.

> 
> Again, neither should crash the kernel or stall the module.
> 
> In the end of these tests you should be able to run the script alone
> just once and not see issues.


Thanks,
Ming

