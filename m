Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733F37349CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Jun 2023 03:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjFSBwR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Jun 2023 21:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjFSBwQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Jun 2023 21:52:16 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D3FBD
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 18:52:15 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-39ed11d6a50so618058b6e.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 18 Jun 2023 18:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1687139535; x=1689731535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=y0HdewFqYNfw5Jxe2MzOIpg2fQoQaMstEP/0eP1FzIo=;
        b=Kvk+6JStgD+T3vLboAGdC7I6gRd1y1qtW0W4iGqEuZHqI7jcLRfFHzRDQNVj6T9qM6
         lxgxIRar69qsT7/QH9vfAcL4WBVTLdFDZOjAlYlaB+ej7n4OgrS9joLYgCrqktJjysz0
         6F59etDPLOW29tFTNH5DeumtBTeFNl9bikMSGHZLmbDe4qMyND+d+lYzZOdr4VxUo3yJ
         KJ9WBSxvq7lxqyAeV5igBgG/ZxAMvyadUiuJGJj+6qjw8Z/+vO7SmzNpASBgDKjbp/BM
         TiOQMuMStI2zqYVU0n9idx4m8EZP8DyKZAIyHJBzuQ24neRM9v2G5E5GbNjIGorO/Uv1
         femg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687139535; x=1689731535;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y0HdewFqYNfw5Jxe2MzOIpg2fQoQaMstEP/0eP1FzIo=;
        b=cuVYM4o5SUjdAlH5q4+fD4SSYYZPZiLeWoB1ut4R5SJHEHMellZJapPT2x1ESS2Zyp
         0XAYnSCFO5VtjUdQQ3AqlaXugEqxrHal9EaN7tD9igO0coR4DUiKuDuVCYHv/QpCG/aI
         pawnL4pKfL7pw+p3rsKZDGwdiyXXEq92F0Gk/Ll7T3N8FEktqUFy7uBQ85ulxmmy3fQ+
         lPwKNF3D2UEHXSL7Lv5XbNkzihxfCThGtN8qFBDDS0uxi266E12kVH3jiM4iJgvV4U3N
         edHUjblzmO5GJaDo3TS+9IrSC3o42SOyH1NhjxXNLkPZKma7iwO/DF5IY7r8qbz/lsvC
         8J7w==
X-Gm-Message-State: AC+VfDzhCiuNXiPsRvNLqSfi3mYgsvjwarxC8c3GooBrqmx45yLBF/9B
        2BsQI4qvUV3ime1/vOxiL3m1Zg==
X-Google-Smtp-Source: ACHHUZ5qbz78riMP2Loam5VGkXbrUYuwQpD+CXejr+CTgGGnq4Io593wt0JxdkeDmwPnL6VgQzbIYw==
X-Received: by 2002:a05:6808:15a4:b0:39e:d344:b4c0 with SMTP id t36-20020a05680815a400b0039ed344b4c0mr3026443oiw.34.1687139534927;
        Sun, 18 Jun 2023 18:52:14 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-13-202.pa.nsw.optusnet.com.au. [49.180.13.202])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902e74e00b001b39e866324sm15469535plf.306.2023.06.18.18.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Jun 2023 18:52:14 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qB43u-00DTfc-2U;
        Mon, 19 Jun 2023 11:52:10 +1000
