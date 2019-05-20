Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 21B9322C07
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 08:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730618AbfETG0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 02:26:04 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34645 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbfETG0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 02:26:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id c13so6274526pgt.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 19 May 2019 23:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eFV+c2kPhme0O4UWnGAxG0d2Em20Ogy0oyDm+9NMWYM=;
        b=V/cetqBv2cbwA/IQ/Hl3GeUangriBuugG2ChBzGCi04fc0wbHl17DEl0HVTQ0yZLms
         DE5AycwkDB/zwUz/ufWCsX+6glJPNjlOLXDtn7PPp2jMlCDJGo6ZHI58g8qkMhwpIr/O
         3KtmOMCh6vBTyc+skXVmHp4Cbb9sTuHWXkTRw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eFV+c2kPhme0O4UWnGAxG0d2Em20Ogy0oyDm+9NMWYM=;
        b=Lsr66WQJVkrsHRZAYvZ7FI5GlRtgBLKnaw906vgC9mWPQCgNd2OQlHCsgonnSk72r0
         e1GZq1rLmqqv7sFqlMNNmc/WazTSypk1q+wbnNubyXZYBZdg5V26bswq/3Q8r2FgPIm5
         MYM+YXjDoPJLCPvkyPyPs2Xh2fM6C2uRbASInC2Vi+ebuyzEqmV7CP4Vq35bfNLhmPwl
         9bYURKQO0IVkjaKTE610eg/l3fGH/yDZ8h0rMUwma9idkO6WQw5Xh5OxUOkQYUCO8O+B
         M2TkDdZmkCU2EOuhCTQiA5MNB0I0S9+vfI1b+Oo/ipoPivWeB/UFwN3uVv/beSSwFu5G
         jZ+g==
X-Gm-Message-State: APjAAAUr+QJ0lDx/UpA5RSa2beN+ZI1LIZpGEBavJE8HZv7bTWmMnRBH
        yHNSBr1427haobSNZLyAtAx0Rw==
X-Google-Smtp-Source: APXvYqzjSV7A4VhHh7mtHJcB29+nRR5bsNaM5xmTZmgcwyrDwZlSwJnS/F6tjmzkPfHU6lxaKLTCcQ==
X-Received: by 2002:a65:6088:: with SMTP id t8mr25524536pgu.381.1558333563607;
        Sun, 19 May 2019 23:26:03 -0700 (PDT)
Received: from localhost (ppp167-251-205.static.internode.on.net. [59.167.251.205])
        by smtp.gmail.com with ESMTPSA id f28sm34790641pfk.104.2019.05.19.23.26.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 19 May 2019 23:26:03 -0700 (PDT)
From:   Daniel Axtens <dja@axtens.net>
To:     nayna@linux.ibm.com, cclaudio@linux.ibm.com,
        linux-fsdevel@vger.kernel.org, greg@kroah.com,
        linuxppc-dev@lists.ozlabs.org
Cc:     Daniel Axtens <dja@axtens.net>
Subject: [WIP RFC PATCH 1/6] kernfs: add create() and unlink() hooks
Date:   Mon, 20 May 2019 16:25:48 +1000
Message-Id: <20190520062553.14947-2-dja@axtens.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190520062553.14947-1-dja@axtens.net>
References: <20190520062553.14947-1-dja@axtens.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I'm building a generic firmware variable filesystem on top of kernfs
and I'd like to be able to create and unlink files.

The hooks are fairly straightforward. create() returns a kernfs_node*,
which is safe with regards to cleanup on error paths, because there
is no way that things can fail after that point in the current
implementation. However, currently O_EXCL is not implemented and
that may create failure paths, in which case we may need to revisit
this later.

Signed-off-by: Daniel Axtens <dja@axtens.net>
---
 fs/kernfs/dir.c        | 55 ++++++++++++++++++++++++++++++++++++++++++
 include/linux/kernfs.h |  3 +++
 2 files changed, 58 insertions(+)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index 016ba88f7335..74fe51dbd027 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -1175,6 +1175,59 @@ static int kernfs_iop_rename(struct inode *old_dir, struct dentry *old_dentry,
 	return ret;
 }
 
+static int kernfs_iop_create(struct inode *dir, struct dentry *dentry,
+			     umode_t mode, bool excl)
+{
+	struct kernfs_node *parent = dir->i_private;
+	struct kernfs_node *kn;
+	struct kernfs_syscall_ops *scops = kernfs_root(parent)->syscall_ops;
+
+	if (!scops || !scops->create)
+		return -EPERM;
+
+	if (!kernfs_get_active(parent))
+		return -ENODEV;
+
+	// TODO: add some locking to ensure that scops->create
+	// is called only once, and possibly to handle the O_EXCL case
+	WARN_ONCE(excl, "excl unimplemented");
+
+	kn = scops->create(parent, dentry->d_name.name, mode);
+
+	if (!kn)
+		return -EPERM;
+
+	if (IS_ERR(kn))
+		return PTR_ERR(kn);
+
+	d_instantiate(dentry, kernfs_get_inode(dir->i_sb, kn));
+
+	return 0;
+}
+
+static int kernfs_iop_unlink(struct inode *dir, struct dentry *dentry)
+{
+	struct kernfs_node *parent = dir->i_private;
+	struct kernfs_node *kn = d_inode(dentry)->i_private;
+	struct kernfs_syscall_ops *scops = kernfs_root(parent)->syscall_ops;
+	int ret;
+
+
+	if (!scops || !scops->unlink)
+		return -EPERM;
+
+	if (!kernfs_get_active(parent))
+		return -ENODEV;
+
+	ret = scops->unlink(kn);
+	if (ret)
+		return ret;
+
+	drop_nlink(d_inode(dentry));
+	dput(dentry);
+	return 0;
+};
+
 const struct inode_operations kernfs_dir_iops = {
 	.lookup		= kernfs_iop_lookup,
 	.permission	= kernfs_iop_permission,
@@ -1185,6 +1238,8 @@ const struct inode_operations kernfs_dir_iops = {
 	.mkdir		= kernfs_iop_mkdir,
 	.rmdir		= kernfs_iop_rmdir,
 	.rename		= kernfs_iop_rename,
+	.create		= kernfs_iop_create,
+	.unlink		= kernfs_iop_unlink,
 };
 
 static struct kernfs_node *kernfs_leftmost_descendant(struct kernfs_node *pos)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 2bf477f86eb1..282b96acbd7e 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -179,6 +179,9 @@ struct kernfs_syscall_ops {
 		      const char *new_name);
 	int (*show_path)(struct seq_file *sf, struct kernfs_node *kn,
 			 struct kernfs_root *root);
+	struct kernfs_node* (*create)(struct kernfs_node *parent,
+				      const char *name, umode_t mode);
+	int (*unlink)(struct kernfs_node *kn);
 };
 
 struct kernfs_root {
-- 
2.19.1

