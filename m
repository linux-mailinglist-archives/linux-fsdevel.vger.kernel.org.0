Return-Path: <linux-fsdevel+bounces-72420-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12186CF6FD2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 06 Jan 2026 08:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 616FF30208DF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jan 2026 07:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBBDF30AAAE;
	Tue,  6 Jan 2026 07:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kL5V8WRz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C10309EF9;
	Tue,  6 Jan 2026 07:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767683485; cv=none; b=fQEflnP2D1H9MB27Dt2BjpcEEVmS2wb+beLQlQXLr5IDeyZVCIwqJQAzwMnYur+zeqlHJMO8McYVgCsoNt8xzItUhCNtLD3Bp1IPiXNBfPnvUtBdJKLe+OqPAn/jAAzkOqd49Xb7Zgh1bDbQRtzlFHr51Rbv/5A+iWjY4TrGDbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767683485; c=relaxed/simple;
	bh=M1NKj8YkxcKAu5jpaSX36dDV6oGXVFMMtxs30VxIXic=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JAvDYTbMs+G+JPKRKfEQ1OjgVWo8QIh+UkN/DC20HmccmwMcCNv5v0SwJgRJChyjAP9/sbyCbkJu7K/tYgU4jZKyhVw63ydv+7AYy2nGGXXL7CGe43iTU5M/BFyGkagfvlZziv9tKXJTPNHxnrCwMY5AIklTQqvVwNIADUhvufY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kL5V8WRz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0A2C116C6;
	Tue,  6 Jan 2026 07:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767683484;
	bh=M1NKj8YkxcKAu5jpaSX36dDV6oGXVFMMtxs30VxIXic=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=kL5V8WRzLtMIIX4BjWN/va2Ig0ksTfSv3dJiIJ9t1KTu8EbzdZVMH6/NDwlI7kAIm
	 EJQKBW2Nj8vT5C+QDWeSLqjA1dyABT3L1ZekIHhVCnjyKmAQytLLEaKjb3hFIWsJEq
	 Ssrzh9aCe/6bdvUnN0mpgsFS6sNWLkHSCXJ1/aumeEQLTk5AM+0cmUNgwUoZ3h0RP9
	 W1kTWA/tuhvcI1gZvsqp/tBu7jhiSQC4feAlqoBPqeVHU9lT9CfOv8mUi1SyqgCZST
	 L6SxiOsC+sNkP1CR0cjeDPZ56QlTYJfoU9I+JZbiTxbBcJ3BZE2mIYsCgmpo/alDJ7
	 HUpnh2goJ2ZKg==
Date: Mon, 05 Jan 2026 23:11:24 -0800
Subject: [PATCH 03/11] xfs: create event queuing, formatting,
 and discovery infrastructure
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: linux-xfs@vger.kernel.org, hch@lst.de, linux-fsdevel@vger.kernel.org
Message-ID: <176766637311.774337.2635132516714726157.stgit@frogsfrogsfrogs>
In-Reply-To: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
References: <176766637179.774337.3663793412524347917.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create the basic infrastructure that we need to report health events to
userspace.  We need a compact form for recording critical information
about an event and queueing them; a means to notice that we've lost some
events; and a means to format the events into something that userspace
can handle.  Make the kernel export C structures via read().

In a previous iteration of this new subsystem, I wanted to explore data
exchange formats that are more flexible and easier for humans to read
than C structures.  The thought being that when we want to rev (or
worse, enlarge) the event format, it ought to be trivially easy to do
that in a way that doesn't break old userspace.

I looked at formats such as protobufs and capnproto.  These look really
nice in that extending the wire format is fairly easy, you can give it a
data schema and it generates the serialization code for you, handles
endianness problems, etc.  The huge downside is that neither support C
all that well.

