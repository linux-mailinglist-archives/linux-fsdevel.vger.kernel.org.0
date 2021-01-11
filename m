Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 261452F1E1A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:34:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390465AbhAKSeF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:34:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:40860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390460AbhAKSeE (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:34:04 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 462042222D;
        Mon, 11 Jan 2021 18:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610390003;
        bh=gB6im3tPJYXdjfwUieFSckqduRKKMBNiViI3k98M4go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eRweZXePRK4pU0YN1x7uea23ilDFKC+khTeK4a9uY/CAjg3mjxMlZ22ujzEvPiGF+
         6OC9GG9LdpU8gXJ0tT+PQxmPn+ewkIFimwa00/iBZv60SQFkFuL0n74X5qLd7+mlrD
         PRcjWATEelDaL7t09VcB4A3Jy00lGWdZfgngFE6w=
Date:   Mon, 11 Jan 2021 19:33:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <X/yZ6wtNYJEniwC0@kroah.com>
References: <20210111170513.1526780-1-hch@lst.de>
 <20210111173500.GG35215@casper.infradead.org>
 <X/yUzVu04TyVuU/f@kroah.com>
 <20210111182029.GH35215@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111182029.GH35215@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 06:20:29PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 11, 2021 at 07:11:25PM +0100, Greg KH wrote:
> > On Mon, Jan 11, 2021 at 05:35:00PM +0000, Matthew Wilcox wrote:
> > > On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> > > > None of the complicated overlapping regions bits of the kobj_map are
> > > > required for the character device lookup, so just a trivial xarray
> > > > instead.
> > > 
> > > Thanks for doing this.  We could make it more efficient for chardevs
> > > that occupy 64 or more consecutive/aligned devices -- is it worth doing?
> > 
> > efficient in what way?  Space or faster lookup?
> 
> Both, but primarily space.
> 
> The radix tree underlying the xarray allows N consecutive entries with
> the same value to be represented as a single entry; if there are at
> least 64 entries then we get to skip an entire level of the tree (saving
> 1/7 of a page).  Of course, we'd need to go from the 'head' pointer to
> the correct pointer, something like p += rdev - p->rdev.

How much "space" are you talking about here?

A "normal" machine has about 100-200 char devices.  Servers, maybe more,
but probably not.

The kobject being used previously wasn't really "small" at all, so odds
are any conversion to not use it like this will be better overall.

> > THis shouldn't be on a "fast" lookup path, so I doubt that's worth
> > optimizing for.  Space, maybe, for systems with thousands of scsi
> > devices, but usually they just stick to the block device, not a char
> > device from what I remember.
> 
> /dev/sgX is a chardev?

I sure hope no one is using /dev/sgX for tens of thousands of block
device accesses, if so, they have bigger problems than this :)

thanks,

greg k-h
