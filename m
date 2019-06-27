Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71849585E4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2019 17:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbfF0PeT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jun 2019 11:34:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:48262 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726587AbfF0PeT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jun 2019 11:34:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C1667ABC4;
        Thu, 27 Jun 2019 15:34:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 7744ADA811; Thu, 27 Jun 2019 17:35:02 +0200 (CEST)
Date:   Thu, 27 Jun 2019 17:35:02 +0200
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
Subject: Re: [PATCH 09/19] btrfs: limit super block locations in HMZONED mode
Message-ID: <20190627153502.GD20977@twin.jikos.cz>
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
 <20190607131025.31996-10-naohiro.aota@wdc.com>
 <20190617225356.GJ19057@twin.jikos.cz>
 <SN6PR04MB523133E2B4DA6705F79A48FF8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR04MB523133E2B4DA6705F79A48FF8CEA0@SN6PR04MB5231.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 18, 2019 at 09:01:35AM +0000, Naohiro Aota wrote:
> On 2019/06/18 7:53, David Sterba wrote:
> > On Fri, Jun 07, 2019 at 10:10:15PM +0900, Naohiro Aota wrote:
> >> When in HMZONED mode, make sure that device super blocks are located in
> >> randomly writable zones of zoned block devices. That is, do not write super
> >> blocks in sequential write required zones of host-managed zoned block
> >> devices as update would not be possible.
> > 
> > This could be explained in more detail. My understanding is that the 1st
> > and 2nd copy superblocks is skipped at write time but the zone
> > containing the superblocks is not excluded from allocations. Ie. regular
> > data can appear in place where the superblocks would exist on
> > non-hmzoned filesystem. Is that correct?
> 
> Correct. You can see regular data stored at usually SB location on HMZONED fs.
> 
> > The other option is to completely exclude the zone that contains the
> > superblock copies.
> > 
> > primary sb			 64K
> > 1st copy			 64M
> > 2nd copy			256G
> > 
> > Depends on the drives, but I think the size of the random write zone
> > will very often cover primary and 1st copy. So there's at least some
> > backup copy.
> > 
> > The 2nd copy will be in the sequential-only zone, so the whole zone
> > needs to be excluded in exclude_super_stripes. But it's not, so this
> > means data can go there.  I think the zone should be left empty.
> > 
> 
> I see. That's more safe for the older kernel/userland, right? By keeping that zone empty,
> we can avoid old ones to mis-interpret data to be SB.

That's not only for older kernels, the superblock locations are known
and the contents should not depend on the type of device on which it was
created. This can be considered part of the on-disk format.