Too hard, and didn't want to port either of those huge sprawling
libraries first to the kernel and then again to xfsprogs.  Then I
thought, how about JSON?  Javascript objects are human readable, the
kernel can emit json without much fuss (it's all just strings!) and
there are plenty of interpreters for python/rust/c/etc.

There's a proposed schema format for json, which means that xfs can
publish a description of the events that kernel will emit.  Userspace
consumers (e.g. xfsprogs/xfs_healer) can embed the same schema document
and use it to validate the incoming events from the kernel, which means
it can discard events that it doesn't understand, or garbage being
emitted due to bugs.

However, json has a huge crutch -- javascript is well known for its
vague definitions of what are numbers.  This makes expressing a large
number rather fraught, because the runtime is free to represent a number
in nearly any way it wants.  Stupider ones will truncate values to word
size, others will roll out doubles for uint52_t (yes, fifty-two) with
the resulting loss of precision.  Not good when you're dealing with
discrete units.

It just so happens that python's json library is smart enough to see a
sequence of digits and put them in a u64 (at least on x86_64/aarch64)
but an actual javascript interpreter (pasting into Firefox) isn't
necessarily so clever.

It turns out that none of the proposed json schemas were ever ratified
even in an open-consensus way, so json blobs are still just loosely
structured blobs.  The parsing in userspace was also noticeably slow and
memory-consumptive.

Hence only the C interface survives.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fs/xfs/libxfs/xfs_fs.h |   47 ++++
 fs/xfs/xfs_healthmon.h |   63 ++++++
 fs/xfs/xfs_trace.h     |  171 ++++++++++++++++
 fs/xfs/xfs_healthmon.c |  512 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/xfs/xfs_trace.c     |    2 
 5 files changed, 789 insertions(+), 6 deletions(-)


diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index dba7896f716092..dfca42b2c31192 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -1003,6 +1003,45 @@ struct xfs_rtgroup_geometry {
 #define XFS_RTGROUP_GEOM_SICK_RMAPBT	(1U << 3)  /* reverse mappings */
 #define XFS_RTGROUP_GEOM_SICK_REFCNTBT	(1U << 4)  /* reference counts */
 
+/* Health monitor event domains */
+
+/* affects the whole fs */
+#define XFS_HEALTH_MONITOR_DOMAIN_MOUNT		(0)
+
+/* Health monitor event types */
+
+/* status of the monitor itself */
+#define XFS_HEALTH_MONITOR_TYPE_RUNNING		(0)
+#define XFS_HEALTH_MONITOR_TYPE_LOST		(1)
+
+/* lost events */
+struct xfs_health_monitor_lost {
+	__u64	count;
+};
+
+struct xfs_health_monitor_event {
+	/* XFS_HEALTH_MONITOR_DOMAIN_* */
+	__u32	domain;
+
+	/* XFS_HEALTH_MONITOR_TYPE_* */
+	__u32	type;
+
+	/* Timestamp of the event, in nanoseconds since the Unix epoch */
+	__u64	time_ns;
+
+	/*
+	 * Details of the event.  The primary clients are written in python
+	 * and rust, so break this up because bindgen hates anonymous structs
+	 * and unions.
+	 */
+	union {
+		struct xfs_health_monitor_lost lost;
+	} e;
+
+	/* zeroes */
+	__u64	pad[2];
+};
+
 struct xfs_health_monitor {
 	__u64	flags;		/* flags */
 	__u8	format;		/* output format */
@@ -1010,6 +1049,14 @@ struct xfs_health_monitor {
 	__u64	pad2[2];	/* zeroes */
 };
 
+/* Return all health status events, not just deltas */
+#define XFS_HEALTH_MONITOR_VERBOSE	(1ULL << 0)
+
+#define XFS_HEALTH_MONITOR_ALL		(XFS_HEALTH_MONITOR_VERBOSE)
+
+/* Initial return format version */
+#define XFS_HEALTH_MONITOR_FMT_V0	(0)
+
 /*
  * ioctl commands that are used by Linux filesystems
  */
diff --git a/fs/xfs/xfs_healthmon.h b/fs/xfs/xfs_healthmon.h
index 218d5aac87b012..600f8a3e52196d 100644
--- a/fs/xfs/xfs_healthmon.h
+++ b/fs/xfs/xfs_healthmon.h
@@ -26,10 +26,73 @@ struct xfs_healthmon {
 	 * and running event handlers hold their own refs.
 	 */
 	refcount_t			ref;
+
+	/* lock for event list and event counters */
+	struct mutex			lock;
+
+	/* list of event objects */
+	struct xfs_healthmon_event	*first_event;
+	struct xfs_healthmon_event	*last_event;
+
+	/* number of events in the list */
+	unsigned int			events;
+
+	/* do we want all events? */
+	bool				verbose:1;
+
+	/* waiter so read/poll can sleep until the arrival of events */
+	struct wait_queue_head		wait;
+
+	/*
+	 * Buffer for formatting events for a read_iter call.  Events are
+	 * formatted into the buffer at bufhead, and buftail determines where
+	 * to start a copy_iter to get those events to userspace.  All buffer
+	 * fields are protected by inode_lock.
+	 */
+	char				*buffer;
+	size_t				bufsize;
+	size_t				bufhead;
+	size_t				buftail;
+
+	/* did we lose previous events? */
+	unsigned long long		lost_prev_event;
+
+	/* total counts of events observed and lost events */
+	unsigned long long		total_events;
+	unsigned long long		total_lost;
 };
 
 void xfs_healthmon_unmount(struct xfs_mount *mp);
 
+enum xfs_healthmon_type {
+	XFS_HEALTHMON_RUNNING,	/* monitor running */
+	XFS_HEALTHMON_LOST,	/* message lost */
+};
+
+enum xfs_healthmon_domain {
+	XFS_HEALTHMON_MOUNT,	/* affects the whole fs */
+};
+
+struct xfs_healthmon_event {
+	struct xfs_healthmon_event	*next;
+
+	enum xfs_healthmon_type		type;
+	enum xfs_healthmon_domain	domain;
+
+	uint64_t			time_ns;
+
+	union {
+		/* lost events */
+		struct {
+			uint64_t	lostcount;
+		};
+		/* mount */
+		struct {
+			unsigned int	flags;
+		};
+	};
+};
+
 long xfs_ioc_health_monitor(struct file *file,
 		struct xfs_health_monitor __user *arg);
 
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index f70afbf3cb196b..04727470b3b410 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -103,6 +103,8 @@ struct xfs_refcount_intent;
 struct xfs_metadir_update;
 struct xfs_rtgroup;
 struct xfs_open_zone;
+struct xfs_healthmon_event;
+struct xfs_healthmon;
 
 #define XFS_ATTR_FILTER_FLAGS \
 	{ XFS_ATTR_ROOT,	"ROOT" }, \
@@ -5906,6 +5908,175 @@ DEFINE_EVENT(xfs_freeblocks_resv_class, name, \
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_reserved);
 DEFINE_FREEBLOCKS_RESV_EVENT(xfs_freecounter_enospc);
 
+TRACE_EVENT(xfs_healthmon_lost_event,
+	TP_PROTO(const struct xfs_healthmon *hm),
+	TP_ARGS(hm),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->lost_prev = hm->lost_prev_event;
+	),
+	TP_printk("dev %d:%d lost_prev %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->lost_prev)
+);
+
+#define XFS_HEALTHMON_FLAGS_STRINGS \
+	{ XFS_HEALTH_MONITOR_VERBOSE,	"verbose" }
+#define XFS_HEALTHMON_FMT_STRINGS \
+	{ XFS_HEALTH_MONITOR_FMT_V0,	"v0" }
+
+TRACE_EVENT(xfs_healthmon_create,
+	TP_PROTO(dev_t dev, u64 flags, u8 format),
+	TP_ARGS(dev, flags, format),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(u64, flags)
+		__field(u8, format)
+	),
+	TP_fast_assign(
+		__entry->dev = dev;
+		__entry->flags = flags;
+		__entry->format = format;
+	),
+	TP_printk("dev %d:%d flags %s format %s",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_flags(__entry->flags, "|", XFS_HEALTHMON_FLAGS_STRINGS),
+		  __print_symbolic(__entry->format, XFS_HEALTHMON_FMT_STRINGS))
+);
+
+TRACE_EVENT(xfs_healthmon_copybuf,
+	TP_PROTO(const struct xfs_healthmon *hm, const struct iov_iter *iov),
+	TP_ARGS(hm, iov),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(size_t, bufsize)
+		__field(size_t, inpos)
+		__field(size_t, outpos)
+		__field(size_t, to_copy)
+		__field(size_t, iter_count)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->bufsize = hm->bufsize;
+		__entry->inpos = hm->bufhead;
+		__entry->outpos = hm->buftail;
+		if (hm->bufhead > hm->buftail)
+			__entry->to_copy = hm->bufhead - hm->buftail;
+		else
+			__entry->to_copy = 0;
+		__entry->iter_count = iov_iter_count(iov);
+	),
+	TP_printk("dev %d:%d bufsize %zu in_pos %zu out_pos %zu to_copy %zu iter_count %zu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->bufsize,
+		  __entry->inpos,
+		  __entry->outpos,
+		  __entry->to_copy,
+		  __entry->iter_count)
+);
+
+DECLARE_EVENT_CLASS(xfs_healthmon_class,
+	TP_PROTO(const struct xfs_healthmon *hm),
+	TP_ARGS(hm),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, events)
+		__field(unsigned long long, lost_prev)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->events = hm->events;
+		__entry->lost_prev = hm->lost_prev_event;
+	),
+	TP_printk("dev %d:%d events %u lost_prev? %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->events,
+		  __entry->lost_prev)
+);
+#define DEFINE_HEALTHMON_EVENT(name) \
+DEFINE_EVENT(xfs_healthmon_class, name, \
+	TP_PROTO(const struct xfs_healthmon *hm), \
+	TP_ARGS(hm))
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_start);
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_read_finish);
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_release);
+DEFINE_HEALTHMON_EVENT(xfs_healthmon_detach);
+
+#define XFS_HEALTHMON_TYPE_STRINGS \
+	{ XFS_HEALTHMON_LOST,		"lost" }
+
+#define XFS_HEALTHMON_DOMAIN_STRINGS \
+	{ XFS_HEALTHMON_MOUNT,		"mount" }
+
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_LOST);
+TRACE_DEFINE_ENUM(XFS_HEALTHMON_MOUNT);
+
+DECLARE_EVENT_CLASS(xfs_healthmon_event_class,
+	TP_PROTO(const struct xfs_healthmon *hm,
+		 const struct xfs_healthmon_event *event),
+	TP_ARGS(hm, event),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(unsigned int, type)
+		__field(unsigned int, domain)
+		__field(unsigned int, mask)
+		__field(unsigned long long, ino)
+		__field(unsigned int, gen)
+		__field(unsigned int, group)
+		__field(unsigned long long, offset)
+		__field(unsigned long long, length)
+		__field(unsigned long long, lostcount)
+	),
+	TP_fast_assign(
+		__entry->dev = hm->dev;
+		__entry->type = event->type;
+		__entry->domain = event->domain;
+		__entry->mask = 0;
+		__entry->group = 0;
+		__entry->ino = 0;
+		__entry->gen = 0;
+		__entry->offset = 0;
+		__entry->length = 0;
+		__entry->lostcount = 0;
+		switch (__entry->domain) {
+		case XFS_HEALTHMON_MOUNT:
+			switch (__entry->type) {
+			case XFS_HEALTHMON_LOST:
+				__entry->lostcount = event->lostcount;
+				break;
+			}
+			break;
+		}
+	),
+	TP_printk("dev %d:%d type %s domain %s mask 0x%x ino 0x%llx gen 0x%x offset 0x%llx len 0x%llx group 0x%x lost %llu",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __print_symbolic(__entry->type, XFS_HEALTHMON_TYPE_STRINGS),
+		  __print_symbolic(__entry->domain, XFS_HEALTHMON_DOMAIN_STRINGS),
+		  __entry->mask,
+		  __entry->ino,
+		  __entry->gen,
+		  __entry->offset,
+		  __entry->length,
+		  __entry->group,
+		  __entry->lostcount)
+);
+#define DEFINE_HEALTHMONEVENT_EVENT(name) \
+DEFINE_EVENT(xfs_healthmon_event_class, name, \
+	TP_PROTO(const struct xfs_healthmon *hm, \
+		 const struct xfs_healthmon_event *event), \
+	TP_ARGS(hm, event))
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_insert);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_push);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_pop);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_format_overflow);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_drop);
+DEFINE_HEALTHMONEVENT_EVENT(xfs_healthmon_merge);
+
 #endif /* _TRACE_XFS_H */
 
 #undef TRACE_INCLUDE_PATH
