Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5AD59B068
	for <lists+linux-fsdevel@lfdr.de>; Sat, 20 Aug 2022 22:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbiHTU0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 20 Aug 2022 16:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbiHTU0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 20 Aug 2022 16:26:39 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5087B27CFA;
        Sat, 20 Aug 2022 13:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hOCm0Hz0m+lBIrzxUnWimgMR+C8pTt4CRmgMxqnfSMk=; b=rA/t41D8U+EWZ5Iyx8G21VoU+y
        yOz55s/LFZVbqHv1oFjOCBQYC+IFgKEW/inQcPNPyTdujwoNChRLLRy6DiDFjHl50rrFKxqsvmIuG
        h6F+31mOgQUnQmTPARFXtlJaN9bda2yv/0G8oHeaBUbzxr+9akHextbRqdfeI9WGYHrczLD6SP79P
        xXhNp/fVW6NdrL473WZj12d2KKNhKjMEFSe6GozMNJD413EMprHrdz29190Wun00sgd/V4uzg1zcJ
        h7LCiyXA6D0beH30zLijOoo20BgK2Y0prwRDFeFTYgoZD2ipVtdZ1WM5w7fw9RNd+6iUvFlJrAniw
        rTRhmbVg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1oPV3F-006TIA-SQ;
        Sat, 20 Aug 2022 20:26:37 +0000
Date:   Sat, 20 Aug 2022 21:26:37 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     linux-fsdevel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH 2/2] tomoyo: struct path it might get from LSM callers won't
 have NULL dentry or mnt
Message-ID: <YwFDfYcRKIYEkr43@ZenIV>
References: <YwFDLhioFG5Mlwws@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwFDLhioFG5Mlwws@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 security/tomoyo/file.c     | 2 +-
 security/tomoyo/realpath.c | 9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/security/tomoyo/file.c b/security/tomoyo/file.c
index 1e6077568fde..8f3b90b6e03d 100644
--- a/security/tomoyo/file.c
+++ b/security/tomoyo/file.c
@@ -717,7 +717,7 @@ int tomoyo_path_number_perm(const u8 type, const struct path *path,
 	int idx;
 
 	if (tomoyo_init_request_info(&r, NULL, tomoyo_pn2mac[type])
-	    == TOMOYO_CONFIG_DISABLED || !path->dentry)
+	    == TOMOYO_CONFIG_DISABLED)
 		return 0;
 	idx = tomoyo_read_lock();
 	if (!tomoyo_get_realpath(&buf, path))
diff --git a/security/tomoyo/realpath.c b/security/tomoyo/realpath.c
index df4798980416..1c483ee7f93d 100644
--- a/security/tomoyo/realpath.c
+++ b/security/tomoyo/realpath.c
@@ -240,11 +240,8 @@ char *tomoyo_realpath_from_path(const struct path *path)
 	char *name = NULL;
 	unsigned int buf_len = PAGE_SIZE / 2;
 	struct dentry *dentry = path->dentry;
-	struct super_block *sb;
+	struct super_block *sb = dentry->d_sb;
 
-	if (!dentry)
-		return NULL;
-	sb = dentry->d_sb;
 	while (1) {
 		char *pos;
 		struct inode *inode;
@@ -264,10 +261,8 @@ char *tomoyo_realpath_from_path(const struct path *path)
 		inode = d_backing_inode(sb->s_root);
 		/*
 		 * Get local name for filesystems without rename() operation
-		 * or dentry without vfsmount.
 		 */
-		if (!path->mnt ||
-		    (!inode->i_op->rename &&
+		if ((!inode->i_op->rename &&
 		     !(sb->s_type->fs_flags & FS_REQUIRES_DEV)))
 			pos = tomoyo_get_local_path(path->dentry, buf,
 						    buf_len - 1);
-- 
2.30.2

