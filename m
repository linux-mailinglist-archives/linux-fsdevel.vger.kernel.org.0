Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29699659E38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiL3X0W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235761AbiL3XZt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:25:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F45512AA6;
        Fri, 30 Dec 2022 15:25:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F060761C40;
        Fri, 30 Dec 2022 23:25:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57987C433EF;
        Fri, 30 Dec 2022 23:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672442746;
        bh=jw2iorKGf8ZJXz7ctY+p1Go980NywIcOIwg5tKE8gD4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Kj/nwvTrRGvy2psCBirNni6hWcawJqdOx2aUzwN3x27N9QmZ38ZqY2m+PE/XD+z+x
         8vzsqu7Eh/+ISK7qFEJRgusFs8itsikhbCfp9ZaLRc7u+jpXXltRRWmLMYRuzQXyeB
         V4aqAcdmLL2tCRiHwkEv5s20yIW4VtFT0Djm/0mP5EvjyCuqpIdx0tZqFJ6Mj7Tubi
         yRwJDCwXKMGNWDDCNmWZSL3UnzBW2ml3u5KNzIpYFbbEGJB2OJQtC+zlvIG7hJBKTZ
         qNCiJgtk3mzkuy6UUPzx2IYS3WxxGX/6+n9pb8V6Qj8BMTGpt+V3rDBKXtIFvn9v/c
         Cy//uD0o1WqXQ==
Subject: [PATCH 7/7] xfs: improve xfarray quicksort pivot
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:12:35 -0800
Message-ID: <167243835587.692498.4752204565816305502.stgit@magnolia>
In-Reply-To: <167243835481.692498.14657125042725378987.stgit@magnolia>
References: <167243835481.692498.14657125042725378987.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <djwong@kernel.org>

Now that we have the means to do insertion sorts of small in-memory
subsets of an xfarray, use it to improve the quicksort pivot algorithm
by reading 7 records into memory and finding the median of that.  This
should prevent bad partitioning when a[lo] and a[hi] end up next to each
other in the final sort, which can happen when sorting for cntbt repair
when the free space is extremely fragmented (e.g. generic/176).

This doesn't speed up the average quicksort run by much, but it will
(hopefully) avoid the quadratic time collapse for which quicksort is
famous.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/xfarray.c |  198 ++++++++++++++++++++++++++++++++----------------
 fs/xfs/scrub/xfarray.h |   19 +++--
 2 files changed, 148 insertions(+), 69 deletions(-)


diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index 3e232ee5e7e6..ce1365144209 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -428,6 +428,14 @@ static inline xfarray_idx_t *xfarray_sortinfo_hi(struct xfarray_sortinfo *si)
 	return xfarray_sortinfo_lo(si) + si->max_stack_depth;
 }
 
