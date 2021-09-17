Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97EB140F3F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Sep 2021 10:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbhIQIWP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Sep 2021 04:22:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbhIQIWP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Sep 2021 04:22:15 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B11C061764
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 01:20:52 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id w206so1338823oiw.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Sep 2021 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgkOy/GFw0B0/CgncsqDFHQxfUOXTsEnE+U8A3BFRto=;
        b=O/gkFxkLAL/XHoootzRwbk+EZdendJXAmmK3oN6ZKwApc5AtO3o8mhNIeeqnRQ3pUo
         e85IZgM3/ogDjaR8IEV0KL8322oWd4xTdhUSfxuuIrxxz60hMsHGNUGQ6azjYp7iTM/n
         34gwqueE1kDaAVWBo16VFiRmwFRTX/h7AjpjQvk43bw6viII1559Vbq7KhyT0YULABLr
         tXQaHt2yo/n4j1FnQh/zUH9QfjtbQtPycH6JG2hSkmSCUmfSZ9axjriYLXHwldMzPo+u
         QrH1DiyLlNo3bW+h6xmMnevv0g1zDmp70hLgaD+B30uggtlVu0cPRbZipzslSFDoL7TM
         4l5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgkOy/GFw0B0/CgncsqDFHQxfUOXTsEnE+U8A3BFRto=;
        b=ryJAWnGd25y9xbZVig73dpvCA0shK/3xC/COA3i/yzRFGoKgweRDoQY1kEQgRkmviI
         tzS6L9H7wA+J+fHjIHfvRkHyhkJeeDAV041xVDaJL0VNe/n3Mi6Ero9Dkn4mswEtqM0O
         eMqK3LNWOGxPGspEBRTgi68SmLYCjSMZ3QjdCO7FLDAp/XauAJr1ntgr1f+gRmB75fnS
         5VSMM5pDWtbftNvhjvysARQLHhoZdyTpkpRb359Bctk2kyuhNHjVyhGrYJKYV2tZm280
         oqKiJatMrgAhURxPbopTJHdBJ8KurIfyQX+TfmEstuO6v7a/iHjWqL1vHw7wftPs6ief
         7cPg==
X-Gm-Message-State: AOAM532L+Q7u9tgKUHbDiEyrgXL1x5iCC5Z3AgVUzo+t8AfZLSFZgkbQ
        6/6tNmj33pw3ukjkX3zSByOSwe3Et9TsYQERhLNXR1yIp+ku6v8wk0mSY87By/GjgZj1NrWHxK9
        Kuw47j/u3qE0NG2IDnBVncPbkmO6eBIwu
X-Google-Smtp-Source: ABdhPJyK30wEchgbZ3Ofsp/bRGkfPwh3/jcKyhwWr4Cn1Pm+l56keRFGHOknRSsCqUmLg36Ao+tH9nTN30gIrkFavNE=
X-Received: by 2002:a54:4005:: with SMTP id x5mr12190251oie.160.1631866851729;
 Fri, 17 Sep 2021 01:20:51 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000f8d56e05cb50a541@google.com>
In-Reply-To: <000000000000f8d56e05cb50a541@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 17 Sep 2021 10:20:40 +0200
Message-ID: <CACT4Y+YLEUuuNQ+2TOEevwNRvPHp-wT4W+dXAdKds_kf+upQbQ@mail.gmail.com>
Subject: Re: [syzbot] upstream test error: WARNING in __do_kernel_fault
To:     syzbot <syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Will Deacon <will.deacon@arm.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-ccpol: medium
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 6 Sept 2021 at 11:55, syzbot
<syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    f1583cb1be35 Merge tag 'linux-kselftest-next-5.15-rc1' of ..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17756315300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=5fe535c85e8d7384
> dashboard link: https://syzkaller.appspot.com/bug?extid=e6bda7e03e329ed0b1db
> compiler:       aarch64-linux-gnu-gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> userspace arch: arm64
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e6bda7e03e329ed0b1db@syzkaller.appspotmail.com

