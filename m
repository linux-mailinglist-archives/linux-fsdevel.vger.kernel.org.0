Return-Path: <linux-fsdevel+bounces-57126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D48B1EEDC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE2497B3AD4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:29:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC93C2882C8;
	Fri,  8 Aug 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiB0EBSS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952D1DF974
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754681427; cv=none; b=MiSF4MD/v2iC75eLO6rfcxz5uYJbXOKQ4etDN+YvWTlI3fAk4jQNNFDlPVbNn06+sr6iW49oYvCnEnTgdeghKgLlXWQNc+PW2ceRIHAVgLFKevHEmEEFAkq4Uj5AkMx1U+v3nwWTXWB7UGWQilo67/V+MEaPb7GUIIE52l/SS3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754681427; c=relaxed/simple;
	bh=pAsDxoioKGjMpCxmNYB0gZAgeQyYwmctjPJMVU9X5Vw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gtXZ3hGr4m+PMJ7ioTtuNIo7ovUmsAl+QbaU1mhe1pgMcREsmAiFYGBAtLvsz3oC4SUML3fCKBwnCSe2Co5vs1ChLsbwSGGwcWof2sY/EAMSOZPisfgwf5phr6HnT0DT8WwxSioz2yEmLBXF7utCCt4PZLmQZTDOAjqhr0524FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiB0EBSS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1754681424;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vZrNM7cLyW6ZntVepWfRx2E68nay34sv/K0xEhdtwxc=;
	b=HiB0EBSSrXefvtzH8KXhg7sMhj9LmtW/Ayj+1gVxEnw4xZC9+o94Aoc5HhzX3qP4lkwWrt
	qteNPbaYUFpB6V0rK0AR0sr3DolRbcpBQaA0ihowW46u9xiaIcoQRj/DeGm8huAENYKkud
	qz9uU2m2UW1yJiGNWz12LXgLXdXveUE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-14-C0X0L-WTM4Ch2QkWIqhERw-1; Fri, 08 Aug 2025 15:30:23 -0400
X-MC-Unique: C0X0L-WTM4Ch2QkWIqhERw-1
X-Mimecast-MFC-AGG-ID: C0X0L-WTM4Ch2QkWIqhERw_1754681422
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3b79ad7b8a5so1497439f8f.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:30:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754681422; x=1755286222;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vZrNM7cLyW6ZntVepWfRx2E68nay34sv/K0xEhdtwxc=;
        b=DcWIA7PY7qkdKBq4X8EvzHfa0nIXR7A0zQlipBnu+xtnegMqrsfHEsma7n33biynJN
         Hr8u8vjkeli8tdaw0B160VS7fAwes1+Gsb3KIDMs3K7IqI0zl8OXFsCfZ9ivRXQPgd08
         Zk47Ck3EdsiENzTXjSC8CVCi7ep77FF0HxJoL+iR8sLGzf6m2DBfDilkd/v8D8pAD0B+
         D7pSOP41WzRtyMQeXwF9We4itjgxeWr8SpaIfPZMCgQTYV0T/uDoy07g2F0oJBLzJu/C
         n8MzzIfQwGbB7Qwg+ODkwrVIrWIgB80P9DWGGyozkUQvOfhy5r8vW7M9J83uWkm8J+Ak
         V7jw==
X-Forwarded-Encrypted: i=1; AJvYcCWTlYjqBK1P7Vvzz8s/FBOYUzP4Kl6+PA24Jh8cFBXyiEXNXVQGlBkqORBtGLVNfskgP3684rb7/1PWpMoV@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3KLSYkYc/S+VMKv1W/jLQmrSpz/3CJ6M3edjeg+DtsKi+4uxR
	lXLK7JzQKClYGZXAxP+buuXluGVzfL5aae+GRWegIqYfwFma8NGTUPLPWVGqJwiqAAGZ9yPnT4K
	TmibZ3cZiCKz66nSwbXKPlo6+jTmP3kO+D/nNa3RQtWTpNC/Ed42TayuYJC9EloRl3XoeDiHPKg
	==
X-Gm-Gg: ASbGncsT1kgGW7qEkwmsCFBXN6raBk5KU2sI5De/ZMULaoe9JnBiYO3sVMDErwHpMrS
	FEn7//aCMqnHgRM8ZxPBKes6VyUe6bhxbbQ/7bHghjp04PKsomB/nl29TT6fYoZSIScwzTP1fBn
	GgBCUgc6zZDkmIkTAO5fiOnBNtHWks70MfgsW7XGsliu2x1T91XUjgbeOj9ckp23C8ZwNXPHTM5
	yXVb6XWupRwJYQjTXR9NRj0cdmgN5LsItTD2dFW3SqSDVypLunWzAFn8dAuxjKc2+OUGqQt9d3J
	FuNtbLIVp6kD3z8fbyUjR1jkRFKmGGWkJFSJIN0s0aAQ6w==
