Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C9D2E15BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Dec 2020 03:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgLWCwy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 22 Dec 2020 21:52:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:49580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729307AbgLWCVV (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 22 Dec 2020 21:21:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CDF05221E5;
        Wed, 23 Dec 2020 02:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608690065;
        bh=oyo0dMFmeIP9On4Qxj8Vvt0/uXxaCwSpx7Tdp1BfnGo=;
        h=From:To:Cc:Subject:Date:From;
        b=JZmRrE17llySnJSzzSqlah2zq6SkUD/4llBQ476eL6SW119FwU1JvD/r8OabNU8a8
         dyn8ynz9wORih+kDwtahVeg/KHres9t6S4hYWj3zsLjx1zJrsnM615HxMyfKneKGV4
         LdW49ABOkxrwPMh7ktAtBWUYkJcvkckMOdAcVQu5DufvXPjJR53X6EsAtwxTFiEqpg
         6IlbQ1nDGBfNfDRvsALkrg03ouVSoS7ug/DHSgBlCCGS6MgPEFhEqk/IDDDc1FARhn
         /FvKglcqqhrCh7waRSaYCMgJY94tYZryk+4zhSfOiyOySs1OUyKf3t2ZCsxdtG3IZy
         PY45El5I+pIhg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Luo Meng <luomeng12@huawei.com>, Jeff Layton <jlayton@kernel.org>,
        Sasha Levin <sashal@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 01/87] locks: Fix UBSAN undefined behaviour in flock64_to_posix_lock
Date:   Tue, 22 Dec 2020 21:19:37 -0500
Message-Id: <20201223022103.2792705-1-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Luo Meng <luomeng12@huawei.com>

[ Upstream commit 16238415eb9886328a89fe7a3cb0b88c7335fe16 ]

When the sum of fl->fl_start and l->l_len overflows,
UBSAN shows the following warning:

UBSAN: Undefined behaviour in fs/locks.c:482:29
signed integer overflow: 2 + 9223372036854775806
cannot be represented in type 'long long int'
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xe4/0x14e lib/dump_stack.c:118
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:161
 handle_overflow+0x193/0x1e2 lib/ubsan.c:192
 flock64_to_posix_lock fs/locks.c:482 [inline]
 flock_to_posix_lock+0x595/0x690 fs/locks.c:515
 fcntl_setlk+0xf3/0xa90 fs/locks.c:2262
 do_fcntl+0x456/0xf60 fs/fcntl.c:387
 __do_sys_fcntl fs/fcntl.c:483 [inline]
 __se_sys_fcntl fs/fcntl.c:468 [inline]
 __x64_sys_fcntl+0x12d/0x180 fs/fcntl.c:468
 do_syscall_64+0xc8/0x5a0 arch/x86/entry/common.c:293
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Fix it by parenthesizing 'l->l_len - 1'.

Signed-off-by: Luo Meng <luomeng12@huawei.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/locks.c b/fs/locks.c
index 28270e74be342..465917362eca3 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -479,7 +479,7 @@ static int flock64_to_posix_lock(struct file *filp, struct file_lock *fl,
 	if (l->l_len > 0) {
 		if (l->l_len - 1 > OFFSET_MAX - fl->fl_start)
 			return -EOVERFLOW;
-		fl->fl_end = fl->fl_start + l->l_len - 1;
+		fl->fl_end = fl->fl_start + (l->l_len - 1);
 
 	} else if (l->l_len < 0) {
 		if (fl->fl_start + l->l_len < 0)
-- 
2.27.0

