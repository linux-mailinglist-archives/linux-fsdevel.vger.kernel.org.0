Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 248902F1DDB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389348AbhAKSVO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730240AbhAKSVO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:21:14 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09B1C061786;
        Mon, 11 Jan 2021 10:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jt+zTaSzHgoXv74FihambALys8BL18QGIjpnja/5Ee8=; b=CTiDW6Md6Yj0vdiWQK5L1rL/lt
        +jdS3x5pyLb6p5tCGsAjAdr4gpliYx2tU7eTqF7u8/x3n0crT3nc8sh7zjITbW3ja7hgd64A0yttp
        wfB90pVnk6lKzHUV0IgWcuB+P5uip+kXnMXhNS9vyu8MupR/nF7vUP+M0y8+Og9s9qf+QS7zp7khh
        gCtjzkEyMZSrEx6jFE4axyH12qx/cUCO0DyJ/2Ea2KCquO8SGIpPZepvWLX6RkK4M6pb3jXLs/bvi
        mRzLOiWXH0QdhU+JYY8WU0e1qQb3dUEr4t5S//Q9a984Y602WyUiryNq7+ZwfJwIoJVgnaq9ZDPsv
        5DJOrPMA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kz1np-003cc6-0b; Mon, 11 Jan 2021 18:20:29 +0000
Date:   Mon, 11 Jan 2021 18:20:29 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <20210111182029.GH35215@casper.infradead.org>
References: <20210111170513.1526780-1-hch@lst.de>
 <20210111173500.GG35215@casper.infradead.org>
 <X/yUzVu04TyVuU/f@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/yUzVu04TyVuU/f@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:11:25PM +0100, Greg KH wrote:
> On Mon, Jan 11, 2021 at 05:35:00PM +0000, Matthew Wilcox wrote:
> > On Mon, Jan 11, 2021 at 06:05:13PM +0100, Christoph Hellwig wrote:
> > > None of the complicated overlapping regions bits of the kobj_map are
> > > required for the character device lookup, so just a trivial xarray
> > > instead.
> > 
> > Thanks for doing this.  We could make it more efficient for chardevs
> > that occupy 64 or more consecutive/aligned devices -- is it worth doing?
> 
> efficient in what way?  Space or faster lookup?

Both, but primarily space.

The radix tree underlying the xarray allows N consecutive entries with
the same value to be represented as a single entry; if there are at
least 64 entries then we get to skip an entire level of the tree (saving
1/7 of a page).  Of course, we'd need to go from the 'head' pointer to
the correct pointer, something like p += rdev - p->rdev.

> THis shouldn't be on a "fast" lookup path, so I doubt that's worth
> optimizing for.  Space, maybe, for systems with thousands of scsi
> devices, but usually they just stick to the block device, not a char
> device from what I remember.

/dev/sgX is a chardev?
