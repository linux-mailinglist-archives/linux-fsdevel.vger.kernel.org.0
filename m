Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6F5BEDDD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 21:36:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231511AbiITTgx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 15:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbiITTgq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:36:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDB076456
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663702604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BsXdvDdXKGBsyyVjzb1UKYoyRx8HM75Tqi022HaH4Io=;
        b=DHNtgamZzpgTr9FXhAB4SL1hL7nJ7chHjlbKZanQJ/ct3WC/lv/FbQ65PpkfPuCHiu0r13
        E1ksFtqkluH4PhWot3NcLB51aiq5QsAlaoCsKzsk6P3ria5RI4qlhmMs81x+fQiZoU8yqB
        9+u4pmycK4maabN5THbJiWNZVoDKzcQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-456-S4DHOuILM92XV_6GeN8NXQ-1; Tue, 20 Sep 2022 15:36:40 -0400
X-MC-Unique: S4DHOuILM92XV_6GeN8NXQ-1
Received: by mail-ed1-f72.google.com with SMTP id w20-20020a05640234d400b00450f24c8ca6so2589221edc.13
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Sep 2022 12:36:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=BsXdvDdXKGBsyyVjzb1UKYoyRx8HM75Tqi022HaH4Io=;
        b=wMKTmu3FRt/8s/sC6q8fr9ufT2WnbEapQsIU/Qjcs4SotWu7BuYyMc1uTEQODnhVXa
         FSByVwPfLYuztRM4zdfuFoKKydemXJ/C4MS0O++1D5HHYALCM+lmH8FkEXEIZTzHzzM1
         gzNb7Y1aMRwBDbsPYbl77NzOIeayRoYR7p+nGpljyLAEd3UHfb5faM/K7CUb2rA8NZgl
         Yjd73chFsRTurscIm4g1ZlN5Yfh2z09yyADqzhSEFtkz1nG2BLSVMtRGAsnjQjgY9t8x
         i4GKlH+wh16wseVuhwGZFqihKtRk2TlYhovCwy0O4R1GVv8+itofbUDPVEmzaA46hmp0
         26VA==
X-Gm-Message-State: ACrzQf1Mw6Lemr77nC4qsZW55egX9p9W2ZJH5dhwOMvq0B+dCCbyc67w
        gcZThEuIwsB5eLxRMOH9Qcz8ES3QxZTUaJeooFNNTqoQQL82GwQ/Ug0AFfwOESYAeSNmYtcAZPQ
        m3orK4jByQ5xXh4YnvNeiUm40lv0fuM3mWCGwUVA7jcmaFAPWhTda4c95fAtUvPC41BwIhKbOPf
        8BpQ==
X-Received: by 2002:a05:6402:1cad:b0:454:50c2:e837 with SMTP id cz13-20020a0564021cad00b0045450c2e837mr6821241edb.171.1663702598684;
        Tue, 20 Sep 2022 12:36:38 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM6sBVdy61J4KEw+AT4MdFfrPrGZTlMqcnQ32YAP1o0BZcaiE2db5rSnxcP9m21E/br0uD3YeQ==
X-Received: by 2002:a05:6402:1cad:b0:454:50c2:e837 with SMTP id cz13-20020a0564021cad00b0045450c2e837mr6821222edb.171.1663702598518;
        Tue, 20 Sep 2022 12:36:38 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (193-226-214-223.pool.digikabel.hu. [193.226.214.223])
        by smtp.gmail.com with ESMTPSA id p5-20020aa7d305000000b0045184540cecsm391821edq.36.2022.09.20.12.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 12:36:38 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Al Viro <viro@ZenIV.linux.org.uk>,
        Amir Goldstein <amir73il@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Yu-li Lin <yulilin@google.com>,
        Chirantan Ekbote <chirantan@chromium.org>
Subject: [PATCH v3 4/9] cachefiles: use tmpfile_open() helper
Date:   Tue, 20 Sep 2022 21:36:27 +0200
Message-Id: <20220920193632.2215598-5-mszeredi@redhat.com>
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

