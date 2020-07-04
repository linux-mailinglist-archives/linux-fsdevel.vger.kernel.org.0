Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 753BC2148A5
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jul 2020 22:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgGDUUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 4 Jul 2020 16:20:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgGDUUi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 4 Jul 2020 16:20:38 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6BAC061794
        for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jul 2020 13:20:38 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id m8so11445843qvk.7
        for <linux-fsdevel@vger.kernel.org>; Sat, 04 Jul 2020 13:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=QO+uGyzkj+1i3npllaKOLzqHp+nCGpS0yeoB+i9InBw=;
        b=LTyAcmb1jWCHIEcjh4Ht2kHNHQswYEDlYuLvebK4cbakU905niMb3Drt4Bw9FU/8QR
         DfSV3WGJ/oecQTxJNB2kH/qJogwOE7q4B+5JF770ahcxfu/TpRD2gVpCJiSzF8z35rQE
         oqbr0U0LeGbH/0JN4J12uMYx58vQNSq8WFtGyys7oPdqwHErM526vGvXV7vLvfhe8tcO
         sBTBaWy1Xi0Iu+P8G3wb/mb5w6/S4xfVlvUcSeWu82NXmV8x3manhwWcV7X8SxqlOHUL
         HTqOdXmE5SjogkYoTT7idZxwM0aO36ykzGJ40YwaRwMI9NKFj9UobJYbQEqCmnJfWZMV
         wV7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=QO+uGyzkj+1i3npllaKOLzqHp+nCGpS0yeoB+i9InBw=;
        b=NDLJfCtPnIIBFwymiap4wUkHwbBJE/0jg6se6IMNo95fDZcRDbssc1RjSaJIKyg9ug
         OF1V6i//P9QlCRBGllkRmfnUS6owppGS93bHa3nDEMMkZgdnG9R+X4KTfldKwObiCw5t
         gi92JiLwOQKBAbGYvCnPpSPoDbJACPLdcIQDZowzhBk+uwxET4GzfZ36A9ELgBoqghTv
         TfMjXqBqq5L/0WXeyV3GGb/F6qPu9aHP7E+R381XnZgHkefSfZdZUJCIRvlBgiJA3sci
         fUQ+Yo/rMWhw4RCU7W40FSbsvJAGHATBlxrMNDCqj52wIKCmCAUwGw4w9U1W3EIS0MEB
         B8Hg==
X-Gm-Message-State: AOAM531La4vq3WbWFw3ACZ9H9NM1m/u2C3UL3LZ7o2xb2UYEJgxWaUIB
        2PXosj0wUB7YYfM/EVwxc4q1vw==
X-Google-Smtp-Source: ABdhPJyUeNymNn5hgWklD31KtuAvPyG4ZFzgvWlratEc0DAavUKWbL/UX1o5dt3xKJBWDPKD7IVrug==
X-Received: by 2002:ad4:42a5:: with SMTP id e5mr12566822qvr.67.1593894037423;
        Sat, 04 Jul 2020 13:20:37 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w11sm15529531qtk.35.2020.07.04.13.20.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Sat, 04 Jul 2020 13:20:35 -0700 (PDT)
Date:   Sat, 4 Jul 2020 13:20:19 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
cc:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH 0/2] Use multi-index entries in the page cache
In-Reply-To: <20200629152033.16175-1-willy@infradead.org>
Message-ID: <alpine.LSU.2.11.2007041206270.1056@eggly.anvils>
References: <20200629152033.16175-1-willy@infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 29 Jun 2020, Matthew Wilcox (Oracle) wrote:

> Following Hugh's advice at LSFMM 2019, I was trying to avoid doing this,
> but it turns out to be hard to support range writeback with the pagecache
> using multiple single entries.  Of course, this isn't a problem for
> shmem because it doesn't have a real backing device (only swap), but
> real filesystems need to start writeback at arbitrary file offsets and
> have problems if we don't notice that the first (huge) page in the range
> is dirty.
> 
> Hugh, I would love it if you could test this.  It didn't introduce any new
> regressions to the xfstests, but shmem does exercise different paths and
> of course I don't have a clean xfstests run yet, so there could easily
> still be bugs.
> 
> I'd like this to be included in mmotm, but it is less urgent than the
> previous patch series that I've sent.  As far as risk, I think it only
> affects shmem/tmpfs.
> 
> Matthew Wilcox (Oracle) (2):
>   XArray: Add xas_split
>   mm: Use multi-index entries in the page cache
> 
>  Documentation/core-api/xarray.rst |  16 ++--
>  include/linux/xarray.h            |   2 +
>  lib/test_xarray.c                 |  41 ++++++++
>  lib/xarray.c                      | 153 ++++++++++++++++++++++++++++--
>  mm/filemap.c                      |  42 ++++----
>  mm/huge_memory.c                  |  21 +++-
>  mm/khugepaged.c                   |  12 ++-
>  mm/shmem.c                        |  11 +--
>  8 files changed, 245 insertions(+), 53 deletions(-)
> 
> -- 
> 2.27.0

