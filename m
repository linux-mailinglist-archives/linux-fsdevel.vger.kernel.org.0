Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCC26A8A3F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Mar 2023 21:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjCBU3N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Mar 2023 15:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjCBU3M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Mar 2023 15:29:12 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5162A1A96D;
        Thu,  2 Mar 2023 12:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=/B53CtexeyD9Bd10s0zaJAUsHZrSjOaoezyvPxx8LTk=; b=kRovkSM5K1GhgJjJe0utOQ9MZY
        hpy6mdK+hdW7jylca3OqRuGOqomE9o3CJgh4EGuz6lp4VM+DigRs+oMJLZbx1vPfYAJGYvE/AZwdR
        zZMqIaZw9YNZrnir2UYXxGBYxi/AOSq6sF5ZDXLpiyr8lp6UjqhN/VKoOTg8OCGk9qa6qaxPQ/cFv
        /zAiY16rKO6TLzH1g2wL004PtEqFK9PR7b5zQiS749hfGIwUIGGJkzbEseFVd7V08//at3INtBAsB
        ehall8mmM0GZyxzilQRwnIGiLlRqdOFLBF5J1OIcHnXiivobw3jlcxCB7V9Z2lFMd/l7y5EuA2dCg
        f+aooOFA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pXpXR-003FxB-Uq; Thu, 02 Mar 2023 20:28:29 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com,
        john.johansen@canonical.com, paul@paul-moore.com,
        jmorris@namei.org, serge@hallyn.com, luto@amacapital.net,
        wad@chromium.org, dverkamp@chromium.org, paulmck@kernel.org,
        baihaowen@meizu.com, frederic@kernel.org, jeffxu@google.com,
        ebiggers@kernel.org, tytso@mit.edu, guoren@kernel.org
Cc:     j.granados@samsung.com, zhangpeng362@huawei.com,
        tangmeng@uniontech.com, willy@infradead.org, nixiaoming@huawei.com,
        sujiaxun@uniontech.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, apparmor@lists.ubuntu.com,
        linux-security-module@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH 02/11] proc_sysctl: move helper which creates required subdirectories
Date:   Thu,  2 Mar 2023 12:28:17 -0800
Message-Id: <20230302202826.776286-3-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230302202826.776286-1-mcgrof@kernel.org>
References: <20230302202826.776286-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the code which creates the subdirectories for a ctl table
into a helper routine so to make it easier to review. Document
the goal.

This creates no functional changes.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 fs/proc/proc_sysctl.c | 56 ++++++++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 24 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 1df0beb50dbe..6b9b2694d430 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1283,6 +1283,35 @@ static int insert_links(struct ctl_table_header *head)
 	return err;
 }
 
+/* Find the directory for the ctl_table. If one is not found create it. */
+static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
+{
+	const char *name, *nextname;
+
+	for (name = path; name; name = nextname) {
+		int namelen;
+		nextname = strchr(name, '/');
+		if (nextname) {
+			namelen = nextname - name;
+			nextname++;
+		} else {
+			namelen = strlen(name);
+		}
+		if (namelen == 0)
+			continue;
+
+		/*
+		 * namelen ensures if name is "foo/bar/yay" only foo is
+		 * registered first. We traverse as if using mkdir -p and
+		 * return a ctl_dir for the last directory entry.
+		 */
+		dir = get_subdir(dir, name, namelen);
+		if (IS_ERR(dir))
+			break;
+	}
+	return dir;
+}
+
 /**
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
@@ -1334,7 +1363,6 @@ struct ctl_table_header *__register_sysctl_table(
 {
 	struct ctl_table_root *root = set->dir.header.root;
 	struct ctl_table_header *header;
-	const char *name, *nextname;
 	struct ctl_dir *dir;
 	struct ctl_table *entry;
 	struct ctl_node *node;
@@ -1359,29 +1387,9 @@ struct ctl_table_header *__register_sysctl_table(
 	dir->header.nreg++;
 	spin_unlock(&sysctl_lock);
 
-	/* Find the directory for the ctl_table */
-	for (name = path; name; name = nextname) {
-		int namelen;
-		nextname = strchr(name, '/');
-		if (nextname) {
-			namelen = nextname - name;
-			nextname++;
-		} else {
-			namelen = strlen(name);
-		}
-		if (namelen == 0)
-			continue;
-
-		/*
-		 * namelen ensures if name is "foo/bar/yay" only foo is
-		 * registered first. We traverse as if using mkdir -p and
-		 * return a ctl_dir for the last directory entry.
-		 */
-		dir = get_subdir(dir, name, namelen);
-		if (IS_ERR(dir))
-			goto fail;
-	}
-
+	dir = sysctl_mkdir_p(dir, path);
+	if (IS_ERR(dir))
+		goto fail;
 	spin_lock(&sysctl_lock);
 	if (insert_header(dir, header))
 		goto fail_put_dir_locked;
-- 
2.39.1

