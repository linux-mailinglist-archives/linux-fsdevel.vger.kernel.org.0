Return-Path: <linux-fsdevel+bounces-20298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 589F48D137A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 06:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0667C283C5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 04:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D441BC4B;
	Tue, 28 May 2024 04:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D9fzjt7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C00E182B3;
	Tue, 28 May 2024 04:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716871016; cv=none; b=SetW8MQ8guMiCfoBt+IyLBA7fOvg79Bg+dCLm9ImZzeKx/rHlKZyT9OU1qT099mUenh/bLfiw/RLwGDlER+mopUimgpJT5ZOY6JIrV8g7gsF3ix5ePc+KYgRbnIjvR8nbm4vdkXFnLJo95BulQUBgQjVoBiFILHBPuNosBBzYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716871016; c=relaxed/simple;
	bh=DYpY7CGnWIgCUiQrkp3N5Rl2SrjhQSquzDX8QPPMWug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe9yBhZUy32J1OQ0N9A2BJMT2HiiUGIczP93+epib2QJ+3EffLA/EXM63u0i8vJ1NHe1Ru0CoMuO4USNHYGhON0YO0E8Ia89gRtN/J1jsO09s58NVAW9CU5QPv5GPBKpaHLsxsk0JGWpzGF7rXgDVEcD7I0OUbXriVeyN7xw8qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D9fzjt7P; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3737b33270aso1761095ab.1;
        Mon, 27 May 2024 21:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716871014; x=1717475814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YOYkf3b0vtTc/39kRephwiKq9G35lqOqtZARqyGpqB8=;
        b=D9fzjt7Pa+82BgtSZCRHvLwsf0WUCAyC56um/RV0/ybzsrpuH9ooHmgEjYMIHCqRIm
         5F6fjPDQyTJxuBS5HVi8ErRK6sc0SYtbg6bPj51AJeVbsUrlJCuy+uHyvo7k6F8yk9jS
         ZupvlgL90ek53g9/785+f82QjAkYrx1c3fXEN5k84oKrONjnMoLa9dWxReM/OjKOGPpk
         zsbgLgKmoJVHps3iP6BgyNcDLwGdHTkh2Wa5nXWDkOq53vqdviPy4yt/EOzsOty+hkUh
         1v54ksb9TocvFWnzsB+MnzmM/w+IM42A4a/sPNeHauTsw7Z64VD0PPzUgmVINmefeS/8
         8b0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716871014; x=1717475814;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YOYkf3b0vtTc/39kRephwiKq9G35lqOqtZARqyGpqB8=;
        b=ZawJIKJz7QZfDNgBE35nEICrQXZzReiusypn6cfimiDwj2HB6cxV9bVNvUczNPBACQ
         P0Pua8C2snVsktQhygaKsgzyyzHqj2nb+Po2U4XJBDGPf+87qJ99GTTrMiY+jfRXB2NK
         S0P3G01/2QfVBnQ2s1tuKTEXPFWdS5vOz5v3hU+QM6otIrRGEm4iGURBXI0cEkSe3/HB
         qcos5LSiCoYqZqNU4rqXNM7jbZiR9V5bqW1weOo2+W/oiMcgESB/NitzfO/Z8jUIUGfM
         PrERb+oZ+s3+OblxuT3IAFcqbBukFB1cNVnYu1ZMSF3Trkf2yplH7MLSEG9UiLO9nQFd
         IETA==
X-Forwarded-Encrypted: i=1; AJvYcCUq3dlj93CGI7Y4HeSBL5ebSbC2AWapgjXBniYrkAVYjDUND7D3tMwgpYT0OviMSodI1Y9RdcBEep6ugAlA+1BpX36VkiHfvMhZe9ZCWm1dC7foHvcQAsV+8sz/KMuoh8//VLv/rIwkCGVsCu0J
X-Gm-Message-State: AOJu0Yxmt5tK/AOC5l8pDTEWcyGAUeHWpGhbL1LwTenaHe7h/5BG4rLP
	M0RCgq5vew4cH/LLLUI5xdPiM7y0de1CjU23TOnVnsnFJ5MTVtN6
X-Google-Smtp-Source: AGHT+IEj6TJElketHQPLu/MwhR3meXGMGRBermQYmLTxIiwlSXBMx6/ckK7Gm4lKFKdlqajlkWulYQ==
X-Received: by 2002:a05:6e02:216e:b0:36c:80b6:9a28 with SMTP id e9e14a558f8ab-3737b300348mr123466775ab.18.1716871014001;
        Mon, 27 May 2024 21:36:54 -0700 (PDT)
Received: from fedora-laptop.hsd1.nm.comcast.net (c-73-127-246-43.hsd1.nm.comcast.net. [73.127.246.43])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3737d1468b7sm18013605ab.26.2024.05.27.21.36.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:36:53 -0700 (PDT)
From: Thomas Bertschinger <tahbertschinger@gmail.com>
To: kent.overstreet@linux.dev,
	linux-bcachefs@vger.kernel.org,
	bfoster@redhat.com,
	linux-fsdevel@vger.kernel.org,
	sandeen@redhat.com,
	dhowells@redhat.com
