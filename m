Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB6A5495626
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 22:53:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347730AbiATVxQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 16:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiATVxL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 16:53:11 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B45AC061574
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 13:53:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so17100617wms.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jan 2022 13:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mc34WbwZ3JOC+keBE25C3l50dTN2VkS75ynRLoWNQ+Q=;
        b=NxhKSGbr6WhpJ1KC0/DcA+yG0qpvFX/Fd2m3PkMiPehdTn2oo2XtGfib1Up01V6T9I
         0SFmBdHqvL2USxg6w9cyDsMiBDtaRhe73amY2YIVSsBY4Pf2kgvIlrcHNRQJf0sTASeX
         Ia4sE89iT5DRM5WZBrxKNVXb25XXUCtk+uM0cbAxkRpniZcyS5Zh6VBoo0xYF8qmQt0G
         Jo1t8xGs6ek6vHqbqnApGruSQe0P18Yo8b98QUJQyzcvGTZpypfFW11ErEhZ79ak8MYM
         2NeMbfFqZupNrqtN2OLhWtKObLm6RovEwFk9WuKGP8OBcpb97y/64LPBsW1k+0Lwq6IH
         z0tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mc34WbwZ3JOC+keBE25C3l50dTN2VkS75ynRLoWNQ+Q=;
        b=x0Ajoi8IFwKl36oHNzWHmcdeksSVizeKmAEt4dj4ELoOdYP/FbKv27BvhD23vtWS06
         IqAXfYDRyGsqrCWfq8mRAFPutLWn1+GjByMSGrqdE3sEfRSwQ31lanQ4XKueIpRpNibu
         5r4Tb6YBUICBJjUYn32SO0KhueocAL3CgMpPp8eyPNZlDT4e0Ubh/86jPNs2lAiqcq+b
         OVKAr6Sw2Wu9Eoghj7IvHx52SGkuTVzMWOKjoJy8rvz03pyqerBSWwRqkqPeI+P1hWwf
         zpbjyQ5ESLRr6nHHFncPb2xyRKZvMUpiGbbBfk928Zjzl/VHY6LK3HHLcXvfwCtBWFhh
         He1Q==
X-Gm-Message-State: AOAM533csGdysKFWSZvIB9iYxZOCf6zfRMRRVYoiAo6FVcVfZbshrPHl
        fbYkrStDzIO9wuoO9FpKJqE=
X-Google-Smtp-Source: ABdhPJztN3J+42xncOrAmlJIradzhQmuu1J8ckWOtjmi6CkJMT4G0OaY63wY6bPd5usRul0fh6X/Kg==
X-Received: by 2002:adf:e592:: with SMTP id l18mr933379wrm.217.1642715589490;
        Thu, 20 Jan 2022 13:53:09 -0800 (PST)
Received: from localhost.localdomain ([77.137.71.153])
        by smtp.gmail.com with ESMTPSA id y8sm4839519wrd.8.2022.01.20.13.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 13:53:08 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <repnop@google.com>,
        Ivan Delalande <colona@arista.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 2/2] fsnotify: fix fsnotify hooks in pseudo filesystems
Date:   Thu, 20 Jan 2022 23:53:05 +0200
Message-Id: <20220120215305.282577-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220120215305.282577-1-amir73il@gmail.com>
References: <20220120215305.282577-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Commit 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of
d_delete()") moved the fsnotify delete hook before d_delete() so fsnotify
will have access to a positive dentry.

This allowed a race where opening the deleted file via cached dentry
is now possible after receiving the IN_DELETE event.

