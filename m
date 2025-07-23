Return-Path: <linux-fsdevel+bounces-55818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A31CB0F188
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 13:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E091AA2D43
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Jul 2025 11:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9252E5408;
	Wed, 23 Jul 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IQeXItu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D352E425F
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 11:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753271082; cv=none; b=TvzX4F2I0RWY345gwuJVvOhhobDNQWcJrLzjsENL7QcTITPlz0e/ytD1SU6eZp7NMlbpR9gVvNkPKlyAImeNSvxXrP7OExqDlcj2MshAd79e/T0oBfbRuBKbLdEhiPo49oocAGgUneD4GCpcbxD3vBlJ2u08E1Ajl8EJftgCUCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753271082; c=relaxed/simple;
	bh=w+Y7l7YLEM4Ks0nX3k+wkBAicwYypX0OuLGcX9TnVp4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=bep7AxzjGfBqe7qlNzdvGzbriFAZYkq825oe42xWHld1IT+PjdPwLOmQ4s7gnqyE3X8MfQfyFVYV0FvGoghj71U1g5sZuIkyVlrTUOs4epab5TANOyZrdgJbiXKPhMnUGoZq5UnClC+k7B6AIaaqbn5GhLVtu5v7IxWkRxYroBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IQeXItu/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3190fbe8536so5796542a91.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Jul 2025 04:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753271080; x=1753875880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1TM2lXI6LKVFFwwKvZZGZaBeEju7c6SCV2hGX05xnS8=;
        b=IQeXItu/k9wLNVtTUQA6dQoKonpVWHS/7SSM2Xf2sz+cdx2oCPT+u8nPn275Jb1IHA
         e65UeO2Pe1BrNUVyK9WRx9CXAZCrTzhEzRemCZ1Gw7aCWck+6OLSmKfysuSx+4k1Hel5
         w/fj7SPena78wf792UmSqEKYAxrmRzUQupunot60dMaG6tGqLKWSfbY/7I75ue8Rwy7M
         xSlgKe0B6XGThlU2UqT4OOOwKN79N72tVv7Ax8KZh6xqt68WS0GFgXnr4S7mN1tdBAvn
         G1cGc7wPyYxpLAqoYNZQjpsNPHAFhos5BRHcSKLEPi4c6uRW6aMNUHLEJHmyhM6Q9VKm
         xEaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753271080; x=1753875880;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1TM2lXI6LKVFFwwKvZZGZaBeEju7c6SCV2hGX05xnS8=;
        b=PpH5GBuRRSDtqTkHmlXKZ/Ik0X2hMeC7inSivQphzrxbl/+xo9QXwQJtWSrud7it2y
         DfQzJxM0ME5bbHD+PNQ1wXKPOnwZir9zVdzTmB9AU2PGRWTOwbkoQCDGpR/qnHVd0yb4
         eBdfrR81ujPQL0oMAyyTAyalNC1jFpYsGWBX/7X6rhV0eQaamqoRAvLt7dWwR+jNveWX
         sQuPAOQ71BYE2PhWqqelPHvGj9NaTyQs/154/tjJ3iyb1pKbfk4p8SCVrlJEf1m21B91
         R4KHi3AP32TjGY+yWPwHowSRRdKtM2IrvcAieIMlr9yH+9IAH8R1P5BHSXtgnxerd/V5
         dkJw==
X-Gm-Message-State: AOJu0YyoKO8SzUS5Hs0VbG4Ru9m/MC0LQhCQ09aYRCpGUv2G5QwXyYys
	DSKNRZJPdqd6nSifw2RZt7mZsc2dkxqAEh6+VhTgiyyUFgWVbfXaTcxLDBGnHQtRGS6kXhp92CW
	dn69ZQ30Lxz/w9UQeaqvVqn4rCVTw9sQ8EZxjwmLBnlAcfhujpYdcuhI=
