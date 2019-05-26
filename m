Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF812AA49
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbfEZOek (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:40 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44067 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfEZOej (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:39 -0400
Received: by mail-wr1-f65.google.com with SMTP id w13so5958015wru.11
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=b1da2t/IpjGTzefdBJqgGc94GYoq3b1nFZIF4BYVMvY=;
        b=cfaxlcU2uXBlk3MhRdoSbYL9z46jykz4e8Oi2P3HSrjLy5lM4Zi3YX0peKfNWiFjVy
         iw0WYirjVvoNjlqdbWr8q1tr5l6DQtaPK9DHlNpMSbCN5sAAIzA3un8/J35f97VZ7Jae
         v4Xq7yZVRvhTPL9U+QkO1Ac3/kAllHGSDczBVQqxh2Gj3+It4mYJFvDTjUYbKt4289pK
         79hf/z/XgHmvwpL/TcJ9AI2SiTYwvp9NRFarzf3r1K7oCXnnP3RQVEXaEb72JctvZ8gk
         JxVPh4Fc6DSVIklA6Dxe4htJdotIGgD4GHDkqbSRxPVH9j2ES3IjKpcsDbclhHup/xOj
         7z1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=b1da2t/IpjGTzefdBJqgGc94GYoq3b1nFZIF4BYVMvY=;
        b=W79eHjirudRO7WnZde7sHMXlk5avAIOkpkDNVWHrvRJkBDxyneqK0sm17V80OjlIs5
         s5VsEzxBW3oWF3wEk14r5ggfRbI+d6Sl5/ehjjnffU0N7RvEDGe4dDZQeXF0tDq/Jh8L
         Qjnr5FkHgFy46+CH+NQ74DTGQkdFNERLvZXPLCyKoH7X5QHgoDc9q9ErNcSnbYvVvCQT
         OAnxoPjrzS9ciJl9R/zUCcNKRN+mPFfr9vrD1F86ehYIgRG141BJEUUB90Bm6SCnWPEE
         U+d5b3+MWiV4TlHCGqYCpKNPoOo745YFbvqDb8dJ+5qYyhjmw2BNjmwlUrgOPupHbvWJ
         DSuQ==
X-Gm-Message-State: APjAAAVHrZmCnkmiFsQUkOaPNgt5v+qedt3m30uyaEsT74oONANY4ywe
        QqEQOn/UEpvKnQV2NzUVaHA=
X-Google-Smtp-Source: APXvYqzNhBrEL75rizD6eavPzBWXcV5VKLOMf9Pf87WYsQ8HuOrGJeRpygVKmVqvBxXqwnNCbTJbBA==
X-Received: by 2002:adf:efcd:: with SMTP id i13mr42973406wrp.51.1558881277796;
        Sun, 26 May 2019 07:34:37 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:37 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Christoph Hellwig <hch@lst.de>,
        Joel Becker <jlbec@evilplan.org>,
        John Johansen <john.johansen@canonical.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 09/10] fsnotify: move fsnotify_nameremove() hook out of d_delete()
Date:   Sun, 26 May 2019 17:34:10 +0300
Message-Id: <20190526143411.11244-10-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
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
index 28f4aa015229..312687223170 100644
--- a/fs/afs/dir_silly.c
+++ b/fs/afs/dir_silly.c
@@ -64,11 +64,6 @@ static int afs_do_silly_rename(struct afs_vnode *dvnode, struct afs_vnode *vnode
 		if (test_bit(AFS_VNODE_DIR_VALID, &dvnode->flags))
 			afs_edit_dir_add(dvnode, &new->d_name,
 					 &vnode->fid, afs_edit_dir_for_silly_1);
-
-		/* vfs_unlink and the like do not issue this when a file is
-		 * sillyrenamed, so do it here.
-		 */
-		fsnotify_nameremove(old, 0);
 	}
 
 	kfree(scb);
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

