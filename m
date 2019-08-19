Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1014926AD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Aug 2019 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbfHSO1Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Aug 2019 10:27:25 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38697 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbfHSO1Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Aug 2019 10:27:25 -0400
Received: by mail-io1-f65.google.com with SMTP id p12so2239946iog.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Aug 2019 07:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digidescorp.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=R8P35k0UQJjogiM45vdQN2jnqatZkqahOot8zhEBvOA=;
        b=C71yn3O+tVUgGp34iebMxBFlEYKY5R6egz+a8nPwjIFrrYZQj7NEkmJqILHXVNuraV
         z8sBN3M48RWzPbmVV4YXWyfLOs6kUmC5mvGoo325X+Wg3P6oEeOohxk4DMM2l+TTVJfr
         MihiKb+FShaUp9U93XS/AZ0LRPlZm4pWd4n5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=R8P35k0UQJjogiM45vdQN2jnqatZkqahOot8zhEBvOA=;
        b=EssoEAz4kwMqwEzKOVhxHYFBMaMBhtKuPa74X3cXaXq/e+aS4P07g7enTbeiLmrrK4
         29Cu0cmC3pszZbqFTHLPDkGtcQPyoDauFlpfKaS9gKDdsvoCC1k67hcKUZoHFJmg3p6f
         RYOnO/FSF14X2dgLZbHPEOWwxviYWn9DgqOLJiJINZm/DPVOzywHmCaMLMQttdnHNbvO
         TWeY0YMbALhf+qCcN0kJ4+WzG3J74v2UppUEoqXagpszyF21S8Qk2mleJVxzv6SwTIrC
         CD34Gs32JJnjmCRu3yDWBGkqujAT6nAgJ/XSTmXdjxqqevnJ0Ky6Oh39kCgIrHYxAAsr
         9++w==
X-Gm-Message-State: APjAAAXLry6qfwBDoOlwQPtnrgsQTevO5buQihj0BRkJF17EJAY7KWzd
        Tl9vXMSHLx6XsvMXGYzA81J7SA==
X-Google-Smtp-Source: APXvYqyUl7vN5glGFLU0oh31MAE5ukPTM6BNKV46NTUX2Bcajx4wlyYAyTb5nVj546i2DGGGQEs22Q==
X-Received: by 2002:a02:4005:: with SMTP id n5mr27068009jaa.73.1566224844827;
        Mon, 19 Aug 2019 07:27:24 -0700 (PDT)
Received: from iscandar.digidescorp.com (104-51-28-62.lightspeed.cicril.sbcglobal.net. [104.51.28.62])
        by smtp.googlemail.com with ESMTPSA id v10sm16487537iob.43.2019.08.19.07.27.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 07:27:24 -0700 (PDT)
From:   "Steven J. Magnani" <steve.magnani@digidescorp.com>
X-Google-Original-From: "Steven J. Magnani" <steve@digidescorp.com>
To:     Jan Kara <jack@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Steven J . Magnani" <steve@digidescorp.com>
Subject: [PATCH] udf: augment owner permissions on new inodes
Date:   Mon, 19 Aug 2019 09:27:07 -0500
Message-Id: <20190819142707.18070-1-steve@digidescorp.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Windows presents files created within Linux as read-only, even when
permissions in Linux indicate the file should be writable.


UDF defines a slightly different set of basic file permissions than Linux.
Specifically, UDF has "delete" and "change attribute" permissions for each
access class (user/group/other). Linux has no equivalents for these.

When the Linux UDF driver creates a file (or directory), no UDF delete or
change attribute permissions are granted. The lack of delete permission
appears to cause Windows to mark an item read-only when its permissions
otherwise indicate that it should be read-write.

Fix this by granting UDF delete and change attribute permissions
to the owner when creating a new inode.

Reported by: Ty Young
Signed-off-by: Steven J. Magnani <steve@digidescorp.com>
---
--- a/fs/udf/udf_i.h	2019-08-14 07:24:05.029508342 -0500
+++ b/fs/udf/udf_i.h	2019-08-19 08:55:37.797394177 -0500
@@ -38,6 +38,7 @@ struct udf_inode_info {
 	__u32			i_next_alloc_block;
 	__u32			i_next_alloc_goal;
 	__u32			i_checkpoint;
+	__u32			i_extraPerms;
 	unsigned		i_alloc_type : 3;
 	unsigned		i_efe : 1;	/* extendedFileEntry */
 	unsigned		i_use : 1;	/* unallocSpaceEntry */
--- a/fs/udf/ialloc.c	2019-08-14 07:24:05.029508342 -0500
+++ b/fs/udf/ialloc.c	2019-08-19 08:33:08.992422457 -0500
@@ -118,6 +118,7 @@ struct inode *udf_new_inode(struct inode
 	iinfo->i_lenAlloc = 0;
 	iinfo->i_use = 0;
 	iinfo->i_checkpoint = 1;
+	iinfo->i_extraPerms = FE_PERM_U_DELETE | FE_PERM_U_CHATTR;
 	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_AD_IN_ICB))
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 	else if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
--- a/fs/udf/inode.c	2019-08-14 07:24:05.029508342 -0500
+++ b/fs/udf/inode.c	2019-08-19 08:42:46.537530051 -0500
@@ -45,6 +45,10 @@
 
 #define EXTENT_MERGE_SIZE 5
 
+#define FE_MAPPED_PERMS	(FE_PERM_U_READ | FE_PERM_U_WRITE | FE_PERM_U_EXEC | \
+			 FE_PERM_G_READ | FE_PERM_G_WRITE | FE_PERM_G_EXEC | \
+			 FE_PERM_O_READ | FE_PERM_O_WRITE | FE_PERM_O_EXEC)
+
 static umode_t udf_convert_permissions(struct fileEntry *);
 static int udf_update_inode(struct inode *, int);
 static int udf_sync_inode(struct inode *inode);
@@ -1458,6 +1462,8 @@ reread:
 	else
 		inode->i_mode = udf_convert_permissions(fe);
 	inode->i_mode &= ~sbi->s_umask;
+	iinfo->i_extraPerms = le32_to_cpu(fe->permissions) & ~FE_MAPPED_PERMS;
+
 	read_unlock(&sbi->s_cred_lock);
 
 	link_count = le16_to_cpu(fe->fileLinkCount);
@@ -1691,10 +1697,7 @@ static int udf_update_inode(struct inode
 		   ((inode->i_mode & 0070) << 2) |
 		   ((inode->i_mode & 0700) << 4);
 
-	udfperms |= (le32_to_cpu(fe->permissions) &
-		    (FE_PERM_O_DELETE | FE_PERM_O_CHATTR |
-		     FE_PERM_G_DELETE | FE_PERM_G_CHATTR |
-		     FE_PERM_U_DELETE | FE_PERM_U_CHATTR));
+	udfperms |= iinfo->i_extraPerms;
 	fe->permissions = cpu_to_le32(udfperms);
 
 	if (S_ISDIR(inode->i_mode) && inode->i_nlink > 0)
