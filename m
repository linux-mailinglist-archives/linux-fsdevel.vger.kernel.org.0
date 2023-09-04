Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10731791386
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 10:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352575AbjIDId6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Sep 2023 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbjIDId5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:33:57 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74960CDA
        for <linux-fsdevel@vger.kernel.org>; Mon,  4 Sep 2023 01:33:45 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1c0d0bf18d7so4885335ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 04 Sep 2023 01:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1693816425; x=1694421225; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MDxq47lH4J+ZR6XRwDVJfrN/aEh66horqS8Q0LZlj/Y=;
        b=jHDoXqGY9gRfpJMPzXqWSsH41D2SACS9E3O7KaNjwpxtyV4g+1cg/H5wpj9+QTeVra
         L3veVnhsmRWR8Cj06OExdWruUlXs6pU91FhiZnAdlm3Sz/aNjVPR+CQWPXGMSNaecQYe
         ko1SCQKvDRyXaAnHqgTUD96vQgzh5j7+2SyG1gE97eI/siKhjWeFJVeJ+fd00V5TIBV1
         6En8HlLtoaoWIu62RSeLZJoczjl4hrfwt4Evv2Xtnr3IH4ukrARlaw/53S8KanKJ2G76
         556guymSh32HKnmuA6t4SH6shJ0SjD7CdnewroqQ8dDU2fFn2p1H6jG5ZMyheBRt3qcI
         oM7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693816425; x=1694421225;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MDxq47lH4J+ZR6XRwDVJfrN/aEh66horqS8Q0LZlj/Y=;
        b=MZEfhHi/0/SHyLUh/92boe3y4sO8zREZXyHPTazt1MdQ/2uZ16IUPCnWscMVnf8Yni
         WJmVKdG6D1r9KyJjZHQ5buziVTa+rgYWDEwYVaBRd6WkBEBApMKSIsPOwQMYdL2w9zmI
         +JmjqERnvv1kLQwTKfztN3gYXK9gxdoueDhcjiz0W9uGhHD0wt/+CpOAtX3wmZfUPBf5
         a0lqazwZAW0AnZ/6uB2c1DOhAwEYyQKXLk+Fz/YjD4gNn6meHUMa2d3qCwP7sSHvKNFu
         Qk81/tJPDNSmKUpcNkbacuuSBPtjCvDMF5aM4tg3oA+7ppghiABoxqC78W9ZZAwHCkpp
         HPBg==
X-Gm-Message-State: AOJu0Yz4t79K6J8qWq7fgsrRlU7LgafRxkmlZPJr8tHVGrzKqAfOqF7f
        Mq9noow91aNaHcIgHos9DwL6nQ==
X-Google-Smtp-Source: AGHT+IFuLko3syhAxHbcZ/yTXMg91Gpq3n/9bGTpOnxZtJRpzZtVFlK/HE8nPar+ChyaqrvrAomZ5g==
X-Received: by 2002:a17:902:76c3:b0:1bc:2c83:f770 with SMTP id j3-20020a17090276c300b001bc2c83f770mr6455033plt.45.1693816424756;
        Mon, 04 Sep 2023 01:33:44 -0700 (PDT)
Received: from dread.disaster.area (pa49-195-66-88.pa.nsw.optusnet.com.au. [49.195.66.88])
        by smtp.gmail.com with ESMTPSA id f21-20020a170902e99500b001bdd7579b5dsm7041065plb.240.2023.09.04.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 01:33:44 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qd51h-00Adiy-0S;
        Mon, 04 Sep 2023 18:33:41 +1000
Date:   Mon, 4 Sep 2023 18:33:41 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, djwong@kernel.org,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        song@kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu,
        yukuai3@huawei.com, zhang_shurong@foxmail.com,
        linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: [syzbot] [xfs?] [ext4?] kernel BUG in __block_write_begin_int
Message-ID: <ZPWWZeWliX7RhOAZ@dread.disaster.area>
References: <000000000000e76944060483798d@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000e76944060483798d@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[cc linux-block, Christoph]

