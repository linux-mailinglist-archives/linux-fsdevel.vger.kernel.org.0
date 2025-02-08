Return-Path: <linux-fsdevel+bounces-41283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E157CA2D5C7
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 12:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1B373AA5C0
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Feb 2025 11:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19473246327;
	Sat,  8 Feb 2025 11:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jA99cWQI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727A21B4F0B
	for <linux-fsdevel@vger.kernel.org>; Sat,  8 Feb 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739013892; cv=none; b=cJIsGMN9T2LGoPm03MYKIDjOYukXUKVbSTz0SvbsCpjhR1zopaVf749ahhNO0MZdkyn4NN+ZHB4j7xS0B989Pg4tgmcmeLDgc9x1E9szY6p1Wuk8gFi/5Y7lM6Gy3c2ukTr5Mvzb9RmzKoiAi6ig97DdHJewH5XAlLFFRn4OFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739013892; c=relaxed/simple;
	bh=QxCoR5fINOgaRG/7i/sZBWB8ob4zBL1L6L24kHwv/BM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eBcikRt0O7KODo9OiZwbHV/PyefbppELCsCTw/+MbSqt6nDoNybm1W6J7D6IgOf7maIgN/E85iee2X0wVVeGKicH4KM04Riwf6fbGJF3DiBNXlu4D3TjgcncZ4S9WkHH5WPWCE6Ye2ZrellvvwAXO8N2LmTfTrnLSCPKMUdgDTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jA99cWQI; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-8671d8a9c3eso38741241.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 08 Feb 2025 03:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739013888; x=1739618688; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UR24c0ybsYSCT638vdO45F5vCET0OjoyBMHeBOmvILQ=;
        b=jA99cWQIVwP/laXmvPPR8h/MaMlKNrqJq5uYxfmLWzBuDOo4yGcR6Zmk6mMGiL+22j
         P8qczuU/9ya6Fcccnyv/xKae3lN4GMo0sTw2p9vHCwlxJTgjTi3w6WYShirb2XdmmGne
         14GVtRCI3bKG9gV7VyB9LbRDhRRnSYhqYfZiIRfoLoXbsCP6GAEKOJ9pUBjC00oF8Rtq
         TivPCEAiNgz/ebZtr2O80LzpLSTAl6xWUXoQz2Pl69bducqwW9figGDgGLKAjcWDdqxT
         qA4o7D6l/GScfx4xp1dDlauIHNjwg5DNAbdUTfe5I579sjpiJ/dzJ546o1Elgt5B0IT0
         s2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739013888; x=1739618688;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UR24c0ybsYSCT638vdO45F5vCET0OjoyBMHeBOmvILQ=;
        b=exRPczCI52zuPe9tKEKMSX4vL30tCGqQ4Vul5TmzGzK18bXtN1KH9AVVOYan3iv/rm
         XK3ZCzLZkQpK1QJFCq7Zisd1aTqk+TOrGO0QZL3W/ZbYtoHeFMdeQbV/pUFVYemNKKkO
         Kj8HDJKk7NSDrSXfsHWd2N5pM4hpdsoL78idIQZzio6f/GPIoOgZbpVay7+9a18ShFwH
         PE6cZsE9GPspB85BLTN8+8lSKOefY74ZDMjEenvixTQ2zP7TmvIFFuneJj781PM4Ukdj
         V+acPQzuNwn+g6hYuG7SAkSe/g+BOtUPNFIo0R2s2cJOt6tJVlodl2iMkJSk2xmU3Azk
         ZrqQ==
X-Forwarded-Encrypted: i=1; AJvYcCURN9Hj5NSthjTH+TzD6dv+8U/WH0NRKaUqiVyFdQWjj6pWRgjxGhPZLOxcQfSN7JXGS8El/ehQSgQ0XRRn@vger.kernel.org
X-Gm-Message-State: AOJu0Yy99wwZWPML36EQyzP8R1f8+q/sZEcfWew02Ypc1ectSkDigkIx
	YjsmH1pjYiGNrynxgLYu34PJYmcF6g+JjFVLzOE0uDRBJ++CsuPdNPTZD1NgZqKOep8wkrV1AS9
	1ErA10/l7CKcjBKvnvf+Fxjp7F1I0YEXvvoN3HQ==
X-Gm-Gg: ASbGncvd4TfLwNeIUw0nUCutJyejwiWOju/wQJg3lDvFRXCSEk9THi+DZ8r0zHKBE8S
	pxE28PN64RYpP+fkChxeJz2VbGsn5Y8xIYJBYwT3So6G20igbIspBO6DT1sFLxx5PKWTYnHITMU
	PMDdSz4eQdOX5YXSPiWTdGNWTk/h8BJg==
