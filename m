Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79F182F2CBD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 11:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406130AbhALKZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 05:25:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:49658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406127AbhALKZG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 05:25:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F244206F1;
        Tue, 12 Jan 2021 10:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610447066;
        bh=1E28wDR2IrHwj2FKBuLMUQ5MdrzfH/G6Qx+RcS+9+ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qE2TZlNfKpc8mW5MUhOpsTN0teg5LmxABlWh8601A+HxdM5LnG9btIRiHlkHz9Nab
         mXLZU0l9P3eqI6kqzJzMQCthVbURxoxlomEkCGxhi/8/vnyElCsZOjOmJf60LtVCLW
         e9OMal5W5+82kzNZ4H8beF3goD0v3721OZDJDS1A=
Date:   Tue, 12 Jan 2021 11:25:35 +0100
From:   'Greg KH' <gregkh@linuxfoundation.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <X/15H16IGvlDoeyQ@kroah.com>
References: <20210111170513.1526780-1-hch@lst.de>
 <20210111205818.GJ35215@casper.infradead.org>
 <X/1tXpCfzMrTUhDQ@kroah.com>
 <4e46c186b6a4493992d3a5cc15fb3bf3@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e46c186b6a4493992d3a5cc15fb3bf3@AcuMS.aculab.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 12, 2021 at 10:00:25AM +0000, David Laight wrote:
> From: Greg KH
> > Sent: 12 January 2021 09:35
> > 
> > On Mon, Jan 11, 2021 at 08:58:18PM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> > > > @@ -486,14 +491,22 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
> > > >  	if (WARN_ON(dev == WHITEOUT_DEV))
> > > >  		return -EBUSY;
> > > >
> > > > -	error = kobj_map(cdev_map, dev, count, NULL,
> > > > -			 exact_match, exact_lock, p);
> > > > -	if (error)
> > > > -		return error;
> > > > +	mutex_lock(&chrdevs_lock);
> > > > +	for (i = 0; i < count; i++) {
> > > > +		error = xa_insert(&cdev_map, dev + i, p, GFP_KERNEL);
> > > > +		if (error)
> > > > +			goto out_unwind;
> > > > +	}
> > > > +	mutex_unlock(&chrdevs_lock);
> > >
> > > Looking at some of the users ...
> > >
> > > #define BSG_MAX_DEVS            32768
> > > ...
> > >         ret = cdev_add(&bsg_cdev, MKDEV(bsg_major, 0), BSG_MAX_DEVS);
> > >
> > > So this is going to allocate 32768 entries; at 8 bytes each, that's 256kB.
> > > With XArray overhead, it works out to 73 pages or 292kB.  While I don't
> > > have bsg loaded on my laptop, I imagine a lot of machines do.
> > >
> > > drivers/net/tap.c:#define TAP_NUM_DEVS (1U << MINORBITS)
> > > include/linux/kdev_t.h:#define MINORBITS        20
> > > drivers/net/tap.c:      err = cdev_add(tap_cdev, *tap_major, TAP_NUM_DEVS);
> > >
> > > That's going to be even worse -- 8MB plus the overhead to be closer to 9MB.
> > >
> > > I think we do need to implement the 'store a range' option ;-(
> > 
> > Looks like it will be needed here.
> > 
> > Wow that's a lot of tap devices allocated all at once, odd...
> 
> Aren't there two distinct use cases that probably need treating
> separately?
> 
> 1) A driver that uses it's own major (private) major number.
> 2) Drivers that share a major number (eg serial ports).
> 
> In the first case you just want all minors to come to your driver.
> In the second case different (ranges of) minors need to go to
> different drivers.
> 
> Until the major number is actually shared only the upper limit
> is an any way relevant.

Patches gladly reviewed.

thanks,

greg k-h
