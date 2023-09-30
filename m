Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C557B3E44
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Sep 2023 07:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbjI3FDb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 30 Sep 2023 01:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234172AbjI3FC5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 30 Sep 2023 01:02:57 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1014F1716;
        Fri, 29 Sep 2023 22:02:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-578b4981526so9577018a12.0;
        Fri, 29 Sep 2023 22:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696050121; x=1696654921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wc3/lDJ0Y70q5wqO7T6IeDRSePuhtOmjFGCpqJDnCH4=;
        b=Kmjejcs6cA9AmCbLWbwjDyo5/oq/p4ugr8dzIFKsz7B3OqCJCDkkuqvAGr5nKDo9se
         yXxv2j5A5Lf9K0MRJanMitul1TQSlh4rmJ/y1FQlWORMFU1iICjYW/aTsW1ey+mYNHIG
         4ceorT8CgJVOQSzlJrvyuWGYCN5keizFS+o/RghJLHuTtIAMWBAJzNvEh/L85kH+aXZM
         Eyq1Q4+4i1fklgTkRVxGGcO6MakyUlzPHlESo5RnMHiooaLYH4z/fcdHCfzo2wQdzrK8
         jcH6Q6vDN3jz89vHhALqKW2tozaUdP4jWDPRKdYyhOe/qwEvg8hzEG7RkISbwCAjq514
         t5OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696050121; x=1696654921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wc3/lDJ0Y70q5wqO7T6IeDRSePuhtOmjFGCpqJDnCH4=;
        b=iRaY03i69y0xYuDvru75+uGODn+wVhQeBmxxxXc5YAfYINqywnHlBTH+G8DhGi1+2P
         ioWyLte3vW+AQEHhbfl0ztBozxrk/CuEKJj7g1T2uJKJqhA9QF+PY3/VJb1xPe5xAtGJ
         8kDbKZfHVMEtHpv+g/AA4tTt2CHPwtENLuwRJhhKPKL7m3erlouPFwkiR4Gob2ItAadn
         em1P7v+wLgWHdlNnyHpzIYaz3brVPx+WnsuV7nGf3RMP7mSH5N0Sumn+sJHaAVm3KGjW
         i6cNEzBAR7FwthfyVxH5aFZtcngMrGV2An0HrjUrydYtM/jd5tRWUl2GRndH/NeKKpFE
         ulfw==
X-Gm-Message-State: AOJu0YwhKxySJNNrGz0y11QzVWLoO3tNeUh5c1YT3EOmDGWxVCDhpG9k
        fa04bmVo5FtHuR3zrHmp8Lc=
X-Google-Smtp-Source: AGHT+IGwjxf7szTTsQLyPMtmx6D961AfPmaEk+HWKxuN9bQbxtvcTWtZao4yWyr/O0xKDGBTdR7a8g==
X-Received: by 2002:a05:6a20:1451:b0:15d:e68d:a855 with SMTP id a17-20020a056a20145100b0015de68da855mr6635638pzi.29.1696050121350;
        Fri, 29 Sep 2023 22:02:01 -0700 (PDT)
Received: from wedsonaf-dev.home.lan ([189.124.190.154])
        by smtp.googlemail.com with ESMTPSA id y10-20020a17090322ca00b001c322a41188sm392136plg.117.2023.09.29.22.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 22:02:01 -0700 (PDT)
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Subject: [PATCH 19/29] ntfs3: move ntfs_xattr_handlers to .rodata
Date:   Sat, 30 Sep 2023 02:00:23 -0300
Message-Id: <20230930050033.41174-20-wedsonaf@gmail.com>
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
ntfs_xattr_handlers at runtime.

Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev
Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
---
 fs/ntfs3/ntfs_fs.h | 2 +-
 fs/ntfs3/xattr.c   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 629403ede6e5..41c1538f8e51 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -872,7 +872,7 @@ int ntfs_init_acl(struct mnt_idmap *idmap, struct inode *inode,
 
 int ntfs_acl_chmod(struct mnt_idmap *idmap, struct dentry *dentry);
 ssize_t ntfs_listxattr(struct dentry *dentry, char *buffer, size_t size);
-extern const struct xattr_handler *ntfs_xattr_handlers[];
+extern const struct xattr_handler * const ntfs_xattr_handlers[];
 
 int ntfs_save_wsl_perm(struct inode *inode, __le16 *ea_size);
 void ntfs_get_wsl_perm(struct inode *inode);
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index 023f314e8950..a67ff036a251 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -1016,7 +1016,7 @@ static const struct xattr_handler ntfs_other_xattr_handler = {
 	.list	= ntfs_xattr_user_list,
 };
 
-const struct xattr_handler *ntfs_xattr_handlers[] = {
+const struct xattr_handler * const ntfs_xattr_handlers[] = {
 	&ntfs_other_xattr_handler,
 	NULL,
 };
-- 
2.34.1

