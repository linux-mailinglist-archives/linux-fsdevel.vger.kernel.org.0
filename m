Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D255F1F7608
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFLJeJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgFLJeH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CA9C03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id w7so5961900edt.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IUb/hJFbGNPx/GA4uExNVhANvviQpWzogW7D2fGl5nk=;
        b=cXqWSC3ZwsStZj/HnyCBWiQ5Rb1v5WgVl9aaKewKIHsuENRrTU6b81z+XPCnXgv/cD
         B4iWijpPvLAj4oWRErqD04kObwV/VxyW8vd355mOarmKosyLTkuKeMBFGn+V0zrgqyqd
         9y/zAG9xgaqRYSDNPcYW1Dtew4PJPprnCxzD8Y2UBicxjAEoG+BJzXyb7KqLOjzjA2Q1
         a6Q/GjPMvqByl5TNCM/3DEI8WjHjrTW2sfs52TrNoCnkqPehjeC7/qJGNAXYeANqf00j
         OPpyEu6c+v6a+dKl4C8MQIdFSTIHDhQ5RK42Kl58+cUdhCfORAJpgY0iWORNlWj1OhvT
         eITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IUb/hJFbGNPx/GA4uExNVhANvviQpWzogW7D2fGl5nk=;
        b=MNM/Knd80olPb4RJVgnent7Lnlqu1DF7LuLvhDdNa7aLEZMN9QcaUfxR3XHDLt9b61
         xnoL33ESAocojHLzQj9vT6RBacW5PLATkdjVTzhV3M745uXWkar1ONH18qeFylKzjFAk
         /D25ul8sHMqRpvd9XVA4AxPl9Qn/U7R6WGTrEpNAs4R59rYpctMZDMRQLqckioqaIz0p
         tuuY58qKBYv5OI4dGKksKLPvOtYncdRC1vGxe6RTvgRq04fSjVsfusG3pwjlLs9paqdm
         5Lq20L7LsnmzYHNUIwMiYnxfVqJjqmOQ1akoFckLtsvjr4+J1dIsAQhVZdtw7ONoqTEe
         rZmQ==
X-Gm-Message-State: AOAM531gHQY7InxU8hqTqr69tK2Gtg5OAf9ITLH6xFTQGoXu/gkzMsCL
        hHu/1t8mqU4xJe1pEvdgCNJc5WNK
X-Google-Smtp-Source: ABdhPJyDmrcFGHbV/4n4hMPRsDg4453vanYdwR6f+qtXAhzMfwTboiRxLYbGAO5koVFm89OLIBkb7A==
X-Received: by 2002:a50:f094:: with SMTP id v20mr10669404edl.77.1591954445689;
        Fri, 12 Jun 2020 02:34:05 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:05 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 03/20] fsnotify: return non const from fsnotify_data_inode()
Date:   Fri, 12 Jun 2020 12:33:26 +0300
Message-Id: <20200612093343.5669-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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

