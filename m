Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A42765F5B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 00:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjG0WZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 18:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjG0WZy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:25:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E974F0;
        Thu, 27 Jul 2023 15:25:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA6FA61F57;
        Thu, 27 Jul 2023 22:25:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E89BC433C8;
        Thu, 27 Jul 2023 22:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690496751;
        bh=i578hWS3rXzB0EpMXxUhfAK4/mmK7kp3kodAg6CDML0=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=pmidTTroZAGdYbgboOxpWlPwWlwpfiG9IYCTiWtG7gNME6zqIzAGIKK4mt4idRTHn
         ICyDGLjYxxOSAwiXJh5RUegWmsM33JjQNJuc0KpH4IT+FZUSlFCtXusppVv8TJHYWd
         wQfUuP0exDFeBvyaoHoL6C/FaYO4YsQsKL6g4yOE8AOCWMoqtwgl3/gYHVZ1yxMu0s
         4adg6DTqdY+U4aIdZM31zrqX9aCwNPHQUP4PPKzatkUoZieyx5mHm3qOS3dkkHAL9B
         kGO3DOgidiUQVI1whMMExcZr/D3IfPPxAS+WGzrjG9yH6/4wGpwD8y+3If6R7TQBq4
         Fo7QJgxk3mUOQ==
Date:   Thu, 27 Jul 2023 15:25:50 -0700
Subject: [PATCH 2/7] xfs: enable sorting of xfile-backed arrays
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org
Message-ID: <169049623600.921478.515800900911021005.stgit@frogsfrogsfrogs>
In-Reply-To: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
References: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

The btree bulk loading code requires that records be provided in the
correct record sort order for the given btree type.  In general, repair
code cannot be required to collect records in order, and it is not
feasible to insert new records in the middle of an array to maintain
sort order.

Implement a sorting algorithm so that we can sort the records just prior
to bulk loading.  In principle, an xfarray could consume many gigabytes
of memory and its backing pages can be sent out to disk at any time.
This means that we cannot map the entire array into memory at once, so
we must find a way to divide the work into smaller portions (e.g. a
page) that /can/ be mapped into memory.

Quicksort seems like a reasonable fit for this purpose, since it uses a
divide and conquer strategy to keep its average runtime logarithmic.
The solution presented here is a port of the glibc implementation, which
itself is derived from the median-of-three and tail call recursion
strategies outlined by Sedgwick.

Subsequent patches will optimize the implementation further by utilizing
the kernel's heapsort on directly-mapped memory whenever possible, and
improving the quicksort pivot selection algorithm to try to avoid O(n^2)
collapses.

Note: The sorting functionality gets its own patch because the basic big
array mechanisms were plenty for a single code patch.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/scrub/trace.h   |  114 ++++++++++
 fs/xfs/scrub/xfarray.c |  569 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfarray.h |   67 ++++++
 3 files changed, 750 insertions(+)


diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 0b9e781840f37..2fbee6389e2a0 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -18,6 +18,7 @@
 
 struct xfile;
 struct xfarray;
