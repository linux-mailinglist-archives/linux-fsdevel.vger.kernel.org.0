Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 32DBE177178
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 09:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbgCCIpj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 03:45:39 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33219 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbgCCIpj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:45:39 -0500
Received: by mail-lf1-f68.google.com with SMTP id c20so2029922lfb.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Mar 2020 00:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=zUsO2nMCM9HhiGl3c+blkV/sJUEioZQL7RWJ6Sg9JxU=;
        b=vqB1iBHLkBD4wUmjvlLQvfF/SLBKh7Esz8WadNOSMsr9hQAVQ/XWaHqwLbNd0HM9uo
         OZzk/GFChVY+IC6rmxLI8jRZyYjU+zutSqTQYZ/OQPdC2ARoqGrc1DXDCC0iBR4Z2fkS
         GdivGwsfpiJ3TAyKJXcivV92m2p0vrOIvLR+Ya0ecL8Vxt1atKIWjBa7KXe2MpaiobXL
         R/z28l4DexE6qZRLp5Q6fTXlVhZu4L/B/ybHbJDrWP3B+UHy+fok7on18SyKKfjINPF/
         rbhxWkFTSqegYYaPWPc3o2AN30fAJG2rj9vUfk17976Ln/q3crARUHZbFboeMePhRI46
         Gz+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=zUsO2nMCM9HhiGl3c+blkV/sJUEioZQL7RWJ6Sg9JxU=;
        b=ADwscX38Z46RHoNH4E3BrMiyAS8NM750hs63c7e36R7Ehw2H4i6HBcqcIyxj18a4pS
         DPcMl+WnEk219mGfGfKqaVFFW/8u2GRNyUdiNqovylTWPpOh/CaWveejjs5t2s1wkA7o
         PF6bmiTjZ0BCdKmBWYVMWpSK2MCcxZdqY5AXA4kgSUW+xks/JxO6cCrfJ8FMICWVyeBQ
         o1U6hMFDAWyND4w1Lt9gGcDI6W0cqsU6CLHgRMyQolvoA+9MpCrQFCK4TuWn27b8wmjG
         T9vszB89/SaAzIa2BWPiDxc5AT2+bVhhGgmXD8hMGEtCLSdd+bdSRnKNSnvt2B7xaXEB
         4ZLw==
X-Gm-Message-State: ANhLgQ36OeKXbwCkF4ivXOyA+QbGNZD0cxa1fbS2N1SRVJ+iii8Osuqh
        N525vCBNNvZ656FgLCMPU2Oc9lK6Ebcs0yKlDO8rgWb0LaOhkA==
X-Google-Smtp-Source: ADFU+vsXA4t58U0AaanSATOsRmnvKEdms25FguKqsYCaaKaf1gkgQwMMWnC8G6EEojjD1DzrywKiB/u4TgSS+Qmzg74=
X-Received: by 2002:ac2:4467:: with SMTP id y7mr2120942lfl.167.1583225135820;
 Tue, 03 Mar 2020 00:45:35 -0800 (PST)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Tue, 3 Mar 2020 14:15:24 +0530
Message-ID: <CA+G9fYs==eMEmY_OpdhyCHO_1Z5f_M8CAQQTh-AOf5xAvBHKAQ@mail.gmail.com>
Subject: fs/buffer.c: WARNING: alloc_page_buffers while mke2fs
To:     linux-fsdevel@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Kara <jack@suse.cz>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Dmitry Vyukov <dvyukov@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@kernel.org>, ak@linux.intel.com,
        jlayton@redhat.com, tim.c.chen@linux.intel.com,
        willy@infradead.org, LTP List <ltp@lists.linux.it>,
        Jan Stancek <jstancek@redhat.com>, chrubis <chrubis@suse.cz>,
        lkft-triage@lists.linaro.org,
        Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[Sorry for the spam]

Linux-next 5.6.0-rc3-next-20200302 running on arm64 juno-r2 device while
running LTP syscalls chown tests.

Suspecting commits are (did not do git bisect),
b1473d5f3d0 fs/buffer.c: dump more info for __getblk_gfp() stall problem
b10a7ae6565 fs/buffer.c: add debug print for __getblk_gfp() stall problem

steps to reproduce:
-------------------
  - Boot kernel Linux-next 5.6.0-rc3-next-20200302 on arm64 device
  - cd /opt/ltp
  - ./runltp -s chown -I 10 -d /scratch -p -q

* /scratch is a mounted hard drive for LTP test files.

