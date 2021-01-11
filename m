Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1EAF2F2141
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 22:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbhAKU7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 15:59:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbhAKU7M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 15:59:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 977CFC061794;
        Mon, 11 Jan 2021 12:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Cv7VbZ5smu3P4Ii21Ehn0+Vp636YonNPeqjeeY7v9Jw=; b=tnAv4qWaCc85VIMfUWbl4cZRjE
        lkskA4ziJMQruGVP3Hf8eCGWXc+uwGnSB8F1A/ddnjtWx8x5EGqkKCeyFM4lUE+qhXflJoypfMEJx
        wmc1GoyYz9rmVqtGbQhIw4UaG5IvlpHfJGobpLqkXqMUgeGc+Pe7ii9GJZdWMFHp7QzJOQpKjyP5t
        uMKCkXX7GsNhs0cUmj+ltn6Hx7Ewy92JvN+3OsOUrKzqWIY0xRKRF70SP59sfNEg4z5f9fY2oRhME
        Tv2+5j+s7nukDUg4oDQwulFRcy4Wizovzg1K2EXURY7M3yki7Arordu9itjqWIOS1tlhiPePGG+NK
        PsVIJ/Tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kz4GY-003r1a-Vv; Mon, 11 Jan 2021 20:58:23 +0000
Date:   Mon, 11 Jan 2021 20:58:18 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <20210111205818.GJ35215@casper.infradead.org>
References: <20210111170513.1526780-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111170513.1526780-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> @@ -486,14 +491,22 @@ int cdev_add(struct cdev *p, dev_t dev, unsigned count)
>  	if (WARN_ON(dev == WHITEOUT_DEV))
>  		return -EBUSY;
>  
> -	error = kobj_map(cdev_map, dev, count, NULL,
> -			 exact_match, exact_lock, p);
> -	if (error)
> -		return error;
> +	mutex_lock(&chrdevs_lock);
> +	for (i = 0; i < count; i++) {
> +		error = xa_insert(&cdev_map, dev + i, p, GFP_KERNEL);
> +		if (error)
> +			goto out_unwind;
> +	}
> +	mutex_unlock(&chrdevs_lock);

Looking at some of the users ...

#define BSG_MAX_DEVS            32768
...
        ret = cdev_add(&bsg_cdev, MKDEV(bsg_major, 0), BSG_MAX_DEVS);

So this is going to allocate 32768 entries; at 8 bytes each, that's 256kB.
With XArray overhead, it works out to 73 pages or 292kB.  While I don't
have bsg loaded on my laptop, I imagine a lot of machines do.

drivers/net/tap.c:#define TAP_NUM_DEVS (1U << MINORBITS)
include/linux/kdev_t.h:#define MINORBITS        20
drivers/net/tap.c:      err = cdev_add(tap_cdev, *tap_major, TAP_NUM_DEVS);

That's going to be even worse -- 8MB plus the overhead to be closer to 9MB.

I think we do need to implement the 'store a range' option ;-(
