Return-Path: <linux-fsdevel+bounces-48509-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 045D1AB0451
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 22:02:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB25F981E84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 May 2025 20:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080B6223DD8;
	Thu,  8 May 2025 20:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="BRpv7335"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE88820D4E3
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 May 2025 20:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746734565; cv=none; b=fJFWukzyMPqojj57wT0pEdKAY3tF19nw+qHhW0dq9c6asVcCcCNWUvTyUBqcPSYXAJ9ONq14+cmGgk6qTCCWsLHa5RCcqzMZqcxqqXU59C2yrRyS3aTkOuoRYQGP9drUeIF7tGyWFb3rlU6al1WzrVfKxwa70dlwopresSWL8Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746734565; c=relaxed/simple;
	bh=44VQruIGPzIpFWbdqoefVmyZMMeZ4LIPtVP4KoretoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=POYvHqdBtqFkVcs32jyvG7p6/FSIQG9dWPUTOLZIlcbWW98m1kZUIssGOohiUzZ+1sp9xkXFFWA66ngJM7dGQs/VmGYDEPdBW1gejyvqtmoiiq/YZA8cKjJtrG67uKxl0m1wVqgFSnCxp3ykA/Ybau2ey8AeCLyRlRlnErKEnNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=BRpv7335; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3oO8PvSLn/LFgN4rbkiuJ3dpnfBNKztDQasb/J4keDI=; b=BRpv7335AXv6IhziQQbnsrNxvT
	Ny4d6TdpmIiK1lVIfml65r9ZtC2ltW+zLPaLPA7/B1nljwhQWWApz8aEdhasURSWw7uLeuFHA84LR
	3XhUDPntrCunUgUeSS83djiThRjJEqCNMWSfalGD0/5KewJEbePk9YH68fsUXYKVRn2/ADpr0wtng
	Pypy3xiIGjzRO9W8Do0pBpaEthuWmbVToIRvUPI3fNATeP6IJ0l6GMJkdHx9D1VDJR4UWoRvZRgOl
	0AMMf+o6AxQ+Me2J5N3eVKIEytgzBxaHRWPBC1YT55iMFwcAm1k3PggV05VWEcw4ZgboGPpniIfz/
	ffqvmKfg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uD7S6-00000007qWi-0SSx;
	Thu, 08 May 2025 20:02:42 +0000
Date: Thu, 8 May 2025 21:02:42 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4/4] fix IS_MNT_PROPAGATING uses
Message-ID: <20250508200242.GG2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
 <20250428070353.GM2023217@ZenIV>
 <20250428-wortkarg-krabben-8692c5782475@brauner>
 <20250428185318.GN2023217@ZenIV>
 <20250508055610.GB2023217@ZenIV>
 <20250508195916.GC2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250508195916.GC2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

propagate_mnt() does not attach anything to mounts created during
propagate_mnt() itself.  What's more, anything on ->mnt_slave_list
of such new mount must also be new, so we don't need to even look
there.

When move_mount() had been introduced, we've got an additional
class of mounts to skip - if we are moving from anon namespace,
we do not want to propagate to mounts we are moving (i.e. all
mounts in that anon namespace).

Unfortunately, the part about "everything on their ->mnt_slave_list
will also be ignorable" is not true - if we have propagation graph
	A -> B -> C
