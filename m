Return-Path: <linux-fsdevel+bounces-49123-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2723AB84B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 13:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E33F19E67DB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 May 2025 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DA9C2980B4;
	Thu, 15 May 2025 11:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sb2kaDAG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD96CC2C9
	for <linux-fsdevel@vger.kernel.org>; Thu, 15 May 2025 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747308330; cv=none; b=ZdZg3IqS+qdWGELL+8xOiwqVlk7XbzpsiL2uLVC1Tv6uttCIFhNNe1cPoWSjTlj4C50nKW9FQO0oBOyVLrzwMt5XwKEQ26hUGtwDNzuW8FNXKL13i4ptD98UBpuvWeuqYh3JYuiTdYLgn2bl2N/nVDj6GadKVcK3OliX1Xs9HIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747308330; c=relaxed/simple;
	bh=bF8pefb3xdRSGr9Jji/EFCpHrUsXPdXhWboeIdJCCPk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K6ht1+zEaXZgMgPBzFjCkUZ0Of9BsTOWCfc2HxfXSV47sTxNqGW4ETWsDwOgPoLVawWzCHV+bIqaGorTt1ARtdPDZ9JZ8QTpKByGedZS4K+lEF+DIu9jnVgIa6+SccUOplQ6Qn0UQz6VxXOUNeKahXQRJfYB8xnNIW4al4Ysx8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sb2kaDAG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D805C4CEE7;
	Thu, 15 May 2025 11:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747308330;
	bh=bF8pefb3xdRSGr9Jji/EFCpHrUsXPdXhWboeIdJCCPk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sb2kaDAGw1SiqZkIuFK26KyO28AVoHhI9p426tE/N/Bpz64wBKRcSHeySxiqcZR/p
	 s+gYvMYtGoCHeW/MEgzmNfGYOXa0pEm+gA8LPmL8gygHgP6pJmSjUV9Pz3boCgNExO
	 tsT6deFzQZfM+WZuHWePpJoc6etRqVl70l/RbsRhZ//UNi1xE6bOAilikIDR1OievS
	 VSWreOCD9ge4dFqCdwDtLruGKLdAXLTUEZnKDUx5dMI/zTFbcYyXiBrdke79QzfKjh
	 IN3vtzJeV2mMz8PDwHYPA+I3Pl1+kXY1ac2TO4joDmYxhOx4BeI3L+MAVC/mNnhCO/
	 tRhT45smm2o5A==
Date: Thu, 15 May 2025 13:25:27 +0200
From: Christian Brauner <brauner@kernel.org>
To: Allison Karlitskaya <lis@redhat.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: Apparent mount behaviour change in 6.15
Message-ID: <20250515-abhauen-geflecht-c7eb5df70b78@brauner>
References: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOYeF9WQhFDe+BGW=Dp5fK8oRy5AgZ6zokVyTj1Wp4EUiYgt4w@mail.gmail.com>

