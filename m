Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62E50E890
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 19:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfD2ROE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 13:14:04 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:42454 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728776AbfD2ROE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 13:14:04 -0400
Received: by mail-pf1-f202.google.com with SMTP id d12so7605806pfn.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 29 Apr 2019 10:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJZw+a1zAAS2yXCulVsapzFNzx2HgPG8quVXkMNIzRA=;
        b=LNHMaVmcposMzXiBxo+LfVRrsXl/hzH7pjhT+t1iPGrPl3ttT6JqRtwLI+LmJZzfO3
         6dooMjOh7leRjuHd+y/PjbfED8ng26vganF2W2sFFNwLnXk6AO6Gnk27hUJRFq6vMHnD
         V/8GhLSaHioBm8HlcVfQcAoSlyZLZXgu6P3IdkSFLTkVAt1kTaAXh3IygzCUzwkRkMO2
         ABs/JrSSCGKRasEP9mu0SQTJMLHuHvq8LSeIkgusJW0LAXLmHG7xmCeCdF9OyEsbz3k2
         Ag2CxRX2t31eXoE9nTs+JsO7/i88GZiSYPqm/ZR7APmhOvzuNg5tIpU4XhI4eSSqDaiw
         t5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJZw+a1zAAS2yXCulVsapzFNzx2HgPG8quVXkMNIzRA=;
        b=hAE07AYdKFQHWtnGf0+meeHff5RjTlK1NYGsPsju0mzCtEK/QzilBFDuqPZ4mYyQ8r
         i1YX1kG6l7Ue3VZvGaWqedBYRpK3Y+Fkyb2ILZcxUuKS0KxllJ23QMMwQQY+Msp0TbtE
         d6tN94zeYs/f25dalv8fXdiDIbYi+Ae/CQnT8MgtAeTtBTYcMKgKJUdhtNlNmq9j82ZT
         udYbwGSW3rz5xV26NMDU4Meqweo0ZPkpOP7EhhYsT93SFyo/q2qdfdlTPql3faTrZoNJ
         y0spYAxA8cc6r2g8SmfGQ2+ggNqNAetseSMob8ubAaT4mnlRoF2E43/0id4DQxB2bvDq
         yPyQ==
X-Gm-Message-State: APjAAAXaT2nsOLooRgRAL8lvfGbdTqC55MgNqmE115k0JuxoHQf4ttZb
        o8lM36aw8d73cpATJmfZ9k++tn3xfiQtqA==
X-Google-Smtp-Source: APXvYqzTjNvJrvL+jBUcp6W9VnuxIBNtyu3+LblRTc2xOWy1Rbb1xQgUwgBIVo88fNW8fifpkQ8drzhLbu6dhw==
X-Received: by 2002:a65:5941:: with SMTP id g1mr60655155pgu.51.1556558043109;
 Mon, 29 Apr 2019 10:14:03 -0700 (PDT)
Date:   Mon, 29 Apr 2019 10:13:32 -0700
In-Reply-To: <20190429171332.152992-1-shakeelb@google.com>
Message-Id: <20190429171332.152992-2-shakeelb@google.com>
Mime-Version: 1.0
References: <20190429171332.152992-1-shakeelb@google.com>
X-Mailer: git-send-email 2.21.0.593.g511ec345e18-goog
Subject: [PATCH 2/2] memcg, fsnotify: no oom-kill for remote memcg charging
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
__GFP_RETRY_MAYFAIL to the fanotify and inotify event allocations.

Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 fs/notify/fanotify/fanotify.c        | 4 +++-
 fs/notify/inotify/inotify_fsnotify.c | 7 +++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index 6b9c27548997..9aa5d325e6d8 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -282,13 +282,15 @@ struct fanotify_event *fanotify_alloc_event(struct fsnotify_group *group,
 					    __kernel_fsid_t *fsid)
 {
 	struct fanotify_event *event = NULL;
-	gfp_t gfp = GFP_KERNEL_ACCOUNT;
+	gfp_t gfp = GFP_KERNEL_ACCOUNT | __GFP_RETRY_MAYFAIL;
 	struct inode *id = fanotify_fid_inode(inode, mask, data, data_type);
 
 	/*
 	 * For queues with unlimited length lost events are not expected and
 	 * can possibly have security implications. Avoid losing events when
 	 * memory is short.
+	 *
+	 * Note: __GFP_NOFAIL takes precedence over __GFP_RETRY_MAYFAIL.
 	 */
 	if (group->max_events == UINT_MAX)
 		gfp |= __GFP_NOFAIL;
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
2.21.0.593.g511ec345e18-goog