and do OPEN_TREE_CLONE open_tree() of B, we get
	A -> [B <-> B'] -> C
as propagation graph, where B' is a clone of B in our detached tree.
Making B private will result in
	A -> B' -> C
C still gets propagation from A, as it would after making B private
if we hadn't done that open_tree(), but now the propagation goes
through B'.  Trying to move_mount() our detached tree on subdirectory
in A should have
	* moved B' on that subdirectory in A
	* skipped the corresponding subdirectory in B' itself
	* copied B' on the corresponding subdirectory in C.
As it is, the logics in propagation_next() and friends ends up
skipping propagation into C, since it doesn't consider anything
downstream of B'.

IOW, walking the propagation graph should only skip the ->mnt_slave_list
of new mounts; the only places where the check for "in that one
anon namespace" are applicable are propagate_one() (where we should
treat that as the same kind of thing as "mountpoint we are looking
at is not visible in the mount we are looking at") and
propagation_would_overmount().  The latter is better dealt with
in the caller (can_move_mount_beneath()); on the first call of
propagation_would_overmount() the test is always false, on the
second it is always true in "move from anon namespace" case and
always false in "move within our namespace" one, so it's easier
to just use check_mnt() before bothering with the second call and
be done with that.

Fixes: 064fe6e233e8 ("mount: handle mount propagation for detached mount trees")
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c |  3 ++-
 fs/pnode.c     | 17 +++++++++--------
 fs/pnode.h     |  2 +-
 3 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 04a9bb9f31fa..1b466c54a357 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3557,7 +3557,8 @@ static int can_move_mount_beneath(const struct path *from,
 	 * @mnt_from itself. This defeats the whole purpose of mounting
 	 * @mnt_from beneath @mnt_to.
 	 */
-	if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
+	if (check_mnt(mnt_from) &&
+	    propagation_would_overmount(parent_mnt_to, mnt_from, mp))
 		return -EINVAL;
 
 	return 0;
diff --git a/fs/pnode.c b/fs/pnode.c
index 7a062a5de10e..fb77427df39e 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -150,7 +150,7 @@ static struct mount *propagation_next(struct mount *m,
 					 struct mount *origin)
 {
 	/* are there any slaves of this mount? */
-	if (!IS_MNT_PROPAGATED(m) && !list_empty(&m->mnt_slave_list))
+	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
 		return first_slave(m);
 
 	while (1) {
@@ -174,7 +174,7 @@ static struct mount *skip_propagation_subtree(struct mount *m,
 	 * Advance m such that propagation_next will not return
 	 * the slaves of m.
 	 */
-	if (!IS_MNT_PROPAGATED(m) && !list_empty(&m->mnt_slave_list))
+	if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
 		m = last_slave(m);
 
 	return m;
@@ -185,7 +185,7 @@ static struct mount *next_group(struct mount *m, struct mount *origin)
 	while (1) {
 		while (1) {
 			struct mount *next;
-			if (!IS_MNT_PROPAGATED(m) && !list_empty(&m->mnt_slave_list))
+			if (!IS_MNT_NEW(m) && !list_empty(&m->mnt_slave_list))
 				return first_slave(m);
 			next = next_peer(m);
 			if (m->mnt_group_id == origin->mnt_group_id) {
@@ -226,11 +226,15 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 	struct mount *child;
 	int type;
 	/* skip ones added by this propagate_mnt() */
-	if (IS_MNT_PROPAGATED(m))
+	if (IS_MNT_NEW(m))
 		return 0;
-	/* skip if mountpoint isn't covered by it */
+	/* skip if mountpoint isn't visible in m */
 	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
 		return 0;
+	/* skip if m is in the anon_ns we are emptying */
+	if (m->mnt_ns->mntns_flags & MNTNS_PROPAGATING)
+		return 0;
+
 	if (peers(m, last_dest)) {
 		type = CL_MAKE_SHARED;
 	} else {
@@ -380,9 +384,6 @@ bool propagation_would_overmount(const struct mount *from,
 	if (!IS_MNT_SHARED(from))
 		return false;
 
-	if (IS_MNT_PROPAGATED(to))
-		return false;
-
 	if (to->mnt.mnt_root != mp->m_dentry)
 		return false;
 
diff --git a/fs/pnode.h b/fs/pnode.h
index ddafe0d087ca..34b6247af01d 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -12,7 +12,7 @@
 
 #define IS_MNT_SHARED(m) ((m)->mnt.mnt_flags & MNT_SHARED)
 #define IS_MNT_SLAVE(m) ((m)->mnt_master)
-#define IS_MNT_PROPAGATED(m) (!(m)->mnt_ns || ((m)->mnt_ns->mntns_flags & MNTNS_PROPAGATING))
+#define IS_MNT_NEW(m) (!(m)->mnt_ns)
 #define CLEAR_MNT_SHARED(m) ((m)->mnt.mnt_flags &= ~MNT_SHARED)
 #define IS_MNT_UNBINDABLE(m) ((m)->mnt.mnt_flags & MNT_UNBINDABLE)
 #define IS_MNT_MARKED(m) ((m)->mnt.mnt_flags & MNT_MARKED)
-- 
2.39.5


