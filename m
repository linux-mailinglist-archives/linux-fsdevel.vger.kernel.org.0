Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D025737CE5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jun 2023 10:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbjFUHy0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 21 Jun 2023 03:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbjFUHyZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 21 Jun 2023 03:54:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2891B1BC;
        Wed, 21 Jun 2023 00:54:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9AA9C6149D;
        Wed, 21 Jun 2023 07:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACAFBC433C0;
        Wed, 21 Jun 2023 07:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687334063;
        bh=752cHcSfOaa6JXjMJhj8pGyWTZDxoRYLEzUL0z2u63w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mVvZ/3zznpvFSIRwCvxgmlDqlcLAGJZvuTbON6Y837qbqxsndreEoDdjSGcC/dTSL
         qcbe2SwyysizHvpfOE1gl7wM1J2cRYd/kB3F+X54giT1schOWHoaxjdUcWNdKjzuoR
         30/qh+sU4UyayVlqdFDLRUYFpMDijBtUeBWCod9PUBujpyzdBpYrqJSarEH7rf7OEb
         fztYiiHGMo3pl0ZpCQjxoWiUwyLVydzu6ARAUDhpcDJGFmvHA/aCjlAH8gl5iPDODr
         ecP7TztayLrcdDn6BUG4wnRft3kJBol0Td7oUp6svdQKXICXjq7Xh/IooFL2BwVV+p
         xgt1B2YOUABgQ==
Date:   Wed, 21 Jun 2023 00:54:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com>,
        dchinner@redhat.com, djwong@kernel.org, hch@lst.de,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] WARNING: Reset corrupted AGFL on AG NUM. NUM
 blocks leaked. Please unmount and run xfs_repair.
Message-ID: <20230621075421.GA56560@sol.localdomain>
References: <000000000000ffcb2e05fe9a445c@google.com>
 <ZJKhoxnkNF3VspbP@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJKhoxnkNF3VspbP@dread.disaster.area>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Dave,

