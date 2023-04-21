Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 922486EB0C8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Apr 2023 19:41:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbjDURkj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Apr 2023 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233184AbjDURk0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Apr 2023 13:40:26 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE4A125B2
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id 98e67ed59e1d1-2474877cc18so1388770a91.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 21 Apr 2023 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682098824; x=1684690824;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=abvwWBWOn0vLHIokwPNC/tHyu1Fa1R/g8ZqTWIaeK3o=;
        b=XiTBjh0uy9kBhESmjZrsmo27Fd2heaOUEeGy+wI7JgY+55BFi83KpJfUElFkBAdtm2
         /9Y+dOWIDQQOwVTZr/9l2zpPw4NhLuSad5LwurXNF9rM5PxMETajnAk6IdSR9itjleO5
         5RCZOU6uWoQn/XlBfG6L6Ut73QqfPkSzpxRKMZq9c5dNC03EQysfXGAmQsX7vQIaMlXI
         wrYrPEcgEz4/6R89vEXhItTLbmEid9U911aGVkkoSTQdm4KxH3ssyAravljY6M6dDyLy
         P40RfGznmXP1ykBLl7M1nQBK+thu7rJX9Fwoe+MatBRuu3PDwmPEoG+B+msi8iGqptyL
         Fwng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682098824; x=1684690824;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=abvwWBWOn0vLHIokwPNC/tHyu1Fa1R/g8ZqTWIaeK3o=;
        b=dgT3YjoLsXWIwtENFUkUPUeSRtP0NC+ejtrFYDBqFLamhGaX41YLTo8FgCFfb1/yQA
         79gwsXhTCmZNB1fdqHoQSsFhUMqVfLbCQiOxDnYGLYL+bkIUhBnokoXxhXVWRkPIihMa
         NYOuyY4rUmK43kBZD0QdVWhPyC1baFsHMm4Deqt1swV5LQqQ95gqVVnzlABsZ2FsbWox
         1mIedwk6te4sA4lhKo59rd8R1tCRDvQgNl6Xj+ezScdhyUYYEmJTpKBlpjTG1xqVz18I
         nY8/9vs4VxNSnY3HDVQvNaFX5cgL4nqEJeqnGsboCDYxa2vb8zVniT0THNJDObw0RaIg
         +B2w==
X-Gm-Message-State: AAQBX9cpzorSNTgNxAOmHA4gvGfheSqUkpPfHxkokbBv1Xkxrq1y8y7q
        A7uf3M7CEs1asB91CVGWzQYyBpX41TbJQQ/1
X-Google-Smtp-Source: AKy350YbjANQ50zXR9lpXjPZgwQ40mwqLJ7O/YqrPonNpx/xppRCva3J0ueIG/FDAbEMT7LPHpueSbGCVpFSyjJ8
X-Received: from yosry.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2327])
 (user=yosryahmed job=sendgmr) by 2002:a17:90a:290:b0:247:2677:77b with SMTP
 id w16-20020a17090a029000b002472677077bmr1455398pja.8.1682098824669; Fri, 21
 Apr 2023 10:40:24 -0700 (PDT)
Date:   Fri, 21 Apr 2023 17:40:16 +0000
In-Reply-To: <20230421174020.2994750-1-yosryahmed@google.com>
Mime-Version: 1.0
References: <20230421174020.2994750-1-yosryahmed@google.com>
X-Mailer: git-send-email 2.40.0.634.g4ca3ef3211-goog
Message-ID: <20230421174020.2994750-2-yosryahmed@google.com>
Subject: [PATCH v5 1/5] writeback: move wb_over_bg_thresh() call outside lock section
From:   Yosry Ahmed <yosryahmed@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        "=?UTF-8?q?Michal=20Koutn=C3=BD?=" <mkoutny@suse.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        Yosry Ahmed <yosryahmed@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

wb_over_bg_thresh() calls mem_cgroup_wb_stats() which invokes an rstat
flush, which can be expensive on large systems. Currently,
wb_writeback() calls wb_over_bg_thresh() within a lock section, so we
have to do the rstat flush atomically. On systems with a lot of
cpus and/or cgroups, this can cause us to disable irqs for a long time,
potentially causing problems.

Move the call to wb_over_bg_thresh() outside the lock section in
preparation to make the rstat flush in mem_cgroup_wb_stats() non-atomic.
The list_empty(&wb->work_list) check should be okay outside the lock
section of wb->list_lock as it is protected by a separate lock
(wb->work_lock), and wb_over_bg_thresh() doesn't seem like it is
modifying any of wb->b_* lists the wb->list_lock is protecting.
Also, the loop seems to be already releasing and reacquring the
lock, so this refactoring looks safe.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Reviewed-by: Michal Koutn=C3=BD <mkoutny@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 1db3e3c24b43..11aa1652fb84 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -2024,7 +2024,6 @@ static long wb_writeback(struct bdi_writeback *wb,
 	struct blk_plug plug;
=20
 	blk_start_plug(&plug);
-	spin_lock(&wb->list_lock);
 	for (;;) {
 		/*
 		 * Stop writeback when nr_pages has been consumed
@@ -2049,6 +2048,9 @@ static long wb_writeback(struct bdi_writeback *wb,
 		if (work->for_background && !wb_over_bg_thresh(wb))
 			break;
=20
+
+		spin_lock(&wb->list_lock);
+
 		/*
 		 * Kupdate and background works are special and we want to
 		 * include all inodes that need writing. Livelock avoidance is
@@ -2078,13 +2080,19 @@ static long wb_writeback(struct bdi_writeback *wb,
 		 * mean the overall work is done. So we keep looping as long
 		 * as made some progress on cleaning pages or inodes.
 		 */
-		if (progress)
+		if (progress) {
+			spin_unlock(&wb->list_lock);
 			continue;
+		}
+
 		/*
 		 * No more inodes for IO, bail
 		 */
-		if (list_empty(&wb->b_more_io))
+		if (list_empty(&wb->b_more_io)) {
+			spin_unlock(&wb->list_lock);
 			break;
+		}
+
 		/*
 		 * Nothing written. Wait for some inode to
 		 * become available for writeback. Otherwise
@@ -2096,9 +2104,7 @@ static long wb_writeback(struct bdi_writeback *wb,
 		spin_unlock(&wb->list_lock);
 		/* This function drops i_lock... */
 		inode_sleep_on_writeback(inode);
-		spin_lock(&wb->list_lock);
 	}
-	spin_unlock(&wb->list_lock);
 	blk_finish_plug(&plug);
=20
 	return nr_pages - work->nr_pages;
--=20
2.40.0.634.g4ca3ef3211-goog

