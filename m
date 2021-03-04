Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBC932D64C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 16:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233853AbhCDPRk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Mar 2021 10:17:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:33736 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234053AbhCDPRL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Mar 2021 10:17:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4D88AAC5;
        Thu,  4 Mar 2021 15:16:29 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 56556DA81D; Thu,  4 Mar 2021 16:14:33 +0100 (CET)
Date:   Thu, 4 Mar 2021 16:14:33 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] btrfs: zoned: move superblock logging zone
 location
Message-ID: <20210304151433.GR7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1614760899.git.naohiro.aota@wdc.com>
 <fe07f3ca7b17b6739cff8ab228d57bdbea0c447b.1614760899.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe07f3ca7b17b6739cff8ab228d57bdbea0c447b.1614760899.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 03, 2021 at 05:55:47PM +0900, Naohiro Aota wrote:
> This commit moves the location of superblock logging zones basing on the
> fixed address instead of the fixed zone number.
> 
> By locating the superblock zones using fixed addresses, we can scan a
> dumped file system image without the zone information. And, no drawbacks
> exist.
> 
> The following zones are reserved as the circular buffer on zoned btrfs.
>   - The primary superblock: zone at LBA 0 and the next zone
>   - The first copy: zone at LBA 16G and the next zone
>   - The second copy: zone at LBA 256G and the next zone
> 
> If the location of the zones are outside of disk, we don't record the
> superblock copy.
> 
> The addresses are much larger than the usual superblock copies locations.
> The copies' locations are decided to support possible future larger zone
> size, not to overlap the log zones. We support zone size up to 8GB.

One thing I don't see is that the reserved space for superblock is fixed
regardless of the actual device zone size. In exclude_super_stripes.

0-16G for primary
... and now what, 16G would be the next copy thus reserving 16 up to 32G

So the 64G offset for the 1st copy is more suitable:

0    -  16G primary
64G  -  80G 1st copy
256G - 272G 2nd copy

This still does not sound great because it just builds on the original
offsets from 10 years ago.  The device sizes are expected to be in
terabytes but all the superblocks are in the first terabyte.

What if we do that like

0   -  16G
1T  -  1T+16G
8T  -  8T+16G

The HDD sizes start somewhere at 4T so the first two copies cover the
small sizes, larger have all three copies. But we could go wild even
more, like 0/4T/16T.

I'm not sure if the capacities for non-HDD are going to be also that
large, I could not find anything specific, the only existing ZNS is some
DC ZN540 but no details.

We need to get this right (best effort), so I'll postpone this patch
until it's all sorted.
