Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6963ECCC6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232336AbhHPCs5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232049AbhHPCsz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:48:55 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D7AC0617AD;
        Sun, 15 Aug 2021 19:48:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id x27so31570745lfu.5;
        Sun, 15 Aug 2021 19:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LhP4KmjamUZIjdoWUccaTN8Y5WL2GFHtIS6CXRcaByM=;
        b=D5OsEetl087LrLfFgvMcE2fOoHuq2cMGpqaOgXJnPEGIZKBLeax5735V9djMGXqbPv
         zMVdPsSsotN91V/LIw7pHlDjzeqaVcWqoWyFxYUYqxf/cYP2bEqwkmb1j8eYz8+kx2aD
         J5R1i0NzR57RAW56L1nw0GN3Y99lKraAd1eaw99YuShp9psnajE9d1woQuVsHi7Kx20g
         ucCHd4lAuhs5kl3Tv/1pJF+e2WIADoigazvK09JY1nw5BnM8GaSLa3rKMjJ2CiEK7i9J
         ppekNTF3iEEkY8/Vol4F/qmsdz6SHrBC483rGMeaQPZZlMFLwyUEED99di2XPKUf63jx
         QVAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LhP4KmjamUZIjdoWUccaTN8Y5WL2GFHtIS6CXRcaByM=;
        b=sLcpwsccch9YnPqFU4r0WPv4X3iCADwvflAHppKLEOj8tlYrbpS32usiHTSgzOCJl5
         FsGlfr5qclSXDW7LMuhH42Lnzw/NuMvzXUHC8poLsov6JF0B7GcgaoGjucecsKC6tuUG
         9QEhX2c9NuXpWu/WRuEIvsArjSboUbIE54IcHNdOkWMOMqXAU3yMMSRERLiwpVUf1VXo
         sPv7Dqo7LfmqZeG6jB0suKRVomhqO+CK1xKw5nqVImPBxXdFub+YAj7x2TU36i5iuxIh
         WiTotqS3IlGNCnKce/EdiJhUtkmWBfX2q5WPSWuMwu+x4QNXUsJaCZt3joOOfv5WjCzi
         UIlg==
X-Gm-Message-State: AOAM530TCNyVIqRSf/95vKNHEnwDw0hMMNnj0SPIt++e/gUu630qjKq4
        Z+vDudRjvnL+aaDp83pbRV8=
X-Google-Smtp-Source: ABdhPJzQ8koM921EMdhBxnFqP4Fc4UipwepNzN1wJlyTA3rHNYrnrLySwmoHhu0wlIDHrwSHDznDaw==
X-Received: by 2002:a05:6512:b9e:: with SMTP id b30mr4273793lfv.428.1629082103262;
        Sun, 15 Aug 2021 19:48:23 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b12sm425392lfs.152.2021.08.15.19.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 19:48:22 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 2/4] fs/ntfs3: Remove unnecesarry mount option noatime
Date:   Mon, 16 Aug 2021 05:47:01 +0300
Message-Id: <20210816024703.107251-3-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816024703.107251-1-kari.argillander@gmail.com>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove unnecesarry mount option noatime because this will be handled
by VFS. Our function ntfs_parse_param will never get opt like
this.

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
index d805e0b31404..e4e2bd0ebfe6 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -240,7 +240,6 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_noatime,
 	Opt_nls,
 	Opt_prealloc,
 	Opt_no_acs_rules,
@@ -260,7 +259,6 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("sparse",		Opt_sparse),
 	fsparam_flag("nohidden",		Opt_nohidden),
 	fsparam_flag_no("acl",			Opt_acl),
-	fsparam_flag("noatime",			Opt_noatime),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
 	fsparam_string("nls",			Opt_nls),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
@@ -341,9 +339,6 @@ static int ntfs_fs_parse_param(struct fs_context *fc, struct fs_parameter *param
 		else
 			fc->sb_flags &= ~SB_POSIXACL;
 		break;
-	case Opt_noatime:
-		fc->sb_flags |= SB_NOATIME;
-		break;
 	case Opt_showmeta:
 		opts->showmeta = result.negated ? 0 : 1;
 		break;
@@ -555,8 +550,6 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 		seq_puts(m, ",prealloc");
 	if (sb->s_flags & SB_POSIXACL)
 		seq_puts(m, ",acl");
-	if (sb->s_flags & SB_NOATIME)
-		seq_puts(m, ",noatime");
 
 	return 0;
 }
-- 
2.25.1

