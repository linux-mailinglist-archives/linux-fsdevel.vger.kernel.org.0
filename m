Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AD47221EAF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jul 2020 10:42:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbgGPImx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 04:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728024AbgGPImt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 04:42:49 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C083CC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id o11so6128676wrv.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 01:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nyv2KtM2WO7usNbqtN+HqdiLWba1gwwl7ImOSY7fMcw=;
        b=tetOeu6P9HowxRpnSOCw/FAoB9VGZHFjyqzbpvS14Nf/WB3sxAg2PAHJ5iouHl1e4E
         PHZkYrzgDTEplr/GJ81UwMzoY05veVs06M35BQEskWwLwhwS7FD93gRLTQZy+ZW2bxmE
         HgJcwTCm0OgkwAjfiIAhB12PdSSWP+GBstBKAfuAYQBwWV0STRWjbxn2ov+9Mo5GN5DF
         7o8HgeZ0aDOz79E9gQ5VOg85HHract6b4eUE4yDn9atsO8evqJCeIFxg/Pc7QPgyvBcw
         F1VikbeIOIlu2AGHCVqjkVkq1+NiPzngsuER1vKnXNGNtRusl3g5d1gPC7Un63YMe+B2
         31gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nyv2KtM2WO7usNbqtN+HqdiLWba1gwwl7ImOSY7fMcw=;
        b=Mqw0SSW8rQTxPkRXBwsjX5zGVbKPmL/3SQqYcyksFTQlKrB0NacjG9cVOSjKCIgq9/
         xvQcEajy3kuj5qtLHbRtqr0pSosAkhXFsN1VHHBaYg26xZqCAaItIsTN3h+fu9/bb7zz
         A9dgFEaQP0gUziZLX2HxrR4nOPcmgTcXdiGlYMaJs1frf2z8obZ+qTJcq5TN3YNhWAST
         nUhefdaexOcDdyZcSaXxTMmtCSy3ITxNjKf7kmDmOXc1osi2LkITJuFPDWro+/GoytXI
         QVYZlzoGVlEDGwj5FEQwx32WrFdFnlNDE76y4yRvAeagopBdQHR5CQ1a5cX6bC/JNOGl
         JjfQ==
X-Gm-Message-State: AOAM533h7tXvMg1kvH4mjsuQ7UcTgSldQP1JIRm5ltKAZ08joNscBN2V
        ERy5huELFCSISfd4L0V8B/aKS8tT
X-Google-Smtp-Source: ABdhPJwi6vbtTUVUjq7VLtvvXVN3JEq6TruXUyGmYRVzWpNGthqkyCEEIn5euq8bxKqtGJwdgXm7pw==
X-Received: by 2002:adf:ec8c:: with SMTP id z12mr3755434wrn.281.1594888967520;
        Thu, 16 Jul 2020 01:42:47 -0700 (PDT)
Received: from localhost.localdomain ([141.226.183.23])
        by smtp.gmail.com with ESMTPSA id j75sm8509977wrj.22.2020.07.16.01.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 01:42:46 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v5 08/22] fsnotify: add object type "child" to object type iterator
Date:   Thu, 16 Jul 2020 11:42:16 +0300
Message-Id: <20200716084230.30611-9-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200716084230.30611-1-amir73il@gmail.com>
References: <20200716084230.30611-1-amir73il@gmail.com>
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

