Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D38A67A7042
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 04:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjITCNi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 22:13:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbjITCNh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 22:13:37 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22175C9
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:13:30 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c47309a8ccso2880675ad.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 19 Sep 2023 19:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1695176009; x=1695780809; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6uXBbE5KgrXZ1PrV2CPAiVdc34yjyfb/zSsxiLq4Gfg=;
        b=KcgFWtd+jXtA0yqkpqXXjl6SCwWdqAlmvJizHLKXxkJSHD0ZMRRTFOFZTEVC9gpwco
         owQSdVUACIe1yu1C/P4VRD79jCcw4I0Zz7IQCN0JBMJI4QIGbofO47BJ5SsP2hwjuchy
         HE1zIGC4OPWmVnX41KR1FGP1NCSs/fTgFW3bmVVDKq1obxAsafW4L0klarEX4zTrAcsE
         yKizYIEnmYV+YL7sh1GCnimzMO4DqB8IzmEyZQoooqnTklsfG/1GBOmL62lZIvA3CeSH
         oXpgjMTtaeeeBSR3rs7FNwtBBu728iq6LPVZ4EtrYsykjOyxfD1BP4gW+qVaDTEQ8bNg
         uZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695176009; x=1695780809;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6uXBbE5KgrXZ1PrV2CPAiVdc34yjyfb/zSsxiLq4Gfg=;
        b=O6TAIh0ltdvC48VvVT1aqqshJP5j/uKOAjQGFO39Pi8G0J52Bo62Oz1lwkibqf1CHZ
         elcz9lQtaVXFBmQxe7CpNE5sXfBWK6vHxG8NS1i6AoRKuOGJfNcsW8AmayOL4b7Wcwh+
         JLlHk35brH0+nPR9Vwzh+PUfb/JobkFkw9x44hvhJwUTkWU0dllTU8bgKyJw42qhPBFi
         Vnt9vq3bCi8Q1QB8DheQPTNmecxvz0Pp3vPA7Bd5i7kG4Ok4wkBX1V8CrlSG8n/qruga
         JK62Yf2z7SlF670abDpaIlG/08rR/4VXPeR73pz733sz3eMfQLOiKV0VetNz+9OFmJDF
         z8xA==
X-Gm-Message-State: AOJu0YwkOCUszZ2G1ktfl/sM2u8MC9OMtB5BL91im1HlkH6xSUniQDzo
        uJ4FFP0oRM3DVIstZ4strhi1dA==
X-Google-Smtp-Source: AGHT+IFCr8HadOsZQbrJ4wohDzoccU6NTqszpfjxoJWBXQTUrZ9oQbdMYc2MVuKsvyy2AKtfg3iwGQ==
X-Received: by 2002:a17:903:2310:b0:1bc:edd:e891 with SMTP id d16-20020a170903231000b001bc0edde891mr5799297plh.1.1695176009443;
        Tue, 19 Sep 2023 19:13:29 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id q5-20020a17090311c500b001b9de39905asm10587082plh.59.2023.09.19.19.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 19:13:28 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qimiU-0032LT-0s;
        Wed, 20 Sep 2023 12:13:26 +1000
Date:   Wed, 20 Sep 2023 12:13:26 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Pankaj Raghav <p.raghav@samsung.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 17/18] xfs: remove check for block sizes smaller than
 PAGE_SIZE
Message-ID: <ZQpVRnh9QgdoQZso@dread.disaster.area>
References: <20230918110510.66470-1-hare@suse.de>
 <20230918110510.66470-18-hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918110510.66470-18-hare@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 18, 2023 at 01:05:09PM +0200, Hannes Reinecke wrote:
> We now support block sizes larger than PAGE_SIZE, so this
> check is pointless.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>  fs/xfs/xfs_super.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
> index 1f77014c6e1a..67dcdd4dcf2d 100644
> --- a/fs/xfs/xfs_super.c
> +++ b/fs/xfs/xfs_super.c
> @@ -1651,18 +1651,6 @@ xfs_fs_fill_super(
>  		goto out_free_sb;
>  	}
>  
> -	/*
> -	 * Until this is fixed only page-sized or smaller data blocks work.
> -	 */
> -	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> -		xfs_warn(mp,
> -		"File system with blocksize %d bytes. "
> -		"Only pagesize (%ld) or less will currently work.",
> -				mp->m_sb.sb_blocksize, PAGE_SIZE);
> -		error = -ENOSYS;
> -		goto out_free_sb;
> -	}

This really needs to be replaced with an EXPERIMENTAL warning -
we're not going to support these LBS configurations until we are
sure it doesn't eat data.

Anyway, smoke tests....

