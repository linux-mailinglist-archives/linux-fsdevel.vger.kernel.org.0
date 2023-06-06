Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600C47243FA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Jun 2023 15:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbjFFNMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Jun 2023 09:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbjFFNLT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Jun 2023 09:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DABA171D
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 06:11:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 054F2632EF
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Jun 2023 13:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D49B5C433D2;
        Tue,  6 Jun 2023 13:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686057067;
        bh=u0otBwYFQ+z8N18f7DVMp5oxjO//N2A60QgEjFLrBOg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=JbNBABKontbCwxlBmCbgb53L+r3ClkUEcy/pix2iQTSQrm4wG0Ut5O1PNkwtl/tkc
         fcVFp/o2WMTQP1ukmGZxhhxK0epu/Hb5wf6/JQd9t2rMQ8ZKMYKaK8fGEWUvzFxtg+
         Zsm+3AGV/OYNDLgLKJtruy6LStpYQ/+zv4P9NleyF23jYlRhZC/o94eeTRa72HKykE
         HL6eHLij77ycF7f14I8ayfRA0iy6qx7ZBtKlPyj0FDh1pIDuLAq9GmFVYkbAtKHuv2
         LlrC2bOkKURujeISHZ/950XiuAcydS7J8tsWR1ks2rCYFMFRO85xXE3rJa+N9EBlIn
         i5gy1CWDQ8PuA==
Subject: [PATCH v3 2/3] shmem: Refactor shmem_symlink()
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
Date:   Tue, 06 Jun 2023 09:11:05 -0400
Message-ID: <168605706595.32244.17121016307596271925.stgit@manet.1015granger.net>
In-Reply-To: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
References: <168605676256.32244.6158641147817585524.stgit@manet.1015granger.net>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/shmem.c |   19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index e40a08c5c6d7..721f9fd064aa 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3161,26 +3161,22 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 
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
@@ -3195,6 +3191,9 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
+out_iput:
+	iput(inode);
+	return error;
 }
 
 static void shmem_put_link(void *arg)


