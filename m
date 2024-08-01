Return-Path: <linux-fsdevel+bounces-24731-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79214944210
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 05:53:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C0551C2218E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Aug 2024 03:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C8714374F;
	Thu,  1 Aug 2024 03:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b="MM+m0Hir"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77314372E;
	Thu,  1 Aug 2024 03:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484393; cv=none; b=mF3h39tJ6aN55eAnd41urz13SkSJ/ajP1Rtk1PR/dnULdRS/6/GMASISVc2zckp8C8NBTrMkga6sq6GfFwcC+ZiUf8XTHpval1M+Mc1vOg7qhRqfeVTFEo4Ki9yhOQhf65nBeb0KPJBPK5SRg7FnWtIN8wCX41P9dmyvT1hnfqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484393; c=relaxed/simple;
	bh=iaW9F+1hGplJ+XVY4xEy89+V0guZHjhOi4/zsCtd+ow=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ElRqCg9tVx0xdKhBeVZ/+PEFVYna4brMl9foAivEa6pYB3bxblKdDiirWFvyf/9zbkwbQA7yjc5ocQ5ebaMMgYhn4n4advWfuS+bxQv07fi5xww5SA/YmA0VrakkOHAW2atRs5Ey0Y21Mw6JuKO3KpuocNdDJzwcvMq4++LhbzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com; spf=pass smtp.mailfrom=cyphar.com; dkim=pass (2048-bit key) header.d=cyphar.com header.i=@cyphar.com header.b=MM+m0Hir; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyphar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyphar.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4WZFRk2SCFz9sW1;
	Thu,  1 Aug 2024 05:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyphar.com; s=MBO0001;
	t=1722484386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jED3yi9I8NFf6TIpgjA0Hu/yrPNZC0px3hxjpdzE1No=;
	b=MM+m0HiroBKZ+HQuwz8vCN1DAx1s3hcq4wUs+2Au6JwAhZ6yVdjW2AtWmo1yI2L+pebohN
	HR17/rV2SUQJP0iyFQEoO7XcjhodBQNfh19t2x6hskCMeiLK0GMJcJxlsl961SEYi8/ug7
	ssLwtXrkdxGWoQC/DuIFKwM0qF/aYGpSd9pJ7mmKfAudSPRyNgWuF6H5xfqfsZjOUAL7FQ
	woH1g46uyXCnY1SnTUzkJLdKIwk6QHrh+dYJmt571RiRsMBCxGZSL4vRG2BFV7JH3FVamR
	Kti0FwvpEmRXoaVGgU9dkAJdToXlsOWHTUTUo/2BPOVmrtw+i3nfPpaAO0l0HA==
From: Aleksa Sarai <cyphar@cyphar.com>
Date: Thu, 01 Aug 2024 13:52:40 +1000
Subject: [PATCH RFC v3 1/2] uapi: explain how per-syscall AT_* flags should
 be allocated
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240801-exportfs-u64-mount-id-v3-1-be5d6283144a@cyphar.com>
References: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
In-Reply-To: <20240801-exportfs-u64-mount-id-v3-0-be5d6283144a@cyphar.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Alexander Aring <alex.aring@gmail.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
 linux-perf-users@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=13765; i=cyphar@cyphar.com;
 h=from:subject:message-id; bh=iaW9F+1hGplJ+XVY4xEy89+V0guZHjhOi4/zsCtd+ow=;
 b=owGbwMvMwCWmMf3Xpe0vXfIZT6slMaStZut5M91IwzFsvYWDzx8ZSSYR9eBT4p1OkbL75jE3H
 wxdsi++o5SFQYyLQVZMkWWbn2fopvmLryR/WskGM4eVCWQIAxenAEzk/w+Gf4a99TNUJVYxSIYv
 mRm0srN63p0TSdZ22aL7HDPN48S9BBgZHkxjdvjr/ZKLKen3nhXFHGqnHeTTFlYVKevLt+5vU3z
 ABAA=
