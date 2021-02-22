Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CCA321C29
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Feb 2021 17:04:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231336AbhBVQDk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Feb 2021 11:03:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:37994 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231253AbhBVQDb (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Feb 2021 11:03:31 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4CEC4AFBF;
        Mon, 22 Feb 2021 16:02:48 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C219DA7FF; Mon, 22 Feb 2021 17:00:49 +0100 (CET)
Date:   Mon, 22 Feb 2021 17:00:49 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     dsterba@suse.cz, Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Subject: Re: [PATCH v15 00/42] btrfs: zoned block device support
Message-ID: <20210222160049.GR1993@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "hare@suse.com" <hare@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
References: <cover.1612433345.git.naohiro.aota@wdc.com>
 <20210210195829.GW1993@twin.jikos.cz>
 <SN4PR0401MB35987EE941FA59E2ECB8D7269B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211151901.GD1993@twin.jikos.cz>
 <SN4PR0401MB3598ADA963CA60A715DE5EDE9B8C9@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210211154627.GE1993@twin.jikos.cz>
 <SN4PR0401MB359821DC2BBF171C946142D09B889@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20210216043247.cjxybi7dudpgvvyg@naota-xeon>
 <20210216114611.GM1993@suse.cz>
 <20210222075043.3g7watpx5gedguaj@naota-xeon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222075043.3g7watpx5gedguaj@naota-xeon>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Feb 22, 2021 at 04:50:43PM +0900, Naohiro Aota wrote:
> > For real hardware I think this is not relevant but for the emulated mode
> > we need to deal with that case. The reserved size is wasteful and this
> > will become noticeable for devices < 16G but I'd rather keep the logic
> > simple and not care much about this corner case. So, the superblock
> > range would be reserved and if there's not enough to store the secondary
> > sb, then don't.
> 
> Sure. That works. I'm running xfstests with these new SB
> locations. Once it passed, I'll post the patch.
> 
> One corner case left. What should we do with zone size > 8G? In this
> case, the primary SB zones and the 1st copy SB zones overlap. I know
> this is unrealistic for real hardware, but you can still create such a
> device with null_blk.
> 
> 1) Use the following zones (zones #2, #3) as the primary SB zones
> 2) Do not write the primary SBs
> 3) Reject to mkfs
> 
> To be simple logic, method #3 would be appropriate here?
> 
> Technically, all the log zones overlap with zone size > 128 GB. I'm
> considering to reject to mkfs in this insane case anyway.

The 8G zone size idea is to buy us some time to support future hardware,
once this won't suffice we'll add an incompat bit like BIGZONES that
will allow larger zone sizes. At that time we'll probably have a better
idea about an exact number. So it's #3.
