Return-Path: <linux-fsdevel+bounces-76009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 9KXBG0pRf2m9nwIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76009-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 14:12:42 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 02036C5FA8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 01 Feb 2026 14:12:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31DF830022F8
	for <lists+linux-fsdevel@lfdr.de>; Sun,  1 Feb 2026 13:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7583D34678A;
	Sun,  1 Feb 2026 13:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FtZtPBbZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD6751A58D
	for <linux-fsdevel@vger.kernel.org>; Sun,  1 Feb 2026 13:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769951559; cv=none; b=Kf+9vELg54HNI+4Vjhr5aA2TraSfhAtfQnDsvVZ29Yt8BpJvoG3OLK0lrlSfMhi4sAYT5AEFMIIG8OSE0crktqYGFYeij9JucuZZxWiYJAlgkjrj8zStsWsilrDSVPhGPEQx9xIBOA1Po/snbdULdxN3/+NXtRH7+awcGXCcXYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769951559; c=relaxed/simple;
	bh=JXeaXtpB82Xtgp9hOcE4hSwkhfWEypULlw6HciVzaxE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FBKLsm7Kg2tzvH5GR9GQ/ZoHuo5Gh9jUKZTrJ2FIuoX5IWIi9JDsWgnELGi6XqIyhOwjlMy+2Gu2fYJh53hzvvYBXDUGott2csj/xv41FmGtxKbYwoVHah5qb7t5+G2p+irTG78+ZNr+PFfWR8FFULA/NGWTakBuCbpNqXqhtXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FtZtPBbZ; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c636487ccaeso1465100a12.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 01 Feb 2026 05:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769951557; x=1770556357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ts58/HVJVntlC9t6K8nf8iDwbH90uPeoGmbeeGFT5Mo=;
        b=FtZtPBbZYobcFUERc+ZEfA8p2WMjoP8SzuYoJwRjoqfqznYIifaBxeXMZ2yIcEbC4i
         v05UHBgaXzus0fyFYwsF8E3txE17ngops/bc/x8zIsf2CoerpycBZDfRV+Zm7qHKCB1U
         DXKnsRrIYq/9+zs9hl3mpJQ0aHyztw7VcSkbaXYkJW8ZoxXuxtoPD0WlhhRcN5D9VXbS
         kp9SZlT6tam/TgdSB9iSqIO0PNSTWNMAZNDCD5RRmSIuIQikPgBMKZk8QhAr4kjOfyYT
         rf1Ays7a4Pl5TMV5rWm+02jLBooypsuAN2Ru8DlFFeQoz9pyU27+ibvvMVpxsGF13oyo
         ro8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769951557; x=1770556357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ts58/HVJVntlC9t6K8nf8iDwbH90uPeoGmbeeGFT5Mo=;
        b=e1gJuC1Uc93jv3vRJDiYMt0A3mcqtwmmW3XOvoGemrUqcZouDIvcnQ6GAOcJQaeN+X
         oUpf7dZIvmwNUEoBZ6GP0Btsw9/K4hv7Aakzt/GpLzRFBCnqwQSNWLq6TvgYfDJbpXV5
         gOabn4KiRrZGRnJZFkYMZiajnnw0tG6gxDNz0VZRzvfmXF+nzXGPdE7aJ637ZtW0hC11
         KJUAgT4/Yq5S1QukfVb9tow3gKpTmP6kvnE2P5qdC67fcb+gxpN6u16Hz31ICvNuad1s
         fvmDze0MvZFAiMrMkImtqjqzX6UAcO1x5Sk4FPunuTIk11vE71eRqylez7eNREfN9aT4
         CNvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfd82u1pLeZRgPwduWTeUXaCD1Rj661MWd6tpQBxLQSLrXlIH59tWdpyH4kT841uwk9i7XCFE/872cNHWh@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmc2jvcoWv8lgR0SApDuVo4yktfuQZW1fVpW1WJ3JS3Y2tFBB7
	fQ5ayZ6nNAzu2AIjhXx7HWRBUoOiUhDriZn0BnrqEkpmgpzS/8oR6z6o
X-Gm-Gg: AZuq6aItoWdqos70e+Pr/8p+Z8vIE7r96DjcYiMlsXtmVl726u47r2Mhdw0dkPvzze7
	0Fh3Z3fq8gB5XLp0YU+Iw953idYJdvX0ZFe9cnoRSDNDjvFcAhuWGTL2WMSqVAv0OgaJrWmxvEn
	k/ywl6zav0Vo5ASFl3lEzpjzjrwKyo9bJl/ReK7U0TytOPa+WCCWfEkfqCtIu+wtHt/NIRSRvTK
	9bjeJ7C2DmkEFmJMXhItU7qw2GcKk/yMxUohdJoUEN0swx73yqo65iWTzxjUPf9PuxiUxlbxZ1b
	o2eN4RFPzV4TrVe0pW2cJcm20+DCzpqgp/VXy/Xmey/zyh/K1KihBe+GHIKbffFVWpQ0g6lPiXP
	F6hkwtCXHN0PtGATPs7gF02h4rPo4EXPl4UfLtPnKxbFz3mYOEEo0Pzcg7cfAyHNsGfvD8JNnUR
	FKmxbvr5COm3V5trlENCzVehFbFu+6GishR0nfioI=
