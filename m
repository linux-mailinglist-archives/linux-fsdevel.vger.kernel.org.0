Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A03B73AB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 15:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234298AbhF2OCG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 10:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234269AbhF2OCC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 10:02:02 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C5AC061767
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:33 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id p7so7903239qvn.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Jun 2021 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=a9FEw/mlX+aDER0g2+babK847oC7xUdGfaZoTgPtJkQ=;
        b=Vlu3QuZ/rcv1xG90SJOASIDYhc2os7rbaqE0gb/XIf13j6jJXigfLghnHp+VcLlk5M
         +tmvgfHOkRuZhKSaypYBZner2O9PouhzWp4Pbp0R8744onQtvFjNmxv+jtkOEpNpINUh
         IPLgvO+5cR2jdgah4o9rHhZOV/LNI8SRMBHGf5XTOsAYaWEo1FMixPj0agbqVTyvJ3TZ
         cZ9we6mk41WOE5bTxZrsTPwirhDKZLl0jwfxGmUByfvaS2CgigSJjO+RJ0ntlC1X1XHK
         vNI3YFKbTyMoBTUKdiay7uoGhGp4NfXHv5bRGEilufRQ5jodbAUH0rk9gbPl7ZW+xMVU
         +Isw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=a9FEw/mlX+aDER0g2+babK847oC7xUdGfaZoTgPtJkQ=;
        b=QTTq8utmeeqVm2whSMINKZZfNAtykxBTuoPcuDTfy7CT+5KCdxqyJ9eK56gENiU/tE
         1l7sJV738aKt6YLv3KjQHXw1rjyyCniO+/BWD/pio1NLUZCFRbpaFBPPQLOjw4S1bUr3
         1er536flqYOsARXQWEQsf01ep/uWhyxNXJcwkdY3tD3NcQCJvuiaZsHPEY5U54ktzbLx
         kmVDNHyPH/dwGkXHPltvxSqYTtqrUGryQGc+bo+ESQvtyMJPUHU0sZ/I6Ulta9JH2Sbk
         uPOpVc/zvct+ySLGKG1MbMLyqvpXSgmLa2DOWPTttH9LWJvYXYBaiYVGH+uUxeKhhs63
         fLSg==
X-Gm-Message-State: AOAM531rRAx5ooT3bwcc4chlEYU0YJCBD6eiknlU6QRy+E9TDuY+vIgl
        6/AgU9BUPNkR4louYgSIIaE8bw==
X-Google-Smtp-Source: ABdhPJyF58CM+mZKvSxOBHUHW30ZVBaVWPKC/J3naBDg5RYwEHvP7MHU/j1+v/3D4JGphUHUncY2UA==
X-Received: by 2002:a05:6214:16d2:: with SMTP id d18mr11440756qvz.34.1624975172734;
        Tue, 29 Jun 2021 06:59:32 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id b21sm4936518qkh.55.2021.06.29.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:59:32 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH v2 4/8] btrfs: wake up async_delalloc_pages waiters after submit
Date:   Tue, 29 Jun 2021 09:59:20 -0400
Message-Id: <54425f6e0ece01f5d579e1bcc0aab22a988c301f.1624974951.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624974951.git.josef@toxicpanda.com>
References: <cover.1624974951.git.josef@toxicpanda.com>
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