diff --git a/fs/xfs/xfs_healthmon.c b/fs/xfs/xfs_healthmon.c
index 3fdac72b478f3f..799e0687ae3263 100644
--- a/fs/xfs/xfs_healthmon.c
+++ b/fs/xfs/xfs_healthmon.c
@@ -45,6 +45,13 @@
 /* sign of a detached health monitor */
 #define DETACHED_MOUNT_COOKIE		((uintptr_t)0)
 
+/* Constrain the number of event objects that can build up in memory. */
+#define XFS_HEALTHMON_MAX_EVENTS \
+		(SZ_32K / sizeof(struct xfs_healthmon_event))
+
+/* Constrain the size of the output buffer for read_iter. */
+#define XFS_HEALTHMON_MAX_OUTBUF	SZ_64K
+
 /* spinlock for atomically updating xfs_mount <-> xfs_healthmon pointers */
 static DEFINE_SPINLOCK(xfs_healthmon_lock);
 
@@ -64,6 +71,23 @@ xfs_healthmon_get(
 	return hm;
 }
 
+/* Free all events */
+STATIC void
+xfs_healthmon_free_events(
+	struct xfs_healthmon		*hm)
+{
+	struct xfs_healthmon_event	*event, *next;
+
+	event = hm->first_event;
+	while (event != NULL) {
+		trace_xfs_healthmon_drop(hm, event);
+		next = event->next;
+		kfree(event);
+		event = next;
+	}
+	hm->first_event = hm->last_event = NULL;
+}
+
 /*
  * Free the health monitor after an RCU grace period to eliminate possibility
  * of races with xfs_healthmon_get.
@@ -72,6 +96,9 @@ static inline void
 xfs_healthmon_free(
 	struct xfs_healthmon		*hm)
 {
+	xfs_healthmon_free_events(hm);
+	kfree(hm->buffer);
+	mutex_destroy(&hm->lock);
 	kfree_rcu_mightsleep(hm);
 }
 
@@ -142,8 +169,190 @@ xfs_healthmon_detach(
 	}
 	spin_unlock(&xfs_healthmon_lock);
 
-	if (hm)
+	if (hm) {
+		trace_xfs_healthmon_detach(hm);
 		xfs_healthmon_put(hm);
+	}
+}
+
+static inline void xfs_healthmon_bump_events(struct xfs_healthmon *hm)
+{
+	hm->events++;
+	hm->total_events++;
+}
+
+static inline void xfs_healthmon_bump_lost(struct xfs_healthmon *hm)
+{
+	hm->lost_prev_event++;
+	hm->total_lost++;
+}
+
+/*
+ * If possible, merge a new event into an existing event.  Returns whether or
+ * not it merged anything.
+ */
+static bool
+xfs_healthmon_merge_events(
+	struct xfs_healthmon_event		*existing,
+	const struct xfs_healthmon_event	*new)
+{
+	if (!existing)
+		return false;
+
+	/* type and domain must match to merge events */
+	if (existing->type != new->type ||
+	    existing->domain != new->domain)
+		return false;
+
+	switch (existing->type) {
+	case XFS_HEALTHMON_RUNNING:
+		/* should only ever be one of these events anyway */
+		return false;
+
+	case XFS_HEALTHMON_LOST:
+		existing->lostcount += new->lostcount;
+		return true;
+	}
+
+	return false;
+}
+
+/* Insert an event onto the start of the queue. */
+static inline void
+__xfs_healthmon_insert(
+	struct xfs_healthmon		*hm,
+	struct xfs_healthmon_event	*event)
+{
+	struct timespec64		now;
+
+	ktime_get_coarse_real_ts64(&now);
+	event->time_ns = (now.tv_sec * NSEC_PER_SEC) + now.tv_nsec;
+
+	event->next = hm->first_event;
+	if (!hm->first_event)
+		hm->first_event = event;
+	if (!hm->last_event)
+		hm->last_event = event;
+	xfs_healthmon_bump_events(hm);
+	wake_up(&hm->wait);
+
+	trace_xfs_healthmon_insert(hm, event);
+}
+
+/* Push an event onto the end of the queue. */
+static inline void
+__xfs_healthmon_push(
+	struct xfs_healthmon		*hm,
+	struct xfs_healthmon_event	*event)
+{
+	struct timespec64		now;
+
+	ktime_get_coarse_real_ts64(&now);
+	event->time_ns = (now.tv_sec * NSEC_PER_SEC) + now.tv_nsec;
+
+	if (!hm->first_event)
+		hm->first_event = event;
+	if (hm->last_event)
+		hm->last_event->next = event;
+	hm->last_event = event;
+	event->next = NULL;
+	xfs_healthmon_bump_events(hm);
+	wake_up(&hm->wait);
+
+	trace_xfs_healthmon_push(hm, event);
+}
+
+/* Make a stack event dynamic so we can put it on the list. */
+static inline struct xfs_healthmon_event *
+xfs_healthmon_event_dup(
+	const struct xfs_healthmon_event	*event)
+{
+	return kmemdup(event, sizeof(struct xfs_healthmon_event), GFP_NOFS);
+}
+
+/* Deal with any previously lost events */
+static int
+xfs_healthmon_clear_lost_prev(
+	struct xfs_healthmon		*hm)
+{
+	struct xfs_healthmon_event	lost_event = {
+		.type			= XFS_HEALTHMON_LOST,
+		.domain			= XFS_HEALTHMON_MOUNT,
+		.lostcount		= hm->lost_prev_event,
+	};
+	struct xfs_healthmon_event	*event;
+
+	if (xfs_healthmon_merge_events(hm->last_event, &lost_event)) {
+		trace_xfs_healthmon_merge(hm, hm->last_event);
+		wake_up(&hm->wait);
+		goto cleared;
+	}
+
+	if (hm->events >= XFS_HEALTHMON_MAX_EVENTS)
+		return -ENOMEM;
+
+	event = xfs_healthmon_event_dup(&lost_event);
+	if (!event)
+		return -ENOMEM;
+
+	__xfs_healthmon_push(hm, event);
+cleared:
+	hm->lost_prev_event = 0;
+	return 0;
+}
+
+/*
+ * Push an event onto the end of the list after dealing with lost events and
+ * possibly full queues.
+ */
+STATIC int
+xfs_healthmon_push(
+	struct xfs_healthmon			*hm,
+	const struct xfs_healthmon_event	*template)
+{
+	struct xfs_healthmon_event		*event = NULL;
+	int					error = 0;
+
+	/*
+	 * Locklessly check if the health monitor has already detached from the
+	 * mount.  If so, ignore the event.  If we race with deactivation,
+	 * we'll queue the event but never send it.
+	 */
+	if (!xfs_healthmon_activated(hm))
+		return -ESHUTDOWN;
+
+	mutex_lock(&hm->lock);
+
+	/* Report previously lost events before we do anything else */
+	if (hm->lost_prev_event) {
+		error = xfs_healthmon_clear_lost_prev(hm);
+		if (error)
+			goto out_unlock;
+	}
+
+	/* Try to merge with the newest event */
+	if (xfs_healthmon_merge_events(hm->last_event, template)) {
+		trace_xfs_healthmon_merge(hm, hm->last_event);
+		wake_up(&hm->wait);
+		goto out_unlock;
+	}
+
+	/* Only create a heap event object if we're not already at capacity. */
+	if (hm->events < XFS_HEALTHMON_MAX_EVENTS)
+		event = xfs_healthmon_event_dup(template);
+
+	if (!event) {
+		/* No memory means we lose the event */
+		trace_xfs_healthmon_lost_event(hm);
+		xfs_healthmon_bump_lost(hm);
+		error = -ENOMEM;
+	} else {
+		__xfs_healthmon_push(hm, event);
+	}
+
+out_unlock:
+	mutex_unlock(&hm->lock);
+	return error;
 }
 
 /* Detach the xfs mount from this healthmon instance. */
