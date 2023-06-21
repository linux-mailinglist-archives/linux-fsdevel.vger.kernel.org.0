Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7428D737C3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 09:36:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbjFUHHZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 03:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjFUHHV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:07:21 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54C6510FF
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 00:07:20 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-666ecf9a0ceso2880507b3a.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jun 2023 00:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687331240; x=1689923240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/3ivr0Uvn0xo4yZRSVF9o5KFsPxbHD7ljE2Fq2Q7Rk=;
        b=lvrWyMcx2apWGaapBurs7DV5QSCM2IAD3pfwIHVgQqNlyu0EXcveUaQhahvHw6bsiN
         IulOjmltLeqcV2UH+hw4chi/kRCzevakgKNE7YywkvcYtMXtshuoEgjlOgE6ia9fhhz2
         JgbUyWOoDLdj8/b1EXWdcIgf8KmHhmujLmLVLmZrdyOYaF3vXLuzHuAUYPh/OmdW+JRq
         zu5LSPqbiYG7YFMh+0ZNnzKGIpBxYdtwDXMe2SbMScyGEsH3puCaZN2/X5DU65wV5DXZ
         AjspeCQM4ZbTKXYF+OWAhTCrHvI4u9AuuOIA+j/APGCF3Ss8GvXKQFLATdj+0B10vISQ
         1A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687331240; x=1689923240;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/3ivr0Uvn0xo4yZRSVF9o5KFsPxbHD7ljE2Fq2Q7Rk=;
        b=K9GZldnLPD06AFpsHpqa/3IEQJCKs/DXhXWhXV3soMSsxAyE/PC6pDHw7RJEMSXeal
         p3m9uSW1CtJv50+tYQqe4Kgvb2gRITZ1tbCkSBwDTyPqy4DC/RFBiNuhANY+hh8Mj3N8
         aRMpv8AfQvNxJlvqWxLBcLL/QdK8gtx4mTCH/QW++sDcxYrmD9of2pvTtBDCpz2v+ZDq
         jfuhEdVT04zzu1FDWCfqNjcRofnmLElb20clGG3CxnDwe4+UCxULSKFe7ZrPHvVjABVG
         8g/10VSpD27xshamgMxUQOFji4Qc/GGhtyte3pM1AK910dtWaH9PRoQTlaTIgzgN4ovo
         LlOw==
X-Gm-Message-State: AC+VfDwe1C94iITtWwqG9IdYWLbLqi1Q2I2WZDPP8kmZHn96iCbFYZ1y
        ZXcoJYEWwyih5iMItNGsQxHeOA==
X-Google-Smtp-Source: ACHHUZ7sTBcKKL8tWbHKZpuD9Of59X+aEk+5qQmG01kJeoc4kPDbdLKuWxz/OcFotfXBZlCRgbQ8Xg==
X-Received: by 2002:a05:6a21:7890:b0:11f:1aa2:666b with SMTP id bf16-20020a056a21789000b0011f1aa2666bmr12943224pzc.32.1687331239730;
        Wed, 21 Jun 2023 00:07:19 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78551000000b0064d47cd116esm2298187pfn.161.2023.06.21.00.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 00:07:18 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qBrvv-00EMGg-14;
        Wed, 21 Jun 2023 17:07:15 +1000
Date:   Wed, 21 Jun 2023 17:07:15 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>
Cc:     dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
Message-ID: <ZJKhoxnkNF3VspbP@dread.disaster.area>
References: <000000000000ffcb2e05fe9a445c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ffcb2e05fe9a445c@google.com>
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:10:19PM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=158b99d3280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
> dashboard link: https://syzkaller.appspot.com/bug?extid=9d0b0d54a8bd799f6ae4
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab4537280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148326ef280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/2dc89d5fee38/disk-40f71e7c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/0ced5a475218/vmlinux-40f71e7c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d543a4f69684/bzImage-40f71e7c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/e2012b787a31/mount_0.gz
> 
> The issue was bisected to:
> 
> commit e0a8de7da35e5b22b44fa1013ccc0716e17b0c14
> Author: Dave Chinner <dchinner@redhat.com>
> Date:   Mon Jun 5 04:48:15 2023 +0000
> 
>     xfs: fix agf/agfl verification on v4 filesystems
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10bb665b280000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=12bb665b280000
> console output: https://syzkaller.appspot.com/x/log.txt?x=14bb665b280000

