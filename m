Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1454E743276
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 04:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjF3CEr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 22:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjF3CEo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 22:04:44 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E501FE7
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:43 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-56938733c13so11684157b3.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 19:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688090682; x=1690682682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T+U3NPNy+xyAlbM+feS8QAyMObapdpoy5/9PcF9TKLI=;
        b=rvyDGGahsbSARiQKNJBvs5NaGYjXW8NZzm9dcWursQkpPyYTW87vOp0jaL/v9wFn72
         bVCnSMsCL0Uww5Cz2gl4BTCbB3YOvEPgid/Pz/LzO8PDWuvfrJ2G8Jiylai9nQSwghqV
         XTPn7m5a6XLji4dmREhc1FM19R1MCvpV3tbEnuzVLNravKUeqSKCb2E7NDFaKDZgK3oA
         59VRX6qKLr9O5DBQxMvgWTxqC8FOrrGsqmH7OYYKLdSnJ0MiFxDdJVnxpCvmqod/rmwQ
         xQnRBu3/xHvFBzDvleXzw2kra/qngRMyB/qMKcD/nmpoEBHDjoyDF9TWDoyXcI8GVjIk
         1b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688090682; x=1690682682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T+U3NPNy+xyAlbM+feS8QAyMObapdpoy5/9PcF9TKLI=;
        b=gQ0Cb7lrk1zfB9Hx5rxdnSxVepylumoeBfrxwrcvW2F8wrWjz0XD0JMQ7tWMyh72ly
         2iCkUkhzUbMHLBiiQTrhHxgH9h62Z7jbra5k0yohJSz/uVhY1eYnvuy+P9vlXvbCczVQ
         KhFPnEOo5ss4OKrrEhQcChfQr3uKgXxjvySw6H50rfFKrl6Q5A2Q+2b2KdWU40ucBElu
         5URi+nHkdIngN11fHlZ3fDfm5ELjYncxAISZhoCki1qsyNhYQuU0txxrE+HeJdcZ3tj8
         5fbpQRoJiH+h4I6fdFKojMzNs2CZcVyDn7lmEanwNCvrPvkDqYtEEwklanVlTWpdsV1d
         uSzg==
X-Gm-Message-State: ABy/qLbXNvsnM33GCGBI/miMqOPJYuvs0l3ZlSqWxV6ggKJYtx2jcwLH
        H60El8ulX1XyNTc1nje9vBNyQVu0IeA=
X-Google-Smtp-Source: APBJJlFHuVnY9FeKGILHpU4FVRKk28e82VnRW+1SQlAaSM9Gd4WVwIdiE5OHAJvPzkmeNDyyPG7JbAA7D7A=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:1f11:a3d0:19a9:16e5])
 (user=surenb job=sendgmr) by 2002:a0d:db8a:0:b0:576:f208:4d91 with SMTP id
 d132-20020a0ddb8a000000b00576f2084d91mr8639ywe.4.1688090682204; Thu, 29 Jun
 2023 19:04:42 -0700 (PDT)
Date:   Thu, 29 Jun 2023 19:04:30 -0700
In-Reply-To: <20230630020436.1066016-1-surenb@google.com>
Mime-Version: 1.0
References: <20230630020436.1066016-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630020436.1066016-2-surenb@google.com>
Subject: [PATCH v6 1/6] swap: remove remnants of polling from read_swap_cache_async
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