# mkfs.xfs -f -b size=64k /dev/pmem0
meta-data=/dev/pmem0             isize=512    agcount=4, agsize=32768 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=65536  blocks=131072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=65536  ascii-ci=0, ftype=1
log      =internal log           bsize=65536  blocks=1024, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=65536  blocks=0, rtextents=0
# mount /dev/pmem0 /mnt/test

Message from syslogd@test3 at Sep 20 11:23:32 ...
 kernel:[   73.521819] XFS: Assertion failed: PAGE_SHIFT >= sbp->sb_blocklog, file: fs/xfs/xfs_mount.c, line: 134

Message from syslogd@test3 at Sep 20 11:23:32 ...
 kernel:[   73.521819] XFS: Assertion failed: PAGE_SHIFT >= sbp->sb_blocklog, file: fs/xfs/xfs_mount.c, line: 134
Segmentation fault
#

Looks like this hasn't been tested with CONFIG_XFS_DEBUG=y. If
that's the case, I expect that none of this actually works... :/

I've attached a patch at the end of the email that allows XFS
filesystems to mount with debug enabled.

Next problem, filesystem created with a 32kB sector size:

# mkfs.xfs -f -b size=64k -s size=32k /dev/pmem0
meta-data=/dev/pmem0             isize=512    agcount=4, agsize=32768 blks
         =                       sectsz=32768 attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=1
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=65536  blocks=131072, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=65536  ascii-ci=0, ftype=1
log      =internal log           bsize=65536  blocks=2709, version=2
         =                       sectsz=32768 sunit=1 blks, lazy-count=1
realtime =none                   extsz=65536  blocks=0, rtextents=0
#

and then running xfs_db on it to change the UUID:

# xfs_admin -U generate /dev/pmem0

Results in a kernel panic:

[  132.151886] XFS (pmem0): Mounting V5 Filesystem 3d96f860-2aa2-4e50-970c-134508b7954a
[  132.161673] XFS (pmem0): Ending clean mount
[  175.824015] XFS (pmem0): Unmounting Filesystem 3d96f860-2aa2-4e50-970c-134508b7954a
[  185.759251] Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: do_mpage_readpage+0x7e5/0x7f0
[  185.766632] CPU: 1 PID: 4383 Comm: xfs_db Not tainted 6.6.0-rc2-dgc+ #1903
[  185.771882] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  185.778827] Call Trace:
[  185.780706]  <TASK>
[  185.782318]  dump_stack_lvl+0x37/0x50
[  185.785069]  dump_stack+0x10/0x20
[  185.787557]  panic+0x15b/0x300
[  185.789763]  ? do_mpage_readpage+0x7e5/0x7f0
[  185.792705]  __stack_chk_fail+0x14/0x20
[  185.795183]  do_mpage_readpage+0x7e5/0x7f0
[  185.797826]  ? blkdev_write_begin+0x30/0x30
[  185.800500]  ? blkdev_readahead+0x15/0x20
[  185.802894]  ? read_pages+0x5c/0x230
[  185.805023]  ? page_cache_ra_order+0x2ae/0x310
[  185.807538]  ? ondemand_readahead+0x1f1/0x3a0
[  185.809899]  ? page_cache_async_ra+0x26/0x30
[  185.812175]  ? filemap_get_pages+0x540/0x6d0
[  185.814327]  ? _copy_to_iter+0x65/0x4c0
[  185.816283]  ? filemap_read+0xfc/0x3a0
[  185.818086]  ? __fsnotify_parent+0x107/0x340
[  185.820142]  ? __might_sleep+0x42/0x70
[  185.821854]  ? blkdev_read_iter+0x6d/0x150
[  185.823697]  ? vfs_read+0x1b1/0x300
[  185.825307]  ? __x64_sys_pread64+0x8f/0xc0
[  185.827159]  ? irqentry_exit+0x33/0x40
[  185.828858]  ? do_syscall_64+0x35/0x80
[  185.830485]  ? entry_SYSCALL_64_after_hwframe+0x63/0xcd
[  185.832677]  </TASK>
[  185.834068] Kernel Offset: disabled
[  185.835510] ---[ end Kernel panic - not syncing: stack-protector: Kernel stack is corrupted in: do_mpage_readpage+0x7e5/0x7f0 ]---

Probably related to the block device having a 32kB block size set on
the pmem device by xfs_db when it only really has a 4kB sector size....

Anyway, back to just using 64k fsb, 4k sector.  generic/001 ASSERT
fails immediately with:

