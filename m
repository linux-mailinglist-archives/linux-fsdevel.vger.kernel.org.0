Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E90DA20C155
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jun 2020 14:58:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbgF0M4E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 27 Jun 2020 08:56:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726402AbgF0M4D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 27 Jun 2020 08:56:03 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D5CC03E979;
        Sat, 27 Jun 2020 05:56:03 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so6087878pjd.0;
        Sat, 27 Jun 2020 05:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGvZib8pdw3S5tlf2fLr9MTmZjnf+euhMJXGijUwvfw=;
        b=aYwbbD/J1SI38fp02GDl82/GSSX9R02Ewea3Re0BXnrbRfsdZqIo/UtgbmebQMNKxs
         guZtJS/EMfpLcYhwjQtnkDF63ioRJeB8aW2icRTjzyJdkfv9ytIj5uS7JpL1aYZG7Rwo
         l0CtetgR3mdslTKD8MyQsrvHwhIu+NL69PUSajfJKBwOdK5PsFOFFRY7l6rp+kM6wqZ3
         5HKs6ULkpo5XQxFXoZAIkrCPPNdUJef6uMnzTL85FZhM4J2L1J0fuPejiRl9v4mN/HHy
         71Avk3D5c6C1y0Wh27LbkSOnzhVJe9W744JI3YG++0m3uwKRY2PSvRV2QS4gbvQzK3A8
         RHdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OGvZib8pdw3S5tlf2fLr9MTmZjnf+euhMJXGijUwvfw=;
        b=pxJyxNdVpQCWD9oM42z8fHzGg9Rl24/eZbStYcFFWFZyIjlEww+zmw7ZtNxLi6Ru5z
         CB7TnFRermaIssqG8oobL9DmRpRNaFTkd0K1reqn8AVdDCySYsvXuRaYHWXDHTP7jOwQ
         ZlmPkSLIvouV0eepIKPOGGV7MoqN4rzMbo63CPBw1FQrlaKqVIc83GpeHOQNsB2yvvhy
         LeLO+IJJ3eOQcjehq64kgm4a7X4aDxkSOEtufZ6zyDb95cRT69Ccc2/CTudX1ileOury
         NtOm97NcLVAZA0eZPUTuVY7q+8QAtccZtOtgBCgsI9Z3p2dI1PYEilPwU11EUdw3BKq1
         6eGg==
X-Gm-Message-State: AOAM533o6WUVitefA8xz7BTAY/eq+wjBP+tj/oIv7tAIGdi2tlljN6zP
        +9ak/WNkeIyMY+u4+9k6WTquglHJfDgjHw==
X-Google-Smtp-Source: ABdhPJzLmyVikN5w48/X6MhRGaWzTPhpgXGppM+9aXL0CyTAu7JOQk/LEbxCUKt6DQ7oSuA38j1o0w==
X-Received: by 2002:a17:90b:a11:: with SMTP id gg17mr8499048pjb.74.1593262562502;
        Sat, 27 Jun 2020 05:56:02 -0700 (PDT)
Received: from localhost.localdomain ([211.195.169.54])
        by smtp.gmail.com with ESMTPSA id o1sm13873552pjp.37.2020.06.27.05.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2020 05:56:02 -0700 (PDT)
From:   Park Ju Hyung <qkrwngud825@gmail.com>
To:     linux-fsdevel@vger.kernel.org
Cc:     Park Ju Hyung <qkrwngud825@gmail.com>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] exfat: implement "quiet" option for setattr
Date:   Sat, 27 Jun 2020 21:55:09 +0900
Message-Id: <20200627125509.142393-1-qkrwngud825@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Few programs, especially old ones, simply don't want to work
if there isn't a POSIX-compliant setattr.

Follow vfat and implement a new "quiet" option to workaround this.

