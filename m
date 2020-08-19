Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD9224A752
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Aug 2020 21:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726862AbgHST7o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Aug 2020 15:59:44 -0400
Received: from linux.microsoft.com ([13.77.154.182]:39336 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHST7n (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Aug 2020 15:59:43 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id E09A320B490A;
        Wed, 19 Aug 2020 12:59:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E09A320B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597867182;
        bh=JLjW6kqfNC4bfwuCqsUVtHYApk01Zz9a6JXX3jmYcTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olNQ889oPc+v1FSPKXs9A83XFwdlaPJfYI2+rt+cQSeYYzciu59/m/K/6Q+xl57GS
         pHVazd1arwqgOEa3X/sxoezAnZX220R42ai2mtjtmaDXAEyXGUlkEN676v8iy4zYsN
         IputGk9lLpFP9GxbWe3aA4cIHIx96DtDO4oErN70=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v3 1/4] selinux: Create function for selinuxfs directory cleanup
Date:   Wed, 19 Aug 2020 15:59:32 -0400
Message-Id: <20200819195935.1720168-2-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
References: <20200819195935.1720168-1-dburgener@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Separating the cleanup from the creation will simplify two things in
future patches in this series.  First, the creation can be made generic,
to create directories not tied to the selinux_fs_info structure.  Second,
we will ultimately want to reorder creation and deletion so that the
deletions aren't performed until the new directory structures have already
been moved into place.

Signed-off-by: Daniel Burgener <dburgener@linux.microsoft.com>
---
 security/selinux/selinuxfs.c | 39 +++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 131816878e50..19670e9bcd72 100644
--- a/security/selinux/selinuxfs.c
+++ b/security/selinux/selinuxfs.c
@@ -355,6 +355,9 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
 static struct dentry *sel_make_dir(struct dentry *dir, const char *name,
 			unsigned long *ino);
 
+/* declaration for sel_remove_old_policy_nodes */
+static void sel_remove_entries(struct dentry *de);
+
 static ssize_t sel_read_mls(struct file *filp, char __user *buf,
 				size_t count, loff_t *ppos)
 {
@@ -509,11 +512,33 @@ static const struct file_operations sel_policy_ops = {
 	.llseek		= generic_file_llseek,
 };
 
+static void sel_remove_old_policy_nodes(struct selinux_fs_info *fsi)
+{
+	u32 i;
+
+	/* bool_dir cleanup */
+	for (i = 0; i < fsi->bool_num; i++)
+		kfree(fsi->bool_pending_names[i]);
+	kfree(fsi->bool_pending_names);
+	kfree(fsi->bool_pending_values);
+	fsi->bool_num = 0;
+	fsi->bool_pending_names = NULL;
+	fsi->bool_pending_values = NULL;
+
+	sel_remove_entries(fsi->bool_dir);
+
+	/* class_dir cleanup */
+	sel_remove_entries(fsi->class_dir);
+
+}
+
 static int sel_make_policy_nodes(struct selinux_fs_info *fsi,
 				struct selinux_policy *newpolicy)
 {
 	int ret;
 
+	sel_remove_old_policy_nodes(fsi);
+
 	ret = sel_make_bools(fsi, newpolicy);
 	if (ret) {
 		pr_err("SELinux: failed to load policy booleans\n");
@@ -1348,17 +1373,6 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
 	int *values = NULL;
 	u32 sid;
 
-	/* remove any existing files */
-	for (i = 0; i < fsi->bool_num; i++)
-		kfree(fsi->bool_pending_names[i]);
-	kfree(fsi->bool_pending_names);
-	kfree(fsi->bool_pending_values);
-	fsi->bool_num = 0;
-	fsi->bool_pending_names = NULL;
-	fsi->bool_pending_values = NULL;
-
-	sel_remove_entries(dir);
-
 	ret = -ENOMEM;
 	page = (char *)get_zeroed_page(GFP_KERNEL);
 	if (!page)
@@ -1873,9 +1887,6 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
 	int rc, nclasses, i;
 	char **classes;
 
-	/* delete any existing entries */
-	sel_remove_entries(fsi->class_dir);
-
 	rc = security_get_classes(newpolicy, &classes, &nclasses);
 	if (rc)
 		return rc;
-- 
2.25.4

