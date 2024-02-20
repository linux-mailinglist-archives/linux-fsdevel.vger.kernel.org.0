Return-Path: <linux-fsdevel+bounces-12082-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B32D85B1BC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 04:55:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1B01C212AE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Feb 2024 03:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56795482FC;
	Tue, 20 Feb 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ds40mMzW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2242350A98;
	Tue, 20 Feb 2024 03:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708401325; cv=none; b=XKOQZhsQpNlyLZPYZPikHUYIv9X1eQYbJuUonK4UzeTz2rPeDAlwHE8ppSPUPP4BOIMOHPj1xZGyjupCBulrMyk/1/nt9fc3eDj7vG/Eu9etqWdZVHdWCIAwRl1t22aBUEkqVpC8VjP83Wc1FKP4iVS2iu9srQNbNJ0ZYg4YR9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708401325; c=relaxed/simple;
	bh=ZdFn5apitN8GnM3/p1LTDMKxEr8qz7tAt/krl7HUDzY=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=t1Q5TO1MvJZVm6YCYi2wfEUQgA+lX8m2cc7zovql9SgxAKiDk3zve84G15rXLTN7nTDez7OA0fI1gKly1EyRcAGP6WfluXzVyme53mDQDmATcm4vDwQ7j+9W30uoSPRtVujZCUoFiMZYf2DgzfK2XX0TJX3WdcIBPSmS9MLTTK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ds40mMzW; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1708401320; bh=3jTd95gK70X2nBcjTwzGRdH17uQgMXk8jURH3DqzqBg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ds40mMzWs5S7CQnjZvv+wz/M/2ornf/6xiPjbpJv2S2K+Usf+gIXyhR9hSi7jFHey
	 m1E4rABPFK9o9ftbJhJfeb/EfAhkX/7m7VMdpNlk4vmSlL7v7RYcgHhaaCCg3jJLgB
	 8CmOs7PUS5/fS8U5WU2q4oCCWRLQGCnmbLS8TnAI=
Received: from pek-lxu-l1.wrs.com ([111.198.228.140])
	by newxmesmtplogicsvrsza10-0.qq.com (NewEsmtp) with SMTP
	id DD198E4D; Tue, 20 Feb 2024 11:55:17 +0800
X-QQ-mid: xmsmtpt1708401317t2ce8lavy
Message-ID: <tencent_E860EA86EF0ECC0079FA6D3C2D496D30940A@qq.com>
X-QQ-XMAILINFO: N7h1OCCDntujaWSH7ZPN/fW7iDszXhnNNTb4Zx30q9IYTmSszZI/yKqW8bTsww
	 T6SBI4F+U11e1E9IceIVvzmtwGalk9Db3cOzrs24uSJ2kFV/JaJReUl/N53YvWmDm5LkHPFLfcmy
	 qb8EVpFKFnVA323lvRH3lBdWOEmsQSf2cBzK/GtmYoSuABPsIVX6mUQn/0ya1IWl1i16imYyGiKR
	 f95nA0ILysOM09HQ/zOwavFCVHTpTeCj3lN4VEXLQv47HSoZJY3LHVz41c13/6zyLIWiW64ys+v6
	 8bsr99bFuw7kPiw19ouP2sznwDyZkeW5tjGYpNTxCSMEJFnlR3h/eMMmpDvFUYIVfFYFC+2HmeDD
	 kvhb5yEMRCTcqX2wFxFq7MgMk8gWCZbyyH8etArx75dt0IJjlPViH7E2T9V7FznLZ2tsg4/LzdTG
	 vgtBoRmuE0KpdZAzxFuNFQcf84GGeszTB4gmzmb3lNJ+Q06co9n5wjl8fb6g49IN5OpSUeBajy6X
	 e0mP5jTQf+zQiQWFA5X999GX9k8KkSrXdUqdvQcy1OlU8LFLwyXkKWbpWqSyvT1F0SLVJtQosIam
	 z8vHy3r4HvRZfiC3LLX7wqEead4BCgcc5RHIYWep4A6Q3xvGwTJMZqH9UO3ngjCwnk4PcLkHuv5v
	 GTfdCfyi0/Y6zrJ2ClRmKeuop0iZ3ySsQC2w94i5d5q9hwBH9tdkGTw67duE3aIqXcIu3M0L5t/l
	 ap1zMzu41lQMAfLLZv/6NVknTBGzhsqKa612+Cro7uxjy5UruNacG1CTNQdhBQ1ZtVVON3lSW7tH
	 wkmHRYfA2SJ6P0ZyCUZJewPk5POkYs2eAWJ1Ax+7S5xE+QocA7xjNjD9Yu+AIeOpDw0kIRD4NkGS
	 zH5Qa72+T2VJD9LQ3u2EHN72tg8XRNCMo+g54ugNYZ3Kk4eKsJlH2Qtl/xlGsRng==
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: fix uaf in jfs_syncpt
Date: Tue, 20 Feb 2024 11:55:18 +0800
X-OQ-MSGID: <20240220035517.2079019-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <0000000000003d021006119cbf46@google.com>
References: <0000000000003d021006119cbf46@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

