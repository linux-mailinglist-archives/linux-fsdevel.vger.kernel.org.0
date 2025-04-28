Return-Path: <linux-fsdevel+bounces-47489-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E69A9E8C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 09:04:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8C23AB37F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC491C9EB1;
	Mon, 28 Apr 2025 07:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="KpTLaw+C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514A43C3C
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745823838; cv=none; b=h3j32x7BAObL5HNZOW9ocgIbp4kk3/0MPMXc41kLn+6Rd/2mB39rRz/lmvp9a3dqCVpdB4cZqV7EJArMNfGOvF25365z0/d1FVuaoDe8KO+Sfno8Q85UVyYhZxOWbRkr4pjPbhJTBlggAgpnUzr8b+hRaPIlWQM3Ra0bgI2TQ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745823838; c=relaxed/simple;
	bh=2OSPW8fgaMcrxDQoyK+tqQRMk92HybTPVYv2zepBVn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c9dVW0QHRs4HHqwhyWFFzO9xtMg9ldElNW7PTzO60jIROYtqJOaf5JqUPc6f2+j9D2V4YsBg8qUybeNvbtjloiK/xkGHnGsuAc79wagSteab84LBmTt2gYCrV/r/FvHAOIboyQA8Ob1+bnxMluOkddNSxYTdgu6q8ZuFZjtx4Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=KpTLaw+C; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=E6ISd+/sZg+sVfkZTbL/515hKYok9F/HWwmBF1C6DHo=; b=KpTLaw+CBMXRaFyRxJOeE4klm5
	LflgA6+bQ3LjkYeOEEkQVSvQWTq1eK0CoTQOWRNS0BJpg4ueHjmvi3cQ+ii5YBn8k9NXTq+nNR0/G
	k8haIpYK7Onb0JUIJM00czJfZk/H5rIgo7tn6uIHvlZUH3VmuC1OV19heDx1RnSDJG7eR6vLLC0de
	WDAdfNtUsil2rRTZzcOUYuJs4SF5iB3l1nbQ/Lhli/dKIlr1j8fNwDM+qsEwneFND7it+46un4amV
	m5lxqMvwayvK6XsemEtsO9IgESmr13mv777iMIFplE7EU/15r1nKfD8J/5RQzoKbMgBllmYea+dUM
	u9/oHHYg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9IWv-00000006Sf4-1Afu;
	Mon, 28 Apr 2025 07:03:53 +0000
Date: Mon, 28 Apr 2025 08:03:53 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250428070353.GM2023217@ZenIV>
References: <20250428063056.GL2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428063056.GL2023217@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Apr 28, 2025 at 07:30:56AM +0100, Al Viro wrote:
> have at most one ns so marked, right?  And we only care about it in
> propagate_mnt(), where we are serialized under namespace_lock.
> So why not simply remember the anon_ns we would've marked and compare
> ->mnt_ns with it instead of dereferencing and checking for flag?
> 
> IOW, what's wrong with the following?

Hmm... You also have propagation_would_overmount() (from
can_move_mount_beneath()) checking it...  IDGI.

For that predicate to trigger in there you need source
anon ns - you won't see NULL ->mnt_ns there.  So...
mnt_from is the absolute root of anon ns, target is
*not* in that anon ns (either it's in our current namespace,
or in a different anon ns).  IOW, in
        if (propagation_would_overmount(parent_mnt_to, mnt_to, mp))
		return -EINVAL;
IS_MNT_PROPAGATED() will be false (mnt_to has unmarked namespace)
and in
        if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
		return -EINVAL;
IS_MNT_PROPAGATED() is true.  So basically, we can drop that
check inf propagation_would_overmount() and take it to
can_move_mount_beneath(), turning the second check into
        if (check_mnt(mnt_from) &&
	    propagation_would_overmount(parent_mnt_to, mnt_from, mp))
		    return -EINVAL;
since mnt_from is either ours or root of anon and the check removed
from propagation_would_overmount() had it return false in "mnt_from
is root of anon" case.

And we obviously need it cleared at the end of propagate_mnt(),
yielding the patch below.  Do you see any other problems?

diff --git a/fs/mount.h b/fs/mount.h
index 7aecf2a60472..ad7173037924 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -7,10 +7,6 @@
 
 extern struct list_head notify_list;
 
