Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4733DB4CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jul 2021 10:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237979AbhG3IA0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jul 2021 04:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237886AbhG3IAZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jul 2021 04:00:25 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAC0C061765
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 01:00:21 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id z24so8625972qkz.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jul 2021 01:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Y7HX5YFqqvflWtOAFdHp5v6MXY/OcEeQOaBTkBgwruM=;
        b=u8YUNlG7+lu5Is9eMpdvivobPs3T+0kbTL+S17t5SgHQK7ZI42wPzwim0p5Qj9MV7u
         2bU9YmpRo2bxZv0e7RZC0bKrCIrL2hx3bFOEZ6pFcNGTALYst0tCHVstlt4tlGIRQQdX
         YBJkVxUcLZYwRKs5+DEOoB5RT6WXu3viAXutpX6d0PengNqn+KpyfxmeUiJktHHuDf9S
         wz6YT+4+y452/F7EFITeaClRAPZZk6ry5z+Bi8M8uGzUp3dTwWg0eb8/yMP9X5qjqoH0
         P/262T7dGLXaXcsIuhno7w4OQvYVMVnVrxPySbDDf0a4bY6qGegqMAGl1aNtMhFP5DZ/
         8ibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Y7HX5YFqqvflWtOAFdHp5v6MXY/OcEeQOaBTkBgwruM=;
        b=UPsjSwQtVa9O6X/7aXDbIfEpa8QSUTlNVxo3Dp4pXaD4hHvlvdyV7WNCtd0wm6KZSd
         eg9XN+Pjod4sagJHvwmtou5HVbrwj8EyYlzSYAUKWw1mbfdvT01WoZjQrUOO49mRjbxN
         XsOTHDU+8HkGlA7fVONKHOtcFSb9z+AsbAV1Pfvw6s/66qZcmzQCGV17s/azMu9xFBUx
         bBE6p6OUYV+AST2E3qsa+QsBjbFeDmxPgGRplueCnvbkeuUzonr91VH4w4Roq7Ys0sSz
         UWNO5FwJohm2iwnprktcwWk+HOxsbfpUxqNKB9BbGpz0SbLcg/w39g4S8oiD4fw2H304
         4sPA==
X-Gm-Message-State: AOAM533cZirjmyma3X9Nsm6s8GaupJGxew8T2G1jZzh8bx3yrUM3ym0v
        okYk91Qnm17XsUZbHZzBzF7Cew==
X-Google-Smtp-Source: ABdhPJxX+FZqmUvFbB6LFhFizDSmok15mmV3G7aae8zfjyp+xlKCEmRsFFggV9F2XDQhme81TddiHg==
X-Received: by 2002:a05:620a:13a1:: with SMTP id m1mr1061123qki.91.1627632020050;
        Fri, 30 Jul 2021 01:00:20 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m80sm536727qke.98.2021.07.30.01.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jul 2021 01:00:18 -0700 (PDT)
Date:   Fri, 30 Jul 2021 01:00:16 -0700 (PDT)
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
Subject: [PATCH 12/16] tmpfs: refuse memlock when fallocated beyond i_size
In-Reply-To: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
Message-ID: <3e5b2999-a27d-3590-46d9-80841b9427a9@google.com>
References: <2862852d-badd-7486-3a8e-c5ea9666d6fb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

F_MEM_LOCK is accounted by i_size, but fallocate(,FALLOC_FL_KEEP_SIZE,,)
could have added many pages beyond i_size, which would also be held as
Unevictable from memory. The mlock_ucounts check in shmem_fallocate() is
fine, but shmem_memlock_fcntl() needs to check fallocend too. We could
change F_MEM_LOCK accounting to use the max of i_size and fallocend, but
fallocend is obscure: I think it's better just to refuse the F_MEM_LOCK
(with EPERM) if fallocend exceeds (page-rounded) i_size.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/shmem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 6e53dabe658b..35c0f5c7120e 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2304,7 +2304,10 @@ static int shmem_memlock_fcntl(struct file *file, unsigned int cmd)
 
 	inode_lock(inode);
 	if (cmd == F_MEM_LOCK) {
-		if (!info->mlock_ucounts) {
+		if (info->fallocend > DIV_ROUND_UP(inode->i_size, PAGE_SIZE)) {
+			/* locking is accounted by i_size: disallow excess */
+			retval = -EPERM;
+		} else if (!info->mlock_ucounts) {
 			struct ucounts *ucounts = current_ucounts();
 			/* capability/rlimit check is down in user_shm_lock */
 			retval = shmem_lock(file, 1, ucounts);
@@ -2854,9 +2857,10 @@ static long shmem_fallocate(struct file *file, int mode, loff_t offset,
 	spin_unlock(&inode->i_lock);
 
 	/*
-	 * info->fallocend is only relevant when huge pages might be
+	 * info->fallocend is mostly relevant when huge pages might be
 	 * involved: to prevent split_huge_page() freeing fallocated
 	 * pages when FALLOC_FL_KEEP_SIZE committed beyond i_size.
+	 * But it is also checked in F_MEM_LOCK validation.
 	 */
 	undo_fallocend = info->fallocend;
 	if (info->fallocend < end)
-- 
2.26.2

