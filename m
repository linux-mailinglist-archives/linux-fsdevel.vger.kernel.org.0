Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9098242EFC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHLTPg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:15:36 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49318 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726641AbgHLTPf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:15:35 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id 66F1C20B490F;
        Wed, 12 Aug 2020 12:15:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 66F1C20B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597259735;
        bh=TWaa5J7FL27uITC423BFjVEEdl8/5m1i6QAGc4Mk748=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hOva4hYJRXvonlUrfkYrNKYzSAFdxngxjLgWb9GRx9nlZRkNv2x77vkzJJXv9fRac
         sC/4Clc6TfsYiV19d43DzkUgij6dJmT5t3wfhOioXm1nAeSXmMqQDueWm8kIMaAGsT
         V8HGo5ggoNYz7TWKjVWH6OAsDXz7yYhMD8FzT/0o=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 3/4] selinux: Standardize string literal usage for selinuxfs directory names
Date:   Wed, 12 Aug 2020 15:15:24 -0400
Message-Id: <20200812191525.1120850-4-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Switch class and policy_capabilities directory names to be referred to with
global constants, consistent with booleans directory name.  This will allow
for easy consistency of naming in future development.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 9657c3acfc8f..f09afdb90ddd 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -117,6 +117,10 @@ static void selinux_fs_info_free(struct super_block *sb)
 #define SEL_POLICYCAP_INO_OFFSET	0x08000000
 #define SEL_INO_MASK			0x00ffffff
 
+#define BOOL_DIR_NAME "booleans"
+#define CLASS_DIR_NAME "class"
+#define POLICYCAP_DIR_NAME "policy_capabilities"
+
 #define TMPBUFLEN	12
 static ssize_t sel_read_enforce(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
@@ -1363,8 +1367,6 @@ static void sel_remove_entries(struct dentry *de)
 	shrink_dcache_parent(de);
 }
 
-#define BOOL_DIR_NAME "booleans"
-
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
 			  unsigned int **bool_pending_values)
@@ -2080,14 +2082,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ret)
 		goto err;
 
-	fsi->class_dir = sel_make_dir(sb->s_root, "class", &fsi->last_ino);
+	fsi->class_dir = sel_make_dir(sb->s_root, CLASS_DIR_NAME, &fsi->last_ino);
 	if (IS_ERR(fsi->class_dir)) {
 		ret = PTR_ERR(fsi->class_dir);
 		fsi->class_dir = NULL;
 		goto err;
 	}
 
-	fsi->policycap_dir = sel_make_dir(sb->s_root, "policy_capabilities",
+	fsi->policycap_dir = sel_make_dir(sb->s_root, POLICYCAP_DIR_NAME,
 					  &fsi->last_ino);
 	if (IS_ERR(fsi->policycap_dir)) {
 		ret = PTR_ERR(fsi->policycap_dir);
-- 
2.25.4

