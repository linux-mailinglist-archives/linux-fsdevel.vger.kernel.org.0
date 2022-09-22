Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 613BF5E5DC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiIVIpE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbiIVIo5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:44:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E028A0267
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836290;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x8lUJ3SpIV4mlVs/JuPNx0a+WWSeeA9bZCgVmcay4M8=;
        b=YQv7Jf3x792gVe8FyvXFdh8UkWCQ88XyPiAWNK0Isu9uMDyxpsmfJWTer27g+Z/aA3KpJZ
        vcTwZK7ivFplZcCWYaEwQuKsZys22PO4C6trGCgE+ddqSj1XtF1qL+wE9d4Hx7kiposupQ
        Bs1wsqe8Ktskp12idYYRAmqfFbZhGeA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-594-m5vb3ALKNPmz1ZVJtRoG0Q-1; Thu, 22 Sep 2022 04:44:48 -0400
X-MC-Unique: m5vb3ALKNPmz1ZVJtRoG0Q-1
Received: by mail-ed1-f70.google.com with SMTP id e15-20020a056402190f00b0044f41e776a0so6166205edz.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=x8lUJ3SpIV4mlVs/JuPNx0a+WWSeeA9bZCgVmcay4M8=;
        b=iniMokm3bvxnnkCsuB3+cXxfOXz/n1ClWFCpG2CohnPTds6No9VMEZXWomog5RD1NC
         XKzjIr3cb/TqO0zMwLFeG9QqhXrGTUXnFBGq53LT95LHj5REKtOltybvSMfC2O4pARj1
         qbiAFiT3/7BzZz9S8nHSJWp9oxBP2fN8flHJfhOnZP5QJG8Ao0m64G/GcAp9jnwIVXUw
         tEXKpR0Hk0RVx/nmV1TPtt1dk61YwCBrpb/HjWapFJTQCNXoArDQAz4vq2PZNjztKKh/
         8FclWnX1RYAYQV2hib9MtOIeRPbk8hU3fPP/E04lWaMvMeGkvBzUA7F75YB9ezVZM5Bf
         hiDg==
X-Gm-Message-State: ACrzQf2eXEgoUP0w3DuIAw2DqN7vjq+ES22RsLsEZZJ2bpKXZjl8rc18
        kWw/pVmqTJ2/5oIHuWXxVk9sl2MJr/MrlCWNG6X4W3oXZwxUn5CoD8DVrtpiXCT2rFs2GQJTXfT
        A1Hq02nURfaY09Hs3rYufXDj4sqr7m2yYTCWGDUUh1c0/rMUmQWBOtkJjxwJAoqZsPtgacd4GGa
        RCFA==
X-Received: by 2002:aa7:c382:0:b0:454:9591:79fe with SMTP id k2-20020aa7c382000000b00454959179femr2148300edq.253.1663836286904;
        Thu, 22 Sep 2022 01:44:46 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6eFjvyOJxrjK/S38FYT1FYsFoor5/NPGXCzHHhjnyD6Ze1SbQt0l1+KG0NK5RrnzdaqH43Jw==
X-Received: by 2002:aa7:c382:0:b0:454:9591:79fe with SMTP id k2-20020aa7c382000000b00454959179femr2148282edq.253.1663836286703;
        Thu, 22 Sep 2022 01:44:46 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:46 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 02/10] hugetlbfs: cleanup mknod and tmpfile
Date:   Thu, 22 Sep 2022 10:44:34 +0200
Message-Id: <20220922084442.2401223-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220922084442.2401223-1-mszeredi@redhat.com>
References: <20220922084442.2401223-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Duplicate the few lines that are shared between hugetlbfs_mknod() and
hugetlbfs_tmpfile().

This is a prerequisite for sanely changing the signature of ->tmpfile().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/hugetlbfs/inode.c | 40 ++++++++++++++++------------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index f7a5b5124d8a..0b458beb318c 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -885,33 +885,18 @@ static struct inode *hugetlbfs_get_inode(struct super_block *sb,
 /*
  * File creation. Allocate an inode, and we're done..
  */
-static int do_hugetlbfs_mknod(struct inode *dir,
-			struct dentry *dentry,
-			umode_t mode,
-			dev_t dev,
-			bool tmpfile)
+static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
+			   struct dentry *dentry, umode_t mode, dev_t dev)
 {
 	struct inode *inode;
-	int error = -ENOSPC;
 
 	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode, dev);
-	if (inode) {
-		dir->i_ctime = dir->i_mtime = current_time(dir);
-		if (tmpfile) {
-			d_tmpfile(dentry, inode);
-		} else {
-			d_instantiate(dentry, inode);
-			dget(dentry);/* Extra count - pin the dentry in core */
-		}
-		error = 0;
-	}
-	return error;
-}
-
-static int hugetlbfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
-			   struct dentry *dentry, umode_t mode, dev_t dev)
-{
-	return do_hugetlbfs_mknod(dir, dentry, mode, dev, false);
+	if (!inode)
+		return -ENOSPC;
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	d_instantiate(dentry, inode);
+	dget(dentry);/* Extra count - pin the dentry in core */
+	return 0;
 }
 
 static int hugetlbfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
@@ -935,7 +920,14 @@ static int hugetlbfs_tmpfile(struct user_namespace *mnt_userns,
 			     struct inode *dir, struct dentry *dentry,
 			     umode_t mode)
 {
-	return do_hugetlbfs_mknod(dir, dentry, mode | S_IFREG, 0, true);
+	struct inode *inode;
+
+	inode = hugetlbfs_get_inode(dir->i_sb, dir, mode | S_IFREG, 0);
+	if (!inode)
+		return -ENOSPC;
+	dir->i_ctime = dir->i_mtime = current_time(dir);
+	d_tmpfile(dentry, inode);
+	return 0;
 }
 
 static int hugetlbfs_symlink(struct user_namespace *mnt_userns,
-- 
2.37.3

