Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED1691ACFF
	for <lists+linux-fsdevel@lfdr.de>; Sun, 12 May 2019 18:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfELQJ6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 12 May 2019 12:09:58 -0400
Received: from mail-yw1-f74.google.com ([209.85.161.74]:48572 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbfELQJ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 12 May 2019 12:09:57 -0400
Received: by mail-yw1-f74.google.com with SMTP id q188so20524845ywc.15
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 May 2019 09:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=pNYDYF29KQTiDsLTir5ePdeguGYagzUQEsurF8lSHbY=;
        b=i3YEIaQIHO/PR2+mMIFIpaGHrsGtdYQBTKhgEeVGdXy6IjrQUWW5WGYFsXSjxoy4Qa
         5xlboHTgv9cyDLZ9V2BO/jEBAklDBwaVlu3TrXjcaV9JkSH4r/P/p1LzRbEzXM8NGGqh
         aRossIettQVPYRP2lRDcOH67U+qYdSZGyj8FX4IOWj8uCAckk7xaZVr5GB9pAj4t4hz5
         tsXRN5yNqBGxFb7yJ9dJbrVjuLxoYHIHNy5JGiw3cCLlaZQjNXt/bf4IpwEQgLEKf8BV
         SFS4JqfbN/IHML9PTuVHjyceb1Le0/n+fA3YtuBOVoJ7+b6QgRQjGdnyBJBvvSOkAeon
         Uifw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=pNYDYF29KQTiDsLTir5ePdeguGYagzUQEsurF8lSHbY=;
        b=thfbFI0pEuMeVpN+CdUfoA7nCczB2c1JMf4zf4DqC4ljRe3brcB/ZnfQkWfmzHnk5L
         zf4tkgBSyCXL62YtVbyDq40xtPS3Z/L6ZaTgZOeUi19w9jRLvGp+oOJKMm3liYJ9gc0A
         MW68KD6ctdcQE2scVRp7P8H9qXraPKrYml9zDZgKa6lJYHjE/UCG7c7nkD/rrO8LDYjp
         s+gA+NHTF1D4AGyqLiXyD4zKsQN6qOha20cJJ8248AMNMLOmKgc1HvttNxG7rv4dVuRy
         ck1C/xLVEPYMOctoQ18i+LRhDBKfVEBV2cAcdjLpcOnHjBxXXS0MphR//rvyVhdgYnrO
         UbTg==
X-Gm-Message-State: APjAAAXcyXZuDTRchMJss9OlD06SGrXv6tUoClGnreNYxx4DdasIfRhf
        cDavieTL4vcgM/b3TVlok1DwUD2pqKCdmg==
X-Google-Smtp-Source: APXvYqwFjUEgIaKr0kbwdw7yEWcBwWFgnrXBu4fdjexDy0pGsGSbQmVSEDWFzUFaVoq6HIRtK7D5ckxThWerQA==
X-Received: by 2002:a25:585:: with SMTP id 127mr10890358ybf.60.1557677396951;
 Sun, 12 May 2019 09:09:56 -0700 (PDT)
Date:   Sun, 12 May 2019 09:09:27 -0700
In-Reply-To: <20190512160927.80042-1-shakeelb@google.com>
Message-Id: <20190512160927.80042-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20190512160927.80042-1-shakeelb@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [RESEND PATCH v2 2/2] memcg, fsnotify: no oom-kill for remote memcg charging
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Cc:     linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The commit d46eb14b735b ("fs: fsnotify: account fsnotify metadata to
kmemcg") added remote memcg charging for fanotify and inotify event
objects. The aim was to charge the memory to the listener who is
interested in the events but without triggering the OOM killer.
Otherwise there would be security concerns for the listener. At the
time, oom-kill trigger was not in the charging path. A parallel work
added the oom-kill back to charging path i.e. commit 29ef680ae7c2
("memcg, oom: move out_of_memory back to the charge path"). So to not
trigger oom-killer in the remote memcg, explicitly add
__GFP_RETRY_MAYFAIL to the fanotigy and inotify event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Reviewed-by: Roman Gushchin <guro@fb.com>
---
Changelog since v1:
- Fixed usage of __GFP_RETRY_MAYFAIL flag.

 fs/notify/fanotify/fanotify.c        | 5 ++++-
 fs/notify/inotify/inotify_fsnotify.c | 7 +++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..f78fd4c8f12d 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -288,10 +288,13 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
-	 * memory is short.
+	 * memory is short. Also make sure to not trigger OOM killer in the
+	 * target memcg for the limited size queues.
 	 */
 	if (group->max_events == UINT_MAX)
 		gfp |= __GFP_NOFAIL;
+	else
+		gfp |= __GFP_RETRY_MAYFAIL;
 
 	/* Whoever is interested in the event, pays for the allocation. */
 	memalloc_use_memcg(group->memcg);
diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
index ff30abd6a49b..17c08daa1ba7 100644
--- a/fs/notify/inotify/inotify_fsnotify.c
+++ b/fs/notify/inotify/inotify_fsnotify.c
@@ -99,9 +99,12 @@ int inotify_handle_event(struct fsnotify_group *group,
 	i_mark = container_of(inode_mark, struct inotify_inode_mark,
 			      fsn_mark);
 
-	/* Whoever is interested in the event, pays for the allocation. */
+	/*
+	 * Whoever is interested in the event, pays for the allocation. However
+	 * do not trigger the OOM killer in the target memcg.
+	 */
 	memalloc_use_memcg(group->memcg);
-	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT);
+	event = kmalloc(alloc_len, GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL);
 	memalloc_unuse_memcg();
 
 	if (unlikely(!event)) {
-- 
2.21.0.1020.gf2820cf01a-goog

