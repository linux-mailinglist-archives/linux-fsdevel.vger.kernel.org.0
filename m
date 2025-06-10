Return-Path: <linux-fsdevel+bounces-51139-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB2EAD3014
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7584B3B65B3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E28D0283FE8;
	Tue, 10 Jun 2025 08:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="NrVVZT6l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B692820AA
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543716; cv=none; b=BdnBY1hn0oWTkIhT67d2bM4w68giC3NoxCqquj49U7LrIuMM+yLC4MyrHrlw60Q9Aj6FTnsOVJ2JRlcZvh8zqS16fPLTck/GFBl+Z9NSyCZ1vWrq3iDIqz7BtiyeKLsogvJE/WPr2q+junQUJVVtP/7rsyDKwiT96+QAs0WQgBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543716; c=relaxed/simple;
	bh=SQO73GkUsyZeZzbSpES0aJ8em1aK+tn1wAVKix/B5cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QVpDJsk8lhJH5CCg/mKqBIZHGOgoetP4qsyxhm90tVa24MtMPM8FDuI/rd/J5DUV/WUinf+OhwYRC/y3zsakKdDjRpgQcRPBT0cdzmWSe2vB7heqg537CQnay70o2mmBVxpct2eGGFe6K7v6A//ad9vJb6N7Zb/d0uyr4YzjNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=NrVVZT6l; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FvdDStH53CI9f4mQ0KUfxTuBu+4p8+Palkjw9OnX+3M=; b=NrVVZT6l3VtOo1kDn8pzVPX6Z1
	oaNWXsLSOiKS9MlwrwYCFYDTkxmpzkU9eKFt6upHHZAcYDLY6ANfKkn5yYSeVRYTdnPg+hdiCdFOb
	ptpSC03rRRWfHTx0jssRyQlmuwG28ubduUwgg2NBJo0wVd3AKnq8ajtPZQc2xmekoK4HpKDhJY3lQ
	YTrjW599y1CaDGIAjsKlAKqpfGDpiJeRZGREqNciUpd6bIgtEksAmlKXjA6ggq+c23H36bb/RITJz
	PVYjiFJdybqMF0R9DW+B6M78djOSxgZXvns2qPimflnnlEcosalvGwhYWRnOmjFl94nPr8TscHmnU
	oUPX6lrw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEy-00000004jOm-2URi;
	Tue, 10 Jun 2025 08:21:52 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 24/26] combine __put_mountpoint() with unhash_mnt()
Date: Tue, 10 Jun 2025 09:21:46 +0100
Message-ID: <20250610082148.1127550-24-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 60dcfe4aa976..777e4c3b2c12 100644
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
 	mnt->mnt_parent = mnt;
@@ -1049,15 +1049,15 @@ static struct mountpoint *unhash_mnt(struct mount *mnt)
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
@@ -1445,7 +1445,7 @@ static void mntput_no_expire(struct mount *mnt)
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


