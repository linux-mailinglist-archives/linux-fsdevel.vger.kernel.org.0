Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BF47A9B4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbjIUS5Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230036AbjIUS5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:57:00 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431708FB3E;
        Thu, 21 Sep 2023 11:51:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 7F837100321;
        Thu, 21 Sep 2023 17:03:46 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id cS9HrQngyQhG; Thu, 21 Sep 2023 17:03:46 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 7620310056B; Thu, 21 Sep 2023 17:03:46 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id A40B81002AE;
        Thu, 21 Sep 2023 17:03:45 +1000 (AEST)
Subject: [PATCH 3/8] autofs - refactor super block info init
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 21 Sep 2023 15:03:45 +0800
Message-ID: <169527982522.27328.18413711550740966247.stgit@donald.themaw.net>
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the allocation and initialisation of the super block
info struct to its own function.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   53 ++++++++++++++++++++++++++++-------------------------
 1 file changed, 28 insertions(+), 25 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index e279e275b0a5..992d6cb29707 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -171,11 +171,6 @@ static int parse_options(char *options,
 	root->i_uid = current_uid();
 	root->i_gid = current_gid();
 
-	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
-	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
-
-	sbi->pipefd = -1;
-
 	if (!options)
 		return 1;
 
@@ -248,41 +243,49 @@ static int parse_options(char *options,
 	return (sbi->pipefd < 0);
 }
 
-int autofs_fill_super(struct super_block *s, void *data, int silent)
+static struct autofs_sb_info *autofs_alloc_sbi(void)
 {
-	struct inode *root_inode;
-	struct dentry *root;
 	struct autofs_sb_info *sbi;
-	struct autofs_info *ino;
-	int pgrp = 0;
-	bool pgrp_set = false;
-	int ret = -EINVAL;
 
 	sbi = kzalloc(sizeof(*sbi), GFP_KERNEL);
 	if (!sbi)
-		return -ENOMEM;
-	pr_debug("starting up, sbi = %p\n", sbi);
+		return NULL;
 
-	s->s_fs_info = sbi;
 	sbi->magic = AUTOFS_SBI_MAGIC;
-	sbi->pipefd = -1;
-	sbi->pipe = NULL;
-	sbi->exp_timeout = 0;
-	sbi->oz_pgrp = NULL;
-	sbi->sb = s;
-	sbi->version = 0;
-	sbi->sub_version = 0;
 	sbi->flags = AUTOFS_SBI_CATATONIC;
+	sbi->min_proto = AUTOFS_MIN_PROTO_VERSION;
+	sbi->max_proto = AUTOFS_MAX_PROTO_VERSION;
+	sbi->pipefd = -1;
+
 	set_autofs_type_indirect(&sbi->type);
-	sbi->min_proto = 0;
-	sbi->max_proto = 0;
 	mutex_init(&sbi->wq_mutex);
 	mutex_init(&sbi->pipe_mutex);
 	spin_lock_init(&sbi->fs_lock);
-	sbi->queues = NULL;
 	spin_lock_init(&sbi->lookup_lock);
 	INIT_LIST_HEAD(&sbi->active_list);
 	INIT_LIST_HEAD(&sbi->expiring_list);
+
+	return sbi;
+}
+
+int autofs_fill_super(struct super_block *s, void *data, int silent)
+{
+	struct inode *root_inode;
+	struct dentry *root;
+	struct autofs_sb_info *sbi;
+	struct autofs_info *ino;
+	int pgrp = 0;
+	bool pgrp_set = false;
+	int ret = -EINVAL;
+
+	sbi = autofs_alloc_sbi();
+	if (!sbi)
+		return -ENOMEM;
+
+	pr_debug("starting up, sbi = %p\n", sbi);
+
+	sbi->sb = s;
+	s->s_fs_info = sbi;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = AUTOFS_SUPER_MAGIC;


