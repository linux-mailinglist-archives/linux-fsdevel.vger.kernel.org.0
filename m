Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C33292185B0
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgGHLMO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGHLMM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:12 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181DAC08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:12 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so2501255wmg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=E8Ml8tqMdTEJp/V9Pm/cWxKNJj9YiDr2BArYDfp0AdY=;
        b=E6/03atsFQn9XHs/fks6sZMOhg8S4ljEE4AeJXwAaa09a5/R6huaA+IC61pUJs6Cou
         eJONNJKv5J4295qq8D/73ZPLzpGNoST6sDB7W2me/Ac/JlN9dmsg3RP9k5gy7yjQvFhk
         Hmluu7NAXvKU+5oYZGCbpmdarE3hTkU9Q0CfXIC7zhQtFJinNDIdjiYb7GKB5c9SJDAA
         AQtwqCks5r/agfkbSv7mFAfBPqbw35BLpaCwLDvwwpsltTeXZJ2l6yEwATf/isQe8Swv
         Bma4uulIyneEPG+c4qYe6rlFI/mAIpgxP/1fZs/IQoRhgH/UzbUIXEwOlskjL+83Vzgo
         Erqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=E8Ml8tqMdTEJp/V9Pm/cWxKNJj9YiDr2BArYDfp0AdY=;
        b=nRpaekPSOFBe8lYyIyUc1rF0hFTyOqjvTzpSkandk+L6AMThWXAVUMFmiSjtMWHqAB
         PN9pzTCAZfV7ic29i+gtw6uQz4UHb6MXSwz9ZYO4If800kVYuyuLKMZr4CA+kGKO+uIK
         Jc3Xj5+aS3KsfZV7qUkCNz/OKXEHIilNLnuEtRjKFudSsBJKBv0eXP5x1yUdrXtbbFbq
         nHt9Koe0aO13mmmn/SExvHIbtnEYoa6jA6fdUau9Embq65ktMWEYulWn4V4nHY5WWdYf
         sy4rF00I03FxKgcFXXLvshZEG9+wb/nCkGnjro/2sbcgFlsTVO9NyxUqV2lb47VTYh74
         qZTw==
X-Gm-Message-State: AOAM5312G++Ilth0nh4FlDZCT3rFZWBSXOA1XZ1Cpfjeq2BTy/tXxLjy
        La1FXFM06D9UlFp0Uh9qo6C0skJk
X-Google-Smtp-Source: ABdhPJxIhwLq74qHtcs4fme9VfoWXjShyhRldi/OHydxOA4VBAsYjKkCcmApo/MK9UIG+P6VptDcSA==
X-Received: by 2002:a1c:6a13:: with SMTP id f19mr2384021wmc.106.1594206730892;
        Wed, 08 Jul 2020 04:12:10 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:10 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 04/20] nfsd: use fsnotify_data_inode() to get the unlinked inode
Date:   Wed,  8 Jul 2020 14:11:39 +0300
Message-Id: <20200708111156.24659-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The inode argument to handle_event() is about to become obsolete.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/nfsd/filecache.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
index 82198d747c4c..ace8e5c30952 100644
--- a/fs/nfsd/filecache.c
+++ b/fs/nfsd/filecache.c
@@ -599,11 +599,13 @@ static struct notifier_block nfsd_file_lease_notifier = {
 
 static int
 nfsd_file_fsnotify_handle_event(struct fsnotify_group *group,
-				struct inode *inode,
+				struct inode *to_tell,
 				u32 mask, const void *data, int data_type,
 				const struct qstr *file_name, u32 cookie,
 				struct fsnotify_iter_info *iter_info)
 {
+	struct inode *inode = fsnotify_data_inode(data, data_type);
+
 	trace_nfsd_file_fsnotify_handle_event(inode, mask);
 
 	/* Should be no marks on non-regular files */
-- 
2.17.1

