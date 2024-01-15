Return-Path: <linux-fsdevel+bounces-7972-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5D882DF80
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 19:24:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 674FF1F23985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 18:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13E21865A;
	Mon, 15 Jan 2024 18:23:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7C918628;
	Mon, 15 Jan 2024 18:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4TDKrj3F23z9xGhW;
	Tue, 16 Jan 2024 02:08:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 04FFE140489;
	Tue, 16 Jan 2024 02:23:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDn0ia8d6VlgjybAA--.56873S7;
	Mon, 15 Jan 2024 19:23:08 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	chuck.lever@oracle.com,
	jlayton@kernel.org,
	neilb@suse.de,
	kolga@netapp.com,
	Dai.Ngo@oracle.com,
	tom@talpey.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	dhowells@redhat.com,
	jarkko@kernel.org,
	stephen.smalley.work@gmail.com,
	eparis@parisplace.org,
	casey@schaufler-ca.com,
	shuah@kernel.org,
	mic@digikod.net
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [PATCH v9 15/25] security: Introduce inode_post_create_tmpfile hook
Date: Mon, 15 Jan 2024 19:17:59 +0100
Message-Id: <20240115181809.885385-16-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
References: <20240115181809.885385-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwDn0ia8d6VlgjybAA--.56873S7
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUZF4kuw4UJr4rWr18uFg_yoWrGw48pF
	WxK3W3Gws5XFy7WryvyF47uw1Sgay5WrWUJrZagwn0yFn7tr1ftF4Skr12kF13JrW8Gw1I
	q3ZFkrZxGr17trJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I
	80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCj
	c4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28Icx
	kI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2Iq
	xVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42
	IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxUFMKZDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgADBF1jj5SShQACs1

From: Roberto Sassu <roberto.sassu@huawei.com>

In preparation for moving IMA and EVM to the LSM infrastructure, introduce
the inode_post_create_tmpfile hook.

As temp files can be made persistent, treat new temp files like other new
files, so that the file hash is calculated and stored in the security
xattr.

LSMs could also take some action after temp files have been created.

The new hook cannot return an error and cannot cause the operation to be
canceled.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
Acked-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 fs/namei.c                    |  1 +
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  6 ++++++
 security/security.c           | 15 +++++++++++++++
 4 files changed, 24 insertions(+)

diff --git a/fs/namei.c b/fs/namei.c
index b7f433720b1e..adb3ab27951a 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3686,6 +3686,7 @@ static int vfs_tmpfile(struct mnt_idmap *idmap,
 		inode->i_state |= I_LINKABLE;
 		spin_unlock(&inode->i_lock);
 	}
+	security_inode_post_create_tmpfile(idmap, inode);
 	ima_post_create_tmpfile(idmap, inode);
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index e08b9091350d..5f90914d23e0 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -121,6 +121,8 @@ LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
 	 umode_t mode)
+LSM_HOOK(void, LSM_RET_VOID, inode_post_create_tmpfile, struct mnt_idmap *idmap,
+	 struct inode *inode)
 LSM_HOOK(int, 0, inode_link, struct dentry *old_dentry, struct inode *dir,
 	 struct dentry *new_dentry)
 LSM_HOOK(int, 0, inode_unlink, struct inode *dir, struct dentry *dentry)
diff --git a/include/linux/security.h b/include/linux/security.h
index 977dd9f7f51a..1cb604282617 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -344,6 +344,8 @@ int security_inode_init_security_anon(struct inode *inode,
 				      const struct qstr *name,
 				      const struct inode *context_inode);
 int security_inode_create(struct inode *dir, struct dentry *dentry, umode_t mode);
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *inode);
 int security_inode_link(struct dentry *old_dentry, struct inode *dir,
 			 struct dentry *new_dentry);
 int security_inode_unlink(struct inode *dir, struct dentry *dentry);
@@ -811,6 +813,10 @@ static inline int security_inode_create(struct inode *dir,
 	return 0;
 }
 
+static inline void
+security_inode_post_create_tmpfile(struct mnt_idmap *idmap, struct inode *inode)
+{ }
+
 static inline int security_inode_link(struct dentry *old_dentry,
 				       struct inode *dir,
 				       struct dentry *new_dentry)
diff --git a/security/security.c b/security/security.c
index 750bfe2768d5..5bc7edc22923 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2013,6 +2013,21 @@ int security_inode_create(struct inode *dir, struct dentry *dentry,
 }
 EXPORT_SYMBOL_GPL(security_inode_create);
 
+/**
+ * security_inode_post_create_tmpfile() - Update inode security of new tmpfile
+ * @idmap: idmap of the mount
+ * @inode: inode of the new tmpfile
+ *
+ * Update inode security data after a tmpfile has been created.
+ */
+void security_inode_post_create_tmpfile(struct mnt_idmap *idmap,
+					struct inode *inode)
+{
+	if (unlikely(IS_PRIVATE(inode)))
+		return;
+	call_void_hook(inode_post_create_tmpfile, idmap, inode);
+}
+
 /**
  * security_inode_link() - Check if creating a hard link is allowed
  * @old_dentry: existing file
-- 
2.34.1


