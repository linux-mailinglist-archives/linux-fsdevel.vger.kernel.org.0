Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5191612EA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 14:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729086AbgBQNPN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 08:15:13 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43876 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729018AbgBQNPM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 08:15:12 -0500
Received: by mail-wr1-f68.google.com with SMTP id r11so19636622wrq.10
        for <linux-fsdevel@vger.kernel.org>; Mon, 17 Feb 2020 05:15:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fWbh+qHr8xslK5qL2cBUHYqV44AIJRERVFrOcrvwwPI=;
        b=FCG5s5F9VNPRGfWxxH7/WDdMikIjkauG8NPRDu6F5ZwagzXVVwOphnPmK/rCy5e1Dx
         41Tg3wq5kmJjnmt/s/a7dq1xpPaCuU52ShMo/rpM2i6bCRb7qJ7W5PqFbQyofWuUkX6q
         ZCRyCx/ZshlJsiLU1qJK7Yif9Qc/yQ6S1+D5ot3qkh3jnSw9rC/n4d3/R129EvLBqwNK
         vDOieMV3XYVOisdD2zlVvURdN0UCjLJWUJP12H2t8imKKDxjNsi6k6eFXUXV1fYDKH0A
         bsXmUMiPN5vj8eN5bA0vBCViSpP3QlloEUkFG44KJNCgn9YD+oQ7Ik+vqaXvUA9eYsKx
         /Q/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fWbh+qHr8xslK5qL2cBUHYqV44AIJRERVFrOcrvwwPI=;
        b=l7dm20T3TJihKYXzfkWdJ6OGThiBIt/h07sgAn3EWSLw+IpE2JMnM8gP15w10RPW/6
         /gkI5mhE0gundtjCwX7r/3QUMSl7vUCKsp5vBP0B+neSO/WODXNCkmmutIDqaxIl1DsL
         MSfOhSnNToBdpozBL1a3LsXgRzSxODhxGBI00Ev3OJ/oRWd4vlO6YjXR56WpenTo9SHh
         xHBoEfhQkddqkkk74hnMoUx4hbZCiOuO/6XqM3wJR344+L9br1MfimtW29gozMKceDWb
         PWwvqTkuZEKrF8K8z/pyoukoOanvqKr5Y7iIN7vojM3YWhSF9sc1B6EULy5N+bAJ+ZcL
         zPsw==
X-Gm-Message-State: APjAAAXBPeCbzeG9VuAyfvPTSjHU+sdbZlibrdA/YnwYDs/fykQLJUjA
        qG8+ZR+FW1G2Eoe8L4t8LAg=
X-Google-Smtp-Source: APXvYqwNDDn+xq0x/UYectA3U0tWKXWXvFPGRQ+IQ1LLFwENxiusf75Seurce42gyll8CjTXh2kbtQ==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr23556227wrv.198.1581945310754;
        Mon, 17 Feb 2020 05:15:10 -0800 (PST)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id m21sm545745wmi.27.2020.02.17.05.15.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 05:15:10 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 03/16] fsnotify: funnel all dirent events through fsnotify_name()
Date:   Mon, 17 Feb 2020 15:14:42 +0200
Message-Id: <20200217131455.31107-4-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200217131455.31107-1-amir73il@gmail.com>
References: <20200217131455.31107-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out fsnotify_name() from fsnotify_dirent(), so it can also serve
link and rename events and use this helper to report all directory entry
change events.

Both helpers return void because no caller checks their return value.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify.h | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index a87d4ab98da7..420aca9fd5f4 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -18,16 +18,24 @@
 #include <linux/bug.h>
 
 /*
- * Notify this @dir inode about a change in the directory entry @dentry.
+ * Notify this @dir inode about a change in a child directory entry.
+ * The directory entry may have turned positive or negative or its inode may
+ * have changed (i.e. renamed over).
  *
  * Unlike fsnotify_parent(), the event will be reported regardless of the
  * FS_EVENT_ON_CHILD mask on the parent inode.
  */
-static inline int fsnotify_dirent(struct inode *dir, struct dentry *dentry,
-				  __u32 mask)
+static inline void fsnotify_name(struct inode *dir, __u32 mask,
+				 struct inode *child,
+				 const struct qstr *name, u32 cookie)
 {
-	return fsnotify(dir, mask, d_inode(dentry), FSNOTIFY_EVENT_INODE,
-			&dentry->d_name, 0);
+	fsnotify(dir, mask, child, FSNOTIFY_EVENT_INODE, name, cookie);
+}
+
+static inline void fsnotify_dirent(struct inode *dir, struct dentry *dentry,
+				   __u32 mask)
+{
+	fsnotify_name(dir, mask, d_inode(dentry), &dentry->d_name, 0);
 }
 
 /* Notify this dentry's parent about a child's events. */
@@ -137,10 +145,8 @@ static inline void fsnotify_move(struct inode *old_dir, struct inode *new_dir,
 		mask |= FS_ISDIR;
 	}
 
-	fsnotify(old_dir, old_dir_mask, source, FSNOTIFY_EVENT_INODE, old_name,
-		 fs_cookie);
-	fsnotify(new_dir, new_dir_mask, source, FSNOTIFY_EVENT_INODE, new_name,
-		 fs_cookie);
+	fsnotify_name(old_dir, old_dir_mask, source, old_name, fs_cookie);
+	fsnotify_name(new_dir, new_dir_mask, source, new_name, fs_cookie);
 
 	if (target)
 		fsnotify_link_count(target);
@@ -195,12 +201,13 @@ static inline void fsnotify_create(struct inode *inode, struct dentry *dentry)
  * Note: We have to pass also the linked inode ptr as some filesystems leave
  *   new_dentry->d_inode NULL and instantiate inode pointer later
  */
-static inline void fsnotify_link(struct inode *dir, struct inode *inode, struct dentry *new_dentry)
+static inline void fsnotify_link(struct inode *dir, struct inode *inode,
+				 struct dentry *new_dentry)
 {
 	fsnotify_link_count(inode);
 	audit_inode_child(dir, new_dentry, AUDIT_TYPE_CHILD_CREATE);
 
-	fsnotify(dir, FS_CREATE, inode, FSNOTIFY_EVENT_INODE, &new_dentry->d_name, 0);
+	fsnotify_name(dir, FS_CREATE, inode, &new_dentry->d_name, 0);
 }
 
 /*
-- 
2.17.1

