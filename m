Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 531D8F72A8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2019 12:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfKKLBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Nov 2019 06:01:07 -0500
Received: from relay.sw.ru ([185.231.240.75]:35558 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726791AbfKKLBH (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Nov 2019 06:01:07 -0500
Received: from dhcp-172-16-24-163.sw.ru ([172.16.24.163] helo=snorch.sw.ru)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ptikhomirov@virtuozzo.com>)
        id 1iU7Qu-00028X-SV; Mon, 11 Nov 2019 14:00:33 +0300
From:   Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     Jeff Layton <jlayton@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org,
        Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
        Andrei Vagin <avagin@gmail.com>, <devel@openvz.org>
Subject: [PATCH] fs: add new O_MNT flag for opening mount root from mountpoint fd
Date:   Mon, 11 Nov 2019 14:00:29 +0300
Message-Id: <20191111110029.16483-1-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Imagine that we have an open fd on the directory (or file) - dfd, and a
new mount - mnt is created with these directory as a mountpoint. Before
this patch we had no way to access the contents of mnt through these
dfd.

You would say - who cares, we can just open it by path. But actually it
is not always possible: one can make a (I call it) "propagation trap"
when mnt's propagation overmounts mnt and makes it unresolvable with
simple open just after creation.

You can say - just pre-open the dfd's parent directory - pdfd like you
did with dfd, and you will have access to mnt, but what is not generic,
e.g. if mount point is '/', it can't have pdfd. And also this pdfd
pre-open does not work in case you want to create a mount under some
other mount (these can happen through propagation) there is no way to
access the root of such a mount currently after it was created. (*)

To be extra safe here, add a check that the new path which will be
opened with O_MNT is not getting under MNT_LOCKED mount and can be
accessed. Currently I see no way to get such an fd under locked mount
but better have a precaution here.

But why I actually need these:

When we recreate mount tree in CRIU, we do it by recreating one mount at
a time (we don't have mount-save / mount-restore like with iptables) and
it is quiet hard to determine the right order in which mounts should be
restored: if we mount mnt it can hide directories under it's mountpoint,
so either we need to first create all mounts under mnt's mountpoint and
only after these  mount mnt, or all mounts under mnt can be propagated
and we can safely mount mnt now? Moreover if mnt is not mounted, it can
also block other mounts with other "dependencies" (something like mnt's
child can be in a propagation group with some of mnt's undermounts and
they need to be mounted as one), and we can have circular dependency if
we have wrong order chosen and will fail.

So it would be easier for us if we can create mounts in the file tree
even if the mountpoint is invisible from root. And one way how it could
be done is: First, to have open fd to mountpoint under each mount,
second, to have open fd to each mount root.

More precisely the algorithm is:
a) openat mpfd to a new mountpoint through parent mount's root -
p_rootfd (which we already have) or mountpoint fd under a sibling mount
- s_mpfd if our mountpoint is already overmounted.
b) create a new mount on mpfd via /proc/<pid>/fd/<N> interface
c) openat it's rootfd via O_MNT from mpfd

If we have mpfd and rootfd for each mount through /proc/<pid>/fd/<N>
interface we will be able to bindmount any part of each of already
created mounts to restore other mounts  and we will be able to configure
mounts, e.g. change sharing or other options even if mounts are
invisible from fs-root.

Here is an example of how O_MNT works:

  #term1
	  #term2

  mkdir /test-mounts
  mount -t tmpfs tmpfs-test-mounts /test-mounts
  mount --make-private /test-mounts
  cd /test-mounts/
  mkdir sh1 sh2
  mount -t tmpfs tmpfs_sh sh1
  mount --make-shared sh1
  mkdir sh1/mp
  touch sh1/mp/1

	  ./test_o_mnt /test-mounts/sh1/mp

  mount -t tmpfs tmpfs_mp sh1/mp
  touch sh1/mp/2

	  input

  mount --bind sh1 sh2
  mount -t tmpfs tmpfs_prop sh2/mp
  touch sh2/mp/3

	  input