X-Google-Smtp-Source: AGHT+IF1RRMD7eUyWSo4zZ0nuD/PcQtH1/GOoYgWE/A3nO7nDenaKyW1khMDl4HonWSbq2qwn3LipNrUmvEW01Z/m7Y=
X-Received: by 2002:a05:6102:32c6:b0:4b2:4877:2de4 with SMTP id
 ada2fe7eead31-4ba85e55589mr5245989137.15.1739013888241; Sat, 08 Feb 2025
 03:24:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250206155234.095034647@linuxfoundation.org>
In-Reply-To: <20250206155234.095034647@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Sat, 8 Feb 2025 16:54:36 +0530
X-Gm-Features: AWEUYZkctiuP6MSaer6bJfW68j7DLMOLcCHAn7tCGTVoEJtcXFr3-AbwN1hwwf8
Message-ID: <CA+G9fYvKzV=jo9AmKH2tJeLr0W8xyjxuVO-P+ZEBdou6C=mKUw@mail.gmail.com>
Subject: Re: [PATCH 6.6 000/389] 6.6.76-rc2 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, hargar@microsoft.com, 
	broonie@kernel.org, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Herbert Xu <herbert@gondor.apana.org.au>, willy@infradead.org, 
	Pankaj Raghav <p.raghav@samsung.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 6 Feb 2025 at 21:36, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> This is the start of the stable review cycle for the 6.6.76 release.
> There are 389 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sat, 08 Feb 2025 15:51:12 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.76-rc2.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.6.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h


There are three different regressions found and reporting here,
We are working on bisecting and investigating these issues,

1)
Regression on qemu-arm64 and FVP noticed this kernel warning running
selftests: arm64: check_hugetlb_options test case on 6.6.76-rc1 and
6.6.76-rc2.

Test regression: WARNING-arch-arm64-mm-copypage-copy_highpage

------------[ cut here ]------------
[   96.920028] WARNING: CPU: 1 PID: 3611 at
arch/arm64/mm/copypage.c:29 copy_highpage
(arch/arm64/include/asm/mte.h:87)
[   96.922100] Modules linked in: crct10dif_ce sm3_ce sm3 sha3_ce
sha512_ce sha512_arm64 fuse drm backlight ip_tables x_tables
[   96.925603] CPU: 1 PID: 3611 Comm: check_hugetlb_o Not tainted 6.6.76-rc2 #1
[   96.926956] Hardware name: linux,dummy-virt (DT)
[   96.927695] pstate: 43402009 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   96.928687] pc : copy_highpage (arch/arm64/include/asm/mte.h:87)
[   96.929037] lr : copy_highpage
(arch/arm64/include/asm/alternative-macros.h:232
arch/arm64/include/asm/cpufeature.h:443
arch/arm64/include/asm/cpufeature.h:504
arch/arm64/include/asm/cpufeature.h:814 arch/arm64/mm/copypage.c:27)
[   96.929399] sp : ffff800088aa3ab0
[   96.930232] x29: ffff800088aa3ab0 x28: 00000000000001ff x27: 0000000000000000
[   96.930784] x26: 0000000000000000 x25: 0000ffff9b800000 x24: 0000ffff9b9ff000
[   96.931402] x23: fffffc0003257fc0 x22: ffff0000c95ff000 x21: ffff0000c93ff000
[   96.932054] x20: fffffc0003257fc0 x19: fffffc000324ffc0 x18: 0000ffff9b800000
[   96.933357] x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
[   96.934091] x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
[   96.935095] x11: 0000000000000000 x10: 0000000000000000 x9 : 0000000000000000
[   96.935982] x8 : 0bfffc0001800000 x7 : 0000000000000000 x6 : 0000000000000000
[   96.936536] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   96.937089] x2 : 0000000000000000 x1 : ffff0000c9600000 x0 : ffff0000c9400080
[   96.939431] Call trace:
[   96.939920] copy_highpage (arch/arm64/include/asm/mte.h:87)
[   96.940443] copy_user_highpage (arch/arm64/mm/copypage.c:40)
[   96.940963] copy_user_large_folio (mm/memory.c:5977 mm/memory.c:6109)
[   96.941535] hugetlb_wp (mm/hugetlb.c:5701)
[   96.941948] hugetlb_fault (mm/hugetlb.c:6237)
[   96.942344] handle_mm_fault (mm/memory.c:5330)
[   96.942794] do_page_fault (arch/arm64/mm/fault.c:513
arch/arm64/mm/fault.c:626)
[   96.943341] do_mem_abort (arch/arm64/mm/fault.c:846)
[   96.943797] el0_da (arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:547)
[   96.944229] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:0)
[   96.944765] el0t_64_sync (arch/arm64/kernel/entry.S:599)
[   96.945383] ---[ end trace 0000000000000000 ]---

