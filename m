Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293F47A9B46
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Sep 2023 20:57:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjIUS5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Sep 2023 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjIUS5A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:57:00 -0400
Received: from smtp01.aussiebb.com.au (smtp01.aussiebb.com.au [IPv6:2403:5800:3:25::1001])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1258DEFE;
        Thu, 21 Sep 2023 11:51:05 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 70527100580;
        Thu, 21 Sep 2023 17:03:40 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at smtp01.aussiebb.com.au
Received: from smtp01.aussiebb.com.au ([127.0.0.1])
        by localhost (smtp01.aussiebb.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AAGMtsSZ3NHu; Thu, 21 Sep 2023 17:03:40 +1000 (AEST)
Received: by smtp01.aussiebb.com.au (Postfix, from userid 116)
        id 67A5C10057F; Thu, 21 Sep 2023 17:03:40 +1000 (AEST)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
Received: from donald.themaw.net (180-150-90-198.b4965a.per.nbn.aussiebb.net [180.150.90.198])
        by smtp01.aussiebb.com.au (Postfix) with ESMTP id 8AFA9100265;
        Thu, 21 Sep 2023 17:03:39 +1000 (AEST)
Subject: [PATCH 2/8] autofs: add autofs_parse_fd()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     autofs mailing list <autofs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bill O'Donnell <billodo@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Date:   Thu, 21 Sep 2023 15:03:39 +0800
Message-ID: <169527981914.27328.15182386732807940466.stgit@donald.themaw.net>
In-Reply-To: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
References: <169527971702.27328.16272807830250040704.stgit@donald.themaw.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Factor out the fd mount option handling.

Signed-off-by: Ian Kent <raven@themaw.net>
---
 fs/autofs/inode.c |   48 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 17 deletions(-)

diff --git a/fs/autofs/inode.c b/fs/autofs/inode.c
index 2b49662ed237..e279e275b0a5 100644
--- a/fs/autofs/inode.c
+++ b/fs/autofs/inode.c
@@ -129,6 +129,33 @@ static const match_table_t tokens = {
 	{Opt_err, NULL}
 };
 
+static int autofs_parse_fd(struct autofs_sb_info *sbi, int fd)
+{
+	struct file *pipe;
+	int ret;
+
+	pipe = fget(fd);
+	if (!pipe) {
+		pr_err("could not open pipe file descriptor\n");
+		return -EBADF;
+	}
+
+	ret = autofs_check_pipe(pipe);
+	if (ret < 0) {
+		pr_err("Invalid/unusable pipe\n");
+		fput(pipe);
+		return -EBADF;
+	}
+
+	if (sbi->pipe)
+		fput(sbi->pipe);
+
+	sbi->pipefd = fd;
+	sbi->pipe = pipe;
+
+	return 0;
+}
+
 static int parse_options(char *options,
 			 struct inode *root, int *pgrp, bool *pgrp_set,
 			 struct autofs_sb_info *sbi)
@@ -139,6 +166,7 @@ static int parse_options(char *options,
 	int pipefd = -1;
 	kuid_t uid;
 	kgid_t gid;
+	int ret;
 
 	root->i_uid = current_uid();
 	root->i_gid = current_gid();
@@ -162,7 +190,9 @@ static int parse_options(char *options,
 		case Opt_fd:
 			if (match_int(args, &pipefd))
 				return 1;
-			sbi->pipefd = pipefd;
+			ret = autofs_parse_fd(sbi, pipefd);
+			if (ret)
+				return 1;
 			break;
 		case Opt_uid:
 			if (match_int(args, &option))
@@ -222,7 +252,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 {
 	struct inode *root_inode;
 	struct dentry *root;
-	struct file *pipe;
 	struct autofs_sb_info *sbi;
 	struct autofs_info *ino;
 	int pgrp = 0;
@@ -275,7 +304,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 		ret = -ENOMEM;
 		goto fail_ino;
 	}
-	pipe = NULL;
 
 	root->d_fsdata = ino;
 
@@ -321,16 +349,7 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 
 	pr_debug("pipe fd = %d, pgrp = %u\n",
 		 sbi->pipefd, pid_nr(sbi->oz_pgrp));
-	pipe = fget(sbi->pipefd);
 
-	if (!pipe) {
-		pr_err("could not open pipe file descriptor\n");
-		goto fail_put_pid;
-	}
-	ret = autofs_prepare_pipe(pipe);
-	if (ret < 0)
-		goto fail_fput;
-	sbi->pipe = pipe;
 	sbi->flags &= ~AUTOFS_SBI_CATATONIC;
 
 	/*
@@ -342,11 +361,6 @@ int autofs_fill_super(struct super_block *s, void *data, int silent)
 	/*
 	 * Failure ... clean up.
 	 */
-fail_fput:
-	pr_err("pipe file descriptor does not contain proper ops\n");
-	fput(pipe);
-fail_put_pid:
-	put_pid(sbi->oz_pgrp);
 fail_dput:
 	dput(root);
 	goto fail_free;