X-Developer-Key: i=cyphar@cyphar.com; a=openpgp;
 fpr=C9C370B246B09F6DBCFC744C34401015D1D2D386
X-Rspamd-Queue-Id: 4WZFRk2SCFz9sW1

Unfortunately, the way we have gone about adding new AT_* flags has
been a little messy. In the beginning, all of the AT_* flags had generic
meanings and so it made sense to share the flag bits indiscriminately.
However, we inevitably ran into syscalls that needed their own
syscall-specific flags. Due to the lack of a planned out policy, we
ended up with the following situations:

 * Existing syscalls adding new features tended to use new AT_* bits,
   with some effort taken to try to re-use bits for flags that were so
   obviously syscall specific that they only make sense for a single
   syscall (such as the AT_EACCESS/AT_REMOVEDIR/AT_HANDLE_FID triplet).

   Given the constraints of bitflags, this works well in practice, but
   ideally (to avoid future confusion) we would plan ahead and define a
   set of "per-syscall bits" ahead of time so that when allocating new
   bits we don't end up with a complete mish-mash of which bits are
   supposed to be per-syscall and which aren't.

 * New syscalls dealt with this in several ways:

   - Some syscalls (like renameat2(2), move_mount(2), fsopen(2), and
     fspick(2)) created their separate own flag spaces that have no
     overlap with the AT_* flags. Most of these ended up allocating
     their bits sequentually.

     In the case of move_mount(2) and fspick(2), several flags have
     identical meanings to AT_* flags but were allocated in their own
     flag space.

     This makes sense for syscalls that will never share AT_* flags, but
     for some syscalls this leads to duplication with AT_* flags in a
     way that could cause confusion (if renameat2(2) grew a
     RENAME_EMPTY_PATH it seems likely that users could mistake it for
     AT_EMPTY_PATH since it is an *at(2) syscall).

   - Some syscalls unfortunately ended up both creating their own flag
     space while also using bits from other flag spaces. The most
     obvious example is open_tree(2), where the standard usage ends up
     using flags from *THREE* separate flag spaces:

       open_tree(AT_FDCWD, "/foo", OPEN_TREE_CLONE|O_CLOEXEC|AT_RECURSIVE);

     (Note that O_CLOEXEC is also platform-specific, so several future
     OPEN_TREE_* bits are also made unusable in one fell swoop.)