During the execution of the jfs lazy commit, the jfs file system was unmounted,
causing the sbi and jfs log objects to be released, triggering this issue.
The solution is to add mutex to synchronize jfs lazy commit and jfs unmount 
operations.

Reported-and-tested-by: syzbot+c244f4a09ca85dd2ebc1@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_incore.h | 1 +
 fs/jfs/jfs_txnmgr.c | 7 ++++++-
 fs/jfs/jfs_umount.c | 2 ++
 fs/jfs/super.c      | 1 +
 4 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index dd4264aa9bed..15955dd86bfd 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -197,6 +197,7 @@ struct jfs_sb_info {
 	kgid_t		gid;		/* gid to override on-disk gid */
 	uint		umask;		/* umask to override on-disk umask */
 	uint		minblks_trim;	/* minimum blocks, for online trim */
+	struct mutex log_mutex;
 };
 
 /* jfs_sb_info commit_state */
diff --git a/fs/jfs/jfs_txnmgr.c b/fs/jfs/jfs_txnmgr.c
index be17e3c43582..eb60862dc61b 100644
--- a/fs/jfs/jfs_txnmgr.c
+++ b/fs/jfs/jfs_txnmgr.c
@@ -2665,6 +2665,9 @@ static void txLazyCommit(struct tblock * tblk)
 
 	log = (struct jfs_log *) JFS_SBI(tblk->sb)->log;
 
+	if (!log)
+		return;
+
 	spin_lock_irq(&log->gclock);	// LOGGC_LOCK
 
 	tblk->flag |= tblkGC_COMMITTED;
@@ -2730,10 +2733,12 @@ int jfs_lazycommit(void *arg)
 				list_del(&tblk->cqueue);
 
 				LAZY_UNLOCK(flags);
+				mutex_lock(&sbi->log_mutex);
 				txLazyCommit(tblk);
+				sbi->commit_state &= ~IN_LAZYCOMMIT;
+				mutex_unlock(&sbi->log_mutex);
 				LAZY_LOCK(flags);
 
-				sbi->commit_state &= ~IN_LAZYCOMMIT;
 				/*
 				 * Don't continue in the for loop.  (We can't
 				 * anyway, it's unsafe!)  We want to go back to
diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 8ec43f53f686..04788cf3a471 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -51,6 +51,7 @@ int jfs_umount(struct super_block *sb)
 	 *
 	 * if mounted read-write and log based recovery was enabled
 	 */
+	mutex_lock(&sbi->log_mutex);
 	if ((log = sbi->log))
 		/*
 		 * Wait for outstanding transactions to be written to log:
@@ -113,6 +114,7 @@ int jfs_umount(struct super_block *sb)
 		 */
 		rc = lmLogClose(sb);
 	}
+	mutex_unlock(&sbi->log_mutex);
 	jfs_info("UnMount JFS Complete: rc = %d", rc);
 	return rc;
 }
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 8d8e556bd610..cf291bdd094f 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -504,6 +504,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->uid = INVALID_UID;
 	sbi->gid = INVALID_GID;
 	sbi->umask = -1;
+	mutex_init(&sbi->log_mutex);
 
 	/* initialize the mount flag and determine the default error handler */
 	flag = JFS_ERR_REMOUNT_RO;
-- 
2.43.0


