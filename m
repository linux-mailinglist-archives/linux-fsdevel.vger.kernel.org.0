Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED1DD2298CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 14:59:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732359AbgGVM7J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732295AbgGVM7G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:59:06 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5AEC0619DC
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:06 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a6so4337371wmm.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Jul 2020 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LwjKIox4FCFrccXbofKj5hB5esw+QCHsR17VPIIhsQE=;
        b=EJTv9cE10qRaQEAShmWfDWhRnN+QIo+pREmW0YWvj6nTmAHwiivulnIY8DzkmirgM+
         nHCUs/03s/6rHoAfrQgQOtZ56L3BHHaKjrbTWOzKXkM5uKzYyMGylPP8DVy4Xw+p3Al8
         mRba1eTpRODh1eiVdkVNzCL8VB1qfcCWvCT6zf3eMxaDroU3YFIZDYyBHia+1MxH9Ht2
         JLOcHQD0oJNmsjmSl+sC6XgOlrxJdZZ3xWAZz6ml9UDYarBxPtshnaHtNuspHprcw3xI
         WW38OpM8jg+fuGVAdom5W0+4glqZhNlDWuaXXYIDXLt6ZJK9TcZRsWji1FhaDPKofdpB
         6Pqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LwjKIox4FCFrccXbofKj5hB5esw+QCHsR17VPIIhsQE=;
        b=ceUiMUQkkqZKvpatiGEYnU298hx1bF0U2K4K9mvsS4VQYR+YSvUu0sZJoqPgZAlkZn
         1LezyQyKbMmGqUixIVaAPNhRpSaVrD5QdaDZYOnbyzbn5fJNQ9dOXWA2EhsxX/HkRn8K
         U8CQrg4QEQ3E5sGuJjGPFhuIgIIrKbODWuGUQR5OZYF8GWsxaOIZUNv3M51zHb2rvIUq
         ygN1Fr0B89N5b0Zwu1hfa+7+jO1xIPLqN8lilM83UB0BjxFnFed0soGzIi36dRzmChtO
         wEWrsHiaGHGWPaVvFOPI8Lkqu72PblX6t7ndLI0Dve5zyqhA+V0R94qfNCHQkzRtmM2a
         dJCQ==
X-Gm-Message-State: AOAM531+x3NZATRibNRGFaownCVQEFxeIFUFYeAqhubFz10HDS12BPzq
        NwpJtmJCH+6v+cXajkB5+YI=
X-Google-Smtp-Source: ABdhPJzt8AJs0NSj+Uc9/jzL5O4ISIhf5JtAJQYlj8TLL7sHAS14hgSkm88HSTMzrBVGBVVRfz9alQ==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr1736600wmk.136.1595422744978;
        Wed, 22 Jul 2020 05:59:04 -0700 (PDT)
Received: from localhost.localdomain ([31.210.180.214])
        by smtp.gmail.com with ESMTPSA id s4sm35487744wre.53.2020.07.22.05.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 05:59:04 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 2/9] inotify: do not set FS_EVENT_ON_CHILD in non-dir mark mask
Date:   Wed, 22 Jul 2020 15:58:42 +0300
Message-Id: <20200722125849.17418-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200722125849.17418-1-amir73il@gmail.com>
References: <20200722125849.17418-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Since commit ecf13b5f8fd6 ("fsnotify: send event with parent/name info
to sb/mount/non-dir marks") the flag FS_EVENT_ON_CHILD has a meaning in
mask of a mark on a non-dir inode.  It means that group is interested
in the name of the file with events.

Since inotify is only intereseted in names of children of a watching
parent, do not sete FS_EVENT_ON_CHILD flag for marks on non-dir.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/notify/inotify/inotify_user.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 5385d5817dd9..186722ba3894 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -75,15 +75,17 @@ struct ctl_table inotify_table[] = {
 };
 #endif /* CONFIG_SYSCTL */
 
-static inline __u32 inotify_arg_to_mask(u32 arg)
+static inline __u32 inotify_arg_to_mask(struct inode *inode, u32 arg)
 {
 	__u32 mask;
 
 	/*
-	 * everything should accept their own ignored, cares about children,
-	 * and should receive events when the inode is unmounted
+	 * Everything should accept their own ignored and should receive events
+	 * when the inode is unmounted.  All directories care about children.
 	 */
-	mask = (FS_IN_IGNORED | FS_EVENT_ON_CHILD | FS_UNMOUNT);
+	mask = (FS_IN_IGNORED | FS_UNMOUNT);
+	if (S_ISDIR(inode->i_mode))
+		mask |= FS_EVENT_ON_CHILD;
 
 	/* mask off the flags used to open the fd */
 	mask |= (arg & (IN_ALL_EVENTS | IN_ONESHOT | IN_EXCL_UNLINK));
@@ -512,7 +514,7 @@ static int inotify_update_existing_watch(struct fsnotify_group *group,
 	int create = (arg & IN_MASK_CREATE);
 	int ret;
 
-	mask = inotify_arg_to_mask(arg);
+	mask = inotify_arg_to_mask(inode, arg);
 
 	fsn_mark = fsnotify_find_mark(&inode->i_fsnotify_marks, group);
 	if (!fsn_mark)
@@ -565,7 +567,7 @@ static int inotify_new_watch(struct fsnotify_group *group,
 	struct idr *idr = &group->inotify_data.idr;
 	spinlock_t *idr_lock = &group->inotify_data.idr_lock;
 
-	mask = inotify_arg_to_mask(arg);
+	mask = inotify_arg_to_mask(inode, arg);
 
 	tmp_i_mark = kmem_cache_alloc(inotify_inode_mark_cachep, GFP_KERNEL);
 	if (unlikely(!tmp_i_mark))
-- 
2.17.1

