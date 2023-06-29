Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2348B742EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 22:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbjF2UvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 16:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbjF2Uuz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 16:50:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F363594
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 13:50:52 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bacfa4ef059so873360276.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 29 Jun 2023 13:50:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688071852; x=1690663852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oot+BFijmfKZ0KO/nJIrIU5HcDe1IwfMU2NYWHhWcUA=;
        b=dv8waobWVaNSUsOT47GOsDx8vV/iRkGODf8zThZKK4JKq0ZSnTrMWy7R3IAiX1fM4t
         tegdL5nlYEw74WxJbU4ciZTSnZwOVQYCywDP/6JAHDEF3YVNRNQoSLNsxO+X0jE8+WLZ
         4ib0DDeM9eP9xJoybwRbj9HMMqb5rE/qTj6br4mOJWTUvJsbEgikpTHZ4BkIpODJP7uS
         FeOaZbb/LsG8QdVorLcYBayDjEa0cgjzLqqSuGqP5etuMwIPhztE5czIvy2CmabhCZfJ
         vnsHoy7ITFctcEgQKTEC1tg/xVWWYMTZvhXULy5xYz0ZzCxTiOdKZ00s3BGxSv+HUqqN
         HmAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688071852; x=1690663852;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oot+BFijmfKZ0KO/nJIrIU5HcDe1IwfMU2NYWHhWcUA=;
        b=QuU7wCN+8nW9JRqi51q4p624GVDnDi1A/FKY0WnClOFVxCgHA4/ea5OcQZilVwlmyx
         dY7zYEHCd4+DuTMBEyCZ4L9VCFEtXDibu3dK6ZbIwz0Zd2i8FPNWGsJauRriPv/XcGO4
         62lI+w8/tD0oj8+UEAFIKpeY8RLGjsQmhvA4cFE0BHEfNTndTVlipTNUV8RXpDyOjBeJ
         O9LOYtT3fh3shAyDKgmJ+6gbefDX9Vc7q4nwrPUeVb0erwY0HtGtJgqHtMk+EnwGIG60
         hWjKOCV1joFsOpBg1u6Bufs/zwsfdqRogHdWL5UoDIlp4x2YOstwDkeJCxhdSWd/P3Wl
         ScRA==
X-Gm-Message-State: ABy/qLZqhSLqUwoImMkW6H6v4Uex5v2T3pYWjPjxNdCVigmcPc9ipu1g
        F1WatXk+NCPl59ViOfNXeX/ZhCpm4mNgvO0iQspo
X-Google-Smtp-Source: APBJJlG01gugR5pBeLSzgr9QaRAnN1lelWD28Wisa41iTTVqrwvQyIgcQU0WMKN/qYg/ivXFlgsOpx2irKkAZegi36c2
X-Received: from axel.svl.corp.google.com ([2620:15c:2a3:200:e20f:5917:3efa:d4bb])
 (user=axelrasmussen job=sendgmr) by 2002:a25:f621:0:b0:bc7:f6af:8cff with
 SMTP id t33-20020a25f621000000b00bc7f6af8cffmr5650ybd.2.1688071852014; Thu,
 29 Jun 2023 13:50:52 -0700 (PDT)
Date:   Thu, 29 Jun 2023 13:50:37 -0700
In-Reply-To: <20230629205040.665834-1-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20230629205040.665834-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230629205040.665834-3-axelrasmussen@google.com>
Subject: [PATCH v2 3/6] mm: userfaultfd: support UFFDIO_POISON for hugetlbfs
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Huang Ying <ying.huang@intel.com>,
        Hugh Dickins <hughd@google.com>,
        James Houghton <jthoughton@google.com>,
        Jiaqi Yan <jiaqiyan@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Nadav Amit <namit@vmware.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        ZhangPeng <zhangpeng362@huawei.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
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

The behavior here is the same as it is for anon/shmem. This is done
separately because hugetlb pte marker handling is a bit different.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 mm/hugetlb.c     | 33 +++++++++++++++++++++++++++++++--
 mm/userfaultfd.c |  6 +-----
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 38711d49e4db..05abe88986b6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6090,14 +6090,24 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 	}
 
 	entry = huge_ptep_get(ptep);
-	/* PTE markers should be handled the same way as none pte */
-	if (huge_pte_none_mostly(entry))
+	if (huge_pte_none_mostly(entry)) {
+		if (is_pte_marker(entry)) {
+			unsigned long marker = pte_marker_get(pte_to_swp_entry(entry));
+
+			if (marker & PTE_MARKER_UFFD_POISON) {
+				ret = VM_FAULT_HWPOISON_LARGE;
+				goto out_mutex;
+			}
+		}
 		/*
+		 * Other PTE markers should be handled the same way as none PTE.
+		 *
 		 * hugetlb_no_page will drop vma lock and hugetlb fault
 		 * mutex internally, which make us return immediately.
 		 */
 		return hugetlb_no_page(mm, vma, mapping, idx, address, ptep,
 				      entry, flags);
+	}
 
 	ret = 0;
 
@@ -6253,6 +6263,25 @@ int hugetlb_mfill_atomic_pte(pte_t *dst_pte,
 	int writable;
 	bool folio_in_pagecache = false;
 
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
+		ptl = huge_pte_lock(h, dst_mm, dst_pte);
+
+		/* Don't overwrite any existing PTEs (even markers) */
+		if (!huge_pte_none(huge_ptep_get(dst_pte))) {
+			spin_unlock(ptl);
+			return -EEXIST;
+		}
+
+		_dst_pte = make_pte_marker(PTE_MARKER_UFFD_POISON);
+		set_huge_pte_at(dst_mm, dst_addr, dst_pte, _dst_pte);
+
+		/* No need to invalidate - it was non-present before */
+		update_mmu_cache(dst_vma, dst_addr, dst_pte);
+
+		spin_unlock(ptl);
+		return 0;
+	}
+
 	if (is_continue) {
 		ret = -EFAULT;
 		folio = filemap_lock_folio(mapping, idx);
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 87b62ca1e09e..4436cae1c7a8 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -381,12 +381,8 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 	 * supported by hugetlb.  A PMD_SIZE huge pages may exist as used
 	 * by THP.  Since we can not reliably insert a zero page, this
 	 * feature is not supported.
-	 *
-	 * PTE marker handling for hugetlb is a bit special, so for now
-	 * UFFDIO_POISON is not supported.
 	 */
-	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE) ||
-	    uffd_flags_mode_is(flags, MFILL_ATOMIC_POISON)) {
+	if (uffd_flags_mode_is(flags, MFILL_ATOMIC_ZEROPAGE)) {
 		mmap_read_unlock(dst_mm);
 		return -EINVAL;
 	}
-- 
2.41.0.255.g8b1d071c50-goog