+struct xfarray_sortinfo;
 
 /*
  * ftrace's __print_symbolic requires that all enum values be wrapped in the
@@ -846,6 +847,119 @@ TRACE_EVENT(xfarray_create,
 		  __entry->obj_size_log)
 );
 
+TRACE_EVENT(xfarray_isort,
+	TP_PROTO(struct xfarray_sortinfo *si, uint64_t lo, uint64_t hi),
+	TP_ARGS(si, lo, hi),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(unsigned long long, lo)
+		__field(unsigned long long, hi)
+	),
+	TP_fast_assign(
+		__entry->ino = file_inode(si->array->xfile->file)->i_ino;
+		__entry->lo = lo;
+		__entry->hi = hi;
+	),
+	TP_printk("xfino 0x%lx lo %llu hi %llu elts %llu",
+		  __entry->ino,
+		  __entry->lo,
+		  __entry->hi,
+		  __entry->hi - __entry->lo)
+);
+
+TRACE_EVENT(xfarray_qsort,
+	TP_PROTO(struct xfarray_sortinfo *si, uint64_t lo, uint64_t hi),
+	TP_ARGS(si, lo, hi),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(unsigned long long, lo)
+		__field(unsigned long long, hi)
+		__field(int, stack_depth)
+		__field(int, max_stack_depth)
+	),
+	TP_fast_assign(
+		__entry->ino = file_inode(si->array->xfile->file)->i_ino;
+		__entry->lo = lo;
+		__entry->hi = hi;
+		__entry->stack_depth = si->stack_depth;
+		__entry->max_stack_depth = si->max_stack_depth;
+	),
+	TP_printk("xfino 0x%lx lo %llu hi %llu elts %llu stack %d/%d",
+		  __entry->ino,
+		  __entry->lo,
+		  __entry->hi,
+		  __entry->hi - __entry->lo,
+		  __entry->stack_depth,
+		  __entry->max_stack_depth)
+);
+
+TRACE_EVENT(xfarray_sort,
+	TP_PROTO(struct xfarray_sortinfo *si, size_t bytes),
+	TP_ARGS(si, bytes),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+		__field(unsigned long long, nr)
+		__field(size_t, obj_size)
+		__field(size_t, bytes)
+		__field(unsigned int, max_stack_depth)
+	),
+	TP_fast_assign(
+		__entry->nr = si->array->nr;
+		__entry->obj_size = si->array->obj_size;
+		__entry->ino = file_inode(si->array->xfile->file)->i_ino;
+		__entry->bytes = bytes;
+		__entry->max_stack_depth = si->max_stack_depth;
+	),
+	TP_printk("xfino 0x%lx nr %llu objsz %zu stack %u bytes %zu",
+		  __entry->ino,
+		  __entry->nr,
+		  __entry->obj_size,
+		  __entry->max_stack_depth,
+		  __entry->bytes)
+);
+
+TRACE_EVENT(xfarray_sort_stats,
+	TP_PROTO(struct xfarray_sortinfo *si, int error),
+	TP_ARGS(si, error),
+	TP_STRUCT__entry(
+		__field(unsigned long, ino)
+#ifdef DEBUG
+		__field(unsigned long long, loads)
+		__field(unsigned long long, stores)
+		__field(unsigned long long, compares)
+#endif
+		__field(unsigned int, max_stack_depth)
+		__field(unsigned int, max_stack_used)
+		__field(int, error)
+	),
+	TP_fast_assign(
+		__entry->ino = file_inode(si->array->xfile->file)->i_ino;
+#ifdef DEBUG
+		__entry->loads = si->loads;
+		__entry->stores = si->stores;
+		__entry->compares = si->compares;
+#endif
+		__entry->max_stack_depth = si->max_stack_depth;
+		__entry->max_stack_used = si->max_stack_used;
+		__entry->error = error;
+	),
+	TP_printk(
+#ifdef DEBUG
+		  "xfino 0x%lx loads %llu stores %llu compares %llu stack_depth %u/%u error %d",
+#else
+		  "xfino 0x%lx stack_depth %u/%u error %d",
+#endif
+		  __entry->ino,
+#ifdef DEBUG
+		  __entry->loads,
+		  __entry->stores,
+		  __entry->compares,
+#endif
+		  __entry->max_stack_used,
+		  __entry->max_stack_depth,
+		  __entry->error)
+);
+
 /* repair tracepoints */
 #if IS_ENABLED(CONFIG_XFS_ONLINE_REPAIR)
 
diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index ca4a4a307010f..226488d85d6d6 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -367,3 +367,572 @@ xfarray_load_next(
 	*idx = cur;
 	return 0;
 }
