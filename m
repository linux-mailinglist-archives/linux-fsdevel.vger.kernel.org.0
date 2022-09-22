Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FED85E5DC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Sep 2022 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbiIVIpW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Sep 2022 04:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiIVIo7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:44:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDB9A0247
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663836291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pNJWIfJSeZg6QdnpOp0Q5fhm9Bpczx3RBHL8ibawlzI=;
        b=anPFyOzksUSnROa9/p3Zc+vM0tnHCbNfnpczDka12wQDKAjZTCGuEm0kpG+M86lgo3xKHo
        aXCRPyx0S1oeHmfPN1u9wJ1C78gxAHhObBEj9c1LJlSPrRrxEx9lstLHsydk7vXA/HLLjr
        ShOQGTWjxGT6qnxZQIQISYhLN8SKtwA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-241-UjjHf6czO5-1jxOsXg2bBg-1; Thu, 22 Sep 2022 04:44:50 -0400
X-MC-Unique: UjjHf6czO5-1jxOsXg2bBg-1
Received: by mail-ej1-f70.google.com with SMTP id hr12-20020a1709073f8c00b0077e8371f847so4234169ejc.20
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Sep 2022 01:44:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=pNJWIfJSeZg6QdnpOp0Q5fhm9Bpczx3RBHL8ibawlzI=;
        b=4Y1VFMNk/KxcgD6kdaV/Ebmth0QHQ/UwR2ja6RIfORGoFpo/kopdLM/l8cCRCfurBl
         eiJjff844SHbX7TK+OGAY3XN5mianvXuRVv5MVq3exfQArx7z1SRs7kzeH0ZeGO9ATIE
         +KA2KQ75bzze2PqSKQgdxiyeQAizAIJzCG1PLXHPKy/Po4Hz/DyGHBh9C/2wYoXWKhqT
         T4jVYzriMXWCmSojqaAUiPdyr8S6PsDmZDLAyGwrPnnlQ3GDRXr22/TN3r5zYtWDX4BH
         E8w7PVwbT7gspZ3iuZRHZIvGeAU8hCV6MZ8tL61rja5pg7kfEB6F/ni+A01nur/nCXPS
         qj9A==
X-Gm-Message-State: ACrzQf3WySDMCG7OkCF36xh2fN/Mbi4fjoVeXAjICEAHNNPptBs8JJ1O
        a0XxIJAOuEddDo9BV5RewL5sB+x3JhH/dY9ei8J1q/QvK41Ma2kBXyyoPld4LhVQaxWzd6osGBO
        Ie55YNbve74ORNiZsGztO8a+NSjiuSK2na9nCNtu+zDfM1SOCfUM3g474cNU2wSVePVRLUCm0Ne
        F9tw==
X-Received: by 2002:a17:907:960e:b0:782:68e3:620f with SMTP id gb14-20020a170907960e00b0078268e3620fmr487523ejc.663.1663836289113;
        Thu, 22 Sep 2022 01:44:49 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM41kuSs0ywXc/KeQPJA/EndPAQ7NsfRy75GYDPZW8027PY9PEd7FtuzpSW8th8Yt1odwDMhnA==
X-Received: by 2002:a17:907:960e:b0:782:68e3:620f with SMTP id gb14-20020a170907960e00b0078268e3620fmr487499ejc.663.1663836288829;
        Thu, 22 Sep 2022 01:44:48 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id h15-20020a170906718f00b00730b3bdd8d7sm2297942ejk.179.2022.09.22.01.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Sep 2022 01:44:48 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v4 04/10] cachefiles: only pass inode to *mark_inode_inuse() helpers
Date:   Thu, 22 Sep 2022 10:44:36 +0200
Message-Id: <20220922084442.2401223-5-mszeredi@redhat.com>
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

The only reason to pass dentry was because of a pr_notice() text.  Move
that to the two callers where it makes sense and add a WARN_ON() to the
third.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/cachefiles/namei.c | 47 ++++++++++++++++++++-----------------------
 1 file changed, 22 insertions(+), 25 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d3a5884fe5c9..4d04f5fb49f3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -15,9 +15,8 @@
  * file or directory.  The caller must hold the inode lock.
  */
 static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
-					   struct dentry *dentry)
+					   struct inode *inode)
 {
-	struct inode *inode = d_backing_inode(dentry);
 	bool can_use = false;
 
 	if (!(inode->i_flags & S_KERNEL_FILE)) {
@@ -26,21 +25,18 @@ static bool __cachefiles_mark_inode_in_use(struct cachefiles_object *object,
 		can_use = true;
 	} else {
 		trace_cachefiles_mark_failed(object, inode);
-		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
-			  dentry, inode->i_ino);
 	}
 
 	return can_use;
 }
 
 static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