Date:   Mon, 19 Jun 2023 11:52:10 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     syzbot <syzbot+b7854dc75e15ffc8c2ae@syzkaller.appspotmail.com>
Cc:     djwong@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_pack_data
Message-ID: <ZI+0yi+V+ziqAQ3Z@dread.disaster.area>
References: <00000000000029729c05fe5c6f5c@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000029729c05fe5c6f5c@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 17, 2023 at 05:23:58P[   65.275181][ T4996] XFS (loop0): Deprecated V4 format (crc=0) will not be supported after September 2030.
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    15adb51c04cc Merge tag 'devicetree-fixes-for-6.4-3' of git..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=17554263280000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3731e922b1097b2e
> dashboard link: https://syzkaller.appspot.com/bug?extid=b7854dc75e15ffc8c2ae
> compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1323469d280000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12975795280000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/733f46de69b0/disk-15adb51c.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f9a6a2c566b8/vmlinux-15adb51c.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/55e80680ef0e/bzImage-15adb51c.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/99d5407c555b/mount_0.gz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b7854dc75e15ffc8c2ae@syzkaller.appspotmail.com

 XFS (loop0): Deprecated V4 format (crc=0) will not be supported after September 2030.
 XFS (loop0): Mounting V4 Filesystem acfebfcd-0806-4e27-9777-0ac4ff5ddf54
 XFS (loop0): Log size 756 blocks too small, minimum size is 2220 blocks
 XFS (loop0): Log size out of supported range.
 XFS (loop0): Continuing onwards, but if log hangs are experienced then please report this message in the bug report.
 XFS (loop0): Torn write (CRC failure) detected at log block 0x10. Truncating head block from 0x20.
 XFS (loop0): Ending clean mount
 xfs filesystem being mounted at /root/file0 supports timestamps until 2038-01-19 (0x7fffffff)
 XFS (loop0): Unmounting Filesystem acfebfcd-0806-4e27-9777-0ac4ff5ddf54

<sigh>

Still testing on v4 filesystems.

And with yet another invalid configuration - one that we
explicitly cannot fix for v4 filesystems, yet one that V5
filesystems will immediately reject.

So at this point, the problem "discovered" by syzbot will not
manifest on V5 formats at all.

> xfs filesystem being mounted at /root/file0 supports timestamps until 2038-01-19 (0x7fffffff)
> XFS (loop0): Unmounting Filesystem acfebfcd-0806-4e27-9777-0ac4ff5ddf54
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in xlog_pack_data+0x370/0x540 fs/xfs/xfs_log.c:1822
> Read of size 4 at addr ffff888075c64e00 by task syz-executor205/4996

And, yeah, the issue that is a too-small log on V4 filesystems skips
over other geometry checks (which will still be run on V5) and it's
one of those skipped geometry checks that causes the UAF.

Even if the log was not too small, the specific corruption
that caused the OOB read would have been caught at mount by a V5
filesystem and rejected before anything any attempt to write to the
log occurred.

So here we are again, with syzbot reporting a V4 filesystem issue
that just doesn't happen in the real world, and one that V5
filesystems detect and reject.

And, once again, I'm going to have to modify the code so that V4
filesystems reject stuff that v5 filesystems already reject, even
though no users are actually going to benefit from these changes:

 loop0: detected capacity change from 0 to 65536
 XFS (loop0): log stripe unit 151041 bytes must be a multiple of block size
 XFS (loop0): Metadata corruption detected at xfs_sb_read_verify+0x279/0x2a0, xfs_sb_quiet block 0x0 
 XFS (loop0): Unmount and run xfs_repair
 XFS (loop0): First 128 bytes of corrupted metadata buffer:
 00000000: 58 46 53 42 00 00 08 00 00 00 00 00 00 00 40 00  XFSB..........@.
 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
 00000020: ac fe bf cd 08 06 4e 27 97 77 0a c4 ff 5d df 54  ......N'.w...].T
 00000030: 00 00 00 00 00 00 20 04 00 00 00 00 00 00 00 10  ...... .........
 00000040: 00 00 00 00 00 00 00 11 00 00 00 00 00 00 00 12  ................
 00000050: 00 00 00 02 00 00 20 00 00 00 00 02 00 00 00 00  ...... .........
 00000060: 00 00 02 f4 b4 b4 02 00 04 00 00 02 00 00 00 00  ................
 00000070: 00 00 00 00 00 00 00 00 0b 09 0a 01 0d 00 00 05  ................

Can you please just stop testing V4 filesystems already?

-Dave.
-- 
Dave Chinner
david@fromorbit.com
