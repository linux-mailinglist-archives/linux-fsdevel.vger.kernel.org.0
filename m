Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C053C8B2E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239819AbhGNSuW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbhGNSuW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:22 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889BEC061762
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id c15so1539154qvw.6
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NEIgkiTj4t3jttXcyN/5zz8YqcqMXxtRu1nEAsbHwxE=;
        b=p+t/WKtRaf1tvAClAUr+ZmzhvTPUK1x9+pxpPkUkK9ebhmfVYlIezYHVv5zK8FI0EC
         dOS9cdzvmSuG/oXQ7jwhUdwwolA2ZtTOQqP115r4SFQR8iaZUuNnF2phPKQTzCoKEqhs
         B63TppqB5ueS98zoW2li+i9GcNO+iokQJpwOKXm/lh0ruStga2kj1s3UONzCxtt//8lT
         o7lOzjkzs+i1M9TkP4ZfKWbmzokra4mxYfYEkM9VMSIH8OEPzN+n2/GmyilJ1F+3Ed+V
         OosJ8lNyw44JzjXumqin6jJvOJqoFGfMpNJPTjiCycK7kPks4XB9N50Wdk/Cu03ga2Qq
         uFcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NEIgkiTj4t3jttXcyN/5zz8YqcqMXxtRu1nEAsbHwxE=;
        b=AJqqadv5pQwEaPBrHzjMrxmxljYwOQYWn3Y9eq2g98aGZUluhK5zMOBwNmkwIe3dM/
         7zhi0CAlU4Ucdcsvu2AGRf443uzxwzn4DQLCRd5SxXpqbNT0Fq0LMi4nMXafA7zJgBLK
         HyP/RFEd69eAxVr0Ik5Toc0f0XiKpeotYFCrO31vRX03jk21GIxftUBJALXAQ8CNXMq9
         /DWlZ6cUYa7k47I8fFTvtSAWKWbgOq6go/aurlDJKHwzX93NMzr8yL5c1WIlr548SpOb
         OlukQb3QN2ryCr57oJKVMh8KC8m1aSyI0U86+bbDFFf6XWM+ZruEBRZDGLyq/Q2gfm3g
         dfDQ==
X-Gm-Message-State: AOAM530yeRoZ9Ln/4nsVo+nzXu61Wsuhx4QuxPlLcINon0NgXB5mWBpM
        P9rlWm2Ae7PyVX3Y9jzqizwXab2NzdBnJI7K
X-Google-Smtp-Source: ABdhPJxZG8yTJlXAWrF55wKnikwJzt6/9WAyS7O1ymLPDGQRhmqUeoOYUjprybts1WfL3aPcNUKmsw==
X-Received: by 2002:a05:6214:d08:: with SMTP id 8mr12484989qvh.32.1626288448684;
        Wed, 14 Jul 2021 11:47:28 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id 3sm1077237qtz.5.2021.07.14.11.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:28 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Cc:     stable@vger.kernel.org, Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 1/9] btrfs: wake up async_delalloc_pages waiters after submit
Date:   Wed, 14 Jul 2021 14:47:17 -0400
Message-Id: <dac85f4251481dcee67e93f0dd1e119c68041fab.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We use the async_delalloc_pages mechanism to make sure that we've
completed our async work before trying to continue our delalloc
flushing.  The reason for this is we need to see any ordered extents
that were created by our delalloc flushing.  However we're waking up
before we do the submit work, which is before we create the ordered
extents.  This is a pretty wide race window where we could potentially
think there are no ordered extents and thus exit shrink_delalloc
prematurely.  Fix this by waking us up after we've done the work to
create ordered extents.

cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e6eb20987351..0f42864d5dd4 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -1290,11 +1290,6 @@ static noinline void async_cow_submit(struct btrfs_work *work)
 	nr_pages = (async_chunk->end - async_chunk->start + PAGE_SIZE) >>
 		PAGE_SHIFT;
 
-	/* atomic_sub_return implies a barrier */
-	if (atomic_sub_return(nr_pages, &fs_info->async_delalloc_pages) <
-	    5 * SZ_1M)
-		cond_wake_up_nomb(&fs_info->async_submit_wait);
-
 	/*
 	 * ->inode could be NULL if async_chunk_start has failed to compress,
 	 * in which case we don't have anything to submit, yet we need to
@@ -1303,6 +1298,11 @@ static noinline void async_cow_submit(struct btrfs_work *work)
 	 */
 	if (async_chunk->inode)
 		submit_compressed_extents(async_chunk);
+
+	/* atomic_sub_return implies a barrier */
+	if (atomic_sub_return(nr_pages, &fs_info->async_delalloc_pages) <
+	    5 * SZ_1M)
+		cond_wake_up_nomb(&fs_info->async_submit_wait);
 }
 
 static noinline void async_cow_free(struct btrfs_work *work)
-- 
2.26.3

