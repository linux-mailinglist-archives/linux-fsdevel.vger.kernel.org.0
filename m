Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 172E22CDA53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Dec 2020 16:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389200AbgLCPrD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Dec 2020 10:47:03 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46368 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389171AbgLCPrC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Dec 2020 10:47:02 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201203154610euoutp020858a1e3013031a34108f484e782475d~NP2rblamq1714217142euoutp02B
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Dec 2020 15:46:10 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201203154610euoutp020858a1e3013031a34108f484e782475d~NP2rblamq1714217142euoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1607010370;
        bh=z3/D0MJrjrF94npmo1z4sClZBeVcZraVE0CVPLPG7zg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=KqbHSL+SrT69RkrrVrjvac+gY0GnzGptbDgpfWABETcC6XMxv1QkPlwbFvR0rwVDG
         FdDgCxmSJ/TOOjINrUs5GPuysc+MrEud1QNUL+3Ur7QG3bKgPr1zdf/GH5GrDpX82K
         xiakLkkYGGi8vv77qfl5RHvbYuUJbjDDtUfHN/6g=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201203154604eucas1p201d76d19c7044922f703edb697a16eee~NP2mbgiLy1046010460eucas1p25;
        Thu,  3 Dec 2020 15:46:04 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 2E.66.44805.C3809CF5; Thu,  3
        Dec 2020 15:46:04 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201203154604eucas1p200d001d25dd344a1dd1c7da34f35aad0~NP2lzGzuR1046410464eucas1p2m;
        Thu,  3 Dec 2020 15:46:04 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201203154604eusmtrp2955b24b6b96bb204fdacf8696f76ab47~NP2lyYQXW3076630766eusmtrp2O;
        Thu,  3 Dec 2020 15:46:04 +0000 (GMT)
X-AuditID: cbfec7f4-b37ff7000000af05-90-5fc9083cd590
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1F.78.16282.C3809CF5; Thu,  3
        Dec 2020 15:46:04 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201203154603eusmtip1862c92c36bc22a0a3695d5b3b6a86fc4~NP2lIqFsM0365503655eusmtip1L;
        Thu,  3 Dec 2020 15:46:03 +0000 (GMT)
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
To:     Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, hch@lst.de,
        hannes@cmpxchg.org, yang.shi@linux.alibaba.com,
        dchinner@redhat.com, linux-kernel@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <bb95be97-2a50-b345-fc2c-3ff865b60e08@samsung.com>
