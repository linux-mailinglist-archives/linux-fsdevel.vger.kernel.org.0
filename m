Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8555473F348
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 06:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjF0EXb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 00:23:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjF0EX3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 00:23:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4747DC
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:27 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-57003dac4a8so105902257b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 26 Jun 2023 21:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687839807; x=1690431807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=o3AoGbebO2/sjyjLq3ryUCG8xyOW9r1weM+cOFZBuLE=;
        b=dHheU6IC1gE4LjWZbQ/IniaV5DkcPhnNF8syM8uOEowX24NwDyxL2jv7tc6FMBV27G
         4Rxqr6ibWCntKsVRDQuwZtzhYYD6gJJ2gf36p8H6RGHXmOM8wDs4xTT/AlcWoevHEkxS
         v11okL1qKsR1gEcM8TCR0a/PdkjPb5Pq5EFqxbA0tdJVQ5Xuw5GeD2Ni9wv4/5tL70nq
         RQBUnOCAF8gaCTtKz4Rjw+9hMKvCgHNAWYRPVUKlT6kt/uP3e/quWkiQpWjZf2l4itqS
         1KtiecTwEsABkWVxwh5d4fxy32LDKhCX/GgNJwBCk69VtHXh+xGpl12LuLk4+qxVZJeO
         Od9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687839807; x=1690431807;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o3AoGbebO2/sjyjLq3ryUCG8xyOW9r1weM+cOFZBuLE=;
        b=NJl5k4tlNU2nXfFdSqIek3U9a+Z7Qe4YNVCUxMVHDIvUw4uGdxGqTagQnoWe9IQC+p
         jrexXHiYrjhN+e38FY9Jk6ZAnGyFeqe/noNCRIHReoRV8up5GsxffeMphnyc3H344vNA
         ifZSNNWA0+RHw1F4Eh2jMpM4brK2bGajSf3gWbbGiWkpS1TNlm7XpyIOYOJrZM9TJUdS
         80hpSbrTW+TSAM6k0qg2byzdrTcu9C1rWpzB7lT3PvhRQ994gsdClI901XO5KD/ySzGj
         w0OBeFhlfZIl3ad8bIlZ/0rCOCaHcnk55MICZ/0AN3etKhnc7bY/GMcCDVaEq3QAPn6f
         h2qQ==
X-Gm-Message-State: AC+VfDxqprdk9kUjSxVr0RhYduuhS2P84XftkLN2wg/9DN7aXmpKAy2U
        nzt3G6jmPfeHnqbQgdmCie/JAgn45eM=
X-Google-Smtp-Source: ACHHUZ5z6WN5yIbltZSphoAhRLFW8PERhElNtWSsbrV8xNDcki//Fjq1aVBOXHRZFF3wnIZEH2iDfzPMLKI=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:5075:f38d:ce2f:eb1b])
 (user=surenb job=sendgmr) by 2002:a05:6902:92:b0:bc4:a660:528f with SMTP id
 h18-20020a056902009200b00bc4a660528fmr10901839ybs.5.1687839807170; Mon, 26
 Jun 2023 21:23:27 -0700 (PDT)
Date:   Mon, 26 Jun 2023 21:23:14 -0700
In-Reply-To: <20230627042321.1763765-1-surenb@google.com>
Mime-Version: 1.0
References: <20230627042321.1763765-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230627042321.1763765-2-surenb@google.com>
Subject: [PATCH v3 1/8] swap: remove remnants of polling from read_swap_cache_async
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, hannes@cmpxchg.org, mhocko@suse.com,
        josef@toxicpanda.com, jack@suse.cz, ldufour@linux.ibm.com,
        laurent.dufour@fr.ibm.com, michel@lespinasse.org,
        liam.howlett@oracle.com, jglisse@google.com, vbabka@suse.cz,
        minchan@google.com, dave@stgolabs.net, punit.agrawal@bytedance.com,
        lstoakes@gmail.com, hdanton@sina.com, apopple@nvidia.com,
        peterx@redhat.com, ying.huang@intel.com, david@redhat.com,
        yuzhao@google.com, dhowells@redhat.com, hughd@google.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org,
        pasha.tatashin@soleen.com, surenb@google.com, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit [1] introduced IO polling support duding swapin to reduce
swap read latency for block devices that can be polled. However later
commit [2] removed polling support. Therefore it seems safe to remove
do_poll parameter in read_swap_cache_async and always call swap_readpage
with synchronous=false waiting for IO completion in folio_lock_or_retry.

[1] commit 23955622ff8d ("swap: add block io poll in swapin path")
[2] commit 9650b453a3d4 ("block: ignore RWF_HIPRI hint for sync dio")

Suggested-by: "Huang, Ying" <ying.huang@intel.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 mm/madvise.c    |  4 ++--
 mm/swap.h       |  1 -
 mm/swap_state.c | 12 +++++-------
 3 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index b5ffbaf616f5..b1e8adf1234e 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -215,7 +215,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 			continue;
 
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
-					     vma, index, false, &splug);
+					     vma, index, &splug);
 		if (page)
 			put_page(page);
 	}
@@ -252,7 +252,7 @@ static void force_shm_swapin_readahead(struct vm_area_struct *vma,
 		rcu_read_unlock();
 
 		page = read_swap_cache_async(swap, GFP_HIGHUSER_MOVABLE,
-					     NULL, 0, false, &splug);
+					     NULL, 0, &splug);
 		if (page)
 			put_page(page);
 
diff --git a/mm/swap.h b/mm/swap.h
index 7c033d793f15..8a3c7a0ace4f 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -46,7 +46,6 @@ struct folio *filemap_get_incore_folio(struct address_space *mapping,
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct vm_area_struct *vma,
 				   unsigned long addr,
-				   bool do_poll,
 				   struct swap_iocb **plug);
 struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				     struct vm_area_struct *vma,
diff --git a/mm/swap_state.c b/mm/swap_state.c
index b76a65ac28b3..a3839de71f3f 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -517,15 +517,14 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
  */
 struct page *read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
 				   struct vm_area_struct *vma,
-				   unsigned long addr, bool do_poll,
-				   struct swap_iocb **plug)
+				   unsigned long addr, struct swap_iocb **plug)
 {
 	bool page_was_allocated;
 	struct page *retpage = __read_swap_cache_async(entry, gfp_mask,
 			vma, addr, &page_was_allocated);
 
 	if (page_was_allocated)
-		swap_readpage(retpage, do_poll, plug);
+		swap_readpage(retpage, false, plug);
 
 	return retpage;
 }
@@ -620,7 +619,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
-	bool do_poll = true, page_allocated;
+	bool page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
@@ -628,7 +627,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (!mask)
 		goto skip;
 
-	do_poll = false;
 	/* Read a page_cluster sized and aligned cluster around offset. */
 	start_offset = offset & ~mask;
 	end_offset = offset | mask;
@@ -660,7 +658,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll, NULL);
+	return read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -825,7 +823,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1, NULL);
+				     NULL);
 }
 
 /**
-- 
2.41.0.178.g377b9f9a00-goog