To fix the regression in pseudo filesystems, convert d_delete() calls
to d_drop() (see commit 46c46f8df9aa ("devpts_pty_kill(): don't bother
with d_delete()") and move the fsnotify hook after d_drop().

Add a missing fsnotify_unlink() hook in nfsdfs that was found during
the audit of fsnotify hooks in pseudo filesystems.

Note that the fsnotify hooks in simple_recursive_removal() follow
d_invalidate(), so they require no change.

Reported-by: Ivan Delalande <colona@arista.com>
Link: https://lore.kernel.org/linux-fsdevel/YeNyzoDM5hP5LtGW@visor/
Fixes: 49246466a989 ("fsnotify: move fsnotify_nameremove() hook out of d_delete()")
Cc: stable@vger.kernel.org # v5.3+
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/configfs/dir.c     | 6 +++---
 fs/devpts/inode.c     | 2 +-
 fs/nfsd/nfsctl.c      | 5 +++--
 net/sunrpc/rpc_pipe.c | 4 ++--
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/configfs/dir.c b/fs/configfs/dir.c
index 1466b5d01cbb..d3cd2a94d1e8 100644
--- a/fs/configfs/dir.c
+++ b/fs/configfs/dir.c
@@ -1780,8 +1780,8 @@ void configfs_unregister_group(struct config_group *group)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
+	d_drop(dentry);
 	fsnotify_rmdir(d_inode(parent), dentry);
-	d_delete(dentry);
 	inode_unlock(d_inode(parent));
 
 	dput(dentry);
@@ -1922,10 +1922,10 @@ void configfs_unregister_subsystem(struct configfs_subsystem *subsys)
 	configfs_detach_group(&group->cg_item);
 	d_inode(dentry)->i_flags |= S_DEAD;
 	dont_mount(dentry);
-	fsnotify_rmdir(d_inode(root), dentry);
 	inode_unlock(d_inode(dentry));
 
-	d_delete(dentry);
+	d_drop(dentry);
+	fsnotify_rmdir(d_inode(root), dentry);
 
 	inode_unlock(d_inode(root));
 
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index 42e5a766d33c..4f25015aa534 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -621,8 +621,8 @@ void devpts_pty_kill(struct dentry *dentry)
 
 	dentry->d_fsdata = NULL;
 	drop_nlink(dentry->d_inode);
-	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
 	d_drop(dentry);
+	fsnotify_unlink(d_inode(dentry->d_parent), dentry);
 	dput(dentry);	/* d_alloc_name() in devpts_pty_new() */
 }
 
diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index 51a49e0cfe37..d0761ca8cb54 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1249,7 +1249,8 @@ static void nfsdfs_remove_file(struct inode *dir, struct dentry *dentry)
 	clear_ncl(d_inode(dentry));
 	dget(dentry);
 	ret = simple_unlink(dir, dentry);
-	d_delete(dentry);
+	d_drop(dentry);
+	fsnotify_unlink(dir, dentry);
 	dput(dentry);
 	WARN_ON_ONCE(ret);
 }
@@ -1340,8 +1341,8 @@ void nfsd_client_rmdir(struct dentry *dentry)
 	dget(dentry);
 	ret = simple_rmdir(dir, dentry);
 	WARN_ON_ONCE(ret);
+	d_drop(dentry);
 	fsnotify_rmdir(dir, dentry);
-	d_delete(dentry);
 	dput(dentry);
 	inode_unlock(dir);
 }
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index ee5336d73fdd..35588f0afa86 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -600,9 +600,9 @@ static int __rpc_rmdir(struct inode *dir, struct dentry *dentry)
 
 	dget(dentry);
 	ret = simple_rmdir(dir, dentry);
+	d_drop(dentry);
 	if (!ret)
 		fsnotify_rmdir(dir, dentry);
-	d_delete(dentry);
 	dput(dentry);
 	return ret;
 }
@@ -613,9 +613,9 @@ static int __rpc_unlink(struct inode *dir, struct dentry *dentry)
 
 	dget(dentry);
 	ret = simple_unlink(dir, dentry);
+	d_drop(dentry);
 	if (!ret)
 		fsnotify_unlink(dir, dentry);
-	d_delete(dentry);
 	dput(dentry);
 	return ret;
 }
-- 
2.34.1

