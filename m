Return-Path: <linux-fsdevel+bounces-17653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D68B10D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 19:22:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7E2A1F27533
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 17:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE65416D33C;
	Wed, 24 Apr 2024 17:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGTzcU2v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62216D31D;
	Wed, 24 Apr 2024 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713979368; cv=none; b=NXXs/QN3v3g7uBGJk+IjhBE74c8l1yxymP20mPXuFEDjHZVIsLZIu5uaaV4irA3Kdd3zQtbWSf8m/uqedo06PAQDczbrpCBjJMHUx49nFKyGW5wUkYJ4dLSpqF3PapOanJKWcSQnDZeHw4UAWj6cl33THQn4QSHH/cfD9nS8rWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713979368; c=relaxed/simple;
	bh=Yb+OQoCeiGA6k2KlYFUZY/qCE6v4EL88MeEU0q3Gg7Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pPCn/OhgSmMC4XOjwUNCKEXIXXwyl0j0B5DtxxVgOQRwK1vIlkecTNc5KMdTb/b+5UfhzHjn0/eiRjuRtLY9ZQZClhWn46jTbnXuBYqiTUH4hGy48AQa6pjsQqr7qy1oV2mfbUCONJEkFcPxv4aS6vxEONzd5pq5Y9T3MS1nAXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGTzcU2v; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1e9451d8b71so689005ad.0;
        Wed, 24 Apr 2024 10:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713979366; x=1714584166; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vLMNR1xv0JaPuIH7/cMqGXZSflApU/kLSGpTxPwxekk=;
        b=RGTzcU2vtQpn63Udk8JZ8lOkYkA/H7YkC4VH17Wu+GbpM+NdD/kIn+czZcHBrLcHUa
         R3AcKiHkcTG8h3gugQHCUSvMt2i3Xd5jT3gSoNKixfCTlMu9tp3HzU/q51xOdl33DSyS
         OAk6Gq/BcyZRXWT03F7438Lza0MagdiFaTmKQquN2ifRhxJKSk167bbErAPg9VJ6t2oi
         8TgUmVBK/9nBDQExfNDR7f/85NmXsbGqFUgy1hCoaJBHlqrrFSIxkx9SKMUlMgV3Vmy4
         MNVcP9dqmrkYK1Z+LNPDItRfbAUMZA6mvKyswfldq5Iq67qdINYf68DgliEK51aw/sAo
         2kLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713979366; x=1714584166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vLMNR1xv0JaPuIH7/cMqGXZSflApU/kLSGpTxPwxekk=;
        b=dtXkRmj8N7edJPeN3xmlm1u3GiSAqWyRt0TD7xcdFAesGZRltZEv57kMQUM/2wZe63
         tRZi8y1Xn6h9KZTpKgUtWnVJ6CxiJ4i7DMPcdNQPHCxh2AwEyzSr+BIGjhsf2Rly2k0P
         aW1nCpG+349HQc3C1DNoB4k2KfB/p2/v8sZM2WgWEd6uDW7c6zVRMQ14JrbgYBeA95RR
         cxdEmy85ohqX8rjGbxIpLA6wQtkKpyoiVlZd7DSWuoFeJYk6DisD+moKbvRxzOHA5Hwy
         Vu4tdNL1n8SBhNH6/TtHIv9JOKYKam2CHLvUGxRPOW6Ec9pOKmxNZmqTIqnDK3thUnJX
         qWxg==
X-Forwarded-Encrypted: i=1; AJvYcCUSQ39tjSeg+SgsdekWk+N/7F+Z9NJchjuUrq5knMnvcQC700YpXONZuW2qVfSX6H8TlaN9P/i33IHorCKpR20Avpr4lf0lQ+ZZsTEdw44rc9xtvHwhL+sZlB/7LBw7cx8mUZPiAgoxFrbfWg==
X-Gm-Message-State: AOJu0YzAFFv0PGoi73ifCaKLQ2A7WvWmAjoJZwDBmsq4Ok6lGebe1znT
	LBYhiiUjal2O1PNf44QHM10zh7Kcv9uNmUtZ8/7uNDe+vXryJas3/wWHBJnD5Hg=
X-Google-Smtp-Source: AGHT+IEgmCxsGqxWGZUa8bERNgxHtuZTBX9uCMZ1jvAtytfz/tSJn0YI8J6GsPq3BJ3urcBbnegbQQ==
X-Received: by 2002:a17:903:40c2:b0:1e0:ca47:4d96 with SMTP id t2-20020a17090340c200b001e0ca474d96mr3278846pld.3.1713979366074;
        Wed, 24 Apr 2024 10:22:46 -0700 (PDT)
Received: from kernelexploit-virtual-machine.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id p14-20020a170902780e00b001e29ac7cc64sm12428454pll.231.2024.04.24.10.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Apr 2024 10:22:45 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Cc: brauner@kernel.org,
	jlayton@kernel.org,
	eadavis@qq.com,
	jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Date: Thu, 25 Apr 2024 02:22:40 +0900
Message-Id: <20240424172240.148883-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <0000000000000866ea0616cb082c@google.com>
References: <0000000000000866ea0616cb082c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[syzbot report]
UBSAN: array-index-out-of-bounds in fs/jfs/jfs_imap.c:886:2
index 524288 is out of range for type 'struct mutex[128]'
CPU: 0 PID: 113 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x121/0x150 lib/ubsan.c:429
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 1 PID: 113 Comm: jfsCommit Not tainted 6.9.0-rc5-syzkaller-00036-g9d1ddab261f3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 panic+0x349/0x860 kernel/panic.c:348
 check_panic_on_warn+0x86/0xb0 kernel/panic.c:241
 ubsan_epilogue lib/ubsan.c:236 [inline]
 __ubsan_handle_out_of_bounds+0x141/0x150 lib/ubsan.c:429
 diFree+0x21c3/0x2fb0 fs/jfs/jfs_imap.c:886
 jfs_evict_inode+0x32d/0x440 fs/jfs/inode.c:156
 evict+0x2a8/0x630 fs/inode.c:667
 txUpdateMap+0x829/0x9f0 fs/jfs/jfs_txnmgr.c:2367
 txLazyCommit fs/jfs/jfs_txnmgr.c:2664 [inline]
 jfs_lazycommit+0x49a/0xb80 fs/jfs/jfs_txnmgr.c:2733
 kthread+0x2f0/0x390 kernel/kthread.c:388
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..
===========================================================

Due to overflow, a value that is too large is entered into the agno 
value. Therefore, we need to add code to check the agno value.

Reported-by: syzbot+241c815bda521982cb49@syzkaller.appspotmail.com
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 fs/jfs/jfs_imap.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/jfs/jfs_imap.c b/fs/jfs/jfs_imap.c
index 2ec35889ad24..0aac083bc0db 100644
--- a/fs/jfs/jfs_imap.c
+++ b/fs/jfs/jfs_imap.c
@@ -881,6 +881,11 @@ int diFree(struct inode *ip)
 	 */
 	agno = BLKTOAG(JFS_IP(ip)->agstart, JFS_SBI(ip->i_sb));
 
+	if(agno >= MAXAG || agno < 0){
+		jfs_error(ip->i_sb, "invalid array index (0 <= agno < MAXAG), agno = %d\n", agno);
+		return -ENOMEM;
+	}
+
 	/* Lock the AG specific inode map information
 	 */
 	AG_LOCK(imap, agno);
-- 
2.34.1

