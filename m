Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0092F4C2D18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Feb 2022 14:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235020AbiBXNdL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Feb 2022 08:33:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235031AbiBXNdK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:33:10 -0500
Received: from smtpbg156.qq.com (smtpbg156.qq.com [15.184.82.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D313D1EC
        for <linux-fsdevel@vger.kernel.org>; Thu, 24 Feb 2022 05:32:36 -0800 (PST)
X-QQ-mid: bizesmtp70t1645709547tpwkhq7i
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 24 Feb 2022 21:32:20 +0800 (CST)
X-QQ-SSF: 01400000002000B0F000B00A0000000
X-QQ-FEAT: /38I06TeVDt/A9RUhVZYOINAD/wPpx9pW1Fb3qmhzq4x7Q2Ua+MBKouMh0Uzn
        mF7ioiAmnlUyMwrWJmNKv+nmVGoBWKsVxjGl5q6nYE8pE+TExWnUpBh5SlcD/UZFVCM8Isk
        bRvIkO+BkFI+Vo+R9MC3qN9npU/RvArveLimfqrBtfH1aUfXiI8dUS4EHHNz68oxLxEUFUJ
        j4VSg9QJkWUkJBIMdt8Y2FgEob+tjpdKZ0jxDzHys7ObyddxOeYpBCEG5EBa7OsZwYK7XSy
        3wxpQ7bLzxjCGFutx+fQbnjEOV6rtr4OuEtPMNineyYAsgPwEn3u+IcmfHlX0l7XI4xJ46X
        Ev8c7UftVm2ZQSwKxnjYepAa9bYffdyMQ1gKLRZqw1Q1vTfZvQ=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com
Cc:     guoren@kernel.org, nickhu@andestech.com, green.hu@gmail.com,
        deanbo422@gmail.com, ebiggers@kernel.org, tytso@mit.edu,
        wad@chromium.org, john.johansen@canonical.com, jmorris@namei.org,
        serge@hallyn.com, linux-csky@vger.kernel.org,
        linux-fscrypt@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>
Subject: [PATCH v3 1/2] fs/proc: Optimize arrays defined by struct ctl_path
Date:   Thu, 24 Feb 2022 21:32:16 +0800
Message-Id: <20220224133217.1755-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Previously, arrays defined by struct ctl_path is terminated
with an empty one. When we actually only register one ctl_path,
we've gone from 8 bytes to 16 bytes.

So, I use ARRAY_SIZE() as a boundary condition to optimize it.

Since the original __register_sysctl_paths is only used in
fs/proc/proc_sysctl.c, in order to not change the usage of
register_sysctl_paths, delete __register_sysctl_paths from
include/linux/sysctl.h, change it to __register_sysctl_paths_init
in fs/proc/proc_sysctl.c, and modify it with static.
The register_sysctl_paths becomes __register_sysctl_paths,
and the macro definition is used in include/linux/sysctl.h
to expand register_sysctl_paths(path, table) to
__register_sysctl_paths(path, ARRAY_SIZE(path), table).

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
---
 fs/proc/proc_sysctl.c  | 22 +++++++++++++---------
 include/linux/sysctl.h |  9 ++++-----
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 9ecd5c87e8dd..721a8bec63d6 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1589,9 +1589,10 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 }
 
 /**
- * __register_sysctl_paths - register a sysctl table hierarchy
+ * __register_sysctl_paths_init - register a sysctl table hierarchy
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
+ * @ctl_path_num: The numbers(ARRAY_SIZE(path)) of ctl_path
  * @table: the top-level table structure
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
@@ -1599,22 +1600,23 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  *
  * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *__register_sysctl_paths(
+static struct ctl_table_header *__register_sysctl_paths_init(
 	struct ctl_table_set *set,
-	const struct ctl_path *path, struct ctl_table *table)
+	const struct ctl_path *path, int ctl_path_num, struct ctl_table *table)
 {
 	struct ctl_table *ctl_table_arg = table;
 	int nr_subheaders = count_subheaders(table);
 	struct ctl_table_header *header = NULL, **subheaders, **subheader;
 	const struct ctl_path *component;
 	char *new_path, *pos;
+	int i;
 
 	pos = new_path = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!new_path)
 		return NULL;
 
 	pos[0] = '\0';
-	for (component = path; component->procname; component++) {
+	for (component = path, i = 0; component->procname && i < ctl_path_num; component++, i++) {
 		pos = append_path(new_path, pos, component->procname);
 		if (!pos)
 			goto out;
@@ -1663,20 +1665,22 @@ struct ctl_table_header *__register_sysctl_paths(
 /**
  * register_sysctl_paths - register a sysctl table hierarchy
  * @path: The path to the directory the sysctl table is in.
+ * @ctl_path_num: The numbers(ARRAY_SIZE(path)) of ctl_path
  * @table: the top-level table structure
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
  *
- * See __register_sysctl_paths for more details.
+ * See __register_sysctl_paths_init for more details.
  */
-struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
+struct ctl_table_header *__register_sysctl_paths(const struct ctl_path *path,
+						int ctl_path_num,
 						struct ctl_table *table)
 {
-	return __register_sysctl_paths(&sysctl_table_root.default_set,
-					path, table);
+	return __register_sysctl_paths_init(&sysctl_table_root.default_set,
+					path, ctl_path_num, table);
 }
-EXPORT_SYMBOL(register_sysctl_paths);
+EXPORT_SYMBOL(__register_sysctl_paths);
 
 /**
  * register_sysctl_table - register a sysctl table hierarchy
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 889c995d8a08..37958aeecfb5 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -219,13 +219,12 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
 struct ctl_table_header *__register_sysctl_table(
 	struct ctl_table_set *set,
 	const char *path, struct ctl_table *table);
-struct ctl_table_header *__register_sysctl_paths(
-	struct ctl_table_set *set,
-	const struct ctl_path *path, struct ctl_table *table);
 struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table);
 struct ctl_table_header *register_sysctl_table(struct ctl_table * table);
-struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
-						struct ctl_table *table);
+#define register_sysctl_paths(path, table) \
+	__register_sysctl_paths(path, ARRAY_SIZE(path), table)
+extern struct ctl_table_header *__register_sysctl_paths(const struct ctl_path *path,
+						int ctl_path_num, struct ctl_table *table);
 
 void unregister_sysctl_table(struct ctl_table_header * table);
 
-- 
2.20.1