X-Gm-Gg: ASbGnctzmjN0+4iIF0rap5UDIK3nqikiUXe94OmDEip9u0Jv8p+kgyJX5Se1lJBegxs
	WcUXF+tLBlGnu193J3CCXuyowXw7EBR1ovV093avkhmxzCz3tEENlHF0qqPPdmYLdnJI8lsxSAP
	5GLFHjtceVI/stHhKNyz2yJjaGdfXWtQB8dRt5j6WivjXWVS9Fzo7l7j9U9bii6ICiPagzoznVp
	XAz1uOI5BE0eB8DCuXU4UeZGe9jH9lqJj6LDNab
X-Google-Smtp-Source: AGHT+IEhV+0xhpn9zGV2a6sm19XLdd8n4FB96H4yqAPVqOdZG5EnD3iwTpL+ZT5wmT24E8Pvq3yy1m+gGSGTHyCf3PM=
X-Received: by 2002:a17:90b:5488:b0:312:1c83:58e9 with SMTP id
 98e67ed59e1d1-31e50792b7bmr4177595a91.5.1753271079656; Wed, 23 Jul 2025
 04:44:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 23 Jul 2025 17:14:28 +0530
X-Gm-Features: Ac12FXzxMQQLVl4FMvovsrunOOtQXchdTouMHZnPEIiuTGf6k4FuubUp0DfE068
Message-ID: <CA+G9fYs5AdVM-T2Tf3LciNCwLZEHetcnSkHsjZajVwwpM2HmJw@mail.gmail.com>
Subject: next-20250721 arm64 16K and 64K page size WARNING fs fuse file.c at fuse_iomap_writeback_range
To: linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	linux-xfs@vger.kernel.org, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
	Andrew Morton <akpm@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	"Darrick J. Wong" <djwong@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	"Liam R. Howlett" <liam.howlett@oracle.com>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>, 
	Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

Regressions found while running LTP msync04 tests on qemu-arm64 running
Linux next-20250721, next-20250722 and next-20250723 with 16K and 64K
page size enabled builds.

CONFIG_ARM64_64K_PAGES=y ( kernel warning as below )
CONFIG_ARM64_16K_PAGES=y ( kernel warning as below )

No warning noticed with 4K page size.
CONFIG_ARM64_4K_PAGES=y works as expected


First seen on the tag next-20250721.
Good: next-20250718
Bad:  next-20250721 to next-20250723

Regression Analysis:
- New regression? Yes
- Reproducibility? Yes

Test regression: next-20250721 arm64 16K and 64K page size WARNING fs
fuse file.c at fuse_iomap_writeback_range

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

