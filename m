Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C9764EDE0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Dec 2022 16:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiLPP1Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Dec 2022 10:27:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiLPP1H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Dec 2022 10:27:07 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E1C62EAF
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Dec 2022 07:27:03 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 64D65343E4;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671204422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2zsNk46dwlO21O2DgprEKKvHvrvZ3EJhKrUg0oK13Y=;
        b=XdKgEdngGss0Qjkmk+eQ2Ghrr0oQFFP1mZY3P2gX04qbVdooUOll3ssqr6G5NseI40EP6j
        rgOJrqRgIIJPnmzC8Tkn9iO62EaU3196MG53uagLN60/Sa6nXMDecrhlmC/6kHEfKGGoBn
        vzmsEBDAFUm7x4q530a1pLevrMS0Va8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671204422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g2zsNk46dwlO21O2DgprEKKvHvrvZ3EJhKrUg0oK13Y=;
        b=kSzeE/b9fnMDba6Pf4RJz9WcLcMfUTABjAOAWNZTb7hOCWN/29qlBn3BKQgnpJ5+Bxjnq2
        OYFxe0+yvP2bbKCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3556713909;
        Fri, 16 Dec 2022 15:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id jMsEDUaOnGPVCAAAMHmgww
        (envelope-from <jack@suse.cz>); Fri, 16 Dec 2022 15:27:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id B5241A076F; Fri, 16 Dec 2022 16:26:56 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Jan Kara <jack@suse.cz>
Subject: [PATCH 12/20] udf: Convert udf_unlink() to new directory iteration code
Date:   Fri, 16 Dec 2022 16:24:16 +0100
Message-Id: <20221216152656.6236-12-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20221216121344.14025-1-jack@suse.cz>
References: <20221216121344.14025-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1908; i=jack@suse.cz; h=from:subject; bh=r2ilemztHko3M2bYhkKVAXFSFwPIL/JhPNljRM+2zH0=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGJLn9C5YeSB7lsDW7Mc263i9X4tkOMs5/T8rpFy5/lSyinKD cIRgJ6MxCwMjB4OsmCLL6siL2tfmGXVtDdWQgRnEygQyhYGLUwAmonGFg2FKT815vmMJx8POXjVbeK S90iDn+LSW7uBV6+2fpT0r1c6VMj9n9J01peVp1uUlYV1/bNSUWGWcElNmdhYLSbg2rA1ZKqh6a1VN oZrrTb8zptHzaxZPE92zuuLTzSlpE+4YbjZgLK7g8X7I+jQ6wW2bMbOi5fVaxdhdeso7zoY717/4Fh oQXNn5xv3E0Q0yU/c977R+UNx4ivOW/tUSL+3Da2IbLx2RSLizIYI9UFem+9oPn4x1a9me8zlUR6jm mSz1TT7G+blW75nFLJ+sGv3L91bXTHrQ7iMWkR955ESfDpeP8YyFn7gKule6NYSEi92Y/17oiOFFzR mXZTriZJSmLTd/Kmmt2XwvicEWAA==
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert udf_unlink() to new directory iteration code.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/namei.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 703303562778..d0ffd2083519 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -933,24 +933,17 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 
 static int udf_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int retval;
+	int ret;
 	struct inode *inode = d_inode(dentry);
-	struct udf_fileident_bh fibh;
-	struct fileIdentDesc *fi;
-	struct fileIdentDesc cfi;
+	struct udf_fileident_iter iter;
 	struct kernel_lb_addr tloc;
 
-	retval = -ENOENT;
-	fi = udf_find_entry(dir, &dentry->d_name, &fibh, &cfi);
-
-	if (IS_ERR_OR_NULL(fi)) {
-		if (fi)
-			retval = PTR_ERR(fi);
+	ret = udf_fiiter_find_entry(dir, &dentry->d_name, &iter);
+	if (ret)
 		goto out;
-	}
 
-	retval = -EIO;
-	tloc = lelb_to_cpu(cfi.icb.extLocation);
+	ret = -EFSCORRUPTED;
+	tloc = lelb_to_cpu(iter.fi.icb.extLocation);
 	if (udf_get_lb_pblock(dir->i_sb, &tloc, 0) != inode->i_ino)
 		goto end_unlink;
 
@@ -959,22 +952,16 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 			  inode->i_ino, inode->i_nlink);
 		set_nlink(inode, 1);
 	}
-	retval = udf_delete_entry(dir, fi, &fibh, &cfi);
-	if (retval)
-		goto end_unlink;
+	udf_fiiter_delete_entry(&iter);
 	dir->i_ctime = dir->i_mtime = current_time(dir);
 	mark_inode_dirty(dir);
 	inode_dec_link_count(inode);
 	inode->i_ctime = dir->i_ctime;
-	retval = 0;
-
+	ret = 0;
 end_unlink:
-	if (fibh.sbh != fibh.ebh)
-		brelse(fibh.ebh);
-	brelse(fibh.sbh);
-
+	udf_fiiter_release(&iter);
 out:
-	return retval;
+	return ret;
 }
 
 static int udf_symlink(struct user_namespace *mnt_userns, struct inode *dir,
-- 
2.35.3