[  111.785796] run fstests generic/001 at 2023-09-20 11:50:19
[  113.346797] XFS: Assertion failed: imap.br_startblock != DELAYSTARTBLOCK, file: fs/xfs/xfs_reflink.c, line: 1392
[  113.352512] ------------[ cut here ]------------
[  113.354793] kernel BUG at fs/xfs/xfs_message.c:102!
[  113.358444] invalid opcode: 0000 [#1] PREEMPT SMP
[  113.360769] CPU: 8 PID: 7581 Comm: cp Not tainted 6.6.0-rc2-dgc+ #1903
[  113.364183] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[  113.369784] RIP: 0010:assfail+0x35/0x40
[  113.372038] Code: c9 48 c7 c2 00 d8 6c 82 48 89 e5 48 89 f1 48 89 fe 48 c7 c7 d8 d3 60 82 e8 a8 fd ff ff 80 3d d1 36 ec 02 00 75 04 0f 0b 5d c3 <0f> 0b 66 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 55 48 63 f6 49 89
[  113.384178] RSP: 0018:ffffc9000962bca0 EFLAGS: 00010202
[  113.387467] RAX: 0000000000000000 RBX: 0000000000000001 RCX: 000000007fffffff
[  113.392326] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8260d3d8
[  113.397235] RBP: ffffc9000962bca0 R08: 0000000000000000 R09: 000000000000000a
[  113.401449] R10: 000000000000000a R11: 0fffffffffffffff R12: 0000000000000000
[  113.406312] R13: 00000000ffffff8b R14: 0000000000000000 R15: ffff88810de00f00
[  113.410562] FS:  00007f4f6219b500(0000) GS:ffff8885fec00000(0000) knlGS:0000000000000000
[  113.415506] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  113.418688] CR2: 0000564951bfcf50 CR3: 00000005cd6b8005 CR4: 0000000000060ee0
[  113.422825] Call Trace:
[  113.424302]  <TASK>
[  113.425566]  ? show_regs+0x61/0x70
[  113.427444]  ? die+0x37/0x90
[  113.429175]  ? do_trap+0xec/0x100
[  113.431016]  ? do_error_trap+0x6c/0x90
[  113.432951]  ? assfail+0x35/0x40
[  113.434677]  ? exc_invalid_op+0x52/0x70
[  113.436755]  ? assfail+0x35/0x40
[  113.438659]  ? asm_exc_invalid_op+0x1b/0x20
[  113.440864]  ? assfail+0x35/0x40
[  113.442671]  xfs_reflink_remap_blocks+0x197/0x350
[  113.445278]  xfs_file_remap_range+0xf3/0x320
[  113.447504]  do_clone_file_range+0xfe/0x2b0
[  113.449689]  vfs_clone_file_range+0x3f/0x150
[  113.452080]  ioctl_file_clone+0x52/0xa0
[  113.453600]  do_vfs_ioctl+0x485/0x8d0
[  113.455054]  ? selinux_file_ioctl+0x96/0x120
[  113.456637]  ? selinux_file_ioctl+0x96/0x120
[  113.458213]  __x64_sys_ioctl+0x73/0xd0
[  113.459598]  do_syscall_64+0x35/0x80
[  113.460840]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

Problems with unexpected extent types in the reflink remap code.

This is due to the reflink operation finding a delalloc extent where
it should be finding a real extent. this implies the
xfs_flush_unmap_range() call in xfs_reflink_remap_prep() didn't
flush the full data range it was supposed to.
xfs_flush_unmap_range() is supposed to round the range out to:

	rounding = max_t(xfs_off_t, mp->m_sb.sb_blocksize, PAGE_SIZE);

the block size for these cases, so it is LBS aware. So maybe there's
a problem with filemap_write_and_wait_range() and/or
truncate_pagecache_range() when dealing with LBS enabled page cache?

So, yeah, debug XFS builds tell us straight away that important stuff
does not appear to be not working correctly. Debug really needs to
be enabled, otherwise silent data corruption situations like this
can go unnoticed by fstests tests...

-Dave
-- 
Dave Chinner
david@fromorbit.com


xfs: fix page cache size validation for LBS configuations

From: Dave Chinner <dchinner@redhat.com>

The page cache can index larger filesystem sizes on 32 bit systems
if large block sizes are enabled. Fix this code to take these
configurations into account.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_mount.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index 0a0fd19573d8..35dfcbc1e576 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -131,11 +131,15 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
-	ASSERT(sbp->sb_blocklog >= BBSHIFT);
+	ASSERT(sbp->sb_blocklog <= XFS_MAX_BLOCKSIZE_LOG);
+	ASSERT(sbp->sb_blocklog >= XFS_MIN_BLOCKSIZE_LOG);
 
 	/* Limited by ULONG_MAX of page cache index */
-	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
+	if (PAGE_SHIFT >= sbp->sb_blocklog)
+		nblocks >>= (PAGE_SHIFT - sbp->sb_blocklog);
+	else
+		nblocks <<= (sbp->sb_blocklog - PAGE_SHIFT);
+	if (nblocks > ULONG_MAX)
 		return -EFBIG;
 	return 0;
 }
