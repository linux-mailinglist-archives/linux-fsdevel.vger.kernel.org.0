Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E211224571
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgGQUzx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jul 2020 16:55:53 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51829 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgGQUzw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jul 2020 16:55:52 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200717205550euoutp0184a2a08dc34e34056303b9c875af9abf~ipaYNAsbs2252122521euoutp01U
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jul 2020 20:55:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200717205550euoutp0184a2a08dc34e34056303b9c875af9abf~ipaYNAsbs2252122521euoutp01U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1595019350;
        bh=sHAVE2zPECZIasZiWwPeXAOwzMaCE1Ho5cU+IWJzsZY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=tzyg3tvJRvNDeOND4B74Z2UBTy7hZQ5hgpUgocE2wMERvydf5KrYGkBRnTQQmxLzV
         LPFl1w7lRbNqPyiZba8gXDsXuh3iYasfGJ2SqpawT/5FPLCqbyBKeeA7L4MKkF1Foi
         6RyTOP3nTU08Pe9aQrC5SwNyjKT4NtzAvoOzRa0I=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200717205550eucas1p29b57f9d0e46609c0981d85431ed9862f~ipaXxx_qf1814218142eucas1p2m;
        Fri, 17 Jul 2020 20:55:50 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A3.14.06318.650121F5; Fri, 17
        Jul 2020 21:55:50 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200717205549eucas1p13fca9a8496836faa71df515524743648~ipaXFkjcm0401804018eucas1p1s;
        Fri, 17 Jul 2020 20:55:49 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200717205549eusmtrp10da805baf7c3bb309dafbfc5b3a047fd~ipaXE4J4m1408614086eusmtrp1K;
        Fri, 17 Jul 2020 20:55:49 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-28-5f12105678ed
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 48.A8.06017.550121F5; Fri, 17
        Jul 2020 21:55:49 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200717205548eusmtip1f8dd32bba10f075e5e345c583879d52f~ipaWl6oCm2455324553eusmtip1L;
        Fri, 17 Jul 2020 20:55:48 +0000 (GMT)
