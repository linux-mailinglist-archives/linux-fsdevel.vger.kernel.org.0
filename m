Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34E0632084
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 12:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbiKUL0l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 06:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbiKUL0L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:26:11 -0500
Received: from mail-wr1-x44a.google.com (mail-wr1-x44a.google.com [IPv6:2a00:1450:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8316DBFF5A
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 03:21:42 -0800 (PST)
Received: by mail-wr1-x44a.google.com with SMTP id w11-20020adfbacb000000b002418a90da01so3089896wrg.16
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 03:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V66iN5ZNYfCs2IKwl/XWPfYUEeh8Am+8/6YCzEI2D8c=;
        b=DrqkFhwq+x32T++mKGiLwBwBQlLcPegquOjKmY4DA36Bdlu1UHyvmrWX1hBJRhVkQ6
         CuCW3GY8rqEftTjZZrLMe7/mkVQz7UfhK+xIE67b7ScIXkJpIv8j5OGL6cLYo9+mckRB
         K7uXn7jnhwdTz8CKtd1PZLB/aUu4HHTidPyJYgxXX5idXFCZCOZVGyv8hmv6enXEqnwn
         sySci2PTifGmbTVUqgKzOGBN+JGcWBPg2j+F9wLZjNT18VaSguq8lzh50Et/vzVO1B6Q
         2Y+EGhsTlaR3AYtHfVR7KGPKNpJOX8E3kDw+u1VmZZUxfQ8uANGRO5Nfw1xQZ/dSm2xH
         GfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V66iN5ZNYfCs2IKwl/XWPfYUEeh8Am+8/6YCzEI2D8c=;
        b=mGgSTis2C98jWsuFi/E86GrgUlOAc3vx35S/XHA6sVSw46vjcB2oqHvAtLl3NR8N5A
         Sw5cqZtrwGiodwqVdagay/YwX+pmxq6AuIuzOmTuOT+WQG+YdIIYAd1JhbgMyrnTNBFY
         56PoXH7/Ctsqdn2aOMWgIwXVCpl4THUF4rxkPARkzW7XoSy8rCE59GMh26vm1np6Bpix
         MNWGecVgbHaCLiEyA2d5i7wE7liudg6MqLoq7frhwgtihDb7BVaCBdGhhdn8RrUfZJiH
         8aRVNzG/RAV1+CxvCjXPHm37wTCuYyw4KjHBJ3k2FMNzFcFJerOXgnuPGKn6vSTXHYqT
         V0Rw==
X-Gm-Message-State: ANoB5pnCoOXJmpqnRBeYlViLLckSCMZX/EIFjEuThwhpKXMh5W//ivNN
        dk3F3uyOCSt2/sVHP4zhmOs+O6gw2jY=
X-Google-Smtp-Source: AA0mqf5PzJbpaiga2Jzsuv2QBaVRj0ECKQH/8ki+ITevGs4ly1kTH35yKTlXkQW0dHRua5gsG9D3oRFruQ0=
X-Received: from glider.muc.corp.google.com ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:adf:e50f:0:b0:22c:cc75:5aab with SMTP id
 j15-20020adfe50f000000b0022ccc755aabmr10402338wrm.143.1669029701044; Mon, 21
 Nov 2022 03:21:41 -0800 (PST)
Date:   Mon, 21 Nov 2022 12:21:31 +0100
In-Reply-To: <20221121112134.407362-1-glider@google.com>
Mime-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-2-glider@google.com>
Subject: [PATCH 2/5] fs: affs: initialize fsdata in affs_truncate()
From:   Alexander Potapenko <glider@google.com>
To:     glider@google.com
Cc:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        chao@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Eric Biggers <ebiggers@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When aops->write_begin() does not initialize fsdata, KMSAN may report
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/affs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/affs/file.c b/fs/affs/file.c
index cefa222f7881c..8daeed31e1af9 100644
--- a/fs/affs/file.c
+++ b/fs/affs/file.c
@@ -880,7 +880,7 @@ affs_truncate(struct inode *inode)
 	if (inode->i_size > AFFS_I(inode)->mmu_private) {
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		loff_t isize = inode->i_size;
 		int res;
 
-- 
2.38.1.584.g0f3c55d4c2-goog

