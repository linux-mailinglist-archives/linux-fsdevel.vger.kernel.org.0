Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F73221EA6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgGPImk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726837AbgGPImj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3CCC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:39 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o11so6128217wrv.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Flp7T9WIc1w1ntsSPO17S0CWhuZufq9WH+smb2lBzBY=;
        b=Q5Pv+QM9KPPbO7YzDANxRunFZgq/FEuvoEebJW0kpKWhOVoBr8NN6E4NPv5s6SU7Pk
         WDuCGtLQ5VN2DhdWZAjg07e8azkwGC3yDQ4jTWHJQ/ILD58xBYFK6ASrn53nzWxmBffR
         aoOcoMWkKY+81RxBJ80hB26AcRO1jRMrgBOrXmE6rKwbeBHJWOLFdTW0kGaH0Gv1LN9Z
         HmjgJg7ZwbKoma0DQnnQMVh+kXIxcEV5OeUQ5LMXeCQw7YckmJyJzdNglm4mVHZICWHM
         vQ0WVXYJd/RhuG1KV3KejhhgbLgllkg9QX5iJVcaJLgSUb2340F84koqpah4qtimiOrv
         MRwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Flp7T9WIc1w1ntsSPO17S0CWhuZufq9WH+smb2lBzBY=;
        b=ZCWYHEHdp16nXiC28yMhS4y4JlkNEtV8/WQwZsryyWh0Ohf7uxgHb5ayTHD6YSYfnJ
         d9eD/GIAF8GGtMyPzUBqiNs1AVvAxBqejwUj45TGtczl1VA28HLskSzyYV2yO26x5W/I
         uY8m31oizefFrPnA3udy02L6rcy8Z0VqFtWNXDDbSttP2cgr5zRWkrbAU5K4or67s23z
         9nXLyZKJM5TNgLZolY8QGTa2eU1gBfIOj/nUj5SEMYndc+sUWW4fNwsABfs9IEYkf5mT
         qDle1UHHlOSs/LF471QvVk/gireMkzoSXLO4HGopJMGlSimSwcz5m4RPvVmog4XMdA68
         Carg==
X-Gm-Message-State: AOAM5324aT7o+Vth+ZOIYRgnxQLUIdsNXqMDP0A0kGd5bYzZnvqCGlOz
        EqdveL7crWWMJn4IWUCP10/zMPvI
X-Google-Smtp-Source: ABdhPJwz9HEkzHgc2krRblj0Z0tT18vzMttxcx9zZntPn1DV+qCUVtdZ1Qz/s0Gif2PU6qDpZIo78A==
X-Received: by 2002:adf:f3cd:: with SMTP id g13mr3765162wrp.45.1594888958310;
        Thu, 16 Jul 2020 01:42:38 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:37 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 01/22] fanotify: generalize the handling of extra event flags
Date:   Thu, 16 Jul 2020 11:42:09 +0300
Message-Id: <20200716084230.30611-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In fanotify_group_event_mask() there is logic in place to make sure we
are not going to handle an event with no type and just FAN_ONDIR flag.
Generalize this logic to any FANOTIFY_EVENT_FLAGS.

There is only one more flag in this group at the moment -
FAN_EVENT_ON_CHILD. We never report it to user, but we do pass it in to
fanotify_alloc_event() when group is reporting fid as indication that
event happened on child. We will have use for this indication later on.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/fanotify/fanotify.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index e6ba605732d7..110835a9bf99 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -211,7 +211,8 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 				     int data_type)
 {
 	__u32 marks_mask = 0, marks_ignored_mask = 0;
-	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS;
+	__u32 test_mask, user_mask = FANOTIFY_OUTGOING_EVENTS |
+				     FANOTIFY_EVENT_FLAGS;
 	const struct path *path = fsnotify_data_path(data, data_type);
 	struct fsnotify_mark *mark;
 	int type;
@@ -264,14 +265,18 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
 	 *
 	 * For backward compatibility and consistency, do not report FAN_ONDIR
 	 * to user in legacy fanotify mode (reporting fd) and report FAN_ONDIR
-	 * to user in FAN_REPORT_FID mode for all event types.
+	 * to user in fid mode for all event types.
+	 *
+	 * We never report FAN_EVENT_ON_CHILD to user, but we do pass it in to
+	 * fanotify_alloc_event() when group is reporting fid as indication
+	 * that event happened on child.
 	 */
 	if (FAN_GROUP_FLAG(group, FAN_REPORT_FID)) {
-		/* Do not report FAN_ONDIR without any event */
-		if (!(test_mask & ~FAN_ONDIR))
+		/* Do not report event flags without any event */
+		if (!(test_mask & ~FANOTIFY_EVENT_FLAGS))
 			return 0;
 	} else {
-		user_mask &= ~FAN_ONDIR;
+		user_mask &= ~FANOTIFY_EVENT_FLAGS;
 	}
 
 	return test_mask & user_mask;
-- 
2.17.1

