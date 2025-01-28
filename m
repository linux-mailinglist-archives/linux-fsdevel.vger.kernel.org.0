Return-Path: <linux-fsdevel+bounces-40218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6918BA2089E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 11:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C4EA188771E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 685AD19F47E;
	Tue, 28 Jan 2025 10:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RfAgQiAP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B7619F438
	for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jan 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738060452; cv=none; b=UQfN1RWTjf0Asq0fXBImsH75qs49ADujBzg5x4pEq2bycRu1T7wGN85TEBeB4dfHeUpXt7LUfmmAf6iT2EI2GyK5/8/7E7r191Q9tKfY8ASbE5Ki3Jh1kKdl+3/znG0aoQzV5B3Ywe3vg2vSKdt32TLewDnv0lL10yVQGlus0jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738060452; c=relaxed/simple;
	bh=mKrbP1RlZ4IXxNfE4ieSzr34lEjsrChFcqwRTQWD/jA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=l+hdmRIlJX6Lu/CE3zN28y1fIbEZNsFfxHV+6QVwPdNW57rrK/qt35o2jrmOq2P+5dZrTg3ZP38Dn//fXOZtjtDCEHotneZWpSzfcOYwb7wIfQRKrD2cFb8IOSNaNX9GYrSjwx+ZSuDTxf1gDpfRSd0wCeII6mlzlTKEfKJIznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RfAgQiAP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A56C4CEE4;
	Tue, 28 Jan 2025 10:34:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738060452;
	bh=mKrbP1RlZ4IXxNfE4ieSzr34lEjsrChFcqwRTQWD/jA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RfAgQiAPKybyedxMoiw77wGUobQAL49pATqxxcTSND6M020/2ZbVRLJ39rNS4vt9o
	 x+xvcWD6X6yHX51NgMXBFZnWmnxP51JkAiCiks7fodfuTPte0kWSymedB93BzFRoY2
	 RB1d7w84dpJ79AI6xTOGBVsfbHkG9g7F80OpD1+GxfdGuK4eQRf9NQCTeKsQn5SCiH
	 ddayZq/I+SH2gZsBEQ/b2LoONjw6WR5RKM5t5y6ir/I2nGkiuWareJ8hC3KwLIY7L/
	 bZMHOtZd9ywgBbi577KgzjQPev1/Z0oV23MnkupwdLIJTZV5dOmhXZONiimrDaH881
	 uA9uRCjNC1M+Q==
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 28 Jan 2025 11:33:42 +0100
Subject: [PATCH 4/5] fs: add kflags member to struct mount_kattr
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-work-mnt_idmap-update-v2-v1-4-c25feb0d2eb3@kernel.org>
References: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
In-Reply-To: <20250128-work-mnt_idmap-update-v2-v1-0-c25feb0d2eb3@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Amir Goldstein <amir73il@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, 
 Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Jan Kara <jack@suse.com>, Lennart Poettering <lennart@poettering.net>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Seth Forshee <sforshee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-1b0d6
X-Developer-Signature: v=1; a=openpgp-sha256; l=2638; i=brauner@kernel.org;
 h=from:subject:message-id; bh=mKrbP1RlZ4IXxNfE4ieSzr34lEjsrChFcqwRTQWD/jA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTP2DTtz+bHpUp6r56X2+znf1z+qTtuzkJDld1sjLlW4
 qavl4S4d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk62lGhre3Li62T+M8tp1v
 ZtIs1hMMl5RV1ny+mvPKR/FI5EWn6nJGhl1BKfO0hLjT30d4snCaGz3NPeI0XfPf+1CRK2rrG4V
 5uAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Instead of using a boolean use a flag so we can add new flags in
following patches.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2a188a6c8df2bceed61c86877e91b87fd154c5a0..2405f839202b3916bcdc4304599996a55ce5deb7 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -84,12 +84,16 @@ static DEFINE_SEQLOCK(mnt_ns_tree_lock);
 static struct rb_root mnt_ns_tree = RB_ROOT; /* protected by mnt_ns_tree_lock */
 static LIST_HEAD(mnt_ns_list); /* protected by mnt_ns_tree_lock */
 
+enum mount_kattr_flags_t {
+	MOUNT_KATTR_RECURSE		= (1 << 0),
+};
+
 struct mount_kattr {
 	unsigned int attr_set;
 	unsigned int attr_clr;
 	unsigned int propagation;
 	unsigned int lookup_flags;
-	bool recurse;
+	enum mount_kattr_flags_t kflags;
 	struct user_namespace *mnt_userns;
 	struct mnt_idmap *mnt_idmap;
 };
@@ -4579,7 +4583,7 @@ static int mount_setattr_prepare(struct mount_kattr *kattr, struct mount *mnt)
 				break;
 		}
 
-		if (!kattr->recurse)
+		if (!(kattr->kflags & MOUNT_KATTR_RECURSE))
 			return 0;
 	}
 
@@ -4640,7 +4644,7 @@ static void mount_setattr_commit(struct mount_kattr *kattr, struct mount *mnt)
 
 		if (kattr->propagation)
 			change_mnt_propagation(m, kattr->propagation);
-		if (!kattr->recurse)
+		if (!(kattr->kflags & MOUNT_KATTR_RECURSE))
 			break;
 	}
 	touch_mnt_namespace(mnt->mnt_ns);
@@ -4670,7 +4674,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 		 */
 		namespace_lock();
 		if (kattr->propagation == MS_SHARED) {
-			err = invent_group_ids(mnt, kattr->recurse);
+			err = invent_group_ids(mnt, kattr->kflags & MOUNT_KATTR_RECURSE);
 			if (err) {
 				namespace_unlock();
 				return err;
@@ -4886,9 +4890,11 @@ SYSCALL_DEFINE5(mount_setattr, int, dfd, const char __user *, path,
 
 	kattr = (struct mount_kattr) {
 		.lookup_flags	= lookup_flags,
-		.recurse	= !!(flags & AT_RECURSIVE),
 	};
 
+	if (flags & AT_RECURSIVE)
+		kattr.kflags |= MOUNT_KATTR_RECURSE;
+
 	err = copy_mount_setattr(uattr, usize, &kattr);
 	if (err)
 		return err;
@@ -4918,9 +4924,10 @@ SYSCALL_DEFINE5(open_tree_attr, int, dfd, const char __user *, filename,
 
 	if (uattr) {
 		int ret;
-		struct mount_kattr kattr = {
-			.recurse = !!(flags & AT_RECURSIVE),
-		};
+		struct mount_kattr kattr = {};
+
+		if (flags & AT_RECURSIVE)
+			kattr.kflags |= MOUNT_KATTR_RECURSE;
 
 		ret = copy_mount_setattr(uattr, usize, &kattr);
 		if (ret)

-- 
2.45.2