On Mon, Sep 04, 2023 at 12:29:52AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    0468be89b3fa Merge tag 'iommu-updates-v6.6' of git://git.k..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=11145910680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3d78b3780d210e21
> dashboard link: https://syzkaller.appspot.com/bug?extid=4a08ffdf3667b36650a1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164f7a57a80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143b0298680000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f3914b539822/disk-0468be89.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6128b0644784/vmlinux-0468be89.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/349d98668c3a/bzImage-0468be89.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/75bd68910fd4/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 8b0472b50bcf0f19a5119b00a53b63579c8e1e4d
> Author: Zhang Shurong <zhang_shurong@foxmail.com>
> Date:   Sat Jul 22 07:53:53 2023 +0000
> 
>     md: raid1: fix potential OOB in raid1_remove_disk()

Bisect is broken. That has nothing to do with the block device
conversion to use iomap that triggered this.

The commit that made this change was 487c607df790 ("block: use iomap
for writes to block devices"), and that's why we're getting a
BUG_ON() being triggered in iomap_to_bh()....

> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e52577a80000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=15e52577a80000
> console output: https://syzkaller.appspot.com/x/log.txt?x=11e52577a80000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+4a08ffdf3667b36650a1@syzkaller.appspotmail.com
> Fixes: 8b0472b50bcf ("md: raid1: fix potential OOB in raid1_remove_disk()")
> 
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:2028!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> CPU: 0 PID: 5187 Comm: syz-executor424 Not tainted 6.5.0-syzkaller-10885-g0468be89b3fa #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/26/2023
> RIP: 0010:iomap_to_bh fs/buffer.c:2028 [inline]
> RIP: 0010:__block_write_begin_int+0x18f7/0x1a40 fs/buffer.c:2111
> Code: af 0d 85 ff 48 8b 7c 24 08 48 c7 c6 20 22 18 8b e8 6e 8b c6 ff 0f 0b e8 97 0d 85 ff eb 13 e8 90 0d 85 ff eb c7 e8 89 0d 85 ff <0f> 0b e8 82 0d 85 ff 48 8b 7c 24 08 48 c7 c6 20 22 18 8b e8 41 8b
> RSP: 0018:ffffc9000418f520 EFLAGS: 00010293
> RAX: ffffffff82087b37 RBX: 0000000000040000 RCX: ffff888078093b80
> RDX: 0000000000000000 RSI: 0000000000040000 RDI: 00000000000d0000
> RBP: ffffc9000418f6b0 R08: ffffffff82086ba2 R09: 1ffff1100f27203a
> R10: dffffc0000000000 R11: ffffed100f27203b R12: 00000000000d0000
> R13: 0000000000000400 R14: 0000000000000000 R15: ffff8880793901d0
> FS:  00007f0623ec56c0(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000020040000 CR3: 0000000067478000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  iomap_write_begin+0xaf6/0x1f00 fs/iomap/buffered-io.c:772
>  iomap_write_iter fs/iomap/buffered-io.c:907 [inline]
>  iomap_file_buffered_write+0x587/0x1020 fs/iomap/buffered-io.c:968
>  blkdev_buffered_write block/fops.c:634 [inline]
>  blkdev_write_iter+0x41d/0x5c0 block/fops.c:688
>  call_write_iter include/linux/fs.h:1985 [inline]
>  new_sync_write fs/read_write.c:491 [inline]
>  vfs_write+0x782/0xaf0 fs/read_write.c:584
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:637
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd

It appears that 0010:__block_write_begin_int() has iterated beyond
the iomap that was passed in, triggering the BUG_ON() check in
iomap_to_bh().

Definitely not an XFS problem. Most likely not an ext4 problem.
It appears to be related to syzbot trying to modify the block device
under a mounted ext4 filesystem given the reproducer involves
mounting an ext4 filesystem, then the process that mounted the ext4
filesystem hits a BUG_ON trying to write to a block device.

Certainly seems like a block device problem, though, given
the new iomap write path in the block device merged in the 6.6-rc1 window.

#syz set subsystems: block

-Dave.
-- 
Dave Chinner
david@fromorbit.com
