Return-Path: <linux-fsdevel+bounces-53282-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 983EEAED2AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 570FB3B5328
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4921521B9FF;
	Mon, 30 Jun 2025 02:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="oz5Rbfi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCEC1DAC95
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251984; cv=none; b=J3F/v0liSxBS7giF6axllp3ONODzpKYeGVZO4rDGl2b/X9E7TsZ6Fb9dSDKhzyApzUPma/LidTL/syok0QWHSrf6QQEkrkbk8XWl8rtMX0CW1L1cHmWVEdPyvIt2cULMUF6TzUTkPvP1Fq3RqFcu3/IC2DlUOwmaQrmwVPVDyss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251984; c=relaxed/simple;
	bh=+6SudWo00Jt2kJXgtK0fc1hORqYtp7yLFPe8H8yUhUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=STQ0N0LVEUi9bi/NlhssyCdAn1jsi9hfKR5tLwaGdOhfV4hbX0WSUdzdxSiQaLTucEXMyiqOl1XXY6jJK/2Sco3lSI47ehGJJNaSFPqdschFCQqTUZZ4L4XEtC/UINnILcY/rxFwc8eEvMAnkK23tk8pUV74EKkLSrGW3CeF2Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=oz5Rbfi2; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/omHeKv68Jyq1+nVRmwTN5MLT3xOgZg41WVr8aOtQLI=; b=oz5Rbfi2CZdTOv/yWtk1+/zGR3
	lEuIj2XeFyBEIHXxj8aLI7Qn94un1VB0gZpiKV0M/EYYzDRr9Qw7XargAMLKriqPMW5fgxuM5QeZN
	PwTu0SEXerzrfTzUTupn9mQX7F2nXsYMsK0pbpyNwNvv/QHwgXJBJi17xt11ce9jiaN/qXT8+ij9N
	NFNdmUCQZrtSiZyOzTBUBAGPUJaoKW9ZKvMIm4+F0rcgP/g6Cjfh88/MOW2Au5d4hcOmhinXZjAbr
	e76FroS8UYHZpO9aih9ZC0VXWmYCKbpwjUbHlea9ySqZwhZdbQ/9HkBg6aDyhFn/qCAPrNC/IiCo3
	5m54nMOg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dg-00000005p2v-1qXl;
	Mon, 30 Jun 2025 02:53:00 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 42/48] mnt_slave_list/mnt_slave: turn into hlist_head/hlist_node