It's not entirely clear to me what the "right" choice is for new
syscalls. Just saying that all future VFS syscalls should use AT_* flags
doesn't seem practical. openat2(2) has RESOLVE_* flags (many of which
don't make much sense to burn generic AT_* flags for) and move_mount(2)
has separate AT_*-like flags for both the source and target so separate
flags are needed anyway (though it seems possible that renameat2(2)
could grow *_EMPTY_PATH flags at some point, and it's a bit of a shame
they can't be reused).

But at least for syscalls that _do_ choose to use AT_* flags, we should
explicitly state the policy that 0x2ff is currently intended for
per-syscall flags and that new flags should err on the side of
overlapping with existing flag bits (so we can extend the scope of
generic flags in the future if necessary).

And add AT_* aliases for the RENAME_* flags to further cement that
renameat2(2) is an *at(2) flag, just with its own per-syscall flags.

Suggested-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Aleksa Sarai <cyphar@cyphar.com>
---
 include/uapi/linux/fcntl.h                         | 80 ++++++++++++++-------
 tools/perf/trace/beauty/include/uapi/linux/fcntl.h | 83 +++++++++++++++-------
 2 files changed, 115 insertions(+), 48 deletions(-)

diff --git a/include/uapi/linux/fcntl.h b/include/uapi/linux/fcntl.h
index e55a3314bcb0..38a6d66d9e88 100644
--- a/include/uapi/linux/fcntl.h
+++ b/include/uapi/linux/fcntl.h
@@ -90,37 +90,69 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define AT_FDCWD		-100    /* Special value for dirfd used to
+					   indicate openat should use the
+					   current working directory. */
+
+
+/* Generic flags for the *at(2) family of syscalls. */
+
+/* Reserved for per-syscall flags	0xff. */
+#define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
+						   links. */
+/* Reserved for per-syscall flags	0x200 */
+#define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
+#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
+						   traversal. */
+#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
+						   pathname to operate on dirfd
+						   directly. */
 /*
- * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
- * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
- * unlinkat.  The two functions do completely different things and therefore,
- * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
- * faccessat would be undefined behavior and thus treating it equivalent to
- * AT_EACCESS is valid undefined behavior.
+ * These flags are currently statx(2)-specific, but they could be made generic
+ * in the future and so they should not be used for other per-syscall flags.
  */
-#define AT_FDCWD		-100    /* Special value used to indicate
-                                           openat should use the current
-                                           working directory. */
-#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required from statx() */
+#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
+#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync'd with the server */
+#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the server */
+
+#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
+
+/*
+ * Per-syscall flags for the *at(2) family of syscalls.
+ *
+ * These are flags that are so syscall-specific that a user passing these flags
+ * to the wrong syscall is so "clearly wrong" that we can safely call such
+ * usage "undefined behaviour".
+ *
+ * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same value.
+ * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is meaningful
+ * only to unlinkat. The two functions do completely different things and
+ * therefore, the flags can be allowed to overlap. For example, passing
+ * AT_REMOVEDIR to faccessat would be undefined behavior and thus treating it
+ * equivalent to AT_EACCESS is valid undefined behavior.
+ *
+ * Note for implementers: When picking a new per-syscall AT_* flag, try to
+ * reuse already existing flags first. This leaves us with as many unused bits
+ * as possible, so we can use them for generic bits in the future if necessary.
+ */
+
+/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+#define AT_RENAME_NOREPLACE	0x0001
+#define AT_RENAME_EXCHANGE	0x0002
+#define AT_RENAME_WHITEOUT	0x0004
+
+/* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for
                                            effective IDs, not real IDs.  */
+/* Flag for unlinkat(2). */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
-#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
-#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
-#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
-
-#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required from statx() */
-#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
-#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
-#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
-
-#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+/* Flags for name_to_handle_at(2). */
+#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
+					   object identity and may not be
+					   usable with open_by_handle_at(2). */
 
-/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
-#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
-					compare object identity and may not
-					be usable to open_by_handle_at(2) */
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
 #endif
diff --git a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
index c0bcc185fa48..38a6d66d9e88 100644
--- a/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
+++ b/tools/perf/trace/beauty/include/uapi/linux/fcntl.h
@@ -16,6 +16,9 @@
 
 #define F_DUPFD_QUERY	(F_LINUX_SPECIFIC_BASE + 3)
 
+/* Was the file just created? */
+#define F_CREATED_QUERY	(F_LINUX_SPECIFIC_BASE + 4)
+
 /*
  * Cancel a blocking posix lock; internal use only until we expose an
  * asynchronous lock api to userspace:
@@ -87,37 +90,69 @@
 #define DN_ATTRIB	0x00000020	/* File changed attibutes */
 #define DN_MULTISHOT	0x80000000	/* Don't remove notifier */
 
+#define AT_FDCWD		-100    /* Special value for dirfd used to
+					   indicate openat should use the
+					   current working directory. */
+
+
+/* Generic flags for the *at(2) family of syscalls. */
+
+/* Reserved for per-syscall flags	0xff. */
+#define AT_SYMLINK_NOFOLLOW		0x100   /* Do not follow symbolic
+						   links. */
+/* Reserved for per-syscall flags	0x200 */
+#define AT_SYMLINK_FOLLOW		0x400   /* Follow symbolic links. */
+#define AT_NO_AUTOMOUNT			0x800	/* Suppress terminal automount
+						   traversal. */
+#define AT_EMPTY_PATH			0x1000	/* Allow empty relative
+						   pathname to operate on dirfd
+						   directly. */
+/*
+ * These flags are currently statx(2)-specific, but they could be made generic
+ * in the future and so they should not be used for other per-syscall flags.
+ */
+#define AT_STATX_SYNC_TYPE		0x6000	/* Type of synchronisation required from statx() */
+#define AT_STATX_SYNC_AS_STAT		0x0000	/* - Do whatever stat() does */
+#define AT_STATX_FORCE_SYNC		0x2000	/* - Force the attributes to be sync'd with the server */
+#define AT_STATX_DONT_SYNC		0x4000	/* - Don't sync attributes with the server */
+
+#define AT_RECURSIVE			0x8000	/* Apply to the entire subtree */
+
 /*
- * The constants AT_REMOVEDIR and AT_EACCESS have the same value.  AT_EACCESS is
- * meaningful only to faccessat, while AT_REMOVEDIR is meaningful only to
- * unlinkat.  The two functions do completely different things and therefore,
- * the flags can be allowed to overlap.  For example, passing AT_REMOVEDIR to
- * faccessat would be undefined behavior and thus treating it equivalent to
- * AT_EACCESS is valid undefined behavior.
+ * Per-syscall flags for the *at(2) family of syscalls.
+ *
+ * These are flags that are so syscall-specific that a user passing these flags
+ * to the wrong syscall is so "clearly wrong" that we can safely call such
+ * usage "undefined behaviour".
+ *
+ * For example, the constants AT_REMOVEDIR and AT_EACCESS have the same value.
+ * AT_EACCESS is meaningful only to faccessat, while AT_REMOVEDIR is meaningful
+ * only to unlinkat. The two functions do completely different things and
+ * therefore, the flags can be allowed to overlap. For example, passing
+ * AT_REMOVEDIR to faccessat would be undefined behavior and thus treating it
+ * equivalent to AT_EACCESS is valid undefined behavior.
+ *
+ * Note for implementers: When picking a new per-syscall AT_* flag, try to
+ * reuse already existing flags first. This leaves us with as many unused bits
+ * as possible, so we can use them for generic bits in the future if necessary.
  */
-#define AT_FDCWD		-100    /* Special value used to indicate
-                                           openat should use the current
-                                           working directory. */
-#define AT_SYMLINK_NOFOLLOW	0x100   /* Do not follow symbolic links.  */
+
+/* Flags for renameat2(2) (must match legacy RENAME_* flags). */
+#define AT_RENAME_NOREPLACE	0x0001
+#define AT_RENAME_EXCHANGE	0x0002
+#define AT_RENAME_WHITEOUT	0x0004
+
+/* Flag for faccessat(2). */
 #define AT_EACCESS		0x200	/* Test access permitted for
                                            effective IDs, not real IDs.  */
+/* Flag for unlinkat(2). */
 #define AT_REMOVEDIR		0x200   /* Remove directory instead of
                                            unlinking file.  */
-#define AT_SYMLINK_FOLLOW	0x400   /* Follow symbolic links.  */
-#define AT_NO_AUTOMOUNT		0x800	/* Suppress terminal automount traversal */
-#define AT_EMPTY_PATH		0x1000	/* Allow empty relative pathname */
-
-#define AT_STATX_SYNC_TYPE	0x6000	/* Type of synchronisation required from statx() */
-#define AT_STATX_SYNC_AS_STAT	0x0000	/* - Do whatever stat() does */
-#define AT_STATX_FORCE_SYNC	0x2000	/* - Force the attributes to be sync'd with the server */
-#define AT_STATX_DONT_SYNC	0x4000	/* - Don't sync attributes with the server */
-
-#define AT_RECURSIVE		0x8000	/* Apply to the entire subtree */
+/* Flags for name_to_handle_at(2). */
+#define AT_HANDLE_FID		0x200	/* File handle is needed to compare
+					   object identity and may not be
+					   usable with open_by_handle_at(2). */
 
-/* Flags for name_to_handle_at(2). We reuse AT_ flag space to save bits... */
-#define AT_HANDLE_FID		AT_REMOVEDIR	/* file handle is needed to
-					compare object identity and may not
-					be usable to open_by_handle_at(2) */
 #if defined(__KERNEL__)
 #define AT_GETATTR_NOSEC	0x80000000
 #endif

-- 
2.45.2


