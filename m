Return-Path: <linux-fsdevel+bounces-20300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DCC38D137C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB6C7283B5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0F1BC4B;
	Tue, 28 May 2024 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QxlsmdyS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E531BDD3;
	Tue, 28 May 2024 04:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871025; cv=none; b=m2gpT5+ZJ54k36XTdqdAprr85h2tkQJFsR5KL5+UNiS76T1c8mmgSwZyXpOIUohAqfe4gj9GCbY7SxwltAVQ0sVoafRQiMUiIDZ8otCzYjLR7LX4cALxvhR6nphdlzqUi+3033AaSfZJD3x/zfk3W+Q+VglIalH8QL/IrGs8xw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871025; c=relaxed/simple;
	bh=Dp1AbvHvXEhdy6ILD8tpg7SuF0EVxUD+o/6ocDsVkRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4SOdtRs+qSjXk4q2QBUQhb3fCIllbLfNynQR+jze2S/+VcgruhnlQj/jNF+G/IAFewYB0fou5CCJfKosIHfw5iOaubQ+bpjcJEY1WsuhLv5xJS68dAdvpo5H2qqndX6pzoFzl4pJbMqY2yurjw9K0UUJWmxsV2HFGcBm8twzhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QxlsmdyS; arc=none smtp.client-ip=209.85.166.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-3737b412ad6so2132755ab.2;
        Mon, 27 May 2024 21:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716871023; x=1717475823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aLKwbY3XDeFZ182F0IBS4mBhDQ5DCCmgeBoMZt6z/mw=;
        b=QxlsmdySuXdPnZtgStzXR3tGOPwJS8pDKcHrHLYr6OIPYycjAkEYwSTGiiMzQYA+Qq
         717izCTUrqqRalaH//NLgOgMmZTCG9r1msb8e6v/XIJ27jhE7qV/IQxnBdey43BNM5zM
         JA4oDbtXBwGfkvDvkrR5Fzj/DaadW8zFp2ZXVKVDlk21BrR7tmZsRwlEGqnDfixa+iQo
         34nbM+EBC3g3ivxbFV8g5BCHOsFm8fNwJt9/LCm12/m5szbnLQ5BGcEfIZFrov43lnPD
         iJv78JtvQ8F2j6fuFif/spOI2uOSkowNoXWDnSqK9O7ExtMrMCbPYEyA4a7P7706hWT9
         45OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716871023; x=1717475823;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aLKwbY3XDeFZ182F0IBS4mBhDQ5DCCmgeBoMZt6z/mw=;
        b=nY5IuKMLl3RkGWXDpRAJMdjkcpHKcFSTXEBwwPUgD7d3/x6GEyfZ3D1qHKxMINXeXx
         5YUFHrFZqVEffp1ZVL6x+kqyTI0RS7CeOCyf3S+wIJCqhrTrCXZmwvE7o/C5nNCEeuDO
         nM6/jZgw5yRxqaLQDiNL3eoLzGtp6s6/AJYAxgoxvysXEDxImFBDJvrLRX6oUAOPqj3y
         ZpZm9CmZx8VlICaioSISMRCYd0tZj2hdUJILo/1tvM6vvu9TKuap2wYb95GFw7PXlCRa
         jeXpzbAQ00gvaZdgyxAwnslfxWqxSQuSoVlcdZirw9uHLlKqDmX1C2APi2TT2WqEM5xC
         jzFg==
X-Forwarded-Encrypted: i=1; AJvYcCUYe/dEkcUTnnvd0wEYK1fOIIfxC0nZm6D03PSfeRkXHj79WOnu8X9to4+hR9a8jHGNa05CR8PX8+7Iz3jvfAGmINWopmYDPcVPz/TW75y/el6+YNgjsR1ggK9VYR32r3SgemSpnuDVnXFI4UGm
X-Gm-Message-State: AOJu0YzvGePmIUNo6dV7ZbZwBVrfU5EZLiPJA53V2+BtZ4N7o1n7hjxs
	xfmGjXbk5antT8uBki13Q00uvvNnt602fc8WUlcZDZNlaRM3h27p
