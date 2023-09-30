Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89B57B3E17
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233999AbjI3FBH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjI3FBD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:01:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C2E1B0;
        Fri, 29 Sep 2023 22:01:00 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-5859b2eaa67so1169926a12.0;
        Fri, 29 Sep 2023 22:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050060; x=1696654860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9WSGeyDZriCKRNJzS9a5bpAtYgU4j64EZGl2o5ZwnHo=;
        b=chixZPn68wPzpPaXBpXJPcHLVyqXmkdsyx7keiyCNsq5Q/LuRkXMQwJW9byonEhY98
         MlOlXnUK0mE3HgI/Z393vQklX5+643Ozs2KFXRWsvktZEB/S2evUqFpvM48mkBmUVz3W
         a6Ifh7sCBz0cldhuUpwzWq7MvRDOyPalK9eKHRWxLiiAPIt/oBRQweVURwzbBHlwMZwV
         ZqZvH+6vQWepBtLxmnSF1UHY6J9WMhetMEE+5K3MAuFb5+YUmDrQUBxD/4WDY5ClS5mu
         ZqcrGWQn3Ja6e7Ir0meuLgpCjlnsdaEEs1+fcOo+05GSY+lxsZmyJfDa4Bz4FXvbCwjI
         y74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050060; x=1696654860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9WSGeyDZriCKRNJzS9a5bpAtYgU4j64EZGl2o5ZwnHo=;
        b=VP+QLVy37z5qONJ1a8BccL1oT+RDVGpv72nky+vE5f44BDqQs1dsJw4RSrO95LNiRN
         jdCCuNYDNOSGRe8aLr7PwfTFNjjzMMoQi2aYriTpk3oRC3oHz18vdgq6SQXbrWEVEW+a
         ftlEOpelT8qA7Bl2shMSY3lln8Sytj0iq5lBkXyE5ZqxeFEsSd3ierzz4N6mECCxVARd
         UuH5ZzbnaHFyU/WtMr8H+Ftwx9UxrKZdnfV4h6BeWSuRFB1h5XHgFsXoKVbCc+j2KPf8
         +514OZunSFJ9WfYwraYelCwtobzG7iwzBjiMxhvfESv3o7zF9jV88fi9Q8VQ7nluw5sp
         83oA==
X-Gm-Message-State: AOJu0YxzZzpDwFF1onMqVnVkPfRWnrxcrDZzl68iohkiIzEDkcxEgzni
        NKk/hEIGaP6YJxmhYkHUMlQ=
X-Google-Smtp-Source: AGHT+IFyL6ZhSw9Y7MywEL+gpT1cH09yC3kbsx+Xe5i6RwF3MHct2uU9i+Sa3kKstKEQr6Exixs9BA==
X-Received: by 2002:a05:6a21:3d8b:b0:163:4288:1c3d with SMTP id bj11-20020a056a213d8b00b0016342881c3dmr3036924pzc.43.1696050060285;
        Fri, 29 Sep 2023 22:01:00 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:01:00 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Subject: [PATCH 02/29] ext4: move ext4_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:06 -0300
Message-Id: <20230930050033.41174-3-wedsonaf@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230930050033.41174-1-wedsonaf@gmail.com>
References: <20230930050033.41174-1-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Wedson Almeida Filho <walmeida@microsoft.com>

This makes it harder for accidental or malicious changes to
ext4_xattr_handlers at runtime.

Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/ext4/xattr.c | 2 +-
 fs/ext4/xattr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 05151d61b00b..5e8a7328fe4e 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -98,7 +98,7 @@ static const struct xattr_handler * const ext4_xattr_handler_map[] = {
 	[EXT4_XATTR_INDEX_HURD]		     = &ext4_xattr_hurd_handler,
 };
 
-const struct xattr_handler *ext4_xattr_handlers[] = {
+const struct xattr_handler * const ext4_xattr_handlers[] = {
 	&ext4_xattr_user_handler,
 	&ext4_xattr_trusted_handler,
 #ifdef CONFIG_EXT4_FS_SECURITY
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 824faf0b15a8..bd97c4aa8177 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -193,7 +193,7 @@ extern int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 			    struct ext4_inode *raw_inode, handle_t *handle);
 extern void ext4_evict_ea_inode(struct inode *inode);
 
-extern const struct xattr_handler *ext4_xattr_handlers[];
+extern const struct xattr_handler * const ext4_xattr_handlers[];
 
 extern int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
 				 struct ext4_xattr_ibody_find *is);
-- 
2.34.1

