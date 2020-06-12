Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB6181F760B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgFLJeM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbgFLJeK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:10 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCB9C03E96F
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:10 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id m21so5928364eds.13
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8UVubkuXhicUmFZ2Y1+zmG91pHnTICwuP72MUM8XTwU=;
        b=YKFGgRjogXAvtdZk9yJSGnicJZOHpjECTR/Z1KMDbubdnftr6Co53eVpXnawx0ABlg
         WVqyR75r73EG6bJ6tImbO/q+LYQz8QuxEVJHGCuTrY2CJcF0UK1mYRATbYHTstqaXDbY
         v+svjUSmxsGr4i/MNourOv9hO8rxnQwTa5PofGm2CJ3pXHFaBo/55T90GtD2Xjwu2e2Q
         amYiJe6nNwiCsYjbXNJMsqU1zX5XevDguDKvWEh4ghv6SH8EvWgVaqO6vnNrSs9PyyEd
         ONCVSTUQ09pY9NUa8DhDZyUnAaxyUInsIP2lmc+Uk36zNHMlq0x9JeUKS2JEf/uejBHp
         Y7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8UVubkuXhicUmFZ2Y1+zmG91pHnTICwuP72MUM8XTwU=;
        b=jiXZlZHrT6m/FdTjs58rnAJjUEl2KKLg7gnv2bMdPdbD7lqD584NtlFbBFk1ijrRZm
         Yc8N3cS3YubzPfeqdwWxWcCgmGRxMQtm6UIKLcaxCN7Tf2XlBXxFBBSDFYbaUqydqyQv
         8eWvGArYTnh6hfbphFBXx5QVmcEvs+2PBUZ6CSGZ7YbFKwg8QGZ+XnWzeqcaXDTCIO+y
         vPhZnTGcxCTBJnS3k2l/VseYK63+KfkksFOOD3iKYjrbaFYwi6npdOy+vRfP+/07rFRL
         XXbtJ0rH7f+UgSXXTlDO4kklKY6zfOIY8ubGPP3IAJps6mVWIZDi7l9eRmvywIH6gHGj
         E2Gw==
X-Gm-Message-State: AOAM530MtEg6F2VjY7T+OIa78hJ2Jsz/jrRYGCcv5pZfTn9Vo2bwtP85
        aNtNfuaHCgWtibDgWuKvkFU=
X-Google-Smtp-Source: ABdhPJyC1gjMbJx0tsQc+x7QJfUhYOBTRgLCW9GsbKTbTNv17UpycsLl9OZF0aXzCvGNEer7LU/Jng==
X-Received: by 2002:a50:fe94:: with SMTP id d20mr10415614edt.254.1591954449265;
        Fri, 12 Jun 2020 02:34:09 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:08 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/20] inotify: do not use objectid when comparing events
Date:   Fri, 12 Jun 2020 12:33:29 +0300
Message-Id: <20200612093343.5669-7-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

inotify's event->wd is the object identifier.
Compare that instead of the common fsnotidy event objectid, so
we can get rid of the objectid field later.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify_fsnotify.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index 2ebc89047153..9b481460a2dc 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -39,7 +39,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
 	if (old->mask & FS_IN_IGNORED)
 		return false;
 	if ((old->mask == new->mask) &&
-	    (old_fsn->objectid == new_fsn->objectid) &&
+	    (old->wd == new->wd) &&
 	    (old->name_len == new->name_len) &&
 	    (!old->name_len || !strcmp(old->name, new->name)))
 		return true;
@@ -116,7 +116,7 @@ int inotify_handle_event(struct fsnotify_group *group,
 		mask &= ~IN_ISDIR;
 
 	fsn_event = &event->fse;
-	fsnotify_init_event(fsn_event, (unsigned long)inode);
+	fsnotify_init_event(fsn_event, 0);
 	event->mask = mask;
 	event->wd = i_mark->wd;
 	event->sync_cookie = cookie;
-- 
2.17.1

