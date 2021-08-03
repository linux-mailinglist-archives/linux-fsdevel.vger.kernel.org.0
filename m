Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 658413DF44C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Aug 2021 20:04:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbhHCSER (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Aug 2021 14:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbhHCSER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Aug 2021 14:04:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53A8BC06175F
        for <linux-fsdevel@vger.kernel.org>; Tue,  3 Aug 2021 11:04:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id h14so26218658wrx.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 03 Aug 2021 11:04:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pi1UXkTQldERNML991jYDsPgWN1vYpM8GjLB7gfzc1E=;
        b=K8HR+dehCQLfMWVbgpOXAwZzR9jl0or7LFqyt8BEGPHsBv4hPgHGU/ZvsIHS/sFaaf
         Htq7b+CtfBMd1JcOGpyhgumXlWapNrJELVOGQpIVTtxAlzLtIkRrxgrdwkxQ45wt5loh
         eM29eoG+f2uncAgpewtXpgb2fD1+1gMLJR+z1o+jaM5E4MvN76Ct3prmEguZucRvVA8g
         L5IkBY1k/hAiacpbI4VgtM4uZRjT+9qDWpx40UhbLHncC8qPWm1JFw44RnYVK5cyWeJS
         4sS/qltssXTiLlkZcne6Z1g+np1LmCY2ajOlqe9w9R3apZNKsjW2/GwF272QpbSQ7Pu/
         kzOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pi1UXkTQldERNML991jYDsPgWN1vYpM8GjLB7gfzc1E=;
        b=k3AnGR0y6S5TvLb/ydpqWRqZ1ucoS4N3D28LdSCryYbgQaUYVkN0ISM4CBebEf/KMb
         thrJutf2vGs2Gsojl0Xmb84YmyueC1Sbepoh72i9Rt0Del6KI8QqLYqzaOzeL6xFOlB9
         U1nlJRFZ8XukIryITGjfzWZFMkY2Dr0szbb5oINPy3HlzZr9RaVKGuMyTQ2gIS2tTCD6
         1NvM1zifhcYk9cBzhP0nIa/SSBXj6fM/DbBdaC12CZf9SG094xNn4zoKKCGJ3kTuBrka
         9iQ6VGWDfdbgcRm9e7psSWdJuyqk+n0cd6sBI0RHbuHK3mbxcUg0tqz00uQQk800Gym0
         3Jmw==
X-Gm-Message-State: AOAM533ShV211w8GK1rFU/x2mptsJGBwq59550WgPjYrIltxaSLDf7A3
        0yE7M1cj55HsubPPOHAIKgzGSM5pVp4=
X-Google-Smtp-Source: ABdhPJwH5BHhiJ5aJqS6GbmbvxoKhccrgv9Wpm03zIysFDtMfyQnKchFlU/dQWhUg3VSqRaSbDChUQ==
X-Received: by 2002:adf:d085:: with SMTP id y5mr23877371wrh.272.1628013844012;
        Tue, 03 Aug 2021 11:04:04 -0700 (PDT)
Received: from localhost.localdomain ([185.110.110.213])
        by smtp.gmail.com with ESMTPSA id b14sm15515555wrm.43.2021.08.03.11.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 11:04:03 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 4/4] fsnotify: optimize the case of no marks of any type
Date:   Tue,  3 Aug 2021 21:03:44 +0300
Message-Id: <20210803180344.2398374-5-amir73il@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210803180344.2398374-1-amir73il@gmail.com>
References: <20210803180344.2398374-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a simple check in the inline helpers to avoid calling fsnotify()
and __fsnotify_parent() in case there are no marks of any type
(inode/sb/mount) for an inode's sb, so there can be no objects
of any type interested in the event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index f8acddcf54fb..12d3a7d308ab 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -30,6 +30,9 @@ static inline void fsnotify_name(struct inode *dir, __u32 mask,
 				 struct inode *child,
 				 const struct qstr *name, u32 cookie)
 {
+	if (atomic_long_read(&dir->i_sb->s_fsnotify_connectors) == 0)
+		return;
+
 	fsnotify(mask, child, FSNOTIFY_EVENT_INODE, dir, name, NULL, cookie);
 }
 
@@ -41,6 +44,9 @@ static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
 
 static inline void fsnotify_inode(struct inode *inode, __u32 mask)
 {
+	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+		return;
+
 	if (S_ISDIR(inode->i_mode))
 		mask |= FS_ISDIR;
 
@@ -53,6 +59,9 @@ static inline int fsnotify_parent(struct dentry *dentry, __u32 mask,
 {
 	struct inode *inode = d_inode(dentry);
 
+	if (atomic_long_read(&inode->i_sb->s_fsnotify_connectors) == 0)
+		return 0;
+
 	if (S_ISDIR(inode->i_mode)) {
 		mask |= FS_ISDIR;
 
-- 
2.25.1

