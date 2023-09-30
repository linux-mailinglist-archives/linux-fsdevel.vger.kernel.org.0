Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A91A17B3DD6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 05:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbjI3Dbf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 23:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjI3Dbe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 23:31:34 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343A7B9
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:31:31 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-5a22f9e2f40so23100787b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Sep 2023 20:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696044690; x=1696649490; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QspsCGzxpxq3SSLDt+LJp9Jy//8oF6+tYorlwqGdsRA=;
        b=FVeE6k2L8wP8t7TzSUr7z3tKhbLL753juRIs1Pm1jUQpzO5VguculLP9NNS9J/izpc
         uwF8bc+zEkdBVEPuBqkn7M+zXM7fHFe32zxL8gf6PI+Ul75ofc/93NuSDuaCh2Vchc/G
         FVifpXEfHbF9pvvqRIGKOaMlpLY64Pg8h3ijY/jUuzsCPrCSt/KOwMQyKP5nNsEwFKoD
         epzd3p2+Gk1HSM7tl8WSygnGViXjzW8of00Doe58eQajwEr24n4s0DTYag5WTRImFvss
         Fxnc87PJzT1D2w9fx7jELbfruPab3T7gzvikmmHHxokA0WsCtAY07MhDjJTzz720FtMz
         UF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696044690; x=1696649490;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QspsCGzxpxq3SSLDt+LJp9Jy//8oF6+tYorlwqGdsRA=;
        b=eTeiWH1jIZS/zuloXMRV4cDaa7wnhOEVDpm8OnHCqBs86oJJgbJRSl2dHIvlTJkWSo
         Ic3hb1wCwwSueEidvdds2yeU/37d6xOiRau77uhohKOCtb/78Se9P7nl+GvRVwVVaWpE
         ZpG/H9RuQTYNOHQbvObstf2rOE4b+2TSS8Paj3TA7ROuqDrUAW6kh14uRmN+qpWeVnPj
         YhK3lsGdHUvRAdNzn3ep9396qRbLxXUXibTtpTCpqZJgAOepBh9fnSmqQWatK2xQdRnE
         jv/mCckHNS3I5i1L2w8QtjFxWTdQSd7W2LTx69v71GJd5XLCp3b6m2AAYmxXuZYf19Yu
         Wfbw==
X-Gm-Message-State: AOJu0YxWelxBuGpNZ2Xg88h8oJHHJBwbGQ9SHq3RlBDbErczBtHaXYLH
        232Z/hxqXolRki7+AcqCLt4X6A==
X-Google-Smtp-Source: AGHT+IEgXqnD7PMNlAh5dIBX1/Qy7aURmmr6eaqI4X8ytb5LLyV63aow9Zb+c+tnCOaAvJkKxO8m7Q==
X-Received: by 2002:a0d:d3c5:0:b0:585:ef4e:6d93 with SMTP id v188-20020a0dd3c5000000b00585ef4e6d93mr5637010ywd.47.1696044690238;
        Fri, 29 Sep 2023 20:31:30 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d71-20020a814f4a000000b0059be3d854b1sm5928458ywb.109.2023.09.29.20.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 20:31:29 -0700 (PDT)
Date:   Fri, 29 Sep 2023 20:31:27 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Christian Brauner <brauner@kernel.org>,
        Carlos Maiolino <cem@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH 6/8] shmem: move memcg charge out of
 shmem_add_to_page_cache()
In-Reply-To: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
Message-ID: <4b2143c5-bf32-64f0-841-81a81158dac@google.com>
References: <c7441dc6-f3bb-dd60-c670-9f5cbd9f266@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Extract shmem's memcg charging out of shmem_add_to_page_cache(): it's
misleading done there, because many calls are dealing with a swapcache
page, whose memcg is nowadays always remembered while swapped out, then
the charge re-levied when it's brought back into swapcache.

Temporarily move it back up to the shmem_get_folio_gfp() level, where
the memcg was charged before v5.8; but the next commit goes on to move
it back down to a new home.