Date: Mon, 30 Jun 2025 03:52:49 +0100
Message-ID: <20250630025255.1387419-42-viro@zeniv.linux.org.uk>
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

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |  4 ++--
 fs/namespace.c | 14 ++++++--------
 fs/pnode.c     | 41 +++++++++++++++++++----------------------
 3 files changed, 27 insertions(+), 32 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index f299dc85446d..08583428b10b 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -69,8 +69,8 @@ struct mount {
 	struct list_head mnt_list;
 	struct list_head mnt_expire;	/* link in fs-specific expiry list */
 	struct list_head mnt_share;	/* circular list of shared mounts */
-	struct list_head mnt_slave_list;/* list of slave mounts */
-	struct list_head mnt_slave;	/* slave list entry */
+	struct hlist_head mnt_slave_list;/* list of slave mounts */
+	struct hlist_node mnt_slave;	/* slave list entry */
 	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
 	struct mnt_namespace *mnt_ns;	/* containing namespace */
 	struct mountpoint *mnt_mp;	/* where is it mounted */
diff --git a/fs/namespace.c b/fs/namespace.c
index da27365418a5..38a46b32413d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -380,8 +380,8 @@ static struct mount *alloc_vfsmnt(const char *name)
 		INIT_LIST_HEAD(&mnt->mnt_list);
 		INIT_LIST_HEAD(&mnt->mnt_expire);
 		INIT_LIST_HEAD(&mnt->mnt_share);
-		INIT_LIST_HEAD(&mnt->mnt_slave_list);
-		INIT_LIST_HEAD(&mnt->mnt_slave);
+		INIT_HLIST_HEAD(&mnt->mnt_slave_list);
+		INIT_HLIST_NODE(&mnt->mnt_slave);
 		INIT_HLIST_NODE(&mnt->mnt_mp_list);
 		INIT_HLIST_HEAD(&mnt->mnt_stuck_children);
 		RB_CLEAR_NODE(&mnt->mnt_node);
@@ -1348,10 +1348,10 @@ static struct mount *clone_mnt(struct mount *old, struct dentry *root,
 
 	if ((flag & CL_SLAVE) ||
 	    ((flag & CL_SHARED_TO_SLAVE) && IS_MNT_SHARED(old))) {
-		list_add(&mnt->mnt_slave, &old->mnt_slave_list);
+		hlist_add_head(&mnt->mnt_slave, &old->mnt_slave_list);
 		mnt->mnt_master = old;
 	} else if (IS_MNT_SLAVE(old)) {
-		list_add(&mnt->mnt_slave, &old->mnt_slave);
+		hlist_add_behind(&mnt->mnt_slave, &old->mnt_slave);
 		mnt->mnt_master = old->mnt_master;
 	}
 	return mnt;
@@ -3398,10 +3398,8 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 		goto out;
 
 	if (IS_MNT_SLAVE(from)) {
-		struct mount *m = from->mnt_master;
-
-		list_add(&to->mnt_slave, &from->mnt_slave);
-		to->mnt_master = m;
+		hlist_add_behind(&to->mnt_slave, &from->mnt_slave);
+		to->mnt_master = from->mnt_master;
 	}
 
 	if (IS_MNT_SHARED(from)) {
diff --git a/fs/pnode.c b/fs/pnode.c
index 0a54848cbbd1..69278079faeb 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -21,12 +21,12 @@ static inline struct mount *next_peer(struct mount *p)
 
 static inline struct mount *first_slave(struct mount *p)
 {
-	return list_entry(p->mnt_slave_list.next, struct mount, mnt_slave);
+	return hlist_entry(p->mnt_slave_list.first, struct mount, mnt_slave);
 }
 
 static inline struct mount *next_slave(struct mount *p)
 {
-	return list_entry(p->mnt_slave.next, struct mount, mnt_slave);
+	return hlist_entry(p->mnt_slave.next, struct mount, mnt_slave);
 }
 
 static struct mount *get_peer_under_root(struct mount *mnt,
@@ -85,21 +85,18 @@ static struct mount *propagation_source(struct mount *mnt)
 
 static void transfer_propagation(struct mount *mnt, struct mount *to)
 {
-	struct mount *slave_mnt;
-	if (!to) {
-		struct list_head *p = &mnt->mnt_slave_list;
-		while (!list_empty(p)) {
-			slave_mnt = list_first_entry(p,
-					struct mount, mnt_slave);
-			list_del_init(&slave_mnt->mnt_slave);
-			slave_mnt->mnt_master = NULL;
-		}
-		return;
+	struct hlist_node *p = NULL, *n;
+	struct mount *m;
+
+	hlist_for_each_entry_safe(m, n, &mnt->mnt_slave_list, mnt_slave) {
+		m->mnt_master = to;
+		if (!to)
+			hlist_del_init(&m->mnt_slave);
+		else
+			p = &m->mnt_slave;
 	}
-	list_for_each_entry(slave_mnt, &mnt->mnt_slave_list, mnt_slave)
-		slave_mnt->mnt_master = to;
-	list_splice(&mnt->mnt_slave_list, to->mnt_slave_list.prev);
-	INIT_LIST_HEAD(&mnt->mnt_slave_list);
+	if (p)
+		hlist_splice_init(&mnt->mnt_slave_list, p, &to->mnt_slave_list);
 }
 
 /*
@@ -124,10 +121,10 @@ void change_mnt_propagation(struct mount *mnt, int type)
 		transfer_propagation(mnt, m);
 		mnt->mnt_master = m;
 	}
-	list_del_init(&mnt->mnt_slave);
+	hlist_del_init(&mnt->mnt_slave);
 	if (type == MS_SLAVE) {
 		if (mnt->mnt_master)
-			list_add(&mnt->mnt_slave,
+			hlist_add_head(&mnt->mnt_slave,
 				 &mnt->mnt_master->mnt_slave_list);
 	} else {
 		mnt->mnt_master = NULL;
@@ -147,7 +144,7 @@ static struct mount *__propagation_next(struct mount *m,
 		if (master == origin->mnt_master) {
 			struct mount *next = next_peer(m);
 			return (next == origin) ? NULL : next;
-		} else if (m->mnt_slave.next != &master->mnt_slave_list)
+		} else if (m->mnt_slave.next)
 			return next_slave(m);
 
 		/* back at master */
@@ -169,7 +166,7 @@ static struct mount *propagation_next(struct mount *m,
 					 struct mount *origin)
 {
 	/* are there any slaves of this mount? */
-	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
+	if (!IS_MNT_NEW(m) && !hlist_empty(&m->mnt_slave_list))
 		return first_slave(m);
 
 	return __propagation_next(m, origin);
@@ -194,7 +191,7 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 	while (1) {
 		while (1) {
 			struct mount *next;
-			if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
+			if (!IS_MNT_NEW(m) && !hlist_empty(&m->mnt_slave_list))
 				return first_slave(m);
 			next = next_peer(m);
 			if (m->mnt_group_id == origin->mnt_group_id) {
@@ -207,7 +204,7 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 		/* m is the last peer */
 		while (1) {
 			struct mount *master = m->mnt_master;
-			if (m->mnt_slave.next != &master->mnt_slave_list)
+			if (m->mnt_slave.next)
 				return next_slave(m);
 			m = next_peer(master);
 			if (master->mnt_group_id == origin->mnt_group_id)
-- 
2.39.5


