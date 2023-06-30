Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660D27443D6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 23:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjF3VUK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 17:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbjF3VUF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 17:20:05 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4EE2680
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c0d62f4487cso2203258276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688160004; x=1690752004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+U3NPNy+xyAlbM+feS8QAyMObapdpoy5/9PcF9TKLI=;
        b=gj3Eoj1ySBPw7PRJkS7EMLlo2pHw7Fy4fqTaMfYLzfs8i//BzYVVgxavozWht9eYa3
         9QAis0pBfrH9H8O+BTK2P79HmbSy+ccpBICKn8dunthp5sDi7iBpTMHFffkiZCrb/4pR
         En+6nDy6jwP37RQrIPo3q7g/52V2l2w5AufZPHDuq4ZHdGhSDNnMavuXRPZVKntKOTDi
         uiJ3U638bAeT24PExrpL+ltCWuRdoPULemr1kCD8+I4EoR2xOlnV2Nf8827lutjv9zcq
         lKwsFdM6xI6ZVtuw93zeDjoRoNdTpjbnxRcchetindVZNkpIckBFK5QbU6hmmDd25SjA
         DVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688160004; x=1690752004;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+U3NPNy+xyAlbM+feS8QAyMObapdpoy5/9PcF9TKLI=;
        b=SYIPSRw30lS0lK75VFEPI1YOXTnbKGxWy/sRaQwQquI8sZ07dDlmos1jZdZNwyahcV
         /cKcR+pCwEeXvMO7+rDgUTI/d+fiyVrFFiMtRQtOJygvSR5aKz6gm3nuuGSjTJE0upUH
         IwMwazr2MUiJu2klCAlA3MdX7ljs5eYZcJMygO1h4X/KVSiSgCUbMs7zE6b2KTAMLnZ0
         avXvgz1V1Xjc2RPCviiWcjmrhJYYf1td/VlKNvjTrm4L0CMvdpJ6+JXTs6LWECb7KL+n
         sNB4pmpAj7fl/bHtxn/vMLlI7IPG0iwxeV5mO3SBM4KqbsdKG0vjs3kwst9UUoRARJ/2
         jPZA==
X-Gm-Message-State: ABy/qLZL2oxcl+oMnLd7sbwV7kz7DAet4LyhMGvR5WEu2ohooAPFgHzr
        4T4SAW6SzoDgshw37mQf59RMoZmRLhY=
X-Google-Smtp-Source: APBJJlHm1PS8GELal/xG6N1RB/HDwu0xhxZBZ/b8TRPUqLWRpiaRfbIuTnZTA+ooMa+BPx0Ft/eRiuXr8FU=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:b54c:4d64:f00a:1b67])
 (user=surenb job=sendgmr) by 2002:a25:2cb:0:b0:c43:b4b6:dde8 with SMTP id
 194-20020a2502cb000000b00c43b4b6dde8mr17502ybc.8.1688160003659; Fri, 30 Jun
 2023 14:20:03 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:19:52 -0700
In-Reply-To: <20230630211957.1341547-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630211957.1341547-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630211957.1341547-2-surenb@google.com>
Subject: [PATCH v7 1/6] swap: remove remnants of polling from read_swap_cache_async
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
index 886f06066622..ac6d92f74f6d 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -218,7 +218,7 @@ static int swapin_walk_pmd_entry(pmd_t *pmd, unsigned long start,
 		ptep = NULL;
 
 		page = read_swap_cache_async(entry, GFP_HIGHUSER_MOVABLE,
-					     vma, addr, false, &splug);
+					     vma, addr, &splug);
 		if (page)
 			put_page(page);
 	}
@@ -262,7 +262,7 @@ static void shmem_swapin_range(struct vm_area_struct *vma,
 		rcu_read_unlock();
 
 		page = read_swap_cache_async(entry, mapping_gfp_mask(mapping),
-					     vma, addr, false, &splug);
+					     vma, addr, &splug);
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
index f8ea7015bad4..5a690c79cc13 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -527,15 +527,14 @@ struct page *__read_swap_cache_async(swp_entry_t entry, gfp_t gfp_mask,
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
@@ -630,7 +629,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	struct swap_info_struct *si = swp_swap_info(entry);
 	struct blk_plug plug;
 	struct swap_iocb *splug = NULL;
-	bool do_poll = true, page_allocated;
+	bool page_allocated;
 	struct vm_area_struct *vma = vmf->vma;
 	unsigned long addr = vmf->address;
 
@@ -638,7 +637,6 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	if (!mask)
 		goto skip;
 
-	do_poll = false;
 	/* Read a page_cluster sized and aligned cluster around offset. */
 	start_offset = offset & ~mask;
 	end_offset = offset | mask;
@@ -670,7 +668,7 @@ struct page *swap_cluster_readahead(swp_entry_t entry, gfp_t gfp_mask,
 	lru_add_drain();	/* Push any new pages onto the LRU now */
 skip:
 	/* The page was likely read above, so no need for plugging here */
-	return read_swap_cache_async(entry, gfp_mask, vma, addr, do_poll, NULL);
+	return read_swap_cache_async(entry, gfp_mask, vma, addr, NULL);
 }
 
 int init_swap_address_space(unsigned int type, unsigned long nr_pages)
@@ -838,7 +836,7 @@ static struct page *swap_vma_readahead(swp_entry_t fentry, gfp_t gfp_mask,
 skip:
 	/* The page was likely read above, so no need for plugging here */
 	return read_swap_cache_async(fentry, gfp_mask, vma, vmf->address,
-				     ra_info.win == 1, NULL);
+				     NULL);
 }
 
 /**
-- 
2.41.0.255.g8b1d071c50-goog

