Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1937A3FAA98
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235181AbhH2J5x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbhH2J5s (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:48 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B06C061756;
        Sun, 29 Aug 2021 02:56:56 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id w4so20052300ljh.13;
        Sun, 29 Aug 2021 02:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQd2rP5z5neQZUgk+5RzW3oFnwLepeMEfmyuxIVBcHw=;
        b=lwXV7aagUV2AlWNCICOKtqOGMZvaI4gN0UPgc7ujv/8pF2dmy9+CAX6EHRwZjSs1ak
         ZOkto5zpFZFo7QeJZTG1q16sMPmUNKmGdkdY7zouCYFn1LQKbmEfTrcLFhCRq9T24kUh
         t4KMUZzmlp9Z9b4Poos7KpJmI0dn1MhPGiYyoTaSLAnrKNSsdle5gadx04zSokEyABb+
         k7oOJ6cvhjPaD3LfhWsga3Cw4ECTBsQYDHqcN/qK7vsSzXa4TfD4PITlewOC6MBDU4OO
         OZOlglo/kmWu6NOmvM9KLJEBo+CvBeXRvO+r1HNseYTzuxVmERiqo1ZNyuoj1byzJ+DL
         vwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQd2rP5z5neQZUgk+5RzW3oFnwLepeMEfmyuxIVBcHw=;
        b=ssL6R2t1o1BITXNWEF46PeTfiLX3TrNhBnFFd6XbLuYED8pV6U10yKHnC5IhCIQB5c
         rDwghKIaJrAPAGhPBBuKFwWeZywuo/k5nEhmLpecBecLNgHbWkpwyjDZjq++xQ+EXjUT
         E1Q3sfQ/36pKv0SxI5sxq2VAuOOMvDyOPYDJmDabjA3YjRTZf7rHl/3scYG+RdKv31sr
         VymtQjAKdiM7mj4H6ZqSfSDkYjO4WGE7SYic1X5Iu2qNWYY/HIpnKxJGfJ2AQU3moRVf
         jAeGO0kJCWY/FHADfs86t6+WO1d+ENy6YZMA3aQg5vp4Ldz0WVvYpgp2jBCujn1LLOwE
         Z3tQ==
X-Gm-Message-State: AOAM531uN8E9FqNnuNLFmV3NB5pe5zKoNNKGueG5C+e1MVxraqOfCGVj
        ORluy+/ruYpvj+MU5MoWMFg=
X-Google-Smtp-Source: ABdhPJzUAdVzKmx1iDF4WfSe2NFUFUd1UHkrVACgSYPcG/QBd9F4FrK8xl8iqmJNfSTBUO3Oo6XgFw==
X-Received: by 2002:a05:651c:1126:: with SMTP id e6mr15733463ljo.28.1630231014546;
        Sun, 29 Aug 2021 02:56:54 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:54 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 7/9] fs/ntfs3: Add iocharset= mount option as alias for nls=
Date:   Sun, 29 Aug 2021 12:56:12 +0300
Message-Id: <20210829095614.50021-8-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
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
index 52e0dc45e060..e5c319604c4d 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -219,7 +219,7 @@ enum Opt {
 	Opt_nohidden,
 	Opt_showmeta,
 	Opt_acl,
-	Opt_nls,
+	Opt_iocharset,
 	Opt_prealloc,
 	Opt_no_acs_rules,
 	Opt_err,
@@ -238,9 +238,13 @@ static const struct fs_parameter_spec ntfs_fs_parameters[] = {
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
 
@@ -339,7 +343,7 @@ static int ntfs_fs_parse_param(struct fs_context *fc,
 	case Opt_showmeta:
 		opts->showmeta = result.negated ? 0 : 1;
 		break;
-	case Opt_nls:
+	case Opt_iocharset:
 		kfree(opts->nls_name);
 		opts->nls_name = param->string;
 		param->string = NULL;
@@ -373,11 +377,11 @@ static int ntfs_fs_reconfigure(struct fs_context *fc)
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
 
@@ -519,9 +523,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
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