X-Google-Smtp-Source: AGHT+IENarS7kWNwGSa/1qh0U+hGYWb4AepZPt05xm+T5O8rQNAdHh0EZ68k+Lj7DeZhyb+4clq2qg==
X-Received: by 2002:a92:c26d:0:b0:36b:3b10:7419 with SMTP id e9e14a558f8ab-3737b302a5cmr122976485ab.32.1716871023030;
        Mon, 27 May 2024 21:37:03 -0700 (PDT)
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737d1468b7sm18013605ab.26.2024.05.27.21.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:37:02 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	sandeen@redhat.com,
	dhowells@redhat.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH 3/3] bcachefs: use new mount API
Date: Mon, 27 May 2024 22:36:11 -0600
Message-ID: <20240528043612.812644-4-tahbertschinger@gmail.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240528043612.812644-1-tahbertschinger@gmail.com>
References: <20240528043612.812644-1-tahbertschinger@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This updates bcachefs to use the new mount API:

- Update the file_system_type to use the new init_fs_context()
  function.

- Define the new fs_context_operations functions.

- No longer register bch2_mount() and bch2_remount(); these are now
  called via the new fs_context functions.

- Define a new helper type, bch2_opts_parse that includes a struct
  bch_opts and additionally a printbuf used to save options that can't
  be parsed until after the FS is opened. This enables us to parse as
  many options as possible prior to opening the filesystem while saving
  those options that need the open FS for later parsing.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/bcachefs/fs.c   | 113 ++++++++++++++++++++++++++++++++++++---------
 fs/bcachefs/opts.h |   7 +++
 2 files changed, 99 insertions(+), 21 deletions(-)

diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 662d0c9bb3c2..29aca0d961b3 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -31,6 +31,7 @@
 #include <linux/backing-dev.h>
 #include <linux/exportfs.h>
 #include <linux/fiemap.h>
+#include <linux/fs_context.h>
 #include <linux/module.h>
 #include <linux/pagemap.h>
 #include <linux/posix_acl.h>
@@ -1708,16 +1709,12 @@ static struct bch_fs *bch2_path_to_fs(const char *path)
 	return c ?: ERR_PTR(-ENOENT);
 }
 
