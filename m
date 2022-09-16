Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873BB5BB2F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Sep 2022 21:44:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiIPTo0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Sep 2022 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiIPToX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Sep 2022 15:44:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210DBB40F4
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663357462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsXdvDdXKGBsyyVjzb1UKYoyRx8HM75Tqi022HaH4Io=;
        b=RhJj8DXi9bfpSJjoFEOuasvgtddJJX/UrdUZmsymQCvg1kPtwewKjGXX+ThUWVdbkpFdIi
        ZKZTZqsJaBJMPrWXLPbqh+YGlgFHpzMRxRwJsTgKwkm+32BLq/zBN60nWviRnx+UBVi7eW
        3IUDRuYBB/VCN+kHT8tyaBcU+Rs8KeQ=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-570-fJJp4ytXM_WMLTMWc_pMJw-1; Fri, 16 Sep 2022 15:44:21 -0400
X-MC-Unique: fJJp4ytXM_WMLTMWc_pMJw-1
Received: by mail-ej1-f69.google.com with SMTP id qa33-20020a17090786a100b0077a69976d24so8694188ejc.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 16 Sep 2022 12:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BsXdvDdXKGBsyyVjzb1UKYoyRx8HM75Tqi022HaH4Io=;
        b=SqgZ8pfjq35SN0Ate46SbkbZFi6EFpnMFDP4H/tHACAY6iVQeGuty9RvxaE0Nm+PSu
         Bp1FSRCsP1OEijK1qUsjpsZg02XeFCZl4HHeloEtYhfh6LicuEjHcN27ZzYi/HW7nD4X
         vdocB2qZ5JUCHe/NdyUZd4kX2obhterh8XfxtsRV7N3yjlyFc7n4S35QLW9DY0xT+wan
         tXPj1osKEpNebvI2biqXwDYoz4kPP++B9l2kAH2qxTlg3UPCDkxvphBZ46zC+atKq1v4
         dgse7v9fxYuMcJDkJCBcPFtUvVFYdeKtOnhgOR8+2JcKB0aRHCLywUrwT8BewsHEsDbL
         ZcTA==
X-Gm-Message-State: ACrzQf1KYIj+IxBvNq7QsLWDW6+7b/+Ua3HSjAsGmGgdO5pCNeoYQLq5
        5/ic7bpP4WiCaR6kWSx4o6xiQe0YVXwHiqQIwTEUwmSTezbsg9k1Ok/nr/HSAF9u8nmPPeecZVJ
        1cU4ywyzvQB9qgQq5QQBjsVSkTVf0mD0M0ll5xCIZVAywczPEqkh9sbpT5iBvJg+gePgyMaS48J
        aVLQ==
X-Received: by 2002:a05:6402:4150:b0:44a:ec16:def4 with SMTP id x16-20020a056402415000b0044aec16def4mr5270388eda.21.1663357459848;
        Fri, 16 Sep 2022 12:44:19 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7Qc0qV0zLQ3LBk0Ml3fEK9PsWdt4VgNc7Vz9c/dRs5RTZarGFttSj96CLSMlGRiJ/3JEnGvg==
X-Received: by 2002:a05:6402:4150:b0:44a:ec16:def4 with SMTP id x16-20020a056402415000b0044aec16def4mr5270372eda.21.1663357459615;
        Fri, 16 Sep 2022 12:44:19 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-212-116.pool.digikabel.hu. [193.226.212.116])
        by smtp.gmail.com with ESMTPSA id r17-20020a17090609d100b0077ce503bd77sm8348592eje.129.2022.09.16.12.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 12:44:19 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH 3/8] cachefiles: use tmpfile_open() helper
Date:   Fri, 16 Sep 2022 21:44:11 +0200
Message-Id: <20220916194416.1657716-3-mszeredi@redhat.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220916194416.1657716-1-mszeredi@redhat.com>
References: <20220916194416.1657716-1-mszeredi@redhat.com>
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

Use the tmpfile_open() helper instead of doing tmpfile creation and opening
separately.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/cachefiles/namei.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d3a5884fe5c9..44f575328af4 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -451,18 +451,19 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 	const struct cred *saved_cred;
 	struct dentry *fan = volume->fanout[(u8)object->cookie->key_hash];
 	struct file *file;
-	struct path path;
+	struct path path = { .mnt = cache->mnt, .dentry = fan };
 	uint64_t ni_size;
 	long ret;
 
 
 	cachefiles_begin_secure(cache, &saved_cred);
 
-	path.mnt = cache->mnt;
 	ret = cachefiles_inject_write_error();
 	if (ret == 0) {
-		path.dentry = vfs_tmpfile(&init_user_ns, fan, S_IFREG, O_RDWR);
-		ret = PTR_ERR_OR_ZERO(path.dentry);
+		file = tmpfile_open(&init_user_ns, &path, S_IFREG,
+				    O_RDWR | O_LARGEFILE | O_DIRECT,
+				    cache->cache_cred);
+		ret = PTR_ERR_OR_ZERO(file);
 	}
 	if (ret) {
 		trace_cachefiles_vfs_error(object, d_inode(fan), ret,
@@ -471,12 +472,14 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 			cachefiles_io_error_obj(object, "Failed to create tmpfile");
 		goto err;
 	}
+	/* From now path refers to the tmpfile */
+	path.dentry = file->f_path.dentry;
 
 	trace_cachefiles_tmpfile(object, d_backing_inode(path.dentry));
 
 	ret = -EBUSY;
 	if (!cachefiles_mark_inode_in_use(object, path.dentry))
-		goto err_dput;
+		goto err_fput;
 
 	ret = cachefiles_ondemand_init_object(object);
 	if (ret < 0)
@@ -499,14 +502,6 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		}
 	}
 
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DIRECT,
-				   d_backing_inode(path.dentry), cache->cache_cred);
-	ret = PTR_ERR(file);
-	if (IS_ERR(file)) {
-		trace_cachefiles_vfs_error(object, d_backing_inode(path.dentry),
-					   ret, cachefiles_trace_open_error);
-		goto err_unuse;
-	}
 	ret = -EINVAL;
 	if (unlikely(!file->f_op->read_iter) ||
 	    unlikely(!file->f_op->write_iter)) {
@@ -514,15 +509,14 @@ struct file *cachefiles_create_tmpfile(struct cachefiles_object *object)
 		pr_notice("Cache does not support read_iter and write_iter\n");
 		goto err_unuse;
 	}
-	dput(path.dentry);
 out:
 	cachefiles_end_secure(cache, saved_cred);
 	return file;
 
 err_unuse:
 	cachefiles_do_unmark_inode_in_use(object, path.dentry);
-err_dput:
-	dput(path.dentry);
+err_fput:
+	fput(file);
 err:
 	file = ERR_PTR(ret);
 	goto out;
-- 
2.37.3

