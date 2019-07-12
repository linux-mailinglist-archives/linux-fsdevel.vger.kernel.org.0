Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB256645A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 04:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbfGLCXH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jul 2019 22:23:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:35646 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728485AbfGLCXH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jul 2019 22:23:07 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B564030897464F660B2C;
        Fri, 12 Jul 2019 10:23:02 +0800 (CST)
Received: from RH5885H-V3.huawei.com (10.90.53.225) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Fri, 12 Jul 2019 10:22:54 +0800
From:   SunKe <sunke32@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sunke32@huawei.com>
Subject: [PATCH] fs/sync.c: Fix UBSAN Undefined behaviour in sync_file_range
Date:   Fri, 12 Jul 2019 10:28:37 +0800
Message-ID: <1562898517-143943-1-git-send-email-sunke32@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a UBSAN report:
UBSAN: Undefined behaviour in ../fs/sync.c:298:10
signed integer overflow:
-8 + -9223372036854775807 cannot be represented in type 'long long int'
CPU: 0 PID: 15876 Comm: syz-executor.3 Not tainted
Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
Call trace:
[<ffffff90080ac450>] dump_backtrace+0x0/0x698 arch/arm64/kernel/traps.c:96
[<ffffff90080acb20>] show_stack+0x38/0x60 arch/arm64/kernel/traps.c:234
[<ffffff9008ca4500>] __dump_stack lib/dump_stack.c:15 [inline]
[<ffffff9008ca4500>] dump_stack+0x1a8/0x230 lib/dump_stack.c:51
[<ffffff9008d7e078>] ubsan_epilogue+0x34/0x9c lib/ubsan.c:164
[<ffffff9008d7ebb4>] handle_overflow+0x228/0x280 lib/ubsan.c:195
[<ffffff9008d7ed28>] __ubsan_handle_add_overflow+0x4c/0x68 lib/ubsan.c:203
[<ffffff900874c2b8>] SYSC_sync_file_range fs/sync.c:298 [inline]
[<ffffff900874c2b8>] SyS_sync_file_range+0x350/0x3e8 fs/sync.c:285
[<ffffff9008094480>] el0_svc_naked+0x30/0x34

When calculate the endbyte, there maybe an overflow, even if no effect
the kernel, but I also want to avoid overflowing and avoid UBSAN reporting.
The original compare is to ensure the offset >= 0 && nbytes >= 0 && no
overflow happened.

I do the calculate after compare. ensure the offset >= 0 && nbytes >= 0 &&
no overflow may happen first.

Signed-off-by: SunKe <sunke32@huawei.com>
---
 fs/sync.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/sync.c b/fs/sync.c
index 4d1ff01..5827471 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -246,15 +246,15 @@ int sync_file_range(struct file *file, loff_t offset, loff_t nbytes,
 	if (flags & ~VALID_FLAGS)
 		goto out;
 
-	endbyte = offset + nbytes;
-
 	if ((s64)offset < 0)
 		goto out;
-	if ((s64)endbyte < 0)
+	if ((s64)nbytes < 0)
 		goto out;
-	if (endbyte < offset)
+	if (S64_MAX - offset < nbytes)
 		goto out;
 
+	endbyte = offset + nbytes;
+
 	if (sizeof(pgoff_t) == 4) {
 		if (offset >= (0x100000000ULL << PAGE_SHIFT)) {
 			/*
-- 
2.7.4

