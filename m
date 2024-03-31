Return-Path: <linux-fsdevel+bounces-15783-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96314893000
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 10:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0E2825CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Mar 2024 08:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D329134402;
	Sun, 31 Mar 2024 08:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="E1af0MIc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B20131746;
	Sun, 31 Mar 2024 08:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711874707; cv=none; b=ASjZhm4etoroySNZM7SHPypUllGWchz7JTA0L9hJQ1lBfEDoFwSBJD/6kAL0RflI5zSLfAZ/MkUNLsAAIBmQnAO8CtBHPFeYe37YDR6GMznoRpXjHAH4SpJ1symJl1qCEmjALonN5QDOCCdH3QGxM5kWF4p1hRK8WB1H51ALt1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711874707; c=relaxed/simple;
	bh=CNf8m/nWef9wkixInR6E4NOpXx000CTYoiqaE6ARRBM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=YOho9o/tqDgno3dKSYsO97RmZwiqBoe2ZMvFABUtl+RpS+nrT20p8EPgivMRnI466WV22nvtRywPYJw/jV8rzZg/My27zL/15Bywi3pCnOafdfEQo6tVSLzyM8mcJagKI8nXKIAqHmqfSW/HndFs1Mp7TGVRVFJ5OSfIH5e1pUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=E1af0MIc; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711874698; bh=tBu+Ad0GvUc8I+j976xrx6ZCEBZjX5o7ydCYejD59JE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E1af0MIcwwgHHanggZE7u1ZgOGH/OUXEy/YKxQRtoMkA/EnpA1cuUmIR2iVFc7LFh
	 T1U+/m1cmjrlXTGch9yz2WSW7iwv0TYbIz6USo5DTXe2vZ/g3KQFuVEhzZ4i2+ZN10
	 3kvdAS++WEe1Ba2CtpaOThEtyvIAGovjTnGK8HiQ=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id B38BB8CD; Sun, 31 Mar 2024 16:44:56 +0800
X-QQ-mid: xmsmtpt1711874696tshyse111
Message-ID: <tencent_6CF766EA3CD936E4960C377C4A0C74377609@qq.com>
X-QQ-XMAILINFO: Mdc3TkmnJyI/uQ6d1i0rpitS/WHY3aEsTp4RGE2Rw/OuqxCrWz4BOPf2zajzUA
	 OVQnNkUIZgAGyBK+zkbxNXxuyjMfpzjcaCysDFz6P+IaJsUBjG7ybGHRrhT/wysmMVBj0I1opnWW
	 nXWAXIrhGG4g+lnTwEtj2+wlcEwFXQ1sLVcIzNSY2rrD/D35zMTSPQjOKIwZOh+NHCOsYT93XzG4
	 G4gtVFVHO1D63kETEWyMXWWup6PuCZhNrQkvz9MS4cdsdA9nQsIBn+ALUA0gniPXS8Q2jjburTTp
	 UtqH7tlI0tKUwwd5oeV8qdFfeiu8QYv2qt5PaJiJzArTEhIt92zlW//3ZV0K+8RgI0nlU6ljDWCa
	 Zl05gZSxGzb0Nrejcie3UgMcPXZCtxxX1gqmKYjCgiJlkEJ+ppITyssSRec3tY4W4SLNkMgQt+aD
	 vF2C3bhV/rpyv0cXJKCvyQtNQ2zffU4qo4LzjgKWDWuqvM+Gra40aCHR4uxJPy9HMbGlE0GrOasr
	 5QmNDM1xSCcIWGv+y7sWk9khpy7syy3/ahflyLYGg1BSOvffGr2hzBM5huI3ucmHssx8QnkwQ4Xh
	 K3nhBEDr2ANCrovAhX0eT65U9zTvYSgHeswbps8NzTY6WTwV8bV8gt82jYYd1eH3KRsQlDe+dwWV
	 OGLYkQRSiMd6zxtnD7fcSiPt3P+npQq1t4q9KBDPCyxGhXWh0nKEKNOVyyf+JNXBv+1T02AKmRpm
	 8CNToJYt5/Y7UDfGu9wpg1WGxZmRdOuIq4rRbFdWE4kt12BL7F4mS6L68C/3lEiqCaRhZhcfF6YW
	 xO1UGhpse9wGZWLw5NUf2uDVpxtl9l1YaJfC/ZSUV6/7FHeioyRpACSuX4VzAi6ID0MTtlUFdOIJ
	 4Md8/+BPyBfqiOAxBiKQ+ptf0qmxXLETNUlmwgHGpqFrN+AZtAmDOyTXbHuvXtfzl9iiyctBR4
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+c824290332add8067111@syzkaller.appspotmail.com
Cc: jfs-discussion@lists.sourceforge.net,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	shaggy@kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] jfs: fix task hung in lmLogClose
Date: Sun, 31 Mar 2024 16:44:57 +0800
X-OQ-MSGID: <20240331084456.1126705-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000041ac86061400b95d@google.com>
References: <00000000000041ac86061400b95d@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
INFO: task syz-executor394:6204 blocked for more than 143 seconds.
      Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor394 state:D stack:0     pid:6204  tgid:6204  ppid:6201   flags:0x0000000c