+Will, you added this WARNING in 42f91093b04333.
This now crashes periodically on syzbot.

> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Not tainted 5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 0000000000000308 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : ffff00007fbbb9c8 x4 : 0000000000015ff5 x3 : 0000000000000001
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640ca ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 000000000000032d x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640cb ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 0000000000000352 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640cc ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 0000000000000377 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640cd ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 000000000000039c x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640ce ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 00000000000003c1 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640cf ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 00000000000003e6 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d0 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 000000000000040b x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d1 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 0000000000000430 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d2 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 0000000000000455 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d3 ]---
> __do_kernel_fault: 65272 callbacks suppressed
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 000000000000047b x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : ffff00007fbbb9c8 x4 : 0000000000015ff5 x3 : 0000000000000001
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d4 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 00000000000004a0 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d5 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 00000000000004c5 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d6 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 00000000000004ea x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d7 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 000000000000050f x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d8 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 0000000000000534 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640d9 ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 0000000000000559 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640da ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 000000000000057e x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640db ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 00000000000005a3 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640dc ]---
> ------------[ cut here ]------------
> Ignoring spurious kernel translation fault at virtual address ffff00007b65e020
> WARNING: CPU: 0 PID: 22 at arch/arm64/mm/fault.c:365 __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> Modules linked in:
> CPU: 0 PID: 22 Comm: kdevtmpfs Tainted: G        W         5.14.0-syzkaller-09284-gf1583cb1be35 #0
> Hardware name: linux,dummy-virt (DT)
> pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> lr : __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
> sp : ffff80001267b980
> x29: ffff80001267b980 x28: f4ff0000029a0000 x27: 0000000000000000
> x26: 0000000000000000 x25: fdff000002fa0d00 x24: ffff80001267bcb8
> x23: 0000000060400009 x22: ffff00007b65e020 x21: 0000000000000025
> x20: ffff80001267ba50 x19: 0000000097c48007 x18: 00000000fffffffd
> x17: 6666207373657264 x16: 6461206c61757472 x15: 697620746120746c
> x14: 756166206e6f6974 x13: 00000000000005c8 x12: ffff80001267b680
> x11: ffff8000122cd1e0 x10: 00000000ffffe000 x9 : ffff8000122cd1e0
> x8 : ffff80001221d1e0 x7 : ffff8000122cd1e0 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000015ff5 x3 : 0000000000000000
> x2 : 0000000000000000 x1 : 0000000000000000 x0 : f4ff0000029a0000
> Call trace:
>  __do_kernel_fault+0x170/0x1bc arch/arm64/mm/fault.c:365
>  do_bad_area arch/arm64/mm/fault.c:466 [inline]
>  do_translation_fault+0x58/0xc0 arch/arm64/mm/fault.c:682
>  do_mem_abort+0x44/0xb4 arch/arm64/mm/fault.c:813
>  el1_abort+0x40/0x60 arch/arm64/kernel/entry-common.c:357
>  el1h_64_sync_handler+0xb0/0xd0 arch/arm64/kernel/entry-common.c:408
>  el1h_64_sync+0x78/0x7c arch/arm64/kernel/entry.S:567
>  __entry_tramp_text_end+0xdfc/0x3000
>  d_lookup+0x44/0x70 fs/dcache.c:2370
>  lookup_dcache+0x24/0x84 fs/namei.c:1520
>  __lookup_hash+0x24/0xd0 fs/namei.c:1543
>  kern_path_locked+0x90/0x10c fs/namei.c:2567
>  handle_remove+0x38/0x284 drivers/base/devtmpfs.c:312
>  handle drivers/base/devtmpfs.c:382 [inline]
>  devtmpfs_work_loop drivers/base/devtmpfs.c:395 [inline]
>  devtmpfsd+0x8c/0xd0 drivers/base/devtmpfs.c:437
>  kthread+0x150/0x15c kernel/kthread.c:319
>  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:756
> ---[ end trace ae975648337640dd ]---
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000f8d56e05cb50a541%40google.com.
