Return-Path: <linux-fsdevel+bounces-51975-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726E6ADDD2C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 22:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDF917B6F5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 20:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4282E3AFF;
	Tue, 17 Jun 2025 20:26:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DF12EFDB5;
	Tue, 17 Jun 2025 20:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191990; cv=none; b=TQ8OKf/z/1jtb8auWLwo7fav/hX9fUFSs+e59/5TyCbF87rVLcNpqjbBZ14dvvYm/JApkpZ7xlsQ6M9JPoQnVanHn+PDavZ7MXGdC408tPl8VTH2aZJinOvyDn74zE3ZamgTZAH88fABtyd4VmLXw2kgC7rwl2Radvwj1xu5KkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191990; c=relaxed/simple;
	bh=cqTl9Etvsf352tMZUXRY8foMIfzXbvY0PzDroxDp5co=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=hp9bTY5URufTG0Sa9sbGy6RfLydYxvq5e0MjewNKFrjdcmyIe/+ZjraFeTZsm+CR4fz1ixCk4dyReM92v1c6clTDlE84sXJiN0S1O0qhoDuBbUCP4VwlKREH2nyX6zMfqc0dZ/QOZSXUxinjbZCaqWZN1qba6rG/iJAotyzNzm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id AA5181D6A5B;
	Tue, 17 Jun 2025 20:26:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 3319F60010;
	Tue, 17 Jun 2025 20:26:20 +0000 (UTC)
Date: Tue, 17 Jun 2025 16:26:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, "linux-trace-users@vger.kernel.org"
 <linux-trace-users@vger.kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-perf-users@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Namhyung Kim <namhyung@kernel.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Al Viro
 <viro@ZenIV.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, Arnaldo Carvalho de Melo <acme@kernel.org>, Frederic
 Weisbecker <fweisbec@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Ian Rogers
 <irogers@google.com>
Subject: [RFC][PATCH v2] tracing: Deprecate auto-mounting tracefs in debugfs
Message-ID: <20250617162625.1d44862b@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3319F60010
X-Stat-Signature: b7rn7txh4sm3734rzip95rghbr8gxj3g
X-Rspamd-Server: rspamout05
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19VqbkcwJiB/aMINIF944FtS/w2WfpSG/8=
X-HE-Tag: 1750191980-497717
X-HE-Meta: U2FsdGVkX192M0RQ/UyFwqpdmFwlfSoe3kdAM/l1EYJsXgfMrcRu/YaY7RqGN8+ydHnrzXxfoL46pQg833zXkT8htVH3KMfXmeMYFaGZr2Zrvbk1FN7n09yDpjB+TK5UoRYjCc+B+BsLDA8uiPTe1+rc9iVnS28dqcXVxWwzJpAkyOH47uEieCQgUgs+laz6zG/8I7eLHZpNPFbQNlfCjmJq2DXDE84l9OsnZ6+Qv9EFBPE1y/mmlxFP2B1fnlSwepCmJVtetULl59sT3WPebrRwPqRbr8AteVWYrqdeQhisZ0ftQWgXYGlaFP6U978rxKC7eg1yhPl3RK1RvFUE25jUNWIW1wXXqxoP9hhDDM+Wl2P2KIio66m1j0mORIjfyzRBF1rkiXFmy35+AU7JNA==


In January 2015, tracefs was created to allow access to the tracing
infrastructure without needing to compile in debugfs. When tracefs is
configured, the directory /sys/kernel/tracing will exist and tooling is
expected to use that path to access the tracing infrastructure.

To allow backward compatibility, when debugfs is mounted, it would
automount tracefs in its "tracing" directory so that tooling that had hard
coded /sys/kernel/debug/tracing would still work.

It has been over 10 years since the new interface was introduced, and all
tooling should now be using it. Start the process of deprecating the old
path so that it doesn't need to be maintained anymore.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/linux-trace-kernel/20250617133614.24e2ba7f@gandalf.local.home/

- Fixed pr_warn() print, and move it to when debugfs accesses the tracing dir
  and not when tracefs automount is registered


 .../ABI/obsolete/automount-tracefs-debugfs    | 20 +++++++++++++++++++
 kernel/trace/Kconfig                          | 13 ++++++++++++
 kernel/trace/trace.c                          | 14 +++++++++----
 3 files changed, 43 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/ABI/obsolete/automount-tracefs-debugfs

