Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6C8B6F88BA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:39:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbjEESjy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:39:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233294AbjEESju (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:39:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CA91A4AE
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 11:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 656EE6123B
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 18:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C52C4339E;
        Fri,  5 May 2023 18:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311985;
        bh=mnpCJnLWNfPkHxmM+u+UF6L43j8pKp55GRe3BbzShFc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=dt/3WmZqawbotPuR4zhXODVMzgAQJFtU6w6auHJr1A7S+XkIzFtfFk+q3ptGu8yR8
         2iixaLu4XVTftOxrRSLTgQevQ3/bOiMNHtq7y/CWsi313PFGm2eC7sEbNmx60QtXrA
         yyx4yTPvgWCC71x28BXwfyT9VTO6l/mFyKEmjD5MsqLEY/9hM5+rOcYIloJO8H5cws
         WA1E+KHEHpO2/R6KGY37mcuIbJd1YAkDZxwk9btgWSOYM9lust1gHRgSfK8uc+nQ7J
         5pTwMUvw2+WXyKy4VYxnu69W5Ydf4amfrsCvz7tzrC3j1fz+VFn0f6D57AvLXOxSdZ
         q2DdnRsZplhuQ==
Subject: [PATCH v2 4/5] shmem: Add a shmem-specific dir_emit helper
From:   Chuck Lever <cel@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 05 May 2023 14:39:34 -0400
Message-ID: <168331196437.20728.1655558228044135552.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168331111400.20728.2327812215536431362.stgit@oracle-102.nfsv4bat.org>
References: <168331111400.20728.2327812215536431362.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Clean up to improve the readability of shmem_readdir().

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 mm/shmem.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index b78253996108..733b98ca8517 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3329,6 +3329,15 @@ static loff_t shmem_dir_llseek(struct file *file, loff_t offset, int whence)
 	return offset;
 }
 
+static bool shmem_dir_emit(struct dir_context *ctx, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+
+	return ctx->actor(ctx, dentry->d_name.name, dentry->d_name.len,
+			  ctx->pos, inode->i_ino,
+			  fs_umode_to_dtype(inode->i_mode));
+}
+
 /**
  * shmem_readdir - Emit entries starting at offset @ctx->pos
  * @file: an open directory to iterate over
@@ -3369,9 +3378,7 @@ static int shmem_readdir(struct file *file, struct dir_context *ctx)
 		return 0;
 
 	while ((next = scan_positives(cursor, p, 1, next)) != NULL) {
-		if (!dir_emit(ctx, next->d_name.name, next->d_name.len,
-			      d_inode(next)->i_ino,
-			      fs_umode_to_dtype(d_inode(next)->i_mode)))
+		if (!shmem_dir_emit(ctx, dentry))
 			break;
 		ctx->pos++;
 		p = &next->d_child;


