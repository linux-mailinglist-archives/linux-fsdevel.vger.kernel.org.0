Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED27E4A769E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Feb 2022 18:15:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346177AbiBBRP1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Feb 2022 12:15:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBBRP1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:15:27 -0500
Received: from mail-ua1-x92f.google.com (mail-ua1-x92f.google.com [IPv6:2607:f8b0:4864:20::92f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E328AC061714;
        Wed,  2 Feb 2022 09:15:26 -0800 (PST)
Received: by mail-ua1-x92f.google.com with SMTP id m90so445881uam.2;
        Wed, 02 Feb 2022 09:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2/VSjT23LlHP8K4b90Xh7vZYdJE6g4XvQeOYow5yDFU=;
        b=DvTyzXe4kpxaG0jnsq4uJBR5DX+ZmAGPvEfaV4lTsWjmdgqyy/ZLrekxQvmMln3AfV
         rpi69GS78UXYYzpO1eDTBEfl8weuEVMr/AX8vH767Z8MBEn3fZ80QP+kPyk58UTpdKOk
         EBZfZttAN+m6Xv/qhjcqPpHchVUE87mp7f/E7zgCyu4qSR++okzD6gcW3SfnYGetubyU
         ccYokXDkGU/Kk+gI5+SK9A+4NFqLQB19ZsQHLrNFUWr4vkD/YxATxjpMSpyNxx5l98X1
         HS1rddEVVENgYLaYlAsZdZL8EtTZO+ZhyPHE4nRBJB7DM4wqk1DGKbvE23nn/Nia25AG
         Bgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=2/VSjT23LlHP8K4b90Xh7vZYdJE6g4XvQeOYow5yDFU=;
        b=nkZJ4OprzojwvILSXLca0bp7Ln0TYzgsEWjPAZsGr5wtvZTFDaSZPcgnYp3Dvfz+Gy
         hk6CSJn2MwmigQmSul4IbfNVrmMc6CGGmcC3pEkUflrluuvZgqhJx6vxAooWq7rSqy//
         Vl4BsMf+1u852IjWz4HDY+mpOFRmx0y/mI4wguCqQInoTVeiERFm1Ce6SPyzzI39PCje
         GZfjP1Q/yRya6B+K2Mo8xBLAinHvtCWapZeu8r2rWf+ibmiEbslvNimzX/jHKKFMn2zL
         ow0UJm1f8pQFMUncPrUu0kKNGTwLWDI+bZ9a+DWE03Mbt2ufdBLU6U4luFeKcYkxzeqc
         DTow==
X-Gm-Message-State: AOAM530sevRMQNeHAJle/CCmnasBdYrjQv/Hw5KXApki0vpeu0WGI4wA
        B4ux2lwM8rKa3iu7Q9Xy9nHPTFM7aA7OsiAFgPAWZouQPVFP2JOj
X-Google-Smtp-Source: ABdhPJy0OBeoicWhl5HNNFV+5QRuaUA3OfPUAID1UXEgiMTKYIdXTwygJuZu69La0ua+52KpLtUBANhH76Jh9QNtboI=
X-Received: by 2002:a67:e005:: with SMTP id c5mr12015669vsl.70.1643822125838;
 Wed, 02 Feb 2022 09:15:25 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?B?RMSBdmlzIE1vc8SBbnM=?= <davispuh@gmail.com>
Date:   Wed, 2 Feb 2022 19:15:14 +0200
Message-ID: <CAOE4rSwfTEaJ_O9Bv1CkLRnLWYoZ7NSS=5pzuQz4mUBE-PXQ5A@mail.gmail.com>
Subject: How to debug stuck read?
To:     BTRFS <linux-btrfs@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
        kernelnewbies@kernelnewbies.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I have a corrupted file on BTRFS which has CoW disabled thus no
checksum. Trying to read this file causes the process to get stuck
forever. It doesn't return EIO.

How can I find out why it gets stuck?

$ ddrescue -b 1 currupted_file /tmp/temp
GNU ddrescue 1.26
Press Ctrl-C to interrupt
    ipos:        0 B, non-trimmed:        0 B,  current rate:       0 B/s
    opos:        0 B, non-scraped:        0 B,  average rate:       0 B/s
non-tried:    8388 kB,  bad-sector:        0 B,    error rate:       0 B/s
 rescued:        0 B,   bad areas:        0,        run time:          0s
pct rescued:    0.00%, read errors:        0,  remaining time:         n/a
                             time since last successful read:         n/a
Copying non-tried blocks... Pass 1 (forwards)
^C
// doesn't stop with Ctrl+C nor SIGTERM

$ gdb -q -p 3449
Attaching to process 3449
^C
// same gets stuck

$ cat /proc/3449/stack | ./scripts/decode_stacktrace.sh vmlinux
folio_wait_bit_common (mm/filemap.c:1314)
filemap_get_pages (mm/filemap.c:2622)
filemap_read (mm/filemap.c:2676)
new_sync_read (fs/read_write.c:401 (discriminator 1))
vfs_read (fs/read_write.c:481)
ksys_read (fs/read_write.c:619)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)


I enabled
CONFIG_BTRFS_DEBUG=3Dy
CONFIG_BTRFS_ASSERT=3Dy
CONFIG_LOCKDEP_SUPPORT=3Dy
CONFIG_LOCKDEP=3Dy
CONFIG_LOCKUP_DETECTOR=3Dy
CONFIG_SOFTLOCKUP_DETECTOR=3Dy
CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
CONFIG_PROVE_LOCKING=3Dy
CONFIG_DEBUG_SPINLOCK=3Dy
CONFIG_DEBUG_LOCK_ALLOC=3Dy

but in dmesg only thing that shows up is a lot of
BTRFS error (device sdh): invalid lzo header, lzo len 2937060802
compressed len 4096

If I try to do btrfs send, it gets stuck same way
$ btrfs send -v /mnt/fs > /dev/null

$ cat /proc/4712/stack | ./scripts/decode_stacktrace.sh vmlinux
folio_wait_bit_common (mm/filemap.c:1314)
__filemap_get_folio (mm/filemap.c:1690 ./include/linux/pagemap.h:779
mm/filemap.c:1960)
pagecache_get_page (mm/folio-compat.c:126)
send_extent_data (fs/btrfs/send.c:4980 fs/btrfs/send.c:5048
fs/btrfs/send.c:5235) btrfs
process_extent (fs/btrfs/send.c:5575 fs/btrfs/send.c:5959) btrfs
btrfs_ioctl_send (fs/btrfs/send.c:6770 fs/btrfs/send.c:7368
fs/btrfs/send.c:7688) btrfs
_btrfs_ioctl_send (fs/btrfs/ioctl.c:4963) btrfs
btrfs_ioctl (fs/btrfs/ioctl.c:5072) btrfs
__x64_sys_ioctl (fs/ioctl.c:52 fs/ioctl.c:874 fs/ioctl.c:860 fs/ioctl.c:860=
)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:113)

I'm now using 5.17.0-rc2 but it's exactly same with 5.16.5

Thanks!

Best regards,
D=C4=81vis
