Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A550402BF7
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345469AbhIGPhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345464AbhIGPhb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:31 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0248C061575;
        Tue,  7 Sep 2021 08:36:24 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f2so17258778ljn.1;
        Tue, 07 Sep 2021 08:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Epwz9tOgzNdT5eJf6A6dPhiUiuiznCpEaozn8HC4mtE=;
        b=aclqQKLURedcL8YOp8JmRei8QCBPzB/+7FryeRIOuCxEZds/Y/yoOc01vpj3PYr0m7
         pt+41iqBuvPhcEknCaPpRrWVrySfUaZ4NcymHreqFFbgaHqzVLb0UVG+p9936ebtzHGF
         iNA06ICMDybNjDoyARNj5eJtI1LF2qMTwj+oWZWacvQ4+FjZrmbazZPCM5wlmuSzLSly
         FW+O6QXiXorvQ8Q6tXQ9DlvImWPxC9O9+pB5E0xtncblo43QZoccUYT8wKG460IEufor
         wHxgzAdlnGC+izoS5Mda+gOR0gmWi3mnE9anr1k9a3pcvGWd3PYrWMUHpjBOtGRY6z/i
         xYFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Epwz9tOgzNdT5eJf6A6dPhiUiuiznCpEaozn8HC4mtE=;
        b=ai/KyBUDnLkeldUUiBLgKZbobPzp0toOQ/BTEFp7VHxCM1YuHvfbZCZra6VV17CEDj
         gBAwRUhbJdk8dJ6bCfGQP8zR/wymzm6A6X90x/aCn1SNOnOtmxQynlXsFiFCtLBaHdh2
         Uuo0pQVRQfcbdRN5qh2Mzn5BtgQsYk5awa0HC4iPP+EK1+Qv53F1rTZN1bG0dkhcp/3Y
         Jfw1J4Uk6lp/TJA1Wy01UKuc7MFgLcu0cmZCxarK4Mlr8vX16hHrrV0Px6vvXlpVQtF7
         xBQP2DCKFgog9nj6yOADsCszJ+wVkST2P2NSfhKCMVb9yjZ+SEDPm9nRUwRS4Dq1vxYy
         oHxg==
X-Gm-Message-State: AOAM533dbgWcxIiTj+ImvcoHpN1qesqpMxVVHEZK9eME4NEDz0hUR4WH
        aXmpDPvDgJx0fJMFZ8uFu6o=
X-Google-Smtp-Source: ABdhPJwx/9G/1Sh8TeuVIbvlSLdoKlW78mtKLU4Vm5q47XvdIemAJOanz3QYviGH/tliK3b2ezpGYA==
X-Received: by 2002:a05:651c:178d:: with SMTP id bn13mr15428224ljb.530.1631028983294;
        Tue, 07 Sep 2021 08:36:23 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id p14sm1484458lji.56.2021.09.07.08.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:36:22 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 7/9] fs/ntfs3: Add iocharset= mount option as alias for nls=
Date:   Tue,  7 Sep 2021 18:35:55 +0300
Message-Id: <20210907153557.144391-8-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907153557.144391-1-kari.argillander@gmail.com>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Other fs drivers are using iocharset= mount option for specifying charset.
So add it also for ntfs3 and mark old nls= mount option as deprecated.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 Documentation/filesystems/ntfs3.rst |  4 ++--
 fs/ntfs3/super.c                    | 18 +++++++++++-------
 2 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/ntfs3.rst b/Documentation/filesystems/ntfs3.rst
index af7158de6fde..ded706474825 100644
--- a/Documentation/filesystems/ntfs3.rst
+++ b/Documentation/filesystems/ntfs3.rst
@@ -32,12 +32,12 @@ generic ones.
 
 ===============================================================================
 
-nls=name		This option informs the driver how to interpret path
+iocharset=name		This option informs the driver how to interpret path
 			strings and translate them to Unicode and back. If
 			this option is not set, the default codepage will be
 			used (CONFIG_NLS_DEFAULT).
 			Examples:
-				'nls=utf8'
+				'iocharset=utf8'
 
 uid=
 gid=
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 729ead6f2fac..503e2e23f711 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -226,7 +226,7 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_nls,
+	Opt_iocharset,
 	Opt_prealloc,
 	Opt_no_acs_rules,
 	Opt_err,
@@ -245,9 +245,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
 	fsparam_flag_no("hidden",		Opt_nohidden),
 	fsparam_flag_no("acl",			Opt_acl),
 	fsparam_flag_no("showmeta",		Opt_showmeta),
-	fsparam_string("nls",			Opt_nls),
 	fsparam_flag_no("prealloc",		Opt_prealloc),
 	fsparam_flag("no_acs_rules",		Opt_no_acs_rules),
+	fsparam_string("iocharset",		Opt_iocharset),
+
+	__fsparam(fs_param_is_string,
+		  "nls", Opt_iocharset,
+		  fs_param_deprecated, NULL),
 	{}
 };
 
@@ -346,7 +350,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_showmeta:
 		opts->showmeta = result.negated ? 0 : 1;
 		break;
-	case Opt_nls:
+	case Opt_iocharset:
 		kfree(opts->nls_name);
 		opts->nls_name = param->string;
 		param->string = NULL;
@@ -380,11 +384,11 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
 	new_opts->nls = ntfs_load_nls(new_opts->nls_name);
 	if (IS_ERR(new_opts->nls)) {
 		new_opts->nls = NULL;
-		errorf(fc, "ntfs3: Cannot load nls %s", new_opts->nls_name);
+		errorf(fc, "ntfs3: Cannot load iocharset %s", new_opts->nls_name);
 		return -EINVAL;
 	}
 	if (new_opts->nls != sbi->options->nls)
-		return invalf(fc, "ntfs3: Cannot use different nls when remounting!");
+		return invalf(fc, "ntfs3: Cannot use different iocharset when remounting!");
 
 	sync_filesystem(sb);
 
@@ -528,9 +532,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 	if (opts->dmask)
 		seq_printf(m, ",dmask=%04o", ~opts->fs_dmask_inv);
 	if (opts->nls)
-		seq_printf(m, ",nls=%s", opts->nls->charset);
+		seq_printf(m, ",iocharset=%s", opts->nls->charset);
 	else
-		seq_puts(m, ",nls=utf8");
+		seq_puts(m, ",iocharset=utf8");
 	if (opts->sys_immutable)
 		seq_puts(m, ",sys_immutable");
 	if (opts->discard)
-- 
2.25.1

