Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A62A3B662C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jun 2021 17:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234302AbhF1Pyp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Jun 2021 11:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233163AbhF1PyB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Jun 2021 11:54:01 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F9DC09CDDF
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 08:37:24 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id g14so1896632qvo.7
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jun 2021 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=PQ/W8mpYAbUtGA5QrU6gmz/RrpmvrTciMU8aA+nLdpU=;
        b=khibYnwqq5lM5pMwkW1s1YKU5O2p3ID2GgeDSiKiZTy2M61VIAlozaRHzNk+4+u2E6
         IXEatwX+9SJNkcEBYR8opywG7s/Hu0JPyZCIJjIEFvdreNrWzdT2DH8dQpfvQsf+2Uxa
         q/MfSsSR/hHdKB1Z7CMW1ikhvXEGXGTTTUK1LY0+SXjk/5On9MHUS+6+BdJj57fwd62z
         gsKhZr7uahNVL2tMWORu/obVa7FVkdJ4FExaxx/IER7FEdl8GIZCvcEiHMnHzmeRacAt
         wWLyzOUryo8Yy3Q97nqLRic5CaTEAYrW4cKqm5CKVJfIQoeFxv8naG5dFSzjPvRXau4Z
         KVRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQ/W8mpYAbUtGA5QrU6gmz/RrpmvrTciMU8aA+nLdpU=;
        b=gshqFN2sENwZpY1u3EHnX52aMe2uOAzpBbhpxiaIQUEHWMZJn5MZHjtZXcFJ2CgVqt
         LdzGT7T7/grlmtSv+brtcW3/UX9+Iy7E0v2B3I2qkFz7mKCZah6Q6ACs8Qs49V3rGHfy
         DzPIpH8CEedvo8uPbZpvHEzPM8ZOXCVTLqmTQV+ZvafkDRgwdddvmHQZ70tc5oUtgmlp
         BfjK6uKKBcnlQs09BwzOstDOqhr047bhhgmT3PbfCXJUx3t2KHeHQgUXr4Acgg/7GwBR
         cqP5rNG13rpj6royAGzBQuN9+yciH/YYIHIAK102jqZAX2gPmjF+qY04yl1VeAVrXqbm
         zbDA==
X-Gm-Message-State: AOAM532OAwZWFfvX82X53BBMCNfdxk0gU0M97SCdg0x1to2a81B6SYB6
        V7loqvJgpPlfVcZTi1ookXuLVw==
X-Google-Smtp-Source: ABdhPJxiJb/mzIIWLXVp9OGUyWoUSeFXtg3t1UNiibi8Ktk9aMBlwo+w1KSt+OQdHautRK+V5jSlrg==
X-Received: by 2002:a05:6214:15d0:: with SMTP id p16mr4588383qvz.21.1624894643431;
        Mon, 28 Jun 2021 08:37:23 -0700 (PDT)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id e12sm940104qtr.32.2021.06.28.08.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jun 2021 08:37:23 -0700 (PDT)
From:   Josef Bacik <josef@toxicpanda.com>
To:     linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-team@fb.com
Subject: [PATCH 6/6] btrfs: use the filemap_fdatawrite_wbc helper for delalloc shrinking
Date:   Mon, 28 Jun 2021 11:37:11 -0400
Message-Id: <2acb56dd851d31d7b5547099821f0cbf6dfb5d29.1624894102.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.26.3
In-Reply-To: <cover.1624894102.git.josef@toxicpanda.com>
References: <cover.1624894102.git.josef@toxicpanda.com>
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

