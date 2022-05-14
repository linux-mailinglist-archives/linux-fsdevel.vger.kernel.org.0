Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185AE5270A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 May 2022 12:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiENKWe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 14 May 2022 06:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiENKWd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 14 May 2022 06:22:33 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751003153A
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 May 2022 03:22:31 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id c24so8837238lfv.11
        for <linux-fsdevel@vger.kernel.org>; Sat, 14 May 2022 03:22:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=71mBNyH9B09u2q3LU3Ju59I/HS2yC5xAPDJGFqnY1VY=;
        b=aDNslnbKSGb4N2xm1Lxo4JxC4fAdYDbFa2mX+wCqkePx5mKCMbOD5iCq1sfQ4987Ly
         pknma9OKnD55wK9708N0oBvqAdYOUcm5Az6rId19fcg02Ws62hKcfzOhMqR3M/o8PrLT
         gj6GmVJmadt1Q6ikgZmpoha1PxC2zu9pP27midOTTvFra8OJt0emu5vd+7PT0uiq6Y9d
         12DQijP7/V04zHpW/6n8kdepYQ97ZFhJf+PtwkCHdsOBLtENyltKd4LGYu1SWRWsvYA+
         nFL4NUStGXtMLH9yefk27zuXk9ipvER/7g6r1EYIOYlifhm6zULorvCMq4FGU1drfKW2
         iMng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=71mBNyH9B09u2q3LU3Ju59I/HS2yC5xAPDJGFqnY1VY=;
        b=rEVDMIMGBHtXAmlsMaAE5zmuTtQfEdueL9hbQvsGLzoamv4jRjBXXXFBlEl6+uxwuH
         4Uu1rTEinBBJ1zTHgwz2DNbx0mPyybPus2CFjw/WbXPlMe5oFDnHMNJZrV1BiRAzJpRh
         G1z6BXSIw+G37kIqwoMYIpLbVy999hT0rjpYc98Qk/Ilcap+/HiEsj4gEeqgdHylUDHK
         T9GgBJcfvRs3/Nhwea4C+RBEkJFPi/hZkxt5voqT1xtKqNqp16Qhpho1zUaAcdTZC3kb
         MtfNAOKpsWRwjLLlSVCZTF5hKpAvjtRZ8eklHFNVAglKoMPON3T3PILfaRMR0F23MvMs
         YWhg==
X-Gm-Message-State: AOAM533gp+OjpvULcDiFR8FW93otedRaPv4Sssv6Hnh67dWgdu3vFp5r
        ItnjwITqJzRbUmPjD534UJob9g==
X-Google-Smtp-Source: ABdhPJwZxMpGHEZgzMQNdvGnPixwwGWS54tSUBK+DTtqe6KWoYW3KsgiSQ5njS8i16pr3UdHcaKJ5A==
X-Received: by 2002:a05:6512:39c1:b0:471:b37e:fe5a with SMTP id k1-20020a05651239c100b00471b37efe5amr6108692lfu.527.1652523749833;
        Sat, 14 May 2022 03:22:29 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id m22-20020a195216000000b0047255d21149sm665060lfb.120.2022.05.14.03.22.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 14 May 2022 03:22:29 -0700 (PDT)
Message-ID: <1eb3b298-4f7e-32ad-74ae-12044ed637ed@openvz.org>
Date:   Sat, 14 May 2022 13:22:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Vasily Averin <vvs@openvz.org>
Subject: [PATCH] sparse: use force attribute for fmode_t casts
To:     Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     kernel@openvz.org, linux-kernel@vger.kernel.org,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Fixes sparce warnings:
fs/notify/fanotify/fanotify_user.c:267:63: sparse:
 warning: restricted fmode_t degrades to integer
fs/notify/fanotify/fanotify_user.c:1351:28: sparse:
 warning: restricted fmode_t degrades to integer
fs/proc/base.c:2240:25: sparse: warning: cast to restricted fmode_t
fs/proc/base.c:2297:42: sparse: warning: cast from restricted fmode_t
fs/proc/base.c:2394:48: sparse: warning: cast from restricted fmode_t
fs/open.c:1024:21: sparse: warning: restricted fmode_t degrades to integer

Signed-off-by: Vasily Averin <vvs@openvz.org>
---
 fs/notify/fanotify/fanotify_user.c | 4 ++--
 fs/open.c                          | 2 +-
 fs/proc/base.c                     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 9b32b76a9c30..6b058828e412 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -264,7 +264,7 @@ static int create_fd(struct fsnotify_group *group, struct path *path,
 	 * originally opened O_WRONLY.
 	 */
 	new_file = dentry_open(path,
-			       group->fanotify_data.f_flags | FMODE_NONOTIFY,
+			       group->fanotify_data.f_flags | (__force int)FMODE_NONOTIFY,
 			       current_cred());
 	if (IS_ERR(new_file)) {
 		/*
@@ -1348,7 +1348,7 @@ SYSCALL_DEFINE2(fanotify_init, unsigned int, flags, unsigned int, event_f_flags)
 	    (!(fid_mode & FAN_REPORT_NAME) || !(fid_mode & FAN_REPORT_FID)))
 		return -EINVAL;
 
-	f_flags = O_RDWR | FMODE_NONOTIFY;
+	f_flags = O_RDWR | (__force int)FMODE_NONOTIFY;
 	if (flags & FAN_CLOEXEC)
 		f_flags |= O_CLOEXEC;
 	if (flags & FAN_NONBLOCK)
diff --git a/fs/open.c b/fs/open.c
index 1315253e0247..b5ff39ccebfd 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -1021,7 +1021,7 @@ inline struct open_how build_open_how(int flags, umode_t mode)
 inline int build_open_flags(const struct open_how *how, struct open_flags *op)
 {
 	u64 flags = how->flags;
-	u64 strip = FMODE_NONOTIFY | O_CLOEXEC;
+	u64 strip = (__force u64)FMODE_NONOTIFY | O_CLOEXEC;
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index c1031843cc6a..194b5ac069e7 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2237,7 +2237,7 @@ static struct dentry *
 proc_map_files_instantiate(struct dentry *dentry,
 			   struct task_struct *task, const void *ptr)
 {
-	fmode_t mode = (fmode_t)(unsigned long)ptr;
+	fmode_t mode = (__force fmode_t)(unsigned long)ptr;
 	struct proc_inode *ei;
 	struct inode *inode;
 
@@ -2294,7 +2294,7 @@ static struct dentry *proc_map_files_lookup(struct inode *dir,
 
 	if (vma->vm_file)
 		result = proc_map_files_instantiate(dentry, task,
-				(void *)(unsigned long)vma->vm_file->f_mode);
+				(void *)(__force unsigned long)vma->vm_file->f_mode);
 
 out_no_vma:
 	mmap_read_unlock(mm);
@@ -2391,7 +2391,7 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 				      buf, len,
 				      proc_map_files_instantiate,
 				      task,
-				      (void *)(unsigned long)p->mode))
+				      (void *)(__force unsigned long)p->mode))
 			break;
 		ctx->pos++;
 	}
-- 
2.31.1

