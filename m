Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A49023DB488
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 09:31:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237832AbhG3HbH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 03:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbhG3HbG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 03:31:06 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA59AC0613CF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:31:00 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id 129so8585634qkg.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=nVKTzg+zegoJ7pq31Eztzo2O8w5rVTTFPmYOBnSB5HQ=;
        b=I5y09he3LMg9nKJBO/RVZIAjX6eTPeNw3nDjtVgbJJDsdfBWEvUcV7yl3ay/o2aq3N
         U/3Db1OVkuwPTecxrJzo9KsnCtel83a2PlXjtiNu0Rmayu9sRgJrg1Y3QGGP6uDxv80+
         WbBfX4kJ+XgAia/sidQoA3Vk7ZCYy1wJR60sTwGylISHBMWoKN/vkV4GWBs7zEx+mGll
         u4M62kd1imThj2ggOgJ585Fitxj1BfSa+4J1Va4PDDiO5VdAta3MHT4du6H9lezICkVs
         K08fxnzZpkjVK8KJuM0jehbU6wPy6juKuaTpVaNVWtJ8OnEvN/N1ZCEjky/4Wup1/IZV
         4EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=nVKTzg+zegoJ7pq31Eztzo2O8w5rVTTFPmYOBnSB5HQ=;
        b=Zj3lp8QvyMBobiMoeXcvwzKJUN68lG1FqYjUAfcuTHlcfM+Kqtiw7uCw7eoz5XFfuE
         XGleXdQZ63ugmMnBTvYUfh0gNZcVsrbpIKe1ciiiWZN/sVz28ZMUB7LAKtYybMLRIl23
         fSRE59PtNwLbsJwedz8y543ZITvG6QAj6yR9DV2/f9bvMFzBa+lZBx4cgElH/BgstqlM
         9OgrVuSBFkAkQZnhXO9c517gd6NjYKYok9w1NV/HJCLABmjQsVpED0qqIohN63y6km0n
         g+3i+4KRBGdAfCN19vKXrCeCxxQGfO45+HDzhx3zdcPuplQGeCUhNceZS7BBS7iuFtIk
         szrw==
X-Gm-Message-State: AOAM531JruFwiFbf+Sjh7MIfQ80lmkK9nZKBVMq4ineKOSjWPFRnvjNS
        A6VUT59BXLzqZIcPWCKZc6o9VQ==
X-Google-Smtp-Source: ABdhPJxDC7noWhmpF/FxW8qRqxgJS863LkrD33kURWaXcju0YbgRvrIQ99//7ad611wyKnJPjLJpKA==
X-Received: by 2002:ae9:e002:: with SMTP id m2mr1031128qkk.474.1627630259647;
        Fri, 30 Jul 2021 00:30:59 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id c6sm504860qke.133.2021.07.30.00.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 00:30:58 -0700 (PDT)
Date:   Fri, 30 Jul 2021 00:30:56 -0700 (PDT)
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
Subject: [PATCH 03/16] huge tmpfs: remove shrinklist addition from
 shmem_setattr()
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <42353193-6896-aa85-9127-78881d5fef66@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There's a block of code in shmem_setattr() to add the inode to
shmem_unused_huge_shrink()'s shrinklist when lowering i_size: it dates
from before 5.7 changed truncation to do split_huge_page() for itself,
and should have been removed at that time.

I am over-stating that: split_huge_page() can fail (notably if there's
an extra reference to the page at that time), so there might be value in
retrying.  But there were already retries as truncation worked through
the tails, and this addition risks repeating unsuccessful retries
indefinitely: I'd rather remove it now, and work on reducing the
chance of split_huge_page() failures separately, if we need to.

Fixes: 71725ed10c40 ("mm: huge tmpfs: try to split_huge_page() when punching hole")
Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 24c9da6b41c2..ce3ccaac54d6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1061,7 +1061,6 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 {
 	struct inode *inode = d_inode(dentry);
 	struct shmem_inode_info *info = SHMEM_I(inode);
-	struct shmem_sb_info *sbinfo = SHMEM_SB(inode->i_sb);
 	int error;
 
 	error = setattr_prepare(&init_user_ns, dentry, attr);
@@ -1097,24 +1096,6 @@ static int shmem_setattr(struct user_namespace *mnt_userns,
 			if (oldsize > holebegin)
 				unmap_mapping_range(inode->i_mapping,
 							holebegin, 0, 1);
-
-			/*
-			 * Part of the huge page can be beyond i_size: subject
-			 * to shrink under memory pressure.
-			 */
-			if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE)) {
-				spin_lock(&sbinfo->shrinklist_lock);
-				/*
-				 * _careful to defend against unlocked access to
-				 * ->shrink_list in shmem_unused_huge_shrink()
-				 */
-				if (list_empty_careful(&info->shrinklist)) {
-					list_add_tail(&info->shrinklist,
-							&sbinfo->shrinklist);
-					sbinfo->shrinklist_len++;
-				}
-				spin_unlock(&sbinfo->shrinklist_lock);
-			}
 		}
 	}
 
-- 
2.26.2

