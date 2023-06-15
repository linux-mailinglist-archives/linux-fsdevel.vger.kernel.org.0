Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7751730DA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jun 2023 05:44:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbjFODoh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jun 2023 23:44:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236043AbjFODof (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jun 2023 23:44:35 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1521FD7
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 20:44:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39ce0ab782fso2894128b6e.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jun 2023 20:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1686800671; x=1689392671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+JDes7jRvGsGMMdD7UFRGccqLECG4zJw/AXOu7VOdwQ=;
        b=I4Wlesfjp370iJsVjnl5XNi527Qq2vafNdaCD7KmjSFQ5s1vjXZLXCeU1pMeKig6DH
         FYmVJJevKUtGn9PsZJJb+7RRNitfI3er6jescvapSmNmW7wVRLM9/LSbDhIEXUDNd2rQ
         98j3LklNIGAA/mB/dsfHFiPFlSfyUNW1OKQPjiCM63mnMUZRv7WfydbOanNjMcZh0KZ2
         cu2CeXj8OSo5i13Oa2skKIQa0KRgQv0htadLcqx27/IzCuqL4mpFotLBgFKaxuu8VUBC
         57crKz5Y53JvpASom4YCYA2SWeArEraK2gR2qXh/hfZ4vdqx/Us8ZBnaUJ8hIqOgpEfU
         QhJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686800671; x=1689392671;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+JDes7jRvGsGMMdD7UFRGccqLECG4zJw/AXOu7VOdwQ=;
        b=ZaJmooAygQFcvl9y9yn6jmsZ2SH1zKe9HNK1tXUTDU4TwaXAcqfjmgbscMxfKp8bVl
         bU9oOetdcKeHBuUcAs4Sp3uNk2ZuYmr/hwJjQdYHfzcuFJRdvML83eiyl7SYD4ZiweUF
         xMIxnWy7rKxrZi7nxCFj1F6EQL5qxBBUHfqBEtZbT12w3CYTPoNu9EuwdkZaIJ/aire7
         yXhxdOF4HNZDkf/t+/BfVwjvCQbm8kKbHwrRMy/KPJWlITrDnhJ/HYYQ8zCe3oGLb5EI
         q/3B2fO7bbexzKvRbTvXy2kq8vH77mqgtokyiPaZaQA7ufuiDR5PKbj4yH+XzEqdEPN3
         JK0Q==
X-Gm-Message-State: AC+VfDxcKROX0Xf3t3J9wP8EExQNOZckYfBSdGHh4BCkmc9qU9cC+v/c
        xYqvKGMo9KvuhIJEpIsQ0Newig==
X-Google-Smtp-Source: ACHHUZ7wQxTUTsKfsNvmtb6gohaYaKjOSnZAo7meX8h8d37E6CHZYQBEgmn1KwNeTZ8Ja7H05UX0KA==
X-Received: by 2002:a05:6808:1313:b0:38e:a824:27d3 with SMTP id y19-20020a056808131300b0038ea82427d3mr15185405oiv.27.1686800671489;
        Wed, 14 Jun 2023 20:44:31 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id bk17-20020a17090b081100b00256b9d26a2bsm13411133pjb.44.2023.06.14.20.44.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jun 2023 20:44:30 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1q9duN-00BvW5-2S;
        Thu, 15 Jun 2023 13:44:27 +1000
Date:   Thu, 15 Jun 2023 13:44:27 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH 0/7] RFC: high-order folio support for I/O
Message-ID: <ZIqJG1fR53Jf0Jjg@dread.disaster.area>
References: <20230614114637.89759-1-hare@suse.de>
 <cd816905-0e3e-6397-1a6f-fd4d29dfc739@suse.de>
 <ZInGbz6X/ZQAwdRx@casper.infradead.org>
 <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b3fa1b77-d120-f86b-e02f-f79b6d13efcc@suse.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:06:14PM +0200, Hannes Reinecke wrote:
