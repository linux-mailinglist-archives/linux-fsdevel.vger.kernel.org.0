Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956FA7414DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 17:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjF1PZ0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 11:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230498AbjF1PZT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:25:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0742682
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 08:25:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB20761369
        for <linux-fsdevel@vger.kernel.org>; Wed, 28 Jun 2023 15:25:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E3AC433C9;
        Wed, 28 Jun 2023 15:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687965917;
        bh=e4I/gNHDIjpSKufk2xxM8B41vPKw1FE7ZKuVtO31ayU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j0i6ikly/vKfjVuwx9wICD5KcaOQQ01VEGi3ol8P4+JUzBYb+bgUI0oGPnxlbHbrd
         iHzrPbCdSvNvOnfpVYD5iZkuYXU47+RI0/ZYrjyQvHnleHON3qExf5wjKf1HiOtQ+K
         ES+mAU1eJ8piaIb7lSu7XFLKB1p6kSgDB5THy8oE1MBCWD52xhXBHFArJHok4erBr4
         Sl83t67t1GjeXvTP2DvXpet4h/9OMSiBM8M1EKm7klMeVYtTu0/O/9RF8/ArL8F1lU
         pR6yLbhjZ7/qtA42xeNFwUd14F9l5IIvTomiUdF/7NdFiaB7aANHaY1OPpMvxjoSUC
         2bZehSg3sC1Kg==
Subject: [PATCH v6 2/3] shmem: Refactor shmem_symlink()
From:   Chuck Lever <cel@kernel.org>
To:     viro@zeniv.linux.org.uk, brauner@kernel.org, hughd@google.com,
        akpm@linux-foundation.org
Cc:     Jeff Layton <jlayton@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Chuck Lever <chuck.lever@oracle.com>, jlayton@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 28 Jun 2023 11:25:15 -0400
Message-ID: <168796591580.157221.7871489061567042327.stgit@manet.1015granger.net>
In-Reply-To: <168796579723.157221.1988816921257656153.stgit@manet.1015granger.net>
References: <168796579723.157221.1988816921257656153.stgit@manet.1015granger.net>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
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


