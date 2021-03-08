Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72544330839
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Mar 2021 07:40:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233949AbhCHGkD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Mar 2021 01:40:03 -0500
Received: from exmail.andestech.com ([60.248.187.195]:49538 "EHLO
        ATCSQR.andestech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCHGjo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Mar 2021 01:39:44 -0500
Received: from ATCSQR.andestech.com (localhost [127.0.0.2] (may be forged))
        by ATCSQR.andestech.com with ESMTP id 12867WZT042241
        for <linux-fsdevel@vger.kernel.org>; Mon, 8 Mar 2021 14:07:32 +0800 (GMT-8)
        (envelope-from ruinland@andestech.com)
Received: from mail.andestech.com (atcpcs16.andestech.com [10.0.1.222])
        by ATCSQR.andestech.com with ESMTP id 12866wZL041553;
        Mon, 8 Mar 2021 14:06:58 +0800 (GMT-8)
        (envelope-from ruinland@andestech.com)
Received: from APC301.andestech.com (10.0.12.128) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.487.0; Mon, 8 Mar 2021
 14:06:56 +0800
From:   Ruinland Chuan-Tzu Tsai <ruinland@andestech.com>
To:     <linux-fsdevel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
CC:     <ruinland@andestech.com>, <alankao@andestech.com>
Subject: [PATCH 1/1] Modifying fs/binfmt_elf.c:elf_core_dump() to use round_up()
Date:   Mon, 8 Mar 2021 14:03:56 +0800
Message-ID: <20210308060356.329-2-ruinland@andestech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210308060356.329-1-ruinland@andestech.com>
References: <20210308060356.329-1-ruinland@andestech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.12.128]
X-DNSRBL: 
X-MAIL: ATCSQR.andestech.com 12866wZL041553
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since roundup() will use plain division which might cause the compiler
to use its own integer library routines (i.e. __divid3() in libgcc) on
32bit mahcines when "O0" is specified. The problem won't occur if it
uses round_up() which utilize bitwise operations (shift & and), and the
limitation that "the divisor must be the power of 2" is true on
ELF_EXEC_PAGESIZE.

Signed-off-by: Ruinland Chuan-Tzu Tsai <ruinland@andestech.com>
---
 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index b12ba98ae..01d4d6d2b 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -2209,7 +2209,7 @@ static int elf_core_dump(struct coredump_params *cprm)
 		offset += sz;
 	}
 
-	dataoff = offset = roundup(offset, ELF_EXEC_PAGESIZE);
+	dataoff = offset = round_up(offset, ELF_EXEC_PAGESIZE);
 
 	offset += vma_data_size;
 	offset += elf_core_extra_data_size();
-- 
2.17.1