> On 6/14/23 15:53, Matthew Wilcox wrote:
> > On Wed, Jun 14, 2023 at 03:17:25PM +0200, Hannes Reinecke wrote:
> > > Turns out that was quite easy to fix (just remove the check in
> > > set_blocksize()), but now I get this:
> > > 
> > > SGI XFS with ACLs, security attributes, quota, no debug enabled
> > > XFS (ram0): File system with blocksize 16384 bytes. Only pagesize (4096) or
> > > less will currently work.
> > 
> > What happens if you just remove this hunk:
> > 
> > +++ b/fs/xfs/xfs_super.c
> > @@ -1583,18 +1583,6 @@ xfs_fs_fill_super(
> >                  goto out_free_sb;
> >          }
> > 
> > -       /*
> > -        * Until this is fixed only page-sized or smaller data blocks work.
> > -        */
> > -       if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
> > -               xfs_warn(mp,
> > -               "File system with blocksize %d bytes. "
> > -               "Only pagesize (%ld) or less will currently work.",
> > -                               mp->m_sb.sb_blocksize, PAGE_SIZE);
> > -               error = -ENOSYS;
> > -               goto out_free_sb;
> > -       }
> > -
> >          /* Ensure this filesystem fits in the page cache limits */
> >          if (xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_dblocks) ||
> >              xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_rblocks)) {
> 
> Whee! That works!
> 
> Rebased things with your memcpy_{to,from}_folio() patches, disabled that
> chunk, and:
> 
> # mount /dev/ram0 /mnt

What is the output of mkfs.xfs?

> XFS (ram0): Mounting V5 Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551
> XFS (ram0): Ending clean mount
> xfs filesystem being mounted at /mnt supports timestamps until 2038-01-19
> (0x7fffffff)
> # umount /mnt
> XFS (ram0): Unmounting Filesystem 5cd71ab5-2d11-4c18-97dd-71708f40e551

Nope. Not here.

Debug kernel builds assert fail at mount time with:

XFS: Assertion failed: PAGE_SHIFT >= sbp->sb_blocklog, file: fs/xfs/xfs_mount.c, line: 133

Because we do a check to ensure that the entire filesystem address
range can be indexed by the page cache. I suspect this is actually a
stale, left over check from the days we used the page cache for
indexing cached metadata, but with that sorted....

It fails here (8GB ram disk):

#mkfs.xfs -f -b size=64k /dev/ram0
meta-data=/dev/ram0              isize=512    agcount=4, agsize=32000 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=65536  blocks=128000, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=65536  ascii-ci=0, ftype=1
log      =internal log           bsize=65536  blocks=1024, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=65536  blocks=0, rtextents=0
# mount /dev/ram0 /mnt/test
[   34.047433] XFS (ram0): Mounting V5 Filesystem 074579ae-9c33-447a-a336-8ea99cda87c3
[   34.053962] BUG: Bad rss-counter state mm:00000000b41e2cf6 type:MM_FILEPAGES val:11
[   34.054451] general protection fault, probably for non-canonical address 0x4002888237d00000: 0000 [#1] PREEMPT SMP
[   34.057426] psi: task underflow! cpu=8 t=2 tasks=[0 0 0 0] clear=4 set=0
[   34.065011] CPU: 2 PID: 3689 Comm: mount Not tainted 6.4.0-rc6-dgc+ #1832
[   34.068647] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   34.073236] RIP: 0010:__submit_bio+0x9e/0x110
[   34.075124] Code: c3 e8 d6 c5 88 ff 48 8b 43 08 48 89 df 4c 8b 60 10 49 8b 44 24 60 ff 10 49 8b 5c 24 68 e8 3a 92 88 ff 48 8b 43 10 a8 03 75 56 <65> 48 8
[   34.084879] RSP: 0018:ffffc900045c3a10 EFLAGS: 00010246
[   34.087501] RAX: 4003000000000000 RBX: ffff8885c1568000 RCX: 0000000000000080
[   34.090455] RDX: ffff888805d8a900 RSI: 0000000000000286 RDI: ffffc900045c3ad8
[   34.093419] RBP: ffffc900045c3a20 R08: 0000000000000000 R09: 0000000000000000
[   34.096381] R10: 0000000000000000 R11: 0000000000000000 R12: ffff88880124b000
[   34.099340] R13: ffff8885c1568000 R14: ffff888100620000 R15: 0000000000fa0000
[   34.102285] FS:  00007f1b86428840(0000) GS:ffff888237d00000(0000) knlGS:0000000000000000
[   34.105410] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   34.107577] CR2: 00007f1b86364000 CR3: 000000010482d003 CR4: 0000000000060ee0
[   34.110114] Call Trace:
[   34.111031]  <TASK>
[   34.111782]  ? show_regs+0x61/0x70
[   34.112945]  ? die_addr+0x37/0x90
[   34.114080]  ? exc_general_protection+0x19e/0x3b0
[   34.115619]  ? asm_exc_general_protection+0x27/0x30
[   34.117162]  ? __submit_bio+0x9e/0x110
[   34.118355]  submit_bio_noacct_nocheck+0xf3/0x330
[   34.119819]  submit_bio_noacct+0x196/0x490
[   34.121042]  submit_bio+0x58/0x60
[   34.122045]  submit_bio_wait+0x70/0xd0
[   34.123178]  xfs_rw_bdev+0x188/0x1b0
[   34.124255]  xlog_do_io+0x95/0x170
[   34.125283]  xlog_bwrite+0x14/0x20
[   34.126310]  xlog_write_log_records+0x179/0x260
[   34.127637]  xlog_clear_stale_blocks+0xa5/0x1c0
[   34.128917]  xlog_find_tail+0x372/0x3b0
[   34.130011]  xlog_recover+0x2f/0x190
[   34.131041]  xfs_log_mount+0x1b8/0x350
[   34.132055]  xfs_mountfs+0x451/0x9a0
[   34.133019]  xfs_fs_fill_super+0x4d9/0x920
[   34.134113]  get_tree_bdev+0x16e/0x270
[   34.135130]  ? xfs_open_devices+0x230/0x230
[   34.136184]  xfs_fs_get_tree+0x15/0x20
[   34.137144]  vfs_get_tree+0x24/0xd0
[   34.138041]  path_mount+0x2fd/0xae0
[   34.138955]  ? putname+0x53/0x60
[   34.139749]  __x64_sys_mount+0x108/0x140
[   34.140698]  do_syscall_64+0x34/0x80
[   34.141574]  entry_SYSCALL_64_after_hwframe+0x63/0xcd