X-Received: by 2002:a17:903:11ce:b0:2a7:d93a:a3b2 with SMTP id d9443c01a7336-2a8d8951448mr96558255ad.0.1769951557039;
        Sun, 01 Feb 2026 05:12:37 -0800 (PST)
Received: from Shardul.tailddf38c.ts.net ([223.185.36.73])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4c3df6sm121636485ad.49.2026.02.01.05.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 05:12:36 -0800 (PST)
From: Shardul Bankar <shardulsb08@gmail.com>
X-Google-Original-From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: slava@dubeyko.com,
	glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	brauner@kernel.org,
	janak@mpiricsoftware.com,
	shardulsb08@gmail.com,
	Shardul Bankar <shardul.b@mpiricsoftware.com>,
	syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Subject: [PATCH v2] hfsplus: fix s_fs_info leak on mount setup failure
Date: Sun,  1 Feb 2026 18:42:29 +0530
Message-Id: <20260201131229.4009115-1-shardul.b@mpiricsoftware.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-76009-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[zeniv.linux.org.uk,suse.cz,kernel.org,mpiricsoftware.com,gmail.com,syzkaller.appspotmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardulsb08@gmail.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-fsdevel,99f6ed51479b86ac4c41];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02036C5FA8
X-Rspamd-Action: no action

Syzkaller reported a memory leak in hfsplus where s_fs_info (sbi) is
allocated in hfsplus_init_fs_context() but never freed if the mount
setup fails during setup_bdev_super().

In get_tree_bdev_flags(), if setup_bdev_super() fails, the superblock
is torn down via deactivate_locked_super(). Since this failure occurs
before fill_super() is called, the superblock's operations (sb->s_op)
are not yet set. Consequently, the standard ->put_super() callback
cannot be invoked, and the allocated s_fs_info remains leaked.

Fix this by implementing a custom ->kill_sb() handler,
hfsplus_kill_sb(), which explicitly frees s_fs_info using RCU
synchronization. This ensures cleanup happens regardless of whether
fill_super() succeeded or ->put_super() was called.

To support this new lifecycle:
1. In hfsplus_put_super(), remove the call_rcu() call. The actual freeing
   of s_fs_info is deferred to hfsplus_kill_sb().
2. In hfsplus_fill_super(), remove the explicit cleanup of sbi (both kfree
   and unload_nls) in the error path. The VFS will call ->kill_sb() on
   failure, so retaining these would result in double-frees or refcount
   underflows.
3. Implement hfsplus_kill_sb() to invoke kill_block_super() and then free
   s_fs_info via RCU.

Reported-by: syzbot+99f6ed51479b86ac4c41@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=99f6ed51479b86ac4c41
Signed-off-by: Shardul Bankar <shardul.b@mpiricsoftware.com>
---
v1:
 - tried to fix the leak in fs/super.c (VFS layer).
 - Link: https://lore.kernel.org/all/20260201082724.GC3183987@ZenIV/
v2:
 - abandons the VFS changes in favor of a driver-specific fix in
   hfsplus, implementing a custom ->kill_sb() to handle the cleanup
   lifecycle, as suggested by Al Viro.

 fs/hfsplus/super.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index aaffa9e060a0..cc80cd545a3e 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -311,14 +311,6 @@ void hfsplus_mark_mdb_dirty(struct super_block *sb)
 	spin_unlock(&sbi->work_lock);
 }
 
-static void delayed_free(struct rcu_head *p)
-{
-	struct hfsplus_sb_info *sbi = container_of(p, struct hfsplus_sb_info, rcu);
-
-	unload_nls(sbi->nls);
-	kfree(sbi);
-}
-
 static void hfsplus_put_super(struct super_block *sb)
 {
 	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
@@ -344,7 +336,6 @@ static void hfsplus_put_super(struct super_block *sb)
 	hfs_btree_close(sbi->ext_tree);
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
-	call_rcu(&sbi->rcu, delayed_free);
 
 	hfs_dbg("finished\n");
 }
@@ -648,9 +639,7 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	kfree(sbi->s_vhdr_buf);
 	kfree(sbi->s_backup_vhdr_buf);
 out_unload_nls:
-	unload_nls(sbi->nls);
 	unload_nls(nls);
-	kfree(sbi);
 	return err;
 }
 
@@ -709,10 +698,27 @@ static int hfsplus_init_fs_context(struct fs_context *fc)
 	return 0;
 }
 
+static void delayed_free(struct rcu_head *p)
+{
+	struct hfsplus_sb_info *sbi = container_of(p, struct hfsplus_sb_info, rcu);
+
+	unload_nls(sbi->nls);
+	kfree(sbi);
+}
+
+static void hfsplus_kill_sb(struct super_block *sb)
+{
+	struct hfsplus_sb_info *sbi = sb->s_fs_info;
+
+	kill_block_super(sb);
+	if (sbi)
+		call_rcu(&sbi->rcu, delayed_free);
+}
+
 static struct file_system_type hfsplus_fs_type = {
 	.owner		= THIS_MODULE,
 	.name		= "hfsplus",
-	.kill_sb	= kill_block_super,
+	.kill_sb	= hfsplus_kill_sb,
 	.fs_flags	= FS_REQUIRES_DEV,
 	.init_fs_context = hfsplus_init_fs_context,
 };
-- 
2.34.1


