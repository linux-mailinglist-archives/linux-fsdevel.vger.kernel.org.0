Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B67659E2F
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbiL3XZw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiL3XZR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:25:17 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217DB1DDD3;
        Fri, 30 Dec 2022 15:25:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B149E61C0D;
        Fri, 30 Dec 2022 23:25:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19E60C433EF;
        Fri, 30 Dec 2022 23:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672442715;
        bh=yr/19mIKu0tHF8R9GcuDzQDVRQVMjwRQP/5oSYuAfcA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Mg0jdYmzX5QJot9po+u0KWBXKXWgvzORnXq2K/YDJ2p/MvYBSlH2QlKywJ6qTlx82
         GY0xvCcD40kOh8gB6mJ5E7CAV3GuV9F1gfPylLsFH2dqeJzl39YGOWgKpkFEeSOY1C
         pzuytrzWY2eva6IWv1Rzln6NDzPdpglLIH5O9YhTf/AyqE8PoYz72Yp1aaUyq9laN8
         YCm8Jbl77icNnNkvSBTj8ZAEopBrwmCS2hPjpSogyFVjIkj8m6j+yo9sCpr7/ansDo
         cYddZp5VpLdv7yHPyEABK/uOtJw6QiQx5oqoO4JG2lzUexPi62j3oPna0vYNmw2CCP
         e4SgLexDJf+7w==
Subject: [PATCH 5/7] xfs: speed up xfarray sort by sorting xfile page contents
 directly
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:12:35 -0800
Message-ID: <167243835559.692498.7669553320803282373.stgit@magnolia>
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

If all the records in an xfarray subset live within the same memory
page, we can short-circuit even more quicksort recursion by mapping that
page into the local CPU and using the kernel's heapsort function to sort
the subset.  On the author's computer, this reduces the runtime by
another 15% on a 500,000 element array.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/trace.h   |   20 ++++++++++
 fs/xfs/scrub/xfarray.c |   97 ++++++++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/scrub/xfarray.h |    4 ++
 3 files changed, 121 insertions(+)


diff --git a/fs/xfs/scrub/trace.h b/fs/xfs/scrub/trace.h
index 79b844c969df..2431083b9f91 100644
--- a/fs/xfs/scrub/trace.h
+++ b/fs/xfs/scrub/trace.h
@@ -872,6 +872,26 @@ TRACE_EVENT(xfarray_isort,
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
index 171c40d04e6c..08479be07fda 100644
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
index f49c1afe24a1..e8a4523bf2de 100644
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

