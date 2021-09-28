Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FB941AF81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Sep 2021 14:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240591AbhI1M6z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Sep 2021 08:58:55 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:12770 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240488AbhI1M6z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:58:55 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HJfd81S3QzVpvy;
        Tue, 28 Sep 2021 20:55:56 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 20:57:14 +0800
Received: from linux-suspe12sp5.huawei.com (10.67.133.83) by
 dggpeml500017.china.huawei.com (7.185.36.243) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Tue, 28 Sep 2021 20:57:07 +0800
From:   Chen Jingwen <chenjingwen6@huawei.com>
To:     Chen Jingwen <chenjingwen6@huawei.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Michal Hocko <mhocko@suse.com>,
        Andrei Vagin <avagin@openvz.org>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] elf: don't use MAP_FIXED_NOREPLACE for elf interpreter mappings
Date:   Tue, 28 Sep 2021 20:56:57 +0800
Message-ID: <20210928125657.153293-1-chenjingwen6@huawei.com>
X-Mailer: git-send-email 2.12.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.133.83]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In commit b212921b13bd ("elf: don't use MAP_FIXED_NOREPLACE for elf executable mappings")
we still leave MAP_FIXED_NOREPLACE in place for load_elf_interp.
Unfortunately, this will cause kernel to fail to start with

[    2.384321] 1 (init): Uhuuh, elf segment at 00003ffff7ffd000 requested but the memory is mapped already
[    2.386240] Failed to execute /init (error -17)

The reason is that the elf interpreter (ld.so) has overlapping segments.

readelf -l ld-2.31.so
Program Headers:
  Type           Offset             VirtAddr           PhysAddr
                 FileSiz            MemSiz              Flags  Align
  LOAD           0x0000000000000000 0x0000000000000000 0x0000000000000000
                 0x000000000002c94c 0x000000000002c94c  R E    0x10000
  LOAD           0x000000000002dae0 0x000000000003dae0 0x000000000003dae0
                 0x00000000000021e8 0x0000000000002320  RW     0x10000
  LOAD           0x000000000002fe00 0x000000000003fe00 0x000000000003fe00
                 0x00000000000011ac 0x0000000000001328  RW     0x10000

The reason for this problem is the same as described in
commit ad55eac74f20 ("elf: enforce MAP_FIXED on overlaying elf segments").
Not only executable binaries, elf interpreters (e.g. ld.so) can have
overlapping elf segments, so we better drop MAP_FIXED_NOREPLACE and go
back to MAP_FIXED in load_elf_interp.

Fixes: 4ed28639519c ("fs, elf: drop MAP_FIXED usage from elf_map")
Cc: <stable@vger.kernel.org> # v4.19
Signed-off-by: Chen Jingwen <chenjingwen6@huawei.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 69d900a8473d..a813b70f594e 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -630,7 +630,7 @@ static unsigned long load_elf_interp(struct elfhdr *interp_elf_ex,
 
 			vaddr = eppnt->p_vaddr;
 			if (interp_elf_ex->e_type == ET_EXEC || load_addr_set)
-				elf_type |= MAP_FIXED_NOREPLACE;
+				elf_type |= MAP_FIXED;
 			else if (no_base && interp_elf_ex->e_type == ET_DYN)
 				load_addr = -vaddr;
 
-- 
2.12.3

