Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0011959B055
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiHTUPB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiHTUPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:15:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 002F02F65C
        for <linux-fsdevel@vger.kernel.org>; Sat, 20 Aug 2022 13:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eczBb+dnAseXIDwvlTbbXDeY6daD9Fm1d0jKak5GadE=; b=IYMO1TFsBJBUDzJ8bzeFIjSTsi
        XSzoTPari7vdoaFMH4rDttOahikJnBiF/uxVNIBmCsAyQeUApg4CZUv+AVqzjnT97LXRsDApNkDC4
        yF3WBeUoqkvpg+X6lx/ZpDIOFw0JKRNk7mBAp9PsHD1Crq13JfxrgWWmrIKse/ixje0SMIeYJu5CF
        w5KvuQlrUJODre22ubgesKgZx0WC17ehF9nXDWF7x2VW0rF0WGotONCme+XqqbS1OBw6so0CEpdd0
        D7WoDnvf2chGiFQdaYN1I63zqOX8IjddaT9RQay15g2WpdFjH0vBVH86MSSsXiB2jqL+w6/xSCUfV
        hw+Y9MUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPUrx-006T7j-HP;
        Sat, 20 Aug 2022 20:14:57 +0000
Date:   Sat, 20 Aug 2022 21:14:57 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-fsdevel@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 2/8] exfat_iterate(): don't open-code file_inode(file)
Message-ID: <YwFAwZDjXN9ZQrfP@ZenIV>
References: <YwFANLruaQpqmPKv@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFANLruaQpqmPKv@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

and it's file, not filp...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/exfat/dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/exfat/dir.c b/fs/exfat/dir.c
index a27b55ec060a..0fc08fdcba73 100644
--- a/fs/exfat/dir.c
+++ b/fs/exfat/dir.c
@@ -212,9 +212,9 @@ static void exfat_free_namebuf(struct exfat_dentry_namebuf *nb)
 
 /* skip iterating emit_dots when dir is empty */
 #define ITER_POS_FILLED_DOTS    (2)
-static int exfat_iterate(struct file *filp, struct dir_context *ctx)
+static int exfat_iterate(struct file *file, struct dir_context *ctx)
 {
-	struct inode *inode = filp->f_path.dentry->d_inode;
+	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	struct inode *tmp;
 	struct exfat_dir_entry de;
@@ -228,7 +228,7 @@ static int exfat_iterate(struct file *filp, struct dir_context *ctx)
 	mutex_lock(&EXFAT_SB(sb)->s_lock);
 
 	cpos = ctx->pos;
-	if (!dir_emit_dots(filp, ctx))
+	if (!dir_emit_dots(file, ctx))
 		goto unlock;
 
 	if (ctx->pos == ITER_POS_FILLED_DOTS) {
-- 
2.30.2

