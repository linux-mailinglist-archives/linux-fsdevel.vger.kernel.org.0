Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86CD620366
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbfEPK1M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:27:12 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35796 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbfEPK1L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:27:11 -0400
Received: by mail-wm1-f65.google.com with SMTP id q15so2911520wmj.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4bdjyR4m8h8raappyVKGgwLGodQevThJISEQQyBEVd0=;
        b=hNXLe8bVEIr5XSpNObJUIhCniKcDnvrTMIVEP2UCHFzCiF5yh4+k+vn/7dL27c+APF
         Vg/y2qa0yxQrv+Sg4bVEViBpNbaJSbsmyIZAhCNp/7wEa/e7CI6OfGWc6VKCBeQtpAku
         ruMerdftmocy3Bep5ziLJIw9JD0lkL7lS4m1W7zDN+uDXlskNrIWZIoQWf6IIXsUvc5t
         8b6uK+rUB6nO+Mx7Yd02eJVRBKUy5hI5xFmXERMhD0uvWEG22/TcAB92jsWIgvSf8/4V
         vuCirExurqsYV7FJ2rqHN+dwu7sA4bX0rQMIAsSPgxin3Xob2SNc30K+a5JmzBPmPW4z
         bnFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4bdjyR4m8h8raappyVKGgwLGodQevThJISEQQyBEVd0=;
        b=r10IFsBx5UCrevp+qDbD//oruPJaAnwI2JTxF/oadZw1IuMRLFvSW/kWixweOC+so6
         X99W712vwc+j2vVXPIKj9ZDWWU47qfFMRUBPaUe8aHANRxxe88HYUwY2Ed0+rwUaHtB3
         /uhSnoWeF8XWfGXEMfubn7rvdXaEK47/+8vJt0qNrF4cmcZ4EwUMFm7cw6g/LBnrYeFw
         roNFJ9TTRe9QPw8uCqCp8CRB4HMGdbHc3dlDCNY91lqBXDempNIAO+n3gW5E22rc4rGT
         rFvDF0DZEKLQkGq7dECVLhmRBX7yIDYt2v9fHWb2vRyXIXlA3wKKBEMRB13tqbcL6lWt
         KKdA==
X-Gm-Message-State: APjAAAX1uoEiXG09rOol0uvmPTL2TdgFW0WvEroTjKITBJVMEKIDHZH1
        qDelhOzwhHnbA7gSpJ6RdI0=
X-Google-Smtp-Source: APXvYqw3NLLfvU1o1DnqAolVULSgxqvZTqGIkorgVzpx1ZGTtKCR5PRTbA1oaTfMqqrGZl3RRMVh1Q==
X-Received: by 2002:a7b:ce83:: with SMTP id q3mr25700394wmj.32.1558002430128;
        Thu, 16 May 2019 03:27:10 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.27.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:27:09 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 13/14] fsnotify: move fsnotify_nameremove() hook out of d_delete()
Date:   Thu, 16 May 2019 13:26:40 +0300
Message-Id: <20190516102641.6574-14-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

d_delete() was piggy backed for the fsnotify_nameremove() hook when
in fact not all callers of d_delete() care about fsnotify events.

For all callers of d_delete() that may be interested in fsnotify events,
we made sure to call one of fsnotify_{unlink,rmdir}() hooks before
calling d_delete().

Now we can move the fsnotify_nameremove() call from d_delete() to the
fsnotify_{unlink,rmdir}() hooks.

Two explicit calls to fsnotify_nameremove() from nfs/afs sillyrename
are also removed. This will cause a change of behavior - nfs/afs will
NOT generate an fsnotify delete event when renaming over a positive
dentry.  This change is desirable, because it is consistent with the
behavior of all other filesystems.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/afs/dir_silly.c       | 5 -----
 fs/dcache.c              | 2 --
 fs/nfs/unlink.c          | 6 ------
 include/linux/fsnotify.h | 2 ++
 4 files changed, 2 insertions(+), 13 deletions(-)

diff --git a/fs/afs/dir_silly.c b/fs/afs/dir_silly.c
index f6f89fdab6b2..d3494825d08a 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -57,11 +57,6 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode
 		if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 			afs_edit_dir_add(dvnode, &new->d_name,
 					 &vnode->fid, afs_edit_dir_for_silly_1);
-
-		/* vfs_unlink and the like do not issue this when a file is
-		 * sillyrenamed, so do it here.
-		 */
-		fsnotify_nameremove(old, 0);
 	}
 
 	_leave(" = %d", ret);
diff --git a/fs/dcache.c b/fs/dcache.c
index 8136bda27a1f..ce131339410c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2371,7 +2371,6 @@ EXPORT_SYMBOL(d_hash_and_lookup);
 void d_delete(struct dentry * dentry)
 {
 	struct inode *inode = dentry->d_inode;
-	int isdir = d_is_dir(dentry);
 
 	spin_lock(&inode->i_lock);
 	spin_lock(&dentry->d_lock);
@@ -2386,7 +2385,6 @@ void d_delete(struct dentry * dentry)
 		spin_unlock(&dentry->d_lock);
 		spin_unlock(&inode->i_lock);
 	}
-	fsnotify_nameremove(dentry, isdir);
 }
 EXPORT_SYMBOL(d_delete);
 
diff --git a/fs/nfs/unlink.c b/fs/nfs/unlink.c
index 52d533967485..0effeee28352 100644
--- a/fs/nfs/unlink.c
+++ b/fs/nfs/unlink.c
@@ -396,12 +396,6 @@ nfs_complete_sillyrename(struct rpc_task *task, struct nfs_renamedata *data)
 		nfs_cancel_async_unlink(dentry);
 		return;
 	}
-
-	/*
-	 * vfs_unlink and the like do not issue this when a file is
-	 * sillyrenamed, so do it here.
-	 */
-	fsnotify_nameremove(dentry, 0);
 }
 
 #define SILLYNAME_PREFIX ".nfs"
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 7f23eddefcd0..0145073c2b42 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -199,6 +199,7 @@ static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
 	WARN_ON_ONCE(d_is_negative(dentry));
 
 	/* TODO: call fsnotify_dirent() */
+	fsnotify_nameremove(dentry, 0);
 }
 
 /*
@@ -222,6 +223,7 @@ static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
 	WARN_ON_ONCE(d_is_negative(dentry));
 
 	/* TODO: call fsnotify_dirent() */
+	fsnotify_nameremove(dentry, 1);
 }
 
 /*
-- 
2.17.1