Subject: Re: [PATCH 16/23] initramfs: simplify clean_rootfs
To:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <7f37802c-d8d9-18cd-7394-df51fa785988@samsung.com>
Date:   Fri, 17 Jul 2020 22:55:48 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714190427.4332-17-hch@lst.de>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHKsWRmVeSWpSXmKPExsWy7djP87phAkLxBuefM1tsnLGe1WLl6qNM
        FtM2ilvs2XuSxeLyrjlsFu3zdzFaHF/+l83iUd9bdovzf4+zOnB6bFrVyeZxYsZvFo/dNxvY
        PPq2rGL0+LxJzmPTk7dMHidavrAGsEdx2aSk5mSWpRbp2yVwZTw+9pKpoEWr4sSJ1ewNjJNU
        uhg5OSQETCS2PDvF1sXIxSEksIJRYsXRj4wgCSGBL4wSrb/SIBKfGSUetm8HSnCAdXxbaQoR
        X84o0XdvHzOE855R4mzTZyaQbmEBa4nv8z6yg9giAg4S019cYAUpYhboYpL4/n4CWIJNwFCi
        620XG4jNK2An8b95DZjNIqAq0d70FewMUYE4ifUvtzNB1AhKnJz5hAXE5hQwkFh1u4MZxGYW
        kJdo3jobyhaXuPVkPhPIMgmBS+wSf7d+YoR41EVi7b2v7BC2sMSr41ugbBmJ05N7WCAamoH+
        PLeWHcLpYZS43DQDqtta4s65X2ygAGAW0JRYv0sfIuwose3fGWi48EnceCsIcQSfxKRt05kh
        wrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJGllWM4qmlxbnpqcXGeanl
        esWJucWleel6yfm5mxiBqer0v+NfdzDu+5N0iFGAg1GJh9dglWC8EGtiWXFl7iFGCQ5mJRFe
        p7On44R4UxIrq1KL8uOLSnNSiw8xSnOwKInzGi96GSskkJ5YkpqdmlqQWgSTZeLglGpg3LLl
        YUfU/IcN95YVzL56gtV67aum9jMnZvVtCk6smqgQrHTM6oN2V4Ne9DWmc2quv7KF75m0tVpt
        2XhzpsmWH3927rhf0Nx+gt3gtMuRtJvVS6ZtE3ML3fX6jFd48CpnZ7dQk4dbuXbKcnXY/J+S
        F5Eq3Wyj0Hp/cdbSmooD1zSeH3zMk3WnUomlOCPRUIu5qDgRAN1GaItRAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrAIsWRmVeSWpSXmKPExsVy+t/xu7qhAkLxBouPSlhsnLGe1WLl6qNM
        FtM2ilvs2XuSxeLyrjlsFu3zdzFaHF/+l83iUd9bdovzf4+zOnB6bFrVyeZxYsZvFo/dNxvY
        PPq2rGL0+LxJzmPTk7dMHidavrAGsEfp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvH
        WhmZKunb2aSk5mSWpRbp2yXoZTw+9pKpoEWr4sSJ1ewNjJNUuhg5OCQETCS+rTTtYuTiEBJY
        yijR+fk+SxcjJ1BcRuLktAZWCFtY4s+1LjaIoreMEkvufgQrEhawlvg+7yM7iC0i4CAx/cUF
        VpAiZoEeJokpc28wgSSEBEIkzry9AFbEJmAo0fUWZBInB6+AncT/5jVgNouAqkR701dGEFtU
        IE5i+Zb57BA1ghInZz4BW8YpYCCx6nYHM4jNLGAmMW/zQyhbXqJ562woW1zi1pP5TBMYhWYh
        aZ+FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzNbcd+btnB2PUu+BCj
        AAejEg+vwSrBeCHWxLLiytxDjBIczEoivE5nT8cJ8aYkVlalFuXHF5XmpBYfYjQFem4is5Ro
        cj4wbeSVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamCs3eq94gVH
        1V9f5R/6X2Id5p8vnnpy5jvJhrAty19YnzdcsC3xxbXEKU8/9d3naWMISVPXWNxZ7La/Rk1S
        riHb7PKxJ+/WCvVZ/l31dkOvPqtiyeX++Y+alT5oSGb+nf3+93vXK1wmz32O11lpHHcvLv6+
        U2Qux+MMMzuFqVkun/sWtVj5H3ytxFKckWioxVxUnAgAv5iTl+MCAAA=
X-CMS-MailID: 20200717205549eucas1p13fca9a8496836faa71df515524743648
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200717205549eucas1p13fca9a8496836faa71df515524743648
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200717205549eucas1p13fca9a8496836faa71df515524743648
References: <20200714190427.4332-1-hch@lst.de>
        <20200714190427.4332-17-hch@lst.de>
        <CGME20200717205549eucas1p13fca9a8496836faa71df515524743648@eucas1p1.samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Christoph,

