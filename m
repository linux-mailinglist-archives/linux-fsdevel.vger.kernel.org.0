Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26B645BEDD9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiITTgm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiITTgk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB0C8760EC
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PzsiJLh4qivuvaD01T8k0cktWemsb5i0yo5HxUE+jT4=;
        b=LF/H4kPiuddwRzNquS8ESCxRpc5mjnm3KmVrpodPKTO3Gs2VldNjLnUV3h3u9y9Ot/Skg2
        yEb9PGqTZnATHV/DRByJYNzqjCMMkEiFQk5qZvhhs/vPxMVV2b5PzoKloAz7uMCHJ56EIE
        55nrEep8W3cna0sq4C4jZewp/vs8rxI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-595-f3st1iATNoaCLLUcS8O32A-1; Tue, 20 Sep 2022 15:36:36 -0400
X-MC-Unique: f3st1iATNoaCLLUcS8O32A-1
Received: by mail-ed1-f71.google.com with SMTP id y14-20020a056402440e00b0044301c7ccd9so2579520eda.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=PzsiJLh4qivuvaD01T8k0cktWemsb5i0yo5HxUE+jT4=;
        b=wQKIKBiyv2eKI7EzSUzpMMRmvthFaHr8Sbo/E08nd7gqPszPA2/SrfjRrDxIc7O1xm
         0Psm6/RarTbEc0XOrDNfS/91IfO/4Ui5FuG9jwwxwEledna9L0s14cXWkDlJHRAfCcMx
         xiUm0lL2lqItn1ca5QPPrEQHjvNUCJdOSXNbrL1YcmWyPiLKavwPgIE1KKiZNhUQIwTE
         CNGKQ0X3ARrmokC04+RZjvn5DosOPvdRLDm9uHli2XcMVICcCGc+JoOYnJgYwG/g3Jv1
         vgf0LvGGukM6Z13QSvXlStTM7SWw/o6mZVjl+S1zb15RQiUMo1vUZmhpnLCrVB3I/y4m
         AByg==
X-Gm-Message-State: ACrzQf1mIfITWxvHMFJJvyftfJhdyBe7TRbQnvaz7C8ams2EHKeGm3NY
        GLlt2Eho0sJ0sFhqz9gyr97Xsj2zSqkrX4vS8eNTnTpOiiEXVG+V7iVmV8pjyrQzwjaNSzzSeTe
        HTOGEbvTid2LcyKe9YST6G6MmsX0j5WpUxaQXipPY+WOoiX1TKZEJtvOabNowHqN3ZJTQB4FcGM
        A13A==
X-Received: by 2002:a05:6402:3892:b0:454:37c8:6247 with SMTP id fd18-20020a056402389200b0045437c86247mr8611521edb.307.1663702595102;
        Tue, 20 Sep 2022 12:36:35 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6vVov/hp9JEbB9wFSILRKW94GSuoHVxb0JRTbVQnZ/LAVrOIowlb6ZXdj4imc1Gue5fp2BIQ==
X-Received: by 2002:a05:6402:3892:b0:454:37c8:6247 with SMTP id fd18-20020a056402389200b0045437c86247mr8611502edb.307.1663702594900;
        Tue, 20 Sep 2022 12:36:34 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:34 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 1/9] cachefiles: tmpfile error handling cleanup
Date:   Tue, 20 Sep 2022 21:36:24 +0200
Message-Id: <20220920193632.2215598-2-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220920193632.2215598-1-mszeredi@redhat.com>
References: <20220920193632.2215598-1-mszeredi@redhat.com>
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

Separate the error labels from the success path and use 'ret' to store the
error value before jumping to the error label.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/cachefiles/namei.c | 55 ++++++++++++++++++++-----------------------
 1 file changed, 26 insertions(+), 29 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index facf2ebe464b..d3a5884fe5c9 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -460,31 +460,27 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 
 	path.mnt = cache->mnt;
 	ret = cachefiles_inject_write_error();
-	if (ret == 0)
+	if (ret == 0) {
 		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
-	else
-		path.dentry = ERR_PTR(ret);
-	if (IS_ERR(path.dentry)) {
-		trace_cachefiles_vfs_error(object, d_inode(fan), PTR_ERR(path.dentry),
+		ret = PTR_ERR_OR_ZERO(path.dentry);
+	}
+	if (ret) {
+		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
 					   cachefiles_trace_tmpfile_error);
-		if (PTR_ERR(path.dentry) == -EIO)
+		if (ret == -EIO)
 			cachefiles_io_error_obj(object, "Failed to create tmpfile");
-		file = ERR_CAST(path.dentry);
-		goto out;
+		goto err;
 	}
 
 	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
 
-	if (!cachefiles_mark_inode_in_use(object, path.dentry)) {
-		file = ERR_PTR(-EBUSY);
-		goto out_dput;
-	}
+	ret = -EBUSY;
+	if (!cachefiles_mark_inode_in_use(object, path.dentry))
+		goto err_dput;
 
 	ret = cachefiles_ondemand_init_object(object);
-	if (ret < 0) {
-		file = ERR_PTR(ret);
-		goto out_unuse;
-	}
+	if (ret < 0)
+		goto err_unuse;
 
 	ni_size = object->cookie->object_size;
 	ni_size = round_up(ni_size, CACHEFILES_DIO_BLOCK_SIZE);
@@ -499,36 +495,37 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 			trace_cachefiles_vfs_error(
 				object, d_backing_inode(path.dentry), ret,
 				cachefiles_trace_trunc_error);
-			file = ERR_PTR(ret);
-			goto out_unuse;
+			goto err_unuse;
 		}
 	}
 
 	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
 				   d_backing_inode(path.dentry), cache->cache_cred);
+	ret = PTR_ERR(file);
 	if (IS_ERR(file)) {
 		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
-					   PTR_ERR(file),
-					   cachefiles_trace_open_error);
-		goto out_unuse;
+					   ret, cachefiles_trace_open_error);
+		goto err_unuse;
 	}
+	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
 		fput(file);
 		pr_notice("Cache does not support read_iter and write_iter\n");
-		file = ERR_PTR(-EINVAL);
-		goto out_unuse;
+		goto err_unuse;
 	}
-
-	goto out_dput;
-
-out_unuse:
-	cachefiles_do_unmark_inode_in_use(object, path.dentry);
-out_dput:
 	dput(path.dentry);
 out:
 	cachefiles_end_secure(cache, saved_cred);
 	return file;
+
+err_unuse:
+	cachefiles_do_unmark_inode_in_use(object, path.dentry);
+err_dput:
+	dput(path.dentry);
+err:
+	file = ERR_PTR(ret);
+	goto out;
 }
 
 /*
-- 
2.37.3