## Test log
------------[ cut here ]------------
[  343.828105] WARNING: fs/fuse/file.c:2146 at
fuse_iomap_writeback_range+0x478/0x558 [fuse], CPU#0: msync04/4190
[  343.830969] Modules linked in: btrfs blake2b_generic xor xor_neon
raid6_pq zstd_compress sm3_ce sha3_ce drm fuse backlight ip_tables
x_tables
[  343.833830] CPU: 0 UID: 0 PID: 4190 Comm: msync04 Not tainted
6.16.0-rc7-next-20250723 #1 PREEMPT
[  343.834736] Hardware name: linux,dummy-virt (DT)
[  343.835788] pstate: 03402009 (nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
[  343.836455] pc : fuse_iomap_writeback_range+0x478/0x558 fuse
[  343.837294] lr : iomap_writeback_folio (fs/iomap/buffered-io.c:1586
fs/iomap/buffered-io.c:1710)
[  343.838178] sp : ffff80008b26f8d0
[  343.838668] x29: ffff80008b26f8d0 x28: fff00000e7f8c800 x27: 0000000000000000
[  343.839391] x26: fff00000d4b30000 x25: 0000000000000000 x24: 0000000000000000
[  343.840305] x23: 0000000000000000 x22: fffffc1fc0334200 x21: 0000000000001000
[  343.840928] x20: ffff80008b26fa00 x19: 0000000000000000 x18: 0000000000000000
[  343.841782] x17: 0000000000000000 x16: ffffb8d3b90c67c8 x15: 0000000000000000
[  343.842565] x14: ffffb8d3ba91e340 x13: 0000ffff8ff3ffff x12: 0000000000000000
[  343.843002] x11: 1ffe000004b74a21 x10: fff0000025ba510c x9 : ffffb8d3b90c6308
[  343.843962] x8 : ffff80008b26f788 x7 : ffffb8d365830b90 x6 : ffffb8d3bb6c9000
[  343.844718] x5 : 0000000000000000 x4 : 000000000000000a x3 : 0000000000001000
[  343.845333] x2 : fff00000c0b5ecc0 x1 : 000000000000ffff x0 : 0bfffe000000400b
[  343.846323] Call trace:
[  343.846767] fuse_iomap_writeback_range+0x478/0x558 fuse (P)
[  343.847288] iomap_writeback_folio (fs/iomap/buffered-io.c:1586
fs/iomap/buffered-io.c:1710)
[  343.847930] iomap_writepages (fs/iomap/buffered-io.c:1762)
[  343.848494] fuse_writepages+0xa0/0xe8 fuse
[  343.849112] do_writepages (mm/page-writeback.c:2634)
[  343.849614] filemap_fdatawrite_wbc (mm/filemap.c:386 mm/filemap.c:376)
[  343.850202] __filemap_fdatawrite_range (mm/filemap.c:420)
[  343.850791] file_write_and_wait_range (mm/filemap.c:794)
[  343.851108] fuse_fsync+0x6c/0x138 fuse
[  343.851688] vfs_fsync_range (fs/sync.c:188)
[  343.852002] __arm64_sys_msync (mm/msync.c:96 mm/msync.c:32 mm/msync.c:32)
[  343.852197] invoke_syscall.constprop.0
(arch/arm64/include/asm/syscall.h:61 arch/arm64/kernel/syscall.c:54)
[  343.852914] do_el0_svc (include/linux/thread_info.h:135
(discriminator 2) arch/arm64/kernel/syscall.c:140 (discriminator 2)
arch/arm64/kernel/syscall.c:151 (discriminator 2))
[  343.853389] el0_svc (arch/arm64/include/asm/irqflags.h:82
(discriminator 1) arch/arm64/include/asm/irqflags.h:123 (discriminator
1) arch/arm64/include/asm/irqflags.h:136 (discriminator 1)
arch/arm64/kernel/entry-common.c:169 (discriminator 1)
arch/arm64/kernel/entry-common.c:182 (discriminator 1)
arch/arm64/kernel/entry-common.c:880 (discriminator 1))
[  343.853829] el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:899)
[  343.854350] el0t_64_sync (arch/arm64/kernel/entry.S:596)
[  343.854652] ---[ end trace 0000000000000000 ]---



## Source
* Git tree: https://kernel.googlesource.com/pub/scm/linux/kernel/git/next/linux-next.git
* Project: https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250723/
* Git sha: a933d3dc1968fcfb0ab72879ec304b1971ed1b9a
* Git describe: 6.16.0-rc7-next-20250723
* kernel version: next-20250723
* Architectures: arm64
* Toolchains: gcc-13
* Kconfigs: defconfig + CONFIG_ARM64_64K_PAGES=y
* Kconfigs: defconfig + CONFIG_ARM64_16K_PAGES=y

## Test
* Test log 1: https://qa-reports.linaro.org/api/testruns/29227309/log_file/
* Test log 2: https://qa-reports.linaro.org/api/testruns/29227074/log_file/
* Test run: https://regressions.linaro.org/lkft/linux-next-master/next-20250723/testruns/1713367/
* Test history:
https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20250723/testrun/29227309/suite/log-parser-test/test/exception-warning-fsfusefile-at-fuse_iomap_writeback_range/history/
* Test plan: https://tuxapi.tuxsuite.com/v1/groups/linaro/projects/lkft/tests/30G3hpJVVdXkZKnB15v1qoQOL03
* Build link: https://storage.tuxsuite.com/public/linaro/lkft/builds/30G3dvSFyHHQ3E8CvKH7tjU98I6/
* Kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/30G3dvSFyHHQ3E8CvKH7tjU98I6/config

--
Linaro LKFT
https://lkft.linaro.org

