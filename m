Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750F72F2B67
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Jan 2021 10:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391322AbhALJe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 04:34:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731123AbhALJe6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:34:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2FE2222D58;
        Tue, 12 Jan 2021 09:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610444057;
        bh=hkzbzs0K+f9nm5q4R4p5N9bYRD7QnTBmMG5Q4kjH+Vg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t8u/x5dqKIj2udvVn4cUROXMiNEWhp/ixI854A8coQTzCZSUSkAaCbYn3POtWuXV2
         99/tqddpre/RlZfzGlyt8x9h7Vi2j5a4Kvs4zapFl55ZMlMfpjB6z+iRpjbgYTWrUA
         3kwr4M+mdurQpR15CGCEUk8C+dF9atsNeeV4+jog=
Date:   Tue, 12 Jan 2021 10:35:26 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <X/1tXpCfzMrTUhDQ@kroah.com>
References: <20210111170513.1526780-1-hch@lst.de>
 <20210111205818.GJ35215@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111205818.GJ35215@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 08:58:18PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> > @@ -486,14 +491,22 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
> >  	if (WARN_ON(dev == WHITEOUT_DEV))
> >  		return -EBUSY;
> >  
> > -	error = kobj_map(cdev_map, dev, count, NULL,
> > -			 exact_match, exact_lock, p);
> > -	if (error)
> > -		return error;
> > +	mutex_lock(&chrdevs_lock);
> > +	for (i = 0; i < count; i++) {
> > +		error = xa_insert(&cdev_map, dev + i, p, GFP_KERNEL);
> > +		if (error)
> > +			goto out_unwind;
> > +	}
> > +	mutex_unlock(&chrdevs_lock);
> 
> Looking at some of the users ...
> 
> #define BSG_MAX_DEVS            32768
> ...
>         ret = cdev_add(&bsg_cdev, MKDEV(bsg_major, 0), BSG_MAX_DEVS);
> 
> So this is going to allocate 32768 entries; at 8 bytes each, that's 256kB.
> With XArray overhead, it works out to 73 pages or 292kB.  While I don't
> have bsg loaded on my laptop, I imagine a lot of machines do.
> 
> drivers/net/tap.c:#define TAP_NUM_DEVS (1U << MINORBITS)
> include/linux/kdev_t.h:#define MINORBITS        20
> drivers/net/tap.c:      err = cdev_add(tap_cdev, *tap_major, TAP_NUM_DEVS);
> 
> That's going to be even worse -- 8MB plus the overhead to be closer to 9MB.
> 
> I think we do need to implement the 'store a range' option ;-(

Looks like it will be needed here.

Wow that's a lot of tap devices allocated all at once, odd...

Note, we will get some additional savings when this goes in as I can
delete the kobject from the cdev (after cleaning up the misguided
drivers that tried to set it thinking it was used), which will help out
a lot for the individual structures being created, but not for these
ranges.

thanks,

greg k-h