@@ -160,12 +369,271 @@ xfs_healthmon_unmount(
 	xfs_healthmon_put(hm);
 }
 
+static inline void
+xfs_healthmon_reset_outbuf(
+	struct xfs_healthmon		*hm)
+{
+	hm->buftail = 0;
+	hm->bufhead = 0;
+}
+
+static const unsigned int domain_map[] = {
+	[XFS_HEALTHMON_MOUNT]		= XFS_HEALTH_MONITOR_DOMAIN_MOUNT,
+};
+
+static const unsigned int type_map[] = {
+	[XFS_HEALTHMON_RUNNING]		= XFS_HEALTH_MONITOR_TYPE_RUNNING,
+	[XFS_HEALTHMON_LOST]		= XFS_HEALTH_MONITOR_TYPE_LOST,
+};
+
+/* Render event as a V0 structure */
+STATIC int
+xfs_healthmon_format_v0(
+	struct xfs_healthmon		*hm,
+	const struct xfs_healthmon_event *event)
+{
+	struct xfs_health_monitor_event	hme = {
+		.time_ns		= event->time_ns,
+	};
+
+	trace_xfs_healthmon_format(hm, event);
+
+	if (event->domain < 0 || event->domain >= ARRAY_SIZE(domain_map) ||
+	    event->type < 0   || event->type >= ARRAY_SIZE(type_map))
+		return -EFSCORRUPTED;
+
+	hme.domain = domain_map[event->domain];
+	hme.type = type_map[event->type];
+
+	/* fill in the event-specific details */
+	switch (event->domain) {
+	case XFS_HEALTHMON_MOUNT:
+		switch (event->type) {
+		case XFS_HEALTHMON_LOST:
+			hme.e.lost.count = event->lostcount;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	ASSERT(hm->bufhead + sizeof(hme) <= hm->bufsize);
+
+	/* copy formatted object to the outbuf */
+	if (hm->bufhead + sizeof(hme) <= hm->bufsize) {
+		memcpy(hm->buffer + hm->bufhead, &hme, sizeof(hme));
+		hm->bufhead += sizeof(hme);
+	}
+
+	return 0;
+}
+
+/* How many bytes are waiting in the outbuf to be copied? */
+static inline size_t
+xfs_healthmon_outbuf_bytes(
+	struct xfs_healthmon	*hm)
+{
+	if (hm->bufhead > hm->buftail)
+		return hm->bufhead - hm->buftail;
+	return 0;
+}
+
+/*
+ * Do we have something for userspace to read?  This can mean unmount events,
+ * events pending in the queue, or pending bytes in the outbuf.
+ */
+static inline bool
+xfs_healthmon_has_eventdata(
+	struct xfs_healthmon	*hm)
+{
+	/*
+	 * If the health monitor is already detached from the xfs_mount, we
+	 * want reads to return 0 bytes even if there are no events, because
+	 * userspace interprets that as EOF.  If we race with deactivation,
+	 * read_iter will take the necessary locks to discover that there are
+	 * no events to send.
+	 */
+	if (!xfs_healthmon_activated(hm))
+		return true;
+
+	/*
+	 * Either there are events waiting to be formatted into the buffer, or
+	 * there's unread bytes in the buffer.
+	 */
+	return hm->events > 0 || xfs_healthmon_outbuf_bytes(hm) > 0;
+}
+
+/* Try to copy the rest of the outbuf to the iov iter. */
+STATIC ssize_t
+xfs_healthmon_copybuf(
+	struct xfs_healthmon	*hm,
+	struct iov_iter		*to)
+{
+	size_t			to_copy;
+	size_t			w = 0;
+
+	trace_xfs_healthmon_copybuf(hm, to);
+
+	to_copy = xfs_healthmon_outbuf_bytes(hm);
+	if (to_copy) {
+		w = copy_to_iter(hm->buffer + hm->buftail, to_copy, to);
+		if (!w)
+			return -EFAULT;
+
+		hm->buftail += w;
+	}
+
+	/*
+	 * Nothing left to copy?  Reset the output buffer cursors to the start
+	 * since there's no live data in the buffer.
+	 */
+	if (xfs_healthmon_outbuf_bytes(hm) == 0)
+		xfs_healthmon_reset_outbuf(hm);
+	return w;
+}
+
+/*
+ * Return a health monitoring event for formatting into the output buffer if
+ * there's enough space in the outbuf and an event waiting for us.  Caller
+ * must hold i_rwsem on the healthmon file.
+ */
+static inline struct xfs_healthmon_event *
+xfs_healthmon_format_pop(
+	struct xfs_healthmon	*hm)
+{
+	struct xfs_healthmon_event *event;
+
+	if (hm->bufhead + sizeof(*event) > hm->bufsize)
+		return NULL;
+
+	mutex_lock(&hm->lock);
+	event = hm->first_event;
+	if (event) {
+		if (hm->last_event == event)
+			hm->last_event = NULL;
+		hm->first_event = event->next;
+		hm->events--;
+
+		trace_xfs_healthmon_pop(hm, event);
+	}
+	mutex_unlock(&hm->lock);
+	return event;
+}
+
+/* Allocate formatting buffer */
+STATIC int
+xfs_healthmon_alloc_outbuf(
+	struct xfs_healthmon	*hm,
+	size_t			user_bufsize)
+{
+	void			*outbuf;
+	size_t			bufsize =
+		min(XFS_HEALTHMON_MAX_OUTBUF, max(PAGE_SIZE, user_bufsize));
+
+	outbuf = kzalloc(bufsize, GFP_KERNEL);
+	if (!outbuf) {
+		if (bufsize == PAGE_SIZE)
+			return -ENOMEM;
+
+		bufsize = PAGE_SIZE;
+		outbuf = kzalloc(bufsize, GFP_KERNEL);
+		if (!outbuf)
+			return -ENOMEM;
+	}
+
+	hm->buffer = outbuf;
+	hm->bufsize = bufsize;
+	hm->bufhead = 0;
+	hm->buftail = 0;
+
+	return 0;
+}
+
+/*
+ * Convey queued event data to userspace.  First copy any remaining bytes in
+ * the outbuf, then format the oldest event into the outbuf and copy that too.
+ */
 STATIC ssize_t
 xfs_healthmon_read_iter(
 	struct kiocb		*iocb,
 	struct iov_iter		*to)
 {
-	return -EIO;
+	struct file		*file = iocb->ki_filp;
+	struct inode		*inode = file_inode(file);
+	struct xfs_healthmon	*hm = file->private_data;
+	struct xfs_healthmon_event *event;
+	size_t			copied = 0;
+	ssize_t			ret = 0;
+
+	if (file->f_flags & O_NONBLOCK) {
+		if (!xfs_healthmon_has_eventdata(hm))
+			return -EAGAIN;
+	} else {
+		ret = wait_event_interruptible(hm->wait,
+				xfs_healthmon_has_eventdata(hm));
+		if (ret)
+			return ret;
+	}
+
+	inode_lock(inode);
+
+	if (hm->bufsize == 0) {
+		ret = xfs_healthmon_alloc_outbuf(hm, iov_iter_count(to));
+		if (ret)
+			goto out_unlock;
+	}
+
+	trace_xfs_healthmon_read_start(hm);
+
+	/*
+	 * If there's anything left in the output buffer, copy that before
+	 * formatting more events.
+	 */
+	ret = xfs_healthmon_copybuf(hm, to);
+	if (ret < 0)
+		goto out_unlock;
+	copied += ret;
+
+	while (iov_iter_count(to) > 0) {
+		/* Format the next events into the outbuf until it's full. */
+		while ((event = xfs_healthmon_format_pop(hm)) != NULL) {
+			ret = xfs_healthmon_format_v0(hm, event);
+			kfree(event);
+			if (ret)
+				goto out_unlock;
+		}
+
+		/* Copy anything formatted into outbuf to userspace */
+		ret = xfs_healthmon_copybuf(hm, to);
+		if (ret <= 0)
+			break;
+
+		copied += ret;
+	}
+
+out_unlock:
+	trace_xfs_healthmon_read_finish(hm);
+	inode_unlock(inode);
+	return copied ?: ret;
+}
+
+/* Poll for available events. */
+STATIC __poll_t
+xfs_healthmon_poll(
+	struct file			*file,
+	struct poll_table_struct	*wait)
+{
+	struct xfs_healthmon		*hm = file->private_data;
+	__poll_t			mask = 0;
+
+	poll_wait(file, &hm->wait, wait);
+
+	if (xfs_healthmon_has_eventdata(hm))
+		mask |= EPOLLIN;
+	return mask;
 }
 
 /* Free the health monitoring information. */
@@ -176,6 +644,8 @@ xfs_healthmon_release(
 {
 	struct xfs_healthmon	*hm = file->private_data;
 
+	trace_xfs_healthmon_release(hm);
+
 	/*
 	 * We might be closing the healthmon file before the filesystem
 	 * unmounts, because userspace processes can terminate at any time and
@@ -184,6 +654,12 @@ xfs_healthmon_release(
 	 */
 	xfs_healthmon_detach(hm);
 
+	/*
+	 * Wake up any readers that might be left.  There shouldn't be any
+	 * because the only users of the waiter are read and poll.
+	 */
+	wake_up_all(&hm->wait);
+
 	xfs_healthmon_put(hm);
 	return 0;
 }
@@ -193,9 +669,9 @@ static inline bool
 xfs_healthmon_validate(
 	const struct xfs_health_monitor	*hmo)
 {
-	if (hmo->flags)
+	if (hmo->flags & ~XFS_HEALTH_MONITOR_ALL)
 		return false;
-	if (hmo->format)
+	if (hmo->format != XFS_HEALTH_MONITOR_FMT_V0)
 		return false;
 	if (memchr_inv(&hmo->pad1, 0, sizeof(hmo->pad1)))
 		return false;
@@ -212,15 +688,20 @@ xfs_healthmon_show_fdinfo(
 {
 	struct xfs_healthmon	*hm = file->private_data;
 
-	seq_printf(m, "state:\t%s\ndev:\t%d:%d\n",
+	mutex_lock(&hm->lock);
+	seq_printf(m, "state:\t%s\ndev:\t%d:%d\nformat:\tv0\nevents:\t%llu\nlost:\t%llu\n",
 			xfs_healthmon_activated(hm) ? "alive" : "dead",
-			MAJOR(hm->dev), MINOR(hm->dev));
+			MAJOR(hm->dev), MINOR(hm->dev),
+			hm->total_events,
+			hm->total_lost);
+	mutex_unlock(&hm->lock);
 }
 
 static const struct file_operations xfs_healthmon_fops = {
 	.owner		= THIS_MODULE,
 	.show_fdinfo	= xfs_healthmon_show_fdinfo,
 	.read_iter	= xfs_healthmon_read_iter,
+	.poll		= xfs_healthmon_poll,
 	.release	= xfs_healthmon_release,
 };
 
@@ -234,6 +715,7 @@ xfs_ioc_health_monitor(
 	struct xfs_health_monitor __user *arg)
 {
 	struct xfs_health_monitor	hmo;
+	struct xfs_healthmon_event	*running_event;
 	struct xfs_healthmon		*hm;
 	struct xfs_inode		*ip = XFS_I(file_inode(file));
 	struct xfs_mount		*mp = ip->i_mount;
@@ -264,6 +746,22 @@ xfs_ioc_health_monitor(
 	hm->dev = mp->m_super->s_dev;
 	refcount_set(&hm->ref, 1);
 
+	mutex_init(&hm->lock);
+	init_waitqueue_head(&hm->wait);
+
+	if (hmo.flags & XFS_HEALTH_MONITOR_VERBOSE)
+		hm->verbose = true;
+
+	/* Queue up the first event that lets the client know we're running. */
+	running_event = kzalloc(sizeof(struct xfs_healthmon_event), GFP_NOFS);
+	if (!running_event) {
+		ret = -ENOMEM;
+		goto out_hm;
+	}
+	running_event->type = XFS_HEALTHMON_RUNNING;
+	running_event->domain = XFS_HEALTHMON_MOUNT;
+	__xfs_healthmon_insert(hm, running_event);
+
 	/*
 	 * Try to attach this health monitor to the xfs_mount.  The monitor is
 	 * considered live and will receive events if this succeeds.
@@ -283,6 +781,8 @@ xfs_ioc_health_monitor(
 	if (ret < 0)
 		goto out_mp;
 
+	trace_xfs_healthmon_create(mp->m_super->s_dev, hmo.flags, hmo.format);
+
 	return ret;
 
 out_mp:
diff --git a/fs/xfs/xfs_trace.c b/fs/xfs/xfs_trace.c
index a60556dbd172ee..d42b864a3837a2 100644
--- a/fs/xfs/xfs_trace.c
+++ b/fs/xfs/xfs_trace.c
@@ -51,6 +51,8 @@
 #include "xfs_rtgroup.h"
 #include "xfs_zone_alloc.h"
 #include "xfs_zone_priv.h"
+#include "xfs_health.h"
+#include "xfs_healthmon.h"
 
 /*
  * We include this last to have the helpers above available for the trace


