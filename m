Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89FBB33F831
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Mar 2021 19:34:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhCQSd6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Mar 2021 14:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233027AbhCQSdl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Mar 2021 14:33:41 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90EAAC06175F
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 11:33:40 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l123so1735875pfl.8
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Mar 2021 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=450uH3zQDItaMM84GetFVuI/of0VP3zLA36bNmD2/No=;
        b=SKe7MboF1/tjZqwzlLRE7WOhlGuYQL8XQ3gghvDgRFq97Xnl672psgn2OZvqcQKzT3
         EkDsXY2OS34LuArm2coDcVO/evXKfe8s8OqBMd2vMggRzH5Rl9qqFG9L0aXZEVz2gufn
         WOW7lGuMB0WMRerBnsXNWYvDqVH1sNQ0XO4dj4u4uuUVxvwE5XI0yrdGhkFAuWVcY6sh
         R/G5FVZNn2VV4UST3E9y4aMYPYYNXdz9nePAQtwUQle44LDerB/Mbf+YrbQCwxz9RM1N
         LoCzcBT14FBi31CaU8J604U827a3m5zIbmS+eWTZ20Vi7NvbWtuqSktcFcTcosTRtikZ
         5u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=450uH3zQDItaMM84GetFVuI/of0VP3zLA36bNmD2/No=;
        b=JqvVzHbsWX2XHDy8wPNc3knipFOlv9yeeiDF+1tG0RZUwOBjBeV9r+ZnoxCSjH0/tJ
         fMzsrA3F3QzS8vjdjNJ3rx4XOfp+SBrbSK6HrNiqr0NFBCdxGhbCJaIukl4FeAbVubIC
         mmhJIQxTfhdMLZaS8VyDFTlGILRO2QkDtIiS62tum9ZUDQiGRB1N8nlD8pCB2Yg8H95J
         MiPxD3iyKqeuenV/7PbXQQCTC/iEQgfeQcnd+9TMOdff/tuBil8+WMc9q3P/HSi5ikd4
         HTrf62qveAHrb5K3F6kjhmyL7PcmohcfXBU/eOVQSblaI6/40eHJCPwPEpf4+O3Puff8
         dVUw==
X-Gm-Message-State: AOAM533ZpM3cEfRsTfP1XnXmMMO2lt5XujxPxa1cTs0dyaaYzqjRwnd4
        UbLa1fvRBKaDDF5yxADj18dqhQ==
X-Google-Smtp-Source: ABdhPJyPNC/FLCayUVtqgBzvbXenIz5qSACHRPhunMtT7mHGUBbdRBIV0OECGhxt8soID+NitX9wyg==
X-Received: by 2002:a62:2585:0:b029:1fb:bd86:2008 with SMTP id l127-20020a6225850000b02901fbbd862008mr296106pfl.77.1616006019890;
        Wed, 17 Mar 2021 11:33:39 -0700 (PDT)
Received: from relinquished.localdomain ([2620:10d:c090:400::5:156])
        by smtp.gmail.com with ESMTPSA id k10sm19763463pfk.49.2021.03.17.11.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 11:33:38 -0700 (PDT)
Date:   Wed, 17 Mar 2021 11:33:36 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>,
        Jann Horn <jannh@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Aleksa Sarai <cyphar@cyphar.com>, linux-api@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v8 04/10] btrfs: fix check_data_csum() error message for
 direct I/O
Message-ID: <YFJLgDQvley7zPjM@relinquished.localdomain>
References: <cover.1615922644.git.osandov@fb.com>
 <3a20de6d6ea2a8ebbed0637480f9aa8fff8da19c.1615922644.git.osandov@fb.com>
 <885fa39a-713f-f594-53ae-241d9cd7a113@gmx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <885fa39a-713f-f594-53ae-241d9cd7a113@gmx.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 17, 2021 at 07:21:46PM +0800, Qu Wenruo wrote:
> 
> 
> On 2021/3/17 上午3:43, Omar Sandoval wrote:
> > From: Omar Sandoval <osandov@fb.com>
> > 
> > Commit 1dae796aabf6 ("btrfs: inode: sink parameter start and len to
> > check_data_csum()") replaced the start parameter to check_data_csum()
> > with page_offset(), but page_offset() is not meaningful for direct I/O
> > pages. Bring back the start parameter.
> 
> So direct IO pages doesn't have page::index set at all?

No, they don't. Usually you do direct I/O into an anonymous page, but I
suppose you could even do direct I/O into a page mmap'd from another
file or filesystem. In either case, the index isn't meaningful for the
file you're doing direct I/O from.

> Any reproducer? I'd like to try to reproduce it first.

The easiest way to see this issue is to apply this patch:

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 2a92211439e8..a962b3026573 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3114,6 +3114,9 @@ static int check_data_csum(struct inode *inode, struct btrfs_io_bio *io_bio,
 	u8 *csum_expected;
 	u8 csum[BTRFS_CSUM_SIZE];
 
+	WARN_ONCE(page_offset(page) + pgoff != start,
+		  "page offset %llu != start %llu\n",
+		  page_offset(page) + pgoff, start);
 	ASSERT(pgoff + len <= PAGE_SIZE);
 
 	offset_sectors = bio_offset >> fs_info->sectorsize_bits;

Run this simple test:

$ dd if=/dev/zero of=foo bs=4k count=1024
1024+0 records in
1024+0 records out
4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.00456495 s, 919 MB/s
$ sync
$ dd if=foo of=/dev/null iflag=direct bs=4k
1024+0 records in
1024+0 records out
4194304 bytes (4.2 MB, 4.0 MiB) copied, 0.163079 s, 25.7 MB/s

And you'll get a warning like:

[   84.896486] ------------[ cut here ]------------
[   84.897370] page offset 94199157981184 != start 0
[   84.898128] WARNING: CPU: 1 PID: 459 at fs/btrfs/inode.c:3119 check_data_csum+0x189/0x260 [btrfs]
[   84.899547] Modules linked in: btrfs blake2b_generic xor pata_acpi ata_piix libata scsi_mod raid6_pq virtio_net net_failover virtio_rng libcrc32c rng_core failover
[   84.901742] CPU: 1 PID: 459 Comm: kworker/u56:2 Not tainted 5.12.0-rc3-00060-ge0cd3910d8cb-dirty #139
[   84.903205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   84.904875] Workqueue: btrfs-endio btrfs_work_helper [btrfs]
[   84.905749] RIP: 0010:check_data_csum+0x189/0x260 [btrfs]
[   84.906576] Code: 57 11 00 00 0f 85 03 ff ff ff 4c 89 ca 48 c7 c7 50 ba 35 c0 4c 89 44 24 10 48 89 44 24 08 c6 05 04 57 11 00 01 e8 22 e0 cf d4 <0f> 0b 4c 8b 44 24 10 48 8b 44 24 08 e9 d2 fe ff ff 41 8b 45 00 4d
[   84.909288] RSP: 0018:ffffb6e9c164bb98 EFLAGS: 00010282
[   84.910061] RAX: 0000000000000000 RBX: ffffe96b84a05f40 RCX: 0000000000000001
[   84.911109] RDX: 0000000080000001 RSI: ffffffff9573d067 RDI: 00000000ffffffff
[   84.912149] RBP: 0000000000000000 R08: 0000000000000000 R09: c0000000ffffdfff
[   84.913197] R10: 0000000000000001 R11: ffffb6e9c164b9c0 R12: 0000000000000000
[   84.914247] R13: ffff9d32a28c8dc0 R14: ffff9d32ac495e10 R15: 0000000000000004
[   84.915304] FS:  0000000000000000(0000) GS:ffff9d399f640000(0000) knlGS:0000000000000000
[   84.916478] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.917340] CR2: 000055ad52f97120 CR3: 00000001292f4002 CR4: 0000000000370ee0
[   84.918435] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.919473] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.920515] Call Trace:
[   84.920884]  ? find_busiest_group+0x41/0x380
[   84.921518]  ? load_balance+0x176/0xc10
[   84.922082]  ? kvm_sched_clock_read+0x5/0x10
[   84.922711]  ? sched_clock+0x5/0x10
[   84.923236]  btrfs_end_dio_bio+0x2fb/0x310 [btrfs]
[   84.923982]  end_workqueue_fn+0x29/0x40 [btrfs]
[   84.924698]  btrfs_work_helper+0xc1/0x350 [btrfs]
[   84.925435]  process_one_work+0x1c8/0x390
[   84.926025]  ? process_one_work+0x390/0x390
[   84.926650]  worker_thread+0x30/0x370
[   84.927209]  ? process_one_work+0x390/0x390
[   84.927875]  kthread+0x13d/0x160
[   84.928466]  ? kthread_park+0x80/0x80
[   84.929008]  ret_from_fork+0x22/0x30
[   84.929543] ---[ end trace 4f87c4a13fa476d4 ]---

> > 
> > Fixes: 265d4ac03fdf ("btrfs: sink parameter start and len to check_data_csum")
> > Signed-off-by: Omar Sandoval <osandov@fb.com>
> > ---
> >   fs/btrfs/inode.c | 14 +++++++++-----
> >   1 file changed, 9 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> > index ef6cb7b620d0..d2ece8554416 100644
> > --- a/fs/btrfs/inode.c
> > +++ b/fs/btrfs/inode.c
> > @@ -2947,11 +2947,13 @@ void btrfs_writepage_endio_finish_ordered(struct page *page, u64 start,
> >    * @bio_offset:	offset to the beginning of the bio (in bytes)
> >    * @page:	page where is the data to be verified
> >    * @pgoff:	offset inside the page
> > + * @start:	logical offset in the file
> 
> Please add some comment if only for direct IO we need that @start parameter.

Won't that add more confusion? Someone might read that and assume that
they don't need to pass start for a page cache page. In my opinion,
having this change in the git log is enough.
