Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D35A3DB4B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237851AbhG3HvJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbhG3HvI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:51:08 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DB0C0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:51:04 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id x3so8614731qkl.6
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=ZYvXgAMhZX01NKmlvH33RhZ44JsHMLRjdU/+X4oPAP0=;
        b=M++CnQDxvFEiHc9PulkSLAh6kL9L0Mf02pYSg26QbAHd0RupUQVcTbQ6JejGvxhBWa
         uDCs7A2+Blzlyec01AEwB3KYzygoRhepQ6cM7zkuC26SuVwQAgqYyDMYGvAb+p6tuWVt
         uAti9yDs3Y0FMyKX/H1+I893Cjxm2AstBrNhJ5/Yj6dO2Njiiu0h7F7BLrpjKHQf7Ag3
         iOEagjkCO1QRJk1OwPPNUwpwm6/wsrkuI72zheG31DfrIoFPKjDcKUJykTvL4iMsvS+h
         dkQMCsTsIQBzcYeQAaiSJFwaYWNXTllFQVFbKi2YeGxu3YbeQ8/w4dCKKQF9WC7QqTrC
         hx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=ZYvXgAMhZX01NKmlvH33RhZ44JsHMLRjdU/+X4oPAP0=;
        b=OUwIRLvx59Jsv2bjiL4DKqkbh1favT8jHkPpFOaR74PeYKEMYLeK4/ksBVeUTBQjiH
         uxlZhu9npQb9PpyETUIdbNFHzvnaf790zcuFNWeKqoNzIsA4RSd6OlI5CbhI7c4EJTM5
         8A+huxoFKMhdn2l/RpbRdu6Zx1nxQuetmj+I21nNR95LvEGexQf6s2F1MhGVkhKW+0Lj
         XCKidaRK2W2XQw0CxSDbLfcGu9VlNuy67hoNfWh0knE0/32ue4zd7KDU2IMAiMbyo3jy
         ukmZHbD5SXoQXDRA8qVwLbAMiKxYhLX8LLltBGivytRkEUcBqvyvhmw/0mfxNxyKlwsE
         JzCg==
X-Gm-Message-State: AOAM53120CAvOkMfURudUCvBS7XnjLYbt7R6H9mqR8zbAoK6jHd2HBhH
        5MJjerccC+IWJZtv2WgP7hPwTg==
X-Google-Smtp-Source: ABdhPJyPBn/olLKduBhhHdPeEPWykg5rqcweE1bgQNc9dr4GS3RCw9sWt+ENRQNyeOq3zhFv/hgaog==
X-Received: by 2002:a05:620a:1242:: with SMTP id a2mr1063374qkl.443.1627631463539;
        Fri, 30 Jul 2021 00:51:03 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x7sm507569qki.102.2021.07.30.00.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:51:02 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:51:00 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 09/16] huge tmpfs: decide stat.st_blksize by
 shmem_is_huge()
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <e6e572-f314-8a43-41a7-7582759d24@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

4.18 commit 89fdcd262fd4 ("mm: shmem: make stat.st_blksize return huge
page size if THP is on") added is_huge_enabled() to decide st_blksize:
now that hugeness can be defined per file, that too needs to be replaced
by shmem_is_huge().

Unless they have been fcntl'ed F_HUGEPAGE, this does give a different
answer (No) for small files on a "huge=within_size" mount: but that can
be considered a minor bugfix.  And a different answer (No) for unfcntl'ed
files on a "huge=advise" mount: I'm reluctant to complicate it, just to
reproduce the same debatable answer as before.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 67a4b7a4849b..f50f2ede71da 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -712,15 +712,6 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
-static inline bool is_huge_enabled(struct shmem_sb_info *sbinfo)
-{
-	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE) &&
-	    (shmem_huge == SHMEM_HUGE_FORCE || sbinfo->huge) &&
-	    shmem_huge != SHMEM_HUGE_DENY)
-		return true;
-	return false;
-}
-
 /*
  * Like add_to_page_cache_locked, but error if expected item has gone.
  */
@@ -1101,7 +1092,6 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = path->dentry->d_inode;
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sb_info = SHMEM_SB(inode->i_sb);
 
 	if (info->alloced - info->swapped != inode->i_mapping->nrpages) {
 		spin_lock_irq(&info->lock);
@@ -1110,7 +1100,7 @@ static int shmem_getattr(struct user_namespace *mnt_userns,
 	}
 	generic_fillattr(&init_user_ns, inode, stat);
 
-	if (is_huge_enabled(sb_info))
+	if (shmem_is_huge(NULL, inode, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
 
 	return 0;
-- 
2.26.2