Hmmmm - that's logical sector aligned/sized IO that is failing like
this. The fs is using 64kB block size, 512 byte sector size.

So I went looking.

# blockdev --report /dev/ram0
RO    RA   SSZ   BSZ        StartSec            Size   Device
rw   256   512  4096               0      8388608000   /dev/ram0
#

Huh. sector size is fine, block size for the device isn't.

# cat /sys/block/ram0/queue/physical_block_size
65536
#

Yup, brd definitely picked up that it is supposed to be using 64kB
blocks.

# blockdev --setbsz 65536 /dev/ram0
blockdev: ioctl error on BLKBSZSET: Invalid argument
#

Huh.

<dig dig dig>

int set_blocksize(struct block_device *bdev, int size)
{
        /* Size must be a power of two, and between 512 and PAGE_SIZE */
        if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
                return -EINVAL;
	.....

Yeah, ok. The block device doesn't support 64kB block sizes. Lucky
that XFs uses this as it's sector size:

# mkfs.xfs -f -b size=64k -s size=16k /dev/ram0
....
# mount /dev/ram0 /mnt/test
[  692.564375] XFS (ram0): Cannot set_blocksize to 16384 on device ram0
<mount fails>
#

Now expected. I wonder if the problem is 512 byte sector sizes....

# mkfs.xfs -f -s size=4k -b size=64k /dev/ram0
meta-data=/dev/ram0              isize=512    agcount=4, agsize=32000 blks
         =                       sectsz=4096  attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=1    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=65536  blocks=128000, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=65536  ascii-ci=0, ftype=1
log      =internal log           bsize=65536  blocks=1024, version=2
         =                       sectsz=4096  sunit=1 blks, lazy-count=1
realtime =none                   extsz=65536  blocks=0, rtextents=0
# mount /dev/ram0 /mnt/test
[  835.711473] XFS (ram0): Mounting V5 Filesystem 72743c95-1264-43cd-8867-1f2b2e30ba24
[  835.722700] XFS (ram0): Ending clean mount
#

Okay, there we go. The patchset appears to have some kind of problem
with the filesystem using the minimum logical sector size of 512
bytes on this modified driver. Setting sector size == PAGE_SIZE
allows the filesystem to mount, but brd should not break if logical
sector aligned/sized IO is done.

$ sudo xfs_io -f -d -c "pwrite -b 1M 0 1M" -c "pread -v 0 1M" /mnt/test/foo
wrote 1048576/1048576 bytes at offset 0
1 MiB, 1 ops; 0.0004 sec (2.266 GiB/sec and 2320.1856 ops/sec)
.....
000ffff0:  cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd cd  ................
read 1048576/1048576 bytes at offset 0
1 MiB, 16 ops; 0.9233 sec (1.083 MiB/sec and 17.3284 ops/sec)
$

Ok, direct IO works just fine.

$ xfs_io -c "pwrite -S 0xaa -b 1M 0 1M" -c "pread 0 1M -v" /mnt/test/foo
.....
000ffff0:  aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa aa  ................
read 1048576/1048576 bytes at offset 0
1 MiB, 16 ops; 0.7035 sec (1.421 MiB/sec and 22.7428 ops/sec)
$

Ok, well aligned buffered IO looks like it works.

Right, let's step it up and do some more complex stuff. Let's run a
basic fsx pass on the filesystem:


$ sudo ~/src/xfstests-dev/ltp/fsx -d /mnt/test/baz
Seed set to 1
main: filesystem does not support dedupe range, disabling!
main: filesystem does not support exchange range, disabling!
truncating to largest ever: 0x3aea7
2 trunc from 0x0 to 0x3aea7
3 copy  from 0x1a3d6 to 0x26608, (0xc232 bytes) at 0x2ea8c
Segmentation fault
$

And there's the boom, only 3 operations into the test. This is kinda
what I expected - getting fsx to run for billions of ops without
failure might take a while.

Huh, why did it say FIDEDUPERANGE was not supported - that's weird,
something is broken there, maybe the fsx test.

[ 1787.365339] ------------[ cut here ]------------
[ 1787.368623] kernel BUG at include/linux/pagemap.h:1248!
[ 1787.371488] invalid opcode: 0000 [#1] PREEMPT SMP
[ 1787.374814] CPU: 10 PID: 5153 Comm: fsx Not tainted 6.4.0-rc6-dgc+ #1832
[ 1787.377240] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[ 1787.383061] RIP: 0010:read_pages+0x11d/0x230
[ 1787.385268] Code: 4c 89 e7 e8 c5 14 ff ff f0 41 ff 4c 24 34 0f 85 55 ff ff ff 4c 89 e7 e8 61 1d 00 00 8b 73 24 8b 43 20 39 f0 0f 83 4d ff ff ff <0f> 0b 0
[ 1787.395078] RSP: 0018:ffffc90004113918 EFLAGS: 00010283
[ 1787.396636] RAX: 0000000000000001 RBX: ffffc90004113ab0 RCX: 0000000000000000
[ 1787.400357] RDX: 0000000000001000 RSI: 0000000000000010 RDI: ffffea0017421000
[ 1787.403989] RBP: ffffc90004113960 R08: 0000000000001000 R09: 0000000000000000
[ 1787.407915] R10: ffff8885d084a000 R11: ffffc900041137d8 R12: ffffffff822b2e60
[ 1787.411472] R13: 000000000000001b R14: ffffea0017421000 R15: ffff8885c0cc8318
[ 1787.415342] FS:  00007f96c86fcc40(0000) GS:ffff8885fed00000(0000) knlGS:0000000000000000
[ 1787.418404] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1787.420717] CR2: 000055ecf4289908 CR3: 00000005feceb001 CR4: 0000000000060ee0
[ 1787.423110] Call Trace:
[ 1787.424214]  <TASK>
[ 1787.425606]  ? show_regs+0x61/0x70
[ 1787.426568]  ? die+0x37/0x90
[ 1787.427584]  ? do_trap+0xec/0x100
[ 1787.428959]  ? do_error_trap+0x6c/0x90
[ 1787.430672]  ? read_pages+0x11d/0x230
[ 1787.432259]  ? exc_invalid_op+0x52/0x70
[ 1787.433312]  ? read_pages+0x11d/0x230
[ 1787.434544]  ? asm_exc_invalid_op+0x1b/0x20
[ 1787.436038]  ? read_pages+0x11d/0x230
[ 1787.437442]  ? read_pages+0x5c/0x230
[ 1787.438943]  page_cache_ra_unbounded+0x128/0x1b0
[ 1787.440419]  do_page_cache_ra+0x6c/0x70
[ 1787.441765]  ondemand_readahead+0x31f/0x350
[ 1787.443426]  page_cache_sync_ra+0x49/0x50
[ 1787.445070]  filemap_get_pages+0x10e/0x680
[ 1787.446259]  ? xfs_ilock+0xc1/0x220
[ 1787.447426]  filemap_read+0xed/0x380
[ 1787.448632]  ? kmem_cache_free+0x1f5/0x480
[ 1787.449926]  ? xfs_log_ticket_put+0x2f/0x60
[ 1787.451152]  ? xfs_inode_item_release+0x2e/0xa0
[ 1787.453128]  generic_file_read_iter+0xdb/0x160
[ 1787.454527]  xfs_file_buffered_read+0x54/0xd0
[ 1787.455894]  xfs_file_read_iter+0x74/0xe0
[ 1787.457544]  generic_file_splice_read+0x8c/0x150
[ 1787.460094]  do_splice_to+0x85/0xb0
[ 1787.461285]  splice_direct_to_actor+0xb3/0x210
[ 1787.462336]  ? pipe_to_sendpage+0xa0/0xa0
[ 1787.463287]  do_splice_direct+0x92/0xd0
[ 1787.464203]  vfs_copy_file_range+0x2af/0x560
[ 1787.465229]  __do_sys_copy_file_range+0xe3/0x1f0
[ 1787.466429]  __x64_sys_copy_file_range+0x24/0x30
[ 1787.468053]  do_syscall_64+0x34/0x80
[ 1787.469392]  entry_SYSCALL_64_after_hwframe+0x63/0xcd

static inline struct folio *__readahead_folio(struct readahead_control *ractl)
{
        struct folio *folio;

>>>>>   BUG_ON(ractl->_batch_count > ractl->_nr_pages);
        ractl->_nr_pages -= ractl->_batch_count;
        ractl->_index += ractl->_batch_count;

....

So something is going wrong in the readahead path from a splice
operation from copy_file_range().

..... Wait, what?

Why is it splicing rather than doing a remap operation?  'cp
--reflink=always bar bar2' appears to work fine, so it's unexpected
that it's copying data rather than cloning extents. Something is
going wrong there...

.....

Ok, that's enough time spent on this right now. The BS > PS stuff in
this patchset doesn't allow filesystems to work correctly, 
and the reasons for things going wrong are not obvious.

I suspect that this is going to take quite some work just to muscle
through all these whacky corner cases - fsx will find a lot of
them; you'll need to work through them until it runs without fail
for a couple of billion ops.

The patch I was using is below.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

xfs: support block size > page size

From: Dave Chinner <dchinner@redhat.com>

Everything is supposed to work, so turn on the BOOM.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 drivers/block/brd.c |  2 +-
 fs/xfs/xfs_mount.c  |  4 +++-
 fs/xfs/xfs_super.c  | 12 ------------
 3 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index a9f3c6591e75..e6e4f31bfcf5 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -314,7 +314,7 @@ static int max_part = 1;
 module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
-static unsigned int rd_blksize = PAGE_SIZE;
+static unsigned int rd_blksize = 65536;
 module_param(rd_blksize, uint, 0444);
 MODULE_PARM_DESC(rd_blksize, "Blocksize of each RAM disk in bytes.");
 
diff --git a/fs/xfs/xfs_mount.c b/fs/xfs/xfs_mount.c
index fb87ffb48f7f..921acd02787c 100644
--- a/fs/xfs/xfs_mount.c
+++ b/fs/xfs/xfs_mount.c
@@ -130,10 +130,12 @@ xfs_sb_validate_fsb_count(
 	xfs_sb_t	*sbp,
 	uint64_t	nblocks)
 {
-	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
 	ASSERT(sbp->sb_blocklog >= BBSHIFT);
 
 	/* Limited by ULONG_MAX of page cache index */
+	if (sbp->sb_blocklog > PAGE_SHIFT &&
+	    (nblocks << (sbp->sb_blocklog - PAGE_SHIFT) > ULONG_MAX))
+		return -EFBIG;
 	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
 		return -EFBIG;
 	return 0;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 4120bd1cba90..3c2fc203a5c0 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1583,18 +1583,6 @@ xfs_fs_fill_super(
 		goto out_free_sb;
 	}
 
-	/*
-	 * Until this is fixed only page-sized or smaller data blocks work.
-	 */
-	if (mp->m_sb.sb_blocksize > PAGE_SIZE) {
-		xfs_warn(mp,
-		"File system with blocksize %d bytes. "
-		"Only pagesize (%ld) or less will currently work.",
-				mp->m_sb.sb_blocksize, PAGE_SIZE);
-		error = -ENOSYS;
-		goto out_free_sb;
-	}
-
 	/* Ensure this filesystem fits in the page cache limits */
 	if (xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_dblocks) ||
 	    xfs_sb_validate_fsb_count(&mp->m_sb, mp->m_sb.sb_rblocks)) {