X-Received: by 2002:a05:6000:2287:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3b900b783a4mr3771392f8f.46.1754681421732;
        Fri, 08 Aug 2025 12:30:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExPi4Jww2nQYBRKA1bZxrgTPJogPHxZwSCKQYWcURLI4nsiHj1T2MlHBfo4w6rPqrojVUgpQ==
X-Received: by 2002:a05:6000:2287:b0:3a4:bfda:1e9 with SMTP id ffacd0b85a97d-3b900b783a4mr3771369f8f.46.1754681421170;
        Fri, 08 Aug 2025 12:30:21 -0700 (PDT)
Received: from [127.0.0.2] (ip-217-030-074-039.aim-net.cz. [217.30.74.39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b8f8b1bc81sm8925162f8f.69.2025.08.08.12.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:30:20 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Fri, 08 Aug 2025 21:30:17 +0200
Subject: [PATCH 2/4] xfs_quota: utilize file_setattr to set prjid on
 special files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250808-xattrat-syscall-v1-2-48567c29e45c@kernel.org>
References: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
In-Reply-To: <20250808-xattrat-syscall-v1-0-48567c29e45c@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7019; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=X1NtZap0LQtCy5fJbgQ5pynD7Qyejgs3jzmfb4BxIDQ=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMqYFeG+o/XEr3nbOv5DsiJAG+6JJR75X2XHYu34w7
 IkM+DzDdnlHKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiUwRZ/gr3fat9Ny6+yyZ
 SnFTJJJ+Lt/W5pA+++6Fd3YL/rNtWV2nwPBXyuepR30Yd9GCaTzxr71zC6Z/rkq+Ou2u4IoFvxN
 lOxyZAJfgSS8=
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Utilize new file_getattr/file_setattr syscalls to set project ID on
special files. Previously, special files were skipped due to lack of the
way to call FS_IOC_SETFSXATTR ioctl on them. The quota accounting was
therefore missing these inodes (special files created before project
setup). The ones created after porject initialization did inherit the
projid flag from the parent.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 quota/project.c | 144 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 70 deletions(-)

diff --git a/quota/project.c b/quota/project.c
index adb26945fa57..93d7ace0e11b 100644
--- a/quota/project.c
+++ b/quota/project.c
@@ -4,14 +4,17 @@
  * All Rights Reserved.
  */
 
+#include <unistd.h>
 #include "command.h"
 #include "input.h"
 #include "init.h"
+#include "libfrog/file_attr.h"
 #include "quota.h"
 
 static cmdinfo_t project_cmd;
 static prid_t prid;
 static int recurse_depth = -1;
+static int dfd;
 
 enum {
 	CHECK_PROJECT	= 0x1,
@@ -19,13 +22,6 @@ enum {
 	CLEAR_PROJECT	= 0x4,
 };
 
-#define EXCLUDED_FILE_TYPES(x) \
-	   (S_ISCHR((x)) \
-	|| S_ISBLK((x)) \
-	|| S_ISFIFO((x)) \
-	|| S_ISLNK((x)) \
-	|| S_ISSOCK((x)))
-
 static void
 project_help(void)
 {
@@ -85,8 +81,8 @@ check_project(
 	int			flag,
 	struct FTW		*data)
 {
-	struct fsxattr		fsx;
-	int			fd;
+	int			error;
+	struct file_attr	fa = { 0 };
 
 	if (recurse_depth >= 0 && data->level > recurse_depth)
 		return 0;
@@ -96,30 +92,30 @@ check_project(
 		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
 		return 0;
 	}
-	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
-		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
-		return 0;
-	}
 
-	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
-		exitcode = 1;
-		fprintf(stderr, _("%s: cannot open %s: %s\n"),
-			progname, path, strerror(errno));
-	} else if ((xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
-		exitcode = 1;
+	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error) {
+#ifndef HAVE_FILE_ATTR
+		if (SPECIAL_FILE(stat->st_mode)) {
+			fprintf(stderr, _("%s: skipping special file %s\n"),
+					progname, path);
+			return 0;
+		}
+#endif
 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
-			progname, path, strerror(errno));
-	} else {
-		if (fsx.fsx_projid != prid)
-			printf(_("%s - project identifier is not set"
-				 " (inode=%u, tree=%u)\n"),
-				path, fsx.fsx_projid, (unsigned int)prid);
-		if (!(fsx.fsx_xflags & FS_XFLAG_PROJINHERIT) && S_ISDIR(stat->st_mode))
-			printf(_("%s - project inheritance flag is not set\n"),
-				path);
+				progname, path, strerror(errno));
+		exitcode = 1;
+		return 0;
 	}
-	if (fd != -1)
-		close(fd);
+
+	if (fa.fa_projid != prid)
+		printf(_("%s - project identifier is not set"
+				" (inode=%u, tree=%u)\n"),
+			path, fa.fa_projid, (unsigned int)prid);
+	if (!(fa.fa_xflags & FS_XFLAG_PROJINHERIT) && S_ISDIR(stat->st_mode))
+		printf(_("%s - project inheritance flag is not set\n"),
+			path);
+
 	return 0;
 }
 
@@ -130,8 +126,8 @@ clear_project(
 	int			flag,
 	struct FTW		*data)
 {
-	struct fsxattr		fsx;
-	int			fd;
+	int			error;
+	struct file_attr	fa;
 
 	if (recurse_depth >= 0 && data->level > recurse_depth)
 		return 0;
@@ -141,32 +137,31 @@ clear_project(
 		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
 		return 0;
 	}
-	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
-		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
-		return 0;
-	}
 
-	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
-		exitcode = 1;
-		fprintf(stderr, _("%s: cannot open %s: %s\n"),
-			progname, path, strerror(errno));
-		return 0;
-	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
-		exitcode = 1;
+	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error) {
+#ifndef HAVE_FILE_ATTR
+		if (SPECIAL_FILE(stat->st_mode)) {
+			fprintf(stderr, _("%s: skipping special file %s\n"),
+					progname, path);
+			return 0;
+		}
+#endif
 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
-			progname, path, strerror(errno));
-		close(fd);
+				progname, path, strerror(errno));
+		exitcode = 1;
 		return 0;
 	}
 
