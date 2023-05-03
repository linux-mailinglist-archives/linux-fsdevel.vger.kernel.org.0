Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355C56F4EDC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 04:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbjECCdv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 May 2023 22:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjECCds (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 May 2023 22:33:48 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5025E30D4;
        Tue,  2 May 2023 19:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=YKv41lrZzaDA5jzJYcM1sk7xegNuYsjSroyK1tUeOHk=; b=4JaMPxa3nrDWOAi6pB1hYBPPx/
        88NsLvabkHhDlY6NxsI7iY/wABw+pm/JcZpY3tR1jY+ZgCwyGq5jcqXdpUVC3xZ07nfoeHUE7rLzc
        geYBwoOO2+VsPL8ufYDnP379sNOhBjtJQKFiAn1Nur3F3N2ERkiI/5p4OiDQ+EN0FBRCYu/mf7O7E
        zuScpiH0jNO3wfS0vfKeuBe+r70qTktbIbEBnWYCo0yGHC5szf+0euyDvcvbOq5YaJu6KPpt1Oyfj
        bEjVXk9yqoCDF+FempRArXYKrqGlM7hJlpQhXXSWmQ12mvBScVmyP+hdqtLK7mbTwX01dCqD1IgCd
        l41NQPcw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pu2J8-0039fJ-2d;
        Wed, 03 May 2023 02:33:30 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        j.granados@samsung.com, patches@lists.linux.dev,
        ebiggers@kernel.org, jeffxu@google.com, akpm@linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 2/2] sysctl: remove register_sysctl_paths()
Date:   Tue,  2 May 2023 19:33:29 -0700
Message-Id: <20230503023329.752123-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230503023329.752123-1-mcgrof@kernel.org>
References: <20230503023329.752123-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The deprecation for register_sysctl_paths() is over. We can rejoice as
we nuke register_sysctl_paths(). The routine register_sysctl_table()
was the only user left of register_sysctl_paths(), so we can now just
open code and move the implementation over to what used to be
to __register_sysctl_paths().

The old dynamic struct ctl_table_set *set is now the point to
sysctl_table_root.default_set.

The old dynamic const struct ctl_path *path was being used in the
routine register_sysctl_paths() with a static:

static const struct ctl_path null_path[] = { {} };

Since this is a null path we can now just simplfy the old routine
and remove its use as its always empty.

This saves us a total of 230 bytes.

$ ./scripts/bloat-o-meter vmlinux.old vmlinux
add/remove: 2/7 grow/shrink: 1/1 up/down: 1015/-1245 (-230)
Function                                     old     new   delta
register_leaf_sysctl_tables.constprop          -     524    +524
register_sysctl_table                         22     497    +475
__pfx_register_leaf_sysctl_tables.constprop       -      16     +16
null_path                                      8       -      -8
__pfx_register_sysctl_paths                   16       -     -16
__pfx_register_leaf_sysctl_tables             16       -     -16
__pfx___register_sysctl_paths                 16       -     -16
__register_sysctl_base                        29      12     -17
register_sysctl_paths                         18       -     -18
register_leaf_sysctl_tables                  534       -    -534
__register_sysctl_paths                      620       -    -620
Total: Before=21259666, After=21259436, chg -0.00%

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c     | 55 +++------------------------------------
 include/linux/sysctl.h    | 12 ---------
 scripts/check-sysctl-docs | 16 ------------
 3 files changed, 4 insertions(+), 79 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 81dbb175017e..8038833ff5b0 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1575,25 +1575,18 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
 }
 
 /**
- * __register_sysctl_paths - register a sysctl table hierarchy
- * @set: Sysctl tree to register on
- * @path: The path to the directory the sysctl table is in.
+ * register_sysctl_table - register a sysctl table hierarchy
  * @table: the top-level table structure
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
  * We are slowly deprecating this call so avoid its use.
- *
- * See __register_sysctl_table for more details.
  */