chown03_16    2  TCONF  :
/usr/src/debug/ltp/20190930-r0/git/testcases/kernel/syscalls/chown/../utils/compat_16.h:168:
Remaining cases not appropriate for configuration
mke2fs 1.43.8 (1-Jan-2018)
[   97.998689] ------------[ cut here ]------------
[   98.003346] WARNING: CPU: 2 PID: 340 at
include/linux/sched/mm.h:323 alloc_page_buffers+0x210/0x288
[   98.012409] Modules linked in: rfkill tda998x cec drm_kms_helper
drm crct10dif_ce fuse
[   98.020369] CPU: 2 PID: 340 Comm: kworker/u12:6 Not tainted
5.6.0-rc3-next-20200302 #1
[   98.028302] Hardware name: ARM Juno development board (r2) (DT)
[   98.034242] Workqueue: loop0 loop_workfn
[   98.038176] pstate: 60000005 (nZCv daif -PAN -UAO)
[   98.042980] pc : alloc_page_buffers+0x210/0x288
[   98.047522] lr : alloc_page_buffers+0x50/0x288
[   98.051972] sp : ffff000904a76c00
[   98.055291] x29: ffff000904a76c00 x28: ffff000900126000
[   98.060617] x27: ffff0008e0ad0888 x26: ffffffe001ff3908
[   98.065941] x25: 0000000000408c40 x24: ffffffe001ff3900
[   98.071265] x23: 0000000000000401 x22: ffff0008e0ad0780
[   98.076589] x21: 0000000000001000 x20: 0000000000000000
[   98.081913] x19: ffff0009022fd980 x18: 0000000000000000
[   98.087236] x17: 0000000000000000 x16: 0000000000000000
[   98.092559] x15: 0000000000000000 x14: ffffa00010468954
[   98.097883] x13: ffffa00010259490 x12: ffff9ffc003fe727
[   98.103207] x11: 1ffffffc003fe726 x10: ffff9ffc003fe726
[   98.108531] x9 : dfffa00000000000 x8 : 0000000000000001
[   98.113855] x7 : ffffffe001ff3937 x6 : ffffffe001ff3934
[   98.119179] x5 : 00006003ffc018da x4 : 000000000000002d
[   98.124503] x3 : dfffa00000000000 x2 : 0000000000000007
[   98.129826] x1 : ffff0009022fe300 x0 : ffff000900126000
[   98.135150] Call trace:
[   98.137605]  alloc_page_buffers+0x210/0x288
[   98.141799]  __getblk_gfp+0x1d4/0x400
[   98.145475]  ext4_read_block_bitmap_nowait+0x148/0xbc8
[   98.150628]  ext4_mb_init_cache+0x25c/0x9b0
[   98.154821]  ext4_mb_init_group+0x270/0x390
[   98.159014]  ext4_mb_good_group+0x264/0x270
[   98.163208]  ext4_mb_regular_allocator+0x480/0x798
[   98.168011]  ext4_mb_new_blocks+0x958/0x10f8
[   98.172294]  ext4_ext_map_blocks+0xec8/0x1618
[   98.176660]  ext4_map_blocks+0x1b8/0x8a0
[   98.180592]  ext4_writepages+0x830/0xf10
[   98.184523]  do_writepages+0xb4/0x198
[   98.188195]  __filemap_fdatawrite_range+0x170/0x1c8
[   98.193086]  filemap_write_and_wait_range+0x40/0xb0
[   98.197974]  ext4_punch_hole+0x4a4/0x660
[   98.201907]  ext4_fallocate+0x294/0x1190
[   98.205839]  loop_process_work+0x690/0x1100
[   98.210032]  loop_workfn+0x2c/0x110
[   98.213529]  process_one_work+0x3e0/0x648
[   98.217546]  worker_thread+0x70/0x670
[   98.221217]  kthread+0x1b8/0x1c0
[   98.224452]  ret_from_fork+0x10/0x18
[   98.228033] ---[ end trace 75d39f61d945043e ]---
chown04     0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
chown04     0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
chown04     1  TPASS  :  chown failed: TEST_ERRNO=EPERM(1): Operation
not permitted
chown04     2  TPASS  :  chown failed: TEST_ERRNO=EACCES(13): Permission denied
chown04     3  TPASS  :  chown failed: TEST_ERRNO=EFAULT(14): Bad address
chown04     4  TPASS  :  chown failed: TEST_ERRNO=ENAMETOOLONG(36):
File name too long
chown04     5  TPASS  :  chown failed: TEST_ERRNO=ENOENT(2): No such
file or directory
chown04     6  TPASS  :  chown failed: TEST_ERRNO=ENOTDIR(20): Not a directory
chown04     7  TPASS  :  chown failed: TEST_ERRNO=ELOOP(40): Too many
levels of symbolic links
chown04     8  TPASS  :  chown failed: TEST_ERRNO=EROFS(30): Read-only
file system
mke2fs 1.43.8 (1-Jan-2018)
chown04_16    0  TINFO  :  Using test device LTP_DEV='/dev/loop0'
chown04_16    0  TINFO  :  Formatting /dev/loop0 with ext2 opts='' extra opts=''
chown04_16    1  TCONF  :
/usr/src/debug/ltp/20190930-r0/git/testcases/kernel/syscalls/chown/../utils/compat_16.h:168:
16-bit version of chown() is not supported on your platform
chown04_16    2  TCONF  :
/usr/src/debug/ltp/20190930-r0/git/testcases/kernel/syscalls/chown/../utils/compat_16.h:168:
Remaining cases not appropriate for configuration

Ref:
https://lkft.validation.linaro.org/scheduler/job/1262252#L2152
https://lkft.validation.linaro.org/scheduler/job/1262374#L1313
https://lkft.validation.linaro.org/scheduler/job/1262121#L2153
https://lkft.validation.linaro.org/scheduler/job/1262105#L2116

-- 
Linaro LKFT
https://lkft.linaro.org