Date:   Thu, 3 Dec 2020 16:46:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201125023234.GH4327@casper.infradead.org>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djPc7o2HCfjDTonaVnMWb+GzeLsq7ns
        Fqs3+VqsXH2UyeLppz4Wi9nTm5ks9uw9yWJxedccNot7a/6zWmxe3MVk8fsHkPux6R6bA4/H
        4TfvmT0WbCr12LxCy2PTp0nsHidm/Gbx2PnQ0mP3zQY2j49Pb7F4vN93lc3jzIIj7B6fN8kF
        cEdx2aSk5mSWpRbp2yVwZXyYcJmx4Khuxby7r1gaGBerdzFyckgImEjs+f6QvYuRi0NIYAWj
        xK4Pe1kgnC+MEu+urIPKfGaU2N74lR2mpfnHfFaIxHJGia1fmqGc94wSe17vYASpEhZwlOh8
        uhysQ0TAU+Ju1yNGkCJmgUVMElNnv2EDSbAJGEp0ve0Cs3kF7CROHb0G1MDBwSKgInH+ty9I
        WFQgSeLgxwdQJYISJ2c+YQGxOQUsJVbPOQIWZxaQl2jeOpsZwhaXuPVkPhPILgmB5ZwSDXMX
        M0Gc7SIxb8EbKFtY4tXxLVDvyEj83wnT0Mwo8fDcWnYIp4dR4nLTDEaIKmuJO+d+sYFcxyyg
        KbF+lz5E2FHiwOlNzCBhCQE+iRtvBSGO4JOYtG06VJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFp
        FpLXZiF5ZxaSd2Yh7F3AyLKKUTy1tDg3PbXYKC+1XK84Mbe4NC9dLzk/dxMjMNmd/nf8yw7G
        5a8+6h1iZOJgPMQowcGsJMJ7e+mJeCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8SVvWxAsJpCeW
        pGanphakFsFkmTg4pRqY5Na0qGzi3WPk3/Ob4T1j156m7XH6vQGMuauunuReLlM8yWXDLZ+q
        yyHVx93/lP358ojrRlrJhj0h1h39Hz83l4rN+Fe6TCm/kvHfixpZJ36Fy5K2rI5HfD6yiG+v
        f/krcasHj2aSjiD/2eeruOfv1nPbaf99Vu8KztsTD2zuTlvlbCWi47iYY96V2onXpq6O9L8w
        V2rB3qXym/a4r6vv/XydR5qhwmzuG26l/luHF7dvLSydcvp7jVzbD2dX7qaZE13mulVHzdnN
        d+P2ym5fFfXMJLeAaSzx8kmKDSp1sQLF4ubRB5+zRO89IPbwlO15rxNTXl+uea14fuEiZ2el
        hWrvquesKRbutsmucylSYinOSDTUYi4qTgQA8Eo5k+UDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrCIsWRmVeSWpSXmKPExsVy+t/xu7o2HCfjDZbtYbWYs34Nm8XZV3PZ
        LVZv8rVYufook8XTT30sFrOnNzNZ7Nl7ksXi8q45bBb31vxntdi8uIvJ4vcPIPdj0z02Bx6P
        w2/eM3ss2FTqsXmFlsemT5PYPU7M+M3isfOhpcfumw1sHh+f3mLxeL/vKpvHmQVH2D0+b5IL
        4I7SsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy/gw
        4TJjwVHdinl3X7E0MC5W72Lk5JAQMJFo/jGftYuRi0NIYCmjxKPbJ9ggEjISJ6c1sELYwhJ/
        rnWxQRS9ZZR4emkBI0hCWMBRovPpcnYQW0TAU+Ju1yNGkCJmgUVMEnOWzYbquM8kcfXTXLBR
        bAKGEl1vu8BW8ArYSZw6eg2om4ODRUBF4vxvX5CwqECSxO+la6FKBCVOznzCAmJzClhKrJ5z
        BCzOLGAmMW/zQ2YIW16ieetsKFtc4taT+UwTGIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3P
        LTbSK07MLS7NS9dLzs/dxAiM7m3Hfm7Zwbjy1Ue9Q4xMHIyHGCU4mJVEeG8vPREvxJuSWFmV
        WpQfX1Sak1p8iNEU6J2JzFKiyfnA9JJXEm9oZmBqaGJmaWBqaWasJM5rcmRNvJBAemJJanZq
        akFqEUwfEwenVANTh0Nc9nybw86ae7Zv8LJtP8WwtyZsh+jnGIGvM8OPbPf8KSf0MGMdv8R6
        o/t+jtpLarPOH1DZGFFet8s6wytVVOjWFQVtS5s0wauTHPd/ffxtR/nOKZdKLvdckNUNftMj
        zMQzIbg/vfllE2tZk3mE0RMng/k7Wldl/U+948H6/Oqz65fj2I9WsC5KEFnw+lTajtrgoOCK
        nrkGbcdXrz+gkyd8u+bZgWe7f3Qe15ww2ypcrT7x+jGpXwqTdGZ49F/+dXfKKdO8m7Mqb/Fd
        qVn3OtHcW8mnNvHq5NsTT63tNnRhKWRylxaPVZkp/8z39d0+4evT5Ce3MZx5qP7u2mPttQcn
        8Pp/OXx/k4dJYucRJZbijERDLeai4kQAmtjg1HcDAAA=
