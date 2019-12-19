Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2D126E9E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Dec 2019 21:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbfLSUTq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Dec 2019 15:19:46 -0500
Received: from mx2.suse.de ([195.135.220.15]:47518 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726880AbfLSUTp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:19:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D3F49B2C8;
        Thu, 19 Dec 2019 20:19:43 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 36532DA939; Thu, 19 Dec 2019 21:19:41 +0100 (CET)
Date:   Thu, 19 Dec 2019 21:19:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 00/28] btrfs: zoned block device support
Message-ID: <20191219201941.GR3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.com>, Anand Jain <anand.jain@oracle.com>,
        linux-fsdevel@vger.kernel.org
References: <20191213040915.3502922-1-naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191213040915.3502922-1-naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 13, 2019 at 01:08:47PM +0900, Naohiro Aota wrote:
> This series adds zoned block device support to btrfs.
> 
> Changes:
>  - Changed -EINVAL to -EOPNOTSUPP to reject incompatible features
>    within HMZONED mode (David)
>  - Use bitmap helpers (Johannes)
>  - Fix calculation of a string length
>  - Code cleanup
> 
> Userland series is unchaged with the last version:
> https://lore.kernel.org/linux-btrfs/20191204082513.857320-1-naohiro.aota@wdc.com/T/
> 
> * Patch series description
> 
> A zoned block device consists of a number of zones. Zones are either
> conventional and accepting random writes or sequential and requiring
> that writes be issued in LBA order from each zone write pointer
> position. This patch series ensures that the sequential write
> constraint of sequential zones is respected while fundamentally not
> changing BtrFS block and I/O management for block stored in
> conventional zones.

One more high-level comment: let's please call it 'zone' mode, without
the 'host managed' part. That term is not relevant for a filesystem. The
zone allocator, or zone append-only allocator or similar describe what
happens on the filesystem layer.

The constraint posed by device is to never overwrite in place, that's
fine for COW design and that's what should be kept in mind while adding
the limitations (no nocow/raid56/...) or exceptions into the code.

In some cases it's not possible to fold the zoned support into existing
helpers but we should do that wherever we can. While reading the code
the number of if (HMZONED) felt too intrusive. This needs to be
adjusted, but I think it's mostly cosmetic or basic refactoring, not
changing the core of the implementation.

So in particular: remove 'hm' everywhere, filename, identifiers. For
short I'd call it 'zone' mode but full description would be something
like 'zone aware append-only allocation mode'.

I'll do another review pass to point out what I think can be refactored
but I hope that with the above gives enough hint.