Cc: Thomas Bertschinger <tahbertschinger@gmail.com>
Subject: [PATCH 1/3] bcachefs: add printbuf arg to bch2_parse_mount_opts()
Date: Mon, 27 May 2024 22:36:09 -0600
Message-ID: <20240528043612.812644-2-tahbertschinger@gmail.com>
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

Mount options that take the name of a device that may be part of a
filesystem, for example "metadata_target", cannot be validated until
after the filesystem has been opened. However, an attempt to parse those
options may be made prior to the filesystem being opened.

This change adds a printbuf parameter to bch2_parse_mount_opts() which
will be used to save those mount options, when they are supplied prior
to the FS being opened, so that they can be parsed later.

This functionality is not currently needed, but will be used after
bcachefs starts using the new mount API to parse mount options. This is
because using the new mount API, we will process mount options prior to
opening the FS, but the new API doesn't provide a convenient way to
"replay" mount option parsing. So we save these options ourselves to
accomplish this.

This change also splits out the code to parse a single option into
bch2_parse_one_mount_opt(), which will be useful when using the new
mount API which deals with a single mount option at a time.

Signed-off-by: Thomas Bertschinger <tahbertschinger@gmail.com>
---
 fs/bcachefs/chardev.c |   4 +-
 fs/bcachefs/fs.c      |   6 +--
 fs/bcachefs/opts.c    | 105 +++++++++++++++++++++++++-----------------
 fs/bcachefs/opts.h    |   5 +-
 4 files changed, 71 insertions(+), 49 deletions(-)

diff --git a/fs/bcachefs/chardev.c b/fs/bcachefs/chardev.c
index 5040c584cd72..b59570f688db 100644
--- a/fs/bcachefs/chardev.c
+++ b/fs/bcachefs/chardev.c
@@ -227,7 +227,7 @@ static long bch2_ioctl_fsck_offline(struct bch_ioctl_fsck_offline __user *user_a
 		}
 
 		ret =   PTR_ERR_OR_ZERO(optstr) ?:
-			bch2_parse_mount_opts(NULL, &thr->opts, optstr);
+			bch2_parse_mount_opts(NULL, &thr->opts, NULL, optstr);
 		kfree(optstr);
 
 		if (ret)
