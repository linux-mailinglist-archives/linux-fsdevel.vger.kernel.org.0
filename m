Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4668711BA0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 02:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjEZAsb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 20:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231344AbjEZAs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 20:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A824912E;
        Thu, 25 May 2023 17:48:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3815261A5C;
        Fri, 26 May 2023 00:48:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DE31C433EF;
        Fri, 26 May 2023 00:48:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685062107;
        bh=gDJChdO4lLzlfsvfXR/2OoKnv0TQP2W9CdJC+cvGd10=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=tEH1jV7SKV8wA4Uf9QgWnIxVmLSh17LiwvLr/rkoaTJKSTJ1wea8ZB/PSS3/N5fqS
         jJLR4fgxYEF1TZY4GJ0RoO8ZAHmFFS5CBu3pVwOaNLlWx9fCGutrDgrJQ0AftxG0bu
         2VDvTNEOKbZOc5EtkPeuFqMrtRj0PRnWF1xfksfHL+nyXX72MXrfbm4/LnhYUCMOrd
         N2wtNp4M0qvwdbNPdk4h7NbSH1LZTrXDScxcDzwPuLgjzRZZQerI5LtfoWXAHqD+L5
         ns9F2POMi6YWfv008nqU5GiBNhyaOSIr3nHgbJKUsEMgijL4tx6PFhOVefYxmCUPSu
         2PuFX+EK9csrA==
Date:   Thu, 25 May 2023 17:48:27 -0700
Subject: [PATCH 6/7] xfs: cache pages used for xfarray quicksort convergence
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        linux-xfs@vger.kernel.org, willy@infradead.org,
        linux-fsdevel@vger.kernel.org
Message-ID: <168506056541.3729324.17926871235505185426.stgit@frogsfrogsfrogs>
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

After quicksort picks a pivot item for a particular subsort, it walks
the records in that subset from the outside in, rearranging them so that
every record less than the pivot comes before it, and every record
greater than the pivot comes after it.  This scan has a lot of locality,
so we can speed it up quite a bit by grabbing the xfile backing page and
holding onto it as long as we possibly can.  Doing so reduces the
runtime by another 5% on the author's computer.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 fs/xfs/scrub/xfarray.c |   86 ++++++++++++++++++++++++++++++++++++++++++------
 fs/xfs/scrub/xfile.h   |   10 ++++++
 2 files changed, 86 insertions(+), 10 deletions(-)


diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index df042fa016e8..443ef9be151b 100644
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
index d08a202f3882..1aae2cd91720 100644
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

