Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A832D659E2E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 31 Dec 2022 00:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235774AbiL3XZx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Dec 2022 18:25:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235744AbiL3XZc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Dec 2022 18:25:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D858C1D0FE;
        Fri, 30 Dec 2022 15:25:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71DCE61C2C;
        Fri, 30 Dec 2022 23:25:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C573EC433D2;
        Fri, 30 Dec 2022 23:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672442730;
        bh=ZD0LIFPwHja5CwRYZugLmWB/Gc4sOpHp2DuGLCulqEQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=G9wPi47w89i19uSSeCLxbbkxdYYHhBUTCt0pI3RK8Si8VEbntr25D7UpXLIiq/5VG
         jMY+8Z/HI3thkR2GAefTTWv8RUY7Vpb4JULUoHvPtOGN2Jb/pBkTtHsPDoty7TwXRa
         IE9vSIU0BuDOYwyYCKCGt9BxRA7WokbSF0X4BYY+sV3Koofv5s8RkJB3U7kR3HPfW+
         kveyLY43CROV5jTZrEizZb6+A05fm8oTm4NJoQxixcQ2G94q+9mILj8jJuKF547vIo
         1WJ+uvribvzJK8Rb2rmNgaaxbruXRDesyxwccsBMkKTAWsUhsFE/jSBCuj6qU1SnfS
         um0YlmZl3hckg==
Subject: [PATCH 6/7] xfs: cache pages used for xfarray quicksort convergence
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Dec 2022 14:12:35 -0800
Message-ID: <167243835573.692498.3498415520081743126.stgit@magnolia>
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

After quicksort picks a pivot item for a particular subsort, it walks
the records in that subset from the outside in, rearranging them so that
every record less than the pivot comes before it, and every record
greater than the pivot comes after it.  This scan has a lot of locality,
so we can speed it up quite a bit by grabbing the xfile backing page and
holding onto it as long as we possibly can.  Doing so reduces the
runtime by another 5% on the author's computer.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 fs/xfs/scrub/xfarray.c |   86 ++++++++++++++++++++++++++++++++++++++++++------
 fs/xfs/scrub/xfile.h   |   10 ++++++
 2 files changed, 86 insertions(+), 10 deletions(-)


diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index 08479be07fda..3e232ee5e7e6 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -760,6 +760,66 @@ xfarray_qsort_push(
 	return 0;
 }
 
+/*
+ * Load an element from the array into the first scratchpad and cache the page,
+ * if possible.
+ */
+static inline int
+xfarray_sort_load_cached(
+	struct xfarray_sortinfo	*si,
+	xfarray_idx_t		idx,
+	void			*ptr)
+{
+	loff_t			idx_pos = xfarray_pos(si->array, idx);
+	pgoff_t			startpage;
+	pgoff_t			endpage;
+	int			error = 0;
+
+	/*
+	 * If this load would split a page, release the cached page, if any,
+	 * and perform a traditional read.
+	 */
+	startpage = idx_pos >> PAGE_SHIFT;
+	endpage = (idx_pos + si->array->obj_size - 1) >> PAGE_SHIFT;
+	if (startpage != endpage) {
+		error = xfarray_sort_put_page(si);
+		if (error)
+			return error;
+
+		if (xfarray_sort_terminated(si, &error))
+			return error;
+
+		return xfile_obj_load(si->array->xfile, ptr,
+				si->array->obj_size, idx_pos);
+	}
+
+	/* If the cached page is not the one we want, release it. */
+	if (xfile_page_cached(&si->xfpage) &&
+	    xfile_page_index(&si->xfpage) != startpage) {
+		error = xfarray_sort_put_page(si);
+		if (error)
+			return error;
+	}
+
+	/*
+	 * If we don't have a cached page (and we know the load is contained
+	 * in a single page) then grab it.
+	 */
+	if (!xfile_page_cached(&si->xfpage)) {
+		if (xfarray_sort_terminated(si, &error))
+			return error;
+
+		error = xfarray_sort_get_page(si, startpage << PAGE_SHIFT,
+				PAGE_SIZE);
+		if (error)
+			return error;
+	}
+
+	memcpy(ptr, si->page_kaddr + offset_in_page(idx_pos),
+			si->array->obj_size);
+	return 0;
+}
+
 /*
  * Sort the array elements via quicksort.  This implementation incorporates
  * four optimizations discussed in Sedgewick:
@@ -785,6 +845,10 @@ xfarray_qsort_push(
  *    If a small set is contained entirely within a single xfile memory page,
  *    map the page directly and run heap sort directly on the xfile page
  *    instead of using the load/store interface.  This halves the runtime.
+ *
+ * 5. This optimization is specific to the implementation.  When converging lo
+ *    and hi after selecting a pivot, we will try to retain the xfile memory
+ *    page between load calls, which reduces run time by 50%.
  */
 
 /*
@@ -866,19 +930,20 @@ xfarray_sort(
 			 * Decrement hi until it finds an a[hi] less than the
 			 * pivot value.
 			 */
-			error = xfarray_sort_load(si, hi, scratch);
+			error = xfarray_sort_load_cached(si, hi, scratch);
 			if (error)
 				goto out_free;
 			while (xfarray_sort_cmp(si, scratch, pivot) >= 0 &&
 								lo < hi) {
-				if (xfarray_sort_terminated(si, &error))
-					goto out_free;
-
 				hi--;
-				error = xfarray_sort_load(si, hi, scratch);
+				error = xfarray_sort_load_cached(si, hi,
+						scratch);
 				if (error)
 					goto out_free;
 			}
+			error = xfarray_sort_put_page(si);
+			if (error)
+				goto out_free;
 
 			if (xfarray_sort_terminated(si, &error))
 				goto out_free;
@@ -894,19 +959,20 @@ xfarray_sort(
 			 * Increment lo until it finds an a[lo] greater than
 			 * the pivot value.
 			 */
-			error = xfarray_sort_load(si, lo, scratch);
+			error = xfarray_sort_load_cached(si, lo, scratch);
 			if (error)
 				goto out_free;
 			while (xfarray_sort_cmp(si, scratch, pivot) <= 0 &&
 								lo < hi) {
-				if (xfarray_sort_terminated(si, &error))
-					goto out_free;
-
 				lo++;
-				error = xfarray_sort_load(si, lo, scratch);
+				error = xfarray_sort_load_cached(si, lo,
+						scratch);
 				if (error)
 					goto out_free;
 			}
+			error = xfarray_sort_put_page(si);
+			if (error)
+				goto out_free;
 
 			if (xfarray_sort_terminated(si, &error))
 				goto out_free;
diff --git a/fs/xfs/scrub/xfile.h b/fs/xfs/scrub/xfile.h
index e34ab9c4aad9..0172bd9eeab0 100644
--- a/fs/xfs/scrub/xfile.h
+++ b/fs/xfs/scrub/xfile.h
@@ -12,6 +12,16 @@ struct xfile_page {
 	loff_t			pos;
 };
 
+static inline bool xfile_page_cached(const struct xfile_page *xfpage)
+{
+	return xfpage->page != NULL;
+}
+
+static inline pgoff_t xfile_page_index(const struct xfile_page *xfpage)
+{
+	return xfpage->page->index;
+}
+
 struct xfile {
 	struct file		*file;
 };

