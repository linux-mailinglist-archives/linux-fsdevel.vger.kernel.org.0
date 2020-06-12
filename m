Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA5F1F7617
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 11:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgFLJe2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 05:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbgFLJe0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:34:26 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9864C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:25 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id gl26so9401302ejb.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jun 2020 02:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=o1ilqhP11b7mG6htExT4jl+becIXl5lkw/PI2nLy92w=;
        b=TWOs3zml5Li/DZo5rnbwpjulGrFDtj6pYB1GOH9IHp2X5CnxRyXzgrkYbqe2g4exLa
         +bM0wL2yRZ/H6FldmZKGWaJE+E4nbrgrzgd0lcWu6o6Yeohq3mxfaJbbiFv0rxQcBEAk
         eNi5qwLcRDRaZFhoXuwYxg4GdjSdzJ5+oRj2bqdRMfOpwkWdGjVJogBFq4mO57SFySI0
         nHJJUaQlkn8687yCDo5kc/VCpumUh4xAvFVgRP/IKWRoHIfNKRb2lFpSGUi9j9J+D/QB
         Hg5mGju7L97GhjDY3r6W7bt9CllztTIJmsqUFuPZIg1+vcrBarRze13oSuN2Wx3qIpFX
         WSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=o1ilqhP11b7mG6htExT4jl+becIXl5lkw/PI2nLy92w=;
        b=GlRboYd0HlpB9XZ470T2Vp8Qi7jed0tWF+y+3Vo3MdCKA8zfqTiIZIme1MyAaDWZE1
         22lSAzMp92V0SueqqGY7spsBD6wqKCoW062YDAPi2/DVAFgPlInEXISL87Goc9rXFLNy
         zSJQKAUiOymR+gN94s9BvJlMxmXBHdUymy/S6J49NK8hK/wUElgQvIMIGVYK33alcvsl
         tm+RWWXEsCXP0bBhWriQK51K0sAs0MUqHYAf6pOtbRQJNm2dtAHPj15odaNtR8gkNBWu
         GhRGrqnLxtOzUlZhtmGI8DtPRNU4oI6xgXE68pzs0nvVMHt7QlCOknb9K0Du4W+5Td/U
         dgVA==
X-Gm-Message-State: AOAM532LTURhJYXeieReTpTEJuueghcKJeqiLTvccvjVe1zv60YkKV1O
        YlvDxdYyGUU+0k1zOq5WxDIBqvUP
X-Google-Smtp-Source: ABdhPJyeJjETtl0EnAQ5zYTyTK7VFM/vm6HiClC/SzBD3nORyIDkgTVV7c7b0324niyj/vZlDxu9qQ==
X-Received: by 2002:a17:907:42d2:: with SMTP id ng2mr10913903ejb.301.1591954464435;
        Fri, 12 Jun 2020 02:34:24 -0700 (PDT)
Received: from localhost.localdomain ([5.102.204.95])
        by smtp.gmail.com with ESMTPSA id l2sm2876578edq.9.2020.06.12.02.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:34:23 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 18/20] fsnotify: add object type "child" to object type iterator
Date:   Fri, 12 Jun 2020 12:33:41 +0300
Message-Id: <20200612093343.5669-19-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612093343.5669-1-amir73il@gmail.com>
References: <20200612093343.5669-1-amir73il@gmail.com>
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
index 738d669f6d6d..e4bc52dcb6e0 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -256,6 +256,7 @@ static inline const struct path *fsnotify_data_path(const void *data,
 
 enum fsnotify_obj_type {
 	FSNOTIFY_OBJ_TYPE_INODE,
+	FSNOTIFY_OBJ_TYPE_CHILD,
 	FSNOTIFY_OBJ_TYPE_VFSMOUNT,
 	FSNOTIFY_OBJ_TYPE_SB,
 	FSNOTIFY_OBJ_TYPE_COUNT,
@@ -263,6 +264,7 @@ enum fsnotify_obj_type {
 };
 
 #define FSNOTIFY_OBJ_TYPE_INODE_FL	(1U << FSNOTIFY_OBJ_TYPE_INODE)
+#define FSNOTIFY_OBJ_TYPE_CHILD_FL	(1U << FSNOTIFY_OBJ_TYPE_CHILD)
 #define FSNOTIFY_OBJ_TYPE_VFSMOUNT_FL	(1U << FSNOTIFY_OBJ_TYPE_VFSMOUNT)
 #define FSNOTIFY_OBJ_TYPE_SB_FL		(1U << FSNOTIFY_OBJ_TYPE_SB)
 #define FSNOTIFY_OBJ_ALL_TYPES_MASK	((1U << FSNOTIFY_OBJ_TYPE_COUNT) - 1)
@@ -307,6 +309,7 @@ static inline struct fsnotify_mark *fsnotify_iter_##name##_mark( \
 }
 
 FSNOTIFY_ITER_FUNCS(inode, INODE)
+FSNOTIFY_ITER_FUNCS(child, CHILD)
 FSNOTIFY_ITER_FUNCS(vfsmount, VFSMOUNT)
 FSNOTIFY_ITER_FUNCS(sb, SB)
 
-- 
2.17.1

