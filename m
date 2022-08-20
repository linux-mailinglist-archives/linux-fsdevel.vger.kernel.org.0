Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCEE59AF6A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 20:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbiHTSL1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 14:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiHTSL0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 14:11:26 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56723FA11;
        Sat, 20 Aug 2022 11:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iFejAed+UMnGncLV0egPSQoz7oFNyDnBGzFlyTFey3U=; b=EsGZJ6fFqH43WC0HIidZeFWCD7
        P1KD0a6wkuLtjzFQINdbVhgoaAOYEWlxiKBWUVgHw7mdQTiPT3z0hotx0gnt6PJfREjvSIpdxIgdt
        64gWSZR1VkcHmRLLwY0JHhprs84OV7i3aoG4SXvgU3WSPYzwcIM5ztdwv+ZlBSreqYeIBvoEsLr4n
        FDUDWUXxlsR0N76MgHOtyAoV7xVymhfWe4pEKdQFZ13BV4hIRd8LmNdM1Q/HJ7TzuCiAfVNWeVICQ
        XVuUm2RR5KEpksTPT8Els0OyX+47sUE/kg5ZT3xBNc/43tlm3JoRZyFkDIK1CO9kCZBgPETIVrwzH
        gGymeYpg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPSwN-006RTZ-22;
        Sat, 20 Aug 2022 18:11:23 +0000
Date:   Sat, 20 Aug 2022 19:11:23 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-security-module@vger.kernel.org
Subject: Subject: [PATCH 01/11] ->getprocattr(): attribute name is const char
 *, TYVM...
Message-ID: <YwEjy6vaFHEVPwlz@ZenIV>
References: <YwEjnoTgi7K6iijN@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwEjnoTgi7K6iijN@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

cast of ->d_name.name to char * is completely wrong - nothing is
allowed to modify its contents.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/proc/base.c                | 2 +-
 include/linux/lsm_hook_defs.h | 2 +-
 include/linux/security.h      | 4 ++--
 security/apparmor/lsm.c       | 2 +-
 security/security.c           | 4 ++--
 security/selinux/hooks.c      | 2 +-
 security/smack/smack_lsm.c    | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 93f7e3d971e4..e347b8ce140c 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2728,7 +2728,7 @@ static ssize_t proc_pid_attr_read(struct file * file, char __user * buf,
 		return -ESRCH;
 
 	length = security_getprocattr(task, PROC_I(inode)->op.lsm,
-				      (char*)file->f_path.dentry->d_name.name,
+				      file->f_path.dentry->d_name.name,
 				      &p);
 	put_task_struct(task);
 	if (length > 0)
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 806448173033..03360d27bedf 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -253,7 +253,7 @@ LSM_HOOK(int, 0, sem_semop, struct kern_ipc_perm *perm, struct sembuf *sops,
 LSM_HOOK(int, 0, netlink_send, struct sock *sk, struct sk_buff *skb)
 LSM_HOOK(void, LSM_RET_VOID, d_instantiate, struct dentry *dentry,
 	 struct inode *inode)
-LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, char *name,
+LSM_HOOK(int, -EINVAL, getprocattr, struct task_struct *p, const char *name,
 	 char **value)
 LSM_HOOK(int, -EINVAL, setprocattr, const char *name, void *value, size_t size)
 LSM_HOOK(int, 0, ismaclabel, const char *name)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1bc362cb413f..93488c01d9bd 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -461,7 +461,7 @@ int security_sem_semctl(struct kern_ipc_perm *sma, int cmd);
 int security_sem_semop(struct kern_ipc_perm *sma, struct sembuf *sops,
 			unsigned nsops, int alter);
 void security_d_instantiate(struct dentry *dentry, struct inode *inode);
-int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
+int security_getprocattr(struct task_struct *p, const char *lsm, const char *name,
 			 char **value);
 int security_setprocattr(const char *lsm, const char *name, void *value,
 			 size_t size);
@@ -1301,7 +1301,7 @@ static inline void security_d_instantiate(struct dentry *dentry,
 { }
 
 static inline int security_getprocattr(struct task_struct *p, const char *lsm,
-				       char *name, char **value)
+				       const char *name, char **value)
 {
 	return -EINVAL;
 }
diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
index e29cade7b662..f56070270c69 100644
--- a/security/apparmor/lsm.c
+++ b/security/apparmor/lsm.c
@@ -614,7 +614,7 @@ static int apparmor_sb_pivotroot(const struct path *old_path,
 	return error;
 }
 
-static int apparmor_getprocattr(struct task_struct *task, char *name,
+static int apparmor_getprocattr(struct task_struct *task, const char *name,
 				char **value)
 {
 	int error = -ENOENT;
diff --git a/security/security.c b/security/security.c
index 14d30fec8a00..d8227531e2fd 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2057,8 +2057,8 @@ void security_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(security_d_instantiate);
 
-int security_getprocattr(struct task_struct *p, const char *lsm, char *name,
-				char **value)
+int security_getprocattr(struct task_struct *p, const char *lsm,
+			 const char *name, char **value)
 {
 	struct security_hook_list *hp;
 
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 79573504783b..c8168d19fb96 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -6327,7 +6327,7 @@ static void selinux_d_instantiate(struct dentry *dentry, struct inode *inode)
 }
 
 static int selinux_getprocattr(struct task_struct *p,
-			       char *name, char **value)
+			       const char *name, char **value)
 {
 	const struct task_security_struct *__tsec;
 	u32 sid;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 001831458fa2..434b348d8fcd 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -3479,7 +3479,7 @@ static void smack_d_instantiate(struct dentry *opt_dentry, struct inode *inode)
  *
  * Returns the length of the smack label or an error code
  */
-static int smack_getprocattr(struct task_struct *p, char *name, char **value)
+static int smack_getprocattr(struct task_struct *p, const char *name, char **value)
 {
 	struct smack_known *skp = smk_of_task_struct_obj(p);
 	char *cp;
-- 
2.30.2

