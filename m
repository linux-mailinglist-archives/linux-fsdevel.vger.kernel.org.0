Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8787D54C171
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jun 2022 08:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbiFOF6l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jun 2022 01:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245729AbiFOF6X (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:58:23 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8102B263
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 22:58:22 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id e11so10498274pfj.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jun 2022 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tPn/OX+JIs9R97iZ60NxPN/VK7IIuBnd/MtJJuDV6Lk=;
        b=Aj1TV0XyYYp4eoe68JfisVh3+RUfmS6CHqpCb9YrQ4KGKQoVIujwyd3Ozd7gZnZZmD
         k7b4yGKZYgFrlI0j5kjcm9HqTqp3lEyh7u/0rtLoO5SiRfWEW0Bg9xJapSuDfN3Usnun
         BdkKODFv1F58tYZ4p10f6Le1EtNa7cQvCMoALPwHElKP2Drw313m1+//wXs+UVQbnQT3
         Wxn/9FfX7q+LiVrcUpKjI08SseccOEHVMNibZD8Zg/DGdVFKBKf6XagiuZJQX+zciuUM
         2DrBq0FmkJYoKkPl345eO3pHO3+t0pkFRZsfYMV66WimA1kayJ9MF317VTaVVsdKtuEG
         DvWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPn/OX+JIs9R97iZ60NxPN/VK7IIuBnd/MtJJuDV6Lk=;
        b=eUypkPrhOry5zdNhGgJ4kesI5RaU57QnywiFTi+bCZZ8MhJSt9fN3EgV3O1VAXi++V
         mSWfGzrYTcvxiECJBgHxPM21dymAvLJEqiVY3kEvAEUI115KVcDYaXk7M6hDFwotd1Vv
         /5GGXTqZLL0cvtjQJicOPCi9axuBTWzUpfpUZznSNxXqDKkYWjp/lVPW86xUBFoRdmGT
         edx9XNRhjna/fB4n5ePGIDaFIwVbR/N7DdP4+tADGEvsC3wDS9PWshdv/Ug7A3rjAjja
         TXzd79hYLnB0ABqs2CMvkamyAmdPCJD4gFhkvRzwne81fliGnkqT06mUXGWBn6hoH4zG
         cHyw==
X-Gm-Message-State: AOAM532CSelrH9rsOgIeKG1DZy1BPtRLlBT+l0KQmjOI4gS+zUPyzvgT
        XMHzfdWUO6nJsAlBIlBSB2xw
X-Google-Smtp-Source: ABdhPJwW3AK6JhouZ9PDoNa3SHDDblP7i9g2ZGdZrbRU/wzbFvVHRolpzZ6pfubk1rCuY4EfDyiPew==
X-Received: by 2002:a05:6a00:842:b0:51b:f289:7354 with SMTP id q2-20020a056a00084200b0051bf2897354mr8282253pfk.75.1655272702157;
        Tue, 14 Jun 2022 22:58:22 -0700 (PDT)
Received: from localhost ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id x29-20020aa79add000000b0051b9912889csm8657827pfp.101.2022.06.14.22.58.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 22:58:20 -0700 (PDT)
From:   Xie Yongji <xieyongji@bytedance.com>
To:     miklos@szeredi.hu, vgoyal@redhat.com, stefanha@redhat.com
Cc:     zhangjiachen.jaycee@bytedance.com, linux-fsdevel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v2 1/2] fuse: Remove unused "no_control" related code
Date:   Wed, 15 Jun 2022 13:57:54 +0800
Message-Id: <20220615055755.197-2-xieyongji@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615055755.197-1-xieyongji@bytedance.com>
References: <20220615055755.197-1-xieyongji@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This gets rid of "no_control" related code since
nobody uses it.

Signed-off-by: Xie Yongji <xieyongji@bytedance.com>
---
 fs/fuse/fuse_i.h    | 4 ----
 fs/fuse/inode.c     | 1 -
 fs/fuse/virtio_fs.c | 1 -
 3 files changed, 6 deletions(-)

diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 488b460e046f..a47f14d0ee3f 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -507,7 +507,6 @@ struct fuse_fs_context {
 	bool default_permissions:1;
 	bool allow_other:1;
 	bool destroy:1;
-	bool no_control:1;
 	bool no_force_umount:1;
 	bool legacy_opts_show:1;
 	enum fuse_dax_mode dax_mode;
@@ -766,9 +765,6 @@ struct fuse_conn {
 	/* Delete dentries that have gone stale */
 	unsigned int delete_stale:1;
 
-	/** Do not create entry in fusectl fs */
-	unsigned int no_control:1;
-
 	/** Do not allow MNT_FORCE umount */
 	unsigned int no_force_umount:1;
 
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 8c0665c5dff8..4059c6898e08 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1564,7 +1564,6 @@ int fuse_fill_super_common(struct super_block *sb, struct fuse_fs_context *ctx)
 	fc->legacy_opts_show = ctx->legacy_opts_show;
 	fc->max_read = max_t(unsigned int, 4096, ctx->max_read);
 	fc->destroy = ctx->destroy;
-	fc->no_control = ctx->no_control;
 	fc->no_force_umount = ctx->no_force_umount;
 
 	err = -ENOMEM;
diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
index 8db53fa67359..24bcf4dbca2a 100644
--- a/fs/fuse/virtio_fs.c
+++ b/fs/fuse/virtio_fs.c
@@ -1287,7 +1287,6 @@ static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *ctx)
 	ctx->max_read = UINT_MAX;
 	ctx->blksize = 512;
 	ctx->destroy = true;
-	ctx->no_control = true;
 	ctx->no_force_umount = true;
 }
 
-- 
2.20.1