Call trace:
 __switch_to+0x314/0x560 arch/arm64/kernel/process.c:553
 context_switch kernel/sched/core.c:5400 [inline]
 __schedule+0x1498/0x24b4 kernel/sched/core.c:6727
 __schedule_loop kernel/sched/core.c:6802 [inline]
 schedule+0xb8/0x19c kernel/sched/core.c:6817
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:6874
 __mutex_lock_common+0xbd8/0x21a0 kernel/locking/mutex.c:684
 __mutex_lock kernel/locking/mutex.c:752 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:804
 lmLogClose+0xc8/0x4d4 fs/jfs/jfs_logmgr.c:1444
 jfs_umount+0x274/0x360 fs/jfs/jfs_umount.c:114
 jfs_put_super+0x90/0x188 fs/jfs/super.c:194
 generic_shutdown_super+0x128/0x2b8 fs/super.c:641
 kill_block_super+0x44/0x90 fs/super.c:1675
 deactivate_locked_super+0xc4/0x12c fs/super.c:472
 deactivate_super+0xe0/0x100 fs/super.c:505
 cleanup_mnt+0x34c/0x3dc fs/namespace.c:1267
 __cleanup_mnt+0x20/0x30 fs/namespace.c:1274
 task_work_run+0x230/0x2e0 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 do_notify_resume+0x178/0x1f4 arch/arm64/kernel/entry-common.c:151
 exit_to_user_mode_prepare arch/arm64/kernel/entry-common.c:169 [inline]
 exit_to_user_mode arch/arm64/kernel/entry-common.c:178 [inline]
 el0_svc+0xac/0x168 arch/arm64/kernel/entry-common.c:713
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
[Fix]
The jfs_log_mutex cannot distinguish different superblocks, resulting in multiple
different superblocks competing for jfs_log_mutex.

Reported-and-tested-by: syzbot+c824290332add8067111@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/jfs/jfs_incore.h |  1 +
 fs/jfs/jfs_logmgr.c | 26 +++++++++++++-------------
 fs/jfs/super.c      |  1 +
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/jfs/jfs_incore.h b/fs/jfs/jfs_incore.h
index 10934f9a11be..56d336a49985 100644
--- a/fs/jfs/jfs_incore.h
+++ b/fs/jfs/jfs_incore.h
@@ -197,6 +197,7 @@ struct jfs_sb_info {
 	kgid_t		gid;		/* gid to override on-disk gid */
 	uint		umask;		/* umask to override on-disk umask */
 	uint		minblks_trim;	/* minimum blocks, for online trim */
+	struct mutex    simutex;
 };
 
 /* jfs_sb_info commit_state */
diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 73389c68e251..b5609a7618e5 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -155,7 +155,6 @@ do {						\
  */
 static LIST_HEAD(jfs_external_logs);
 static struct jfs_log *dummy_log;
-static DEFINE_MUTEX(jfs_log_mutex);
 
 /*
  * forward references
@@ -1068,19 +1067,19 @@ int lmLogOpen(struct super_block *sb)
 	if (sbi->mntflag & JFS_INLINELOG)
 		return open_inline_log(sb);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	list_for_each_entry(log, &jfs_external_logs, journal_list) {
 		if (file_bdev(log->bdev_file)->bd_dev == sbi->logdev) {
 			if (!uuid_equal(&log->uuid, &sbi->loguuid)) {
 				jfs_warn("wrong uuid on JFS journal");
-				mutex_unlock(&jfs_log_mutex);
+				mutex_unlock(&sbi->simutex);
 				return -EINVAL;
 			}
 			/*
 			 * add file system to log active file system list
 			 */
 			if ((rc = lmLogFileSystem(log, sbi, 1))) {
-				mutex_unlock(&jfs_log_mutex);
+				mutex_unlock(&sbi->simutex);
 				return rc;
 			}
 			goto journal_found;
@@ -1088,7 +1087,7 @@ int lmLogOpen(struct super_block *sb)
 	}
 
 	if (!(log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL))) {
-		mutex_unlock(&jfs_log_mutex);
+		mutex_unlock(&sbi->simutex);
 		return -ENOMEM;
 	}
 	INIT_LIST_HEAD(&log->sb_list);
@@ -1130,7 +1129,7 @@ int lmLogOpen(struct super_block *sb)
 	sbi->log = log;
 	LOG_UNLOCK(log);
 
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	return 0;
 
 	/*
@@ -1144,7 +1143,7 @@ int lmLogOpen(struct super_block *sb)
 	fput(bdev_file);
 
       free:		/* free log descriptor */
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	kfree(log);
 
 	jfs_warn("lmLogOpen: exit(%d)", rc);
@@ -1187,12 +1186,13 @@ static int open_inline_log(struct super_block *sb)
 static int open_dummy_log(struct super_block *sb)
 {
 	int rc;
+	struct jfs_sb_info *sbi = JFS_SBI(sb);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	if (!dummy_log) {
 		dummy_log = kzalloc(sizeof(struct jfs_log), GFP_KERNEL);
 		if (!dummy_log) {
-			mutex_unlock(&jfs_log_mutex);
+			mutex_unlock(&sbi->simutex);
 			return -ENOMEM;
 		}
 		INIT_LIST_HEAD(&dummy_log->sb_list);
@@ -1205,7 +1205,7 @@ static int open_dummy_log(struct super_block *sb)
 		if (rc) {
 			kfree(dummy_log);
 			dummy_log = NULL;
-			mutex_unlock(&jfs_log_mutex);
+			mutex_unlock(&sbi->simutex);
 			return rc;
 		}
 	}
@@ -1214,7 +1214,7 @@ static int open_dummy_log(struct super_block *sb)
 	list_add(&JFS_SBI(sb)->log_list, &dummy_log->sb_list);
 	JFS_SBI(sb)->log = dummy_log;
 	LOG_UNLOCK(dummy_log);
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 
 	return 0;
 }
@@ -1441,7 +1441,7 @@ int lmLogClose(struct super_block *sb)
 
 	jfs_info("lmLogClose: log:0x%p", log);
 
-	mutex_lock(&jfs_log_mutex);
+	mutex_lock(&sbi->simutex);
 	LOG_LOCK(log);
 	list_del(&sbi->log_list);
 	LOG_UNLOCK(log);
@@ -1490,7 +1490,7 @@ int lmLogClose(struct super_block *sb)
 	kfree(log);
 
       out:
-	mutex_unlock(&jfs_log_mutex);
+	mutex_unlock(&sbi->simutex);
 	jfs_info("lmLogClose: exit(%d)", rc);
 	return rc;
 }
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index e1be21ca5d6e..23628ca3990c 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -504,6 +504,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 	sbi->uid = INVALID_UID;
 	sbi->gid = INVALID_GID;
 	sbi->umask = -1;
+	mutex_init(&sbi->simutex);
 
 	/* initialize the mount flag and determine the default error handler */
 	flag = JFS_ERR_REMOUNT_RO;
-- 
2.43.0


