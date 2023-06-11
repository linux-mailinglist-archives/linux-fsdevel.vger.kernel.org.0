Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271B872B219
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 15:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbjFKN1v (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 09:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233505AbjFKN1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 09:27:44 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB27E57;
        Sun, 11 Jun 2023 06:27:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-30fbcfdc7b6so209323f8f.3;
        Sun, 11 Jun 2023 06:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686490062; x=1689082062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/NXu5lzuXPa3n5cZXSckUaHCdmsimcqXflXrOFxRmz8=;
        b=AjBlq/XI+W96bCJgFTxL45+n0Hg1pNGkXKL4AygoJ/ad6qXy61o7EkG/JRriP4DqOe
         ED7ObFwVfoHtHlHRfIBoTKJ2umieM/Xo7xEw8m6Efsc2H+gdnqqPxqO+NmZYwau6ewJD
         pPnlqHl1uBpodoJH1YqyX9+Wynsw4+65UBlT8mqOnjZI76t+C083VfXwIZWFL6CUymb1
         gDRsgDzRNnr5W0fO3ei3lBqTtQlERb174kWIaprlP0zVVH9p+kKJ6LxkeJs7yGDgC3J/
         yhfsfgV2vGnVkx5QTmWDSiOOmlBo6cLSc0ngh2ssEU99AeeT90k1rpK9MnXFE2mNWGIl
         XR8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686490062; x=1689082062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/NXu5lzuXPa3n5cZXSckUaHCdmsimcqXflXrOFxRmz8=;
        b=ATP78BXqAemDZblrjp/jHHTTy5QTvejpnuFyqzTCQC2sPKy1YRSUtJgydJP02iPhi3
         1uL0+Kvl9w2JOiomOvoVBkjhMg0MnP9p9hlKc4shPxnWwjxiqU+9J+LAZ7S/k+g3YfYi
         n/3ME83RBpFHTFfKJ9cvLk6nCyjS32tAkJ9vPtkdXU3KCcclpq83cyB/uYGyR92JVH6r
         G8rxUEFXpJEjM4nQvbv1/wKCoH+BRRSsCMMD1XJr8cV8wv5Zi8ZXOYW1plb+rTq/W1eV
         Pby/zLGqMnjaA06NSBrnKd8Pm8lrKlQ/svhIP+a3cbTlDnuqmGN1252yd/EARv23D1Tp
         D0Gg==
X-Gm-Message-State: AC+VfDxWcx/dK39Q/3ZSj2U/YVQbUxbf2js4beYcDY9RsAGl0U03W1am
        XHaBl41F9JyijQxoaH+voRk=
X-Google-Smtp-Source: ACHHUZ6OvW4MZJMMfm3W1e0PyndVSRK4r9WLcVaY5mIIIQUp3/gvf6unAcmnV0po3YCFeEgcRomgPg==
X-Received: by 2002:adf:fe0c:0:b0:306:3284:824f with SMTP id n12-20020adffe0c000000b003063284824fmr2563928wrr.8.1686490061699;
        Sun, 11 Jun 2023 06:27:41 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id c3-20020adffb03000000b0030ab5ebefa8sm9593940wrr.46.2023.06.11.06.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 06:27:41 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v2 3/3] ovl: enable fsnotify events on underlying real files
Date:   Sun, 11 Jun 2023 16:27:32 +0300
Message-Id: <20230611132732.1502040-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611132732.1502040-1-amir73il@gmail.com>
References: <20230611132732.1502040-1-amir73il@gmail.com>
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

Overlayfs creates the real underlying files with fake f_path, whose
f_inode is on the underlying fs and f_path on overlayfs.

Those real files were open with FMODE_NONOTIFY, because fsnotify code was
not prapared to handle fsnotify hooks on files with fake path correctly
and fanotify would report unexpected event->fd with fake overlayfs path,
when the underlying fs was being watched.

Teach fsnotify to handle events on the real files, and do not set real
files to FMODE_NONOTIFY to allow operations on real file (e.g. open,
access, modify, close) to generate async and permission events.

Because fsnotify does not have notifications on address space
operations, we do not need to worry about ->vm_file not reporting
events to a watched overlayfs when users are accessing a mapped
overlayfs file.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/overlayfs/file.c      | 4 ++--
 include/linux/fsnotify.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 39737c2aaa84..61b5faa2b10f 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -34,8 +34,8 @@ static char ovl_whatisit(struct inode *inode, struct inode *realinode)
 		return 'm';
 }
 
-/* No atime modification nor notify on underlying */
-#define OVL_OPEN_FLAGS (O_NOATIME | FMODE_NONOTIFY)
+/* No atime modification on underlying */
+#define OVL_OPEN_FLAGS (O_NOATIME)
 
 static struct file *ovl_open_realfile(const struct file *file,
 				      const struct path *realpath)
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index bb8467cd11ae..f4f5db765ec2 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -91,12 +91,14 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
 {
-	const struct path *path = &file->f_path;
+	struct path path;
 
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
 
-	return fsnotify_parent(path->dentry, mask, path, FSNOTIFY_EVENT_PATH);
+	/* Overlayfs internal files have fake f_path */
+	path = f_real_path(file);
+	return fsnotify_parent(path.dentry, mask, &path, FSNOTIFY_EVENT_PATH);
 }
 
 /* Simple call site for access decisions */
-- 
2.34.1

