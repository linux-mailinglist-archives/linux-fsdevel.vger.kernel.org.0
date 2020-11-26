Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C94D2C56C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 15:14:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390144AbgKZOND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 09:13:03 -0500
Received: from mx2.suse.de ([195.135.220.15]:37792 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390133AbgKZONB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 09:13:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CB3CFADB3;
        Thu, 26 Nov 2020 14:12:59 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2AFB5DA87E; Thu, 26 Nov 2020 15:11:30 +0100 (CET)
Date:   Thu, 26 Nov 2020 15:11:30 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "hare@suse.com" <hare@suse.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Message-ID: <20201126141129.GU6430@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "hare@suse.com" <hare@suse.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "josef@toxicpanda.com" <josef@toxicpanda.com>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <20201125214753.GP6430@twin.jikos.cz>
 <b96d23ea0f08ec74a7535b4feb17a000ab935abf.camel@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b96d23ea0f08ec74a7535b4feb17a000ab935abf.camel@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 25, 2020 at 11:50:39PM +0000, Damien Le Moal wrote:
> Hi David,
> 
> On Wed, 2020-11-25 at 22:47 +0100, David Sterba wrote:
> > On Tue, Nov 10, 2020 at 08:26:07PM +0900, Naohiro Aota wrote:
> > > +int btrfs_get_dev_zone_info(struct btrfs_device *device)
> > > +{
> > > +	struct btrfs_zoned_device_info *zone_info = NULL;
> > > +	struct block_device *bdev = device->bdev;
> > > +	sector_t nr_sectors = bdev->bd_part->nr_sects;
> > > +	sector_t sector = 0;
> > 
> > I'd rather replace the sector_t types with u64. The type is unsigned
> > long and does not have the same width on 32/64 bit. The typecasts must
> > be used and if not, bugs happen (and happened).
> 
> Since kernel 5.2, sector_t is unconditionally defined as u64 in linux/type.h:
> 
> typedef u64 sector_t;
> 
> CONFIG_LBDAF does not exist anymore.

That's great, I was not aware of that.

> I am not against using u64 at all, but using sector_t makes it clear what the
> unit is for the values at hand.

Yeah agreed, I'll switch it back.
