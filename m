Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD56A2B271C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Nov 2020 22:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgKMVgg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Nov 2020 16:36:36 -0500
Received: from mx2.suse.de ([195.135.220.15]:36586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgKMVgf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Nov 2020 16:36:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F01BABD9;
        Fri, 13 Nov 2020 21:36:33 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 0344ADA87A; Fri, 13 Nov 2020 22:34:49 +0100 (CET)
Date:   Fri, 13 Nov 2020 22:34:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Anand Jain <anand.jain@oracle.com>
Cc:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v10 04/41] btrfs: get zone information of zoned block
 devices
Message-ID: <20201113213449.GH6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Anand Jain <anand.jain@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Josef Bacik <josef@toxicpanda.com>
References: <cover.1605007036.git.naohiro.aota@wdc.com>
 <cf46f0aef5a214cae8bacb2be231efed5febef5f.1605007036.git.naohiro.aota@wdc.com>
 <6df7390f-6656-4795-ac54-a99fdaf67ac6@oracle.com>
 <SN4PR0401MB35981D84D03C4D54A3EF627F9BE70@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <BL0PR04MB6514AAB6133006372B04711DE7E70@BL0PR04MB6514.namprd04.prod.outlook.com>
 <4a796bcd-ebac-eff2-6085-346a102b5952@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a796bcd-ebac-eff2-6085-346a102b5952@oracle.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 12, 2020 at 05:44:11PM +0800, Anand Jain wrote:
> On 12/11/20 3:44 pm, Damien Le Moal wrote:
> > On 2020/11/12 16:35, Johannes Thumshirn wrote:
> >> On 12/11/2020 08:00, Anand Jain wrote:
> >>>> diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
> >>>> index 8840a4fa81eb..ed55014fd1bd 100644
> >>>> --- a/fs/btrfs/super.c
> >>>> +++ b/fs/btrfs/super.c
> >>>> @@ -2462,6 +2462,11 @@ static void __init btrfs_print_mod_info(void)
> >>>>    #endif
> >>>>    #ifdef CONFIG_BTRFS_FS_REF_VERIFY
> >>>>    			", ref-verify=on"
> >>>> +#endif
> >>>> +#ifdef CONFIG_BLK_DEV_ZONED
> >>>> +			", zoned=yes"
> >>>> +#else
> >>>> +			", zoned=no"
> >>>>    #endif
> >>> IMO, we don't need this, as most of the generic kernel will be compiled
> >>> with the CONFIG_BLK_DEV_ZONED defined.
> >>> For review purpose we may want to know if the mounted device
> >>> is a zoned device. So log of zone device and its type may be useful
> >>> when we have verified the zoned devices in the open_ctree().
> >>>
> >>
> >> David explicitly asked for this in [1] so we included it.
> >>
> >> [1] https://lore.kernel.org/linux-btrfs/20201013155301.GE6756@twin.jikos.cz
> >>
> > 
> > And as of now, not all generic kernels are compiled with CONFIG_BLK_DEV_ZONED.
> > E.g. RHEL and CentOS. That may change in the future, but it should not be
> > assumed that CONFIG_BLK_DEV_ZONED is always enabled.
> 
> Ok. My comment was from the long term perspective. I am fine if you want 
> to keep it.

The idea is to let the module announce which conditionally built
features are there according to fs/btrfs/Makefile and Kconfig. Besides
ACLs that should be always on and self-tests that run right after module
load, all other are there and we should keep the list up to date.
