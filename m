Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9852F1C8B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 18:37:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389681AbhAKRfo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 12:35:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389677AbhAKRfo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 12:35:44 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A3D4C061786;
        Mon, 11 Jan 2021 09:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LTnXz3vAAnA7BIuUcelR2pUzL4tVATVL7h4LaGI+qsE=; b=IMdyMZO8RWoxtgi1mW6La0HGxK
        a1lxZexgejy45RfpYZxp1ubOj3J5DiHs9HC0oekGxTP9caSgyH9Oyt8yZ9/cweboP+ysyxswbACd8
        RNG2R4EM2fZExyVOTr/KGFt+U5KIaHXi2bGCFNAYvB2551plLILmaI+SZZh3P27Nx99eAIkXZMtBc
        6mF3uNgI5Lv0dCrKXgr46JdMJfStTXCfjtheAj/0hKPYdw1vrgpzX+KGSGNVv4VidFXjdW9nS7TDn
        3kUcjNhlEgzO13g8HM+FRzsr8/P7nB1nCT/9AazYzueqhpWzvdkK2LGnPLBZ+hZfMVQV8hoUaoq/J
        5+Imy9Hg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kz15o-003ZDY-4m; Mon, 11 Jan 2021 17:35:00 +0000
Date:   Mon, 11 Jan 2021 17:35:00 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <20210111173500.GG35215@casper.infradead.org>
References: <20210111170513.1526780-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111170513.1526780-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> None of the complicated overlapping regions bits of the kobj_map are
> required for the character device lookup, so just a trivial xarray
> instead.

Thanks for doing this.  We could make it more efficient for chardevs
that occupy 64 or more consecutive/aligned devices -- is it worth doing?

> +static struct cdev *cdev_lookup(dev_t dev)
> +{
> +	struct cdev *cdev;
> +
> +	mutex_lock(&chrdevs_lock);
> +	cdev = xa_load(&cdev_map, dev);
> +	if (!cdev) {
> +		mutex_unlock(&chrdevs_lock);
> +		if (request_module("char-major-%d-%d",
> +				   MAJOR(dev), MINOR(dev)) > 0)
> +			/* Make old-style 2.4 aliases work */
> +			request_module("char-major-%d", MAJOR(dev));
> +		mutex_lock(&chrdevs_lock);
> +
> +		cdev = xa_load(&cdev_map, dev);
> +	}
> +	if (cdev && !cdev_get(cdev))
> +		cdev = NULL;
> +	mutex_unlock(&chrdevs_lock);
> +	return cdev;

What does the mutex protect here?  Is it cdev being freed?

> @@ -593,11 +601,16 @@ static void cdev_unmap(dev_t dev, unsigned count)
>   */
>  void cdev_del(struct cdev *p)
>  {
> -	cdev_unmap(p->dev, p->count);
> +	int i;
> +
> +	mutex_lock(&chrdevs_lock);
> +	for (i = 0; i < p->count; i++)
> +		xa_erase(&cdev_map, p->dev + i);
> +	mutex_unlock(&chrdevs_lock);

I don't understand what it's protecting here.  It's clearly not cdev_get
as that could happen before we acquire the mutex.  This also suggests
I should add an xa_erase_range() to the API.

But there's nothing wrong here, just some places that maybe could be
better, so:

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
