Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9A27A49BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241375AbjIRMdT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 08:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241231AbjIRMcv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:32:51 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5600411F
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:31 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99bdcade7fbso565706266b.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1695040350; x=1695645150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bTIpQ2wCkQ3gsn9IN2OtZFBrX++kayidfIH0DbMWLuA=;
        b=fJJU9BqTIihg7qWtYW0OAU0Reg/jv7ksGHuJmnrEXD2jsFE2+cews4dZFPDxn+80iS
         8b7uHs/e/18DlFnNn63JImv9m9pgPze8a8p3T8Yx28CJgbdPHPMlPP/P3U3bjDtGhSCY
         OHrDqqfJUa+SKehcgYVlwpjV/hqSdls4G1LpcQv8XWisfr8lUg4CQMimVybhcycoRoxw
         owEiJZoEEA7nZGQnt6KXjK5fk5nd9YRe9VyWt5VGdKECs6J3y1WMVfiQD5rJyEdK/uZN
         B70h4cUIOzjqR2jkBxNpM5uC5Hz6BToCy4F4VvqS/tCjiidpQRy8mCGaWqADn52r10Zl
         JGUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695040350; x=1695645150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bTIpQ2wCkQ3gsn9IN2OtZFBrX++kayidfIH0DbMWLuA=;
        b=S24l40VEKYilR/+ODKRzVQY2hbPhAWtzVhNJbD1ndKbj2NkDhXaAvMW52vk98g690L
         c7sZl0pLtYfNjPwbUwzkY2Gl/ELUbCqfyLANbPgmS9nDOGbvFo1SgRNz8atT6PJwRDeZ
         VkNB0L2rTFQJOOtMoWMh5D2NlwZNEadBIqmQEYvrJRBW4LztG10Y7EN/PdFTW2Mljg7b
         /A/YXy6M3bNdFHdhqKQsq7ZKrMR49G4uRELSVjiKoEaDnuwC4yutjDr9FNml3oSU0RiV
         NXaLogqrH8rG5F5nzm7yO8mFBZJL2D6mkbrzbbOEFRHR5HAMH5ljCIV9kFyCQ1NsVR6c
         CXvA==
X-Gm-Message-State: AOJu0YyaxtvVi9yAzBCKdRZHj16NtwI2aBmla2FIS5W4Uif2tGEEluJu
        XpLuA8bBpBOLAWPPdTdhJZSBsg==
X-Google-Smtp-Source: AGHT+IHEmVNUNMnKl+moqAewq8OTkGHbe/1b/+ipQQWMklc3BOQrfXYoynSLn5IudSVNJhlGcTCSBw==
X-Received: by 2002:a17:907:7888:b0:9ad:e244:911e with SMTP id ku8-20020a170907788800b009ade244911emr6635009ejc.55.1695040349768;
        Mon, 18 Sep 2023 05:32:29 -0700 (PDT)
Received: from heron.intern.cm-ag (p200300dc6f209c00529a4cfffe3dd983.dip0.t-ipconnect.de. [2003:dc:6f20:9c00:529a:4cff:fe3d:d983])
        by smtp.gmail.com with ESMTPSA id sd5-20020a170906ce2500b00992a8a54f32sm6328834ejb.139.2023.09.18.05.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 05:32:29 -0700 (PDT)
From:   Max Kellermann <max.kellermann@ionos.com>
To:     jack@suse.cz, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     amir73il@gmail.com, max.kellermann@ionos.com
Subject: [PATCH 1/4] inotify_user: pass directory fd to inotify_find_inode()
Date:   Mon, 18 Sep 2023 14:32:14 +0200
Message-Id: <20230918123217.932179-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Preparing for inotify_add_watch_at().

To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
To: linux-fsdevel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 fs/notify/inotify/inotify_user.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 1c4bfdab008d..1853439a24f6 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -370,12 +370,12 @@ static const struct file_operations inotify_fops = {
 /*
  * find_inode - resolve a user-given path to a specific inode
  */
-static int inotify_find_inode(const char __user *dirname, struct path *path,
+static int inotify_find_inode(int dfd, const char __user *dirname, struct path *path,
 						unsigned int flags, __u64 mask)
 {
 	int error;
 
-	error = user_path_at(AT_FDCWD, dirname, flags, path);
+	error = user_path_at(dfd, dirname, flags, path);
 	if (error)
 		return error;
 	/* you can only watch an inode if you have read permissions on it */
@@ -774,7 +774,7 @@ SYSCALL_DEFINE3(inotify_add_watch, int, fd, const char __user *, pathname,
 	if (mask & IN_ONLYDIR)
 		flags |= LOOKUP_DIRECTORY;
 
-	ret = inotify_find_inode(pathname, &path, flags,
+	ret = inotify_find_inode(AT_FDCWD, pathname, &path, flags,
 			(mask & IN_ALL_EVENTS));
 	if (ret)
 		goto fput_and_out;
-- 
2.39.2

