Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB73F0F6F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Aug 2021 02:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhHSA1p (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 20:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbhHSA1o (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:27:44 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED0DC061764;
        Wed, 18 Aug 2021 17:27:08 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id d4so8577238lfk.9;
        Wed, 18 Aug 2021 17:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tfj//FhhyfKeVdQKBClWYDezrF9aDmSu69DJf1xq7P8=;
        b=thVoF9ouc3UABUSLBdo0ij9UzOTBrj3X8W/FHCdoHzz88ZfvvTe97dyzMhmdyk3zNM
         YImGEfe57iO6S49EtR0cfXdhqFrgWWYqQmYDX3D8hmLv5LebdvUH8Qx0Bq7svVTPjMEr
         pkNMZlH/Vj2uLfoTjGlpCAT28VTwKPzBJoMIDY8KhzpdhDa08sVqtcwWDCzP2rxU/gbM
         MDOSGMVm+J3WIzn3U4LWpkhgCcj5mC1D3jxhcee6NjaRCCyGJKm836UfipILfxkpEpAE
         CzYURShrAPoo4Dzs/qQw4dcpFLaJsI1TCdJBveoGnYRkuKymyFGZvitzqGMpbkUlLqpp
         wHbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tfj//FhhyfKeVdQKBClWYDezrF9aDmSu69DJf1xq7P8=;
        b=ftqBv0j34Cf9w9L87Y7pSJkSgNydlK1qkZ9RAQ98UQE/r5yl/JOiPq8lWJnEUYzjnP
         AGQTHuvVjc9fEe17ku5iZp6QylueXABj1S+1l1yz1aqXXepm66OJXB7YcgqUpOZ7LOgC
         eW2kTRbydgwCofzdDpp3bcisNJR0ctF8IpLw1RboZLzCcmxW7NcbYSYR4BgROqsXqBT4
         UQ5kjdOeGrIxO0/rMUZa75lwJzspL52y7Z72gniVeQtmiPDEfYYn1P9yk0wwReEZIpd9
         SQMv0RvPT/8PraYDdcGfzJ8/Rvi4fvigv77vSVDIvi8s66rfob70rCHh+WSCXWLwQcNp
         NgkQ==
X-Gm-Message-State: AOAM531/WPLUkG/8ZU5Jtj4kvSLRSU776r+30kwxS/6eiHpf8ESO+ih8
        PvIK7bwzxqYFV3d03SkSfOo=
X-Google-Smtp-Source: ABdhPJwT3+v+7NqeseVFVx9AsF7XLv/dX5uKdtVC+OFkf26i730dxctkKj3zsuC8pyWlV0/5AnxgyA==
X-Received: by 2002:ac2:58d4:: with SMTP id u20mr8007445lfo.157.1629332827385;
        Wed, 18 Aug 2021 17:27:07 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id l14sm125907lji.106.2021.08.18.17.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 17:27:07 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v2 1/6] fs/ntfs3: Remove unnecesarry mount option noatime
Date:   Thu, 19 Aug 2021 03:26:28 +0300
Message-Id: <20210819002633.689831-2-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210819002633.689831-1-kari.argillander@gmail.com>
References: <20210819002633.689831-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unnecesarry mount option noatime because this will be handled
by VFS. Our option parser will never get opt like this.

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
index 6be13e256c1a..081ac875a61a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -215,7 +215,6 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_noatime,
 	Opt_nls,
 	Opt_prealloc,
 	Opt_no_acs_rules,
@@ -234,7 +233,6 @@ static const match_table_t ntfs_tokens = {
 	{ Opt_sparse, "sparse" },
 	{ Opt_nohidden, "nohidden" },
 	{ Opt_acl, "acl" },
-	{ Opt_noatime, "noatime" },
 	{ Opt_showmeta, "showmeta" },
 	{ Opt_nls, "nls=%s" },
 	{ Opt_prealloc, "prealloc" },
@@ -325,9 +323,6 @@ static noinline int ntfs_parse_options(struct super_block *sb, char *options,
 			ntfs_err(sb, "support for ACL not compiled in!");
 			return -EINVAL;
 #endif
-		case Opt_noatime:
-			sb->s_flags |= SB_NOATIME;
-			break;
 		case Opt_showmeta:
 			opts->showmeta = 1;
 			break;
@@ -574,8 +569,6 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",prealloc");
 	if (sb->s_flags & SB_POSIXACL)
 		seq_puts(m, ",acl");
-	if (sb->s_flags & SB_NOATIME)
-		seq_puts(m, ",noatime");
 
 	return 0;
 }
-- 
2.25.1