-					 struct dentry *dentry)
+					 struct inode *inode)
 {
-	struct inode *inode = d_backing_inode(dentry);
 	bool can_use;
 
 	inode_lock(inode);
-	can_use = __cachefiles_mark_inode_in_use(object, dentry);
+	can_use = __cachefiles_mark_inode_in_use(object, inode);
 	inode_unlock(inode);
 	return can_use;
 }
@@ -49,21 +45,17 @@ static bool cachefiles_mark_inode_in_use(struct cachefiles_object *object,
  * Unmark a backing inode.  The caller must hold the inode lock.
  */
 static void __cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
-					     struct dentry *dentry)
+					     struct inode *inode)
 {
-	struct inode *inode = d_backing_inode(dentry);
-
 	inode->i_flags &= ~S_KERNEL_FILE;
 	trace_cachefiles_mark_inactive(object, inode);
 }
 
 static void cachefiles_do_unmark_inode_in_use(struct cachefiles_object *object,
-					      struct dentry *dentry)
+					      struct inode *inode)
 {
-	struct inode *inode = d_backing_inode(dentry);
-
 	inode_lock(inode);
-	__cachefiles_unmark_inode_in_use(object, dentry);
+	__cachefiles_unmark_inode_in_use(object, inode);
 	inode_unlock(inode);
 }
 
@@ -78,7 +70,7 @@ void cachefiles_unmark_inode_in_use(struct cachefiles_object *object,
 	struct inode *inode = file_inode(file);
 
 	if (inode) {
-		cachefiles_do_unmark_inode_in_use(object, file->f_path.dentry);
+		cachefiles_do_unmark_inode_in_use(object, file_inode(file));
 
 		if (!test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags)) {
 			atomic_long_add(inode->i_blocks, &cache->b_released);
@@ -164,8 +156,11 @@ struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 	inode_lock(d_inode(subdir));
 	inode_unlock(d_inode(dir));
 
-	if (!__cachefiles_mark_inode_in_use(NULL, subdir))
+	if (!__cachefiles_mark_inode_in_use(NULL, d_inode(subdir))) {
+		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
+			  subdir, d_inode(subdir)->i_ino);
 		goto mark_error;
+	}
 
 	inode_unlock(d_inode(subdir));
 
@@ -225,7 +220,7 @@ void cachefiles_put_directory(struct dentry *dir)
 {
 	if (dir) {
 		inode_lock(dir->d_inode);
-		__cachefiles_unmark_inode_in_use(NULL, dir);
+		__cachefiles_unmark_inode_in_use(NULL, d_inode(dir));
 		inode_unlock(dir->d_inode);
 		dput(dir);
 	}
@@ -410,7 +405,7 @@ int cachefiles_bury_object(struct cachefiles_cache *cache,
 					    "Rename failed with error %d", ret);
 	}
 
-	__cachefiles_unmark_inode_in_use(object, rep);
+	__cachefiles_unmark_inode_in_use(object, d_inode(rep));
 	unlock_rename(cache->graveyard, dir);
 	dput(grave);
 	_leave(" = 0");
@@ -474,9 +469,9 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
 
-	ret = -EBUSY;
-	if (!cachefiles_mark_inode_in_use(object, path.dentry))
-		goto err_dput;
+	/* This is a newly created file with no other possible user */
+	if (!cachefiles_mark_inode_in_use(object, d_inode(path.dentry)))
+		WARN_ON(1);
 
 	ret = cachefiles_ondemand_init_object(object);
 	if (ret < 0)
@@ -520,8 +515,7 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	return file;
 
 err_unuse:
-	cachefiles_do_unmark_inode_in_use(object, path.dentry);
-err_dput:
+	cachefiles_do_unmark_inode_in_use(object, d_inode(path.dentry));
 	dput(path.dentry);
 err:
 	file = ERR_PTR(ret);
@@ -566,8 +560,11 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 
 	_enter("%pd", dentry);
 
-	if (!cachefiles_mark_inode_in_use(object, dentry))
+	if (!cachefiles_mark_inode_in_use(object, d_inode(dentry))) {
+		pr_notice("cachefiles: Inode already in use: %pd (B=%lx)\n",
+			  dentry, d_inode(dentry)->i_ino);
 		return false;
+	}
 
 	/* We need to open a file interface onto a data file now as we can't do
 	 * it on demand because writeback called from do_exit() sees
@@ -621,7 +618,7 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 error_fput:
 	fput(file);
 error:
-	cachefiles_do_unmark_inode_in_use(object, dentry);
+	cachefiles_do_unmark_inode_in_use(object, d_inode(dentry));
 	dput(dentry);
 	return false;
 }
-- 
2.37.3