In making this change, it becomes clear that shmem_swapin_folio() does
not need to know the vma, just the fault mm (if any): call it fault_mm
rather than charge_mm - let mem_cgroup_charge() decide whom to charge.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 68 +++++++++++++++++++++++-------------------------------
 1 file changed, 29 insertions(+), 39 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 63ba6037b23a..0a7f7b567b80 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -146,9 +146,8 @@ static unsigned long shmem_default_max_inodes(void)
 #endif
 
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
-			     struct folio **foliop, enum sgp_type sgp,
-			     gfp_t gfp, struct vm_area_struct *vma,
-			     vm_fault_t *fault_type);
+			struct folio **foliop, enum sgp_type sgp, gfp_t gfp,
+			struct mm_struct *fault_mm, vm_fault_t *fault_type);
 
 static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 {
@@ -760,12 +759,10 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
  */
 static int shmem_add_to_page_cache(struct folio *folio,
 				   struct address_space *mapping,
-				   pgoff_t index, void *expected, gfp_t gfp,
-				   struct mm_struct *charge_mm)
+				   pgoff_t index, void *expected, gfp_t gfp)
 {
 	XA_STATE_ORDER(xas, &mapping->i_pages, index, folio_order(folio));
 	long nr = folio_nr_pages(folio);
-	int error;
 
 	VM_BUG_ON_FOLIO(index != round_down(index, nr), folio);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
@@ -776,16 +773,7 @@ static int shmem_add_to_page_cache(struct folio *folio,
 	folio->mapping = mapping;
 	folio->index = index;
 
-	if (!folio_test_swapcache(folio)) {
-		error = mem_cgroup_charge(folio, charge_mm, gfp);
-		if (error) {
-			if (folio_test_pmd_mappable(folio)) {
-				count_vm_event(THP_FILE_FALLBACK);
-				count_vm_event(THP_FILE_FALLBACK_CHARGE);
-			}
-			goto error;
-		}
-	}
+	gfp &= GFP_RECLAIM_MASK;
 	folio_throttle_swaprate(folio, gfp);
 
 	do {
@@ -813,15 +801,12 @@ static int shmem_add_to_page_cache(struct folio *folio,
 	} while (xas_nomem(&xas, gfp));
 
 	if (xas_error(&xas)) {
-		error = xas_error(&xas);
-		goto error;
+		folio->mapping = NULL;
+		folio_ref_sub(folio, nr);
+		return xas_error(&xas);
 	}
 
 	return 0;
-error:
-	folio->mapping = NULL;
-	folio_ref_sub(folio, nr);
-	return error;
 }
 
 /*
@@ -1324,10 +1309,8 @@ static int shmem_unuse_swap_entries(struct inode *inode,
 
 		if (!xa_is_value(folio))
 			continue;
-		error = shmem_swapin_folio(inode, indices[i],
-					  &folio, SGP_CACHE,
-					  mapping_gfp_mask(mapping),
-					  NULL, NULL);
+		error = shmem_swapin_folio(inode, indices[i], &folio, SGP_CACHE,
+					mapping_gfp_mask(mapping), NULL, NULL);
 		if (error == 0) {
 			folio_unlock(folio);
 			folio_put(folio);
@@ -1810,12 +1793,11 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
  */
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			     struct folio **foliop, enum sgp_type sgp,
-			     gfp_t gfp, struct vm_area_struct *vma,
+			     gfp_t gfp, struct mm_struct *fault_mm,
 			     vm_fault_t *fault_type)
 {
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct mm_struct *charge_mm = vma ? vma->vm_mm : NULL;
 	struct swap_info_struct *si;
 	struct folio *folio = NULL;
 	swp_entry_t swap;
@@ -1843,7 +1825,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 		if (fault_type) {
 			*fault_type |= VM_FAULT_MAJOR;
 			count_vm_event(PGMAJFAULT);
-			count_memcg_event_mm(charge_mm, PGMAJFAULT);
+			count_memcg_event_mm(fault_mm, PGMAJFAULT);
 		}
 		/* Here we actually start the io */
 		folio = shmem_swapin(swap, gfp, info, index);
@@ -1880,8 +1862,7 @@ static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 	}
 
 	error = shmem_add_to_page_cache(folio, mapping, index,
-					swp_to_radix_entry(swap), gfp,
-					charge_mm);
+					swp_to_radix_entry(swap), gfp);
 	if (error)
 		goto failed;
 
@@ -1929,7 +1910,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	struct address_space *mapping = inode->i_mapping;
 	struct shmem_inode_info *info = SHMEM_I(inode);
 	struct shmem_sb_info *sbinfo;
-	struct mm_struct *charge_mm;
+	struct mm_struct *fault_mm;
 	struct folio *folio;
 	pgoff_t hindex;
 	gfp_t huge_gfp;
@@ -1946,7 +1927,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	}
 
 	sbinfo = SHMEM_SB(inode->i_sb);
-	charge_mm = vma ? vma->vm_mm : NULL;
+	fault_mm = vma ? vma->vm_mm : NULL;
 
 	folio = filemap_get_entry(mapping, index);
 	if (folio && vma && userfaultfd_minor(vma)) {
@@ -1958,7 +1939,7 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 
 	if (xa_is_value(folio)) {
 		error = shmem_swapin_folio(inode, index, &folio,
-					  sgp, gfp, vma, fault_type);
+					   sgp, gfp, fault_mm, fault_type);
 		if (error == -EEXIST)
 			goto repeat;
 
@@ -2044,9 +2025,16 @@ static int shmem_get_folio_gfp(struct inode *inode, pgoff_t index,
 	if (sgp == SGP_WRITE)
 		__folio_set_referenced(folio);
 
-	error = shmem_add_to_page_cache(folio, mapping, hindex,
-					NULL, gfp & GFP_RECLAIM_MASK,
-					charge_mm);
+	error = mem_cgroup_charge(folio, fault_mm, gfp);
+	if (error) {
+		if (folio_test_pmd_mappable(folio)) {
+			count_vm_event(THP_FILE_FALLBACK);
+			count_vm_event(THP_FILE_FALLBACK_CHARGE);
+		}
+		goto unacct;
+	}
+
+	error = shmem_add_to_page_cache(folio, mapping, hindex, NULL, gfp);
 	if (error)
 		goto unacct;
 
@@ -2644,8 +2632,10 @@ int shmem_mfill_atomic_pte(pmd_t *dst_pmd,
 	if (unlikely(pgoff >= max_off))
 		goto out_release;
 
-	ret = shmem_add_to_page_cache(folio, mapping, pgoff, NULL,
-				      gfp & GFP_RECLAIM_MASK, dst_vma->vm_mm);
+	ret = mem_cgroup_charge(folio, dst_vma->vm_mm, gfp);
+	if (ret)
+		goto out_release;
+	ret = shmem_add_to_page_cache(folio, mapping, pgoff, NULL, gfp);
 	if (ret)
 		goto out_release;
 
-- 
2.35.3