@@ -862,7 +862,7 @@ static long bch2_ioctl_fsck_online(struct bch_fs *c,
 		char *optstr = strndup_user((char __user *)(unsigned long) arg.opts, 1 << 16);
 
 		ret =   PTR_ERR_OR_ZERO(optstr) ?:
-			bch2_parse_mount_opts(c, &thr->opts, optstr);
+			bch2_parse_mount_opts(c, &thr->opts, NULL, optstr);
 		kfree(optstr);
 
 		if (ret)
diff --git a/fs/bcachefs/fs.c b/fs/bcachefs/fs.c
index 96040a95cf46..662d0c9bb3c2 100644
--- a/fs/bcachefs/fs.c
+++ b/fs/bcachefs/fs.c
@@ -1714,7 +1714,7 @@ static int bch2_remount(struct super_block *sb, int *flags, char *data)
 	struct bch_opts opts = bch2_opts_empty();
 	int ret;
 
-	ret = bch2_parse_mount_opts(c, &opts, data);
+	ret = bch2_parse_mount_opts(c, &opts, NULL, data);
 	if (ret)
 		goto err;
 
@@ -1887,7 +1887,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 
 	opt_set(opts, read_only, (flags & SB_RDONLY) != 0);
 
-	ret = bch2_parse_mount_opts(NULL, &opts, data);
+	ret = bch2_parse_mount_opts(NULL, &opts, NULL, data);
 	if (ret) {
 		ret = bch2_err_class(ret);
 		return ERR_PTR(ret);
@@ -1921,7 +1921,7 @@ static struct dentry *bch2_mount(struct file_system_type *fs_type,
 	}
 
 	/* Some options can't be parsed until after the fs is started: */
-	ret = bch2_parse_mount_opts(c, &opts, data);
+	ret = bch2_parse_mount_opts(c, &opts, NULL, data);
 	if (ret) {
 		bch2_fs_stop(c);
 		sb = ERR_PTR(ret);
diff --git a/fs/bcachefs/opts.c b/fs/bcachefs/opts.c
index bb068fd72465..e794706276cf 100644
--- a/fs/bcachefs/opts.c
+++ b/fs/bcachefs/opts.c
@@ -460,14 +460,70 @@ int bch2_opts_check_may_set(struct bch_fs *c)
 	return 0;
 }
 
+int bch2_parse_one_mount_opt(struct bch_fs *c, struct bch_opts *opts,
+			     struct printbuf *parse_later,
+			     const char *name, const char *val)
+{
+	struct printbuf err = PRINTBUF;
+	u64 v;
+	int ret, id;
+
+	id = bch2_mount_opt_lookup(name);
+
+	/* Check for the form "noopt", negation of a boolean opt: */
+	if (id < 0 &&
+	    !val &&
+	    !strncmp("no", name, 2)) {
+		id = bch2_mount_opt_lookup(name + 2);
+		val = "0";
+	}
+
+	/* Unknown options are ignored: */
+	if (id < 0)
+		return 0;
+
+	if (!(bch2_opt_table[id].flags & OPT_MOUNT))
+		goto bad_opt;
+
+	if (id == Opt_acl &&
+	    !IS_ENABLED(CONFIG_BCACHEFS_POSIX_ACL))
+		goto bad_opt;
+
+	if ((id == Opt_usrquota ||
+	     id == Opt_grpquota) &&
+	    !IS_ENABLED(CONFIG_BCACHEFS_QUOTA))
+		goto bad_opt;
+
+	ret = bch2_opt_parse(c, &bch2_opt_table[id], val, &v, &err);
+	if (ret < 0)
+		goto bad_val;
+
+	if (opts)
+		bch2_opt_set_by_id(opts, id, v);
+
+	ret = 0;
+	goto out;
+
+bad_opt:
+	pr_err("Bad mount option %s", name);
+	ret = -BCH_ERR_option_name;
+	goto out;
+
+bad_val:
+	pr_err("Invalid mount option %s", err.buf);
+	ret = -BCH_ERR_option_value;
+
+out:
+	printbuf_exit(&err);
+	return ret;
+}
+
 int bch2_parse_mount_opts(struct bch_fs *c, struct bch_opts *opts,
-			  char *options)
+			  struct printbuf *parse_later, char *options)
 {
 	char *copied_opts, *copied_opts_start;
 	char *opt, *name, *val;
-	int ret, id;
-	struct printbuf err = PRINTBUF;
-	u64 v;
+	int ret;
 
 	if (!options)
 		return 0;
@@ -488,53 +544,16 @@ int bch2_parse_mount_opts(struct bch_fs *c, struct bch_opts *opts,
 		name	= strsep(&opt, "=");
 		val	= opt;
 
-		id = bch2_mount_opt_lookup(name);
-
-		/* Check for the form "noopt", negation of a boolean opt: */
-		if (id < 0 &&
-		    !val &&
-		    !strncmp("no", name, 2)) {
-			id = bch2_mount_opt_lookup(name + 2);
-			val = "0";
-		}
-
-		/* Unknown options are ignored: */
-		if (id < 0)
-			continue;
-
-		if (!(bch2_opt_table[id].flags & OPT_MOUNT))
-			goto bad_opt;
-
-		if (id == Opt_acl &&
-		    !IS_ENABLED(CONFIG_BCACHEFS_POSIX_ACL))
-			goto bad_opt;
-
-		if ((id == Opt_usrquota ||
-		     id == Opt_grpquota) &&
-		    !IS_ENABLED(CONFIG_BCACHEFS_QUOTA))
-			goto bad_opt;
-
-		ret = bch2_opt_parse(c, &bch2_opt_table[id], val, &v, &err);
+		ret = bch2_parse_one_mount_opt(c, opts, parse_later, name, val);
 		if (ret < 0)
-			goto bad_val;
-
-		bch2_opt_set_by_id(opts, id, v);
+			goto out;
 	}
 
 	ret = 0;
 	goto out;
 
-bad_opt:
-	pr_err("Bad mount option %s", name);
-	ret = -BCH_ERR_option_name;
-	goto out;
-bad_val:
-	pr_err("Invalid mount option %s", err.buf);
-	ret = -BCH_ERR_option_value;
-	goto out;
 out:
 	kfree(copied_opts_start);
-	printbuf_exit(&err);
 	return ret;
 }
 
diff --git a/fs/bcachefs/opts.h b/fs/bcachefs/opts.h
index f902793e1810..03358655d9ab 100644
--- a/fs/bcachefs/opts.h
+++ b/fs/bcachefs/opts.h
@@ -566,7 +566,10 @@ void bch2_opt_to_text(struct printbuf *, struct bch_fs *, struct bch_sb *,
 
 int bch2_opt_check_may_set(struct bch_fs *, int, u64);
 int bch2_opts_check_may_set(struct bch_fs *);
-int bch2_parse_mount_opts(struct bch_fs *, struct bch_opts *, char *);
+int bch2_parse_one_mount_opt(struct bch_fs *, struct bch_opts *,
+			     struct printbuf *, const char *, const char *);
+int bch2_parse_mount_opts(struct bch_fs *, struct bch_opts *, struct printbuf *,
+			  char *);
 
 /* inode opts: */
 
-- 
2.45.0


