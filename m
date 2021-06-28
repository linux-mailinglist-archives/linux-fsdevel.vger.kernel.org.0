Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CE73B6627
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 17:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbhF1Pyi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 11:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233904AbhF1Pxw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:53:52 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31494C061094
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 08:37:20 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id q16so6346657qke.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9FEw/mlX+aDER0g2+babK847oC7xUdGfaZoTgPtJkQ=;
        b=g1hVnL5vEe01gElT6lkPkTLuN9eYnV5E31nrPHzPH2QVuKZlG8/Bh/rUtLwO6Hx23S
         QlpyrH31Wgw7R+kSZH+UBSEH0CSqfnqVJevhFYezsIt9KIbQ7BNgMi0BAO25RQcdkgwc
         1pvWdmW3z/GYezQyeljEr5jbfK6xZaFQyo4oOw9u9ze//JAbog590TSELSMfLc0fjQjA
         Y2EAfmUKjZxE9uyLiApv8TkuXAbYOquRxcNetWULmdBgL/Y7Q68kgYCoeT56e9JhANJ/
         VTyJC3gaheL7O91pys4+1kBGK92HIw699tqGbxuf46ijpcsENDnxOhwcOnxxFQA/0+sQ
         +K4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9FEw/mlX+aDER0g2+babK847oC7xUdGfaZoTgPtJkQ=;
        b=WwV+e8vnNpD9Mq8WPDabSjo2yGg8hbTDN2r235uYrXlw1UqTDpd07OZYRMK57vdM0e
         hS/9soqhAIFuHiaHmG/72ogyhEkABMrbu6HV6YzwpAZFqkcUnF1Lp082THnoRiw2chVv
         t8hbx3Ead1ygRQBn8pw9rXPmIIaoRoMEuwLFa2hNZqIsrKF1TepToOCKSxbUl99ZgUQS
         h6okkahEQuBAVznJOM/WM8LHMCg4qJcj4j4mwfMaL1LFEslJNJ/fx6hX/RMolYFXjdgx
         njaI1LrV3rGEw8uTvvy8FRQ5X8UQzPx6c7Cwr5FO7fTPp9o02Ty/fgWw9ZMCoHDvK+6I
         7LpQ==
X-Gm-Message-State: AOAM532vGN2WVWkZ46cHoucdbNJEtEkuIFErXtPBO0iJF6K6ld1y4CsU
        7eiGIZ3FyGiLSWMHH3pSTjI/aA==
X-Google-Smtp-Source: ABdhPJxYmj0tEwDN2Cbu+e/r9E8ss72xoqfjT59Uz7dit2Sn6cGFSeDWEEcgbZMsyQYBp1G/JPLafA==
X-Received: by 2002:a37:d55:: with SMTP id 82mr12707081qkn.330.1624894639311;
        Mon, 28 Jun 2021 08:37:19 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o27sm7961728qkj.98.2021.06.28.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 08:37:18 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Cc:     stable@vger.kernel.org
Subject: [PATCH 4/6] btrfs: wake up async_delalloc_pages waiters after submit
Date:   Mon, 28 Jun 2021 11:37:09 -0400
Message-Id: <54425f6e0ece01f5d579e1bcc0aab22a988c301f.1624894102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624894102.git.josef@toxicpanda.com>
References: <cover.1624894102.git.josef@toxicpanda.com>
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
---
 fs/btrfs/inode.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index b1f02e3fea5d..e388153c4ae4 100644
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

