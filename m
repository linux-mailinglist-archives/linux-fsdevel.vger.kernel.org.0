Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423DB765F64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jul 2023 00:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjG0W06 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Jul 2023 18:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbjG0W04 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Jul 2023 18:26:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01874F0;
        Thu, 27 Jul 2023 15:26:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8AC8F61F6F;
        Thu, 27 Jul 2023 22:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EBFC433C7;
        Thu, 27 Jul 2023 22:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690496814;
        bh=iyKDzi1d9HiWjC0nyfy4jd2ywHKCPd3hegieWOYEcWo=;
        h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
        b=D5f24kOzZtyqtuqmDbluesStLWyR9fZqCkQXN0xrld5CKzxLk6b5CzIH3gseb9EzQ
         esaxryHcibxVigELmgCzA6ijGLBy1IUL37dDY8y/Twkw5frtdP5hmIKI9fDmUFe5UE
         QS9QyKkk4YDQ87LD03ctuRdPUSaF2L5zYXJOEVylkL9KzaoUcZHfmUr4rFRBtXuSsm
         WAFICrjF/K+y+Ae9zbxgmKKbLtotqfGIPGDeN/k+6JlYfTnKHK8U5KCzIJcEGQXQ9n
         9/KryN+i7LHoPmYpP2bQL/1P7PIeGyfp9RjgwoV0XRqznpWPv9ZEpC9SR1/hQ0x+jM
         s8Rs6yTSL1Nmg==
Date:   Thu, 27 Jul 2023 15:26:53 -0700
Subject: [PATCH 6/7] xfs: cache pages used for xfarray quicksort convergence
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Dave Chinner <dchinner@redhat.com>, linux-xfs@vger.kernel.org,
        willy@infradead.org, linux-fsdevel@vger.kernel.org
Message-ID: <169049623658.921478.4088556264120415767.stgit@frogsfrogsfrogs>
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

After quicksort picks a pivot item for a particular subsort, it walks
the records in that subset from the outside in, rearranging them so that
every record less than the pivot comes before it, and every record
greater than the pivot comes after it.  This scan has a lot of locality,
so we can speed it up quite a bit by grabbing the xfile backing page and
holding onto it as long as we possibly can.  Doing so reduces the
runtime by another 5% on the author's computer.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: Kent Overstreet <kent.overstreet@linux.dev>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/scrub/xfarray.c |   86 ++++++++++++++++++++++++++++++++++++++++++------
 fs/xfs/scrub/xfile.h   |   10 ++++++
 2 files changed, 86 insertions(+), 10 deletions(-)


diff --git a/fs/xfs/scrub/xfarray.c b/fs/xfs/scrub/xfarray.c
index 457e56eac5e15..18cc734ab0f48 100644
--- a/fs/xfs/scrub/xfarray.c
+++ b/fs/xfs/scrub/xfarray.c
@@ -759,6 +759,66 @@ xfarray_qsort_push(
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
@@ -784,6 +844,10 @@ xfarray_qsort_push(
  *    If a small set is contained entirely within a single xfile memory page,
  *    map the page directly and run heap sort directly on the xfile page
  *    instead of using the load/store interface.  This halves the runtime.
+ *
+ * 5. This optimization is specific to the implementation.  When converging lo
+ *    and hi after selecting a pivot, we will try to retain the xfile memory
+ *    page between load calls, which reduces run time by 50%.
  */
 
 /*
@@ -865,19 +929,20 @@ xfarray_sort(
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
@@ -893,19 +958,20 @@ xfarray_sort(
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
index 7065abd97a9a9..d56643b0f429e 100644
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