+
+/* Sorting functions */
+
+#ifdef DEBUG
+# define xfarray_sort_bump_loads(si)	do { (si)->loads++; } while (0)
+# define xfarray_sort_bump_stores(si)	do { (si)->stores++; } while (0)
+# define xfarray_sort_bump_compares(si)	do { (si)->compares++; } while (0)
+#else
+# define xfarray_sort_bump_loads(si)
+# define xfarray_sort_bump_stores(si)
+# define xfarray_sort_bump_compares(si)
+#endif /* DEBUG */
+
+/* Load an array element for sorting. */
+static inline int
+xfarray_sort_load(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		idx,
+	void			*ptr)
+{
+	xfarray_sort_bump_loads(si);
+	return xfarray_load(si->array, idx, ptr);
+}
+
+/* Store an array element for sorting. */
+static inline int
+xfarray_sort_store(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		idx,
+	void			*ptr)
+{
+	xfarray_sort_bump_stores(si);
+	return xfarray_store(si->array, idx, ptr);
+}
+
+/* Compare an array element for sorting. */
+static inline int
+xfarray_sort_cmp(
+	struct xfarray_sortinfo	*si,
+	const void		*a,
+	const void		*b)
+{
+	xfarray_sort_bump_compares(si);
+	return si->cmp_fn(a, b);
+}
+
+/* Return a pointer to the low index stack for quicksort partitioning. */
+static inline xfarray_idx_t *xfarray_sortinfo_lo(struct xfarray_sortinfo *si)
+{
+	return (xfarray_idx_t *)(si + 1);
+}
+
+/* Return a pointer to the high index stack for quicksort partitioning. */
+static inline xfarray_idx_t *xfarray_sortinfo_hi(struct xfarray_sortinfo *si)
+{
+	return xfarray_sortinfo_lo(si) + si->max_stack_depth;
+}
+
+/* Allocate memory to handle the sort. */
+static inline int
+xfarray_sortinfo_alloc(
+	struct xfarray		*array,
+	xfarray_cmp_fn		cmp_fn,
+	unsigned int		flags,
+	struct xfarray_sortinfo	**infop)
+{
+	struct xfarray_sortinfo	*si;
+	size_t			nr_bytes = sizeof(struct xfarray_sortinfo);
+	int			max_stack_depth;
+
+	/*
+	 * Tail-call recursion during the partitioning phase means that
+	 * quicksort will never recurse more than log2(nr) times.  We need one
+	 * extra level of stack to hold the initial parameters.
+	 */
+	max_stack_depth = ilog2(array->nr) + 1;
+
+	/* Each level of quicksort uses a lo and a hi index */
+	nr_bytes += max_stack_depth * sizeof(xfarray_idx_t) * 2;
+
+	/* One record for the pivot */
+	nr_bytes += array->obj_size;
+
+	si = kvzalloc(nr_bytes, XCHK_GFP_FLAGS);
+	if (!si)
+		return -ENOMEM;
+
+	si->array = array;
+	si->cmp_fn = cmp_fn;
+	si->flags = flags;
+	si->max_stack_depth = max_stack_depth;
+	si->max_stack_used = 1;
+
+	xfarray_sortinfo_lo(si)[0] = 0;
+	xfarray_sortinfo_hi(si)[0] = array->nr - 1;
+
+	trace_xfarray_sort(si, nr_bytes);
+	*infop = si;
+	return 0;
+}
+
+/* Should this sort be terminated by a fatal signal? */
+static inline bool
+xfarray_sort_terminated(
+	struct xfarray_sortinfo	*si,
+	int			*error)
+{
+	/*
+	 * If preemption is disabled, we need to yield to the scheduler every
+	 * few seconds so that we don't run afoul of the soft lockup watchdog
+	 * or RCU stall detector.
+	 */
+	cond_resched();
+
+	if ((si->flags & XFARRAY_SORT_KILLABLE) &&
+	    fatal_signal_pending(current)) {
+		if (*error == 0)
+			*error = -EINTR;
+		return true;
+	}
+	return false;
+}
+
+/* Do we want an insertion sort? */
+static inline bool
+xfarray_want_isort(
+	struct xfarray_sortinfo *si,
+	xfarray_idx_t		start,
+	xfarray_idx_t		end)
+{
+	/*
+	 * For array subsets smaller than 8 elements, it's slightly faster to
+	 * use insertion sort than quicksort's stack machine.
+	 */
+	return (end - start) < 8;
+}
+
+/* Return the scratch space within the sortinfo structure. */
+static inline void *xfarray_sortinfo_isort_scratch(struct xfarray_sortinfo *si)
+{
+	return xfarray_sortinfo_hi(si) + si->max_stack_depth;
+}
+
+/*
+ * Perform an insertion sort on a subset of the array.
+ * Though insertion sort is an O(n^2) algorithm, for small set sizes it's
+ * faster than quicksort's stack machine, so we let it take over for that.
+ * This ought to be replaced with something more efficient.
+ */
+STATIC int
+xfarray_isort(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		lo,
+	xfarray_idx_t		hi)
+{
+	void			*a = xfarray_sortinfo_isort_scratch(si);
+	void			*b = xfarray_scratch(si->array);
+	xfarray_idx_t		tmp;
+	xfarray_idx_t		i;
+	xfarray_idx_t		run;
+	int			error;
+
+	trace_xfarray_isort(si, lo, hi);
+
+	/*
+	 * Move the smallest element in a[lo..hi] to a[lo].  This
+	 * simplifies the loop control logic below.
+	 */
+	tmp = lo;
+	error = xfarray_sort_load(si, tmp, b);
+	if (error)
+		return error;
+	for (run = lo + 1; run <= hi; run++) {
+		/* if a[run] < a[tmp], tmp = run */
+		error = xfarray_sort_load(si, run, a);
+		if (error)
+			return error;
+		if (xfarray_sort_cmp(si, a, b) < 0) {
+			tmp = run;
+			memcpy(b, a, si->array->obj_size);
+		}
+
+		if (xfarray_sort_terminated(si, &error))
+			return error;
+	}
+
+	/*
+	 * The smallest element is a[tmp]; swap with a[lo] if tmp != lo.
+	 * Recall that a[tmp] is already in *b.
+	 */
+	if (tmp != lo) {
+		error = xfarray_sort_load(si, lo, a);
+		if (error)
+			return error;
+		error = xfarray_sort_store(si, tmp, a);
+		if (error)
+			return error;
+		error = xfarray_sort_store(si, lo, b);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * Perform an insertion sort on a[lo+1..hi].  We already made sure
+	 * that the smallest value in the original range is now in a[lo],
+	 * so the inner loop should never underflow.
+	 *
+	 * For each a[lo+2..hi], make sure it's in the correct position
+	 * with respect to the elements that came before it.
+	 */
+	for (run = lo + 2; run <= hi; run++) {
+		error = xfarray_sort_load(si, run, a);
+		if (error)
+			return error;
+
+		/*
+		 * Find the correct place for a[run] by walking leftwards
+		 * towards the start of the range until a[tmp] is no longer
+		 * greater than a[run].
+		 */
+		tmp = run - 1;
+		error = xfarray_sort_load(si, tmp, b);
+		if (error)
+			return error;
+		while (xfarray_sort_cmp(si, a, b) < 0) {
+			tmp--;
+			error = xfarray_sort_load(si, tmp, b);
+			if (error)
+				return error;
+
+			if (xfarray_sort_terminated(si, &error))
+				return error;
+		}
+		tmp++;
+
+		/*
+		 * If tmp != run, then a[tmp..run-1] are all less than a[run],
+		 * so right barrel roll a[tmp..run] to get this range in
+		 * sorted order.
+		 */
+		if (tmp == run)
+			continue;
+
+		for (i = run; i >= tmp; i--) {
+			error = xfarray_sort_load(si, i - 1, b);
+			if (error)
+				return error;
+			error = xfarray_sort_store(si, i, b);
+			if (error)
+				return error;
+
+			if (xfarray_sort_terminated(si, &error))
+				return error;
+		}
+		error = xfarray_sort_store(si, tmp, a);
+		if (error)
+			return error;
+
+		if (xfarray_sort_terminated(si, &error))
+			return error;
+	}
+
+	return 0;
+}
+
+/* Return a pointer to the xfarray pivot record within the sortinfo struct. */
+static inline void *xfarray_sortinfo_pivot(struct xfarray_sortinfo *si)
+{
+	return xfarray_sortinfo_hi(si) + si->max_stack_depth;
+}
+
+/*
+ * Find a pivot value for quicksort partitioning, swap it with a[lo], and save
+ * the cached pivot record for the next step.
+ *
+ * Select the median value from a[lo], a[mid], and a[hi].  Put the median in
+ * a[lo], the lowest in a[mid], and the highest in a[hi].  Using the median of
+ * the three reduces the chances that we pick the worst case pivot value, since
+ * it's likely that our array values are nearly sorted.
+ */
+STATIC int
+xfarray_qsort_pivot(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		lo,
+	xfarray_idx_t		hi)
+{
+	void			*a = xfarray_sortinfo_pivot(si);
+	void			*b = xfarray_scratch(si->array);
+	xfarray_idx_t		mid = lo + ((hi - lo) / 2);
+	int			error;
+
+	/* if a[mid] < a[lo], swap a[mid] and a[lo]. */
+	error = xfarray_sort_load(si, mid, a);
+	if (error)
+		return error;
+	error = xfarray_sort_load(si, lo, b);
+	if (error)
+		return error;
+	if (xfarray_sort_cmp(si, a, b) < 0) {
+		error = xfarray_sort_store(si, lo, a);
+		if (error)
+			return error;
+		error = xfarray_sort_store(si, mid, b);
+		if (error)
+			return error;
+	}
+
+	/* if a[hi] < a[mid], swap a[mid] and a[hi]. */
+	error = xfarray_sort_load(si, hi, a);
+	if (error)
+		return error;
+	error = xfarray_sort_load(si, mid, b);
+	if (error)
+		return error;
+	if (xfarray_sort_cmp(si, a, b) < 0) {
+		error = xfarray_sort_store(si, mid, a);
+		if (error)
+			return error;
+		error = xfarray_sort_store(si, hi, b);
+		if (error)
+			return error;
+	} else {
+		goto move_front;
+	}
+
+	/* if a[mid] < a[lo], swap a[mid] and a[lo]. */
+	error = xfarray_sort_load(si, mid, a);
+	if (error)
+		return error;
+	error = xfarray_sort_load(si, lo, b);
+	if (error)
+		return error;
+	if (xfarray_sort_cmp(si, a, b) < 0) {
+		error = xfarray_sort_store(si, lo, a);
+		if (error)
+			return error;
+		error = xfarray_sort_store(si, mid, b);
+		if (error)
+			return error;
+	}
+
+move_front:
+	/*
+	 * Move our selected pivot to a[lo].  Recall that a == si->pivot, so
+	 * this leaves us with the pivot cached in the sortinfo structure.
+	 */
+	error = xfarray_sort_load(si, lo, b);
+	if (error)
+		return error;
+	error = xfarray_sort_load(si, mid, a);
+	if (error)
+		return error;
+	error = xfarray_sort_store(si, mid, b);
+	if (error)
+		return error;
+	return xfarray_sort_store(si, lo, a);
+}
+
+/*
+ * Set up the pointers for the next iteration.  We push onto the stack all of
+ * the unsorted values between a[lo + 1] and a[end[i]], and we tweak the
+ * current stack frame to point to the unsorted values between a[beg[i]] and
+ * a[lo] so that those values will be sorted when we pop the stack.
+ */
+static inline int
+xfarray_qsort_push(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		*si_lo,
+	xfarray_idx_t		*si_hi,
+	xfarray_idx_t		lo,
+	xfarray_idx_t		hi)
+{
+	/* Check for stack overflows */
+	if (si->stack_depth >= si->max_stack_depth - 1) {
+		ASSERT(si->stack_depth < si->max_stack_depth - 1);
+		return -EFSCORRUPTED;
+	}
+
+	si->max_stack_used = max_t(uint8_t, si->max_stack_used,
+					    si->stack_depth + 2);
+
+	si_lo[si->stack_depth + 1] = lo + 1;
+	si_hi[si->stack_depth + 1] = si_hi[si->stack_depth];
+	si_hi[si->stack_depth++] = lo - 1;
+
+	/*
+	 * Always start with the smaller of the two partitions to keep the
+	 * amount of recursion in check.
+	 */
+	if (si_hi[si->stack_depth]     - si_lo[si->stack_depth] >
+	    si_hi[si->stack_depth - 1] - si_lo[si->stack_depth - 1]) {
+		swap(si_lo[si->stack_depth], si_lo[si->stack_depth - 1]);
+		swap(si_hi[si->stack_depth], si_hi[si->stack_depth - 1]);
+	}
+
+	return 0;
+}
+
+/*
+ * Sort the array elements via quicksort.  This implementation incorporates
+ * four optimizations discussed in Sedgewick:
+ *
+ * 1. Use an explicit stack of array indices to store the next array partition
+ *    to sort.  This helps us to avoid recursion in the call stack, which is
+ *    particularly expensive in the kernel.
+ *
+ * 2. For arrays with records in arbitrary or user-controlled order, choose the
+ *    pivot element using a median-of-three decision tree.  This reduces the
+ *    probability of selecting a bad pivot value which causes worst case
+ *    behavior (i.e. partition sizes of 1).
+ *
+ * 3. The smaller of the two sub-partitions is pushed onto the stack to start
+ *    the next level of recursion, and the larger sub-partition replaces the
+ *    current stack frame.  This guarantees that we won't need more than
+ *    log2(nr) stack space.
+ *
+ * 4. Use insertion sort for small sets since since insertion sort is faster
+ *    for small, mostly sorted array segments.  In the author's experience,
+ *    substituting insertion sort for arrays smaller than 8 elements yields
+ *    a ~10% reduction in runtime.
+ */
+
+/*
+ * Due to the use of signed indices, we can only support up to 2^63 records.
+ * Files can only grow to 2^63 bytes, so this is not much of a limitation.
+ */
+#define QSORT_MAX_RECS		(1ULL << 63)
+
+int
+xfarray_sort(
+	struct xfarray		*array,
+	xfarray_cmp_fn		cmp_fn,
+	unsigned int		flags)
+{
+	struct xfarray_sortinfo	*si;
+	xfarray_idx_t		*si_lo, *si_hi;
+	void			*pivot;
+	void			*scratch = xfarray_scratch(array);
+	xfarray_idx_t		lo, hi;
+	int			error = 0;
+
+	if (array->nr < 2)
+		return 0;
+	if (array->nr >= QSORT_MAX_RECS)
+		return -E2BIG;
+
+	error = xfarray_sortinfo_alloc(array, cmp_fn, flags, &si);
+	if (error)
+		return error;
+	si_lo = xfarray_sortinfo_lo(si);
+	si_hi = xfarray_sortinfo_hi(si);
+	pivot = xfarray_sortinfo_pivot(si);
+
+	while (si->stack_depth >= 0) {
+		lo = si_lo[si->stack_depth];
+		hi = si_hi[si->stack_depth];
+
+		trace_xfarray_qsort(si, lo, hi);
+
+		/* Nothing left in this partition to sort; pop stack. */
+		if (lo >= hi) {
+			si->stack_depth--;
+			continue;
+		}
+
+		/* If insertion sort can solve our problems, we're done. */
+		if (xfarray_want_isort(si, lo, hi)) {
+			error = xfarray_isort(si, lo, hi);
+			if (error)
+				goto out_free;
+			si->stack_depth--;
+			continue;
+		}
+
+		/* Pick a pivot, move it to a[lo] and stash it. */
+		error = xfarray_qsort_pivot(si, lo, hi);
+		if (error)
+			goto out_free;
+
+		/*
+		 * Rearrange a[lo..hi] such that everything smaller than the
+		 * pivot is on the left side of the range and everything larger
+		 * than the pivot is on the right side of the range.
+		 */
+		while (lo < hi) {
+			/*
+			 * Decrement hi until it finds an a[hi] less than the
+			 * pivot value.
+			 */
+			error = xfarray_sort_load(si, hi, scratch);
+			if (error)
+				goto out_free;
+			while (xfarray_sort_cmp(si, scratch, pivot) >= 0 &&
+								lo < hi) {
+				if (xfarray_sort_terminated(si, &error))
+					goto out_free;
+
+				hi--;
+				error = xfarray_sort_load(si, hi, scratch);
+				if (error)
+					goto out_free;
+			}
+
+			if (xfarray_sort_terminated(si, &error))
+				goto out_free;
+
+			/* Copy that item (a[hi]) to a[lo]. */
+			if (lo < hi) {
+				error = xfarray_sort_store(si, lo++, scratch);
+				if (error)
+					goto out_free;
+			}
+
+			/*
+			 * Increment lo until it finds an a[lo] greater than
+			 * the pivot value.
+			 */
+			error = xfarray_sort_load(si, lo, scratch);
+			if (error)
+				goto out_free;
+			while (xfarray_sort_cmp(si, scratch, pivot) <= 0 &&
+								lo < hi) {
+				if (xfarray_sort_terminated(si, &error))
+					goto out_free;
+
+				lo++;
+				error = xfarray_sort_load(si, lo, scratch);
+				if (error)
+					goto out_free;
+			}
+
+			if (xfarray_sort_terminated(si, &error))
+				goto out_free;
+
+			/* Copy that item (a[lo]) to a[hi]. */
+			if (lo < hi) {
+				error = xfarray_sort_store(si, hi--, scratch);
+				if (error)
+					goto out_free;
+			}
+
+			if (xfarray_sort_terminated(si, &error))
+				goto out_free;
+		}
+
+		/*
+		 * Put our pivot value in the correct place at a[lo].  All
+		 * values between a[beg[i]] and a[lo - 1] should be less than
+		 * the pivot; and all values between a[lo + 1] and a[end[i]-1]
+		 * should be greater than the pivot.
+		 */
+		error = xfarray_sort_store(si, lo, pivot);
+		if (error)
+			goto out_free;
+
+		/* Set up the stack frame to process the two partitions. */
+		error = xfarray_qsort_push(si, si_lo, si_hi, lo, hi);
+		if (error)
+			goto out_free;
+
+		if (xfarray_sort_terminated(si, &error))
+			goto out_free;
+	}
+
+out_free:
+	trace_xfarray_sort_stats(si, error);
+	kvfree(si);
+	return error;
+}
diff --git a/fs/xfs/scrub/xfarray.h b/fs/xfs/scrub/xfarray.h
index 3ef7911b104b8..86c09897a4126 100644
--- a/fs/xfs/scrub/xfarray.h
+++ b/fs/xfs/scrub/xfarray.h
@@ -54,4 +54,71 @@ static inline int xfarray_append(struct xfarray *array, const void *ptr)
 uint64_t xfarray_length(struct xfarray *array);
 int xfarray_load_next(struct xfarray *array, xfarray_idx_t *idx, void *rec);
 
+/* Declarations for xfile array sort functionality. */
+
+typedef cmp_func_t xfarray_cmp_fn;
+
+struct xfarray_sortinfo {
+	struct xfarray		*array;
+
+	/* Comparison function for the sort. */
+	xfarray_cmp_fn		cmp_fn;
+
+	/* Maximum height of the partition stack. */
+	uint8_t			max_stack_depth;
+
+	/* Current height of the partition stack. */
+	int8_t			stack_depth;
+
+	/* Maximum stack depth ever used. */
+	uint8_t			max_stack_used;
+
+	/* XFARRAY_SORT_* flags; see below. */
+	unsigned int		flags;
+
+#ifdef DEBUG
+	/* Performance statistics. */
+	uint64_t		loads;
+	uint64_t		stores;
+	uint64_t		compares;
+#endif
+
+	/*
+	 * Extra bytes are allocated beyond the end of the structure to store
+	 * quicksort information.  C does not permit multiple VLAs per struct,
+	 * so we document all of this in a comment.
+	 *
+	 * Pretend that we have a typedef for array records:
+	 *
+	 * typedef char[array->obj_size]	xfarray_rec_t;
+	 *
+	 * First comes the quicksort partition stack:
+	 *
+	 * xfarray_idx_t	lo[max_stack_depth];
+	 * xfarray_idx_t	hi[max_stack_depth];
+	 *
+	 * union {
+	 *
+	 * If for a given subset we decide to use an insertion sort, we use the
+	 * scratchpad record after the xfarray and a second scratchpad record
+	 * here to compare items:
+	 *
+	 * 	xfarray_rec_t	scratch;
+	 *
+	 * Otherwise, we want to partition the records to partition the array.
+	 * We store the chosen pivot record here and use the xfarray scratchpad
+	 * to rearrange the array around the pivot:
+	 *
+	 * 	xfarray_rec_t	pivot;
+	 *
+	 * }
+	 */
+};
+
+/* Sort can be interrupted by a fatal signal. */
+#define XFARRAY_SORT_KILLABLE	(1U << 0)
+
+int xfarray_sort(struct xfarray *array, xfarray_cmp_fn cmp_fn,
+		unsigned int flags);
+
 #endif /* __XFS_SCRUB_XFARRAY_H__ */

