Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B874EA8C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 09:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233603AbiC2HvT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 03:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233584AbiC2HvK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 03:51:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657E31E7452
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:23 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so950202wme.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Mar 2022 00:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gNHmQfdW9fAdfJsuOOGbavQtw86ytVUNrHym0e+zLfE=;
        b=bhzt3sYzCkOBO47uEMXBfD3KWmO5Wypui8tfzpHNVoMgfJptGfM62wEA3MZXSH+ho7
         NHNleFGQlFngaqwPS04OnzvXB3NQk4bVhHtpFgbhaGsqyVCg4rBcD8E06CCTHFIsU+fG
         DJgRunDw/oO1HFo4eCvznT8vKMMTiebu51hF10BHDmm+K9D7nvcNkbj42lEMO+7T8JC1
         oUusiRIxYaakDeuXGNYZCLoh6UKZpC+YWUBYIcMh1FSvML7iUkodp2QU0LnJORBedgDE
         FyIZKC8QEjvxgkBmPHgXAJnHSwWjMGHutWHZAqsBhghi3Xpl8lzWUzzbPBe5M1h9/q7M
         Kcvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gNHmQfdW9fAdfJsuOOGbavQtw86ytVUNrHym0e+zLfE=;
        b=C0PGL44NQ3h2LX37y7aRujXWD0TWpsgVa022Xpywws6MpJRmT1mPdRW1gnVoIeRPVB
         EhxbpTJyqUR7N5MK4q9FS0tgtssKy0Jh5bkzCEXr9RVIRECayV49tkBwpAuoJvbvKNCq
         ZHDlk7Rsm5I6iM5lIrh3otCxniHbfQuNv+ivqeCaqbhNLkSy1/+xu2pbtcmKMiBkj3Ii
         8GTGe4pNN8lSxyYv8a+MKMmenGv9ZpFZQMzFHk1kz1akjFkCVi5TRmQKDLUZ6hRXSVEi
         ePU0gm2Jq4Z1tsI/vI3oLZeYKnMfytsGLOIpHoums7RoiB1/qBunfYjgJc+LcQGinyw5
         8XBg==
X-Gm-Message-State: AOAM531jds/teBMGAkqaGmeDT3ISn4Y3tyn/gX20XT9XbqVDTEMGIPDQ
        FGXq/I6rYpB++dz3O3vqIXJZkWTLHrI=
X-Google-Smtp-Source: ABdhPJyOmiobtUguFLLwC7iyDxYrtCKAIQlFRwjhxn+wl3tAD3dzADSrh8s7ni5gebhFtJNzGhSKLw==
X-Received: by 2002:a05:600c:4ec8:b0:38c:90fb:d3bf with SMTP id g8-20020a05600c4ec800b0038c90fbd3bfmr5020226wmq.0.1648540161956;
        Tue, 29 Mar 2022 00:49:21 -0700 (PDT)
Received: from localhost.localdomain ([77.137.71.203])
        by smtp.gmail.com with ESMTPSA id k40-20020a05600c1ca800b0038c6c8b7fa8sm1534342wms.25.2022.03.29.00.49.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 00:49:21 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 09/16] nfsd: use fsnotify group lock helpers
Date:   Tue, 29 Mar 2022 10:48:57 +0300
Message-Id: <20220329074904.2980320-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220329074904.2980320-1-amir73il@gmail.com>
References: <20220329074904.2980320-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Before commit 9542e6a643fc6 ("nfsd: Containerise filecache laundrette")
nfsd would close open files in direct reclaim context and that could
cause a deadlock when fsnotify mark allocation went into direct reclaim
and nfsd shrinker tried to free existing fsnotify marks.

To avoid issues like this in future code, set the FSNOTIFY_GROUP_NOFS
flag on nfsd fsnotify group to prevent going into direct reclaim from
fsnotify_add_inode_mark().

The lookup of fsnotify mark does not allocate memory so the nofs
variants of fsnotify group helpers are not needed.

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 8bc807c5fea4..0a104e530934 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -118,14 +118,14 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 	struct inode *inode = nf->nf_inode;
 
 	do {
-		mutex_lock(&nfsd_file_fsnotify_group->mark_mutex);
+		fsnotify_group_lock(nfsd_file_fsnotify_group);
 		mark = fsnotify_find_mark(&inode->i_fsnotify_marks,
-				nfsd_file_fsnotify_group);
+					  nfsd_file_fsnotify_group);
 		if (mark) {
 			nfm = nfsd_file_mark_get(container_of(mark,
 						 struct nfsd_file_mark,
 						 nfm_mark));
-			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
+			fsnotify_group_unlock(nfsd_file_fsnotify_group);
 			if (nfm) {
 				fsnotify_put_mark(mark);
 				break;
@@ -133,8 +133,9 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
 			/* Avoid soft lockup race with nfsd_file_mark_put() */
 			fsnotify_destroy_mark(mark, nfsd_file_fsnotify_group);
 			fsnotify_put_mark(mark);
-		} else
-			mutex_unlock(&nfsd_file_fsnotify_group->mark_mutex);
+		} else {
+			fsnotify_group_unlock(nfsd_file_fsnotify_group);
+		}
 
 		/* allocate a new nfm */
 		new = kmem_cache_alloc(nfsd_file_mark_slab, GFP_KERNEL);
@@ -613,6 +614,7 @@ nfsd_file_fsnotify_handle_event(struct fsnotify_mark *mark, u32 mask,
 
 
 static const struct fsnotify_ops nfsd_file_fsnotify_ops = {
+	.group_flags = FSNOTIFY_GROUP_NOFS,
 	.handle_inode_event = nfsd_file_fsnotify_handle_event,
 	.free_mark = nfsd_file_mark_free,
 };
-- 
2.25.1

