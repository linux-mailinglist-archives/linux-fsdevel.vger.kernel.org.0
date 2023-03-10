Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A976B549B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Mar 2023 23:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjCJWkI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Mar 2023 17:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbjCJWkE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Mar 2023 17:40:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C0E12C0DE;
        Fri, 10 Mar 2023 14:40:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=kyWpWo0acxXgbXOKbiq5AQoZeq7yr4dxSGGgNTZKgqM=; b=R+OzvH3LAmf4i0wBfbnsej4V56
        OLQQKIarbjmZMH5HZc3IWX98s8S8ONBA80HxhNDI8I0UvzO0ql4Cq+tbWgx+JoiBcf+j3lU2mApWD
        GZr6uCLJ9qJTHB3Bn6fE4CdwKhPbKiApnEyzng3TvckRtlJ5d9pSahYoPzEOCZofyO5MNd3s8wGIR
        8WLdzdA9ltlA/9cez3MYrN/2uMn3ajjSq8qa4p1/82bnZlZnGpmDjZydx2UsKLU7nsamsGh557+Hf
        mjDh0yWii6rJgOQePz8cvbgbjmOhQjtppKdaXfnu53yG3FElaSbVoY+boyOzxtYaDsYIJY2+f2K69
        FITGTriA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1palOu-00GRBO-J4; Fri, 10 Mar 2023 22:39:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     ebiederm@xmission.com, keescook@chromium.org, yzaikin@google.com
Cc:     j.granados@samsung.com, patches@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] proc_sysctl: enhance documentation
Date:   Fri, 10 Mar 2023 14:39:47 -0800
Message-Id: <20230310223947.3917711-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Expand documentation to clarify:

  o that paths don't need to exist for the new API callers
  o clarify that we *require* callers to keep the memory of
    the table around during the lifetime of the sysctls
  o annotate routines we are trying to deprecate and later remove

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

I'm sending this out separately from the rest of the changes so I can
refer to this new documentation update separately. With the next few
patches I am posting we should be able to deprecate the recursion path
of sysctl registration in about 1-2 kernel cycles max!

 fs/proc/proc_sysctl.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index 15d5e02f1ec0..7ad07435828f 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1316,7 +1316,10 @@ static struct ctl_dir *sysctl_mkdir_p(struct ctl_dir *dir, const char *path)
  * __register_sysctl_table - register a leaf sysctl table
  * @set: Sysctl tree to register on
  * @path: The path to the directory the sysctl table is in.
- * @table: the top-level table structure without any child
+ * @table: the top-level table structure without any child. This table
+ * 	 should not be free'd after registration. So it should not be
+ * 	 used on stack. It can either be a global or dynamically allocated
+ * 	 by the caller and free'd later after sysctl unregistration.
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1410,8 +1413,15 @@ struct ctl_table_header *__register_sysctl_table(
 
 /**
  * register_sysctl - register a sysctl table
- * @path: The path to the directory the sysctl table is in.
- * @table: the table structure
+ * @path: The path to the directory the sysctl table is in. If the path
+ * 	doesn't exist we will create it for you.
+ * @table: the table structure. The calller must ensure the life of the @table
+ * 	will be kept during the lifetime use of the syctl. It must not be freed
+ * 	until unregister_sysctl_table() is called with the given returned table
+ * 	with this registration. If your code is non modular then you don't need
+ * 	to call unregister_sysctl_table() and can instead use something like
+ * 	register_sysctl_init() which does not care for the result of the syctl
+ * 	registration.
  *
  * Register a sysctl table. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
@@ -1427,8 +1437,11 @@ EXPORT_SYMBOL(register_sysctl);
 
 /**
  * __register_sysctl_init() - register sysctl table to path
- * @path: path name for sysctl base
- * @table: This is the sysctl table that needs to be registered to the path
+ * @path: path name for sysctl base. If that path doesn't exist we will create
+ * 	it for you.
+ * @table: This is the sysctl table that needs to be registered to the path.
+ * 	The caller must ensure the life of the @table will be kept during the
+ * 	lifetime use of the sysctl.
  * @table_name: The name of sysctl table, only used for log printing when
  *              registration fails
  *
@@ -1570,6 +1583,7 @@ static int register_leaf_sysctl_tables(const char *path, char *pos,
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
+ * We are slowly deprecating this call so avoid its use.
  *
  * See __register_sysctl_table for more details.
  */
@@ -1641,6 +1655,7 @@ struct ctl_table_header *__register_sysctl_paths(
  *
  * Register a sysctl table hierarchy. @table should be a filled in ctl_table
  * array. A completely 0 filled entry terminates the table.
+ * We are slowly deprecating this caller so avoid future uses of it.
  *
  * See __register_sysctl_paths for more details.
  */
-- 
2.39.1

