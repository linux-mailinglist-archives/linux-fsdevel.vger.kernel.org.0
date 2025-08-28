Return-Path: <linux-fsdevel+bounces-59545-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAFDB3AE06
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6045358395C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50362ECD14;
	Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="L7gwDJZ2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9702D192B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422492; cv=none; b=ofkq0NdLZDXWMElf0yGTHyy3JAPlVqsI4+gfKH9ExrXflc8WGzhCdY67EaH5FZUfXxy7ofP853UTT7V+c04csKYli7EkBKUI1EjXUHo4vo0nssi/GeKJFZjMuIDHxKyayWSL53WAU6jmypnziGXxMFCPugJMXZ6LQreQhKaIQdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422492; c=relaxed/simple;
	bh=s2gGcAHDqewQaDZj9iW6mCs8w2BpsNU9BxKVi8JYs/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=thKz+InlsN/l9S++wlJERE78WYAa0MpcYTr8euz0Ulhst6cOA+8BfX6BpgNRNn6bBZP/xX/h2lSNP/74UM8oPcCQbc9cK4ZOc5MOmRtN8keV69HI+7hM9nbm6aMniWWCsAH6k7783WDaGStsDfguXtBJXiJKnx+tIPyJcolc0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=L7gwDJZ2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Qnbx11MHP8tzCDDVQegtiuSAdAouAnUcse9DDa1YnIs=; b=L7gwDJZ2d54k8UQVWSnCJW2KOg
	D8oxPKCVQIdOBBZn7tdd/RrfG56ayzfBN5PrMXlBzR50N4d1VUVygkv9pWvnWDO89vqXD+O1l9kg2
	PYQPg8xyxiZoogyxTYVJDzADPmqu87/AOEtk0lwFmvP74NKBO/NXZ0yHR1a//WB++DjIFVIJfzsEi
	JD4ygnD5BPGXUgPdo6bo0xtqXUnV/IgSkJLHpQzF4gJJEaYDqURqcA+VHj76dJmni+8Bv0SpeqBB4
	XLXkeE7L6SH9tuLEzlWzAB6P18hwSym3VEAhbdcb7ZjZUfJR8hrEsTSAaTcDMm/i4Gx/9BLTULBRS
	RMeIsfgA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urliy-0000000F23F-2wQ7;
	Thu, 28 Aug 2025 23:08:08 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 18/63] switch do_new_mount_fc() to fc_mount()
Date: Fri, 29 Aug 2025 00:07:21 +0100
Message-ID: <20250828230806.3582485-18-viro@zeniv.linux.org.uk>
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

Prior to the call of do_new_mount_fc() the caller has just done successful
vfs_get_tree().  Then do_new_mount_fc() does several checks on resulting
superblock, and either does fc_drop_locked() and returns an error or
proceeds to unlock the superblock and call vfs_create_mount().

The thing is, there's no reason to delay that unlock + vfs_create_mount() -
the tests do not rely upon the state of ->s_umount and
	fc_drop_locked()
	put_fs_context()
is equivalent to
	unlock ->s_umount
	put_fs_context()

Doing vfs_create_mount() before the checks allows us to move vfs_get_tree()
from caller to do_new_mount_fc() and collapse it with vfs_create_mount()
into an fc_mount() call.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 0474b3a93dbf..9b575c9eee0b 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3705,25 +3705,20 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 			   unsigned int mnt_flags)
 {
-	struct vfsmount *mnt;
 	struct pinned_mountpoint mp = {};
-	struct super_block *sb = fc->root->d_sb;
+	struct super_block *sb;
+	struct vfsmount *mnt = fc_mount(fc);
 	int error;
 
+	if (IS_ERR(mnt))
+		return PTR_ERR(mnt);
+
+	sb = fc->root->d_sb;
 	error = security_sb_kern_mount(sb);
 	if (!error && mount_too_revealing(sb, &mnt_flags))
 		error = -EPERM;
-
-	if (unlikely(error)) {
-		fc_drop_locked(fc);
-		return error;
-	}
-
-	up_write(&sb->s_umount);
-
-	mnt = vfs_create_mount(fc);
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
+	if (unlikely(error))
+		goto out;
 
 	mnt_warn_timestamp_expiry(mountpoint, mnt);
 
@@ -3731,10 +3726,12 @@ static int do_new_mount_fc(struct fs_context *fc, struct path *mountpoint,
 	if (!error) {
 		error = do_add_mount(real_mount(mnt), mp.mp,
 				     mountpoint, mnt_flags);
+		if (!error)
+			mnt = NULL;	// consumed on success
 		unlock_mount(&mp);
 	}
-	if (error < 0)
-		mntput(mnt);
+out:
+	mntput(mnt);
 	return error;
 }
 
@@ -3788,8 +3785,6 @@ static int do_new_mount(struct path *path, const char *fstype, int sb_flags,
 		err = parse_monolithic_mount_data(fc, data);
 	if (!err && !mount_capable(fc))
 		err = -EPERM;
-	if (!err)
-		err = vfs_get_tree(fc);
 	if (!err)
 		err = do_new_mount_fc(fc, path, mnt_flags);
 
-- 
2.47.2