And now through fds we have an access to all three files:

  ls /proc/3799/fd/*
  /proc/3799/fd/0  /proc/3799/fd/1  /proc/3799/fd/2

  /proc/3799/fd/3:
  1

  /proc/3799/fd/4:
  2

  /proc/3799/fd/5:
  1

  /proc/3799/fd/6:
  3

  /proc/3799/fd/7:
  1

Code of test_o_mnt.c:

  #include <stdio.h>
  #include <sys/types.h>
  #include <sys/stat.h>
  #include <fcntl.h>

  #define O_MNT 040000000

  int main(int argc, char **argv)
  {
  	int dfd, fd, fd2;

  	if (argc != 2) {
  		printf("usage: %s <path/under/mountpoint>\n", argv[0]);
  		return 1;
  	}

  	dfd = open(argv[1], O_DIRECTORY);
  	if (dfd < 0) {
  		perror("open");
  		return 1;
  	}

  	scanf("%*s");

  	fd = openat(dfd, ".", O_DIRECTORY | O_MNT);
  	if (fd < 0) {
  		perror("open");
  		return 1;
  	}

  	fd2 = openat(dfd, ".", O_DIRECTORY);
  	if (fd2 < 0) {
  		perror("open");
  		return 1;
  	}

  	scanf("%*s");

  	fd = openat(dfd, ".", O_DIRECTORY | O_MNT);
  	if (fd < 0) {
  		perror("open");
  		return 1;
  	}

  	fd2 = openat(dfd, ".", O_DIRECTORY);
  	if (fd2 < 0) {
  		perror("open");
  		return 1;
  	}

  	while (1) {}

  	return 0;
  }

Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 fs/fcntl.c                       |  2 +-
 fs/namei.c                       | 66 ++++++++++++++++++++++++++++++++
 fs/open.c                        |  2 +
 include/linux/fcntl.h            |  2 +-
 include/linux/namei.h            |  1 +
 include/uapi/asm-generic/fcntl.h |  4 ++
 6 files changed, 75 insertions(+), 2 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 3d40771e8e7c..4cf05a2fd162 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -1031,7 +1031,7 @@ static int __init fcntl_init(void)
 	 * Exceptions: O_NONBLOCK is a two bit define on parisc; O_NDELAY
 	 * is defined as O_NONBLOCK on some platforms and not on others.
 	 */
-	BUILD_BUG_ON(21 - 1 /* for O_RDONLY being 0 */ !=
+	BUILD_BUG_ON(22 - 1 /* for O_RDONLY being 0 */ !=
 		HWEIGHT32(
 			(VALID_OPEN_FLAGS & ~(O_NONBLOCK | O_NDELAY)) |
 			__FMODE_EXEC | __FMODE_NONOTIFY));
diff --git a/fs/namei.c b/fs/namei.c
index 671c3c1a3425..7b4c733fc5ef 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2158,10 +2158,71 @@ static int link_path_walk(const char *name, struct nameidata *nd)
 	}
 }
 
