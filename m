Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3547372B3D6
	for <lists+linux-fsdevel@lfdr.de>; Sun, 11 Jun 2023 21:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjFKTrT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 11 Jun 2023 15:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjFKTrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 11 Jun 2023 15:47:16 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB49C9;
        Sun, 11 Jun 2023 12:47:15 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f7fc9014fdso25928335e9.3;
        Sun, 11 Jun 2023 12:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686512834; x=1689104834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewts1Hoyhwjv61Cr5r+qKFYTZaWq/bD1prALWOt2zeo=;
        b=ZAtxiFecVbTboKIjCB0RwbyDN+FnFjwHWEGy5jfDl7l6EWwUdjB8n9RxBrXOF3YQW1
         EKo6lXxYJSNBh7xtM9buUachGo1hlKoYv+2CRdSNwMmDwvdHHJ/d76Zl3xnXtchc+6CS
         pdrjO1KIRc9hQlwS1XHp1lUDXyjfaEhfP3ozvpH/Yk8csy/b0CvrrtzdOvnsiqkaoP1B
         AA7o3yMIsROp4v8oCghOXGT9fAYL4QWK7UOsNpGKxgMaaYo9qwwJkAUUcB86Iqf5nZw4
         bEt2dTlgJ1fMHm478bP1Ad+T6jbgMmq3g0gUAQmCLDyY1SXIZkrxIjdtIjc56KjpImM2
         oGhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686512834; x=1689104834;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewts1Hoyhwjv61Cr5r+qKFYTZaWq/bD1prALWOt2zeo=;
        b=XdzQkgWa+mTcUJOqkxGr7ood85YvGZY3195CnGa5236sHtCKubzUkFWqAY4cPP10cY
         WWkB5LIfEHm9jWV2QPeLInepM6B6QKEJU2Y24qj1yVst/DZvW4UzoqsTNG070itpEgVj
         rNqbxEaH+1bHC28vX2L1DHXi38n3ShbIrj957dbtKCRpZfnW8lg62wRM6Ms1TiMLfues
         xjEmChzCnrqQhlzcukQs899s1NGufVsXQQkWBxuIwTq9XaMtt+wLenarYE1jN76SPW0M
         gBDKDCSzimQtm06xpZfBcpWOqTBeA2LwkTKFqg/Hu0XL8rsF8NQncP6IWhuD8E6XLHMW
         VZrg==
X-Gm-Message-State: AC+VfDw3bHtZ2E1ki0Lxr1dGcPCz/JRJTApStUUkEyu5EoqSUExB2SFa
        5j6QqSZMqmX/JAL/zd5BcfA=
X-Google-Smtp-Source: ACHHUZ5ME7wYQIEgO64DHR7UBQ7eVZtkSkQ+6LquiODS8e5SB3EtDAywmV50zxrFI2kqKj0lSdXSCQ==
X-Received: by 2002:a05:600c:2942:b0:3f8:f5d:52ec with SMTP id n2-20020a05600c294200b003f80f5d52ecmr3676072wmd.11.1686512833835;
        Sun, 11 Jun 2023 12:47:13 -0700 (PDT)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c211a00b003f42314832fsm9221902wml.18.2023.06.11.12.47.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 12:47:13 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH v3 2/2] ovl: enable fsnotify events on underlying real files
Date:   Sun, 11 Jun 2023 22:47:06 +0300
Message-Id: <20230611194706.1583818-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230611194706.1583818-1-amir73il@gmail.com>
References: <20230611194706.1583818-1-amir73il@gmail.com>
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
 include/linux/fsnotify.h | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 6309dab46985..862563014ae5 100644
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
index bb8467cd11ae..6f6cbc2dc49b 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -91,7 +91,8 @@ static inline void fsnotify_dentry(struct dentry *dentry, __u32 mask)
 
 static inline int fsnotify_file(struct file *file, __u32 mask)
 {
-	const struct path *path = &file->f_path;
+	/* Overlayfs internal files have fake f_path */
+	const struct path *path = f_real_path(file);
 
 	if (file->f_mode & FMODE_NONOTIFY)
 		return 0;
-- 
2.34.1

