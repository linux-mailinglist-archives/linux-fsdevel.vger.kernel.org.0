Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978B974E5E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jul 2023 06:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjGKEgi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jul 2023 00:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjGKEgg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jul 2023 00:36:36 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4580AE4D
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 21:36:35 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b7e66ff65fso39142465ad.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 10 Jul 2023 21:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689050195; x=1691642195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XAHhhESlWk2lPaujVBvLDXmvRjl2svsri3z2wXZkLk=;
        b=M8vGYeHoV98HxtEMd30yZy8J3vsp1gg2UT4CLif35qX5VjoffNTseSfCyCPQjIFXd3
         jMXsnIN0y93aH99CbAOqK1hQE2WTk+EnG39KFI93kZTddE/ujIniiOVaxFJ9l2l4vTyy
         jxxAVfv4neMTtiBhVY1x1UCTGNus5SOkXaix/+VzLqJK/JlnU4Kcb8D4gfAGDEfpfMVG
         INTIy7c3kT1rRA6/vEmVG6JIAT+juFpfwpk2RuCHm+yuEJpr/Ig5n/5eBGCmRW1nx2i7
         F2KVD16LtUYKJ7l7HCE+eVrlVLVXKFzfR62F3qHP5TSypqeEUutFNuq7rPM8cbnX+yk3
         c8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689050195; x=1691642195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XAHhhESlWk2lPaujVBvLDXmvRjl2svsri3z2wXZkLk=;
        b=OpNezfGG00kJrykXvtDLWb/RcuIq4LbLD/PdIvNxJMSGtjvv59oAA/O+mw+i8Jrfv7
         iagmvpiWkCye61GAEhBR5KI5BtLRHcnoYd+KLtsZLtfgM1MVOWFd4iYG8YgtDhXyzdch
         MPFc6nzwS5i5uI97xKSKvcbLP2szuBE2HHsV5b8Iu8ItNLwCa0/aPq1XLKCBBJCriM3c
         p5PeaAXrD6cECBuvnZl8ILjVYSKy9aW2SQUx9eel2dQaTrV5ZUrnyYRl15xYOK7/1LOU
         jD0+IJueezwnrxrWWtVlZ/FjFExbfA96ErMZKC8Yly/Br+XyqkG2fZft5QpWB6OQ+LLm
         v+BQ==
X-Gm-Message-State: ABy/qLYJK33VfI6hxZpLHO8SgtmxcjzxHlm/Qi8jdgUv+7g1pUgjoKX4
        dcf1c1a3PfG4u6EYOQNPkDUXgA==
X-Google-Smtp-Source: APBJJlHVXHi5H4pyAltoj/82qhz5I3Bsfho9pJLgbS3udUMYxFnBreB2K43EEK98etc5oZFkabl6Ow==
X-Received: by 2002:a17:902:b117:b0:1b3:e90b:93e1 with SMTP id q23-20020a170902b11700b001b3e90b93e1mr13910557plr.36.1689050194747;
        Mon, 10 Jul 2023 21:36:34 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id ij9-20020a170902ab4900b001b9de67285dsm755259plb.156.2023.07.10.21.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 21:36:34 -0700 (PDT)
From:   Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     me@jcix.top, Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
Subject: [PATCH 2/5] fuse: invalidate dentry on EEXIST creates or ENOENT deletes
Date:   Tue, 11 Jul 2023 12:34:02 +0800
Message-Id: <20230711043405.66256-3-zhangjiachen.jaycee@bytedance.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
References: <20230711043405.66256-1-zhangjiachen.jaycee@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The EEXIST errors returned from server are strong sign that a local
negative dentry should be invalidated. Similarly, The ENOENT errors from
server can also be a sign of revalidate failure. This commit invalidates
dentries on EEXIST creates and ENOENT deletes by calling
fuse_invalidate_entry(), which improves the consistency with no
performance degradation.

Signed-off-by: Jiachen Zhang <zhangjiachen.jaycee@bytedance.com>
---
 fs/fuse/dir.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 5a4a7155cf1c..cfe38ee91ffd 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -755,7 +755,8 @@ static int fuse_atomic_open(struct inode *dir, struct dentry *entry,
 	if (err == -ENOSYS) {
 		fc->no_create = 1;
 		goto mknod;
-	}
+	} else if (err == -EEXIST)
+		fuse_invalidate_entry(entry);
 out_dput:
 	dput(res);
 	return err;
@@ -835,6 +836,8 @@ static int create_new_entry(struct fuse_mount *fm, struct fuse_args *args,
 	return 0;
 
  out_put_forget_req:
+	if (err == -EEXIST)
+		fuse_invalidate_entry(entry);
 	kfree(forget);
 	return err;
 }
@@ -986,7 +989,7 @@ static int fuse_unlink(struct inode *dir, struct dentry *entry)
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
-	} else if (err == -EINTR)
+	} else if (err == -EINTR || err == -ENOENT)
 		fuse_invalidate_entry(entry);
 	return err;
 }
@@ -1009,7 +1012,7 @@ static int fuse_rmdir(struct inode *dir, struct dentry *entry)
 	if (!err) {
 		fuse_dir_changed(dir);
 		fuse_entry_unlinked(entry);
-	} else if (err == -EINTR)
+	} else if (err == -EINTR || err == -ENOENT)
 		fuse_invalidate_entry(entry);
 	return err;
 }
@@ -1050,7 +1053,7 @@ static int fuse_rename_common(struct inode *olddir, struct dentry *oldent,
 		/* newent will end up negative */
 		if (!(flags & RENAME_EXCHANGE) && d_really_is_positive(newent))
 			fuse_entry_unlinked(newent);
-	} else if (err == -EINTR) {
+	} else if (err == -EINTR || err == -ENOENT) {
 		/* If request was interrupted, DEITY only knows if the
 		   rename actually took place.  If the invalidation
 		   fails (e.g. some process has CWD under the renamed
-- 
2.20.1

