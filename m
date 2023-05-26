Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4B1711B9E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbjEZAsQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234550AbjEZAsO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:48:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A82712E;
        Thu, 25 May 2023 17:48:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8DA8763A6B;
        Fri, 26 May 2023 00:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC6EC433D2;
        Fri, 26 May 2023 00:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685062092;
        bh=ieil9oDICYP49sNwYl1fbl8wErWSNYbCITxFoEMO48Y=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=ruYupq20AMbwABwcuKM8Td0QkYwAYuZZiV9riMx8Yo2BbTcz2qj2DZQo54bX1I92q
         aB9kO2fHbx51wizYvCI7iLj9FQRx//sDY1Gm++sb4F32/S1vfPYhPysJvj3dd0rmWs
         jOhhP7zrNVZc8bwJcKddhIemw0nTr+fgnfnn8TrXgx5Xt07PtnQnZjyLIVZhW/a2O0
         TyrztGxcKv0piyL3jddv+4xtT1eQ/rAbGC7BQvQnB4naKq+VN+Ns0xujiW4gn9BIQy
         wN32cp+i81KNYXwd1PH5D07ncbHIo27RNqADhvpwrcOu9gpm6dccUBvRON6ByZ4L9c
         MuORIwK4QtQRA==
Date:   Thu, 25 May 2023 17:48:11 -0700
Subject: [PATCH 5/7] xfs: speed up xfarray sort by sorting xfile page contents
 directly
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506056526.3729324.16909610222042340263.stgit@frogsfrogsfrogs>
In-Reply-To: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
References: <168506056447.3729324.13624212283929857624.stgit@frogsfrogsfrogs>
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

If all the records in an xfarray subset live within the same memory
page, we can short-circuit even more quicksort recursion by mapping that
page into the local CPU and using the kernel's heapsort function to sort
the subset.  On the author's computer, this reduces the runtime by
another 15% on a 500,000 element array.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/xfs/scrub/trace.h   |   20 ++++++++++
 fs/xfs/scrub/xfarray.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfarray.h |    4 ++
 3 files changed, 121 insertions(+)


diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index cf210681d028..faefcc37fff4 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -871,6 +871,26 @@ TRACE_EVENT(xfarray_isort,
 		  __entry->hi - __entry->lo)
 );
 
+TRACE_EVENT(xfarray_pagesort,
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
 TRACE_EVENT(xfarray_qsort,
 	TP_PROTO(struct xfarray_sortinfo *si, uint64_t lo, uint64_t hi),
 	TP_ARGS(si, lo, hi),
diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index ea995054412c..df042fa016e8 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -546,6 +546,87 @@ xfarray_isort(
 	return xfile_obj_store(si->array->xfile, scratch, len, lo_pos);
 }
 
+/* Grab a page for sorting records. */
+static inline int
+xfarray_sort_get_page(
+	struct xfarray_sortinfo	*si,
+	loff_t			pos,
+	uint64_t		len)
+{
+	int			error;
+
+	error = xfile_get_page(si->array->xfile, pos, len, &si->xfpage);
+	if (error)
+		return error;
+
+	/*
+	 * xfile pages must never be mapped into userspace, so we skip the
+	 * dcache flush when mapping the page.
+	 */
+	si->page_kaddr = kmap_local_page(si->xfpage.page);
+	return 0;
+}
+
+/* Release a page we grabbed for sorting records. */
+static inline int
+xfarray_sort_put_page(
+	struct xfarray_sortinfo	*si)
+{
+	if (!si->page_kaddr)
+		return 0;
+
+	kunmap_local(si->page_kaddr);
+	si->page_kaddr = NULL;
+
+	return xfile_put_page(si->array->xfile, &si->xfpage);
+}
+
+/* Decide if these records are eligible for in-page sorting. */
+static inline bool
+xfarray_want_pagesort(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		lo,
+	xfarray_idx_t		hi)
+{
+	pgoff_t			lo_page;
+	pgoff_t			hi_page;
+	loff_t			end_pos;
+
+	/* We can only map one page at a time. */
+	lo_page = xfarray_pos(si->array, lo) >> PAGE_SHIFT;
+	end_pos = xfarray_pos(si->array, hi) + si->array->obj_size - 1;
+	hi_page = end_pos >> PAGE_SHIFT;
+
+	return lo_page == hi_page;
+}
+
+/* Sort a bunch of records that all live in the same memory page. */
+STATIC int
+xfarray_pagesort(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		lo,
+	xfarray_idx_t		hi)
+{
+	void			*startp;
+	loff_t			lo_pos = xfarray_pos(si->array, lo);
+	uint64_t		len = xfarray_pos(si->array, hi - lo);
+	int			error = 0;
+
+	trace_xfarray_pagesort(si, lo, hi);
+
+	xfarray_sort_bump_loads(si);
+	error = xfarray_sort_get_page(si, lo_pos, len);
+	if (error)
+		return error;
+
+	xfarray_sort_bump_heapsorts(si);
+	startp = si->page_kaddr + offset_in_page(lo_pos);
+	sort(startp, hi - lo + 1, si->array->obj_size, si->cmp_fn, NULL);
+
+	xfarray_sort_bump_stores(si);
+	return xfarray_sort_put_page(si);
+}
+
 /* Return a pointer to the xfarray pivot record within the sortinfo struct. */
 static inline void *xfarray_sortinfo_pivot(struct xfarray_sortinfo *si)
 {
@@ -700,6 +781,10 @@ xfarray_qsort_push(
  * 4. For small sets, load the records into the scratchpad and run heapsort on
  *    them because that is very fast.  In the author's experience, this yields
  *    a ~10% reduction in runtime.
+ *
+ *    If a small set is contained entirely within a single xfile memory page,
+ *    map the page directly and run heap sort directly on the xfile page
+ *    instead of using the load/store interface.  This halves the runtime.
  */
 
 /*
@@ -745,6 +830,18 @@ xfarray_sort(
 			continue;
 		}
 
+		/*
+		 * If directly mapping the page and sorting can solve our
+		 * problems, we're done.
+		 */
+		if (xfarray_want_pagesort(si, lo, hi)) {
+			error = xfarray_pagesort(si, lo, hi);
+			if (error)
+				goto out_free;
+			si->stack_depth--;
+			continue;
+		}
+
 		/* If insertion sort can solve our problems, we're done. */
 		if (xfarray_want_isort(si, lo, hi)) {
 			error = xfarray_isort(si, lo, hi);
diff --git a/fs/xfs/scrub/xfarray.h b/fs/xfs/scrub/xfarray.h
index a58ce3294ded..e7e88350a80e 100644
--- a/fs/xfs/scrub/xfarray.h
+++ b/fs/xfs/scrub/xfarray.h
@@ -81,6 +81,10 @@ struct xfarray_sortinfo {
 	/* XFARRAY_SORT_* flags; see below. */
 	unsigned int		flags;
 
+	/* Cache a page here for faster access. */
+	struct xfile_page	xfpage;
+	void			*page_kaddr;
+
 #ifdef DEBUG
 	/* Performance statistics. */
 	uint64_t		loads;