-	fsx.fsx_projid = 0;
-	fsx.fsx_xflags &= ~FS_XFLAG_PROJINHERIT;
-	if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &fsx) < 0) {
-		exitcode = 1;
+	fa.fa_projid = 0;
+	fa.fa_xflags &= ~FS_XFLAG_PROJINHERIT;
+
+	error = file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error) {
 		fprintf(stderr, _("%s: cannot clear project on %s: %s\n"),
 			progname, path, strerror(errno));
+		exitcode = 1;
 	}
-	close(fd);
 	return 0;
 }
 
@@ -177,8 +172,8 @@ setup_project(
 	int			flag,
 	struct FTW		*data)
 {
-	struct fsxattr		fsx;
-	int			fd;
+	struct file_attr	fa;
+	int			error;
 
 	if (recurse_depth >= 0 && data->level > recurse_depth)
 		return 0;
@@ -188,32 +183,32 @@ setup_project(
 		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
 		return 0;
 	}
-	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
-		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
-		return 0;
-	}
 
-	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
-		exitcode = 1;
-		fprintf(stderr, _("%s: cannot open %s: %s\n"),
-			progname, path, strerror(errno));
-		return 0;
-	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
-		exitcode = 1;
+	error = file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error) {
+#ifndef HAVE_FILE_ATTR
+		if (SPECIAL_FILE(stat->st_mode)) {
+			fprintf(stderr, _("%s: skipping special file %s\n"),
+					progname, path);
+			return 0;
+		}
+#endif
 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
-			progname, path, strerror(errno));
-		close(fd);
+				progname, path, strerror(errno));
+		exitcode = 1;
 		return 0;
 	}
 
-	fsx.fsx_projid = prid;
-	fsx.fsx_xflags |= FS_XFLAG_PROJINHERIT;
-	if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &fsx) < 0) {
-		exitcode = 1;
+	fa.fa_projid = prid;
+	if (S_ISDIR(stat->st_mode))
+		fa.fa_xflags |= FS_XFLAG_PROJINHERIT;
+
+	error = file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error) {
 		fprintf(stderr, _("%s: cannot set project on %s: %s\n"),
 			progname, path, strerror(errno));
+		exitcode = 1;
 	}
-	close(fd);
 	return 0;
 }
 
@@ -223,6 +218,13 @@ project_operations(
 	char		*dir,
 	int		type)
 {
+	dfd = open(dir, O_RDONLY|O_NOCTTY);
+	if (dfd < -1) {
+		printf(_("Error opening dir %s for project %s...\n"), dir,
+				project);
+		return;
+	}
+
 	switch (type) {
 	case CHECK_PROJECT:
 		printf(_("Checking project %s (path %s)...\n"), project, dir);
@@ -237,6 +239,8 @@ project_operations(
 		nftw(dir, clear_project, 100, FTW_PHYS|FTW_MOUNT);
 		break;
 	}
+
+	close(dfd);
 }
 
 static void

-- 
2.49.0