-typedef __u32 __bitwise mntns_flags_t;
-
-#define MNTNS_PROPAGATING	((__force mntns_flags_t)(1 << 0))
-
 struct mnt_namespace {
 	struct ns_common	ns;
 	struct mount *	root;
@@ -37,7 +33,6 @@ struct mnt_namespace {
 	struct rb_node		mnt_ns_tree_node; /* node in the mnt_ns_tree */
 	struct list_head	mnt_ns_list; /* entry in the sequential list of mounts namespace */
 	refcount_t		passive; /* number references not pinning @mounts */
-	mntns_flags_t		mntns_flags;
 } __randomize_layout;
 
 struct mnt_pcp {
diff --git a/fs/namespace.c b/fs/namespace.c
index eba4748388b1..3061f1b04d4c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3556,7 +3556,8 @@ static int can_move_mount_beneath(const struct path *from,
 	 * @mnt_from itself. This defeats the whole purpose of mounting
 	 * @mnt_from beneath @mnt_to.
 	 */
-	if (propagation_would_overmount(parent_mnt_to, mnt_from, mp))
+	if (check_mnt(mnt_from) &&
+	    propagation_would_overmount(parent_mnt_to, mnt_from, mp))
 		return -EINVAL;
 
 	return 0;
@@ -3656,14 +3657,6 @@ static int do_move_mount(struct path *old_path,
 		 */
 		if ((is_anon_ns(p->mnt_ns) && ns == p->mnt_ns))
 			goto out;
-
-		/*
-		 * If this is an anonymous mount tree ensure that mount
-		 * propagation can detect mounts that were just
-		 * propagated to the target mount tree so we don't
-		 * propagate onto them.
-		 */
-		ns->mntns_flags |= MNTNS_PROPAGATING;
 	} else if (is_anon_ns(p->mnt_ns)) {
 		/*
 		 * Don't allow moving an attached mount tree to an
@@ -3714,9 +3707,6 @@ static int do_move_mount(struct path *old_path,
 	if (err)
 		goto out;
 
-	if (is_anon_ns(ns))
-		ns->mntns_flags &= ~MNTNS_PROPAGATING;
-
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
diff --git a/fs/pnode.c b/fs/pnode.c
index 7a062a5de10e..26d0482fe017 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -13,6 +13,18 @@
 #include "internal.h"
 #include "pnode.h"
 
+static struct mnt_namespace *source_anon;
+static inline bool IS_MNT_PROPAGATED(const struct mount *m)
+{
+	/*
+	 * If this is an anonymous mount tree ensure that mount
+	 * propagation can detect mounts that were just
+	 * propagated to the target mount tree so we don't
+	 * propagate onto them.
+	 */
+	return !m->mnt_ns || m->mnt_ns == source_anon;
+}
+
 /* return the next shared peer mount of @p */
 static inline struct mount *next_peer(struct mount *p)
 {
@@ -300,6 +312,9 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 	last_source = source_mnt;
 	list = tree_list;
 	dest_master = dest_mnt->mnt_master;
+	source_anon = source_mnt->mnt_ns;
+	if (source_anon && !is_anon_ns(source_anon))
+		source_anon = NULL;
 
 	/* all peers of dest_mnt, except dest_mnt itself */
 	for (n = next_peer(dest_mnt); n != dest_mnt; n = next_peer(n)) {
@@ -328,6 +343,7 @@ int propagate_mnt(struct mount *dest_mnt, struct mountpoint *dest_mp,
 			CLEAR_MNT_MARK(m->mnt_master);
 	}
 	read_sequnlock_excl(&mount_lock);
+	source_anon = NULL;
 	return ret;
 }
 
@@ -380,9 +396,6 @@ bool propagation_would_overmount(const struct mount *from,
 	if (!IS_MNT_SHARED(from))
 		return false;
 
-	if (IS_MNT_PROPAGATED(to))
-		return false;
-
 	if (to->mnt.mnt_root != mp->m_dentry)
 		return false;
 
diff --git a/fs/pnode.h b/fs/pnode.h
index ddafe0d087ca..ba28110c87d2 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -12,7 +12,6 @@
 
 #define IS_MNT_SHARED(m) ((m)->mnt.mnt_flags & MNT_SHARED)
 #define IS_MNT_SLAVE(m) ((m)->mnt_master)
-#define IS_MNT_PROPAGATED(m) (!(m)->mnt_ns || ((m)->mnt_ns->mntns_flags & MNTNS_PROPAGATING))
 #define CLEAR_MNT_SHARED(m) ((m)->mnt.mnt_flags &= ~MNT_SHARED)
 #define IS_MNT_UNBINDABLE(m) ((m)->mnt.mnt_flags & MNT_UNBINDABLE)
 #define IS_MNT_MARKED(m) ((m)->mnt.mnt_flags & MNT_MARKED)

