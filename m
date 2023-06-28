Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77EB5741722
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 19:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231421AbjF1RZ5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 13:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjF1RZi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 13:25:38 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 450C21FCD
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:36 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-c17812e30b4so5309428276.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 10:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687973135; x=1690565135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KMxqHAnxOZxMzgoGe7kH228DI7ZaEMF5Tfki0D7IS+4=;
        b=e6SPrWEkGiS7vhpHhhy37EcTRVrgLixp2j9nc9EBXVKej7rIbih+NkwJb1MJn3rRDX
         5muFPgNOpa6ZEK4o/0O1g9m3lbEwIyCcXkljX26TsSqupAwnhpmWQRx8CDSGC558JJIO
         zsfH9ZLyWCPVb029aawxSuzo4keH1XGw00BY/iVUfHzSafcc2ABx8vXH3xmVaWp7skVn
         YIYwuCss3vEqI8yrAYLu29TIrCDFEXYAgjNrcxHG3KB3oPG2oESX91b3haK9+Q4XKU6Z
         styvaJQzhk+b5f88CjLax8vu0Fc8jk/0sma4xwI+oS81IE2WBsB+5IiiWsfpeaCvJ4UY
         vfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687973135; x=1690565135;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMxqHAnxOZxMzgoGe7kH228DI7ZaEMF5Tfki0D7IS+4=;
        b=cy/xMWIwcRCJEXw/ZGqR77V89hG/uJFxibPZBp705qcn2cN9aaGwgz0SgcWGtkF9rB
         M0sWxEOHyFv9ZHZPO2s3PLrBpipiLLUJB818fowVVsMfPbSfBtNA74N8uLpYmPOfLLpo
         OHgkMa854TyxNPUmOjr2hqK9aHytfNYPJVTVMaCIJv7V9wfNBnG+fwFYwyZeT/yQdnJM
         NeUXYsgCyepPS4GYvS+Eov8w+ig1Xq3yJ36bgKTrMf8ezRSOXhG2k4zpCAzMPmzIgEWZ
         Tx67/W0sldo3U4cfjrw+kJ2PfiLix0xjColJwS5UZG5oGj0gHV7jT/QnPqK4kVoD/IOy
         KHxQ==
X-Gm-Message-State: AC+VfDzOZub55Q3JP/D0eu0dTcGc7g/AkXX7cSDWnKejUlV3nFENWtwE
        rLYMMRWmu4ZSKdxJwAVzGLHRtWysP3A=
X-Google-Smtp-Source: ACHHUZ6N7gWosjP8G3HWgmkBJCbFxP8A/hCoy48IKxEWFUFucTCUbC4VUp9YtI79x0Uj4BJMkP4VIAbKaOk=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:201:eea3:e898:7d7a:1125])
 (user=surenb job=sendgmr) by 2002:a25:2f95:0:b0:c15:cbd1:60dd with SMTP id
 v143-20020a252f95000000b00c15cbd160ddmr3699476ybv.5.1687973135437; Wed, 28
 Jun 2023 10:25:35 -0700 (PDT)
Date:   Wed, 28 Jun 2023 10:25:24 -0700
In-Reply-To: <20230628172529.744839-1-surenb@google.com>
Mime-Version: 1.0
References: <20230628172529.744839-1-surenb@google.com>
X-Mailer: git-send-email 2.41.0.162.gfafddb0af9-goog
Message-ID: <20230628172529.744839-2-surenb@google.com>
Subject: [PATCH v5 1/6] swap: remove remnants of polling from read_swap_cache_async
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
        autolearn=unavailable autolearn_force=no version=3.4.6
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
2.41.0.162.gfafddb0af9-goog