I have been trying it, and it's not good yet. I had hoped to work
out what's wrong and send a patch, but I'm not making progress,
so better hand back to you with what I've found.

First problem was that it did not quite build on top of 5.8-rc3
plus your 1-7 THP prep patches: was there some other series we
were supposed to add in too? If so, that might make a big difference,
but I fixed up __add_to_page_cache_locked() as in the diff below
(and I'm not bothering about hugetlbfs, so haven't looked to see if
its page indexing is or isn't still exceptional with your series).

Second problem was fs/inode.c:530 BUG_ON(inode->i_data.nrpages),
after warning from shmem_evict_inode(). Surprisingly, that first
happened on a machine with CONFIG_TRANSPARENT_HUGEPAGE not set,
while doing an "rm -rf".

I've seen it on other machines since, with THP enabled, doing other
things; but have not seen it in the last couple of days, which is
intriguing (though partly consequence of narrowing down to xfstests).

The original non-THP machine ran the same load for
ten hours yesterday, but hit no problem. The only significant
difference in what ran successfully, is that I've been surprised
by all the non-zero entries I saw in xarray nodes, exceeding
total entry "count" (I've also been bothered by non-zero "offset"
at root, but imagine that's just noise that never gets used).
So I've changed the kmem_cache_alloc()s in lib/radix-tree.c to
kmem_cache_zalloc()s, as in the diff below: not suggesting that
as necessary, just a temporary precaution in case something is
not being initialized as intended.

I've also changed shmem_evict_inode()'s warning to BUG to crash
sooner, as in the diff below; but not hit it since doing so.

Here's a script to run in the xfstests directory, just running
the tests I've seen frequent problems from: maybe you were not
choosing the "huge=always" option to tmpfs?  An alternative is
"echo force >/sys/kernel/mm/transparent_hugepage/shmem_enabled":
that's good when running random tests that you cannot poke into;
but can cause crashes if the graphics driver e.g. i915 is using
shmem, and then gets hugepages it was not expecting.

sync
export FSTYP=tmpfs
export DISABLE_UDF_TEST=1
export TEST_DEV=tmpfs1:
export TEST_DIR=/xft		# I have that, you'll have somewhere else
export SCRATCH_DEV=tmpfs2:
export SCRATCH_MNT=/mnt
export TMPFS_MOUNT_OPTIONS="-o size=1088M,huge=always"
mount -t $FSTYP $TMPFS_MOUNT_OPTIONS $TEST_DEV $TEST_DIR || exit $?
./check generic/083 generic/224 generic/228 generic/269 generic/476
umount /xft /mnt 2>/dev/null

These problems were either mm/filemap.c:1565 find_lock_entry()
VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page); or hangs, which
(at least the ones that I went on to investigate) turned out also to be
find_lock_entry(), circling around with page_mapping(page) != mapping.
It seems that find_get_entry() is sometimes supplying the wrong page,
and you will work out why much quicker than I shall.  (One tantalizing
detail of the bad offset crashes: very often page pgoff is exactly one
less than the requested offset.)

I have modified find_lock_entry() as in the diff below, to be stricter:
we all prefer to investigate a crash than a hang, and I think it's been
unnecessarily forgiving of page->mapping. I might be wrong (fuse? page
migration? splice stealing? shmem swap? THP collapse? THP splitting?)
but I believe they are all okay with a simple head->mapping check there.

Hugh

--- 5083w/lib/radix-tree.c	2020-06-14 15:13:01.406042750 -0700
+++ 5083wh/lib/radix-tree.c	2020-07-04 11:35:11.433181700 -0700
@@ -249,7 +249,7 @@ radix_tree_node_alloc(gfp_t gfp_mask, st
 		 * cache first for the new node to get accounted to the memory
 		 * cgroup.
 		 */
-		ret = kmem_cache_alloc(radix_tree_node_cachep,
+		ret = kmem_cache_zalloc(radix_tree_node_cachep,
 				       gfp_mask | __GFP_NOWARN);
 		if (ret)
 			goto out;
@@ -257,7 +257,7 @@ radix_tree_node_alloc(gfp_t gfp_mask, st
 		/*
 		 * Provided the caller has preloaded here, we will always
 		 * succeed in getting a node here (and never reach
-		 * kmem_cache_alloc)
+		 * kmem_cache_zalloc)
 		 */
 		rtp = this_cpu_ptr(&radix_tree_preloads);
 		if (rtp->nr) {
@@ -272,7 +272,7 @@ radix_tree_node_alloc(gfp_t gfp_mask, st
 		kmemleak_update_trace(ret);
 		goto out;
 	}
-	ret = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+	ret = kmem_cache_zalloc(radix_tree_node_cachep, gfp_mask);
 out:
 	BUG_ON(radix_tree_is_internal_node(ret));
 	if (ret) {
@@ -334,7 +334,7 @@ static __must_check int __radix_tree_pre
 	rtp = this_cpu_ptr(&radix_tree_preloads);
 	while (rtp->nr < nr) {
 		local_unlock(&radix_tree_preloads.lock);
-		node = kmem_cache_alloc(radix_tree_node_cachep, gfp_mask);
+		node = kmem_cache_zalloc(radix_tree_node_cachep, gfp_mask);
 		if (node == NULL)
 			goto out;
 		local_lock(&radix_tree_preloads.lock);
--- 5083w/mm/filemap.c	2020-06-30 11:38:58.094010948 -0700
+++ 5083wh/mm/filemap.c	2020-07-04 11:35:11.437181729 -0700
@@ -824,6 +824,7 @@ static int __add_to_page_cache_locked(st
 				      void **shadowp)
 {
 	XA_STATE(xas, &mapping->i_pages, offset);
+	unsigned int nr = thp_nr_pages(page);
 	int huge = PageHuge(page);
 	int error;
 	void *old;
@@ -859,12 +860,13 @@ static int __add_to_page_cache_locked(st
 		xas_store(&xas, page);
 		if (xas_error(&xas))
 			goto unlock;
+
 		mapping->nrexceptional -= exceptional;
 		mapping->nrpages += nr;
 
 		/* hugetlb pages do not participate in page cache accounting */
 		if (!huge)
-			__inc_lruvec_page_state(page, NR_FILE_PAGES);
+			__mod_lruvec_page_state(page, NR_FILE_PAGES, nr);
 unlock:
 		xas_unlock_irq(&xas);
 	} while (xas_nomem(&xas, gfp_mask & GFP_RECLAIM_MASK));
@@ -1548,19 +1550,26 @@ out:
  */
 struct page *find_lock_entry(struct address_space *mapping, pgoff_t offset)
 {
-	struct page *page;
-
+	struct page *page, *head;
+	pgoff_t pgoff;
 repeat:
 	page = find_get_entry(mapping, offset);
 	if (page && !xa_is_value(page)) {
-		lock_page(page);
+		head = compound_head(page);
+		lock_page(head);
 		/* Has the page been truncated? */
-		if (unlikely(page_mapping(page) != mapping)) {
-			unlock_page(page);
+		if (unlikely(!head->mapping)) {
+			unlock_page(head);
 			put_page(page);
 			goto repeat;
 		}
-		VM_BUG_ON_PAGE(page_to_pgoff(page) != offset, page);
+		pgoff = head->index + (page - head);
+		if (PageSwapCache(head) ||
+		    head->mapping != mapping || pgoff != offset) {
+			printk("page=%px pgoff=%lx offset=%lx headmapping=%px mapping=%px\n",
+				page, pgoff, offset, head->mapping, mapping);
+			VM_BUG_ON_PAGE(1, page);
+		}
 	}
 	return page;
 }
--- 5083w/mm/shmem.c	2020-06-30 11:38:58.098010985 -0700
+++ 5083wh/mm/shmem.c	2020-07-04 11:35:11.441181757 -0700
@@ -1108,7 +1108,12 @@ static void shmem_evict_inode(struct ino
 	}
 
 	simple_xattrs_free(&info->xattrs);
-	WARN_ON(inode->i_blocks);
+	if (inode->i_blocks) {
+		printk("mapping=%px i_blocks=%lx nrpages=%lx nrexcept=%lx\n",
+			inode->i_mapping, (unsigned long)inode->i_blocks,
+			inode->i_data.nrpages, inode->i_data.nrexceptional);
+		BUG();
+	}
 	shmem_free_inode(inode->i_sb);
 	clear_inode(inode);
 }