-struct ctl_table_header *__register_sysctl_paths(
-	struct ctl_table_set *set,
-	const struct ctl_path *path, struct ctl_table *table)
+struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
 {
 	struct ctl_table *ctl_table_arg = table;
 	int nr_subheaders = count_subheaders(table);
 	struct ctl_table_header *header = NULL, **subheaders, **subheader;
-	const struct ctl_path *component;
 	char *new_path, *pos;
 
 	pos = new_path = kmalloc(PATH_MAX, GFP_KERNEL);
@@ -1601,11 +1594,6 @@ struct ctl_table_header *__register_sysctl_paths(
 		return NULL;
 
 	pos[0] = '\0';
-	for (component = path; component->procname; component++) {
-		pos = append_path(new_path, pos, component->procname);
-		if (!pos)
-			goto out;
-	}
 	while (table->procname && table->child && !table[1].procname) {
 		pos = append_path(new_path, pos, table->procname);
 		if (!pos)
@@ -1613,7 +1601,7 @@ struct ctl_table_header *__register_sysctl_paths(
 		table = table->child;
 	}
 	if (nr_subheaders == 1) {
-		header = __register_sysctl_table(set, new_path, table);
+		header = __register_sysctl_table(&sysctl_table_root.default_set, new_path, table);
 		if (header)
 			header->ctl_table_arg = ctl_table_arg;
 	} else {
@@ -1627,7 +1615,7 @@ struct ctl_table_header *__register_sysctl_paths(
 		header->ctl_table_arg = ctl_table_arg;
 
 		if (register_leaf_sysctl_tables(new_path, pos, &subheader,
-						set, table))
+						&sysctl_table_root.default_set, table))
 			goto err_register_leaves;
 	}
 
@@ -1646,41 +1634,6 @@ struct ctl_table_header *__register_sysctl_paths(
 	header = NULL;
 	goto out;
 }
-
-/**
- * register_sysctl_paths - register a sysctl table hierarchy
- * @path: The path to the directory the sysctl table is in.
- * @table: the top-level table structure
- *
- * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array. A completely 0 filled entry terminates the table.
- * We are slowly deprecating this caller so avoid future uses of it.
- *
- * See __register_sysctl_paths for more details.
- */
-struct ctl_table_header *register_sysctl_paths(const struct ctl_path *path,
-						struct ctl_table *table)
-{
-	return __register_sysctl_paths(&sysctl_table_root.default_set,
-					path, table);
-}
-EXPORT_SYMBOL(register_sysctl_paths);
-
-/**
- * register_sysctl_table - register a sysctl table hierarchy
- * @table: the top-level table structure
- *
- * Register a sysctl table hierarchy. @table should be a filled in ctl_table
- * array. A completely 0 filled entry terminates the table.
- *
- * See register_sysctl_paths for more details.
- */
-struct ctl_table_header *register_sysctl_table(struct ctl_table *table)
-{
-	static const struct ctl_path null_path[] = { {} };
-
-	return register_sysctl_paths(null_path, table);
-}
 EXPORT_SYMBOL(register_sysctl_table);
 
 int __register_sysctl_base(struct ctl_table *base_table)
diff --git a/include/linux/sysctl.h b/include/linux/sysctl.h
index 780690dc08cd..3d08277959af 100644
--- a/include/linux/sysctl.h
+++ b/include/linux/sysctl.h
@@ -221,14 +221,8 @@ extern void retire_sysctl_set(struct ctl_table_set *set);
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
-
 void unregister_sysctl_table(struct ctl_table_header * table);
 
 extern int sysctl_init_bases(void);
@@ -277,12 +271,6 @@ static inline struct ctl_table_header *register_sysctl_mount_point(const char *p
 	return NULL;
 }
 
-static inline struct ctl_table_header *register_sysctl_paths(
-			const struct ctl_path *path, struct ctl_table *table)
-{
-	return NULL;
-}
-
 static inline struct ctl_table_header *register_sysctl(const char *path, struct ctl_table *table)
 {
 	return NULL;
diff --git a/scripts/check-sysctl-docs b/scripts/check-sysctl-docs
index 8bcb9e26c7bc..edc9a629d79e 100755
--- a/scripts/check-sysctl-docs
+++ b/scripts/check-sysctl-docs
@@ -156,22 +156,6 @@ curtable && /\.procname[\t ]*=[\t ]*".+"/ {
     }
 }
 
-/register_sysctl_paths\(.*\)/ {
-    match($0, /register_sysctl_paths\(([^)]+), ([^)]+)\)/, tables)
-    if (debug) print "Attaching table " tables[2] " to path " tables[1]
-    if (paths[tables[1]] == table) {
-	for (entry in entries[tables[2]]) {
-	    printentry(entry)
-	}
-    }
-    split(paths[tables[1]], components, "/")
-    if (length(components) > 1 && components[1] == table) {
-	# Count the first subdirectory as seen
-	seen[components[2]]++
-    }
-}
-
-
 END {
     for (entry in documented) {
 	if (!seen[entry]) {
-- 
2.39.2

