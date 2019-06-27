Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD058546
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 17:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbfF0PKS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 11:10:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:41226 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726431AbfF0PKS (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:10:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E8A79AC37;
        Thu, 27 Jun 2019 15:10:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 32C2ADA811; Thu, 27 Jun 2019 17:11:00 +0200 (CEST)
Date:   Thu, 27 Jun 2019 17:11:00 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH 02/19] btrfs: Get zone information of zoned block devices
Message-ID: <20190627151100.GB20977@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Qu Wenruo <wqu@suse.com>,
        Nikolay Borisov <nborisov@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Matias =?iso-8859-1?Q?Bj=F8rling?= <mb@lightnvm.io>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Bart Van Assche <bvanassche@acm.org>
References: <20190607131025.31996-1-naohiro.aota@wdc.com>
 <20190607131025.31996-3-naohiro.aota@wdc.com>
 <20190617185708.GH19057@twin.jikos.cz>
 <SN6PR04MB5231EA9395FB2C4E973BD32F8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB5231EA9395FB2C4E973BD32F8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 06:42:09AM +0000, Naohiro Aota wrote:
> >> +	device->seq_zones = kcalloc(BITS_TO_LONGS(device->nr_zones),
> >> +				    sizeof(*device->seq_zones), GFP_KERNEL);
> > 
> > What's the expected range for the allocation size? There's one bit per
> > zone, so one 4KiB page can hold up to 32768 zones, with 1GiB it's 32TiB
> > of space on the drive. Ok that seems safe for now.
> 
> Typically, zone size is 256MB (as default value in tcmu-runner). On such device,
> we need one 4KB page per 8TB disk space. Still it's quite safe.

Ok, and for drives up to 16T the allocation is 8kb that the allocator
usually is able to find.

> >> +	u8  zone_size_shift;
> > 
> > So the zone_size is always power of two? I may be missing something, but
> > I wonder if the calculations based on shifts are safe.
> 
> The kernel ZBD support have a restriction that
> "The zone size must also be equal to a power of 2 number of logical blocks."
> http://zonedstorage.io/introduction/linux-support/#zbd-support-restrictions
> 
> So, the zone_size is guaranteed to be power of two.

Ok. I don't remember if there are assertions, but would like to see them
in the filesystem code indpendently anyway as the mount-time sanity
checks.
