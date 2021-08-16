Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E108F3ECCCA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 04:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232739AbhHPCtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 15 Aug 2021 22:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbhHPCs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 15 Aug 2021 22:48:59 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC6C0613C1;
        Sun, 15 Aug 2021 19:48:28 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id k5so3722946lfu.4;
        Sun, 15 Aug 2021 19:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iYz9vWgNSNALF0ku2PXSCElORiPAPuGLP9E83ZEt3mg=;
        b=cZp0EcbuoXb094Fa+0A2X0Axmo8Is+WEreRzqFc9l7hBq/RU6qPOcjFijQ1RKl4Llq
         ESDDbZt65QR1DowjIeNF5DpHOLY8P5gsbNpxGwkNu1SlO/xpJszYPpMBnJUn/fgVC4Cv
         zqgMwhuF/yaZ6Z6JfPSkXBaZRE9l1yHYNgIjZd51E04Uf9q93VXWaTXiIHpfl+9ihaOX
         N+Y/ymJ18SpgvErC94kVxAtsRy2ejQLCfRayZ2ecl80q+CzZsFtm0f0ioOpFG3kkozuH
         AG5aYXjyze7bO+kNiW1a3MF8SXCcoRa3WPYXHsMOMS9kHo7oFo+wkRClfqW/5UIQPLB6
         zMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iYz9vWgNSNALF0ku2PXSCElORiPAPuGLP9E83ZEt3mg=;
        b=ajSN/AqKc9cLeHiYraIy6SGIqWN6e44vjMfu3TZEN5pADPPYhGYh9fuilWCzNmf7yJ
         yYCojvutL7QWBj74KApm8tDPwOPIl1SZDMghmh+w1D4EmPtFMzpFxH8IcuG/lbd9BWlW
         /m/wVQOIXppI7NKYOrh3uowO5mNzUZE8Wz0Ay3iMQjxAcDlmshHIlX8bw3ZS/b1/GrMI
         3BFKRYAVYzzmLur5olEneut7ReJiQ9sZnayfHz1Dgq+CGoncdLZTUwAnbPs+pF8k5jUT
         w4PoiWsxQJdl2eWinKOuOz8Uo3uBIszld4WahjtY/f8V2s6T48iXhwHCkpLA9DWIAOBI
         ad5Q==
X-Gm-Message-State: AOAM532nErpYlNJdJJNDHIuTXs3k2lQHycTpgor4od06XBhQ9S341XMZ
        VOm8hmeuBnwkxDRe7vx5GNs=
X-Google-Smtp-Source: ABdhPJx6TMgsxM82KUFNsSMqgYnQ1K/+2Bw1KpPLpVuKVWH1slkF6yi4IoRTvj84ckvU3XZnElAVwQ==
X-Received: by 2002:a05:6512:3887:: with SMTP id n7mr10007419lft.572.1629082106427;
        Sun, 15 Aug 2021 19:48:26 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy (85-23-89-224.bb.dnainternet.fi. [85.23.89.224])
        by smtp.gmail.com with ESMTPSA id b12sm425392lfs.152.2021.08.15.19.48.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Aug 2021 19:48:26 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: [RFC PATCH 4/4] fs/ntfs3: Add iocharset= mount option as alias for nls=
Date:   Mon, 16 Aug 2021 05:47:03 +0300
Message-Id: <20210816024703.107251-5-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816024703.107251-1-kari.argillander@gmail.com>
References: <20210816024703.107251-1-kari.argillander@gmail.com>
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
 fs/ntfs3/super.c                    | 14 +++++++++-----
 2 files changed, 11 insertions(+), 7 deletions(-)

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
index 2a4866c2a512..886c495d2f5c 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -240,7 +240,7 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_nls,
+	Opt_iocharset,
 	Opt_prealloc,
 	Opt_no_acs_rules,
 	Opt_err,
@@ -260,9 +260,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
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
 // clang-format on
@@ -342,7 +346,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc, struct fs_parameter *param
 	case Opt_showmeta:
 		opts->showmeta = result.negated ? 0 : 1;
 		break;
-	case Opt_nls:
+	case Opt_iocharset:
 		unload_nls(opts->nls);
 
 		opts->nls = ntfs_load_nls(param->string);
@@ -529,9 +533,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
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

