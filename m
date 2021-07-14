Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE4E3C8B3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jul 2021 20:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240129AbhGNSuc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Jul 2021 14:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240120AbhGNSua (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Jul 2021 14:50:30 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10723C061764
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id w26so2591331qto.9
        for <linux-fsdevel@vger.kernel.org>; Wed, 14 Jul 2021 11:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNekpPuEULpCMOwivjqUjmNvC4JFfFA0/dEwN2gvg5g=;
        b=MoDWOvkbNfmQlUXE94ddpWnR8t5gaHGSJ4yjF9hcFzocJuEMNyOZq0aFvxFDtDKwQy
         JJlphut81Z+PPnQONtSnYMFucGSF+zX9g2ecRjox/b5J8iOfTxCPI3kLisFrDnxpu+Zv
         0aIORgxoKEB/NX5mVcFHFmXG8gS00we+YAcqhpKk0Dc0yxCGkb31gqbh+LxS86RCf/2A
         1tobbeTjwZ22Ca8Z30PXaFFieWGlJ7AAQnZkQSyKqZX9ARa7ywKNticn3l4Vk/O3BOYK
         Jqw8NKCggtXwtHrNteh4kgvy+HsvNZp1nFibKdoGEJK4P+ONr8lTg2YhDx3H4zyvMCTA
         MPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNekpPuEULpCMOwivjqUjmNvC4JFfFA0/dEwN2gvg5g=;
        b=Qql9PoGBXpvqW04wC7n+gtLGRF0RHlbc5rSA8pybll3Rdpeb9rDMcdI7zHe60E6FHY
         d3EEZZW3+2k/UMGpQM/+U7k0qBpYnpsfKFKwk+nZhR6rLb3T/iFN25jr2L/jSyI5nDRG
         a6eaWp3sTB7B7UZbubfAG43CQkPB4E8Il86Y9jZ57CfeG97eqjjISOecA9bga+KBPKSy
         3XzNI+hFPfoGp1lWmILCAtMhIucgbB/+B8iLHCoStR6+ExwtPbfXLUM27zpYmOmxWlNW
         3eYtkC9E+k2lPJ4BtPV65MmJxb0Nj0y2T9ifa6djgxDtQmwYKlgUshJwMj5pDCrkD7uQ
         3NQg==
X-Gm-Message-State: AOAM531u6g8W9Snow2ucSY4pHWKzgCZf8nYmrrfygKzEP5MK4DgB5O2f
        fZzvaU/ruP+ID6mFTqfdofYvAQ==
X-Google-Smtp-Source: ABdhPJydN+M0zPH+sop8KzTKtnIAH7/w63hbq9eWYwMhRgunXSjejkotX09tiVc2xvwuPFSi8j4uRw==
X-Received: by 2002:ac8:5803:: with SMTP id g3mr10576731qtg.3.1626288457181;
        Wed, 14 Jul 2021 11:47:37 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id q184sm1389219qkd.35.2021.07.14.11.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 11:47:36 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, kernel-team@fb.com,
        linux-fsdevel@vger.kernel.org
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH v3 7/9] btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
Date:   Wed, 14 Jul 2021 14:47:23 -0400
Message-Id: <8b03a72d1b50931637b25daad29fb470fb08dde8.1626288241.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1626288241.git.josef@toxicpanda.com>
References: <cover.1626288241.git.josef@toxicpanda.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

sync_inode() has some holes that can cause problems if we're under heavy
ENOSPC pressure.  If there's writeback running on a separate thread
sync_inode() will skip writing the inode altogether.  What we really
want is to make sure writeback has been started on all the pages to make
sure we can see the ordered extents and wait on them if appropriate.
Switch to this new helper which will allow us to accomplish this and
avoid ENOSPC'ing early.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e388153c4ae4..b25c84aba743 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -9713,7 +9713,7 @@ static int start_delalloc_inodes(struct btrfs_root *root,
 			btrfs_queue_work(root->fs_info->flush_workers,
 					 &work->work);
 		} else {
-			ret = sync_inode(inode, wbc);
+			ret = filemap_fdatawrite_wbc(inode->i_mapping, wbc);
 			btrfs_add_delayed_iput(inode);
 			if (ret || wbc->nr_to_write <= 0)
 				goto out;
-- 
2.26.3