On 14.07.2020 21:04, Christoph Hellwig wrote:
> Just use d_genocide instead of iterating through the root directory with
> cumbersome userspace-like APIs.  This also ensures we actually remove files
> that are not direct children of the root entry, which the old code failed
> to do.
>
> Fixes: df52092f3c97 ("fastboot: remove duplicate unpack_to_rootfs()")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This patch breaks initrd support ;-(

I use initrd to deploy kernel modules on my test machines. It was 
automatically mounted on /initrd. /lib/modules is just a symlink to 
/initrd. I know that initrd support is marked as deprecated, but it 
would be really nice to give people some time to update their machines 
before breaking the stuff.

Here is the log:

Kernel image @ 0x40007fc0 [ 0x000000 - 0x6dd9c8 ]
## Flattened Device Tree blob at 41000000
    Booting using the fdt blob at 0x41000000
    Loading Ramdisk to 4de3c000, end 50000000 ... OK
    Loading Device Tree to 4de2d000, end 4de3b206 ... OK

Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x900
...

[    0.000000] Kernel command line: root=PARTLABEL=rootfs rootwait 
console=tty1 console=ttySAC2,115200n8 earlycon rootdelay=2
...

[    1.853631] Trying to unpack rootfs image as initramfs...
[    1.858661] rootfs image is not initramfs (invalid magic at start of 
compressed archive); looks like an initrd
...
[    2.204776] Freeing initrd memory: 34576K

...

[    4.635360] Warning: unable to open an initial console.
[    4.640706] Waiting 2 sec before mounting root device...
...
[    6.776007] Failed to create /dev/root: -2
[    6.778989] VFS: Cannot open root device "PARTLABEL=rootfs" or 
unknown-block(179,6): error -2
[    6.787200] Please append a correct "root=" boot option; here are the 
available partitions:
[    6.795693] 0100           65536 ram0
[    6.795697]  (driver?)
[    6.801459] 0101           65536 ram1
[    6.801462]  (driver?)
[    6.807532] 0102           65536 ram2
[    6.807535]  (driver?)
[    6.813674] 0103           65536 ram3
[    6.813677]  (driver?)
[    6.819760] 0104           65536 ram4
[    6.819763]  (driver?)
[    6.832610] 0105           65536 ram5
[    6.832613]  (driver?)
[    6.848685] 0106           65536 ram6
[    6.848688]  (driver?)
[    6.864590] 0107           65536 ram7
[    6.864593]  (driver?)
[    6.880504] 0108           65536 ram8
[    6.880507]  (driver?)
[    6.896248] 0109           65536 ram9
[    6.896251]  (driver?)
[    6.911828] 010a           65536 ram10
[    6.911831]  (driver?)
[    6.927447] 010b           65536 ram11
[    6.927450]  (driver?)
[    6.942976] 010c           65536 ram12
[    6.942979]  (driver?)
[    6.958190] 010d           65536 ram13
[    6.958193]  (driver?)
[    6.973205] 010e           65536 ram14
[    6.973208]  (driver?)
[    6.988105] 010f           65536 ram15
[    6.988108]  (driver?)
[    7.002897] b300        15388672 mmcblk0
[    7.002901]  driver: mmcblk
[    7.018061]   b301            8192 mmcblk0p1 
654b73ea-7c04-c24d-9642-2a186649605c
[    7.018064]
[    7.035359]   b302           61440 mmcblk0p2 
7ef6fb83-0d6c-8c44-826b-ad11df290e0c
[    7.035362]
[    7.052589]   b303          102400 mmcblk0p3 
34883856-7d52-d548-a196-718efbd06876
[    7.052592]
[    7.069744]   b304          153600 mmcblk0p4 
8d4410d0-a4ff-c447-abb9-73350dcdd2d6
[    7.069747]
[    7.086888]   b305         1572864 mmcblk0p5 
485c2c17-a9e8-9c45-bb68-e0748a2bb1f1
[    7.086890]
[    7.103991]   b306         3072000 mmcblk0p6 
7fb2bbf3-e064-2343-b169-e69c18dbb43e
[    7.103993]
[    7.121290]   b307        10413039 mmcblk0p7 
b0ee9150-6b6a-274b-9ec3-703d29072555
[    7.121292]
[    7.138722] Kernel panic - not syncing: VFS: Unable to mount root fs 
on unknown-block(179,6)
[    7.151482] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 
5.8.0-rc5-00064-g38d014f6d446 #8823
[    7.164026] Hardware name: Samsung Exynos (Flattened Device Tree)
[    7.174556] [<c011188c>] (unwind_backtrace) from [<c010d27c>] 
(show_stack+0x10/0x14)
[    7.186799] [<c010d27c>] (show_stack) from [<c05182e4>] 
(dump_stack+0xbc/0xe8)
[    7.198533] [<c05182e4>] (dump_stack) from [<c01272e0>] 
(panic+0x128/0x354)
[    7.210002] [<c01272e0>] (panic) from [<c1001580>] 
(mount_block_root+0x1a8/0x240)
[    7.221961] [<c1001580>] (mount_block_root) from [<c1001738>] 
(mount_root+0x120/0x13c)
[    7.234325] [<c1001738>] (mount_root) from [<c10018ac>] 
(prepare_namespace+0x158/0x194)
[    7.246751] [<c10018ac>] (prepare_namespace) from [<c0ab7684>] 
(kernel_init+0x8/0x118)
[    7.259086] [<c0ab7684>] (kernel_init) from [<c0100114>] 
(ret_from_fork+0x14/0x20)tatic void __init populate_initrd_image(char *err)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

