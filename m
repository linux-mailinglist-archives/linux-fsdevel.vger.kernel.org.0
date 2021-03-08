Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1865330838
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 07:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhCHGkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 01:40:03 -0500
Received: from atcsqr.andestech.com ([60.248.187.195]:65031 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhCHGjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:39:42 -0500
X-Greylist: delayed 1937 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Mar 2021 01:39:42 EST
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 12867OQS042237
        for <linux-fsdevel@vger.kernel.org>; Mon, 8 Mar 2021 14:07:24 +0800 (GMT-8)
        (envelope-from ruinland@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 12866qZj041532;
        Mon, 8 Mar 2021 14:06:52 +0800 (GMT-8)
        (envelope-from ruinland@andestech.com)
Received: from APC301.andestech.com (10.0.12.128) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Mar 2021
 14:06:52 +0800
From:   Ruinland Chuan-Tzu Tsai <ruinland@andestech.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <ruinland@andestech.com>, <alankao@andestech.com>
Subject: [PATCH 0/1] fs: binfmt_elf.c:elf_core_dump() link error on RV32 platform without optimization
Date:   Mon, 8 Mar 2021 14:03:55 +0800
Message-ID: <20210308060356.329-1-ruinland@andestech.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.12.128]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 12866qZj041532
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi all,

Just as the mail title, recently on RISC-V 32bit platform, I've been
encountering linking errors when building a certain part of Kernel,
`fs/ext4/extents.c`, without optimization (-O0) for debugging .

The error message GNU ld giving out indicates that it fails to resolve
undefined symbol "__divdi3", which is one of integer library routines
shipped by libgcc.

After conducting an autopsy, I can locate the root cause is that the
roundup() macro, which does division on 64bit data, is used inside
`fs/ext4/extends.c:elf_core_dump()`. Unfortunately, it's highly unlikely
to fit 64bit data into instruction encoding space on 32bit machines,
hence GCC will try to use its own software routines inside libgcc and
causing the linking error mentioned above.

Yet with default optimization level "-O2", the logic could be optimized
into bitwise instructions ("shift" and "and").Thus the linking error
won't occur.

Though I can kludge the build process by modifying
`scripts/link-vmlinux.sh:vmlinux_link()` to force it link kernel
against libgcc.a, still I'm wondering if it's desirable to work this
issue out by either :

(1) replacing `roundup()` with `round_up()` since `ELF_EXEC_PAGESIZE`
must be the power of 2. (The attached patch.)

or
 
(2) duplicate the logic from `roundup()` and use kernel-provided
`div_s64()` instead of plain division. The most recent relating patch I
saw is 013ad043, which takes this approach.

In my humble opinion, even it's understandable to expect a reasonable
level of optimization in the real world just as glibc expects at least "-Og"
is used, still, I feel absurd to depends on the optimization on
"replacing division with shift and and" to save the day.

Cordially yours,
Ruinland

-- 
2.17.1

