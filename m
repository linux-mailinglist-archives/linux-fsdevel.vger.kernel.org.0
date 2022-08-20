Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B06759A9E0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 02:11:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244511AbiHTAGO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 20:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbiHTAGJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:06:09 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D230CCE20;
        Fri, 19 Aug 2022 17:06:08 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s36-20020a17090a69a700b001faad0a7a34so8908741pjj.4;
        Fri, 19 Aug 2022 17:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=T75p02eZvG3+WmmTggFiMWUmNWvSWQkYcqdlly41NXg=;
        b=lZyqFT7i+LOU+gzcZz2TMvgoFtZdnLqsywdEUl2z5VeeQUCF0petTihkeHcLeUvqeJ
         z2r8OfPqOV3TNMi3wgmdAZD6U+xHyqDA9krO1mkaBXwictige+XzuEO7eQiRBauKNtKc
         Vg3O+MwgxHe4QZQPeyZkOMIj4kEBpfru8iTKDEpWww7AyQ0nA/5SHpUnvcGrFlAkACsV
         Gf7m1/jgBEpbteCDa2TvvACN9nOqMwPnZfRGCyXTb6o7+t/wFdF/rlyMx8R4+RpVCZO6
         mScJw4fP10Dee9sQbr8NtHwQse+4gFf9D3FO0f7NVntLF9XhzZ+9Ne47XFzQM06WWNFQ
         RbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=T75p02eZvG3+WmmTggFiMWUmNWvSWQkYcqdlly41NXg=;
        b=kDHzKS9si2iGj6xLodvCLt/FlVlU6U1gNyq9kW4NqSbRdnpcRCXFZFtvMpNASJuQYl
         fH+ZlYcJacGAy8SVhbY8adsrqhVjIIQIkqBafNWv52oSPEaVFe3RO7P86iNI04APpUz5
         P9w+aIMVSIm0utm+WH+hOv6gkU1b62X/MF8gAObUvFSW6yYoFzjVf+tFlrI+2sW2M+Xz
         VfSCsS+UpmCpz+pCLWOw1rJnWy4BTg/oaU7lfGh03dskekYKoxXNh4iTaSUX2o5p/Zw5
         hEgpIOlsg0J3QbVp52FEjexZHTGj77qQg6ugXiMwoSeiYEnrPu8isQQwyTxDS8JOl4pk
         9Dsw==
X-Gm-Message-State: ACgBeo3RzWeEUAfWkdGM6iqJHNWTiNYD8Z70e5ucxs9ORikVqt2WkXnH
        L2RvhY+NIjEWXBR9pUbcZyM=
X-Google-Smtp-Source: AA6agR5MOG6ext2QMVavgk+xgzAWb2+Bhdnc+vHKm3DeaoXF8JKMx5ExBzTt/0E1zZpa3+rP8vpimQ==
X-Received: by 2002:a17:90a:7806:b0:1fa:e417:e03c with SMTP id w6-20020a17090a780600b001fae417e03cmr5880957pjk.221.1660953967619;
        Fri, 19 Aug 2022 17:06:07 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a2f5])
        by smtp.gmail.com with ESMTPSA id z11-20020a17090a8b8b00b001f51903e03fsm3668173pjn.32.2022.08.19.17.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 17:06:06 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Imran Khan <imran.f.khan@oracle.com>, kernel-team@fb.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 3/7] kernfs: Refactor kernfs_get_open_node()
Date:   Fri, 19 Aug 2022 14:05:47 -1000
Message-Id: <20220820000550.367085-4-tj@kernel.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220820000550.367085-1-tj@kernel.org>
References: <20220820000550.367085-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out commont part. This is cleaner and should help with future
changes. No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 fs/kernfs/file.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
index 6437f7c7162d..7060a2a714b8 100644
--- a/fs/kernfs/file.c
+++ b/fs/kernfs/file.c
@@ -554,31 +554,28 @@ static int kernfs_fop_mmap(struct file *file, struct vm_area_struct *vma)
 static int kernfs_get_open_node(struct kernfs_node *kn,
 				struct kernfs_open_file *of)
 {
-	struct kernfs_open_node *on, *new_on = NULL;
+	struct kernfs_open_node *on;
 	struct mutex *mutex;
 
 	mutex = kernfs_open_file_mutex_lock(kn);
 	on = kernfs_deref_open_node_locked(kn);
 
-	if (on) {
-		list_add_tail(&of->list, &on->files);
-		mutex_unlock(mutex);
-		return 0;
-	} else {
+	if (!on) {
 		/* not there, initialize a new one */
-		new_on = kmalloc(sizeof(*new_on), GFP_KERNEL);
-		if (!new_on) {
+		on = kmalloc(sizeof(*on), GFP_KERNEL);
+		if (!on) {
 			mutex_unlock(mutex);
 			return -ENOMEM;
 		}
-		atomic_set(&new_on->event, 1);
-		init_waitqueue_head(&new_on->poll);
-		INIT_LIST_HEAD(&new_on->files);
-		list_add_tail(&of->list, &new_on->files);
-		rcu_assign_pointer(kn->attr.open, new_on);
+		atomic_set(&on->event, 1);
+		init_waitqueue_head(&on->poll);
+		INIT_LIST_HEAD(&on->files);
+		rcu_assign_pointer(kn->attr.open, on);
 	}
-	mutex_unlock(mutex);
 
+	list_add_tail(&of->list, &on->files);
+
+	mutex_unlock(mutex);
 	return 0;
 }
 
-- 
2.37.2

