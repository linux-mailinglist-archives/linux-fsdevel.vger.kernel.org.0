Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C390711B5C6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 16:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732095AbfLKPz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 10:55:56 -0500
Received: from mx2.suse.de ([195.135.220.15]:58732 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732246AbfLKPzy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:55:54 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 76924AB98;
        Wed, 11 Dec 2019 15:55:52 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 4C7B2DA883; Wed, 11 Dec 2019 16:55:53 +0100 (CET)
Date:   Wed, 11 Dec 2019 16:55:53 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
Subject: Re: 5.5.0-0.rc1 hang, could be zstd compression related
Message-ID: <20191211155553.GP3929@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Josef Bacik <josef@toxicpanda.com>,
        Chris Murphy <chris@colorremedies.com>,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
References: <CAJCQCtS_7vjBnqeDsedBQJYuE_ap+Xo6D=MXY=rOxf66oJZkrA@mail.gmail.com>
 <4eca86cf-65c3-5aba-d0fd-466d779614e6@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4eca86cf-65c3-5aba-d0fd-466d779614e6@toxicpanda.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:58:45AM -0500, Josef Bacik wrote:
> On 12/10/19 11:00 PM, Chris Murphy wrote:
> > Could continue to chat in one application, the desktop environment was
> > responsive, but no shells worked and I couldn't get to a tty and I
> > couldn't ssh into remotely. Looks like the journal has everything up
> > until I pressed and held down the power button.
> > 
> > 
> > /dev/nvme0n1p7 on / type btrfs
> > (rw,noatime,seclabel,compress=zstd:1,ssd,space_cache=v2,subvolid=274,subvol=/root)
> > 
> > dmesg pretty
> > https://pastebin.com/pvG3ERnd
> > 
> > dmesg (likely MUA stomped)
> > [10224.184137] flap.local kernel: perf: interrupt took too long (2522
> >> 2500), lowering kernel.perf_event_max_sample_rate to 79000
> > [14712.698184] flap.local kernel: perf: interrupt took too long (3153
> >> 3152), lowering kernel.perf_event_max_sample_rate to 63000
> > [17903.211976] flap.local kernel: Lockdown: systemd-logind:
> > hibernation is restricted; see man kernel_lockdown.7
> > [22877.667177] flap.local kernel: BUG: kernel NULL pointer
> > dereference, address: 00000000000006c8
> > [22877.667182] flap.local kernel: #PF: supervisor read access in kernel mode
> > [22877.667184] flap.local kernel: #PF: error_code(0x0000) - not-present page
> > [22877.667187] flap.local kernel: PGD 0 P4D 0
> > [22877.667191] flap.local kernel: Oops: 0000 [#1] SMP PTI
> > [22877.667194] flap.local kernel: CPU: 2 PID: 14747 Comm: kworker/u8:7
> > Not tainted 5.5.0-0.rc1.git0.1.fc32.x86_64+debug #1
> > [22877.667196] flap.local kernel: Hardware name: HP HP Spectre
> > Notebook/81A0, BIOS F.43 04/16/2019
> > [22877.667226] flap.local kernel: Workqueue: btrfs-delalloc
> > btrfs_work_helper [btrfs]
> > [22877.667233] flap.local kernel: RIP:
> > 0010:bio_associate_blkg_from_css+0x1c/0x3b0
> 
> This looks like the extent_map bdev cleanup thing that was supposed to be fixed, 
> did you send the patch without the fix for it Dave?  Thanks,

The fix for NULL bdev was added in 429aebc0a9a063667dba21 (and tested
with cgroups v2) and it's in a different function than the one that
appears on the stacktrace.

This seems to be another instance where the bdev is needed right after
the bio is created but way earlier than it's actually known for real,
yet still needed for the blkcg thing.

 443         bio = btrfs_bio_alloc(first_byte);
 444         bio->bi_opf = REQ_OP_WRITE | write_flags;
 445         bio->bi_private = cb;
 446         bio->bi_end_io = end_compressed_bio_write;
 447
 448         if (blkcg_css) {
 449                 bio->bi_opf |= REQ_CGROUP_PUNT;
 450                 bio_associate_blkg_from_css(bio, blkcg_css);
 451         }

Strange that it takes so long to reproduce, meaning the 'if' branch is
not taken often.