+static int handle_mnt(struct nameidata *nd, unsigned int flags)
+{
+	if (!(flags & LOOKUP_MNT) || !d_mountpoint(nd->path.dentry))
+		return 0;
+
+	if (flags & LOOKUP_RCU) {
+		struct mount *mounted;
+
+		mounted = __lookup_mnt(nd->path.mnt, nd->path.dentry);
+		if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
+			return -ECHILD;
+		if (!mounted)
+			return 0;
+
+		if (d_mountpoint(mounted->mnt.mnt_root)) {
+			struct mount *omounted;
+
+			omounted = __lookup_mnt(&mounted->mnt,
+						mounted->mnt.mnt_root);
+			if (unlikely(read_seqretry(&mount_lock, nd->m_seq)))
+				return -ECHILD;
+			if (omounted && omounted->mnt.mnt_flags & MNT_LOCKED)
+				return -EINVAL;
+		}
+
+		nd->path.mnt = &mounted->mnt;
+		nd->path.dentry = mounted->mnt.mnt_root;
+		nd->inode = nd->path.dentry->d_inode;
+		nd->seq = read_seqcount_begin(&nd->path.dentry->d_seq);
+	} else {
+		struct vfsmount *mounted;
+		struct path path;
+
+		mounted = lookup_mnt(&nd->path);
+		if (!mounted)
+			return 0;
+
+		path.mnt = mounted;
+		path.dentry = dget(mounted->mnt_root);
+
+		if (d_mountpoint(mounted->mnt_root)) {
+			struct vfsmount *omounted;
+
+			omounted = lookup_mnt(&path);
+			if (omounted && omounted->mnt_flags & MNT_LOCKED) {
+				mntput(omounted);
+				path_put(&path);
+				return -EINVAL;
+			}
+		}
+
+		dput(nd->path.dentry);
+		mntput(nd->path.mnt);
+		nd->path = path;
+		nd->inode = nd->path.dentry->d_inode;
+	}
+
+	return 0;
+}
+
 /* must be paired with terminate_walk() */
 static const char *path_init(struct nameidata *nd, unsigned flags)
 {
 	const char *s = nd->name->name;
+	int ret;
 
 	if (!*s)
 		flags &= ~LOOKUP_RCU;
@@ -2238,6 +2299,11 @@ static const char *path_init(struct nameidata *nd, unsigned flags)
 			nd->inode = nd->path.dentry->d_inode;
 		}
 		fdput(f);
+
+		ret = handle_mnt(nd, flags);
+		if (ret)
+			return ERR_PTR(ret);
+
 		return s;
 	}
 }
diff --git a/fs/open.c b/fs/open.c
index b62f5c0923a8..5bebd98c2154 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1022,6 +1022,8 @@ static inline int build_open_flags(int flags, umode_t mode, struct open_flags *o
 		lookup_flags |= LOOKUP_DIRECTORY;
 	if (!(flags & O_NOFOLLOW))
 		lookup_flags |= LOOKUP_FOLLOW;
+	if (flags & O_MNT)
+		lookup_flags |= LOOKUP_MNT;
 	op->lookup_flags = lookup_flags;
 	return 0;
 }
diff --git a/include/linux/fcntl.h b/include/linux/fcntl.h
index d019df946cb2..06bdc2b70554 100644
--- a/include/linux/fcntl.h
+++ b/include/linux/fcntl.h
@@ -9,7 +9,7 @@
 	(O_RDONLY | O_WRONLY | O_RDWR | O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC | \
 	 O_APPEND | O_NDELAY | O_NONBLOCK | O_NDELAY | __O_SYNC | O_DSYNC | \
 	 FASYNC	| O_DIRECT | O_LARGEFILE | O_DIRECTORY | O_NOFOLLOW | \
-	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE)
+	 O_NOATIME | O_CLOEXEC | O_PATH | __O_TMPFILE | O_MNT)
 
 #ifndef force_o_largefile
 #define force_o_largefile() (!IS_ENABLED(CONFIG_ARCH_32BIT_OFF_T))
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 397a08ade6a2..63414f065927 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -22,6 +22,7 @@ enum {LAST_NORM, LAST_ROOT, LAST_DOT, LAST_DOTDOT, LAST_BIND};
 #define LOOKUP_AUTOMOUNT	0x0004  /* force terminal automount */
 #define LOOKUP_EMPTY		0x4000	/* accept empty path [user_... only] */
 #define LOOKUP_DOWN		0x8000	/* follow mounts in the starting point */
+#define LOOKUP_MNT		0x10000 /* switch mountpoint fd to mount root */
 
 #define LOOKUP_REVAL		0x0020	/* tell ->d_revalidate() to trust no cache */
 #define LOOKUP_RCU		0x0040	/* RCU pathwalk mode; semi-internal */
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..dcd5844b955e 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -89,6 +89,10 @@
 #define __O_TMPFILE	020000000
 #endif
 
+#ifndef O_MNT
+#define O_MNT		040000000
+#endif
+
 /* a horrid kludge trying to make sure that this will fail on old kernels */
 #define O_TMPFILE (__O_TMPFILE | O_DIRECTORY)
 #define O_TMPFILE_MASK (__O_TMPFILE | O_DIRECTORY | O_CREAT)      
-- 
2.21.0

