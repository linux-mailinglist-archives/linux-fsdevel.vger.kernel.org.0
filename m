Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EFE4765F5D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 00:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjG0W0K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 18:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjG0W0J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:26:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DC25F0;
        Thu, 27 Jul 2023 15:26:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8E86661F6A;
        Thu, 27 Jul 2023 22:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E92B2C433C8;
        Thu, 27 Jul 2023 22:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690496767;
        bh=jL5RmABRLC4PpIGkjhI6AN1lGSJJPK85M9giQpXsJJ0=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=PjT7OyE2+pcErsQI5G07HTley9JXtLYZtZ2GBXnfJhtu2paAIYpF5P+UOD02LVNfU
         IdD7Rl1Q3Ww7ouTfjmcC2Zj/FafW9HHch5rcm9ucOO75pQORZ1auEDG2JU0G5zop21
         tImLeup3Ubk4A36Z7Uy/w5lBKAKZU3Irt2SM7+6MZMdoyIc+RUAYGWCcxMIZUU07x6
         Ixsr3J6zc+fTvA5Gx+VMRohyhY1XnjDmQWgQN+Hp67bp3oJrzdOcdnqJnGONBkDFlk
         eqZgkOvxV8qPY6HlBdHGvsqT7dW56G6aIw30Pip76s7GJxzwsUN69EMfJjFpAi8ohb
         TdRth4993DDbw==
Date:   Thu, 27 Jul 2023 15:26:06 -0700
Subject: [PATCH 3/7] xfs: convert xfarray insertion sort to heapsort using
 scratchpad memory
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org
Message-ID: <169049623614.921478.3633915582455085701.stgit@frogsfrogsfrogs>
In-Reply-To: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
References: <169049623563.921478.13811535720302490179.stgit@frogsfrogsfrogs>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

In the previous patch, we created a very basic quicksort implementation
for xfile arrays.  While the use of an alternate sorting algorithm to
avoid quicksort recursion on very small subsets reduces the runtime
modestly, we could do better than a load and store-heavy insertion sort,
particularly since each load and store requires a page mapping lookup in
the xfile.

For a small increase in kernel memory requirements, we could instead
bulk load the xfarray records into memory, use the kernel's existing
heapsort implementation to sort the records, and bulk store the memory
buffer back into the xfile.  On the author's computer, this reduces the
runtime by about 5% on a 500,000 element array.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/scrub/trace.h   |    5 +-
 fs/xfs/scrub/xfarray.c |  142 +++++++++---------------------------------------
 fs/xfs/scrub/xfarray.h |   12 +++-
 3 files changed, 39 insertions(+), 120 deletions(-)


diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 2fbee6389e2a0..1c9a31dc4e223 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -927,6 +927,7 @@ TRACE_EVENT(xfarray_sort_stats,
 		__field(unsigned long long, loads)
 		__field(unsigned long long, stores)
 		__field(unsigned long long, compares)
+		__field(unsigned long long, heapsorts)
 #endif
 		__field(unsigned int, max_stack_depth)
 		__field(unsigned int, max_stack_used)
@@ -938,6 +939,7 @@ TRACE_EVENT(xfarray_sort_stats,
 		__entry->loads = si->loads;
 		__entry->stores = si->stores;
 		__entry->compares = si->compares;
+		__entry->heapsorts = si->heapsorts;
 #endif
 		__entry->max_stack_depth = si->max_stack_depth;
 		__entry->max_stack_used = si->max_stack_used;
@@ -945,7 +947,7 @@ TRACE_EVENT(xfarray_sort_stats,
 	),
 	TP_printk(
 #ifdef DEBUG
-		  "xfino 0x%lx loads %llu stores %llu compares %llu stack_depth %u/%u error %d",
+		  "xfino 0x%lx loads %llu stores %llu compares %llu heapsorts %llu stack_depth %u/%u error %d",
 #else
 		  "xfino 0x%lx stack_depth %u/%u error %d",
 #endif
@@ -954,6 +956,7 @@ TRACE_EVENT(xfarray_sort_stats,
 		  __entry->loads,
 		  __entry->stores,
 		  __entry->compares,
+		  __entry->heapsorts,
 #endif
 		  __entry->max_stack_used,
 		  __entry->max_stack_depth,
diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index 226488d85d6d6..2a0599f660d7b 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -374,10 +374,12 @@ xfarray_load_next(
 # define xfarray_sort_bump_loads(si)	do { (si)->loads++; } while (0)
 # define xfarray_sort_bump_stores(si)	do { (si)->stores++; } while (0)
 # define xfarray_sort_bump_compares(si)	do { (si)->compares++; } while (0)
+# define xfarray_sort_bump_heapsorts(si) do { (si)->heapsorts++; } while (0)
 #else
 # define xfarray_sort_bump_loads(si)
 # define xfarray_sort_bump_stores(si)
 # define xfarray_sort_bump_compares(si)
+# define xfarray_sort_bump_heapsorts(si)
 #endif /* DEBUG */
 
 /* Load an array element for sorting. */
@@ -440,15 +442,19 @@ xfarray_sortinfo_alloc(
 	/*
 	 * Tail-call recursion during the partitioning phase means that
 	 * quicksort will never recurse more than log2(nr) times.  We need one
-	 * extra level of stack to hold the initial parameters.
+	 * extra level of stack to hold the initial parameters.  In-memory
+	 * sort will always take care of the last few levels of recursion for
+	 * us, so we can reduce the stack depth by that much.
 	 */
-	max_stack_depth = ilog2(array->nr) + 1;
+	max_stack_depth = ilog2(array->nr) + 1 - (XFARRAY_ISORT_SHIFT - 1);
+	if (max_stack_depth < 1)
+		max_stack_depth = 1;
 
 	/* Each level of quicksort uses a lo and a hi index */
 	nr_bytes += max_stack_depth * sizeof(xfarray_idx_t) * 2;
 
-	/* One record for the pivot */
-	nr_bytes += array->obj_size;
+	/* Scratchpad for in-memory sort, or one record for the pivot */
+	nr_bytes += (XFARRAY_ISORT_NR * array->obj_size);
 
 	si = kvzalloc(nr_bytes, XCHK_GFP_FLAGS);
 	if (!si)
@@ -490,7 +496,7 @@ xfarray_sort_terminated(
 	return false;
 }
 
-/* Do we want an insertion sort? */
+/* Do we want an in-memory sort? */
 static inline bool
 xfarray_want_isort(
 	struct xfarray_sortinfo *si,
@@ -498,10 +504,10 @@ xfarray_want_isort(
 	xfarray_idx_t		end)
 {
 	/*
-	 * For array subsets smaller than 8 elements, it's slightly faster to
-	 * use insertion sort than quicksort's stack machine.
+	 * For array subsets that fit in the scratchpad, it's much faster to
+	 * use the kernel's heapsort than quicksort's stack machine.
 	 */
-	return (end - start) < 8;
+	return (end - start) < XFARRAY_ISORT_NR;
 }
 
 /* Return the scratch space within the sortinfo structure. */
@@ -511,10 +517,8 @@ static inline void *xfarray_sortinfo_isort_scratch(struct xfarray_sortinfo *si)
 }
 
 /*
- * Perform an insertion sort on a subset of the array.
- * Though insertion sort is an O(n^2) algorithm, for small set sizes it's
- * faster than quicksort's stack machine, so we let it take over for that.
- * This ought to be replaced with something more efficient.
+ * Sort a small number of array records using scratchpad memory.  The records
+ * need not be contiguous in the xfile's memory pages.
  */
 STATIC int
 xfarray_isort(
@@ -522,114 +526,23 @@ xfarray_isort(
 	xfarray_idx_t		lo,
 	xfarray_idx_t		hi)
 {
-	void			*a = xfarray_sortinfo_isort_scratch(si);
-	void			*b = xfarray_scratch(si->array);
-	xfarray_idx_t		tmp;
-	xfarray_idx_t		i;
-	xfarray_idx_t		run;
+	void			*scratch = xfarray_sortinfo_isort_scratch(si);
+	loff_t			lo_pos = xfarray_pos(si->array, lo);
+	loff_t			len = xfarray_pos(si->array, hi - lo + 1);
 	int			error;
 
 	trace_xfarray_isort(si, lo, hi);
 
-	/*
-	 * Move the smallest element in a[lo..hi] to a[lo].  This
-	 * simplifies the loop control logic below.
-	 */
-	tmp = lo;
-	error = xfarray_sort_load(si, tmp, b);
+	xfarray_sort_bump_loads(si);
+	error = xfile_obj_load(si->array->xfile, scratch, len, lo_pos);
 	if (error)
 		return error;
-	for (run = lo + 1; run <= hi; run++) {
-		/* if a[run] < a[tmp], tmp = run */
-		error = xfarray_sort_load(si, run, a);
-		if (error)
-			return error;
-		if (xfarray_sort_cmp(si, a, b) < 0) {
-			tmp = run;
-			memcpy(b, a, si->array->obj_size);
-		}
 
-		if (xfarray_sort_terminated(si, &error))
-			return error;
-	}
+	xfarray_sort_bump_heapsorts(si);
+	sort(scratch, hi - lo + 1, si->array->obj_size, si->cmp_fn, NULL);
 
-	/*
-	 * The smallest element is a[tmp]; swap with a[lo] if tmp != lo.
-	 * Recall that a[tmp] is already in *b.
-	 */
-	if (tmp != lo) {
-		error = xfarray_sort_load(si, lo, a);
-		if (error)
-			return error;
-		error = xfarray_sort_store(si, tmp, a);
-		if (error)
-			return error;
-		error = xfarray_sort_store(si, lo, b);
-		if (error)
-			return error;
-	}
-
-	/*
-	 * Perform an insertion sort on a[lo+1..hi].  We already made sure
-	 * that the smallest value in the original range is now in a[lo],
-	 * so the inner loop should never underflow.
-	 *
-	 * For each a[lo+2..hi], make sure it's in the correct position
-	 * with respect to the elements that came before it.
-	 */
-	for (run = lo + 2; run <= hi; run++) {
-		error = xfarray_sort_load(si, run, a);
-		if (error)
-			return error;
-
-		/*
-		 * Find the correct place for a[run] by walking leftwards
-		 * towards the start of the range until a[tmp] is no longer
-		 * greater than a[run].
-		 */
-		tmp = run - 1;
-		error = xfarray_sort_load(si, tmp, b);
-		if (error)
-			return error;
-		while (xfarray_sort_cmp(si, a, b) < 0) {
-			tmp--;
-			error = xfarray_sort_load(si, tmp, b);
-			if (error)
-				return error;
-
-			if (xfarray_sort_terminated(si, &error))
-				return error;
-		}
-		tmp++;
-
-		/*
-		 * If tmp != run, then a[tmp..run-1] are all less than a[run],
-		 * so right barrel roll a[tmp..run] to get this range in
-		 * sorted order.
-		 */
-		if (tmp == run)
-			continue;
-
-		for (i = run; i >= tmp; i--) {
-			error = xfarray_sort_load(si, i - 1, b);
-			if (error)
-				return error;
-			error = xfarray_sort_store(si, i, b);
-			if (error)
-				return error;
-
-			if (xfarray_sort_terminated(si, &error))
-				return error;
-		}
-		error = xfarray_sort_store(si, tmp, a);
-		if (error)
-			return error;
-
-		if (xfarray_sort_terminated(si, &error))
-			return error;
-	}
-
-	return 0;
+	xfarray_sort_bump_stores(si);
+	return xfile_obj_store(si->array->xfile, scratch, len, lo_pos);
 }
 
 /* Return a pointer to the xfarray pivot record within the sortinfo struct. */
@@ -783,9 +696,8 @@ xfarray_qsort_push(
  *    current stack frame.  This guarantees that we won't need more than
  *    log2(nr) stack space.
  *
- * 4. Use insertion sort for small sets since since insertion sort is faster
- *    for small, mostly sorted array segments.  In the author's experience,
- *    substituting insertion sort for arrays smaller than 8 elements yields
+ * 4. For small sets, load the records into the scratchpad and run heapsort on
+ *    them because that is very fast.  In the author's experience, this yields
  *    a ~10% reduction in runtime.
  */
 
diff --git a/fs/xfs/scrub/xfarray.h b/fs/xfs/scrub/xfarray.h
index 86c09897a4126..3661c98272cd5 100644
--- a/fs/xfs/scrub/xfarray.h
+++ b/fs/xfs/scrub/xfarray.h
@@ -58,6 +58,10 @@ int xfarray_load_next(struct xfarray *array, xfarray_idx_t *idx, void *rec);
 
 typedef cmp_func_t xfarray_cmp_fn;
 
+/* Perform an in-memory heapsort for small subsets. */
+#define XFARRAY_ISORT_SHIFT		(4)
+#define XFARRAY_ISORT_NR		(1U << XFARRAY_ISORT_SHIFT)
+
 struct xfarray_sortinfo {
 	struct xfarray		*array;
 
@@ -81,6 +85,7 @@ struct xfarray_sortinfo {
 	uint64_t		loads;
 	uint64_t		stores;
 	uint64_t		compares;
+	uint64_t		heapsorts;
 #endif
 
 	/*
@@ -99,11 +104,10 @@ struct xfarray_sortinfo {
 	 *
 	 * union {
 	 *
-	 * If for a given subset we decide to use an insertion sort, we use the
-	 * scratchpad record after the xfarray and a second scratchpad record
-	 * here to compare items:
+	 * If for a given subset we decide to use an in-memory sort, we use a
+	 * block of scratchpad records here to compare items:
 	 *
-	 * 	xfarray_rec_t	scratch;
+	 * 	xfarray_rec_t	scratch[ISORT_NR];
 	 *
 	 * Otherwise, we want to partition the records to partition the array.
 	 * We store the chosen pivot record here and use the xfarray scratchpad

