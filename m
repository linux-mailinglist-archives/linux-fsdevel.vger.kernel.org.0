Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73CBF779FFF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Aug 2023 14:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236752AbjHLMiB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Aug 2023 08:38:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjHLMiA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Aug 2023 08:38:00 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD7A519A3;
        Sat, 12 Aug 2023 05:38:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99cdb0fd093so396763266b.1;
        Sat, 12 Aug 2023 05:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691843882; x=1692448682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UClbfeDcgLrN9gw9PYVkTWcXPt6ww2x5TRV68gA4hiI=;
        b=mh6Y4ZEZNsyNB3U7m5PslH3Ec3aMSRICP6qsSSA35bJik7XE1bXlzPV4G2IvonEBmL
         P1vgs5rslx+GlIWKkENxVFFheO/KpA5bNNek4UnkDK/HbpwTubAsf4uai1aH+zpKC/t+
         qEvyiBZ/nGp/ZYxgQS5fTv8ZgmHEYOkxpwM/zLYbttCEwhrSg9VEteT1YT2hCm5+z+7K
         T5VMWnO5NSc9WRa9af7uhl5EVmCa3Pe44axlqza2W9q3iTu6/UOANb1rHMygQYZR/fRI
         uxT3ltNBVCbqXXiqBzK07TznU5CKKmCtQPYjh49anInv3w/Y+t0pe6MAkc+toCdURrB9
         AD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691843882; x=1692448682;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UClbfeDcgLrN9gw9PYVkTWcXPt6ww2x5TRV68gA4hiI=;
        b=hauhC2IHEYV6XgBhZZbFME/sUcDFJWOwDt1lREmgmqL4DMxhtgPSysXgzM5NqqGhJt
         oiwswV/7j+qNFH6xKDMWM+poW4DnM69FBCRhvrjdwQbu1MJmyvckRpo81s2hbvMQl1Wu
         DNsHWwa95SyMD5zmqNoLwxwsv867lSCqN1B5T8slJKkabLI0eSJTxK/3URY0sYfWHFtB
         L4zPALu858ZVd6zCGCd97Q7WXwgTeB4ThDUW+tLpqdjpuQeQ+sr7PuLAjNYbhD5IoNH+
         OGFm1imsHYVAEllQ8jbh1AZiPVcNCusf/2q+GlHrw00f6D5dUKtBGywI0ATPB1L6TBSX
         twSg==
X-Gm-Message-State: AOJu0YwioOOxDJpdUd5FufGKpBZXRHeZtCws9G7F9Z/Kb5uC2604meFU
        fu/n2HA6vdUxkTHut53QN2180ZSeEM8=
X-Google-Smtp-Source: AGHT+IFYU1RN/MTxWLpvJAIWzkUVKtZAVkG4w3OzsyqyMTgzoQILlHGbWZ61jh4ynW7r+F/uvw9Tiw==
X-Received: by 2002:a17:906:291:b0:99b:efd3:3dcc with SMTP id 17-20020a170906029100b0099befd33dccmr4173224ejf.62.1691843882069;
        Sat, 12 Aug 2023 05:38:02 -0700 (PDT)
Received: from f.. (cst-prg-75-195.cust.vodafone.cz. [46.135.75.195])
        by smtp.gmail.com with ESMTPSA id ov14-20020a170906fc0e00b0099290e2c163sm3402567ejb.204.2023.08.12.05.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Aug 2023 05:38:01 -0700 (PDT)
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     brauner@kernel.org
Cc:     viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH] vfs: remove spin_lock_prefetch(&sb->s_inode_list_lock) from new_inode
Date:   Sat, 12 Aug 2023 14:37:57 +0200
Message-Id: <20230812123757.1666664-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It showed up in 2001, in the following commit in a historical repo [1]:

commit c37fa164f793735b32aa3f53154ff1a7659e6442
Author: linus1 <torvalds@athlon.transmeta.com>
Date:   Thu Aug 16 11:00:00 2001 -0800

    v2.4.9.9 -> v2.4.9.10

with a changelog which does not mention it.

Since then the line got only touched up to keep compiling.

While it may have been of benefit back in the day, it is guaranteed to
at best not get in the way in the multicore setting -- as the code
performs *a lot* of work between the prefetch and actual lock acquire,
any contention means the cacheline is already invalid by the time the
routine calls spin_lock(). It adds spurious traffic, for short.

On top of it prefetch is notoriously tricky to use for single-threaded
purposes, making it questionable from the get go.

As such, remove it.

I concede upfront I did not see value in benchmarking this change, but I
can do it if that is deemed appropriate.

Also worth nothing is that this was the only remaining consumer.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git/commit/fs/inode.c?id=c37fa164f793735b32aa3f53154ff1a7659e6442
Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
---
 fs/inode.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 8fefb69e1f84..67611a360031 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -16,7 +16,6 @@
 #include <linux/fsnotify.h>
 #include <linux/mount.h>
 #include <linux/posix_acl.h>
-#include <linux/prefetch.h>
 #include <linux/buffer_head.h> /* for inode_has_buffers */
 #include <linux/ratelimit.h>
 #include <linux/list_lru.h>
@@ -1041,8 +1040,6 @@ struct inode *new_inode(struct super_block *sb)
 {
 	struct inode *inode;
 
-	spin_lock_prefetch(&sb->s_inode_list_lock);
-
 	inode = new_inode_pseudo(sb);
 	if (inode)
 		inode_sb_list_add(inode);
-- 
2.39.2