Signed-off-by: Park Ju Hyung <qkrwngud825@gmail.com>
---
 fs/exfat/exfat_fs.h |  2 ++
 fs/exfat/file.c     | 13 +++++++++++--
 fs/exfat/super.c    |  7 +++++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/fs/exfat/exfat_fs.h b/fs/exfat/exfat_fs.h
index 3aed8e22087a..66837baf42d2 100644
--- a/fs/exfat/exfat_fs.h
+++ b/fs/exfat/exfat_fs.h
@@ -201,6 +201,8 @@ struct exfat_mount_options {
 	unsigned short allow_utime;
 	/* charset for filename input/display */
 	char *iocharset;
+	/* fake return success on setattr(e.g. chmods/chowns) */
+	unsigned char quiet;
 	/* on error: continue, panic, remount-ro */
 	enum exfat_error_mode errors;
 	unsigned utf8:1, /* Use of UTF-8 character set */
diff --git a/fs/exfat/file.c b/fs/exfat/file.c
index 6707f3eb09b5..2ed6be7cab15 100644
--- a/fs/exfat/file.c
+++ b/fs/exfat/file.c
@@ -295,7 +295,7 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 	    attr->ia_size > i_size_read(inode)) {
 		error = exfat_cont_expand(inode, attr->ia_size);
 		if (error || attr->ia_valid == ATTR_SIZE)
-			return error;
+			goto out;
 		attr->ia_valid &= ~ATTR_SIZE;
 	}
 
@@ -309,8 +309,11 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 
 	error = setattr_prepare(dentry, attr);
 	attr->ia_valid = ia_valid;
-	if (error)
+	if (error) {
+		if (sbi->options.quiet)
+			error = 0;
 		goto out;
+	}
 
 	if (((attr->ia_valid & ATTR_UID) &&
 	     !uid_eq(attr->ia_uid, sbi->options.fs_uid)) ||
@@ -322,6 +325,12 @@ int exfat_setattr(struct dentry *dentry, struct iattr *attr)
 		goto out;
 	}
 
+	if (error) {
+		if (sbi->options.quiet)
+			error = 0;
+		goto out;
+	}
+
 	/*
 	 * We don't return -EPERM here. Yes, strange, but this is too
 	 * old behavior.
diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index b5bf6dedbe11..030db33eed35 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -145,6 +145,8 @@ static int exfat_show_options(struct seq_file *m, struct dentry *root)
 	seq_printf(m, ",fmask=%04o,dmask=%04o", opts->fs_fmask, opts->fs_dmask);
 	if (opts->allow_utime)
 		seq_printf(m, ",allow_utime=%04o", opts->allow_utime);
+	if (opts->quiet)
+		seq_puts(m, ",quiet");
 	if (opts->utf8)
 		seq_puts(m, ",iocharset=utf8");
 	else if (sbi->nls_io)
@@ -198,6 +200,7 @@ enum {
 	Opt_fmask,
 	Opt_allow_utime,
 	Opt_charset,
+	Opt_quiet,
 	Opt_errors,
 	Opt_discard,
 	Opt_time_offset,
@@ -224,6 +227,7 @@ static const struct fs_parameter_spec exfat_parameters[] = {
 	fsparam_u32oct("fmask",			Opt_fmask),
 	fsparam_u32oct("allow_utime",		Opt_allow_utime),
 	fsparam_string("iocharset",		Opt_charset),
+	fsparam_flag("quiet",			Opt_quiet),
 	fsparam_enum("errors",			Opt_errors, exfat_param_enums),
 	fsparam_flag("discard",			Opt_discard),
 	fsparam_s32("time_offset",		Opt_time_offset),
@@ -274,6 +278,9 @@ static int exfat_parse_param(struct fs_context *fc, struct fs_parameter *param)
 		opts->iocharset = param->string;
 		param->string = NULL;
 		break;
+	case Opt_quiet:
+		opts->quiet = 1;
+		break;
 	case Opt_errors:
 		opts->errors = result.uint_32;
 		break;
-- 
2.27.0

