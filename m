Return-Path: <linux-fsdevel+bounces-47488-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B49FEA9E834
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 08:31:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B93A1799EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Apr 2025 06:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6451D5170;
	Mon, 28 Apr 2025 06:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VO4yYOGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AC81C84D7
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Apr 2025 06:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745821862; cv=none; b=NUt5DNXWlWDatVKNKyM7llJNvOtFIY97Z/iKKlHJ4UE9U2dsABj103tVxq0qS/fa2CWEM934pOYx3V0w5vxPrUhpiXb8eK8hRK0XrShp5U3QnsRk/zKgnCNpjvvPUCxLIgBKScW0yu8FNRKkvqcW3gQpOcKwjjnSdEriH7MHfsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745821862; c=relaxed/simple;
	bh=xyv1o9KqvHtsdhFqYncS6clv02jitmXXdqGs/VrvaYY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=scCPLj5Ne8P1rCBTlm2oen+kcxz8dT2g8/r7hp3cmLZDqjYDHLPYqoLkFLXYtakO9gzhIaPYCKRacKbQFjFIvwIjPx64wv+dll/3zjr9VHChexV8Gs9q7yMYM/4ChNNmle+8GoqGnFNohd5ere4czCeN4iiIt4Ju0AuaT+839RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VO4yYOGt; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=lrQPRFkBD1oPwAdVGuyz0o2BacjK+3NAFJlx5U4Gc5U=; b=VO4yYOGt9elHUf681te2Oaa18X
	RXuXN02PKzfY1XjxpeBKCZkkyhuco2Bs8w1XUylUdzeyUVB1UPVzsHZ55BcTkG7/+Sup6gC4QU949
	aUE4kdoWidZjHqVC4N8hzAY1c3wl9Z/8l/VJmJw/ZxQW41kGXi9iNF3jUXIKM/SZEzSD/IvitIbSD
	BOdiPxcBlindyQuJNiPArpU03GGqtS/B6leaSoPwdggtxdbSNhj7bR3AqeCfdGsNuEH0Wumg3CnmD
	i54cVlPB6AXQeClhbGToY7a9+rBGSTFKcDf+vX5ezjOS0jq0dzewU8FCJGHyneWrGWYZyGe1GwCwf
	aZfD846w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9I12-00000006L2O-2UKm;
	Mon, 28 Apr 2025 06:30:56 +0000
Date: Mon, 28 Apr 2025 07:30:56 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [RFC] move_mount(2): still breakage around new mount detection
Message-ID: <20250428063056.GL2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>

	do_move_mount() sets MNTNS_PROPAGATING on move from
anon ns; AFAICS, the cause is that we want everything in
the original copy to be treated as new mounts while handling
propagation.  We could go through the subtree and clear
->mnt_ns before propagation, but then we'd need to restore
them on failure, so you mark the source anon namespace
and make the check for new mount look at that as well.

	Fair enough, but...  you clear that flag exactly in
the case when doing that is absolutely pointless - 
        if (err)
                goto out;

        if (is_anon_ns(ns))
                ns->mntns_flags &= ~MNTNS_PROPAGATING;

        /* if the mount is moved, it should no longer be expire
         * automatically */
        list_del_init(&old->mnt_expire);
        if (attached)
                put_mountpoint(old_mp);
out:
        unlock_mount(mp);
        if (!err) {
                if (attached) {
                        mntput_no_expire(parent);
                } else {
                        /* Make sure we notice when we leak mounts. */
                        VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
                        free_mnt_ns(ns);
                }
        }
And in the beginning you have
        ns = old->mnt_ns;
...
        if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
                goto out;
with check_mnt() and is_anon_ns() being mutually exclusive.

So you clear that flag *only* if err is 0 and attached is false.
Which is to say, in case when you will hit free_mnt_ns(ns).

And you do leave it stuck on failure, which is an observable
bug, AFAICS.

Look:
	mkdir foo
	mkdir blah
	mount --make-private foo
	mount --bind foo foo
	mount --make-shared foo
	fd = open_tree(AT_FDCWD, "foo", OPEN_TREE_CLONE)
	mkdir foo/bar
	mount -t tmpfs none foo/bar
	echo "hedgehog can never be buggered at all" > foo/bar/baz
	move_mount(fd, "", AT_FDCWD, "blah", MOVE_MOUNT_F_EMPTY_PATH)
you get tmpfs showing up at blah/bar, as expected, with
	cat blah/bar/baz
quoting PTerry.  Now, add a *failing* move_mount() attempt right after that
open_tree() - e.g. insert
	move_mount(fd, "", AT_FDCWD, "/dev/null", MOVE_MOUNT_F_EMPTY_PATH)
right before mkdir foo/bar; that move_mount() will fail since source is
a directory and destination isn't.  But... when the second move_mount()
succeeds, there won't be anything mounted on blah/bar.

See the problem?  FWIW, actual reproducer:

#include <sys/mount.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

char s[] = "hedgehog can never be buggered at all\n";
main()
{
	int fd, fd2;

	mkdir("foo", 0700);
	mkdir("blah", 0700);
	mount(NULL, "foo", NULL, MS_PRIVATE, NULL);
	mount("foo", "foo", NULL, MS_BIND, NULL);
	mount(NULL, "foo", NULL, MS_SHARED, NULL);
        fd = open_tree(AT_FDCWD, "foo", OPEN_TREE_CLONE);
        mkdir("foo/bar", 0700);

#if 1
	printf("this move_mount() will fail\n");
        if (move_mount(fd, "", AT_FDCWD, "/dev/null", MOVE_MOUNT_F_EMPTY_PATH) == 0)
		return -1;
	perror("first move_mount");
#endif

	mount("none", "foo/bar", "tmpfs", 0, NULL);
	fd2 = creat("foo/bar/baz", 0600);
	write(fd2, s, strlen(s));
	close(fd2);
	printf("this move_mount() should succeed... ");
        if (move_mount(fd, "", AT_FDCWD, "blah", MOVE_MOUNT_F_EMPTY_PATH) < 0)
		perror("failed");
	else
		printf("it has\n");
        system("cat blah/bar/baz");
	umount2("foo", MNT_DETACH);
	umount2("blah", 0);
	return 0;
}

Replace #if 1 with #if 0 and compare results...

The minimal fix would be to move that
        if (is_anon_ns(ns))
                ns->mntns_flags &= ~MNTNS_PROPAGATING;

several lines down, right after out:; that's the easiest to backport.
However, I'm rather dubious about the flag thing - at any time we should
have at most one ns so marked, right?  And we only care about it in
propagate_mnt(), where we are serialized under namespace_lock.
So why not simply remember the anon_ns we would've marked and compare
->mnt_ns with it instead of dereferencing and checking for flag?

IOW, what's wrong with the following?

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
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
index eba4748388b1..191f88efc6ef 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3656,14 +3656,6 @@ static int do_move_mount(struct path *old_path,
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
@@ -3714,9 +3706,6 @@ static int do_move_mount(struct path *old_path,
 	if (err)
 		goto out;
 
-	if (is_anon_ns(ns))
-		ns->mntns_flags &= ~MNTNS_PROPAGATING;
-
 	/* if the mount is moved, it should no longer be expire
 	 * automatically */
 	list_del_init(&old->mnt_expire);
diff --git a/fs/pnode.c b/fs/pnode.c
index 7a062a5de10e..3285aeb25f38 100644
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

