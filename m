Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C14366521C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 04:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbjAKDGd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 22:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjAKDGc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 22:06:32 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5851DBF5C
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 19:06:07 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id jl4so15340135plb.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 19:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+fX12uPNSC2t5ZlVOlJS/ChkuU5wtG5D7Pig3IIsUBQ=;
        b=ygi1g1WYEQaTmT7xMhGfxlp+5XLSPLxZzEtO5ngxyGYb6hcoG98Oxx4NpmydvyRoDU
         x4MeEt9hoyhTZUOiycjG8g++IhOXV0FT/QQrjDZwYpdxRpEjedZULVHed9IZGPNEKB4r
         9m7LqmLecO1p6d0ul4TWDXX6ozxLSfp8tBu/Ic+NOQ/+jeato8iMW6+RdPCWCmFfed4n
         41ythUHE/n0mHsht2e+qFnWo8eSHdNjmFilU8wDDHcizNu8tc+iIqNQMIU/T+UsgJGWr
         qsx9VGHRKq1pRkGfNgpm3kNsKFO/UtS+F4PEeuP1EXTmjnpGinp0cLsDH4E9lfm37car
         A6PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+fX12uPNSC2t5ZlVOlJS/ChkuU5wtG5D7Pig3IIsUBQ=;
        b=6ftV4O1+eXDYBedwS8mGbz5xJGTUBu7v2RwBs9/ENy73fVwgiFzZZCJBKkBs78SnAL
         qaQALpVgawLukGwvyqOiCbmTtCMoUvylS2MpD2sU70RGs5jgFjXKUflSg00v11jACdjQ
         P5woFsx3GQImANYX/cMCSjXh77pjXKNc0NICIE7Jvx5bX8rfua2mwKVO3lW6NXW8DpVa
         HHBjGNuiScDijIoC9es2HiXIhDIOj3/ImxWSmGu54i56YIQk+qI3ofw2BFhrzSw02lZe
         IQvzooEH21Ps7MSE2BMRE78gzSfhQhOlIso3k8fThBJRR/NFDimMMY1QSNNA2CAyNxcH
         6YaA==
X-Gm-Message-State: AFqh2kpeIzF0LG8NnWDSpImIV1JZmy9Vz/YwIZ61l/behQIM0Ef+mTkt
        IwM9psmJz7uZdI8Zu1YoCLfgO7JEMfaKWb3RmEQ=
X-Google-Smtp-Source: AMrXdXsKx2IEX6ycSALLj1c0cORzoJOsd9Iep1RC5onJEdW6WA3YvZ0q43P2jacj1Q2aVDBQWVjMQQ==
X-Received: by 2002:a05:6a20:b285:b0:af:ec0f:f6b5 with SMTP id ei5-20020a056a20b28500b000afec0ff6b5mr72959936pzb.11.1673406366585;
        Tue, 10 Jan 2023 19:06:06 -0800 (PST)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id 14-20020a630c4e000000b00478f87eaa44sm7290821pgm.35.2023.01.10.19.06.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 19:06:06 -0800 (PST)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] fs/pipe: Delete unused do_pipe_flags()
Date:   Wed, 11 Jan 2023 11:05:47 +0800
Message-Id: <20230111030547.7730-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It looks like do_pipe_flags() is not used anywhere and not exported
too, so delete it. No any functional changes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/pipe.c          | 11 -----------
 include/linux/fs.h |  1 -
 2 files changed, 12 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 42c7ff41c2db..9b6d7b6658f1 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -986,17 +986,6 @@ static int __do_pipe_flags(int *fd, struct file **files, int flags)
 	return error;
 }
 
-int do_pipe_flags(int *fd, int flags)
-{
-	struct file *files[2];
-	int error = __do_pipe_flags(fd, files, flags);
-	if (!error) {
-		fd_install(fd[0], files[0]);
-		fd_install(fd[1], files[1]);
-	}
-	return error;
-}
-
 /*
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way Unix traditionally does this, though.
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 452700c5fa1d..0b8fe4243f48 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3014,7 +3014,6 @@ static inline void i_readcount_inc(struct inode *inode)
 	return;
 }
 #endif
-extern int do_pipe_flags(int *, int);
 
 extern ssize_t kernel_read(struct file *, void *, size_t, loff_t *);
 ssize_t __kernel_read(struct file *file, void *buf, size_t count, loff_t *pos);
-- 
2.37.2

