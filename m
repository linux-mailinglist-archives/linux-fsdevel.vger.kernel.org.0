Return-Path: <linux-fsdevel+bounces-53269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E42FFAED29E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:54:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16ECD168C50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BEC209F2E;
	Mon, 30 Jun 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="lkYeVlum"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED571ABED9
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251982; cv=none; b=umr7uofUoi9zE5FsE5wOenL8LjZxszXbOS7E2Du/f9PfzXl1Gzc+laUk2bOQ1w8sqD1BNJyClJyuRupXHyEi4cTRAUEQxNmE9+RysCathjDiv6h2tgh9E8PiWZOipd3syH3Rd6K7P7EKNL/BlcZLeycv7YHhxAuJohkjVxNLJSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251982; c=relaxed/simple;
	bh=A5CE8Pv3g1crJLR0ADYHDSFnOIVweLGQv7sIsIzp0oA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFS/KsDC1fcgxRIZWjXBJCpmrmELAB/d8Hv0xK65+ha+fA6taBFM/bH2H7lDDDQ0q2TTtqVgR/gz0I5yWkgLP+PiKTErHNK3pWoC/j3tCEcpzAFoWVgc8s5vmTX+Zyf06WPms13j3csXbEoNz5Zr83VUa43+lEsyGHe+fSitCE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=lkYeVlum; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=IGq2aG5LCOL2uxHTdjdlYSmcdrbOBy0S/8HFGoX7cww=; b=lkYeVlumjvQUSUwiJe7fj9tNo1
	abLEGvf4gwv+RQ0y4mDJwKdeAGg4rwnTiE616KDpdHRUqBJc3ad+3EY0FJzzALWJlcKZP7UlzGbKZ
	/yMjr/rKFMnvGbqum7z/AH6MmeAOsItno6RXnFoMqFaXLpC/gJIAb+xGAYHxFFXUGcQlVBpbwxeVL
	W27zjmvvgC29uG2xFJaDEqVL03BSDosHQGbYDEXMJdUoVcvu8Fqxwho0uvhhBMTWQMKcnyz8LMIqR
	afEJdXL52HPtKNd4UFsglT0P9u8ceVFlwJgCFjPCHZLPI7Jtf4cb+yYmWwIBf18+Cf6mhScXyht/c
	uUl/dezw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4de-00000005p1G-2Mh1;
	Mon, 30 Jun 2025 02:52:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 30/48] propagate_one(): get rid of dest_master
Date: Mon, 30 Jun 2025 03:52:37 +0100
Message-ID: <20250630025255.1387419-30-viro@zeniv.linux.org.uk>
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

propagate_mnt() takes the subtree we are about to attach and creates
its copies, setting the propagation between those.  Each copy is cloned
either from the original or from one of the already created copies.
The tricky part is choosing the right copy to serve as a master when we
are starting a new peer group.

The algorithm for doing that selection puts temporary marks on the masters
of mountpoints that already got a copy created for them; since the initial
peer group might have no master at all, we need to special-case that when
looking for the mark.  Currently we do that by memorizing the master of
original peer group.  It works, but we get yet another piece of data to
pass from propagate_mnt() to propagate_one().

Alternative is to mark the master of original peer group if not NULL,
turning the check into "master is NULL or marked".  Less data to pass
around and memory safety is more obvious that way...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/pnode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/pnode.c b/fs/pnode.c
index b997663de6d0..870ebced10aa 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -215,7 +215,7 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 }
 
 /* all accesses are serialized by namespace_sem */
-static struct mount *last_dest, *first_source, *last_source, *dest_master;
+static struct mount *last_dest, *first_source, *last_source;
 static struct hlist_head *list;
 
 static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
@@ -239,7 +239,7 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 		bool done;
 		for (n = m; ; n = p) {
 			p = n->mnt_master;
-			if (p == dest_master || IS_MNT_MARKED(p))
+			if (!p || IS_MNT_MARKED(p))
 				break;
 		}
 		do {
@@ -264,7 +264,7 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 	read_seqlock_excl(&mount_lock);
 	mnt_set_mountpoint(m, dest_mp, child);
 	read_sequnlock_excl(&mount_lock);
-	if (m->mnt_master != dest_master)
+	if (m->mnt_master)
 		SET_MNT_MARK(m->mnt_master);
 	last_dest = m;
 	last_source = child;
@@ -300,7 +300,8 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	first_source = source_mnt;
 	last_source = source_mnt;
 	list = tree_list;
-	dest_master = dest_mnt->mnt_master;
+	if (dest_mnt->mnt_master)
+		SET_MNT_MARK(dest_mnt->mnt_master);
 
 	/* all peers of dest_mnt, except dest_mnt itself */
 	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
@@ -324,9 +325,11 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 out:
 	hlist_for_each_entry(n, tree_list, mnt_hash) {
 		m = n->mnt_parent;
-		if (m->mnt_master != dest_mnt->mnt_master)
+		if (m->mnt_master)
 			CLEAR_MNT_MARK(m->mnt_master);
 	}
+	if (dest_mnt->mnt_master)
+		CLEAR_MNT_MARK(dest_mnt->mnt_master);
 	return ret;
 }
 
-- 
2.39.5


