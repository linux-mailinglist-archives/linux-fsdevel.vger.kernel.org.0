Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 399502F1DA9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390180AbhAKSML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:12:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:37214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389269AbhAKSMK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:12:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5FF102250E;
        Mon, 11 Jan 2021 18:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1610388690;
        bh=cBq1y0iMkVTuLGtG1DMGGNgPvj5YM9W4o39IMIcR/EM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxqXv2rUHSZzxBPXqzFkyl5mxoaAoc95Zt4psMjmeQo2CVASu06pc9ol5BQ3vvgGd
         uZeYPFWpeQr6hEt/aV+Ch9VuNfNKHdab3BHBciV142h7zVWwQygpcAHvOI2vR9sdkx
         RoQBiqRpwhIL3nOxhiTVDGU0+zKdm3KU7jABUgZo=
Date:   Mon, 11 Jan 2021 19:11:25 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <X/yUzVu04TyVuU/f@kroah.com>
References: <20210111170513.1526780-1-hch@lst.de>
 <20210111173500.GG35215@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210111173500.GG35215@casper.infradead.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 05:35:00PM +0000, Matthew Wilcox wrote:
> On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> > None of the complicated overlapping regions bits of the kobj_map are
> > required for the character device lookup, so just a trivial xarray
> > instead.
> 
> Thanks for doing this.  We could make it more efficient for chardevs
> that occupy 64 or more consecutive/aligned devices -- is it worth doing?

efficient in what way?  Space or faster lookup?

THis shouldn't be on a "fast" lookup path, so I doubt that's worth
optimizing for.  Space, maybe, for systems with thousands of scsi
devices, but usually they just stick to the block device, not a char
device from what I remember.

thanks,

greg k-h
