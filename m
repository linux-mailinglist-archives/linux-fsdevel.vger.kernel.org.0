Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E08FE3FAA8D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235098AbhH2J5d (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbhH2J52 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:28 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C72C061575;
        Sun, 29 Aug 2021 02:56:36 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id w4so20051502ljh.13;
        Sun, 29 Aug 2021 02:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=06IJ8wv8VYpmrLf54oJDv7/8FotCGMOf/f2pOdPg7sg=;
        b=bZmgDWQIcYClPh9dxk+5kt1yNkQ8p0mgD1TAtGtU0g7eDn8UKdZ+IKuoGmI8BiZYHD
         mrW6M5ZEInqAytHA0c6uKFU6c6shXXvDOaeuxNdHsfxBPHiYKLx+rfhFKi7sZvWxtEs1
         d00A+utqmIlhzltXws86uhNTUEIcgiNQDS8YCFMtD2zV0ggNClMP+0pwhv5BjJY5ShFn
         OO0mGy41AvM7CMzgKECI6LW7bd7QuRc28CQ6ERowJHO/kJm9RjFX/jbYD5EDRRbI4UxC
         GIVCGVsmZvPPznqpTLJDRmY1Rjm8OnMqrUO26nNw1rkYU+KSUQYtutSHbjouXngvcUcY
         bBTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=06IJ8wv8VYpmrLf54oJDv7/8FotCGMOf/f2pOdPg7sg=;
        b=EfrqrBS12xuo1lIwvUVI5vE6gk/wW6W4yljJYpuLh8L1a4YtS/ofYKf0q6bowIYJMu
         S61cVczGMMVJTsEZvtnSk7lMBF+VhmkH1v+zHil2XRHJbrjVb/2p9RLVmkBuriNEU/xQ
         YfPc2xbvN6RR0TBjn4HRTxs5Rqtj1jEQpl6fajUS9BpmWpaYN6dss15E6YykC2X1WTyv
         cJrb5RJrSz46FiUHO+ooWYr5ISxkFtQGihzVkCdUEcjmzcT1en5QlPcpLqzYvTfiU/0+
         7vALxUY2j+Tf13f5UDHjq6HxD4+ZSiS2h9zSVX7AoFH9rkY9DVYpVbah4mXZN8BICnx3
         miDQ==
X-Gm-Message-State: AOAM533B6lT7CY6N9hbbedcgQsowuFlN93iLNoMONQ7GYrb0uSfZOk25
        4WvsOh+1F1sCI8nNvIsd8/E=
X-Google-Smtp-Source: ABdhPJybXuFCOlJmL+50BGFrqBEJAfgNz3geVl43CRaDiurUM3o/ebil5YGzAknhIdq/76WCd/AMXQ==
X-Received: by 2002:a2e:858e:: with SMTP id b14mr15701090lji.508.1630230994928;
        Sun, 29 Aug 2021 02:56:34 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:34 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 1/9] fs/ntfs3: Remove unnecesarry mount option noatime
Date:   Sun, 29 Aug 2021 12:56:06 +0300
Message-Id: <20210829095614.50021-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
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
index 17ee715ab539..267f123b0109 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -216,7 +216,6 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_noatime,
 	Opt_nls,
 	Opt_prealloc,
 	Opt_no_acs_rules,
@@ -235,7 +234,6 @@ static const match_table_t ntfs_tokens = {
 	{ Opt_sparse, "sparse" },
 	{ Opt_nohidden, "nohidden" },
 	{ Opt_acl, "acl" },
-	{ Opt_noatime, "noatime" },
 	{ Opt_showmeta, "showmeta" },
 	{ Opt_nls, "nls=%s" },
 	{ Opt_prealloc, "prealloc" },
@@ -326,9 +324,6 @@ static noinline int ntfs_parse_options(struct super_block *sb, char *options,
 			ntfs_err(sb, "support for ACL not compiled in!");
 			return -EINVAL;
 #endif
-		case Opt_noatime:
-			sb->s_flags |= SB_NOATIME;
-			break;
 		case Opt_showmeta:
 			opts->showmeta = 1;
 			break;
@@ -575,8 +570,6 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",prealloc");
 	if (sb->s_flags & SB_POSIXACL)
 		seq_puts(m, ",acl");
-	if (sb->s_flags & SB_NOATIME)
-		seq_puts(m, ",noatime");
 
 	return 0;
 }
-- 
2.25.1

