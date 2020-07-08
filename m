Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD842185AF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728700AbgGHLML (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728466AbgGHLML (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:11 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8FA0C08E6DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:10 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 22so2501142wmg.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUb/hJFbGNPx/GA4uExNVhANvviQpWzogW7D2fGl5nk=;
        b=dcd6SfD1Q7sSM50XntDWnsdFE5pM/7B7JVx0fVEiIkel2NAqrI7uNRffge6CXY0DKS
         +zwDyTGv02ejUHjxNJGl19902UooC9L366E9RKKzEx/OkO8bpkve1vGjtf1kLwCK/9tO
         1at66FMMTuLCdcLDQDpJ0zc+fyRwlEuruXKuqhBBlM4551ciHXAw/fxp6ZUI2YaClcCq
         7wayEMarLNq3/O6EXtsABGFxp0jrZ01/FCp0SxAQXTldp2rn7ksM3X4lZVU9E+6LEcDB
         qgjumSVxDDUTkoH5MhT04MqSkMUjoxXEK3kK12yM6Q8F9R1nGRwWOe2sOXatl+ZseDlO
         ItkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUb/hJFbGNPx/GA4uExNVhANvviQpWzogW7D2fGl5nk=;
        b=tk/0G2AFTLdbmFjQ19dhfWuEg4heeUKpYRvXUsnxBxZUcj0gTg2MOcwig/gjnLX7m5
         kqj+8WQN+as/BBnQgq6JFhg7TlQRTq0hHy5ZfrxZ43hat3Gxt82CdUWITDgjgcO9AWHM
         ob8CSCL8yNwjFh29Gf1D+DU20WqnY1OaRoNsZt0rSdEDU94xjW9eeM1KQXSn3bY+32P9
         WEWEthdWlFdPj/fUUUSaHVawVJmC+2fUQt9vp+fnLpClyhkqCZSXeqvPvdRV77ZFcQJl
         OB5qc5/zAf/mKrOOfveTcQTtzdsb8rlWrScNYtrcnBFPDbN4tR/o/sS9OCZlIgthcmpI
         QLIg==
X-Gm-Message-State: AOAM532kLPwjNtDLnrjdjfZjnQhLNiwlIxe6RaXcAyvJf82Ppr3SJzWr
        KkCrUempEBiSIfys/ax7RdoSZuUF
X-Google-Smtp-Source: ABdhPJyGb8Y+XWfM1/vsnb76ZixdtQVUh1LqbZ7mc+C7XKZ94HG1NJlsd+dTQxom8d22xOhg5BjegA==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr8744221wmk.39.1594206729619;
        Wed, 08 Jul 2020 04:12:09 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:09 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 03/20] fsnotify: return non const from fsnotify_data_inode()
Date:   Wed,  8 Jul 2020 14:11:38 +0300
Message-Id: <20200708111156.24659-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Return non const inode pointer from fsnotify_data_inode().
None of the fsnotify hooks pass const inode pointer as data and
callers often need to cast to a non const pointer.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c    | 2 +-
 include/linux/fsnotify_backend.h | 5 ++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 85eda539b35f..d9fc83dd994a 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -341,7 +341,7 @@ static struct inode *fanotify_fid_inode(struct inode *to_tell, u32 event_mask,
 	if (event_mask & ALL_FSNOTIFY_DIRENT_EVENTS)
 		return to_tell;
 
-	return (struct inode *)fsnotify_data_inode(data, data_type);
+	return fsnotify_data_inode(data, data_type);
 }
 
 struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 1626fa7d10ff..97300f3b8ff0 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -220,12 +220,11 @@ enum fsnotify_data_type {
 	FSNOTIFY_EVENT_INODE,
 };
 
-static inline const struct inode *fsnotify_data_inode(const void *data,
-						      int data_type)
+static inline struct inode *fsnotify_data_inode(const void *data, int data_type)
 {
 	switch (data_type) {
 	case FSNOTIFY_EVENT_INODE:
-		return data;
+		return (struct inode *)data;
 	case FSNOTIFY_EVENT_PATH:
 		return d_inode(((const struct path *)data)->dentry);
 	default:
-- 
2.17.1

