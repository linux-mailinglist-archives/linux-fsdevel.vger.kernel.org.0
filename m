Return-Path: <linux-fsdevel+bounces-56230-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3537B14814
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 08:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14BAD541399
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 06:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D784D221F08;
	Tue, 29 Jul 2025 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="oDsCxCJT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEDE186A;
	Tue, 29 Jul 2025 06:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753769852; cv=none; b=qo22cwE+SLMRYFL10IYhzo2+O0KyU/ABhEKPm4EC0rHWCii7TB0QlC2oXU/DNCmESfSlXuZKESKlZ4ZArUQqHgr71Leaw9lXC03/uGh6EayY9f8bzBWg/N9nvGCOfS2U27wTcJB65430Rwd5vSnkG5xLauiVkq/IYr30YLvlM/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753769852; c=relaxed/simple;
	bh=DgSzI9e8yXmTw0Rz6M9RO4vXEASiqJl9wSqSfx/F2jo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=tly0OM8X4UvNDwGXPN2Sns3PHWFzc7MOoYfJSWrrEXAXnv3XOIkzNGn2mp5oqOywSWrPqPDCF45ed3e3uaWbauUkMzz/RavD/0IY/zConoJ4ffQPodg5gG19+nUGaydOBfVlxS5AvE/rCaj+UyknFbJzyqsaAxPye6i5PX8yf5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=oDsCxCJT; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1753769837; bh=Dw+EcVkkA9PZHnVR1tGx0PHyXkGPtmLkIH5AjDuxqCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oDsCxCJTYvi4vkHbf/OsmnvbIHirYX4lU/1UPDMqqUhv0J71SmHz0Rocw7etrx56z
	 f01n3riKlLruIUxSgPozUmLzTWsh1jV2TBpi5AOCruTv1X2aW93apCrVjFxxRtmXNs
	 T2ZrmEz4h6ZGnDOrzQzOZ3sk8NOsY2mehGoH36aI=
Received: from pek-lxu-l1.corp.ad.wrs.com ([111.198.231.14])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 44982808; Tue, 29 Jul 2025 14:17:09 +0800
X-QQ-mid: xmsmtpt1753769829t8hn0as92
Message-ID: <tencent_24D0464B099CEEC72EFD4C95A7FB86DB9206@qq.com>
X-QQ-XMAILINFO: N6f4voFg4bqAG1ViUwkRmAC5Sf9IE+rDDMQBpFxIILDHtWQecx3aMfKxojsEtp
	 PW5c7+CwxnwHJAx89p+0Yz6R2lEHTZ28DElrApKbGVRRipWDT0jUtWrneoLWCxdKOUmugZwhnPMw
	 eJk3mVRP/7ylv0pr+k0jcE9n/utTK6sPHbej17CDy2AW0e/ClF8eiic0Q1OuJyXLI72hJ2KVVV/q
	 mA3XmGvLEgFcSHlLGLyJGpRgxefoa0tM9/JoXH0EoH6VdINtA06ozJ17uhggsGVW1Obf0yJv+R3V
	 v+98UfHwYq2mOGqHO0lEd5IP+QzKYjDDHX+uN7UbJIkTLTr/tvD0Jzu0ut7jbThshr+w6Ps9Zhrg
	 le7Y/JF/P4VukoZcRJm2QfbDVzH/sE/MZJzINfOUQUISY2PokPWaUScDfqnH5OJ6Py2pHGppsb2B
	 vyzQ0bllumF+A99ptJY9z0LIeMIfMhTmqcyeefNdWgkEX/vht4dqS2DZr7p/mcr3Me6BokCaa1Cy
	 fdGh7GKDnxUSk71leNP/4auzmsq+qjBuj93V0+DR0PG6oZlF4l8ag2KvxUb8lWgvqjQCCSEB1OzO
	 EVg/Rd+YM2Ic2DXrzyL1Lh0NRpgYToU9XWyudy8Oj5w+/lVom2P5K8O1cByjUPhh8rblBDQw+j/g
	 6rnpqBKcpM93hL6EgKfu/9p+7HD/L27owa6HllPjGxP1sXKH9x+sqMwDyKKHr1gqk752kO185mHZ
	 MSzywZuVvLeS9iuO1ey/tCKF+li7S3o0rneL1QLLNCZKOX0xZuhUR0hWRoB6r8dJH+RcvRa0JFPj
	 k/TPCSzYdfwCeJMbV+/HRGe2txVdG0eVoc9uOSbRtOD2bd/FbUhbisRoazYHHoJwqV2ABa3B9cYv
	 3h1001qB8ikabWLfiRlPhue0I3TtRuPPEJvEqm4SlJ2wo9Z/c4d2a1NatqI52U9/fU+QKubzMbMX
	 /IVfW8t0Yc1RZ5XhuGkxMUBbtaYHfqe7r/SJHZBTY/cqsgW1KKIsbtsNQYRmDaRXqwwvJPvBWZrI
	 r2m+PH3Xn5o0bx80hy
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: eadavis@qq.com
Cc: hirofumi@mail.parknet.co.jp,
	linkinjeon@kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sj1557.seo@samsung.com,
	syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com,
	viro@zeniv.linux.org.uk
