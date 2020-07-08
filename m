Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09DA52185BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 13:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgGHLMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 07:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgGHLMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 07:12:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FB7C08C5DC
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jul 2020 04:12:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id z2so26212966wrp.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jul 2020 04:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nyv2KtM2WO7usNbqtN+HqdiLWba1gwwl7ImOSY7fMcw=;
        b=ZxBkH0JutqRhUErxyJt8b0YsLkeGYodjLpK0/oT3gp/ZVYtj2lJehrnQ+FmRne02zK
         0pYoZZqyCglNeMa/3wNtJmoY8UVrx2CUkUCbasuIJcMeXzYS4NDM9djRM77tOu1LErqp
         xXb9AGz0ku4IXkfjX0PaOefz1axjyBzXh+AgP0qmjdz8utZ5tSem7S0zjsUMYslVKWRY
         N+P+tYRXtJpdvvZQWR1032yvDtzbRP734XDDqkglRva2PjIDe/7AexE5Y9MJ/1tJO1j9
         giWjc/8FruWckFQHbW8BNDqVHPIH6llPWznlLL9/qIC8PPdF4JIEjKVLtaMj5GQhbT27
         mn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nyv2KtM2WO7usNbqtN+HqdiLWba1gwwl7ImOSY7fMcw=;
        b=TJYhfxHne0Ves92s3mq9RP6DVxkdXc2VOXu7dQno/2/0BNh64vSuQC/DcTTjYE78pa
         1vaxKA8eYJ9i+veycr0kJLOfExgBtzgBNRbVKeyR6z76exM8UVTITtSpD1LgKkcQLITE
         NpdOqaqQoGSquAii379lulogFRqQxZE0W0KacK2+zxua+liT7PiqVTCguww1jjAyTvAl
         bsDI9v4eou7ROEbDdP4Hx2qrcAgbjRzHuMIt2q6cPWAelHac6vkpOuqx9RV5MTrZo3P9
         oUtYXC3PArD3txNuG9nI+EGCpW5q3raf4vw1IQQgxSkdm4coKYtC0D/wi/1+Op7sCv/R
         sB7A==
X-Gm-Message-State: AOAM533X3gN2IBK9nkXQWBpR0G1a9GoXebmLYMIW4IzfeN2DaHqGBWwD
        J4xzy7Bj5VCVtgM8QO9FTqb/J7Pe
X-Google-Smtp-Source: ABdhPJyIhYxX/45ZWx7aokPlm6c2DMyuoQUdQZwjVnjEeWsVkrYDFfHgF/4Oh1hcC0kUZX58/pCL3g==
X-Received: by 2002:adf:ea0f:: with SMTP id q15mr28064113wrm.113.1594206751817;
        Wed, 08 Jul 2020 04:12:31 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id k126sm5980834wme.17.2020.07.08.04.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 04:12:31 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 18/20] fsnotify: add object type "child" to object type iterator
Date:   Wed,  8 Jul 2020 14:11:53 +0300
Message-Id: <20200708111156.24659-18-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200708111156.24659-1-amir73il@gmail.com>
References: <20200708111156.24659-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The object type iterator is used to collect all the marks of
a specific group that have interest in an event.

It is used by fanotify to get a single handle_event callback
when an event has a match to either of inode/sb/mount marks
of the group.

The nature of fsnotify events is that they are associated with
at most one sb at most one mount and at most one inode.

When a parent and child are both watching, two events are sent
to backend, one associated to parent inode and one associated
to the child inode.

This results in duplicate events in fanotify, which usually
get merged before user reads them, but this is sub-optimal.

It would be better if the same event is sent to backend with
an object type iterator that has both the child inode and its
parent, and let the backend decide if the event should be reported
once (fanotify) or twice (inotify).

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify_backend.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 860c847c5bfa..2c62628566c5 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -255,6 +255,7 @@ static inline const struct path *fsnotify_data_path(const void *data,
 
 enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
+	FSNOTIFY_OBJ_TYPE_CHILD,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
 	FSNOTIFY_OBJ_TYPE_COUNT,
@@ -262,6 +263,7 @@ enum fsnotify_obj_type {
 };
 
 #define FSNOTIFY_OBJ_TYPE_INODE_FL	(1U << FSNOTIFY_OBJ_TYPE_INODE)
+#define FSNOTIFY_OBJ_TYPE_CHILD_FL	(1U << FSNOTIFY_OBJ_TYPE_CHILD)
 #define FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL	(1U << FSNOTIFY_OBJ_TYPE_VFSMOUNT)
 #define FSNOTIFY_OBJ_TYPE_SB_FL		(1U << FSNOTIFY_OBJ_TYPE_SB)
 #define FSNOTIFY_OBJ_ALL_TYPES_MASK	((1U << FSNOTIFY_OBJ_TYPE_COUNT) - 1)
@@ -306,6 +308,7 @@ static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 }
 
 FSNOTIFY_ITER_FUNCS(inode, INODE)
+FSNOTIFY_ITER_FUNCS(child, CHILD)
 FSNOTIFY_ITER_FUNCS(vfsmount, VFSMOUNT)
 FSNOTIFY_ITER_FUNCS(sb, SB)
 
-- 
2.17.1

