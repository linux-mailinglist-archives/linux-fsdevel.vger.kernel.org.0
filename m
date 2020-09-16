Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E60026CA2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgIPTtl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Sep 2020 15:49:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:42810 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgIPTsN (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Sep 2020 15:48:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7B895AE92;
        Wed, 16 Sep 2020 19:48:25 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id C991DDA7C7; Wed, 16 Sep 2020 21:46:57 +0200 (CEST)
Date:   Wed, 16 Sep 2020 21:46:57 +0200
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v7 00/39] btrfs: zoned block device support
Message-ID: <20200916194657.GQ1791@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, Hannes Reinecke <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <20200911123259.3782926-1-naohiro.aota@wdc.com>
 <20200915080927.GF1791@twin.jikos.cz>
 <SN4PR0401MB359839054A125BF64641B4E89B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB359839054A125BF64641B4E89B210@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 16, 2020 at 05:42:50PM +0000, Johannes Thumshirn wrote:
> On 15/09/2020 10:25, David Sterba wrote:
> > On Fri, Sep 11, 2020 at 09:32:20PM +0900, Naohiro Aota wrote:
> >> Changelog
> >> v6:
> >>  - Use bitmap helpers (Johannes)
> >>  - Code cleanup (Johannes)
> >>  - Rebased on kdave/for-5.5
> >>  - Enable the tree-log feature.
> >>  - Treat conventional zones as sequential zones, so we can now allow
> >>    mixed allocation of conventional zone and sequential write required
> >>    zone to construct a block group.
> >>  - Implement log-structured superblock
> >>    - No need for one conventional zone at the beginning of a device.
> >>  - Fix deadlock of direct IO writing
> >>  - Fix building with !CONFIG_BLK_DEV_ZONED (Johannes)
> >>  - Fix leak of zone_info (Johannes)
> > 
> > I did a quick check to see if the patchset passes the default VM tests
> > and there's use after free short after the fstests start. No zoned
> > devices or such. I had to fix some conflicts when rebasing on misc-next
> > but I tried to base it on the last iomap-dio patch ("btrfs: switch to
> > iomap for direct IO"), same result so it's something in the zoned
> > patches.
> > 
> > The reported pointer 0x6b6b6b6b6d1918eb contains the use-after-free
> > poison (0x6b) (CONFIG_PAGE_POISONING=y).
> > 
> > MKFS_OPTIONS  -- -f -K --csum xxhash /dev/vdb
> > MOUNT_OPTIONS -- -o discard /dev/vdb /tmp/scratch
> 
> Hi David,
> 
> Can you check if this on top of the series fixes the issue? According
> to Keith we can't call bio_iovec() from endio() as the iterator is already
> advanced (see req_bio_endio()).

It booted and is past the point it crashed before.
