Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C612741F36
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 06:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjF2EUy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jun 2023 00:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjF2EUx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jun 2023 00:20:53 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9944319BA
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 21:20:51 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-977e0fbd742so28194266b.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 21:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688012450; x=1690604450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tdBaY0/gRZeUGoG1Z64feUtdafy/8u45PWUchKhQa+0=;
        b=STZOIwsFSLYeLownpXjCW10wM/2zuXPG1AgtP4DCR259UMbtubhpwSkTu/kTjIBZAW
         ifI2jrAwOwF5i61+WDEsNtWoFiBYUYQ9z/7sH+va3XBurmAX2HrMHIvhwccygZUknQgz
         SgIPWYskLWpyYbyx3KX/CaWLBTNT396t/xLqwyEQwOmOTcsn1Jzo/kuIN6BRzaX1K5c/
         C41Q80oy6uCyySdM4ap6LwFL2HrZlfoe6ebAndvA1s7N675Lsae7xQEDaCHb+MYFZoX1
         5VQxFJuHVgAMoTIMbzxiyi/j+3LhRVIju1xKUusAaRaza52JuYq98cFX2/J8XJb2XMR1
         +4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688012450; x=1690604450;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tdBaY0/gRZeUGoG1Z64feUtdafy/8u45PWUchKhQa+0=;
        b=V+3YTX8MObWOnugx9c76PfbgHjJmC+djauz0J0TD778zLdAbaY0HM+/w6NPcOr8vL5
         KXsBpPr+VEULoMVWuam1DPC1cOvVeQn/I7DXG3+DEbXX6TmAZtv7BOyi0sVDQGM5bLwu
         RU5dzHzXmV8s/cCUdyLUqUIo2xl6hvx/GxDz6h0gyPs3L4OTcVLlaZqvZNLui55t5UNi
         VdCc4B5lSHgbBYAzWUXGkJbjjSIInuCn8TaZUbbWYGMN6/z2Cs1yLejCIIL/JCCXuON4
         xLGE578c74pEPfa9C/8himSeMJkVCZpphH5l2VAl3c1ntrHHjfYcdEi0WlQjmyIWKrlQ
         4JcQ==
X-Gm-Message-State: AC+VfDwWIx8aUNImOXlpcpTWSnmdh2y9kdTHkZG8tt2St+wu0yOZ3CCu
        cp0pbi7SnfflHjdDiJ0cx5laVpBWqfI=
X-Google-Smtp-Source: ACHHUZ7QDzSANjHU3LembVZGdKRdldnx4pZnlRlbTFWS0HipEIkzwt8tJ1SIcmLopqm6yx96pPxJPw==
X-Received: by 2002:a17:907:d9e:b0:98e:419b:4cc2 with SMTP id go30-20020a1709070d9e00b0098e419b4cc2mr11137343ejc.3.1688012449863;
        Wed, 28 Jun 2023 21:20:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id hk18-20020a170906c9d200b0099290e2c163sm1044398ejb.204.2023.06.28.21.20.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 21:20:49 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     =?UTF-8?q?Ahelenia=20Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH] fanotify: disallow mount/sb marks on kernel internal pseudo fs
Date:   Thu, 29 Jun 2023 07:20:44 +0300
Message-Id: <20230629042044.25723-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hopefully, nobody is trying to abuse mount/sb marks for watching all
anonymous pipes/inodes.

I cannot think of a good reason to allow this - it looks like an
oversight that dated back to the original fanotify API.

Link: https://lore.kernel.org/linux-fsdevel/20230628101132.kvchg544mczxv2pm@quack3/
Fixes: d54f4fba889b ("fanotify: add API to attach/detach super block mark")
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Jan,

As discussed, allowing sb/mount mark on anonymous pipes
makes no sense and we should not allow it.

I've noted FAN_MARK_FILESYSTEM as the Fixes commit as a trigger to
backport to maintained LTS kernels event though this dates back to day one
with FAN_MARK_MOUNT. Not sure if we should keep the Fixes tag or not.

The reason this is an RFC and that I have not included also the
optimization patch is because we may want to consider banning kernel
internal inodes from fanotify and/or inotify altogether.

The tricky point in banning anonymous pipes from inotify, which
could have existing users (?), but maybe not, so maybe this is
something that we need to try out.

I think we can easily get away with banning anonymous pipes from
fanotify altogeter, but I would not like to get to into a situation
where new applications will be written to rely on inotify for
functionaly that fanotify is never going to have.

Thoughts?
Am I over thinking this?

Amir.

 fs/notify/fanotify/fanotify_user.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 95d7d8790bc3..8240a3fdbef0 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1622,6 +1622,20 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	    path->mnt->mnt_sb->s_type->fs_flags & FS_DISALLOW_NOTIFY_PERM)
 		return -EINVAL;
 
+	/*
+	 * mount and sb marks are not allowed on kernel internal pseudo fs,
+	 * like pipe_mnt, because that would subscribe to events on all the
+	 * anonynous pipes in the system.
+	 *
+	 * XXX: SB_NOUSER covers all of the internal pseudo fs whose objects
+	 * are not exposed to user's mount namespace, but there are other
+	 * SB_KERNMOUNT fs, like nsfs, debugfs, for which the value of
+	 * allowing sb and mount mark is questionable.
+	 */
+	if (mark_type != FAN_MARK_INODE &&
+	    path->mnt->mnt_sb->s_flags & SB_NOUSER)
+		return -EINVAL;
+
 	/*
 	 * We shouldn't have allowed setting dirent events and the directory
 	 * flags FAN_ONDIR and FAN_EVENT_ON_CHILD in mask of non-dir inode,
-- 
2.34.1

