Return-Path: <linux-fsdevel+bounces-59593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AFB38B3AE3F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A010A4E4C6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C18F3009EA;
	Thu, 28 Aug 2025 23:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="AxeOx9Wv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1321F2FD7DA
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422500; cv=none; b=C84VrVQ3/0VG3O7UUKXMB0U7J7P1UfXdZVjobMflXy3p6SEOu2VEA44bl5EzYPklCMXolaqKdnLGeODmGxpdmvobqh7JtzhjgH9odbQC1PDIGT0rHd3SHOIxZe0+R87l4Pvps2knOe5IysgsGm+Pr3b0pZNWHtpv75qRcL8SVEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422500; c=relaxed/simple;
	bh=zZsWdarxDuWRXCEorynYhHFsBXa5rI9fsIli5fKxqvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NjB3U1L1bPbSExiF/W9QV/Syrn9RmeQwjLp963C7ADR2AHI65yjPynLB5pwWC7pVElmBQwJyAVJrcLeQ7l3iT3/tfAlbdIDwMCaw7E/iVqUTzy2e6FPbmhZWxXmDmGqGVzsl12K9JcSGVpyduHk5G37vLdwuz1B4DfncK5mBqRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=AxeOx9Wv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FKa+yaikP3V/ap1UToYIUTqIcbDe/l3Pv60a6GqCDy0=; b=AxeOx9WvqgPLVTQin4uj3KWvMy
	kRImIfcjwCeU8RcYZHqwvraoUBDTyHl47fF1o9z1NvLDxbig5sxkfHRhBsIsbNvgbCV53VUu85E7K
	0GimsdsHUkuiz6a2panr5tyAhLdhEWG6S75Eu7cxPrK3XWqKm9fxUPReKhhLoKmhgmEkfVqtQ9Cy4
	Zj6iPDfeKmZ4EWeAKnrLQomu1frpgGa5i0yyy1+F6Q5BH0A5vdgiEGNB4MthyucqOy59pQpfBksfW
	rGaRFzDJYDSyz00tZ+WpJNqAn55z3MfUhsLXrh57tRFG9johMKI3iPDS2JzXLEjI2HSsD/7oVRlLO
	QeLiwnxw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj7-0000000F2CS-1Bqk;
	Thu, 28 Aug 2025 23:08:17 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 63/63] WRITE_HOLD machinery: no need for to bump mount_lock seqcount
Date: Fri, 29 Aug 2025 00:08:06 +0100
Message-ID: <20250828230806.3582485-63-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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
index 6b439e5e5a27..545fef0682b1 100644
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
 		if (m->mnt_pprev_for_sb & WRITE_HOLD)
 			m->mnt_pprev_for_sb &= ~WRITE_HOLD;
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


