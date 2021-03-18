Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E858340F0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 21:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233049AbhCRU17 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 16:27:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:43790 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhCRU14 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 16:27:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C327EAC1E;
        Thu, 18 Mar 2021 20:27:54 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 116A3DA6E2; Thu, 18 Mar 2021 21:25:52 +0100 (CET)
Date:   Thu, 18 Mar 2021 21:25:51 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v8 04/10] btrfs: fix check_data_csum() error message for
 direct I/O
Message-ID: <20210318202551.GA7604@twin.jikos.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Qu Wenruo <quwenruo.btrfs@gmx.com>,
        Omar Sandoval <osandov@osandov.com>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
References: <cover.1615922644.git.osandov@fb.com>
 <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1615922644.git.osandov@fb.com>
 <885fa39a-713f-f594-53ae-241d9cd7a113@gmx.com>
 <YFJLgDQvley7zPjM@relinquished.localdomain>
 <d0b2d79f-586e-fc35-4d77-788a6965b155@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d0b2d79f-586e-fc35-4d77-788a6965b155@gmx.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 18, 2021 at 07:47:29AM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/18 上午2:33, Omar Sandoval wrote:
> > On Wed, Mar 17, 2021 at 07:21:46PM +0800, Qu Wenruo wrote:
> >>
> >>
> >> On 2021/3/17 上午3:43, Omar Sandoval wrote:
> >>> From: Omar Sandoval <osandov@fb.com>
> >>>
> >>> Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
> >>> check_data_csum()") replaced the start parameter to check_data_csum()
> >>> with page_offset(), but page_offset() is not meaningful for direct I/O
> >>> pages. Bring back the start parameter.
> >>
> >> So direct IO pages doesn't have page::index set at all?
> >
> > No, they don't. Usually you do direct I/O into an anonymous page, but I
> > suppose you could even do direct I/O into a page mmap'd from another
> > file or filesystem. In either case, the index isn't meaningful for the
> > file you're doing direct I/O from.
> >
> >> Any reproducer? I'd like to try to reproduce it first.
> >
> > The easiest way to see this issue is to apply this patch:
> >
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index 2a92211439e8..a962b3026573 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -3114,6 +3114,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
> >   	u8 *csum_expected;
> >   	u8 csum[BTRFS_CSUM_SIZE];
> >
> > +	WARN_ONCE(page_offset(page) + pgoff != start,
> > +		  "page offset %llu != start %llu\n",
> > +		  page_offset(page) + pgoff, start);
> >   	ASSERT(pgoff + len <= PAGE_SIZE);
> >
> >   	offset_sectors = bio_offset >> fs_info->sectorsize_bits;
> >
> > Run this simple test:
> >
> > $ dd if=/dev/zero of=foo bs=4k count=1024
> > 1024+0 records in
> > 1024+0 records out
> > 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.00456495 s, 919 MB/s
> > $ sync
> > $ dd if=foo of=/dev/null iflag=direct bs=4k
> > 1024+0 records in
> > 1024+0 records out
> > 4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.163079 s, 25.7 MB/s
> >
> > And you'll get a warning like:
> >
> > [   84.896486] ------------[ cut here ]------------
> > [   84.897370] page offset 94199157981184 != start 0
> > [   84.898128] WARNING: CPU: 1 PID: 459 at fs/btrfs/inode.c:3119 check_data_csum+0x189/0x260 [btrfs]
> > [   84.899547] Modules linked in: btrfs blake2b_generic xor pata_acpi ata_piix libata scsi_mod raid6_pq virtio_net net_failover virtio_rng libcrc32c rng_core failover
> > [   84.901742] CPU: 1 PID: 459 Comm: kworker/u56:2 Not tainted 5.12.0-rc3-00060-ge0cd3910d8cb-dirty #139
> > [   84.903205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
> > [   84.904875] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
> > [   84.905749] RIP: 0010:check_data_csum+0x189/0x260 [btrfs]
> > [   84.906576] Code: 57 11 00 00 0f 85 03 ff ff ff 4c 89 ca 48 c7 c7 50 ba 35 c0 4c 89 44 24 10 48 89 44 24 08 c6 05 04 57 11 00 01 e8 22 e0 cf d4 <0f> 0b 4c 8b 44 24 10 48 8b 44 24 08 e9 d2 fe ff ff 41 8b 45 00 4d
> > [   84.909288] RSP: 0018:ffffb6e9c164bb98 EFLAGS: 00010282
> > [   84.910061] RAX: 0000000000000000 RBX: ffffe96b84a05f40 RCX: 0000000000000001
> > [   84.911109] RDX: 0000000080000001 RSI: ffffffff9573d067 RDI: 00000000ffffffff
> > [   84.912149] RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000ffffdfff
> > [   84.913197] R10: 0000000000000001 R11: ffffb6e9c164b9c0 R12: 0000000000000000
> > [   84.914247] R13: ffff9d32a28c8dc0 R14: ffff9d32ac495e10 R15: 0000000000000004
> > [   84.915304] FS:  0000000000000000(0000) GS:ffff9d399f640000(0000) knlGS:0000000000000000
> > [   84.916478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   84.917340] CR2: 000055ad52f97120 CR3: 00000001292f4002 CR4: 0000000000370ee0
> > [   84.918435] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > [   84.919473] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > [   84.920515] Call Trace:
> > [   84.920884]  ? find_busiest_group+0x41/0x380
> > [   84.921518]  ? load_balance+0x176/0xc10
> > [   84.922082]  ? kvm_sched_clock_read+0x5/0x10
> > [   84.922711]  ? sched_clock+0x5/0x10
> > [   84.923236]  btrfs_end_dio_bio+0x2fb/0x310 [btrfs]
> > [   84.923982]  end_workqueue_fn+0x29/0x40 [btrfs]
> > [   84.924698]  btrfs_work_helper+0xc1/0x350 [btrfs]
> > [   84.925435]  process_one_work+0x1c8/0x390
> > [   84.926025]  ? process_one_work+0x390/0x390
> > [   84.926650]  worker_thread+0x30/0x370
> > [   84.927209]  ? process_one_work+0x390/0x390
> > [   84.927875]  kthread+0x13d/0x160
> > [   84.928466]  ? kthread_park+0x80/0x80
> > [   84.929008]  ret_from_fork+0x22/0x30
> > [   84.929543] ---[ end trace 4f87c4a13fa476d4 ]---
> >
> >>>
> >>> Fixes: 265d4ac03fdf ("btrfs: sink parameter start and len to check_data_csum")
> >>> Signed-off-by: Omar Sandoval <osandov@fb.com>
> >>> ---
> >>>    fs/btrfs/inode.c | 14 +++++++++-----
> >>>    1 file changed, 9 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> >>> index ef6cb7b620d0..d2ece8554416 100644
> >>> --- a/fs/btrfs/inode.c
> >>> +++ b/fs/btrfs/inode.c
> >>> @@ -2947,11 +2947,13 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
> >>>     * @bio_offset:	offset to the beginning of the bio (in bytes)
> >>>     * @page:	page where is the data to be verified
> >>>     * @pgoff:	offset inside the page
> >>> + * @start:	logical offset in the file
> >>
> >> Please add some comment if only for direct IO we need that @start parameter.
> >
> > Won't that add more confusion? Someone might read that and assume that
> > they don't need to pass start for a page cache page. In my opinion,
> > having this change in the git log is enough.
> >
> That's fine.
> 
> Then this patch looks fine to me.
> 
> Reviewed-by: Qu Wenruo <wqu@suse.com>

Added to misc-next, thanks.
