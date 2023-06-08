Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63C1F727A53
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jun 2023 10:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235560AbjFHIrf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 8 Jun 2023 04:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbjFHIrc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:47:32 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2062733
        for <linux-fsdevel@vger.kernel.org>; Thu,  8 Jun 2023 01:47:31 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-651f2f38634so284228b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 08 Jun 2023 01:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1686214051; x=1688806051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M478tZ0BJPqFdShribkt4DG9LiqmYQZeG2OJxmtwTQI=;
        b=Yq2Nya/66Vu5w6nNpTUv8LEnsCGR+JlJ895K/cvR0mlClcb2DLPGqhvMmAhPRnVC6P
         5lyLBb0BanEOEB5t67nNrVRDwmL/nXyneeJKirBxtqfYoX82wSUEyObyvO5lBx5WlZjd
         7IFu2/h9klmSHROrvtKaxHRzYYf97RrRZ7R6kUT/MptavElCUHxFZYVt8v39v0QUxqH8
         MBekCo2B/5+W5SBtVF33Auv200I2Z82VjkUUpo4jXKJb6wedh1dfBUxH68MnoVoVRJcq
         CehSyCf+cG+5K5kWw96LsHynVXZEpos6blrNXcKzRev92YSyY59ZKV4R2rqBlgxN/CeI
         vyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686214051; x=1688806051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M478tZ0BJPqFdShribkt4DG9LiqmYQZeG2OJxmtwTQI=;
        b=IIdJ5BqHdko+u8iHJ25sRJlbsFEuTdUrBtxh2l6ZHZ1APaHEHOUIYEdUQk0/jb+fq8
         FBlIf7K/TzO9LyYIshf+7CTZ2HhxfopgnafeaiMeUyID2x+G1Fc3wvAvPSvF7dZKXYJz
         ebR+R0Prljz6lJHDAydvFYURpRfMT5E6Rnwp+CCofymPXlYmcWBgQwA+blAp50FZE4yw
         DMCkSYNzyPbSpA77j4sK3F3ptNJOAdlUzf3w0zlKDX4a146eq+uocseNLb5SftdHWL2z
         FVqlKkGRjuBws2ss1/Iqhhw1q8tPoIHB1yUicoLntg1ukKxFBLsbHIn5juBAcnz7fmQY
         xw6w==
X-Gm-Message-State: AC+VfDxt+ymlCMH+c9NbnO3d+FD0m+JQp5D2xU5rkCmmjrwYyh9vgl+6
        JeUTJJz5Eg0m9YrHXMK4n1CSOQ==
X-Google-Smtp-Source: ACHHUZ7154zUvrdNtTgZVFuJ8WpQ3S+Vr8G9uLG4z30KZw1UZuEHkqXzo6u/4y2aW+LeH1v8GBnjxw==
X-Received: by 2002:a05:6a20:7d85:b0:10d:d0cd:c1c7 with SMTP id v5-20020a056a207d8500b0010dd0cdc1c7mr7184475pzj.15.1686214050909;
        Thu, 08 Jun 2023 01:47:30 -0700 (PDT)
Received: from localhost.localdomain ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id 23-20020aa79157000000b0063b806b111csm614160pfi.169.2023.06.08.01.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jun 2023 01:47:30 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@osdl.org>, me@jcix.top,
        Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH 2/2] fuse: remove an unnecessary if statement
Date:   Thu,  8 Jun 2023 16:46:09 +0800
Message-Id: <20230608084609.14245-3-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
References: <20230608084609.14245-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

FUSE remote locking code paths never add any locking state to
inode->i_flctx, so the locks_remove_posix() function called on
file close will return without calling fuse_setlk().

Therefore, as the if statement to be removed in this commit will
always be false, remove it for clearness.

Fixes: 7142125937e1 ("[PATCH] fuse: add POSIX file locking support")
Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/file.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 7fe9d405969e..57789215c666 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2619,10 +2619,6 @@ static int fuse_setlk(struct file *file, struct file_lock *fl, int flock)
 		return -ENOLCK;
 	}
 
-	/* Unlock on close is handled by the flush method */
-	if ((fl->fl_flags & FL_CLOSE_POSIX) == FL_CLOSE_POSIX)
-		return 0;
-
 	fuse_lk_fill(&args, file, fl, opcode, pid_nr, flock, &inarg);
 	err = fuse_simple_request(fm, &args);
 
-- 
2.20.1