On Thu, May 15, 2025 at 06:06:13AM +0200, Allison Karlitskaya wrote:
> hi,
> 
> The CI in the composefs-rs project picked up an interesting issue with
> the recent mount API changes in the latest 6.15-rc kernels.  I've
> managed to produce a minimal reproducer.
> 
> ==> test.sh <==
> #!/bin/sh
> 
> set -eux
> 
> uname -a
> umount --recursive tmp/mnt || true
> rm -rf tmp/mnt tmp/new
> mkdir -p tmp/mnt tmp/new tmp/new/old
> touch tmp/mnt/this-is-old
> touch tmp/new/this-is-new
> ./swapmnt tmp/new tmp/mnt
> find tmp/mnt
> 
> ==> swapmnt.c <==
> // Replace [old] with a clone of [new], moving [old] to [new]/"old"
> 
> #define _GNU_SOURCE
> #include <err.h>
> #include <fcntl.h>
> #include <linux/mount.h>
> #include <stdio.h>
> #include <stdlib.h>
> #include <sys/stat.h>
> #include <sys/syscall.h>
> #include <unistd.h>
> 
> int
> main (int argc, char **argv) {
>   if (argc != 3) {
>     fprintf(stderr, "usage: %s [new] [old]", argv[0]);
>     return 1;
>   }
> 
>   const char *new = argv[1];
>   const char *old = argv[2];
> 
>   int oldfd = syscall(SYS_open_tree, AT_FDCWD, old,
> OPEN_TREE_CLONE|OPEN_TREE_CLOEXEC);
>   if (oldfd == -1)
>     err(EXIT_FAILURE, "open_tree('%s', OPEN_TREE_CLONE)", old);
> 
>   int newfd = syscall(SYS_open_tree, AT_FDCWD, new,
> OPEN_TREE_CLONE|OPEN_TREE_CLOEXEC);
>   if (newfd == -1)
>     err(EXIT_FAILURE, "open_tree('%s', OPEN_TREE_CLONE)", new);
> 
>   if (syscall(SYS_move_mount, newfd, "", AT_FDCWD, old,
> MOVE_MOUNT_F_EMPTY_PATH))
>     err(EXIT_FAILURE, "move_mount('%s' -> '%s')", new, old);
> 
>   if (syscall(SYS_move_mount, oldfd, "", newfd, "old", MOVE_MOUNT_F_EMPTY_PATH))
>     err(EXIT_FAILURE, "move_mount('%s' -> (new)'%s'/old)", old, old);
> 
>   return 0;
> }
> 
> On 6.14 (Fedora 42) this looks like:
> 
> [root@fedora-bls-efi-127-0-0-2-2201 tmp]# sh test.sh
> + uname -a
> Linux fedora-bls-efi-127-0-0-2-2201 6.14.5-300.fc42.x86_64 #1 SMP
> PREEMPT_DYNAMIC Fri May  2 14:16:46 UTC 2025 x86_64 GNU/Linux
> + umount --recursive tmp/mnt
> umount: tmp/mnt: not found
> + true
> + rm -rf tmp/mnt tmp/new
> + mkdir -p tmp/mnt tmp/new tmp/new/old
> + touch tmp/mnt/this-is-old
> + touch tmp/new/this-is-new
> + ./swapmnt tmp/new tmp/mnt
> + find tmp/mnt
> tmp/mnt
> tmp/mnt/this-is-new
> tmp/mnt/old
> tmp/mnt/old/this-is-old
> [root@fedora-bls-efi-127-0-0-2-2201 tmp]#
> 
> On 6.15 from yesterday (9f35e33144ae, via @kernel-vanilla/mainline
> copr, on rawhide):
> 
> [root@fedora tmp]# sh test.sh
> + uname -a
> Linux fedora 6.15.0-0.rc6.20250514.9f35e331.450.vanilla.fc43.x86_64 #1
> SMP PREEMPT_DYNAMIC Wed May 14 04:18:35 UTC 2025 x86_64 GNU/Linux
> + umount --recursive tmp/mnt
> umount: tmp/mnt: not mounted
> + true
> + rm -rf tmp/mnt tmp/new
> + mkdir -p tmp/mnt tmp/new tmp/new/old
> + touch tmp/mnt/this-is-old
> + touch tmp/new/this-is-new
> + ./swapmnt tmp/new tmp/mnt
> + find tmp/mnt
> tmp/mnt
> tmp/mnt/this-is-new
> find: File system loop detected; ‘tmp/mnt/old’ is part of the same
> file system loop as ‘tmp/mnt’.
> [root@fedora tmp]#
> 
> Otherwise, I gotta say I'm loving all of the new mount work this cycle!

Thank you! I'm happy it's useful and that it's picked up so quickly! :)

This is caused by my patch to allow mount propagation into detached
mount trees. That had been disabled forever until v6.15 to give strong
guarantees to userspace that detached mount trees are really detached.

