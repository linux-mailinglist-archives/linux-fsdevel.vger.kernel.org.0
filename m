Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7CFE402BED
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345383AbhIGPhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbhIGPhQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:16 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F24C061575;
        Tue,  7 Sep 2021 08:36:10 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id f2so17257510ljn.1;
        Tue, 07 Sep 2021 08:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNKca7TdM6UOQ59W0PmuB6JI6yIXEnAZZ18j+cw9ZMM=;
        b=Pz+OHzmYb7NZvewbuGmn6sZLP6XjUa+szUycP+iSikdofQIQhYsukWjEP6JHkIZglA
         vnAHNyaPH3pfm5pOD7+89FRER5ZjOO3WHWPeDpeqIoce0Kb2jgStNhO4o9FvxhQzVm3O
         x1TzYeODELaHJzSSBzJXLYYP/jx0bP8amHZLP/cKZ0TDFuhcmvpV95xe1tq9r/82P7rQ
         zScseh3WBGAPX2ZGAjyrketx6Cru2F3qSz8ilU4/cj/YYqxPwG4rKXbz/hbtLwkUu7U4
         Yph2awkIqbsqgoUVhmFSlJACxLNsFONOJ81iNSJrhZIFV3PdlRGQN9sJDSkYXS/WTKmT
         lAaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNKca7TdM6UOQ59W0PmuB6JI6yIXEnAZZ18j+cw9ZMM=;
        b=bMB1/MSHYqUToyPgy/wkQ+cmCuJCfVWoApyN4pZWb1VLM9k8H1ONS36CE5F9YTnH9e
         Q+w2gy+z2gH2gwOmOSKFQVBWrm5q6QxdqY7yj2zdrq8QnN8FeDyWDE7BJcrKPk6WRQAL
         uwSnjUH+E2nfvZf0Lbxbk4nX5H2onz6JQD8hkOBraR7HVncuAIxjvm7OBjHxJwtk09wx
         T2kUIjgOTJcbcm8OrFKtIeXEKJr38pdsm7jYqXslhdiuYaEhKLelBWwByD01YgaRtOAd
         4U1Of5SnaZsA0wldJ29U+fsLFeO7thR3gfvEkA9T9ih9AXo7QQXVSSNG5IDVhAXZWnM5
         Uuow==
X-Gm-Message-State: AOAM533fJSMxcig5b9VssUpVo0zhYdQHD8bPysSqRTwvD2aMkdUQE5tI
        QLKEuV6eQz7hCV830riEZ+jod+o0jTlUew==
X-Google-Smtp-Source: ABdhPJyydmeiLotrIfztdpGIDFEPKD2CExvveV1n8c53u/SxRzM5CQhT82LVqNeMLAF3FqDyDK/DUA==
X-Received: by 2002:a2e:b173:: with SMTP id a19mr15323585ljm.210.1631028968451;
        Tue, 07 Sep 2021 08:36:08 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id p14sm1484458lji.56.2021.09.07.08.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:36:08 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 1/9] fs/ntfs3: Remove unnecesarry mount option noatime
Date:   Tue,  7 Sep 2021 18:35:49 +0300
Message-Id: <20210907153557.144391-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907153557.144391-1-kari.argillander@gmail.com>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unnecesarry mount option noatime because this will be handled
by VFS. Our option parser will never get opt like this.

Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 Documentation/filesystems/ntfs3.rst | 4 ----
 fs/ntfs3/super.c                    | 7 -------
 2 files changed, 11 deletions(-)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index ffe9ea0c1499..af7158de6fde 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -85,10 +85,6 @@ acl			Support POSIX ACLs (Access Control Lists). Effective if
 			supported by Kernel. Not to be confused with NTFS ACLs.
 			The option specified as acl enables support for POSIX ACLs.
 
-noatime			All files and directories will not update their last access
-			time attribute if a partition is mounted with this parameter.
-			This option can speed up file system operation.
-
 ===============================================================================
 
 ToDo list
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 55bbc9200a10..a18b99a3e3b5 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -223,7 +223,6 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_noatime,
 	Opt_nls,
 	Opt_prealloc,
 	Opt_no_acs_rules,
@@ -242,7 +241,6 @@ static const match_table_t ntfs_tokens = {
 	{ Opt_sparse, "sparse" },
 	{ Opt_nohidden, "nohidden" },
 	{ Opt_acl, "acl" },
-	{ Opt_noatime, "noatime" },
 	{ Opt_showmeta, "showmeta" },
 	{ Opt_nls, "nls=%s" },
 	{ Opt_prealloc, "prealloc" },
@@ -333,9 +331,6 @@ static noinline int ntfs_parse_options(struct super_block *sb, char *options,
 			ntfs_err(sb, "support for ACL not compiled in!");
 			return -EINVAL;
 #endif
-		case Opt_noatime:
-			sb->s_flags |= SB_NOATIME;
-			break;
 		case Opt_showmeta:
 			opts->showmeta = 1;
 			break;
@@ -587,8 +582,6 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",prealloc");
 	if (sb->s_flags & SB_POSIXACL)
 		seq_puts(m, ",acl");
-	if (sb->s_flags & SB_NOATIME)
-		seq_puts(m, ",noatime");
 
 	return 0;
 }
-- 
2.25.1

