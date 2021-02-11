Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87D0318F2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Feb 2021 16:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhBKPvC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Feb 2021 10:51:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:55730 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhBKPtD (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Feb 2021 10:49:03 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14EF3B083;
        Thu, 11 Feb 2021 15:48:22 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id ED3FEDA6E9; Thu, 11 Feb 2021 16:46:27 +0100 (CET)
Date:   Thu, 11 Feb 2021 16:46:27 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Message-ID: <20210211154627.GE1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
 <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211151901.GD1993@twin.jikos.cz>
 <SN4PR0401MB3598ADA963CA60A715DE5EDE9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN4PR0401MB3598ADA963CA60A715DE5EDE9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Feb 11, 2021 at 03:26:04PM +0000, Johannes Thumshirn wrote:
> On 11/02/2021 16:21, David Sterba wrote:
> > On Thu, Feb 11, 2021 at 09:58:09AM +0000, Johannes Thumshirn wrote:
> >> On 10/02/2021 21:02, David Sterba wrote:
> >>>> This series implements superblock log writing. It uses two zones as a
> >>>> circular buffer to write updated superblocks. Once the first zone is filled
> >>>> up, start writing into the second zone. The first zone will be reset once
> >>>> both zones are filled. We can determine the postion of the latest
> >>>> superblock by reading the write pointer information from a device.
> >>>
> >>> About that, in this patchset it's still leaving superblock at the fixed
> >>> zone number while we want it at a fixed location, spanning 2 zones
> >>> regardless of their size.
> >>
> >> We'll always need 2 zones or otherwise we won't be powercut safe.
> > 
> > Yes we do, that hasn't changed.
> 
> OK that I don't understand, with the log structured superblocks on a zoned
> filesystem, we're writing a new superblock until the 1st zone is filled.
> Then we advance to the second zone. As soon as we wrote a superblock to
> the second zone we can reset the first.
> If we only use one zone,

No, that can't work and nobody suggests that.

> we would need to write until it's end, reset and
> start writing again from the beginning. But if a powercut happens between
> reset and first write after the reset, we end up with no superblock.

What I'm saying and what we discussed on slack in December, we can't fix
the zone number for the 1st and 2nd copy of superblock like it is now in
sb_zone_number.

The primary superblock must be there for any reference and to actually
let the tools learn about the incompat bits.

The 1st copy is now fixed zone 16, which depends on the zone size. The
idea is to define the superblock offsets to start at given offsets,
where the ring buffer has the two consecutive zones, regardless of their
size.

primary:		   0
1st copy:		 16G
2nd copy:		256G

Due to the variability of the zones in future devices, we'll reserve a
space at the superblock interval, assuming the zone sizes can grow up to
several gigabytes. Current working number is 1G, with some safety margin
the reserved ranges would be (eg. for a 4G zone size):

primary:		0 up to 8G
1st copy:		16G up to 24G
2nd copy:		256G up to 262G

It is wasteful but we want to be future proof and expecting disk sizes
from tens of terabytes to a hundred terabytes, it's not significant
loss of space.

If the zone sizes can be expected higher than 4G, the 1st copy can be
defined at 64G, that would leave us some margin until somebody thinks
that 32G zones are a great idea.
