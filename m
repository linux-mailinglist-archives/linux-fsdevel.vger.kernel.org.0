Return-Path: <linux-fsdevel+bounces-51124-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6D0AD2FFB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03E8165CAA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0991C2820A5;
	Tue, 10 Jun 2025 08:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jtUKJSs8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25781280008
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543713; cv=none; b=PQYxqs9zvIG48Q4tCFlsorbCrOJRzJ2R+oLoGGy9Z/qb6bfhgO3oo5aw8RJbbQceKvi/OhG6dpEFL0R8B6l5/TqMcbtNEhjTrCVjo72qNagRVW/ipTTtFlrjaB4C97Im20jSiHPV2BwOHNbTT3e1TlhHng/U2mMXGwQz+Z8n0u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543713; c=relaxed/simple;
	bh=dmMBb1SUcepBntVGe0sQgnvQ4sxuW04jpW9jEVkXhiY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aoSbUAi9GtiI2FND7sNpeXNIE9xbxy5YfLd4N5c9RUuW/XF5rw3t99M651251R0ZJXx3lXsB1PhyXgX7WhM8y+mMz/J3G5dblL2CoswUysSIsu2vBZwnzb0gb066IW/WbbdqB4jCfJgBKHFssLe+00n3qwndHaFEi87eRCOdND0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jtUKJSs8; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TJ6JHLl1zvT9YLGemchGjtvjJI19LWkspylK8rLeX0A=; b=jtUKJSs8hsnFUpoR6vcs+Wn0Bm
	qc7ugAXDKNHkqMdfA3sZuWTTuMRC6M7zqPIf3YkdEA6ZujdY4RjjZ/8yHOoXRWvnH5aZPRgY2inWs
	h2hjTlKKVUOjwIYjnFJuyVWa9cuo+J4Bz94ZkflKnCCg+tp6SdmR2NhiH7rNKChPLtGBu9n1vASsv
	dUyZOCfqNP/GvDCetmOHeiCZCsijKxpX6Yt9HTVs0EQjYxwntpBpJbTAeq4NZwJiK9kcTXqdStF6p
	XRuV48BpK1BTMTwfORqupX+WnjRch1xbbYuvvuaY/cF6dmDudkDOurHHwjnX4PqZFRa3Yb3HmzzHM
	21MgMgTA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEv-00000004jKq-3ISc;
	Tue, 10 Jun 2025 08:21:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 04/26] new predicate: mount_is_ancestor()
Date: Tue, 10 Jun 2025 09:21:26 +0100
Message-ID: <20250610082148.1127550-4-viro@zeniv.linux.org.uk>
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

mount_is_ancestor(p1, p2) returns true iff there is a possibly
empty ancestry chain from p1 to p2.

Convert the open-coded checks.  Unlike those open-coded variants
it does not depend upon p1 not being root...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 5eeb17c39fcb..b60cb35aa59c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3491,6 +3491,17 @@ static inline bool path_overmounted(const struct path *path)
 	return unlikely(!no_child);
 }
 
+/*
+ * Check if there is a possibly empty chain of descent from p1 to p2.
+ * Locks: namespace_sem (shared) or mount_lock (read_seqlock_excl).
+ */
+static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
+{
+	while (p2 != p1 && mnt_has_parent(p2))
+		p2 = p2->mnt_parent;
+	return p2 == p1;
+}
+
 /**
  * can_move_mount_beneath - check that we can mount beneath the top mount
  * @from: mount to mount beneath
@@ -3542,9 +3553,8 @@ static int can_move_mount_beneath(const struct path *from,
 	if (parent_mnt_to == current->nsproxy->mnt_ns->root)
 		return -EINVAL;
 
-	for (struct mount *p = mnt_from; mnt_has_parent(p); p = p->mnt_parent)
-		if (p == mnt_to)
-			return -EINVAL;
+	if (mount_is_ancestor(mnt_to, mnt_from))
+		return -EINVAL;
 
 	/*
 	 * If the parent mount propagates to the child mount this would
@@ -3713,9 +3723,8 @@ static int do_move_mount(struct path *old_path,
 	err = -ELOOP;
 	if (!check_for_nsfs_mounts(old))
 		goto out;
-	for (; mnt_has_parent(p); p = p->mnt_parent)
-		if (p == old)
-			goto out;
+	if (mount_is_ancestor(old, p))
+		goto out;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
 	if (err)
-- 
2.39.5


