Return-Path: <linux-fsdevel+bounces-52461-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A4CAE3481
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780D716D374
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5211F03DE;
	Mon, 23 Jun 2025 04:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jaCxKJ/p"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE161C6FF5
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654476; cv=none; b=JP9BNM/Pibjbzl/RKlaDl9uzDmmWKkUqd6jbrKZigRiKtuUc/Qbkg/ybPS7Wuo6nH44y4uJ6dKCPv3HW52BoFVws9Wcsf7w7ohvGTNGXUPNM9C7JlzYDoEP74gPsfQ5O3MrhzC9kXFH1bleME5MLlJLEV/Qg37Ww4qnb5olGRXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654476; c=relaxed/simple;
	bh=J/5RxYeCBPBTXzPfj7pco9lElgv14DECB31lbg90KJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hM7OwNaoSfVlMxH9H+4BccxVUrZvJPLmX8kMkelJt+3c/p7J/QvnrSz4UNdCwAGJSrOnsDTe975p8VYe3fOEDkyJdfV1yCu0Vqib0o/pp/eMGCm69GYqKKZ8BG1l3drWdKnuLdIeDffmOT/R0akET6/p86EmR/OyYgNDILpxBpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jaCxKJ/p; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=63BKo37ZxvczlSQKqosPChhTeaiLYjE7R22jFYNaM+Q=; b=jaCxKJ/pVVyxqeYDOWnyuggNRS
	vLMZaAn94XpoSqndzj1Sn7fY/siGHjs/UDz8A9FmsICVn05ECOKZqMiyyM6kJmU61unz4pLm+qH3E
	LZ+gcCg3bkU6N+OobgKZ6GWZHPjdGs9OuZ2bkdZhh73T8BprGbaVp4c9gjD+AkY2yg3mKb43s7f6P
	uBagk5Q5Y718OUuqYKzKoC+pmYUU5CilQfmzjnqP1gi+XQmP1bD5ANGXVe3i5WsqlagKbXmA9iCjV
	7mL0hlDRhXu1TQ61omtcFxJ2SM5YC8fL3RfL6dh2j5pHm3QX3Xj3kk8Gq4c0dYfvVVBR/NMfpRAfd
	YUTJ2TXg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCS-00000005KtX-3Po4;
	Mon, 23 Jun 2025 04:54:32 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 28/35] combine __put_mountpoint() with unhash_mnt()
Date: Mon, 23 Jun 2025 05:54:21 +0100
Message-ID: <20250623045428.1271612-28-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
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
index 834eed9d4493..5a18ba6e7df2 100644
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