I thought it might be useful for them to partake in propagation
via the MNTNS_PROPAGATION flag. But I've alredy expressed that I regret
this in another thread we had.

Al, I want to kill this again and restore the pre v6.15 behavior.
Allowing mount propagation for detached trees was a crazy
idea on my part. It's a pain and it regresses userspace. If composefs is
broken by this then systemd will absolutely get broken by my change as
well.

Something like this will allow to restore the status-quo:

 fs/mount.h     |  5 -----
 fs/namespace.c | 15 ++-------------
 fs/pnode.c     |  3 ---
 fs/pnode.h     |  2 +-
 4 files changed, 3 insertions(+), 22 deletions(-)

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
index 04a9bb9f31fa..900ffaeff7c6 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3647,7 +3647,7 @@ static int do_move_mount(struct path *old_path,
 	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
 		goto out;
 
-	if (is_anon_ns(ns)) {
+	if (is_anon_ns(ns) && ns == p->mnt_ns) {
 		/*
 		 * Ending up with two files referring to the root of the
 		 * same anonymous mount namespace would cause an error
@@ -3655,16 +3655,7 @@ static int do_move_mount(struct path *old_path,
 		 * twice into the mount tree which would be rejected
 		 * later. But be explicit about it right here.
 		 */
-		if ((is_anon_ns(p->mnt_ns) && ns == p->mnt_ns))
-			goto out;
-
-		/*
-		 * If this is an anonymous mount tree ensure that mount
-		 * propagation can detect mounts that were just
-		 * propagated to the target mount tree so we don't
-		 * propagate onto them.
-		 */
-		ns->mntns_flags |= MNTNS_PROPAGATING;
+		goto out;
 	} else if (is_anon_ns(p->mnt_ns)) {
 		/*
 		 * Don't allow moving an attached mount tree to an
@@ -3721,8 +3712,6 @@ static int do_move_mount(struct path *old_path,
 	if (attached)
 		put_mountpoint(old_mp);
 out:
-	if (is_anon_ns(ns))
-		ns->mntns_flags &= ~MNTNS_PROPAGATING;
 	unlock_mount(mp);
 	if (!err) {
 		if (attached) {
diff --git a/fs/pnode.c b/fs/pnode.c
index fb77427df39e..d80944d66237 100644
--- a/fs/pnode.c
+++ b/fs/pnode.c
@@ -231,9 +231,6 @@ static int propagate_one(struct mount *m, struct mountpoint *dest_mp)
 	/* skip if mountpoint isn't visible in m */
 	if (!is_subdir(dest_mp->m_dentry, m->mnt.mnt_root))
 		return 0;
-	/* skip if m is in the anon_ns we are emptying */
-	if (m->mnt_ns->mntns_flags & MNTNS_PROPAGATING)
-		return 0;
 
 	if (peers(m, last_dest)) {
 		type = CL_MAKE_SHARED;
diff --git a/fs/pnode.h b/fs/pnode.h
index 34b6247af01d..077028814e8d 100644
--- a/fs/pnode.h
+++ b/fs/pnode.h
@@ -12,7 +12,7 @@
 
 #define IS_MNT_SHARED(m) ((m)->mnt.mnt_flags & MNT_SHARED)
 #define IS_MNT_SLAVE(m) ((m)->mnt_master)
-#define IS_MNT_NEW(m) (!(m)->mnt_ns)
+#define IS_MNT_NEW(m) (!(m)->mnt_ns || is_anon_ns((m)->mnt_ns))
 #define CLEAR_MNT_SHARED(m) ((m)->mnt.mnt_flags &= ~MNT_SHARED)
 #define IS_MNT_UNBINDABLE(m) ((m)->mnt.mnt_flags & MNT_UNBINDABLE)
 #define IS_MNT_MARKED(m) ((m)->mnt.mnt_flags & MNT_MARKED)
-- 
2.47.2


