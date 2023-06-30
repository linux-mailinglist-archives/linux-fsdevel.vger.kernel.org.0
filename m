Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EB03744194
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jun 2023 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjF3RtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Jun 2023 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232904AbjF3RtA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Jun 2023 13:49:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20748273B
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 10:48:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A989F617DF
        for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jun 2023 17:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BBCEC433CB;
        Fri, 30 Jun 2023 17:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688147338;
        bh=lpcIrpUUhkkDjNh21WLxKZUWboCaHEQE1ZuJQA6VvY4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HIDO8gaorTxtlC6gS6AuM6QEXfPdbdEGL9QKN8puDoapE+HKJ9F/8+wmmTOPRCF7g
         PD5NHZsNRlwIg6h+JcRcEKJQ4+os8WDGbfvzi+ONC5Ood2iZQirG/WYny7xIQQs//I
         EQvmziJ3NjiMrJTt2q0v4ivFJ68fD6ypLe/Ik3u0S5KwZS9HutdestcxAuy3kWboQx
         MTq61sIYA9MOAzIsVEovyHP/ouimAbkEpfYvnr1NWwCV0+qmZQ+ol8TVCtIFcR43tG
         6Fh4I9SYxJTrYkQkDbxbuDoflZ3kJV/Prljn8cWuag6T5sZjdAuMltbB4APsADiJSE
         sbEl0DxiHkNgA==
Subject: [PATCH v7 2/3] shmem: Refactor shmem_symlink()
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 30 Jun 2023 13:48:56 -0400
Message-ID: <168814733654.530310.9958360833543413152.stgit@manet.1015granger.net>
In-Reply-To: <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
References: <168814723481.530310.17776748558242063239.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

De-duplicate the error handling paths. No change in behavior is
expected.

Suggested-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/shmem.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2f2e0e618072..ba3d7db90c9d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3293,26 +3293,22 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
 	error = security_inode_init_security(inode, dir, &dentry->d_name,
 					     shmem_initxattrs, NULL);
-	if (error && error != -EOPNOTSUPP) {
-		iput(inode);
-		return error;
-	}
+	if (error && error != -EOPNOTSUPP)
+		goto out_iput;
 
 	inode->i_size = len-1;
 	if (len <= SHORT_SYMLINK_LEN) {
 		inode->i_link = kmemdup(symname, len, GFP_KERNEL);
 		if (!inode->i_link) {
-			iput(inode);
-			return -ENOMEM;
+			error = -ENOMEM;
+			goto out_iput;
 		}
 		inode->i_op = &shmem_short_symlink_operations;
 	} else {
 		inode_nohighmem(inode);
 		error = shmem_get_folio(inode, 0, &folio, SGP_WRITE);
-		if (error) {
-			iput(inode);
-			return error;
-		}
+		if (error)
+			goto out_iput;
 		inode->i_mapping->a_ops = &shmem_aops;
 		inode->i_op = &shmem_symlink_inode_operations;
 		memcpy(folio_address(folio), symname, len);
@@ -3327,6 +3323,9 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
+out_iput:
+	iput(inode);
+	return error;
 }
 
 static void shmem_put_link(void *arg)


