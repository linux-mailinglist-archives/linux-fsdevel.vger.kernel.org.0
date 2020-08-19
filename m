Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3246C24A758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 21:59:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgHST7r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 15:59:47 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39368 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726617AbgHST7p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:59:45 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id EC71B20B490F;
        Wed, 19 Aug 2020 12:59:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EC71B20B490F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597867184;
        bh=+Uor5TCih5xbkTzQ5C+cN2bTnoW0jIbhi0w0m5fkTcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=poloawzJDUn30qejyZPPxgdtXa4mC9nCCgVZPIYHc18mIhTwpWV+LZJUrXNpyVbpI
         RcucrH4t5XXwTvD8Qj89+R40+e6sllDPwfVPuhPASN2yicIzU2OXm7i26uEOwIuB2a
         iNs1wdVMMi1RmCzCkkWE8Nz4EBTzU0cNvLQF+MXY=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v3 3/4] selinux: Standardize string literal usage for selinuxfs directory names
Date:   Wed, 19 Aug 2020 15:59:34 -0400
Message-Id: <20200819195935.1720168-4-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
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
index cac585ce576b..2a0e8b5f19d5 100644
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
@@ -1361,8 +1365,6 @@ static void sel_remove_entries(struct dentry *de)
 	shrink_dcache_parent(de);
 }
 
-#define BOOL_DIR_NAME "booleans"
-
 static int sel_make_bools(struct selinux_policy *newpolicy, struct dentry *bool_dir,
 			  unsigned int *bool_num, char ***bool_pending_names,
 			  unsigned int **bool_pending_values)
@@ -2078,14 +2080,14 @@ static int sel_fill_super(struct super_block *sb, struct fs_context *fc)
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

