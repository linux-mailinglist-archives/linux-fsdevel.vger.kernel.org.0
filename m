Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A61742AA40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 16:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbfEZOeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 10:34:24 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43270 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbfEZOeY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 10:34:24 -0400
Received: by mail-wr1-f68.google.com with SMTP id l17so5920517wrm.10
        for <linux-fsdevel@vger.kernel.org>; Sun, 26 May 2019 07:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qKycWqxky6nRaVgP5VI/y2klDKatvoMFA4PA72WdtA4=;
        b=QxaVeU28WNi1Xu8rA8BH7OnSg+3XS+LKuK41BrbkPI06dcDssuhy+J0t9ufMYKOj7x
         wWc5CBuWNo7MQ7yxRlw0YxEMR5IydmUwJ/027Ef0e9cZxRLyMmLyXGWH+BP05DI6MT8g
         knxtLZjm2xjk2uD8x4wifiU1GXynNRkZp0H/YO2uBiVGAr03w5cagjzrcWDP7t9Q09oP
         GAYk33p8o3h8LIfcS+qqSny0Bp0YUSsi19Hd9ESWPTZNFSZxdtwCn1sbyJIolVhzlOQw
         6FgRNT+7/GVuQxnQ4EcfiV/+5Kfjxc8wSLpe+nLFvbxqc4brmU64NNLWCj1xeqQf7ffg
         xmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qKycWqxky6nRaVgP5VI/y2klDKatvoMFA4PA72WdtA4=;
        b=kkAWbEKvGU7cFDzVDS8YfpFPBGpMF82zSYJnRSwHfxV20y6ke8Q5qi0mbsFzmpFC6r
         HCIBWS+ishdzvIA/mzJsI49tgQIzsEWD/6TLm8I3JU9azCW7x9B5eoaM0IE/11oRW4kG
         iU5DqmM/kXT66DPHMWzcgb6oEctP+Ottwx0r1HNcBxywY/z7lWIlxQZ0H/Ey0AsiYMhe
         a4d1MUpKU/DtbQQ2Y8f49wPmKlrvfBvmPHw34uDNooafjh5zax49HmuDP0TEgdYZWvRM
         jhdu7f2wZCWWcEw3g3/XiMwZ2s7Hrvb1PFnzGPiOUbbYELOT9PDYG/+trppQgixns+Gc
         Kckw==
X-Gm-Message-State: APjAAAVfqLv5DiltB0H1W18rWkA5duEj8FCdqzrI4ZeDZWQZaVhiiUWt
        IyCLZIEady2YBWOe5wYKtXg=
X-Google-Smtp-Source: APXvYqxbwbbovNrPehyGg4Xu8PIBZ+SKIYksnTCiYZZLsTw+gLwG8nKJxZBA5TE1GFI4C+icQHHP+g==
X-Received: by 2002:adf:dc09:: with SMTP id t9mr42963109wri.69.1558881262956;
        Sun, 26 May 2019 07:34:22 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id t13sm21144146wra.81.2019.05.26.07.34.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 May 2019 07:34:22 -0700 (PDT)
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
Subject: [PATCH v3 01/10] fsnotify: add empty fsnotify_{unlink,rmdir}() hooks
Date:   Sun, 26 May 2019 17:34:02 +0300
Message-Id: <20190526143411.11244-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526143411.11244-1-amir73il@gmail.com>
References: <20190526143411.11244-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We would like to move fsnotify_nameremove() calls from d_delete()
into a higher layer where the hook makes more sense and so we can
consider every d_delete() call site individually.

Start by creating empty hook fsnotify_{unlink,rmdir}() and place
them in the proper VFS call sites.  After all d_delete() call sites
will be converted to use the new hook, the new hook will generate the
delete events and fsnotify_nameremove() hook will be removed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/namei.c               |  2 ++
 include/linux/fsnotify.h | 26 ++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index 20831c2fbb34..209c51a5226c 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3883,6 +3883,7 @@ int vfs_rmdir(struct inode *dir, struct dentry *dentry)
 	dentry->d_inode->i_flags |= S_DEAD;
 	dont_mount(dentry);
 	detach_mounts(dentry);
+	fsnotify_rmdir(dir, dentry);
 
 out:
 	inode_unlock(dentry->d_inode);
@@ -3999,6 +4000,7 @@ int vfs_unlink(struct inode *dir, struct dentry *dentry, struct inode **delegate
 			if (!error) {
 				dont_mount(dentry);
 				detach_mounts(dentry);
+				fsnotify_unlink(dir, dentry);
 			}
 		}
 	}
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 94972e8eb6d1..7f23eddefcd0 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -188,6 +188,19 @@ static inline void fsnotify_link(struct inode *dir, struct inode *inode, struct
 	fsnotify(dir, FS_CREATE, inode, FSNOTIFY_EVENT_INODE, &new_dentry->d_name, 0);
 }
 
+/*
+ * fsnotify_unlink - 'name' was unlinked
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ */
+static inline void fsnotify_unlink(struct inode *dir, struct dentry *dentry)
+{
+	/* Expected to be called before d_delete() */
+	WARN_ON_ONCE(d_is_negative(dentry));
+
+	/* TODO: call fsnotify_dirent() */
+}
+
 /*
  * fsnotify_mkdir - directory 'name' was created
  */
@@ -198,6 +211,19 @@ static inline void fsnotify_mkdir(struct inode *inode, struct dentry *dentry)
 	fsnotify_dirent(inode, dentry, FS_CREATE | FS_ISDIR);
 }
 
+/*
+ * fsnotify_rmdir - directory 'name' was removed
+ *
+ * Caller must make sure that dentry->d_name is stable.
+ */
+static inline void fsnotify_rmdir(struct inode *dir, struct dentry *dentry)
+{
+	/* Expected to be called before d_delete() */
+	WARN_ON_ONCE(d_is_negative(dentry));
+
+	/* TODO: call fsnotify_dirent() */
+}
+
 /*
  * fsnotify_access - file was read
  */
-- 
2.17.1

