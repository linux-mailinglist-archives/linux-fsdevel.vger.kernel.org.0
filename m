Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7EF2B4134
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 11:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgKPKe6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 05:34:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgKPKe6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 05:34:58 -0500
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01DCDC0613CF
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 02:34:57 -0800 (PST)
Received: by mail-ot1-x342.google.com with SMTP id i18so15534886ots.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Nov 2020 02:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=gnzNZJCbGvWBJQBLWWKvWVBDFmXaiZo16OXXQRcefb4=;
        b=ECAzc0cF1JMrOieupkprbm3LSYVLWA1yrySH3kywqDxpohXSS/TNhfbxBAOg4As0vp
         HqACsCR4zwO/SBIRPfvdA5tHD7UgbqhwXJmRZz+H6EPm8nWLUcIuDdU5uwaQDpzHjpwf
         pFWPw3/u1JTZalRB56TXi5D3OdJxphufxHit8QdlRHr3CDFjgEuzdrUwMzJ4O4FpQQ+W
         ExtD4EsAztVly3JT5OE1HCYmwfuBzCxMC+KDraksNb1QTm0ieQqZKoR6SUVFf5TLi7ZH
         knrGjIQA5f2Z3E0B1cMJOyGPzUAabTF6LIPFxMcPpyX+wZIqpT4esgeuMa2pVQaJylCn
         cFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=gnzNZJCbGvWBJQBLWWKvWVBDFmXaiZo16OXXQRcefb4=;
        b=HDa7xzwOEg18bF4cokZW2mknIzr+K/ewgh8dpMvgtfaTlW2FQl+BqgFsv2z/DlnL9b
         C0iVgRFns8a49Dsx4cHOJAfGWHCjpfkw+F5hu98YnV1MudOowDVwkltqPi8djn4h2xOr
         SPiL6nOUlomxk3te5rOXjIEzzxRWoHya8gGJckA+DBPjE7ciL+KxNkpmsV4bAi+5c4lX
         RX+/uNZeGOmxtE7kocOPi553IlwBxUkCrxl8V5NavqnsF85DYasM+Y051DESEtce2PnU
         GxVtH5l8WQmW3mVbJH6WFqv8tHMIztb5jIAywjYYQs40IYsxWU2uQSbR7CcM2Po+79pZ
         wRiw==
X-Gm-Message-State: AOAM530FZuPZkvhCMyQdLW5V0rwvmkR7gYHHsoay0/H7wX3N8b3aDFJ0
        HUuESPcKBc9BHbjkOfQ6U1kmqg==
X-Google-Smtp-Source: ABdhPJzZtId/Zo5XZ3Fo4NcS/y/g+T7cJDOBP4akQW79ng3M1pyTojg4vrQbxtrIJTYUQ4N+n1DLoQ==
X-Received: by 2002:a9d:70c7:: with SMTP id w7mr10562118otj.110.1605522896826;
        Mon, 16 Nov 2020 02:34:56 -0800 (PST)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 66sm4513619otp.33.2020.11.16.02.34.54
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 16 Nov 2020 02:34:55 -0800 (PST)
Date:   Mon, 16 Nov 2020 02:34:34 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Andrew Morton <akpm@linux-foundation.org>, Jan Kara <jack@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        hughd@google.com, hch@lst.de, hannes@cmpxchg.org,
        yang.shi@linux.alibaba.com, dchinner@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/16] Overhaul multi-page lookups for THP
In-Reply-To: <20201112212641.27837-1-willy@infradead.org>
Message-ID: <alpine.LSU.2.11.2011160128001.1206@eggly.anvils>
References: <20201112212641.27837-1-willy@infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 12 Nov 2020, Matthew Wilcox (Oracle) wrote:

> This THP prep patchset changes several page cache iteration APIs to only
> return head pages.
> 
>  - It's only possible to tag head pages in the page cache, so only
>    return head pages, not all their subpages.
>  - Factor a lot of common code out of the various batch lookup routines
>  - Add mapping_seek_hole_data()
>  - Unify find_get_entries() and pagevec_lookup_entries()
>  - Make find_get_entries only return head pages, like find_get_entry().
> 
> These are only loosely connected, but they seem to make sense together
> as a series.
> 
> v4:
>  - Add FGP_ENTRY, remove find_get_entry and find_lock_entry
>  - Rename xas_find_get_entry to find_get_entry
>  - Add "Optimise get_shadow_from_swap_cache"
>  - Move "iomap: Use mapping_seek_hole_data" to this patch series
>  - Rebase against next-20201112

I hope next-20201112 had nothing vital for this series, I applied
it to v5.10-rc3, and have been busy testing huge tmpfs on that.

Several fixes necessary.  It was only a couple of hours ago that I
finally saw what was wrong in shmem_undo_range(), I'm tired now and
sending these off somewhat hastily, may have got something wrong, but
best to get them to you soonest, to rework and fold in as you see fit.
Please allow me to gather them here below, instead of replying to
individual patches.

Fix to [PATCH v4 06/16] mm/filemap: Add helper for finding pages.
I hit that VM_BUG_ON_PAGE(!thp_contains) when swapping, it is not
safe without page lock, during the interval when shmem is moving a
page between page cache and swap cache.  It could be tightened by
passing in a new FGP to distinguish whether searching page or swap
cache, but I think never tight enough in the swap case - because there
is no rule for persisting page->private as there is for page->index.
The best I could do is:

--- 5103w/mm/filemap.c	2020-11-12 15:46:23.191275470 -0800
+++ 5103wh/mm/filemap.c	2020-11-16 01:09:35.427677277 -0800
@@ -1858,7 +1858,20 @@ retry:
 		put_page(page);
 		goto reset;
 	}
-	VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index), page);
+
+#ifdef CONFIG_DEBUG_VM
+	/*
+	 * thp_contains() is unreliable when shmem is swizzling between page
+	 * and swap cache, when both PageSwapCache and page->mapping are set.
+	 */
+	if (!thp_contains(page, xas->xa_index)) {
+		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
+		if (trylock_page(page)) {
+			VM_BUG_ON_PAGE(!thp_contains(page, xas->xa_index), page);
+			unlock_page(page);
+		}
+	}
+#endif
 
 	return page;
 reset:

Fix to [PATCH v4 07/16] mm/filemap: Add mapping_seek_hole_data.
Crashed on a swap entry 0x2ff09, fairly obvious...

--- 5103w/mm/filemap.c	2020-11-12 15:46:23.191275470 -0800
+++ 5103wh/mm/filemap.c	2020-11-16 01:09:35.427677277 -0800
@@ -2632,7 +2632,8 @@ loff_t mapping_seek_hole_data(struct add
 				seek_data);
 		if (start < pos)
 			goto unlock;
-		put_page(page);
+		if (!xa_is_value(page))
+			put_page(page);
 	}
 	rcu_read_unlock();
 
Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
One machine ran fine, swapping and building in ext4 on loop0 on huge tmpfs;
one machine got occasional pages of zeros in its .os; one machine couldn't
get started because of ext4_find_dest_de errors on the newly mkfs'ed fs.
The partial_end case was decided by PAGE_SIZE, when there might be a THP
there.  The below patch has run well (for not very long), but I could
easily have got it slightly wrong, off-by-one or whatever; and I have
not looked into the similar code in mm/truncate.c, maybe that will need
a similar fix or maybe not.

--- 5103w/mm/shmem.c	2020-11-12 15:46:21.075254036 -0800
+++ 5103wh/mm/shmem.c	2020-11-16 01:09:35.431677308 -0800
@@ -874,7 +874,7 @@ static void shmem_undo_range(struct inod
 	long nr_swaps_freed = 0;
 	pgoff_t index;
 	int i;
-	bool partial_end;
+	bool same_page;
 
 	if (lend == -1)
 		end = -1;	/* unsigned, so actually very big */
@@ -907,16 +907,12 @@ static void shmem_undo_range(struct inod
 		index++;
 	}
 
-	partial_end = ((lend + 1) % PAGE_SIZE) > 0;
+	same_page = (lstart >> PAGE_SHIFT) == end;
 	page = NULL;
 	shmem_getpage(inode, lstart >> PAGE_SHIFT, &page, SGP_READ);
 	if (page) {
-		bool same_page;
-
 		page = thp_head(page);
 		same_page = lend < page_offset(page) + thp_size(page);
-		if (same_page)
-			partial_end = false;
 		set_page_dirty(page);
 		if (!truncate_inode_partial_page(page, lstart, lend)) {
 			start = page->index + thp_nr_pages(page);
@@ -928,7 +924,7 @@ static void shmem_undo_range(struct inod
 		page = NULL;
 	}
 
-	if (partial_end)
+	if (!same_page)
 		shmem_getpage(inode, end, &page, SGP_READ);
 	if (page) {
 		page = thp_head(page);

Fix to [PATCH v4 15/16] mm/truncate,shmem: Handle truncates that split THPs.
xfstests generic/012 on huge tmpfs hit this every time (when checking
xfs_io commands available: later decides "not run" because no "fiemap").
I grabbed this line unthinkingly from one of your later series, it fixes
the crash; but once I actually thought about it when trying to track down
weirder behaviours, realize that the kmap_atomic() and flush_dcache_page()
in zero_user_segments() are not prepared for a THP - so highmem and
flush_dcache_page architectures will be disappointed. If I searched
through your other series, I might find the complete fix; or perhaps
it's already there in linux-next, I haven't looked.

--- 5103w/include/linux/highmem.h	2020-10-11 14:15:50.000000000 -0700
+++ 5103wh/include/linux/highmem.h	2020-11-16 01:09:35.423677246 -0800
@@ -290,7 +290,7 @@ static inline void zero_user_segments(st
 {
 	void *kaddr = kmap_atomic(page);
 
-	BUG_ON(end1 > PAGE_SIZE || end2 > PAGE_SIZE);
+	BUG_ON(end1 > page_size(page) || end2 > page_size(page));
 
 	if (end1 > start1)
 		memset(kaddr + start1, 0, end1 - start1);

I also had noise from the WARN_ON(page_to_index(page) != index)
in invalidate_inode_pages2_range(): but that's my problem, since
for testing I add a dummy shmem_direct_IO() (return 0): for that
I've now added a shmem_mapping() check at the head of pages2_range().

That's all for now: I'll fire off more overnight testing.

Hugh