On Wed, Jun 21, 2023 at 05:07:15PM +1000, 'Dave Chinner' via syzkaller-bugs wrote:
> On Tue, Jun 20, 2023 at 07:10:19PM -0700, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    40f71e7cd3c6 Merge tag 'net-6.4-rc7' of git://git.kernel.o..
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=158b99d3280000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=7ff8f87c7ab0e04e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=9d0b0d54a8bd799f6ae4
> > compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ab4537280000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148326ef280000
> > 
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/2dc89d5fee38/disk-40f71e7c.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/0ced5a475218/vmlinux-40f71e7c.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/d543a4f69684/bzImage-40f71e7c.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/e2012b787a31/mount_0.gz
> > 
> > The issue was bisected to:
> > 
> > commit e0a8de7da35e5b22b44fa1013ccc0716e17b0c14
> > Author: Dave Chinner <dchinner@redhat.com>
> > Date:   Mon Jun 5 04:48:15 2023 +0000
> > 
> >     xfs: fix agf/agfl verification on v4 filesystems
> > 
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10bb665b280000
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=12bb665b280000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=14bb665b280000
> 
> WTAF?
> 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+9d0b0d54a8bd799f6ae4@syzkaller.appspotmail.com
> > Fixes: e0a8de7da35e ("xfs: fix agf/agfl verification on v4 filesystems")
> > 
> > XFS (loop0): WARNING: Reset corrupted AGFL on AG 0. 4 blocks leaked. Please unmount and run xfs_repair.
> > XFS (loop0): Internal error !ino_ok at line 213 of file fs/xfs/libxfs/xfs_dir2.c.  Caller xfs_dir_ino_validate+0x2c/0x90 fs/xfs/libxfs/xfs_dir2.c:220
> > CPU: 1 PID: 46 Comm: kworker/u4:3 Not tainted 6.4.0-rc6-syzkaller-00195-g40f71e7cd3c6 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/27/2023
> > Workqueue: xfs_iwalk-4998 xfs_pwork_work
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:88 [inline]
> >  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
> >  xfs_error_report fs/xfs/xfs_error.c:384 [inline]
> >  xfs_corruption_error+0x11d/0x170 fs/xfs/xfs_error.c:401
> >  xfs_dir_ino_validate+0x5f/0x90 fs/xfs/libxfs/xfs_dir2.c:213
> >  xfs_dir2_sf_verify+0x487/0x990 fs/xfs/libxfs/xfs_dir2_sf.c:779
> >  xfs_ifork_verify_local_data fs/xfs/libxfs/xfs_inode_fork.c:706 [inline]
> >  xfs_iformat_data_fork+0x4bf/0x6d0 fs/xfs/libxfs/xfs_inode_fork.c:256
> >  xfs_inode_from_disk+0xbbf/0x1070 fs/xfs/libxfs/xfs_inode_buf.c:245
> >  xfs_iget_cache_miss fs/xfs/xfs_icache.c:639 [inline]
> >  xfs_iget+0xf08/0x3050 fs/xfs/xfs_icache.c:777
> >  xfs_qm_dqusage_adjust+0x228/0x670 fs/xfs/xfs_qm.c:1157
> >  xfs_iwalk_ag_recs+0x486/0x7c0 fs/xfs/xfs_iwalk.c:220
> >  xfs_iwalk_run_callbacks+0x25b/0x490 fs/xfs/xfs_iwalk.c:376
> >  xfs_iwalk_ag+0xad6/0xbd0 fs/xfs/xfs_iwalk.c:482
> >  xfs_iwalk_ag_work+0xfb/0x1b0 fs/xfs/xfs_iwalk.c:624
> >  xfs_pwork_work+0x7c/0x190 fs/xfs/xfs_pwork.c:47
> >  process_one_work+0x8a0/0x10e0 kernel/workqueue.c:2405
> >  worker_thread+0xa63/0x1210 kernel/workqueue.c:2552
> >  kthread+0x2b8/0x350 kernel/kthread.c:379
> >  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
> >  </TASK>
> > XFS (loop0): Corruption detected. Unmount and run xfs_repair
> > XFS (loop0): Invalid inode number 0x24
> > XFS (loop0): Metadata corruption detected at xfs_dir2_sf_verify+0x767/0x990 fs/xfs/libxfs/xfs_dir2_sf.c:774, inode 0x23 data fork
> > XFS (loop0): Unmount and run xfs_repair
> > XFS (loop0): First 32 bytes of corrupted metadata buffer:
> > 00000000: 02 00 00 00 00 20 05 00 30 66 69 6c 65 30 01 00  ..... ..0file0..
> 
> syzbot corrupted a v4 filesystem.
> 
> Syzbot corrupted the superblock, XFS detected and corrected that.
> 
> Syzbot corrupted the AGI. XFS detected that.
> 
> Syzbot corrupted the AGF and AGFL. XFS detected and corrected that,
> allowing operations to continue.
> 
> Syzbot also corrupted a directory inode. XFS detected that and
> warned about it.
> 
> Test finished.
> 
> At no point did the kernel crash, oops, do anything bad like a UAF
> or OOB read. All XFS did was catch the corruptions, fix some of them
> so it could continue operating, and warn the user that they need to
> unmount and run repair.
> 
> So exactly what is syzbot complaining about here? There's no kernel
> issue here at all.
> 
> Also, I cannot tell syzbot "don't ever report this as a bug again",
> so the syzbot developers are going to have to triage and fix this
> syzbot problem themselves so it doesn't keep getting reported to
> us...

I think the problem here was that XFS logged a message beginning with
"WARNING:", followed by a stack trace.  In the log that looks like a warning
generated by the WARN_ON() macro, which is meant for reporting recoverable
kernel bugs.  It's difficult for any program to understand the log in cases like
this.  This is why include/asm-generic/bug.h contains the following comment:

 * Do not include "BUG"/"WARNING" in format strings manually to make these
 * conditions distinguishable from kernel issues.

If you have a constructive suggestion of how all programs that parse the kernel
log can identify real warnings reliably without getting confused by cases like
this, I'm sure that would be appreciated.  It would need to be documented and
then the guidance in bug.h could then be removed.  But until then, the above is
the current guidance.

- Eric
