Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E999D18F523
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Mar 2020 13:59:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgCWM7Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Mar 2020 08:59:25 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60382 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgCWM7Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Mar 2020 08:59:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WvtBKVD0nXNRJVqJUzQH2Ufp4zb4+Z84v9LBLqu/6gY=; b=lzA5yUbgoA4XGQysQKVdy7achd
        5FYLnz6SUH6i/x7Xk9FOcA+glSsW5iULdvCqOy1K91xXc2Pok1kKWPwLYzwXTJvxycYrlhMNbOqvL
        D4JJTQaxCOpo3nwEmXTMBEKBeS3/aEZ4jXypgoY0xf1GFoznqQzyivphcZ+h3E7HOccNaEdI+YTgG
        GRFvBIcDvGmcS4FmNMXc33IKqkn7LefUUrsTy+xoO/J4XwxE7Gwr/DSr9VUthjV116sN2THPxfCwq
        tnoPQOnSZrtjzlHF+2ilLAQaeUh5xvvAIQBExOMVxn+H3W9upkCBwiCPo4VovZZixwVqIFLcCuF37
        jJ5C3KGQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jGMfs-0002f9-8D; Mon, 23 Mar 2020 12:59:24 +0000
Date:   Mon, 23 Mar 2020 05:59:24 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, Jan Kara <jack@suse.cz>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] iomap: Submit the BIO at the end of each extent
Message-ID: <20200323125924.GA8688@infradead.org>
References: <20200320144014.3276-1-willy@infradead.org>
 <20200320214654.GC6812@magnolia>
 <20200321142034.GE4971@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200321142034.GE4971@bombadil.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 21, 2020 at 07:20:34AM -0700, Matthew Wilcox wrote:
> On Fri, Mar 20, 2020 at 02:46:54PM -0700, Darrick J. Wong wrote:
> > Hmm, I just received the following stack trace while running generic/418
> > on a v5 filesystem with 1k blocks:
> 
> I can't persuade this to reproduce on my setup.
> 
> > FSTYP         -- xfs (debug)
> > PLATFORM      -- Linux/x86_64 alder-mtr01 5.6.0-rc4-djw #rc4 SMP PREEMPT Fri Mar 13 14:48:13 PDT 2020
> > MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1, -b size=1024, /dev/sdd
> > MOUNT_OPTIONS -- -o usrquota,grpquota,prjquota, /dev/sdd /opt
> > 
> > (Note that it seems to do this even with MKFS_OPTIONS='-m crc=0' and
> > empty MOUNT_OPTIONS.)
> 
> FSTYP         -- xfs (debug)
> PLATFORM      -- Linux/x86_64 bobo-kvm 5.6.0-rc4-00001-g907dfd1bfc6d #2 SMP Fri Mar 20 18:30:53 EDT 2020
> MKFS_OPTIONS  -- -f -m reflink=1,rmapbt=1 -i sparse=1, -b size=1024 /dev/sdc
> MOUNT_OPTIONS -- /dev/sdc /mnt/scratch
> 
> > [   33.656942] run fstests generic/418 at 2020-03-20 14:42:29
> > [   36.332268] BUG: kernel NULL pointer dereference, address: 0000000000000060
> > [   36.334254] #PF: supervisor read access in kernel mode
> > [   36.334849] #PF: error_code(0x0000) - not-present page
> > [   36.335461] PGD 0 P4D 0 
> > [   36.335779] Oops: 0000 [#1] PREEMPT SMP
> > [   36.336246] CPU: 2 PID: 5144 Comm: dio-invalidate- Not tainted 5.6.0-rc4-djw #rc4
> > [   36.337078] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.10.2-1ubuntu1 04/01/2014
> > [   36.338069] RIP: 0010:iomap_readpage_actor+0x2ea/0x3c0
> > [   36.338671] Code: 43 10 8b 54 24 24 48 c7 40 38 80 bc 2f 81 48 8b 7b 10 e9 00 ff ff ff 31 c0 48 85 ed 0f 85 c9 fe ff ff 49 8b 46 18 48 8b 2c 24 <8b> 48 60 48 81 c5 ff 0f 00 00 48 c1 ed 0c 81 e1 c0 0c 00 00 e9 12
> > [   36.340705] RSP: 0018:ffffc90004ebb968 EFLAGS: 00010246
> > [   36.341309] RAX: 0000000000000000 RBX: ffffc90004ebbb30 RCX: 000000000000000a
> > [   36.342105] RDX: 0000000000000400 RSI: 0000000000000003 RDI: 0000000000000000
> > [   36.342909] RBP: 0000000000000400 R08: ffffc90004ebb988 R09: ffffc90004ebb98c
> > [   36.343710] R10: 0000000000001000 R11: 0000000000000400 R12: ffffc90004ebba50
> > [   36.344505] R13: 0000000000000086 R14: ffffea0001cd2400 R15: 0000000000000c00
> > [   36.345246] FS:  00007f892894c740(0000) GS:ffff88807e000000(0000) knlGS:0000000000000000
> > [   36.346087] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   36.346696] CR2: 0000000000000060 CR3: 0000000078753005 CR4: 00000000001606a0
> > [   36.347445] Call Trace:
> > [   36.347734]  iomap_readpages_actor+0x1e3/0x250
> > [   36.348699]  iomap_apply+0x12c/0x4e3
> > [   36.349097]  ? iomap_readpage_actor+0x3c0/0x3c0
> > [   36.349593]  ? prep_new_page+0x3f/0x100
> > [   36.350022]  ? iomap_readpage_actor+0x3c0/0x3c0
> > [   36.350519]  iomap_readpages+0xc7/0x2b0
> > [   36.350938]  ? iomap_readpage_actor+0x3c0/0x3c0
> > [   36.351438]  read_pages+0x6e/0x1a0
> > [   36.351824]  __do_page_cache_readahead+0x1c3/0x1e0
> > [   36.352343]  ondemand_readahead+0x210/0x4b0
> > [   36.352797]  generic_file_read_iter+0x871/0xcd0
> > [   36.353365]  ? xfs_file_buffered_aio_read+0x54/0x170 [xfs]
> > [   36.353982]  xfs_file_buffered_aio_read+0x5f/0x170 [xfs]
> > [   36.354591]  xfs_file_read_iter+0xea/0x2a0 [xfs]
> > [   36.355139]  ? xfs_file_write_iter+0xf2/0x1d0 [xfs]
> > [   36.355668]  new_sync_read+0x12d/0x1d0
> > [   36.356085]  vfs_read+0xa6/0x180
> > [   36.356454]  ksys_pread64+0x64/0xa0
> > [   36.356841]  do_syscall_64+0x50/0x1a0
> > [   36.357252]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [   36.357792] RIP: 0033:0x7f8928524f64
> > [   36.358189] Code: 15 61 80 20 00 f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 8b 05 aa c4 20 00 49 89 ca 85 c0 75 13 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 5c f3 c3 66 90 41 55 41 54 49 89 cd 55 53 49
> > [   36.360053] RSP: 002b:00007fffc7893b18 EFLAGS: 00000246 ORIG_RAX: 0000000000000011
> > [   36.360841] RAX: ffffffffffffffda RBX: 0000000000000400 RCX: 00007f8928524f64
> > [   36.361594] RDX: 0000000000000400 RSI: 00005593e3c23000 RDI: 0000000000000003
> > [   36.362344] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000001
> > [   36.363075] R10: 0000000000000000 R11: 0000000000000246 R12: 00005593e3c23000
> > [   36.363817] R13: 0000000000000000 R14: 00005593e3c25000 R15: 0000000000000400
> > [   36.364569] Modules linked in: xfs libcrc32c ip6t_REJECT nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 ip_set_hash_ip ip_set_hash_net xt_tcpudp xt_set ip_set_hash_mac ip_set nfnetlink ip6table_filter ip6_tables iptable_filter bfq sch_fq_codel ip_tables x_tables nfsv4 af_packet
> > [   36.366966] Dumping ftrace buffer:
> > [   36.367351]    (ftrace buffer empty)
> > [   36.367742] CR2: 0000000000000060
> > [   36.369050] ---[ end trace d599586d1259866c ]---
> > [   36.369884] RIP: 0010:iomap_readpage_actor+0x2ea/0x3c0
> > [   36.370694] Code: 43 10 8b 54 24 24 48 c7 40 38 80 bc 2f 81 48 8b 7b 10 e9 00 ff ff ff 31 c0 48 85 ed 0f 85 c9 fe ff ff 49 8b 46 18 48 8b 2c 24 <8b> 48 60 48 81 c5 ff 0f 00 00 48 c1 ed 0c 81 e1 c0 0c 00 00 e9 12
> > [   36.373022] RSP: 0018:ffffc90004ebb968 EFLAGS: 00010246
> > [   36.373615] RAX: 0000000000000000 RBX: ffffc90004ebbb30 RCX: 000000000000000a
> > [   36.374362] RDX: 0000000000000400 RSI: 0000000000000003 RDI: 0000000000000000
> > [   36.375100] RBP: 0000000000000400 R08: ffffc90004ebb988 R09: ffffc90004ebb98c
> > [   36.375833] R10: 0000000000001000 R11: 0000000000000400 R12: ffffc90004ebba50
> > [   36.376577] R13: 0000000000000086 R14: ffffea0001cd2400 R15: 0000000000000c00
> > [   36.377322] FS:  00007f892894c740(0000) GS:ffff88807e000000(0000) knlGS:0000000000000000
> > [   36.378190] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   36.378795] CR2: 0000000000000060 CR3: 0000000078753005 CR4: 00000000001606a0
> 
> This doesn't entirely match your backtrace, but this looks wrong:
> 
>                 if (ctx->is_readahead) /* same as readahead_gfp_mask */
>                         gfp |= __GFP_NORETRY | __GFP_NOWARN;
>                 ctx->bio = bio_alloc(gfp, min(BIO_MAX_PAGES, nr_vecs));
>                 ctx->bio->bi_opf = REQ_OP_READ;
> 
> If we're specifying NORETRY, then we have to handle bio_alloc() failure
> here, right?  I say it doesn't entirely match because you've got a read
> from an offset of 0x60, and every access here is a write.

Yes.  Interesting that this would only show up with your not exactly
related patch.  FYI, I'm tempted to just drop the gfp mask adustment
vs trying to handle the error, as exiting early from the loop looks
pretty nasty to implement..
