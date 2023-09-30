Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 647437B3E19
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233870AbjI3FBG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233053AbjI3FA7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:00:59 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA4EB9;
        Fri, 29 Sep 2023 22:00:57 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c3cbfa40d6so133398475ad.1;
        Fri, 29 Sep 2023 22:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050057; x=1696654857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+kwTjR+CWDbHNLH7Vi6T+1DkOngNTu95bmWBQQSjqM=;
        b=S7sYrmck40xgfqrsFLnX3leo2dQykimaZ9ibzIv7/8SJX/CovuEHpyX47jhZeLSztM
         rUWNYvhA+gQP3j3f+/Q/A9TTcwyyNpswjpMiUjb8WYssZA+2nbL+ulQ9dxR/yikDQH6e
         beZNU9JYKZ/hZ4TLPY0HT40BRC1k3jWs+Z1Kn+7pTLKPxs8w1A2gCNRa8vUe4wqNfGrc
         isvIJNOAxUahbuw1bm4bpEJNOp7VGbGKBNNTsGIfNnzrWCCwSldeLYKujUu2GqVr51Ag
         548GRaKLYo9dqzhWyI9nOIjCrhHVKOJFhxEsTspNJeq/FDM47n8XXdKj5PDgpQ52750s
         UzyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050057; x=1696654857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+kwTjR+CWDbHNLH7Vi6T+1DkOngNTu95bmWBQQSjqM=;
        b=adjT2LI56iZkFtzP7pZpKDJw0tenQBFYC3OrGpfrxF29hMU0Qk2nzA22ZFI0x3HNaj
         bQsKcaBWDN5lhlgSMEhuveEueoSUK2fehAzq7Vj6zKnupbf/rKtIlK5NxNkI+INPo74J
         bKSowyMsuwjechH/nnUNjZcCylbM49s1Zzu2I4SRhYAXAn2AAg/DLUNOKdSa95KP99iL
         FNRvRpYDfrqozfUH+vgOHQi/QuUBwbKzA5sdiHCMPReBF1YUKIk5yYyOdaRTe3ynm5Xu
         NkCILWJndt4IBevOD83f9TIyM9czFpkkaUY165bnCdzqRPgE4QM+rK2OQD1wMoo2Dxtz
         3R3w==
X-Gm-Message-State: AOJu0YySZcacFIj6LIFh88h3gJElFj39vMSPszuqe+8N3DfsW8ckpHgi
        12vYq0+7sUkwhAaDM/K2uVs=
X-Google-Smtp-Source: AGHT+IE3clBoNe1+iQ3IlslzBntHeKBbfAzduqxSVh1lFbVUKfB6ydY61EaO5FHqjtkOJGliaqwK3g==
X-Received: by 2002:a17:903:2445:b0:1c4:fae:bf4a with SMTP id l5-20020a170903244500b001c40faebf4amr6676418pls.16.1696050056932;
        Fri, 29 Sep 2023 22:00:56 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:00:56 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: [PATCH 01/29] xattr: make the xattr array itself const
Date:   Sat, 30 Sep 2023 02:00:05 -0300
Message-Id: <20230930050033.41174-2-wedsonaf@gmail.com>
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

As it is currently declared, the xattr_handler structs are const but the
array containing their pointers is not. This patch makes it so that fs
modules can place them in .rodata, which makes it harder for
accidental/malicious modifications at runtime.

Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/xattr.c         | 6 +++---
 include/linux/fs.h | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index e7bbb7f57557..1905f8ede13d 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -56,7 +56,7 @@ strcmp_prefix(const char *a, const char *a_prefix)
 static const struct xattr_handler *
 xattr_resolve_name(struct inode *inode, const char **name)
 {
-	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
+	const struct xattr_handler * const *handlers = inode->i_sb->s_xattr;
 	const struct xattr_handler *handler;
 
 	if (!(inode->i_opflags & IOP_XATTR)) {
@@ -162,7 +162,7 @@ xattr_permission(struct mnt_idmap *idmap, struct inode *inode,
 int
 xattr_supports_user_prefix(struct inode *inode)
 {
-	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
+	const struct xattr_handler * const *handlers = inode->i_sb->s_xattr;
 	const struct xattr_handler *handler;
 
 	if (!(inode->i_opflags & IOP_XATTR)) {
@@ -999,7 +999,7 @@ int xattr_list_one(char **buffer, ssize_t *remaining_size, const char *name)
 ssize_t
 generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
 {
-	const struct xattr_handler *handler, **handlers = dentry->d_sb->s_xattr;
+	const struct xattr_handler *handler, * const *handlers = dentry->d_sb->s_xattr;
 	ssize_t remaining_size = buffer_size;
 	int err = 0;
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 562f2623c9c9..4d8003f48216 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1172,7 +1172,7 @@ struct super_block {
 #ifdef CONFIG_SECURITY
 	void                    *s_security;
 #endif
-	const struct xattr_handler **s_xattr;
+	const struct xattr_handler * const *s_xattr;
 #ifdef CONFIG_FS_ENCRYPTION
 	const struct fscrypt_operations	*s_cop;
 	struct fscrypt_keyring	*s_master_keys; /* master crypto keys in use */
-- 
2.34.1

