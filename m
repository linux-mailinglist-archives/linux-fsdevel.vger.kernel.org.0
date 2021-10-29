Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0367C43FB8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Oct 2021 13:40:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231989AbhJ2LnG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Oct 2021 07:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231969AbhJ2LnC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Oct 2021 07:43:02 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD052C061745
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:33 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b2-20020a1c8002000000b0032fb900951eso4154102wmd.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 29 Oct 2021 04:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=espOezy5a4LSuBEze/qzpkewNvpn19NpfS0DCjbYONk=;
        b=IK+dlluqI7uBf8cJsP1RWYwtmHQn5U0ZT4CbgwBpd/N6UO/+KzshGqnoOaArFU+aUe
         wpIR7vOSp04Dg89sRo4okSoXje/Kxso4C+MNksntIeAuKEts+gjcsRekCCBrS1njMttw
         k0sjBG/R5ckZCgy0IB0gGTuaeO6AzS+hXm5LhsD1h3LUKZBsD+lXk6JvE7ullxCTEJDU
         UTrh8qCKMlcVFehcbFTXG6pZ5FEZ8BxW9AQtYAw537uNBgcxaevTH6ziDHIeOC6ZPrAN
         FJeIHVJozyZP1mRu+7yv99BVAHESwTfZ5WyjwB6Nhp/8fv1DS1KFTdAEu8rfXqIbESS6
         0GZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=espOezy5a4LSuBEze/qzpkewNvpn19NpfS0DCjbYONk=;
        b=JtfGqFRn6Fg60L8l3K37QBe+5GttTnJ9DqkbVOcfOWKqhitoM+Cx6IUrYWZWvhUZZO
         UxT6BJtbt7XGks79QKnPGQnYCAswrgUaGss0WkMKRapEFoSXL9POCoiMbXy+jMkZUtX7
         ehiSV1vcpeEtObHZKey3Ng9/WZjke36XU1Jpk6CkDnPTPZpclsE6tk/PrJJ5K6kc8/Jy
         I0f1RBycX95lgpE38w1Qxq4o54yEyyTCVFmiHZ16PnxEYb7NzLET3e3/dT5o1IsHH5Ak
         GaXs6RZib24KZat0AdwbZBlD+/yfuovjzxYPYzjImKfen+Cc1jIjvbkhxjDTiDSYMFSj
         vyxg==
X-Gm-Message-State: AOAM532R218FG2gZt+cVZzhKaJ3CSdASp9YOq3lrW3ckb2HiHbIzZy31
        bPJWrNCYh/6Ku35cj9LkLSU6Y6jUX+c=
X-Google-Smtp-Source: ABdhPJxnzQtAJxbXqS3J1eqcEbo2L7G6A9tYNZRUwc4x8yTAv4Tu0DWS9jUk59kuznhENcQUbuZl4g==
X-Received: by 2002:a1c:29c2:: with SMTP id p185mr18939857wmp.43.1635507632509;
        Fri, 29 Oct 2021 04:40:32 -0700 (PDT)
Received: from localhost.localdomain ([82.114.46.186])
        by smtp.gmail.com with ESMTPSA id t3sm8178643wma.38.2021.10.29.04.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Oct 2021 04:40:32 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] fsnotify: pass dentry instead of inode data for move events
Date:   Fri, 29 Oct 2021 14:40:22 +0300
Message-Id: <20211029114028.569755-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211029114028.569755-1-amir73il@gmail.com>
References: <20211029114028.569755-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is needed for reporting the new parent/name with MOVED_FROM
events.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 787545e87eeb..ae7501c80d05 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -140,7 +140,6 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 				 int isdir, struct inode *target,
 				 struct dentry *moved)
 {
-	struct inode *source = moved->d_inode;
 	u32 fs_cookie = fsnotify_get_cookie();
 	__u32 old_dir_mask = FS_MOVED_FROM;
 	__u32 new_dir_mask = FS_MOVED_TO;
@@ -154,14 +153,14 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 		new_dir_mask |= FS_ISDIR;
 	}
 
-	fsnotify_name(old_dir_mask, source, FSNOTIFY_EVENT_INODE,
+	fsnotify_name(old_dir_mask, moved, FSNOTIFY_EVENT_DENTRY,
 		      old_dir, old_name, fs_cookie);
-	fsnotify_name(new_dir_mask, source, FSNOTIFY_EVENT_INODE,
+	fsnotify_name(new_dir_mask, moved, FSNOTIFY_EVENT_DENTRY,
 		      new_dir, new_name, fs_cookie);
 
 	if (target)
 		fsnotify_link_count(target);
-	fsnotify_inode(source, FS_MOVE_SELF);
+	fsnotify_inode(d_inode(moved), FS_MOVE_SELF);
 	audit_inode_child(new_dir, moved, AUDIT_TYPE_CHILD_CREATE);
 }
 
-- 
2.33.1