2)
Regression on Gravition-V4 boot has noticed this kernel warning while
booting the
6.6.76-rc1 and 6.6.76-rc2.

Boot regression: WARNING-crypto-testmgr-alg_test

[   62.438009] ------------[ cut here ]------------
[   62.440316] alg: self-tests for stdrng using drbg_nopr_hmac_sha512
failed (rc=-22)
[   62.440324] WARNING: CPU: 1 PID: 158 at crypto/testmgr.c:5936
alg_test (crypto/testmgr.c:5936 (discriminator 1))
[   62.443128] Modules linked in:
[   62.443729] CPU: 1 PID: 158 Comm: cryptomgr_test Not tainted 6.6.76-rc2 #1
[   62.445029] Hardware name: Amazon EC2 r8g.large/, BIOS 1.0 11/1/2018
[   62.446248] pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[   62.447588] pc : alg_test (crypto/testmgr.c:5936 (discriminator 1))
[   62.448306] lr : alg_test (crypto/testmgr.c:5936 (discriminator 1))
[   62.449029] sp : ffff8000817c3d40
[   62.449683] x29: ffff8000817c3d40 x28: ffffcf33cddf6388 x27: 0000000000000059
[   62.451056] x26: 00000000ffffffea x25: 00000000ffffffff x24: ffffcf33cf699000
[   62.452417] x23: ffffcf33cddf6388 x22: 000000000000000c x21: ffff0003c4627a80
[   62.453786] x20: ffff0003c4627a00 x19: 0000000000000058 x18: 00000000fffffffe
[   62.455163] x17: 72282064656c6961 x16: 6620323135616873 x15: ffff8000817c3950
[   62.456545] x14: 0000000000000000 x13: 00000000000003f2 x12: 00000000ffffffea
[   62.457927] x11: 00000000ffffefff x10: ffffcf33cf23d2d8 x9 : ffffcf33cf1e5278
[   62.459319] x8 : 0000000000017fe8 x7 : c0000000ffffefff x6 : 0000000000057fa8
[   62.460697] x5 : 0000000000000fff x4 : 0000000000000000 x3 : 0000000000000000
[   62.462069] x2 : 0000000000000000 x1 : 0000000000000000 x0 : ffff0003c4697000
[   62.463445] Call trace:
[   62.463940] alg_test (crypto/testmgr.c:5936 (discriminator 1))
[   62.464595] cryptomgr_test (crypto/algboss.c:182)
[   62.465314] kthread (kernel/kthread.c:388)
[   62.465920] ret_from_fork (arch/arm64/kernel/entry.S:862)
[   62.466619] ---[ end trace 0000000000000000 ]---

3)
Regression on qemu-arm64 while running LTP fs fs_fill the following
kernel warning found this was seen from the last rc round also.

Boot regression: WARNING-fs-buffer-mark_buffer_dirty

