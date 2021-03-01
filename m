Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21861327F78
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Mar 2021 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235737AbhCAN2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 1 Mar 2021 08:28:04 -0500
Received: from mx2.suse.de ([195.135.220.15]:35498 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235717AbhCAN16 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 1 Mar 2021 08:27:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 59310AC24;
        Mon,  1 Mar 2021 13:27:16 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 99542DA7AF; Mon,  1 Mar 2021 14:25:21 +0100 (CET)
Date:   Mon, 1 Mar 2021 14:25:21 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/3] btrfs: zoned: move superblock logging zone location
Message-ID: <20210301132521.GU7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
References: <cover.1614331998.git.naohiro.aota@wdc.com>
 <7d02b9117f15101e70d2cd37da05ca93c2fd624d.1614331998.git.naohiro.aota@wdc.com>
 <20210226191130.GR7604@twin.jikos.cz>
 <20210301045548.zirmwk56almxgint@naota-xeon>
 <BL0PR04MB651469B0D0AE850CF0E069ADE79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR04MB651469B0D0AE850CF0E069ADE79A9@BL0PR04MB6514.namprd04.prod.outlook.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 01, 2021 at 05:17:52AM +0000, Damien Le Moal wrote:
> On 2021/03/01 14:02, Naohiro Aota wrote:
> > On Fri, Feb 26, 2021 at 08:11:30PM +0100, David Sterba wrote:
> >> On Fri, Feb 26, 2021 at 06:34:36PM +0900, Naohiro Aota wrote:
> >>> This commit moves the location of superblock logging zones basing on the
> >>> static address instead of the static zone number.
> >>>
> >>> The following zones are reserved as the circular buffer on zoned btrfs.
> >>>   - The primary superblock: zone at LBA 0 and the next zone
> >>>   - The first copy: zone at LBA 16G and the next zone
> >>>   - The second copy: zone at LBA 256G and the next zone
> >>
> >> This contains all the important information but somehow feels too short
> >> given how many mails we've exchanged and all the reasoning why we do
> >> that
> > 
> > Yep, sure. I'll expand the description and repost.
> > 
> >>>
> >>> We disallow zone size larger than 8GB not to overlap the superblock log
> >>> zones.
> >>>
> >>> Since the superblock zones overlap, we disallow zone size larger than 8GB.
> >>
> >> or why we chose 8G to be the reasonable upper limit for the zone size.
> >>
> >>> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>
> >>> ---
> >>>  fs/btrfs/zoned.c | 21 +++++++++++++++------
> >>>  1 file changed, 15 insertions(+), 6 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
> >>> index 9a5cf153da89..40cb99854844 100644
> >>> --- a/fs/btrfs/zoned.c
> >>> +++ b/fs/btrfs/zoned.c
> >>> @@ -112,10 +112,9 @@ static int sb_write_pointer(struct block_device *bdev, struct blk_zone *zones,
> >>>  
> >>>  /*
> >>>   * The following zones are reserved as the circular buffer on ZONED btrfs.
> >>> - *  - The primary superblock: zones 0 and 1
> >>> - *  - The first copy: zones 16 and 17
> >>> - *  - The second copy: zones 1024 or zone at 256GB which is minimum, and
> >>> - *                     the following one
> >>> + *  - The primary superblock: zone at LBA 0 and the next zone
> >>> + *  - The first copy: zone at LBA 16G and the next zone
> >>> + *  - The second copy: zone at LBA 256G and the next zone
> >>>   */
> >>>  static inline u32 sb_zone_number(int shift, int mirror)
> >>>  {
> >>> @@ -123,8 +122,8 @@ static inline u32 sb_zone_number(int shift, int mirror)
> >>>  
> >>>  	switch (mirror) {
> >>>  	case 0: return 0;
> >>> -	case 1: return 16;
> >>> -	case 2: return min_t(u64, btrfs_sb_offset(mirror) >> shift, 1024);
> >>> +	case 1: return 1 << (const_ilog2(SZ_16G) - shift);
> >>> +	case 2: return 1 << (const_ilog2(SZ_1G) + 8 - shift);
> >>
> >> This ilog(SZ_1G) + 8 is confusing, it should have been 256G for clarity,
> >> as it's a constant it'll get expanded at compile time.
> > 
> > I'd like to use SZ_256G here, but linux/sizes.h does not define
> > it. I'll define one for us and use it in the next version.
> 
> Or just use const_ilog2(256 * SZ_1G)... That is fairly easy to understand :)
> 
> I would even go further and add:
> 
> #define BTRFS_SB_FIRST_COPY_OFST		(16ULL * SZ_1G)
> #define BTRFS_SB_SECOND_COPY_OFST		(256ULL * SZ_1G)
> 
> To be clear about what the values represent.
> Then you can have:
> 
> +	case 1: return 1 << (const_ilog2(BTRFS_SB_FIRST_COPY_OFST) - shift);
> +	case 2: return 1 << (const_ilog2(BTRFS_SB_SECOND_COPY_OFST) - shift);

That's even better, so the magic constants are defined in a more visible
place. Maybe the shift can be also defined separately and then just used
here, like we have PAGE_SIZE/PAGE_SHIFT and such.