Subject: [PATCH V2] fat: Prevent the race of read/write the FAT32 entry
Date: Tue, 29 Jul 2025 14:17:10 +0800
X-OQ-MSGID: <20250729061709.2621336-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <tencent_341B732549BA50BB6733349E621B0D4B7A08@qq.com>
References: <tencent_341B732549BA50BB6733349E621B0D4B7A08@qq.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reports data-race in fat32_ent_get/fat32_ent_put. 

	CPU0(Task A)			CPU1(Task B)
	====				====
	vfs_write
	new_sync_write
	generic_file_write_iter
	fat_write_begin
	block_write_begin		vfs_statfs
	fat_get_block			statfs_by_dentry
	fat_add_cluster			fat_statfs
	fat_ent_write			fat_count_free_clusters
	fat32_ent_put			fat32_ent_get

Task A's write operation on CPU0 and Task B's read operation on CPU1 occur
simultaneously, generating an race condition.

Add READ/WRITE_ONCE to solve the race condition that occurs when accessing
FAT32 entry.

Reported-by: syzbot+d3c29ed63db6ddf8406e@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d3c29ed63db6ddf8406e
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
V1 -> V2: using READ/WRITE_ONCE to fix

 fs/fat/fatent.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/fat/fatent.c b/fs/fat/fatent.c
index 1db348f8f887..a9eecd090d91 100644
--- a/fs/fat/fatent.c
+++ b/fs/fat/fatent.c
@@ -146,8 +146,8 @@ static int fat16_ent_get(struct fat_entry *fatent)
 
 static int fat32_ent_get(struct fat_entry *fatent)
 {
-	int next = le32_to_cpu(*fatent->u.ent32_p) & 0x0fffffff;
-	WARN_ON((unsigned long)fatent->u.ent32_p & (4 - 1));
+	int next = le32_to_cpu(READ_ONCE(*fatent->u.ent32_p)) & 0x0fffffff;
+	WARN_ON((unsigned long)READ_ONCE(fatent->u.ent32_p) & (4 - 1));
 	if (next >= BAD_FAT32)
 		next = FAT_ENT_EOF;
 	return next;
@@ -187,8 +187,8 @@ static void fat16_ent_put(struct fat_entry *fatent, int new)
 static void fat32_ent_put(struct fat_entry *fatent, int new)
 {
 	WARN_ON(new & 0xf0000000);
-	new |= le32_to_cpu(*fatent->u.ent32_p) & ~0x0fffffff;
-	*fatent->u.ent32_p = cpu_to_le32(new);
+	new |= le32_to_cpu(READ_ONCE(*fatent->u.ent32_p)) & ~0x0fffffff;
+	WRITE_ONCE(*fatent->u.ent32_p, cpu_to_le32(new));
 	mark_buffer_dirty_inode(fatent->bhs[0], fatent->fat_inode);
 }
 
-- 
2.43.0