+/* Size of each element in the quicksort pivot array. */
+static inline size_t
+xfarray_pivot_rec_sz(
+	struct xfarray		*array)
+{
+	return round_up(array->obj_size, 8) + sizeof(xfarray_idx_t);
+}
+
 /* Allocate memory to handle the sort. */
 static inline int
 xfarray_sortinfo_alloc(
@@ -438,8 +446,16 @@ xfarray_sortinfo_alloc(
 {
 	struct xfarray_sortinfo	*si;
 	size_t			nr_bytes = sizeof(struct xfarray_sortinfo);
+	size_t			pivot_rec_sz = xfarray_pivot_rec_sz(array);
 	int			max_stack_depth;
 
+	/*
+	 * The median-of-nine pivot algorithm doesn't work if a subset has
+	 * fewer than 9 items.  Make sure the in-memory sort will always take
+	 * over for subsets where this wouldn't be the case.
+	 */
+	BUILD_BUG_ON(XFARRAY_QSORT_PIVOT_NR >= XFARRAY_ISORT_NR);
+
 	/*
 	 * Tail-call recursion during the partitioning phase means that
 	 * quicksort will never recurse more than log2(nr) times.  We need one
@@ -454,8 +470,10 @@ xfarray_sortinfo_alloc(
 	/* Each level of quicksort uses a lo and a hi index */
 	nr_bytes += max_stack_depth * sizeof(xfarray_idx_t) * 2;
 
-	/* Scratchpad for in-memory sort, or one record for the pivot */
-	nr_bytes += (XFARRAY_ISORT_NR * array->obj_size);
+	/* Scratchpad for in-memory sort, or finding the pivot */
+	nr_bytes += max_t(size_t,
+			(XFARRAY_QSORT_PIVOT_NR + 1) * pivot_rec_sz,
+			XFARRAY_ISORT_NR * array->obj_size);
 
 	si = kvzalloc(nr_bytes, XCHK_GFP_FLAGS);
 	if (!si)
@@ -633,14 +651,43 @@ static inline void *xfarray_sortinfo_pivot(struct xfarray_sortinfo *si)
 	return xfarray_sortinfo_hi(si) + si->max_stack_depth;
 }
 
+/* Return a pointer to the start of the pivot array. */
+static inline void *
+xfarray_sortinfo_pivot_array(
+	struct xfarray_sortinfo	*si)
+{
+	return xfarray_sortinfo_pivot(si) + si->array->obj_size;
+}
+
+/* The xfarray record is stored at the start of each pivot array element. */
+static inline void *
+xfarray_pivot_array_rec(
+	void			*pa,
+	size_t			pa_recsz,
+	unsigned int		pa_idx)
+{
+	return pa + (pa_recsz * pa_idx);
+}
+
+/* The xfarray index is stored at the end of each pivot array element. */
+static inline xfarray_idx_t *
+xfarray_pivot_array_idx(
+	void			*pa,
+	size_t			pa_recsz,
+	unsigned int		pa_idx)
+{
+	return xfarray_pivot_array_rec(pa, pa_recsz, pa_idx + 1) -
+			sizeof(xfarray_idx_t);
+}
+
 /*
  * Find a pivot value for quicksort partitioning, swap it with a[lo], and save
  * the cached pivot record for the next step.
  *
- * Select the median value from a[lo], a[mid], and a[hi].  Put the median in
- * a[lo], the lowest in a[mid], and the highest in a[hi].  Using the median of
- * the three reduces the chances that we pick the worst case pivot value, since
- * it's likely that our array values are nearly sorted.
+ * Load evenly-spaced records within the given range into memory, sort them,
+ * and choose the pivot from the median record.  Using multiple points will
+ * improve the quality of the pivot selection, and hopefully avoid the worst
+ * quicksort behavior, since our array values are nearly always evenly sorted.
  */
 STATIC int
 xfarray_qsort_pivot(
@@ -648,76 +695,99 @@ xfarray_qsort_pivot(
 	xfarray_idx_t		lo,
 	xfarray_idx_t		hi)
 {
-	void			*a = xfarray_sortinfo_pivot(si);
-	void			*b = xfarray_scratch(si->array);
-	xfarray_idx_t		mid = lo + ((hi - lo) / 2);
+	void			*pivot = xfarray_sortinfo_pivot(si);
+	void			*parray = xfarray_sortinfo_pivot_array(si);
+	void			*recp;
+	xfarray_idx_t		*idxp;
+	xfarray_idx_t		step = (hi - lo) / (XFARRAY_QSORT_PIVOT_NR - 1);
+	size_t			pivot_rec_sz = xfarray_pivot_rec_sz(si->array);
+	int			i, j;
 	int			error;
 
-	/* if a[mid] < a[lo], swap a[mid] and a[lo]. */
-	error = xfarray_sort_load(si, mid, a);
-	if (error)
-		return error;
-	error = xfarray_sort_load(si, lo, b);
-	if (error)
-		return error;
-	if (xfarray_sort_cmp(si, a, b) < 0) {
-		error = xfarray_sort_store(si, lo, a);
-		if (error)
-			return error;
-		error = xfarray_sort_store(si, mid, b);
-		if (error)
-			return error;
-	}
+	ASSERT(step > 0);
 
-	/* if a[hi] < a[mid], swap a[mid] and a[hi]. */
-	error = xfarray_sort_load(si, hi, a);
-	if (error)
-		return error;
-	error = xfarray_sort_load(si, mid, b);
-	if (error)
-		return error;
-	if (xfarray_sort_cmp(si, a, b) < 0) {
-		error = xfarray_sort_store(si, mid, a);
-		if (error)
-			return error;
-		error = xfarray_sort_store(si, hi, b);
-		if (error)
-			return error;
-	} else {
-		goto move_front;
+	/*
+	 * Load the xfarray indexes of the records we intend to sample into the
+	 * pivot array.
+	 */
+	idxp = xfarray_pivot_array_idx(parray, pivot_rec_sz, 0);
+	*idxp = lo;
+	for (i = 1; i < XFARRAY_QSORT_PIVOT_NR - 1; i++) {
+		idxp = xfarray_pivot_array_idx(parray, pivot_rec_sz, i);
+		*idxp = lo + (i * step);
 	}
+	idxp = xfarray_pivot_array_idx(parray, pivot_rec_sz,
+			XFARRAY_QSORT_PIVOT_NR - 1);
+	*idxp = hi;
 
-	/* if a[mid] < a[lo], swap a[mid] and a[lo]. */
-	error = xfarray_sort_load(si, mid, a);
-	if (error)
-		return error;
-	error = xfarray_sort_load(si, lo, b);
-	if (error)
-		return error;
-	if (xfarray_sort_cmp(si, a, b) < 0) {
-		error = xfarray_sort_store(si, lo, a);
-		if (error)
-			return error;
-		error = xfarray_sort_store(si, mid, b);
+	/* Load the selected xfarray records into the pivot array. */
+	for (i = 0; i < XFARRAY_QSORT_PIVOT_NR; i++) {
+		xfarray_idx_t	idx;
+
+		recp = xfarray_pivot_array_rec(parray, pivot_rec_sz, i);
+		idxp = xfarray_pivot_array_idx(parray, pivot_rec_sz, i);
+
+		/* No unset records; load directly into the array. */
+		if (likely(si->array->unset_slots == 0)) {
+			error = xfarray_sort_load(si, *idxp, recp);
+			if (error)
+				return error;
+			continue;
+		}
+
+		/*
+		 * Load non-null records into the scratchpad without changing
+		 * the xfarray_idx_t in the pivot array.
+		 */
+		idx = *idxp;
+		xfarray_sort_bump_loads(si);
+		error = xfarray_load_next(si->array, &idx, recp);
 		if (error)
 			return error;
 	}
 
-move_front:
+	xfarray_sort_bump_heapsorts(si);
+	sort(parray, XFARRAY_QSORT_PIVOT_NR, pivot_rec_sz, si->cmp_fn, NULL);
+
 	/*
-	 * Move our selected pivot to a[lo].  Recall that a == si->pivot, so
-	 * this leaves us with the pivot cached in the sortinfo structure.
+	 * We sorted the pivot array records (which includes the xfarray
+	 * indices) in xfarray record order.  The median element of the pivot
+	 * array contains the xfarray record that we will use as the pivot.
+	 * Copy that xfarray record to the designated space.
 	 */
-	error = xfarray_sort_load(si, lo, b);
-	if (error)
-		return error;
-	error = xfarray_sort_load(si, mid, a);
-	if (error)
-		return error;
-	error = xfarray_sort_store(si, mid, b);
+	recp = xfarray_pivot_array_rec(parray, pivot_rec_sz,
+			XFARRAY_QSORT_PIVOT_NR / 2);
+	memcpy(pivot, recp, si->array->obj_size);
+
+	/* If the pivot record we chose was already in a[lo] then we're done. */
+	idxp = xfarray_pivot_array_idx(parray, pivot_rec_sz,
+			XFARRAY_QSORT_PIVOT_NR / 2);
+	if (*idxp == lo)
+		return 0;
+
+	/*
+	 * Find the cached copy of a[lo] in the pivot array so that we can swap
+	 * a[lo] and a[pivot].
+	 */
+	for (i = 0, j = -1; i < XFARRAY_QSORT_PIVOT_NR; i++) {
+		idxp = xfarray_pivot_array_idx(parray, pivot_rec_sz, i);
+		if (*idxp == lo)
+			j = i;
+	}
+	if (j < 0) {
+		ASSERT(j >= 0);
+		return -EFSCORRUPTED;
+	}
+
+	/* Swap a[lo] and a[pivot]. */
+	error = xfarray_sort_store(si, lo, pivot);
 	if (error)
 		return error;
-	return xfarray_sort_store(si, lo, a);
+
+	recp = xfarray_pivot_array_rec(parray, pivot_rec_sz, j);
+	idxp = xfarray_pivot_array_idx(parray, pivot_rec_sz,
+			XFARRAY_QSORT_PIVOT_NR / 2);
+	return xfarray_sort_store(si, *idxp, recp);
 }
 
 /*
@@ -829,7 +899,7 @@ xfarray_sort_load_cached(
  *    particularly expensive in the kernel.
  *
  * 2. For arrays with records in arbitrary or user-controlled order, choose the
- *    pivot element using a median-of-three decision tree.  This reduces the
+ *    pivot element using a median-of-nine decision tree.  This reduces the
  *    probability of selecting a bad pivot value which causes worst case
  *    behavior (i.e. partition sizes of 1).
  *
diff --git a/fs/xfs/scrub/xfarray.h b/fs/xfs/scrub/xfarray.h
index e8a4523bf2de..69f0c922c98a 100644
--- a/fs/xfs/scrub/xfarray.h
+++ b/fs/xfs/scrub/xfarray.h
@@ -63,6 +63,9 @@ typedef cmp_func_t xfarray_cmp_fn;
 #define XFARRAY_ISORT_SHIFT		(4)
 #define XFARRAY_ISORT_NR		(1U << XFARRAY_ISORT_SHIFT)
 
+/* Evalulate this many points to find the qsort pivot. */
+#define XFARRAY_QSORT_PIVOT_NR		(9)
+
 struct xfarray_sortinfo {
 	struct xfarray		*array;
 
@@ -92,7 +95,6 @@ struct xfarray_sortinfo {
 	uint64_t		compares;
 	uint64_t		heapsorts;
 #endif
-
 	/*
 	 * Extra bytes are allocated beyond the end of the structure to store
 	 * quicksort information.  C does not permit multiple VLAs per struct,
@@ -115,11 +117,18 @@ struct xfarray_sortinfo {
 	 * 	xfarray_rec_t	scratch[ISORT_NR];
 	 *
 	 * Otherwise, we want to partition the records to partition the array.
-	 * We store the chosen pivot record here and use the xfarray scratchpad
-	 * to rearrange the array around the pivot:
-	 *
-	 * 	xfarray_rec_t	pivot;
+	 * We store the chosen pivot record at the start of the scratchpad area
+	 * and use the rest to sample some records to estimate the median.
+	 * The format of the qsort_pivot array enables us to use the kernel
+	 * heapsort function to place the median value in the middle.
 	 *
+	 * 	struct {
+	 * 		xfarray_rec_t	pivot;
+	 * 		struct {
+	 *			xfarray_rec_t	rec;  (rounded up to 8 bytes)
+	 * 			xfarray_idx_t	idx;
+	 *		} qsort_pivot[QSORT_PIVOT_NR];
+	 * 	};
 	 * }
 	 */
 };