<3>[  942.039675] Buffer I/O error on dev loop0, logical block 153753,
lost async page write
<3>[  942.040482] I/O error, dev loop0, sector 1222152 op 0x1:(WRITE)
flags 0x100000 phys_seg 1 prio class 2
<3>[  942.041273] Buffer I/O error on dev loop0, logical block 152769,
lost async page write
<4>[  942.048676] ------------[ cut here ]------------
<4>[ 942.051768] WARNING: CPU: 1 PID: 6290 at fs/buffer.c:1188
mark_buffer_dirty (fs/buffer.c:0)
<4>[  942.057394] Modules linked in: btrfs xor xor_neon raid6_pq
zstd_compress libcrc32c tun crct10dif_ce sm3_ce sm3 sha3_ce sha512_ce
sha512_arm64 fuse drm backlight ip_tables x_tables
<4>[  942.068545] CPU: 1 PID: 6290 Comm: fs_fill Not tainted 6.6.76-rc2 #1
<4>[  942.071224] Hardware name: linux,dummy-virt (DT)
<4>[  942.074657] pstate: 83402009 (Nzcv daif +PAN -UAO +TCO +DIT
-SSBS BTYPE=--)
<4>[ 942.076823] pc : mark_buffer_dirty (fs/buffer.c:0)
<4>[ 942.077221] lr : mark_buffer_dirty_inode (fs/buffer.c:682)
<4>[  942.077523] sp : ffff8000822d3820
<4>[  942.077766] x29: ffff8000822d3820 x28: 00000000000278f1 x27:
0000000000000001
<4>[  942.081352] x26: 0000000000000000 x25: 0000000000001000 x24:
ffff8000822d38e0
<4>[  942.081928] x23: ffff8000822d39bc x22: ffff8000822d3920 x21:
ffff0000ce30d1d0
<4>[  942.082381] x20: ffff0000c0480b78 x19: ffff0000fabb3a90 x18:
00000059f17bbe9e
<4>[  942.082841] x17: 0000000000000000 x16: 0000000000000000 x15:
00000000c6a2c000
<4>[  942.084209] x14: 0000000000000001 x13: ffff8000822d0000 x12:
ffff8000822d4000
<4>[  942.085009] x11: edcfb2436f68dc00 x10: 000000000000d84f x9 :
ffffb9036e21ef44
<4>[  942.085793] x8 : 0000000000000418 x7 : 00000000000275d8 x6 :
ffff0000e2a98400
<4>[  942.086706] x5 : ffff0000c77db560 x4 : 00000000ffffffff x3 :
ffff8000822d3710
<4>[  942.087819] x2 : ffff0000c29b4200 x1 : ffff0000ce30d058 x0 :
ffff0000fabb3a90
<4>[  942.091430] Call trace:
<4>[ 942.093962] mark_buffer_dirty (fs/buffer.c:0)
<4>[ 942.095407] ext2_get_blocks (fs/ext2/inode.c:602 fs/ext2/inode.c:765)
<4>[ 942.097279] ext2_get_block (fs/ext2/inode.c:793)
<4>[ 942.098201] __block_write_begin_int (fs/buffer.c:2127)
<4>[ 942.098948] block_write_begin (fs/buffer.c:2235)
<4>[ 942.099493] ext2_write_begin (fs/ext2/inode.c:924)
<4>[ 942.099933] generic_perform_write (mm/filemap.c:4006)
<4>[ 942.102488] __generic_file_write_iter (mm/filemap.c:0)
<4>[ 942.103176] generic_file_write_iter (mm/filemap.c:4125)
<4>[ 942.103607] ext2_file_write_iter (fs/ext2/file.c:0)
<4>[ 942.104071] do_iter_write (fs/read_write.c:736 fs/read_write.c:860)
<4>[ 942.104499] vfs_writev (fs/read_write.c:933)
<4>[ 942.104901] do_writev (fs/read_write.c:976)
<4>[ 942.105307] __arm64_sys_writev (fs/read_write.c:1046)
<4>[ 942.105565] invoke_syscall (arch/arm64/kernel/syscall.c:52)
<4>[ 942.106973] el0_svc_common (include/linux/thread_info.h:127
arch/arm64/kernel/syscall.c:142)
<4>[ 942.107316] do_el0_svc (arch/arm64/kernel/syscall.c:154)
<4>[ 942.107639] el0_svc (arch/arm64/kernel/entry-common.c:133
arch/arm64/kernel/entry-common.c:144
arch/arm64/kernel/entry-common.c:679)
<4>[ 942.110407] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:731)
<4>[ 942.111160] el0t_64_sync (arch/arm64/kernel/entry.S:599)
<4>[  942.113215] ---[ end trace 0000000000000000 ]---

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Source
* kernel version: 6.6.76-rc2
* git tree: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
* git sha: e5534ef3ba233d5207312b032b12b1d3788e94ac
* git describe: v6.6.75-390-ge5534ef3ba23
* project details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23

##Boot log fvp-aemva-qemu-arm64
qemu-arm64 log:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228347/suite/log-parser-test/test/exception-warning-cpu-pid-at-archarm64mmcopypage-copy_highpage/log
fvp-aemva log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228386/suite/log-parser-test/test/exception-warning-cpu-pid-at-archarm64mmcopypage-copy_highpage/log
fvp-aemva details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228386/suite/log-parser-test/test/exception-warning-cpu-pid-at-archarm64mmcopypage-copy_highpage/details/
fvp-aemva-qemu-arm64 history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228347/suite/log-parser-test/test/exception-warning-cpu-pid-at-archarm64mmcopypage-copy_highpage/history/


##Boot log graviton-v4
graviton-v4 log:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228382/suite/log-parser-test/test/warning-warning-0m1mcpu-pid-at-cryptotestmgr-alg_test/log
graviton-v4 details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228382/suite/log-parser-test/test/warning-warning-0m1mcpu-pid-at-cryptotestmgr-alg_test/details/
gravition-v4 history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228382/suite/log-parser-test/test/warning-warning-0m1mcpu-pid-at-cryptotestmgr-alg_test/history/

##Boot log qemu-arm64
* build log: https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27228382/suite/log-parser-test/test/warning-warning-0m1mcpu-pid-at-cryptotestmgr-alg_test/details/
qemu-arm64 fsbuffer details:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27229114/suite/log-parser-test/test/exception-warning-cpu-pid-at-fsbuffer-mark_buffer_dirty/details/
qemu-arm64 fsbuffer history:
https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.6.y/build/v6.6.75-390-ge5534ef3ba23/testrun/27229261/suite/log-parser-test/test/exception-warning-cpu-pid-at-fsbuffer-mark_buffer_dirty/history/


--
Linaro LKFT
https://lkft.linaro.org

