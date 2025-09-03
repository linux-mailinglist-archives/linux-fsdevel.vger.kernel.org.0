Return-Path: <linux-fsdevel+bounces-60116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1075BB4140A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:59:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCA61BA15F2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D65FC2DEA75;
	Wed,  3 Sep 2025 04:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="glRjSFIF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D722DC33F
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875359; cv=none; b=Vy6kdo7yxqU5KxTWXLhIcCqBwg08GzH5+NHJajfbgs4ZMYS/9FInk0X0/lrdHnTUJGNQRZ6XKz0HSjWcognlNAE6btNNG+OgJX9CEB28gQCgKR2UKpuwNPw2KDAyEvIZI/osXYBNHjoT6Yqpp6Xir2su5bTU+sMefMPaS4UwZec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875359; c=relaxed/simple;
	bh=G2bIVk7ExwG+sNoQyDWv6HChzxDw28yKnyTXUQ3KXig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M86q3LbJkwmOxUBtg8gDknVFEHVUY/n7XioLwOdMKgxEZE5aohNo+8tyGGkxZh5NLgqzEotAjTx7YOTL7Vqjwfc1yggGObMlWLVxWZP/g3wx2eXP0bOKMXE2MApxAi/yG9XTfoe6rdtiOGjbgAf0QCoIb5efv6x43a/TnRrHacM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=glRjSFIF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=JkKtLaZEjFwFQ58LkxEfVWC13DGh6qMliHOtV5eqmVI=; b=glRjSFIFTNXnl1mq5pXKYIM1de
	EdorJlk/XyzVkPHefdVQ4mqEzn+RQRu6WEyK3eQILD/aG/5JzRBKRZMqaY3E06JlXWhKEOBvN6I6l
	/IAJSNaYUqNysdZXhGcfOyV6iScrRjUlK9qnJzG6+qaBlOMEoklBAhpOrTsmAzq/H7A5KVxmQ3Gsi
	7mfLps1IjFyb+aVYOc3FQvm/OzG6mjM76kl41NXsmoD55nLMOuug2UzZrl+ysxYIeRj1G9fJLd+vM
	fZIAkm9j7Fsc/FTDBdxbY/hF0n3l0k4kRFxNZA2QoABKGrxEOjyg+JveGqaBORcqa9CT8I+kQYAPs
	XZTRxdIA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXI-0000000ApN6-1Qta;
	Wed, 03 Sep 2025 04:55:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 63/63] WRITE_HOLD machinery: no need for to bump mount_lock seqcount
Date: Wed,  3 Sep 2025 05:55:35 +0100
Message-ID: <20250903045537.2579614-74-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

... neither for insertion into the list of instances, nor for
mnt_{un,}hold_writers(), nor for mnt_get_write_access() deciding
to be nice to RT during a busy-wait loop - all of that only needs
the spinlock side of mount_lock.

IOW, it's mount_locked_reader, not mount_writer.

Clarify the comment re locking rules for mnt_unhold_writers() - it's
not just that mount_lock needs to be held when calling that, it must
have been held all along since the matching mnt_hold_writers().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8e6b6523d3e8..8f0900857822 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -526,8 +526,8 @@ int mnt_get_write_access(struct vfsmount *m)
 			 * the same CPU as the task that is spinning here.
 			 */
 			preempt_enable();
-			lock_mount_hash();
-			unlock_mount_hash();
+			read_seqlock_excl(&mount_lock);
+			read_sequnlock_excl(&mount_lock);
 			preempt_disable();
 		}
 	}
@@ -671,7 +671,7 @@ EXPORT_SYMBOL(mnt_drop_write_file);
  * a call to mnt_unhold_writers() in order to stop preventing write access to
  * @mnt.
  *
- * Context: This function expects lock_mount_hash() to be held serializing
+ * Context: This function expects to be in mount_locked_reader scope serializing
  *          setting WRITE_HOLD.
  * Return: On success 0 is returned.
  *	   On error, -EBUSY is returned.
@@ -716,7 +716,8 @@ static inline int mnt_hold_writers(struct mount *mnt)
  *
  * This function can only be called after a call to mnt_hold_writers().
  *
- * Context: This function expects lock_mount_hash() to be held.
+ * Context: This function expects to be in the same mount_locked_reader scope
+ * as the matching mnt_hold_writers().
  */
 static inline void mnt_unhold_writers(struct mount *mnt)
 {
@@ -770,7 +771,8 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 	if (atomic_long_read(&sb->s_remove_count))
 		return -EBUSY;
 
-	lock_mount_hash();
+	guard(mount_locked_reader)();
+
 	for (struct mount *m = sb->s_mounts; m; m = m->mnt_next_for_sb) {
 		if (!(m->mnt.mnt_flags & MNT_READONLY)) {
 			err = mnt_hold_writers(m);
@@ -787,7 +789,6 @@ int sb_prepare_remount_readonly(struct super_block *sb)
 		if (test_write_hold(m))
 			clear_write_hold(m);
 	}
-	unlock_mount_hash();
 
 	return err;
 }
@@ -1226,9 +1227,8 @@ static void setup_mnt(struct mount *m, struct dentry *root)
 	m->mnt_mountpoint = m->mnt.mnt_root;
 	m->mnt_parent = m;
 
-	lock_mount_hash();
+	guard(mount_locked_reader)();
 	mnt_add_instance(m, s);
-	unlock_mount_hash();
 }
 
 /**
-- 
2.47.2


