Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 666F045B432
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 07:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233357AbhKXGMs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 01:12:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbhKXGMs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 01:12:48 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5909FC061574;
        Tue, 23 Nov 2021 22:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VnSXQlcgEy2R2GmynHAo8lQX3oFv77K7HQ0kh31DPrU=; b=vn2+F00XttavJDV+X8eZkJBrYV
        bOfKsR8wlJu6dpWao1s8Sh6URlBi4ervS1jMWbAwvHLqq17DH3QFS+noeDGBiqIuzzlN4GfUjJId4
        ce3b/kZWP3YkuIc2sEeR1bkGCtdV6p87xKuttEqvTOTBXg5IaKIe7vben3eFVB2H2RA3V2Em3zGuG
        V3ZUTriFGZ7CcPshtKn8mtBMPsGgnxN4BjbTzaITxF9iF8LuhitY4xbT9hNnHZSWlR//fMh/3BXf7
        ZQLsmEGGxU+VsW4XG/hvtjcR3/enkJtdrQ/m6ZEqqKk9kaI9UtPEGa+tFT+KUI9jdZ62uCF2AOGHS
        XlWMwfSQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mplTL-003yvO-6b; Wed, 24 Nov 2021 06:09:35 +0000
Date:   Tue, 23 Nov 2021 22:09:35 -0800
From:   "hch@infradead.org" <hch@infradead.org>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     "hch@infradead.org" <hch@infradead.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Any bio_clone_slow() implementation which doesn't share
 bi_io_vec?
Message-ID: <YZ3XH2PWwrIl/XMy@infradead.org>
References: <5d8351f1-1b09-bff0-02f2-a417c1669607@gmx.com>
 <YZybvlheyLGAadFF@infradead.org>
 <79d38fc2-cd2f-2980-2c4e-408078ce6079@gmx.com>
 <YZyiuFxAeKE/WMrR@infradead.org>
 <cca20bcb-1674-f99d-d504-b7fc928e227a@gmx.com>
 <PH0PR04MB74169757F9CF740289B790C49B609@PH0PR04MB7416.namprd04.prod.outlook.com>
 <YZz6jAVXun8yC/6k@infradead.org>
 <133792e9-b89b-bc82-04fe-41202c3453a5@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133792e9-b89b-bc82-04fe-41202c3453a5@gmx.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 07:07:18AM +0800, Qu Wenruo wrote:
> In that case, the missing piece seems to be a way to convert a splitted
> plain bio into a REQ_OP_ZONE_APPEND bio.
> 
> Can this be done without slow bvec copying?

Yes.  I have a WIP stacking driver that converts writes to zone appends
and it does just that:

	sector_t orig_sector = bio->bi_iter.bi_sector;
	unsigned int bio_flags = bio->bi_opf & ~REQ_OP_MASK;

	...

	clone = bio_clone_fast(bio, GFP_NOIO, &bdev->write_bio_set);

	...

	clone->bi_opf = REQ_OP_ZONE_APPEND | REQ_NOMERGE | bio_flags;
	bio_set_dev(clone, dev->lower_bdev);
	clone->bi_iter.bi_sector = zone_sector;
	trace_block_bio_remap(clone, disk_devt(disk), orig_sector);

> 
> Thanks,
> Qu
---end quoted text---
