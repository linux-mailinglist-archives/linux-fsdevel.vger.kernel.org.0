Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04BC82035B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfEPK05 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:26:57 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33025 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPK05 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:26:57 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so6699958wme.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 May 2019 03:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IxwvaE0YmGct/RzoWtDeDc7kHgzj0Gomy2LP+TO3SVY=;
        b=K66JSEner4SPN49fhAhSA0F92yi6umMSYYuOv/1vpUuA0N8kr4hieGSIwQKQhGdj2U
         eNAUBdaUb1Xx5VH/IjYxtTwIp3zuU1Y9m/gRMQoDeF6igUX9wyInY63hiw2cu5XuMVGz
         /zrfgFjJxcE4mNc7CeauAEroFULEhl8E4e/HibDRnG6stF6FbTrLpeCGQmU8FObjgf2+
         F774+qKL77hE6klmQaTuXRUSdcbV1yaL0uF391CLOyc2GGg4AiTnob81ZyMkXFtmQAQk
         HS26UdJcsyzteEwpkp2xxjv3SSXFz1VJl6plCVq92A45JMKEEtGppUHlRY46kxMP+Vwd
         IGcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IxwvaE0YmGct/RzoWtDeDc7kHgzj0Gomy2LP+TO3SVY=;
        b=i7g+j7MKXDb/3mEHvor7T4bKEJml8M5TOyozzb4xTajWvlP0WfVkYRtzU380q7mv7B
         swR34siMMkxO1hJmhRNpbGZEPIuodXbFAg4bgkGUkmXpYhQfXJ3YyLlwFW9RgcmXObHb
         WBQfZFdeQjYMyLvijNp0xdmP8aRh3svf7HU+7LR134GSX98qwPJiCX/S4lsIW5fN9fIy
         kw9KojYKBYUoapQT5JHwL9g+J1QB4JU1vN/CGBsnKjZbdFD44Zt3cCuGPfHEX0M7ys8m
         A1M1TZpSNLAKVj7469wLQdWZj9fzwlCwvGwaOcIV50t2ymwrlHXctPbsnEDiYx75aidz
         xdfw==
X-Gm-Message-State: APjAAAVjL54zxs8CsPawemkQyBL/oKKuls+qFMjwqi0o1tpA6BQ0KJhx
        slOkqS4SjeD28nz2fqP1sGmUcw4N
X-Google-Smtp-Source: APXvYqxWbUtCflk2jf3nwrk81TtZbGXVJHCc0gKdgTRxL5gOZTPRdT9C+8QaZIXoe1RvkvSmdGNmGg==
X-Received: by 2002:a7b:c7d6:: with SMTP id z22mr4531934wmk.54.1558002416041;
        Thu, 16 May 2019 03:26:56 -0700 (PDT)
Received: from amir-ThinkPad-T480.ctera.local (bzq-166-168-31-246.red.bezeqint.net. [31.168.166.246])
        by smtp.gmail.com with ESMTPSA id d72sm4506299wmd.12.2019.05.16.03.26.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 03:26:55 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 02/14] fs: create simple_remove() helper
Date:   Thu, 16 May 2019 13:26:29 +0300
Message-Id: <20190516102641.6574-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516102641.6574-1-amir73il@gmail.com>
References: <20190516102641.6574-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a common pattern among pseudo filesystems for removing a dentry
from code paths that are NOT coming from vfs_{unlink,rmdir}, using a
combination of simple_{unlink,rmdir} and d_delete().

Create an helper to perform this common operation.  This helper is going
to be used as a place holder for the new fsnotify_{unlink,rmdir} hooks.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/libfs.c         | 27 +++++++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 28 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4b59b1816efb..ca1132f1d5c6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -353,6 +353,33 @@ int simple_rmdir(struct inode *dir, struct dentry *dentry)
 }
 EXPORT_SYMBOL(simple_rmdir);
 
+/*
+ * Unlike simple_unlink/rmdir, this helper is NOT called from vfs_unlink/rmdir.
+ * Caller must guaranty that d_parent and d_name are stable.
+ */
+int simple_remove(struct inode *dir, struct dentry *dentry)
+{
+	int ret;
+
+	/*
+	 * 'simple_' operations get a dentry reference on create/mkdir and drop
+	 * it on unlink/rmdir. So we have to get dentry reference here to
+	 * protect d_delete() from accessing a freed dentry.
+	 */
+	dget(dentry);
+	if (d_is_dir(dentry))
+		ret = simple_rmdir(dir, dentry);
+	else
+		ret = simple_unlink(dir, dentry);
+
+	if (!ret)
+		d_delete(dentry);
+	dput(dentry);
+
+	return ret;
+}
+EXPORT_SYMBOL(simple_remove);
+
 int simple_rename(struct inode *old_dir, struct dentry *old_dentry,
 		  struct inode *new_dir, struct dentry *new_dentry,
 		  unsigned int flags)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..74ea5f0b3b9d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3245,6 +3245,7 @@ extern int simple_open(struct inode *inode, struct file *file);
 extern int simple_link(struct dentry *, struct inode *, struct dentry *);
 extern int simple_unlink(struct inode *, struct dentry *);
 extern int simple_rmdir(struct inode *, struct dentry *);
+extern int simple_remove(struct inode *, struct dentry *);
 extern int simple_rename(struct inode *, struct dentry *,
 			 struct inode *, struct dentry *, unsigned int);
 extern int noop_fsync(struct file *, loff_t, loff_t, int);
-- 
2.17.1

