Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4824E2F1E43
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Jan 2021 19:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbhAKSv5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Jan 2021 13:51:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbhAKSv5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Jan 2021 13:51:57 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9123C061786;
        Mon, 11 Jan 2021 10:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QAL+ZD/8n4kz4BQqPvgQ+g9eI1B/tW2s2NBOJt50tpA=; b=YDa2PzLwdmllsLO3i51RXg8A0D
        XVtts9amjDsQ37djBoBr6W7Uslhh6Kw/+gDgxGTyBj60ije1eQookOHwWU1CItDtFsWkUKG6jwJDq
        zDRCc401pQDopQKDnGasVCdsW2DSF+/seg+84zWsBm5KiDe4asQBu0kblg3hu5SkWwG81RqQxSdMP
        /evVMtg5SfehRAKSAo/d0rGiAxXyaiCpatLd75XuTKlpRIwNRU/JWU68GOFwxtPLtuHgQfrN/SrTg
        3SVzsBbmUrwXVZHA1lFT0vl8L5R9kHbKSRmpEBSxRY+DX0O5Hk78ty7twF+etZuUbBEFxAeRLCMZ1
        FUMVh2pA==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1kz2HX-003etV-Ns; Mon, 11 Jan 2021 18:51:12 +0000
Date:   Mon, 11 Jan 2021 18:51:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] char_dev: replace cdev_map with an xarray
Message-ID: <20210111185111.GI35215@casper.infradead.org>
References: <20210111170513.1526780-1-hch@lst.de>
 <20210111173500.GG35215@casper.infradead.org>
 <X/yUzVu04TyVuU/f@kroah.com>
 <20210111182029.GH35215@casper.infradead.org>
 <X/yZ6wtNYJEniwC0@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/yZ6wtNYJEniwC0@kroah.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 11, 2021 at 07:33:15PM +0100, Greg KH wrote:
> On Mon, Jan 11, 2021 at 06:20:29PM +0000, Matthew Wilcox wrote:
> > > efficient in what way?  Space or faster lookup?
> > 
> > Both, but primarily space.
> > 
> > The radix tree underlying the xarray allows N consecutive entries with
> > the same value to be represented as a single entry; if there are at
> > least 64 entries then we get to skip an entire level of the tree (saving
> > 1/7 of a page).  Of course, we'd need to go from the 'head' pointer to
> > the correct pointer, something like p += rdev - p->rdev.
> 
> How much "space" are you talking about here?

576 bytes -- 1/7 of a page.

> A "normal" machine has about 100-200 char devices.  Servers, maybe more,
> but probably not.
> 
> The kobject being used previously wasn't really "small" at all, so odds
> are any conversion to not use it like this will be better overall.

Yes.

> > > THis shouldn't be on a "fast" lookup path, so I doubt that's worth
> > > optimizing for.  Space, maybe, for systems with thousands of scsi
> > > devices, but usually they just stick to the block device, not a char
> > > device from what I remember.
> > 
> > /dev/sgX is a chardev?
> 
> I sure hope no one is using /dev/sgX for tens of thousands of block
> device accesses, if so, they have bigger problems than this :)

There is one sgX char dev for every /dev/sdN, so anyone with a thousand
SCSI devices also has a thousand char devices.  On the other hand,
they're added one at a time, so there is no chance to optimise here:

        cdev = cdev_alloc();
...
        error = cdev_add(cdev, MKDEV(SCSI_GENERIC_MAJOR, sdp->index), 1);

