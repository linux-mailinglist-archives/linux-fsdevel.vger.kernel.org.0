Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 451B5242EFA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Aug 2020 21:15:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgHLTPe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 15:15:34 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49296 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgHLTPd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 15:15:33 -0400
Received: from localhost.localdomain (c-73-172-233-15.hsd1.md.comcast.net [73.172.233.15])
        by linux.microsoft.com (Postfix) with ESMTPSA id C416320B490A;
        Wed, 12 Aug 2020 12:15:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C416320B490A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1597259733;
        bh=xF0mhOijsh/kjeAjnO2uJStDciaP9z2VfWmKbSz/F+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j0JXZj2XXu+wQLjt7oVyp+NzTln7hSIz5ipRg1uVmnSynU1gsOIOFr1AS1/D072Fa
         0M8bnrLnkRnK/ol0doItqKn8F988at+ZVN8Vmv3W2a4pmApXSKhd2c4shGpYDyQtyc
         Wm77ms5l8h+AI4IGR8jK008s/HxaCdbYD53PY7aE=
From:   Daniel Burgener <dburgener@linux.microsoft.com>
To:     selinux@vger.kernel.org
Cc:     stephen.smalley.work@gmail.com, omosnace@redhat.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk
Subject: [PATCH v2 1/4] selinux: Create function for selinuxfs directory cleanup
Date:   Wed, 12 Aug 2020 15:15:22 -0400
Message-Id: <20200812191525.1120850-2-dburgener@linux.microsoft.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
References: <20200812191525.1120850-1-dburgener@linux.microsoft.com>
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
 security/selinux/selinuxfs.c | 41 ++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 14 deletions(-)

diff --git a/security/selinux/selinuxfs.c b/security/selinux/selinuxfs.c
index 131816878e50..fc914facb48f 100644
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
@@ -509,11 +512,35 @@ static const struct file_operations sel_policy_ops = {
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
+	/* policycap_dir cleanup */
+	sel_remove_entries(fsi->policycap_dir);
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
@@ -1348,17 +1375,6 @@ static int sel_make_bools(struct selinux_fs_info *fsi,
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
@@ -1873,9 +1889,6 @@ static int sel_make_classes(struct selinux_fs_info *fsi,
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