-static int bch2_remount(struct super_block *sb, int *flags, char *data)
+static int bch2_remount(struct super_block *sb, int *flags,
+			struct bch_opts opts)
 {
 	struct bch_fs *c = sb->s_fs_info;
-	struct bch_opts opts = bch2_opts_empty();
 	int ret;
 
-	ret = bch2_parse_mount_opts(c, &opts, NULL, data);
-	if (ret)
-		goto err;
-
 	opt_set(opts, read_only, (*flags & SB_RDONLY) != 0);
 
 	if (opts.read_only != c->opts.read_only) {
@@ -1843,7 +1840,6 @@ static const struct super_operations bch_super_operations = {
 	.statfs		= bch2_statfs,
 	.show_devname	= bch2_show_devname,
 	.show_options	= bch2_show_options,
-	.remount_fs	= bch2_remount,
 	.put_super	= bch2_put_super,
 	.freeze_fs	= bch2_freeze,
 	.unfreeze_fs	= bch2_unfreeze,
@@ -1877,22 +1873,17 @@ static int bch2_test_super(struct super_block *s, void *data)
 }
 
 static struct dentry *bch2_mount(struct file_system_type *fs_type,
-				 int flags, const char *dev_name, void *data)
+				 int flags, const char *dev_name,
+				 struct bch2_opts_parse opts_parse)
 {
 	struct bch_fs *c;
 	struct super_block *sb;
 	struct inode *vinode;
-	struct bch_opts opts = bch2_opts_empty();
+	struct bch_opts opts = opts_parse.opts;
 	int ret;
 
 	opt_set(opts, read_only, (flags & SB_RDONLY) != 0);
 
-	ret = bch2_parse_mount_opts(NULL, &opts, NULL, data);
-	if (ret) {
-		ret = bch2_err_class(ret);
-		return ERR_PTR(ret);
-	}
-
 	if (!dev_name || strlen(dev_name) == 0)
 		return ERR_PTR(-EINVAL);
 
@@ -1921,7 +1912,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 	}
 
 	/* Some options can't be parsed until after the fs is started: */
-	ret = bch2_parse_mount_opts(c, &opts, NULL, data);
+	ret = bch2_parse_mount_opts(c, &opts, NULL, opts_parse.parse_later.buf);
 	if (ret) {
 		bch2_fs_stop(c);
 		sb = ERR_PTR(ret);
@@ -2027,12 +2018,92 @@ static void bch2_kill_sb(struct super_block *sb)
 	bch2_fs_free(c);
 }
 
+static void bch2_fs_context_free(struct fs_context *fc)
+{
+	struct bch2_opts_parse *opts = fc->fs_private;
+
+	if (opts) {
+		printbuf_exit(&opts->parse_later);
+		kfree(opts);
+	}
+}
+
+static int bch2_fs_parse_param(struct fs_context *fc,
+			       struct fs_parameter *param)
+{
+	/*
+	 * the "source" param, i.e., the name of the device(s) to mount,
+	 * is handled by the VFS layer.
+	 */
+	if (!strcmp(param->key, "source"))
+		return -ENOPARAM;
+
+	struct bch2_opts_parse *opts = fc->fs_private;
+	struct bch_fs *c = NULL;
+
+	/* for reconfigure, we already have a struct bch_fs */
+	if (fc->root)
+		c = fc->root->d_sb->s_fs_info;
+
+	int ret = bch2_parse_one_mount_opt(c, &opts->opts,
+					   &opts->parse_later, param->key,
+					   param->string);
+
+	return bch2_err_class(ret);
+}
+
+static int bch2_fs_get_tree(struct fs_context *fc)
+{
+	struct bch2_opts_parse *opts = fc->fs_private;
+	const char *dev_name = fc->source;
+	struct dentry *root;
+
+	root = bch2_mount(fc->fs_type, fc->sb_flags, dev_name, *opts);
+
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	fc->root = root;
+
+	return 0;
+}
+
+static int bch2_fs_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	struct bch2_opts_parse *opts = fc->fs_private;
+
+	return bch2_remount(sb, &fc->sb_flags, opts->opts);
+}
+
+static const struct fs_context_operations bch2_context_ops = {
+	.free        = bch2_fs_context_free,
+	.parse_param = bch2_fs_parse_param,
+	.get_tree    = bch2_fs_get_tree,
+	.reconfigure = bch2_fs_reconfigure,
+};
+
+static int bch2_init_fs_context(struct fs_context *fc)
+{
+	struct bch2_opts_parse *opts = kzalloc(sizeof(*opts), GFP_KERNEL);
+
+	if (!opts)
+		return -ENOMEM;
+
+	opts->parse_later = PRINTBUF;
+
+	fc->ops = &bch2_context_ops;
+	fc->fs_private = opts;
+
+	return 0;
+}
+
 static struct file_system_type bcache_fs_type = {
-	.owner		= THIS_MODULE,
-	.name		= "bcachefs",
-	.mount		= bch2_mount,
-	.kill_sb	= bch2_kill_sb,
-	.fs_flags	= FS_REQUIRES_DEV,
+	.owner			= THIS_MODULE,
+	.name			= "bcachefs",
+	.init_fs_context	= bch2_init_fs_context,
+	.kill_sb		= bch2_kill_sb,
+	.fs_flags		= FS_REQUIRES_DEV,
 };
 
 MODULE_ALIAS_FS("bcachefs");
diff --git a/fs/bcachefs/opts.h b/fs/bcachefs/opts.h
index 03358655d9ab..cff35845aaf6 100644
--- a/fs/bcachefs/opts.h
+++ b/fs/bcachefs/opts.h
@@ -488,6 +488,13 @@ struct bch_opts {
 #undef x
 };
 
+struct bch2_opts_parse {
+	struct bch_opts opts;
+
+	/* to save opts that can't be parsed before the FS is opened: */
+	struct printbuf parse_later;
+};
+
 static const __maybe_unused struct bch_opts bch2_opts_default = {
 #define x(_name, _bits, _mode, _type, _sb_opt, _default, ...)		\
 	._name##_defined = true,					\
-- 
2.45.0


