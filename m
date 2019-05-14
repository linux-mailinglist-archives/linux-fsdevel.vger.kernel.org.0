Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD28F1E4FD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 00:20:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbfENWTO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 18:19:14 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33591 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfENWTO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 18:19:14 -0400
Received: by mail-wm1-f67.google.com with SMTP id c66so3326208wme.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 May 2019 15:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jaoFftjx979q4SA6WjdVQTlTu4R2U03eLosOErcQnkY=;
        b=pvaM3KH5sH57Vh8gtpJz07FGxUSVZBzVB0mPfbtzQw8gwWYxJvZNC8QI17OrNocx7N
         I8jF9UEtzHpYAfW7oFatRcaKes3T0ysU+3wFsw2IjQeUQdw757cCuhznGdNyjmEbja9Y
         oppbpbraaATF/ZKfxKMV6w97SdMMpNlNSyIr5Z4VgEhE8wr5ecJjuIdLBlDR7fV+zhCL
         yRzfcNHBi7ahE9UbzF20UqcEA9eqBSBCG3TdTfyNpS5eFi+NbWZcUhsDPbUVBWsUkO5v
         ZSQnZH+xUEyfvCk5leRdhsWMysBqxXiUfnA2Ctt0WF3MEPuZB72BdQ/RJoIBs5EYgi8a
         VFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jaoFftjx979q4SA6WjdVQTlTu4R2U03eLosOErcQnkY=;
        b=fcOca8DVytXjtUqphZMHOkZOPV/k2x9SVntqJycklLnfB8TTCdG5KLzcjgFuQWMLYl
         N6z3Eg9FTJS50J1Nz2xqvWn2Vds32r71MIwO+AqlDJnUIIottJEn132+zRY+q5aWZBdc
         LVld7QTtqiFVFX6moCZTu9Wx01Xf8DhmMORctesLv0py82FRoDOD61nPXGBRqnB1Rmtc
         GExjpuxLsTN+lsYFptNhcrxur+lsi2lprRO9BY6tCs1krUgA1jMutoXU9ZVaWvAXOGiU
         Z7QmLrU6ARQR7WUiYTxNDQcDow+P3LkMs1hVL4fOeilwrSjodBWialO8LbBkO6IgXgk+
         tyxA==
X-Gm-Message-State: APjAAAUMM9MdvWsBUn4T3ZVc6rAhQTEAbcMA5a/c+PyxUq0zq1CVKxE4
        9sTIvmVbipcuBkw7o/73PEkTe0CV
X-Google-Smtp-Source: APXvYqzf+VcIAaEDWMs5yCVwq1I2Dz8upG7VrHhKo9dDXQU6B+xozpW31wOH2R6fbciBd8TskuYoEg==
X-Received: by 2002:a1c:f70c:: with SMTP id v12mr20266070wmh.86.1557872351939;
        Tue, 14 May 2019 15:19:11 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id h188sm423553wmf.48.2019.05.14.15.19.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 15:19:11 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Subject: [RFC][PATCH 1/4] fs: create simple_remove() helper
Date:   Wed, 15 May 2019 01:18:58 +0300
Message-Id: <20190514221901.29125-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190514221901.29125-1-amir73il@gmail.com>
References: <20190514221901.29125-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is a common pattern among pseudo filesystems for removing a dentry
from code paths that are NOT coming from vfs_{unlink,rmdir}, using a
combination of simple_{unlink,rmdir} and d_delete().

Create an helper to perform this common operation.  This helper is going
to be used as a place holder for the new fsnotify_remove() hook.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/libfs.c         | 22 ++++++++++++++++++++++
 include/linux/fs.h |  1 +
 2 files changed, 23 insertions(+)

diff --git a/fs/libfs.c b/fs/libfs.c
index 4b59b1816efb..030e67c52b5f 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -353,6 +353,28 @@ int simple_rmdir(struct inode *dir, struct dentry *dentry)
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

