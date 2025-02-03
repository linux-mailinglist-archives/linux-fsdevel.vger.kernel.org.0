Return-Path: <linux-fsdevel+bounces-40558-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE63FA251BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 04:41:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1BB6E1625A2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 03:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C279B4501A;
	Mon,  3 Feb 2025 03:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="yw9fTVe4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CCF29A5;
	Mon,  3 Feb 2025 03:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738554092; cv=none; b=Z+X8y8j1hnA0ISLEpxaogLxjqCsA3BX0AkqT+n4aOwLrF24KUmy5pJivfMQrsF3YebZukX8S3AJo16llsokvv3bkOrAwNqqbBdbaWCx5uoHxWgN+bS2vwBm//Z6WD3FKp+buUwcen9qTcyw8LBLZv9sMm9L85x88+6sTXAIrpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738554092; c=relaxed/simple;
	bh=2QjPEXJ8qS247NeodoMw7CC7n+N0uXp4G4AAD3qW77Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=JZyF3y+owPSOIQ1IViLvlHuHCz4OPR9v1aN/zrT0l8938Gf3teWFtZv5cdWUkv1mpiHohhO4OQV7ePJ9wKXfj5+HxUHYZO7jvaWO1II3p12Bb2uMZBBwMDi09jZIfQkjN57g/v+QObjWmF6EG80c4qYvK63m2OQRkhMl/NsO4yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=yw9fTVe4; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1738554079; bh=NYnGRtdhOhOsIpPhQadV8J5ByKmTraTOgY6+AzSZqPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yw9fTVe4sK93aJbsvUHoV4hbwlX1Q2SRq85uaAKON8FsJmpydXhwFQ2z/lRoOLmrc
	 wXtfFZdpAO3PJBVhqqorq+hPYQZ6ixt3X+pJO3CQoKjDGUopkjhf0KGE/wBdpOwa75
	 ycWNvdcXEY+NsEOBxwUp3XF/0wHcnaNHRrokqozo=
Received: from pek-lxu-l1.wrs.com ([2408:8435:9910:167a:8cb3:3b5b:faa2:1ccb])
	by newxmesmtplogicsvrszc16-0.qq.com (NewEsmtp) with SMTP
	id 6F7BBA9B; Mon, 03 Feb 2025 11:27:55 +0800
X-QQ-mid: xmsmtpt1738553275t2pg1fiph
Message-ID: <tencent_8D66623CFF36BA96EE36FE4B7474B1778509@qq.com>
X-QQ-XMAILINFO: Ny9b0zP53WzJy+lbJ0qZAmwf362UUI/jsREqewRS4BvBnoXk7sAs4KrUcm8Lyw
	 Lny045v31BUDNhQsh9gHF+jvewaA4y7msrpgcZJFFgqgTRkJ1pSx0xuoFnA19QXhB0alQV2l1gUM
	 rRTbjXFkpNTGOJD2/qSgPLggZvn0p50mqxyqlWXK76jQXRKKVWKhgwEKooAtYNQd6nZIVtHSIpi1
	 euxMJQ+9EuTN2NqjOlASsLjqCP+QP/UmUb0TYO3FtCDyOww3lardHhz71RicGhVTCmLAIPnOpj8o
	 TKLvYl0m1eOgl7dUysLlkRRya01wLPvx62RghEkX23EFRCmecp+OkERkBhYZTkYHplHfSfY1DWvL
	 zAsbw87IKnR2Aj6lQXyeZu0Or3iQXW2Aevyc/yuzN997N2GB5B0F63df9sxc2lZjgpqBADYVE0GL
	 KOa4uLCPG4QV7pT31ZTcWppibKkR1kGe57BYW1H/lZOkfGDTs5AHgse2YyNZrdVxYWj3O3pJBqvm
	 Q9kFCIkz+/jMlixLnojZ61xmEgn+ebWuLRBpk7I8tan8gk87yZZBPxh9XIhWknrgpP2PtO59LxZ4
	 SP38lZPMIm2DPHh7J3XDTLhfvPb9Tj3r6jyaSZliqgMPR5cz1EPjPirpX/Ano+1oGziHUB/fUtGx
	 0/IXkUNat98X2wesDU5t9J95F+wMEELDV+QOnYa5XpivrUVTnMTxUXzWaEj9eD6YTuBvuki8dunO
	 L5fN43sJRjoC8s4z9aumFuGtX2qSm5CZ/p1mFHcw53RcJvH2vuCHOcdQ59Zi+ITAJk2PQablClsE
	 +IUWpLjj6Znehn9MyJuZAWy465gN5dhcfZowCeaIe8jmj5n4rXpSwaV5JxwuY1HjK5wXw9FmX4PA
	 7jGkiEgA5UaN/tRW0lrGkm1GbwaLHQTijFn6R7CVFR
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
Cc: dakr@kernel.org,
	gregkh@linuxfoundation.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rafael@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] debugfs: add fsd's methods initialization
Date: Mon,  3 Feb 2025 11:27:56 +0800
X-OQ-MSGID: <20250203032755.1430494-2-eadavis@qq.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <679f72f6.050a0220.48cbc.000d.GAE@google.com>
References: <679f72f6.050a0220.48cbc.000d.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a uninit-value in full_proxy_unlocked_ioctl. [1]

The newly created fsd does not initialize methods, and increases the
initialization of methods for fsd.

[1]
BUG: KMSAN: uninit-value in full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
 full_proxy_unlocked_ioctl+0xed/0x3a0 fs/debugfs/file.c:399
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0x246/0x440 fs/ioctl.c:892
 __x64_sys_ioctl+0x96/0xe0 fs/ioctl.c:892
 x64_sys_call+0x19f0/0x3c30 arch/x86/include/generated/asm/syscalls_64.h:17
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 41a0ecc0997c ("debugfs: get rid of dynamically allocation proxy_ops")
Reported-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8928e473a91452caca2f
Tested-by: syzbot+8928e473a91452caca2f@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/debugfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index e33cc77699cd..5fbefce2b372 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -102,6 +102,7 @@ static int __debugfs_file_get(struct dentry *dentry, enum dbgfs_get_mode mode)
 		if (!fsd)
 			return -ENOMEM;
 
+		fsd->methods = 0;
 		if (mode == DBGFS_GET_SHORT) {
 			const struct debugfs_short_fops *ops;
 			ops = fsd->short_fops = DEBUGFS_I(inode)->short_fops;
-- 
2.43.0


