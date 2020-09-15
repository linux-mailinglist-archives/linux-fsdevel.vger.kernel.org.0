Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9796E26B85B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Sep 2020 02:42:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIPAm0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Sep 2020 20:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgIONCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Sep 2020 09:02:55 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51055C06178A
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:54 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o16so1740582pjr.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 15 Sep 2020 06:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rc6KaAEAFGC1bquGjMDTwVXCIGizoAvEk7c9RDuLwUU=;
        b=uHSTTG9SkzuWvTWWD5CiQWnUreepxjLDXUrW6B7M7673ifJte619xFMebuGUKkNww4
         bG8GTdnqecPbRu3IgxB4aRhc+mexcZ6eN5KK4euTNlp1gKFzKVIe2ts+PlcKiAmuLIqB
         fJL2tItNCkXJnufEmBCgqWlq5wG3sztMd+FCYu3K9zqquLZLCWBQkEiDPszHTdxnh+XG
         AInVgU+TUJ4lHuE/KgghIeubyhwp46t68stuqmwWJhvQcXxlvrJTeuCJligdwBHyl5sX
         J42JWxskVo5f+N42nvYckziJh+S0GXbYzGCMVi73KNgTcE+sdpR3ZacUacGUKjQ1KLCf
         cHDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Rc6KaAEAFGC1bquGjMDTwVXCIGizoAvEk7c9RDuLwUU=;
        b=fNiIFBJmtAZYYgpeij93W3gCpEPb3TCQb1t073rj1M0GQEOp1+xCLYIzmZ7jEe4fiI
         0GswjuMZy2plhgS3eu0xPm+AQ1D/mbCyRoAuNSOB6rv84wq8hWw4LFa8ynSLWZJgvlC3
         y/0sVDa/w3awO5ah95KWovcGlIzdUgySRrmiV211P9KxOYVfwPCuJbg+y5eSj0JhKIT7
         egW4e8TjJqsa8kbTkkcq0jjjD09HIaKDjLdp0MJ5Cqn21IOYoUiuwQmMprTRoO3nEdjG
         ICR9xbtbYY18MSt7yW7Pgi54QXtRnDZqfASkA+XeQjqj749KZvaWQzAGEYxZTHamnaTx
         656A==
X-Gm-Message-State: AOAM533genk/iXsvfPRj1pSJVGDuPj6FgXMNK4kLv06N6As2gSswU4D8
        ce6EfywGTjynFFncB3suInTcvA==
X-Google-Smtp-Source: ABdhPJz2EWD6fENT6TGgZ8NuSVKrRjf/5CKkJlBWOkx7TnR0YUJy0AAJv/T2UmCjTO170TN5QGqGGQ==
X-Received: by 2002:a17:90a:72c7:: with SMTP id l7mr4186306pjk.19.1600174973787;
        Tue, 15 Sep 2020 06:02:53 -0700 (PDT)
Received: from MacBook-Pro.local.net ([103.136.221.73])
        by smtp.gmail.com with ESMTPSA id c5sm12133263pgj.0.2020.09.15.06.02.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Sep 2020 06:02:53 -0700 (PDT)
From:   Yinyin Zhu <zhuyinyin@bytedance.com>
To:     viro@zeniv.linux.org.uk, axboe@kernel.dk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com
Subject: [PATCH] io_uring: fix the bug of child process can't do io task
Date:   Tue, 15 Sep 2020 21:02:45 +0800
Message-Id: <20200915130245.89585-1-zhuyinyin@bytedance.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

when parent process setup a io_uring_instance, the ctx->sqo_mm was
assigned of parent process'mm. Then it fork a child
process. So the child process inherits the io_uring_instance fd from
parent process. Then the child process submit a io task to the io_uring
instance. The kworker will do the io task actually, and use
the ctx->sqo_mm as its mm, but this ctx->sqo_mm is parent process's mm,
not the child process's mm. so child do the io task unsuccessfully. To
fix this bug, when a process submit a io task to the kworker, assign the
ctx->sqo_mm with this process's mm.

Signed-off-by: Yinyin Zhu <zhuyinyin@bytedance.com>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f115fff39cf4..f5d6bd54a625 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -514,7 +514,7 @@ static inline void io_queue_async_work(struct io_ring_ctx *ctx,
 	}
 
 	req->files = current->files;
-
+	ctx->sqo_mm = current->mm;
 	spin_lock_irqsave(&ctx->task_lock, flags);
 	list_add(&req->task_list, &ctx->task_list);
 	req->work_task = NULL;
-- 
2.11.0

