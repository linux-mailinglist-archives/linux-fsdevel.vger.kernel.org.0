Return-Path: <linux-fsdevel+bounces-78762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCUiAVTfoWlcwgQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78762-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:15:48 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7661BBDC9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 19:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75B2B30F6C9C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 18:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8E535D5F8;
	Fri, 27 Feb 2026 18:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="bpIh67kD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA76636B05A;
	Fri, 27 Feb 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772215959; cv=none; b=o7bjubQvYD7titQW7xfOUofYcxWfFoxPSQYZ3p/LD2RFrVf22pa6FZWXsLAGNGJJdD6W+Q9ZS9hg4jYS85SU4NGfFE/8w/fDJcCxse4eYwd044qUaf6Fd3MQDKcwkQitB0ky+a/piblPepQ9dnozGw4MkL/pAIJ065OUqyWrANI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772215959; c=relaxed/simple;
	bh=gYxbqG8k+xasiN54/GEPSiW3fJoxtQS8sCev+XNK1FU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=OgIBeBydlISg/PgabveYJr5Ext7PgpOhg7HjaevJBtiR/cDVRbdKqIsYklNBlEa1FYZtiX6e8TFw6YDg2lMyTAcnTIw+El91Yef8blptAA3qsUIsbb+pH/ErdQAvByquBnqqxeorWOCCD2Om5Q/O7Q21aQ6bafPySVu9brEE7Jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=bpIh67kD; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TXz5r/Smk/Jr8ClBPbDf+2+KCLgaYCb3Cg5DtS0mJz0=; b=bpIh67kDNgkmSMFkSjd2PUtMay
	DwCi7vbetHQCZKE6KIf3tkY6rk4WuT/evRoDacYEgldVOz76skE895DpLOdgBFsbNe21LI7SFNxRl
	vOytEdaGPhmLE7Z+oGCb/LYd+jQxgSGOqZ6IKH0vaFg7qrv7n0IcuwPziGsK7+S9bCPQX/GwOGaMU
	plvS9beReydjGyOWfkEKy5kgZPE8Ik/9110//OOX7QnOEXEnmkTIRMcA0+OsFcNuDBzquRITC/GkE
	T3Zwh+LOSDtAiGuTJghVe7bUXBnlIJc+c7+NeWdCn/R80Lb5IUdA1cB0JkSwaJIv+OXdzDOrTLj3l
	ruMG3S2w==;
Received: from [191.54.27.153] (helo=toolbx)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vw2K0-006dFM-Al; Fri, 27 Feb 2026 19:12:16 +0100
From: Helen Koike <koike@igalia.com>
To: shaggy@kernel.org,
	koike@igalia.com,
	jfs-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com
Subject: [PATCH] jfs: hold LOG_LOCK on umount to avoid null-ptr-deref
Date: Fri, 27 Feb 2026 15:11:50 -0300
Message-ID: <20260227181150.736848-1-koike@igalia.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[igalia.com:s=20170329];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[igalia.com : SPF not aligned (relaxed),none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78762-lists,linux-fsdevel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[koike@igalia.com,linux-fsdevel@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	NEURAL_HAM(-0.00)[-0.931];
	DKIM_TRACE(0.00)[igalia.com:-];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,appspotmail.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6B7661BBDC9
X-Rspamd-Action: no action

write_special_inodes() function iterate through the log->sb_list and
access the sbi fields, which can be set to NULL concurrently by umount.

Fix concurrency issue by holding LOG_LOCK and checking for NULL.

Reported-by: syzbot+e14b1036481911ae4d77@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
Signed-off-by: Helen Koike <koike@igalia.com>
---
 fs/jfs/jfs_logmgr.c | 16 +++++++---------
 fs/jfs/jfs_logmgr.h |  7 +++++++
 fs/jfs/jfs_umount.c | 10 ++++++++++
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/fs/jfs/jfs_logmgr.c b/fs/jfs/jfs_logmgr.c
index 5b1c5da04163..59f94c28007d 100644
--- a/fs/jfs/jfs_logmgr.c
+++ b/fs/jfs/jfs_logmgr.c
@@ -74,12 +74,6 @@ static struct lbuf *log_redrive_list;
 static DEFINE_SPINLOCK(log_redrive_lock);
 
 
-/*
- *	log read/write serialization (per log)
- */
-#define LOG_LOCK_INIT(log)	mutex_init(&(log)->loglock)
-#define LOG_LOCK(log)		mutex_lock(&((log)->loglock))
-#define LOG_UNLOCK(log)		mutex_unlock(&((log)->loglock))
 
 
 /*
@@ -204,9 +198,13 @@ static void write_special_inodes(struct jfs_log *log,
 	struct jfs_sb_info *sbi;
 
 	list_for_each_entry(sbi, &log->sb_list, log_list) {
-		writer(sbi->ipbmap->i_mapping);
-		writer(sbi->ipimap->i_mapping);
-		writer(sbi->direct_inode->i_mapping);
+		/* These pointers can be NULL before list_del during umount */
+		if (sbi->ipbmap)
+			writer(sbi->ipbmap->i_mapping);
+		if (sbi->ipimap)
+			writer(sbi->ipimap->i_mapping);
+		if (sbi->direct_inode)
+			writer(sbi->direct_inode->i_mapping);
 	}
 }
 
diff --git a/fs/jfs/jfs_logmgr.h b/fs/jfs/jfs_logmgr.h
index 8b8994e48cd0..09e0ef6aecce 100644
--- a/fs/jfs/jfs_logmgr.h
+++ b/fs/jfs/jfs_logmgr.h
@@ -402,6 +402,13 @@ struct jfs_log {
 	int no_integrity;	/* 3: flag to disable journaling to disk */
 };
 
+/*
+ * log read/write serialization (per log)
+ */
+#define LOG_LOCK_INIT(log)	mutex_init(&(log)->loglock)
+#define LOG_LOCK(log)		mutex_lock(&((log)->loglock))
+#define LOG_UNLOCK(log)		mutex_unlock(&((log)->loglock))
+
 /*
  * Log flag
  */
diff --git a/fs/jfs/jfs_umount.c b/fs/jfs/jfs_umount.c
index 8ec43f53f686..18569f1eaabd 100644
--- a/fs/jfs/jfs_umount.c
+++ b/fs/jfs/jfs_umount.c
@@ -20,6 +20,7 @@
 #include "jfs_superblock.h"
 #include "jfs_dmap.h"
 #include "jfs_imap.h"
+#include "jfs_logmgr.h"
 #include "jfs_metapage.h"
 #include "jfs_debug.h"
 
@@ -57,6 +58,12 @@ int jfs_umount(struct super_block *sb)
 		 */
 		jfs_flush_journal(log, 2);
 
+	/*
+	 * Hold log lock so write_special_inodes (lmLogSync) cannot see
+	 * this sbi with a NULL inode pointer while iterating log->sb_list.
+	 */
+	if (log)
+		LOG_LOCK(log);
 	/*
 	 * close fileset inode allocation map (aka fileset inode)
 	 */
@@ -95,6 +102,9 @@ int jfs_umount(struct super_block *sb)
 	 */
 	filemap_write_and_wait(sbi->direct_inode->i_mapping);
 
+	if (log)
+		LOG_UNLOCK(log);
+
 	/*
 	 * ensure all file system file pages are propagated to their
 	 * home blocks on disk (and their in-memory buffer pages are
-- 
2.53.0