WTAF?

> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com
> Fixes: e0a8de7da35e ("xfs: fix agf/agfl verification on v4 filesystems")
> 
> XFS (loop0): WARNING: Reset corrupted AGFL on AG 0. 4 blocks leaked. Please unmount and run xfs_repair.
> XFS (loop0): Internal error !ino_ok at line 213 of file fs/xfs/libxfs/xfs_dir2.c.  Caller xfs_dir_ino_validate+0x2c/0x90 fs/xfs/libxfs/xfs_dir2.c:220
> CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> Workqueue: xfs_iwalk-4998 xfs_pwork_work
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>  xfs_error_report fs/xfs/xfs_error.c:384 [inline]
>  xfs_corruption_error+0x11d/0x170 fs/xfs/xfs_error.c:401
>  xfs_dir_ino_validate+0x5f/0x90 fs/xfs/libxfs/xfs_dir2.c:213
>  xfs_dir2_sf_verify+0x487/0x990 fs/xfs/libxfs/xfs_dir2_sf.c:779
>  xfs_ifork_verify_local_data fs/xfs/libxfs/xfs_inode_fork.c:706 [inline]
>  xfs_iformat_data_fork+0x4bf/0x6d0 fs/xfs/libxfs/xfs_inode_fork.c:256
>  xfs_inode_from_disk+0xbbf/0x1070 fs/xfs/libxfs/xfs_inode_buf.c:245
>  xfs_iget_cache_miss fs/xfs/xfs_icache.c:639 [inline]
>  xfs_iget+0xf08/0x3050 fs/xfs/xfs_icache.c:777
>  xfs_qm_dqusage_adjust+0x228/0x670 fs/xfs/xfs_qm.c:1157
>  xfs_iwalk_ag_recs+0x486/0x7c0 fs/xfs/xfs_iwalk.c:220
>  xfs_iwalk_run_callbacks+0x25b/0x490 fs/xfs/xfs_iwalk.c:376
>  xfs_iwalk_ag+0xad6/0xbd0 fs/xfs/xfs_iwalk.c:482
>  xfs_iwalk_ag_work+0xfb/0x1b0 fs/xfs/xfs_iwalk.c:624
>  xfs_pwork_work+0x7c/0x190 fs/xfs/xfs_pwork.c:47
>  process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
>  worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
>  kthread+0x2b8/0x350 kernel/kthread.c:379
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
>  </TASK>
> XFS (loop0): Corruption detected. Unmount and run xfs_repair
> XFS (loop0): Invalid inode number 0x24
> XFS (loop0): Metadata corruption detected at xfs_dir2_sf_verify+0x767/0x990 fs/xfs/libxfs/xfs_dir2_sf.c:774, inode 0x23 data fork
> XFS (loop0): Unmount and run xfs_repair
> XFS (loop0): First 32 bytes of corrupted metadata buffer:
> 00000000: 02 00 00 00 00 20 05 00 30 66 69 6c 65 30 01 00  ..... ..0file0..

syzbot corrupted a v4 filesystem.

Syzbot corrupted the superblock, XFS detected and corrected that.

Syzbot corrupted the AGI. XFS detected that.

Syzbot corrupted the AGF and AGFL. XFS detected and corrected that,
allowing operations to continue.

Syzbot also corrupted a directory inode. XFS detected that and
warned about it.

Test finished.

At no point did the kernel crash, oops, do anything bad like a UAF
or OOB read. All XFS did was catch the corruptions, fix some of them
so it could continue operating, and warn the user that they need to
unmount and run repair.

So exactly what is syzbot complaining about here? There's no kernel
issue here at all.

Also, I cannot tell syzbot "don't ever report this as a bug again",
so the syzbot developers are going to have to triage and fix this
syzbot problem themselves so it doesn't keep getting reported to
us...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
