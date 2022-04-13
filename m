Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7AE4FF308
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 11:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiDMJNH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 05:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234286AbiDMJMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:12:12 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF7B186C2
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id r133-20020a1c448b000000b0038ccb70e239so3495518wma.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Apr 2022 02:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TU96ZlVLsOoM0i+tAbwz9u493gtmbJdidxT26D+Nm7U=;
        b=m6HYopknGesTWFQjceC7TRlI5Oj6n9F95MqHUwy13IxtdXbup2Rw7KA/Rm85vTOSZs
         PFcwPf9upYShR3O8YjwNsKNM7Q8AnKfcmheiICM3nY5I/wohgxVYB4MVnH/Lg9UzKi3z
         zOQhwlLMBZTM5gwYGxj4hW0jd4AawUXwI4M9lhUtwQyOXhO2+TUIddXzS7Uhn6J8EK1k
         depcK34M744TKcSLJwiNz4I4Iy6KAHKwlestzt8oUylhgdoguTAVzZuvAcQ2Ux6c22Pv
         pGUvRnzIW2JahoiHgQNC+IUjB4tf8DPNuaCVRND7gMYsz9xIVkZ7BAIVb84qaC0aP478
         k+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TU96ZlVLsOoM0i+tAbwz9u493gtmbJdidxT26D+Nm7U=;
        b=tqoz11b/2mSYtvrvMENePxDvNSK8i2hxUWdZsGjjyj7uG9+RUGmj1WXuujzi0Nbwyr
         5wrLHV3ICShWITVwuF/dsVqKhBEkUvsqUkGsSFONSfuVWsArkdk56FDZAOmu5HGUyRnf
         0EGtwUR7MZqKAhjo/kYjWGTkW/HxM83Q91u7HuXu2EabL0hd3ISKBJvflOdl8CxUvRyu
         /LpHmywYlJSMNfdYDtHtidKC3Pj2TvNhb2T7dXq71al28y+qh98JMNdzp/fReQcVpj/s
         oeLnOYnopqVjBODPJsagAyxEOCLfe6Ha8seQSVuKeOsGdIgkXLAeiGlSJJBPybBEcqvW
         rDZQ==
X-Gm-Message-State: AOAM532FH+cz7RQcMgfnpURRpHWgXEQDrOWVv/v2Z+x2sefi4lH99VFD
        J0tmeoNmttnI+V5nyQgsBR0=
X-Google-Smtp-Source: ABdhPJy/dlY17hCUTmsW39RRjUmjKZMhQXaqTmYlI7mqh1/5Au+2sUjkPK3V/+kHoBJjNepF8geleQ==
X-Received: by 2002:a1c:acc6:0:b0:38e:b184:7721 with SMTP id v189-20020a1cacc6000000b0038eb1847721mr7674757wme.94.1649840990434;
        Wed, 13 Apr 2022 02:09:50 -0700 (PDT)
Received: from localhost.localdomain ([5.29.13.154])
        by smtp.gmail.com with ESMTPSA id bk1-20020a0560001d8100b002061d6bdfd0sm24050518wrb.63.2022.04.13.02.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 02:09:49 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/16] nfsd: use fsnotify group lock helpers
Date:   Wed, 13 Apr 2022 12:09:28 +0300
Message-Id: <20220413090935.3127107-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220413090935.3127107-1-amir73il@gmail.com>
References: <20220413090935.3127107-1-amir73il@gmail.com>
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

Suggested-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20220321112310.vpr7oxro2xkz5llh@quack3.lan/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 79a5b052fcdf..258599db119f 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -119,14 +119,14 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
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
@@ -134,8 +134,9 @@ nfsd_file_mark_find_or_create(struct nfsd_file *nf)
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
@@ -674,7 +675,7 @@ nfsd_file_cache_init(void)
 	}
 
 	nfsd_file_fsnotify_group = fsnotify_alloc_group(&nfsd_file_fsnotify_ops,
-							0);
+							FSNOTIFY_GROUP_NOFS);
 	if (IS_ERR(nfsd_file_fsnotify_group)) {
 		pr_err("nfsd: unable to create fsnotify group: %ld\n",
 			PTR_ERR(nfsd_file_fsnotify_group));
-- 
2.35.1

