Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874D32A4784
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Nov 2020 15:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgKCOMe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Nov 2020 09:12:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:54510 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729582AbgKCOMP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Nov 2020 09:12:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 257E0AD1A;
        Tue,  3 Nov 2020 14:12:13 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 432A8DA7D2; Tue,  3 Nov 2020 15:10:35 +0100 (CET)
Date:   Tue, 3 Nov 2020 15:10:35 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Naohiro Aota <naohiro.aota@wdc.com>
Cc:     linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v9 11/41] btrfs: implement log-structured superblock for
 ZONED mode
Message-ID: <20201103141035.GZ6756@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Naohiro Aota <naohiro.aota@wdc.com>,
        linux-btrfs@vger.kernel.org, dsterba@suse.com, hare@suse.com,
        linux-fsdevel@vger.kernel.org
References: <cover.1604065156.git.naohiro.aota@wdc.com>
 <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca26372a84d8b8ec2b59d3390f172810ed6f3e4.1604065695.git.naohiro.aota@wdc.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 30, 2020 at 10:51:18PM +0900, Naohiro Aota wrote:
> Superblock (and its copies) is the only data structure in btrfs which has a
> fixed location on a device. Since we cannot overwrite in a sequential write
> required zone, we cannot place superblock in the zone. One easy solution is
> limiting superblock and copies to be placed only in conventional zones.
> However, this method has two downsides: one is reduced number of superblock
> copies. The location of the second copy of superblock is 256GB, which is in
> a sequential write required zone on typical devices in the market today.
> So, the number of superblock and copies is limited to be two.  Second
> downside is that we cannot support devices which have no conventional zones
> at all.
> 
> To solve these two problems, we employ superblock log writing. It uses two
> zones as a circular buffer to write updated superblocks. Once the first
> zone is filled up, start writing into the second buffer. Then, when the
> both zones are filled up and before start writing to the first zone again,
> it reset the first zone.
> 
> We can determine the position of the latest superblock by reading write
> pointer information from a device. One corner case is when the both zones
> are full. For this situation, we read out the last superblock of each
> zone, and compare them to determine which zone is older.
> 
> The following zones are reserved as the circular buffer on ZONED btrfs.
> 
> - The primary superblock: zones 0 and 1
> - The first copy: zones 16 and 17
> - The second copy: zones 1024 or zone at 256GB which is minimum, and next
>   to it
> 
> If these reserved zones are conventional, superblock is written fixed at
> the start of the zone without logging.

I don't have a clear picture here.

In case there's a conventional zone covering 0 and 1st copy (64K and
64M) it'll be overwritten. What happens for 2nd copy that's at 256G?
sb-log?

For all-sequential drive, the 0 and 1st copy are in the first zone.
You say 0 and 1, but how come if the minimum zone size we ever expect is
256M?

The circular buffer comprises zones covering all superblock copies? I
mean one buffer for 2 or more sb copies? The problem is that we'll have
just one copy of the current superblock. Or I misunderstood.

My idea is that we have primary zone, unfortunatelly covering 2
superblocks but let it be. Second zone contains 2nd superblock copy
(256G), we can assume that devices will be bigger than that.

Then the circular buffers happen in each zone, so first one will go from
offset 64K up to the zone size (256M or 1G).  Second zone rotates from
offset 0 to end of the zone.

The positive outcome of that is that both zones contain the latest
superblock after succesful write and their write pointer is slightly out
of sync, so they never have to be reset at the same time.

In numbers:
- first zone 64K .. 256M, 65520 superblocks
- second zone 256G .. 245G+256M, 65536 superblocks

The difference is 16 superblock updates, which should be enough to let
the zone resets happen far apart.
