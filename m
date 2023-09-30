Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37C57B3E4C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbjI3FD4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234227AbjI3FDT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:03:19 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DB21BE3;
        Fri, 29 Sep 2023 22:02:16 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-692a885f129so10729448b3a.0;
        Fri, 29 Sep 2023 22:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050135; x=1696654935; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BE6ipvO+8ZhSNCDofbLi72/2YlhGigOFPDez07Hl8BI=;
        b=kzPEBBCmAwadesV6kqjng19qJV8xVwOIq2DWvG51ft3Y+D2zEXTD6iNtcFlO/3A1Kb
         QxEeM8jcJ99LVfO+dZn99wXXdL3lsp2H1okaYqdje7kYXEmcN2KVC530r5yrkYEL4rLR
         BLKfSXEppxRv9/S0w87Jvq+407qtX9JUJQbgjPey/CUd5KVQXgMmtVx0sGsBHgrVMBtR
         kXdzbG7xC8ByLFcUddAqr4cwhFqbK43CyiShYcCVFAzohPcIxLXhowaQ/3T20lGgZ2Le
         Yc/PfpOjfCYFIKo1mIyZ1ZU4iKBQkp56rf/2jl1rRtr9Uk9+lSd9TtQ3M45Ks3gcbO2b
         Uoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050135; x=1696654935;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BE6ipvO+8ZhSNCDofbLi72/2YlhGigOFPDez07Hl8BI=;
        b=OyC2U+oYaBTGTSWZVX59EnitgJP937YC37a30dxfDJ1yZmKg0mC97jBiPsACQBRz0G
         4o0a+5DL69lljUiycIFjsO32UjXUw4BpBt/XhyxZNoh3FVmO3Q75pRDxHU3LS03PQI0n
         4Vnf2HOKBBbh28eEBCVU1aKerguWj5w1zV76AmGVUYSmTu1ljLph4jXonQ9rM6wkvGrN
         aK1i1bVITSekNyFYS3VXbKuNX0N/Fy+v2PDOy/OpInOLRkRBcGeepy41kdGgKyh2gwcL
         AjC27L4fR7XC36LoXb1uoutdHDUdDS1/sNoF8eDk34AQNHZrlNbtV+W8YdjKJTPNFVXK
         jW7g==
X-Gm-Message-State: AOJu0YzkDrthk5hQVFoKXzIF+VJJnN66oiGOK3VhFgdYDpdukbyEpR3b
        XeMVSPaYkC9frijOgyGIMhY=
X-Google-Smtp-Source: AGHT+IHZ2HmNDv8dXuLSBGZEi/tfjtKCBtBv02K3b+NV9KDHm9seCiByjpILFz68EVYfGjkAPCIXFA==
X-Received: by 2002:a05:6a20:5b14:b0:153:588c:f197 with SMTP id kl20-20020a056a205b1400b00153588cf197mr5106839pzb.35.1696050135453;
        Fri, 29 Sep 2023 22:02:15 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:15 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Steve French <sfrench@samba.org>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Subject: [PATCH 23/29] smb: move cifs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:27 -0300
Message-Id: <20230930050033.41174-24-wedsonaf@gmail.com>
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
cifs_xattr_handlers at runtime.

Cc: Steve French <sfrench@samba.org>
Cc: Paulo Alcantara <pc@manguebit.com>
Cc: Ronnie Sahlberg <lsahlber@redhat.com>
Cc: Shyam Prasad N <sprasad@microsoft.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/smb/client/cifsfs.h | 2 +-
 fs/smb/client/xattr.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 15c8cc4b6680..a0472b539567 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -134,7 +134,7 @@ extern int cifs_symlink(struct mnt_idmap *idmap, struct inode *inode,
 			struct dentry *direntry, const char *symname);
 
 #ifdef CONFIG_CIFS_XATTR
-extern const struct xattr_handler *cifs_xattr_handlers[];
+extern const struct xattr_handler * const cifs_xattr_handlers[];
 extern ssize_t	cifs_listxattr(struct dentry *, char *, size_t);
 #else
 # define cifs_xattr_handlers NULL
diff --git a/fs/smb/client/xattr.c b/fs/smb/client/xattr.c
index 4ad5531686d8..ac199160bce6 100644
--- a/fs/smb/client/xattr.c
+++ b/fs/smb/client/xattr.c
@@ -478,7 +478,7 @@ static const struct xattr_handler smb3_ntsd_full_xattr_handler = {
 	.set = cifs_xattr_set,
 };
 
-const struct xattr_handler *cifs_xattr_handlers[] = {
+const struct xattr_handler * const cifs_xattr_handlers[] = {
 	&cifs_user_xattr_handler,
 	&cifs_os2_xattr_handler,
 	&cifs_cifs_acl_xattr_handler,
-- 
2.34.1

