Return-Path: <linux-fsdevel+bounces-53265-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BE0AED2A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74E2E1887237
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8C51F5858;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="Ew1ipQ8a"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FEA1A2643
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251981; cv=none; b=XvBxBBaycQMGqmkm4pa/IcEK+lEfiEc4Y42ZEaUkttmon1RgvtxyeBbCSsBUM6VEacERPG9YpnyfpR+6+K1Uon6lfKFudyrI8TR/8Dx1tGkRjT8/6OAfDId2/fDA4pPR55xg+xNQGDmGeUgSmNyhy9KlhQB2Nl4uRyIX5MbqG58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251981; c=relaxed/simple;
	bh=d2Q1moQPx8L02vL3RgkGyJzAiG7+YTW/YMi5kf5WPuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hDfmq2ne181K0jDHRGQPiTg0PX1e3DZUU2MPAFlTcenpj2WDLPqGbfbdXxxJJuUy9iQ1+Aq7Nm4btXeLWLctttzMSP/mufCWyX09yKAXmrf21YGfTLjYdr6QxoU2WBjtskcK+kQYhbEaiZYR5cWtl7WJ/hMY/v8Cmu7q8SPv8E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=Ew1ipQ8a; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kKnhFuiNC7JnnZaU9YY19OlK6jg0zQcC4D5OOybq1jM=; b=Ew1ipQ8aEXvmKQwC9Lox7YBfyX
	yRjl/Z0SDq1vJkYayi1KlxmEZQSMhmbXrY5ESRmyaV+QhjWmCw2vHv/MAeQIUpPPzlNp7T/QNFWu7
	/5lwHLsE7Yz1KPlMu1N04i8EUhj5glQJ2C1dSqDb34UOKJ6U+F+vJiKAbklL89Ca7oXWR7hSrcPG2
	BHDUj2yIEQ3Me0A2RgZB70vA2ozngiOECPmTBtaG31Ld9hqR/GVL5msMQ+SZSBcJ8hmNtxuIWiBq+
	mrPLxKoNG98gW4we29eqPhJ1n3mNGA+ZzWbp+7Fdy3qaVwzKMGwrpOz4aARyy47tPNLVXBIwNJ6Yy
	z+8Gq8mQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4de-00000005p0e-0cnf;
	Mon, 30 Jun 2025 02:52:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 26/48] combine __put_mountpoint() with unhash_mnt()
Date: Mon, 30 Jun 2025 03:52:33 +0100
Message-ID: <20250630025255.1387419-26-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

A call of unhash_mnt() is immediately followed by passing its return
value to __put_mountpoint(); the shrink list given to __put_mountpoint()
will be ex_mountpoints when called from umount_mnt() and list when called
from mntput_no_expire().

Replace with __umount_mnt(mount, shrink_list), moving the call of
__put_mountpoint() into it (and returning nothing), adjust the
callers.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index eee73e945a54..521ffa52c906 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1037,9 +1037,9 @@ static void __touch_mnt_namespace(struct mnt_namespace *ns)
 }
 
 /*
- * vfsmount lock must be held for write
+ * locks: mount_lock[write_seqlock]
  */
-static struct mountpoint *unhash_mnt(struct mount *mnt)
+static void __umount_mnt(struct mount *mnt, struct list_head *shrink_list)
 {
 	struct mountpoint *mp;
 	struct mount *parent = mnt->mnt_parent;
@@ -1052,15 +1052,15 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
 	hlist_del_init(&mnt->mnt_mp_list);
 	mp = mnt->mnt_mp;
 	mnt->mnt_mp = NULL;
-	return mp;
+	__put_mountpoint(mp, shrink_list);
 }
 
 /*
- * vfsmount lock must be held for write
+ * locks: mount_lock[write_seqlock], namespace_sem[excl] (for ex_mountpoints)
  */
 static void umount_mnt(struct mount *mnt)
 {
-	put_mountpoint(unhash_mnt(mnt));
+	__umount_mnt(mnt, &ex_mountpoints);
 }
 
 /*
@@ -1451,7 +1451,7 @@ static void mntput_no_expire(struct mount *mnt)
 	if (unlikely(!list_empty(&mnt->mnt_mounts))) {
 		struct mount *p, *tmp;
 		list_for_each_entry_safe(p, tmp, &mnt->mnt_mounts,  mnt_child) {
-			__put_mountpoint(unhash_mnt(p), &list);
+			__umount_mnt(p, &list);
 			hlist_add_head(&p->mnt_umount, &mnt->mnt_stuck_children);
 		}
 	}
-- 
2.39.5