X-CMS-MailID: 20201203154604eucas1p200d001d25dd344a1dd1c7da34f35aad0
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201203154604eucas1p200d001d25dd344a1dd1c7da34f35aad0
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201203154604eucas1p200d001d25dd344a1dd1c7da34f35aad0
References: <20201112212641.27837-1-willy@infradead.org>
        <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
        <20201117153947.GL29991@casper.infradead.org>
        <alpine.LSU.2.11.2011170820030.1014@eggly.anvils>
        <20201117191513.GV29991@casper.infradead.org>
        <20201117234302.GC29991@casper.infradead.org>
        <20201125023234.GH4327@casper.infradead.org>
        <CGME20201203154604eucas1p200d001d25dd344a1dd1c7da34f35aad0@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi

On 25.11.2020 03:32, Matthew Wilcox wrote:
> On Tue, Nov 17, 2020 at 11:43:02PM +0000, Matthew Wilcox wrote:
>> On Tue, Nov 17, 2020 at 07:15:13PM +0000, Matthew Wilcox wrote:
>>> I find both of these functions exceptionally confusing.  Does this
>>> make it easier to understand?
>> Never mind, this is buggy.  I'll send something better tomorrow.
> That took a week, not a day.  *sigh*.  At least this is shorter.
>
> commit 1a02863ce04fd325922d6c3db6d01e18d55f966b
> Author: Matthew Wilcox (Oracle) <willy@infradead.org>
> Date:   Tue Nov 17 10:45:18 2020 -0500
>
>      fix mm-truncateshmem-handle-truncates-that-split-thps.patch

This patch landed in todays linux-next (20201203) as commit 8678b27f4b8b 
("8678b27f4b8bfc130a13eb9e9f27171bcd8c0b3b"). Sadly it breaks booting of 
ANY of my ARM 32bit test systems, which use initrd. ARM64bit based 
systems boot fine. Here is example of the crash:

Waiting 2 sec before mounting root device...
RAMDISK: squashfs filesystem found at block 0
RAMDISK: Loading 37861KiB [1 disk] into ram disk... /
/
/
/
done.
using deprecated initrd support, will be removed in 2021.
------------[ cut here ]------------
kernel BUG at fs/inode.c:531!
Internal error: Oops - BUG: 0 [#1] PREEMPT SMP ARM
Modules linked in:
CPU: 0 PID: 12 Comm: kworker/0:1 Not tainted 5.10.0-rc6-next-20201203 #2131
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events delayed_fput
PC is at clear_inode+0x74/0x88
LR is at clear_inode+0x14/0x88
pc : [<c02fb334>]    lr : [<c02fb2d4>]    psr: 200001d3
sp : c1d2be68  ip : c1736ff4  fp : c1208f14
r10: c1208ec8  r9 : c20020c0  r8 : c209b0d8
r7 : c02f759c  r6 : c0c13940  r5 : c209b244  r4 : c209b0d8
r3 : 000024f9  r2 : 00000000  r1 : 00000000  r0 : c209b244
Flags: nzCv  IRQs off  FIQs off  Mode SVC_32  ISA ARM  Segment none
Control: 10c5387d  Table: 4000404a  DAC: 00000051
Process kworker/0:1 (pid: 12, stack limit = 0x(ptrval))
Stack: (0xc1d2be68 to 0xc1d2c000)
...
[<c02fb334>] (clear_inode) from [<c02fc8a0>] (evict+0x12c/0x13c)
[<c02fc8a0>] (evict) from [<c02f648c>] (__dentry_kill+0xb0/0x188)
[<c02f648c>] (__dentry_kill) from [<c02f7714>] (dput+0x2d8/0x67c)
[<c02f7714>] (dput) from [<c02dd300>] (__fput+0xd4/0x24c)
[<c02dd300>] (__fput) from [<c02dd4b4>] (delayed_fput+0x3c/0x48)
[<c02dd4b4>] (delayed_fput) from [<c0149660>] (process_one_work+0x234/0x7e4)
[<c0149660>] (process_one_work) from [<c0149c54>] (worker_thread+0x44/0x51c)
[<c0149c54>] (worker_thread) from [<c0150a88>] (kthread+0x158/0x1a0)
[<c0150a88>] (kthread) from [<c010011c>] (ret_from_fork+0x14/0x38)
Exception stack(0xc1d2bfb0 to 0xc1d2bff8)
...
---[ end trace b3c68905048e7f9b ]---
note: kworker/0:1[12] exited with preempt_count 1
BUG: sleeping function called from invalid context at 
./include/linux/percpu-rwsem.h:49
in_atomic(): 0, irqs_disabled(): 128, non_block: 0, pid: 12, name: 
kworker/0:1
INFO: lockdep is turned off.
irq event stamp: 7498
hardirqs last  enabled at (7497): [<c02b7fcc>] free_unref_page+0x80/0x88
hardirqs last disabled at (7498): [<c0b40b18>] _raw_spin_lock_irq+0x24/0x5c
softirqs last  enabled at (6234): [<c0966af4>] linkwatch_do_dev+0x20/0x80
softirqs last disabled at (6232): [<c0966a60>] rfc2863_policy+0x30/0xa4
CPU: 0 PID: 12 Comm: kworker/0:1 Tainted: G      D 
5.10.0-rc6-next-20201203 #2131
Hardware name: Samsung Exynos (Flattened Device Tree)
Workqueue: events delayed_fput
[<c0111718>] (unwind_backtrace) from [<c010d050>] (show_stack+0x10/0x14)
[<c010d050>] (show_stack) from [<c0b34310>] (dump_stack+0xb4/0xd4)
[<c0b34310>] (dump_stack) from [<c015a9d4>] (___might_sleep+0x288/0x2d8)
[<c015a9d4>] (___might_sleep) from [<c013c744>] (exit_signals+0x38/0x428)
[<c013c744>] (exit_signals) from [<c012ce18>] (do_exit+0xe4/0xc88)
[<c012ce18>] (do_exit) from [<c010d28c>] (die+0x238/0x30c)
[<c010d28c>] (die) from [<c010d560>] (do_undefinstr+0xbc/0x26c)
[<c010d560>] (do_undefinstr) from [<c0100c1c>] (__und_svc_finish+0x0/0x44)
Exception stack(0xc1d2be18 to 0xc1d2be60)
VFS: Mounted root (squashfs filesystem) readonly on device 1:0.
be00: c209b244 00000000
be20: 00000000 000024f9 c209b0d8 c209b244 c0c13940 c02f759c c209b0d8 
c20020c0
be40: c1208ec8 c1208f14 c1736ff4 c1d2be68 c02fb2d4 c02fb334 200001d3 
ffffffff
[<c0100c1c>] (__und_svc_finish) from [<c02fb334>] (clear_inode+0x74/0x88)
[<c02fb334>] (clear_inode) from [<c02fc8a0>] (evict+0x12c/0x13c)
[<c02fc8a0>] (evict) from [<c02f648c>] (__dentry_kill+0xb0/0x188)
[<c02f648c>] (__dentry_kill) from [<c02f7714>] (dput+0x2d8/0x67c)
[<c02f7714>] (dput) from [<c02dd300>] (__fput+0xd4/0x24c)
[<c02dd300>] (__fput) from [<c02dd4b4>] (delayed_fput+0x3c/0x48)
[<c02dd4b4>] (delayed_fput) from [<c0149660>] (process_one_work+0x234/0x7e4)
[<c0149660>] (process_one_work) from [<c0149c54>] (worker_thread+0x44/0x51c)
[<c0149c54>] (worker_thread) from [<c0150a88>] (kthread+0x158/0x1a0)
[<c0150a88>] (kthread) from [<c010011c>] (ret_from_fork+0x14/0x38)
Exception stack(0xc1d2bfb0 to 0xc1d2bff8)
bfa0:                                     00000000 00000000 00000000 
00000000
bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 
00000000
bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
EXT4-fs (mmcblk0p6): INFO: recovery required on readonly filesystem
EXT4-fs (mmcblk0p6): write access will be enabled during recovery
EXT4-fs (mmcblk0p6): recovery complete
EXT4-fs (mmcblk0p6): mounted filesystem with ordered data mode. Opts: (null)
VFS: Mounted root (ext4 filesystem) readonly on device 179:6.
Trying to move old root to /initrd ...

I suppose this issue can be also reproduced with qemu.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