diff --git a/Documentation/ABI/obsolete/automount-tracefs-debugfs b/Documentation/ABI/obsolete/automount-tracefs-debugfs
new file mode 100644
index 000000000000..8d03cf9e579f
--- /dev/null
+++ b/Documentation/ABI/obsolete/automount-tracefs-debugfs
@@ -0,0 +1,20 @@
+What:		/sys/kernel/debug/tracing
+Date:		May 2008
+KernelVersion:	2.6.27
+Contact:	linux-trace-kernel@vger.kernel.org
+Description:
+
+	The ftrace was first added to the kernel, its interface was placed
+	into the debugfs file system under the "tracing" directory. Access
+	to the files were in /sys/kernel/debug/tracing. As systems wanted
+	access to the tracing interface without having to enable debugfs, a
+	new interface was created called "tracefs". This was a stand alone
+	file system and was usually mounted in /sys/kernel/tracing.
+
+	To allow older tooling to continue to operate, when mounting
+	debugfs, the tracefs file system would automatically get mounted in
+	the "tracing" directory of debugfs. The tracefs interface was added
+	in January 2015 in the v4.1 kernel.
+
+	All tooling should now be using tracefs directly and the "tracing"
+	directory in debugfs should be removed by January 2027.
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a3f35c7d83b6..93e8e7fc11c0 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -199,6 +199,19 @@ menuconfig FTRACE
 
 if FTRACE
 
+config TRACEFS_AUTOMOUNT_DEPRECATED
+	bool "Automount tracefs on debugfs [DEPRECATED]"
+	depends on TRACING
+	default y
+	help
+	  The tracing interface was moved from /sys/kernel/debug/tracing
+	  to /sys/kernel/tracing in 2015, but the tracing file system
+	  was still automounted in /sys/kernel/debug for backward
+	  compatibility with tooling.
+
+	  The new interface has been around for more than 10 years and
+	  the old debug mount will soon be removed.
+
 config BOOTTIME_TRACING
 	bool "Boot-time Tracing support"
 	depends on TRACING
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 95ae7c4e5835..2dafe2748b16 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6303,7 +6303,7 @@ static bool tracer_options_updated;
 static void add_tracer_options(struct trace_array *tr, struct tracer *t)
 {
 	/* Only enable if the directory has been created already. */
-	if (!tr->dir)
+	if (!tr->dir && !(tr->flags & TRACE_ARRAY_FL_GLOBAL))
 		return;
 
 	/* Only create trace option files after update_tracer_options finish */
@@ -8984,13 +8984,13 @@ static inline __init int register_snapshot_cmd(void) { return 0; }
 
 static struct dentry *tracing_get_dentry(struct trace_array *tr)
 {
-	if (WARN_ON(!tr->dir))
-		return ERR_PTR(-ENODEV);
-
 	/* Top directory uses NULL as the parent */
 	if (tr->flags & TRACE_ARRAY_FL_GLOBAL)
 		return NULL;
 
+	if (WARN_ON(!tr->dir))
+		return ERR_PTR(-ENODEV);
+
 	/* All sub buffers have a descriptor */
 	return tr->dir;
 }
@@ -10256,6 +10256,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	ftrace_init_tracefs(tr, d_tracer);
 }
 
+#ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
 static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 {
 	struct vfsmount *mnt;
@@ -10277,6 +10278,8 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	if (IS_ERR(fc))
 		return ERR_CAST(fc);
 
+	pr_warn("NOTICE: Automounting of tracing to debugfs is deprecated and will be removed in 2027\n");
+
 	ret = vfs_parse_fs_string(fc, "source",
 				  "tracefs", strlen("tracefs"));
 	if (!ret)
@@ -10287,6 +10290,7 @@ static struct vfsmount *trace_automount(struct dentry *mntpt, void *ingore)
 	put_fs_context(fc);
 	return mnt;
 }
+#endif
 
 /**
  * tracing_init_dentry - initialize top level trace array
@@ -10311,6 +10315,7 @@ int tracing_init_dentry(void)
 	if (WARN_ON(!tracefs_initialized()))
 		return -ENODEV;
 
+#ifdef CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED
 	/*
 	 * As there may still be users that expect the tracing
 	 * files to exist in debugfs/tracing, we must automount
@@ -10319,6 +10324,7 @@ int tracing_init_dentry(void)
 	 */
 	tr->dir = debugfs_create_automount("tracing", NULL,
 					   trace_automount, NULL);
+#endif
 
 	return 0;
 }
-- 
2.47.2


