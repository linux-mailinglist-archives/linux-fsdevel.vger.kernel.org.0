Return-Path: <linux-fsdevel+bounces-59392-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E455B3864F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6EE983FF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A615530BB81;
	Wed, 27 Aug 2025 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HirjhDDw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D8E027A477
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307766; cv=none; b=OsDObst7Jo1kJiZI/AnY40SHWKmXaSiD7tTkJ0x2RqQ5GIBd2+bFb1nblogSvXZ1hdZubH8IObkVTqH3a65Jzz+pnpByri4tXm9ekToPu3h+oWktnopVb9jkhSlTaUoZ3AQF7gPAlEH16xL3tN4WjUbEsaLLai4srq4uHCAjquA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307766; c=relaxed/simple;
	bh=wtFeY5+m4A+61YbGhxwwIdklSPo7wPl2GHVzsV2UpzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XwZunjVGPqF9FTrHe5ROziqW4PADyTRsj3kknJnEZDVqaq69D+7D45CHwl2gqXaywvG3DSzq/Eyk1ccmVPawHCV1UYc9dCyEexSRoKmZlh+627fkcVkf1i/LC5p0p8m6U7c9QLrSC8Aq9TGi3p0mSQT8b9gMc/vzPB1HLgIMwNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HirjhDDw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307763;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oDMIKtbOykVluzD/aE4/YCekuWTf+/4NRT5j4Geyt2U=;
	b=HirjhDDwIrt8nWOoYnMNuBqhcYS2RtltGI5ydOr42/Ikit+t8HagZKCoI8ObIGBodmUqGB
	ZyKQxN8KDPmCGGNQ8omadEXd9tnxcHpK02MMS+W+nN0xoujNkJt8FT1JbUl/quDCKTx/2l
	258h/LBFgFOp5/PJTpnwdfuhCD5dCD0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-InplZsa0P6OiRMhi8poYqg-1; Wed, 27 Aug 2025 11:16:01 -0400
X-MC-Unique: InplZsa0P6OiRMhi8poYqg-1
X-Mimecast-MFC-AGG-ID: InplZsa0P6OiRMhi8poYqg_1756307761
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45b74ec7cd0so2042705e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:16:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307760; x=1756912560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oDMIKtbOykVluzD/aE4/YCekuWTf+/4NRT5j4Geyt2U=;
        b=pqmT/8uJHdMoxdCs+CzHfAUWid43wGwiX3t8uHpSoOaNeyVyIYXGVqpeGPeTl15wkq
         ENw8Nc2Xxd4NmqvKBCFeX8iVSTyRVzpSjWxtPirpz0MVaJQ3AQxGKjhgztJRiKr4DaDX
         jfd2iDfnbtfxkJgCRZhfjhEqfI/wEw2PxZ9Hlmg/cJ2hpDfEkDvKjJTDAzJ5fPU0bDSJ
         VZ33/D4pjis1Uwscdmso3igJWoqbbkWteoLbE3AOX2qEtlzvu4OvlWCof91WJXXrTyet
         EquXfVaIU2nfIatqqDR0iTMvDkjDxxebQWK86l3AJ4rpBjiFB+xeq+spnDyLGY8yThX2
         yfdg==
X-Forwarded-Encrypted: i=1; AJvYcCUO0yQsX0S9VlafdiAA6EKfXx3KIUSkjZDlDSoaLF/yZ7jZB61IguCalZ7K5Fh58c7xdIviOoKu9ogaRHH1@vger.kernel.org
X-Gm-Message-State: AOJu0YzerKSbt/YBh7MsYjEIVtEDq/oAoQImPdh/fRNMyRmO1qJ833wz
	FooYu4StHWylz3Fhdk5PCetcXBe8WNH/K6fmQbEIgdw+G8cvNeEEo4vrlgMmf07nKWVcoQa0ZPd
	F/pSCTRBBeMCamUG7vGQkKq/r8rWD1U/597prVDa7vki9W+4OlVrsNPHrp6rLKJbiAI0+bnlS7w
	==
X-Gm-Gg: ASbGnctWzkrRMJ6bmLBsIZ7+MhCFZXU9rJ1AUH74ZHuE62QViWmRG3uyVgMsqmgWUpT
	/APPPRPDpNFekwMvFTOo+PhoqB3jyzrT34ExR47GIl82Veg/o+OFoW0npxJuMx3Ki8eCa+P2KC7
	+1ABV1m0Ha2w1hKjt1j+jY/MOQwKit/eI6R59JVORNeZOrHV0IfWC7V5wH8Owskfpl1ZUvtLZIG
	8C9CViKHshdU0oPdUccAjs/UvvA5MsxfAHoe1XllaFCYRqIV2wWNahTLImpyccRqChDa5JEjEJO
	Uhw8UXzZ+tZbkujcnw==
X-Received: by 2002:a05:600c:1c0f:b0:45b:6365:7957 with SMTP id 5b1f17b1804b1-45b68bc7a0bmr50802315e9.33.1756307760146;
        Wed, 27 Aug 2025 08:16:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtuRd+d3UhE79MObqvIzCmZnP33waVaDWJvRQ/TUBBFyIonxFBOsPGdIMBTTV2HKAf5Aal7Q==
X-Received: by 2002:a05:600c:1c0f:b0:45b:6365:7957 with SMTP id 5b1f17b1804b1-45b68bc7a0bmr50802055e9.33.1756307759687;
        Wed, 27 Aug 2025 08:15:59 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0e27b2sm33896285e9.10.2025.08.27.08.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:15:59 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 27 Aug 2025 17:15:55 +0200
Subject: [PATCH v2 3/4] xfs_io: make ls/chattr work with special files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-xattrat-syscall-v2-3-82a2d2d5865b@kernel.org>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
In-Reply-To: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=6852; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=D7O/aWbNBBWY0zRzun4IWAktRpxmJKVMoUsO3qTWmLs=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYr6jjp8ImoqpdcW+dj3755a76f3uOD9/P2fOe2r
 Gfmvt70tLyjlIVBjItBVkyRZZ201tSkIqn8IwY18jBzWJlAhjBwcQrARD6nMTLcuhXYNp3xaLtU
 Sm5h+6Y7Wwp7Z5rO29lfvO9DobGf3cJ0hn/a1mVq67W+eGV4V36WbpbZ/cB4weyulaK1RW6RvCV
 mvSwAJzFEjA==
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

With new file_getattr/file_setattr syscalls we can now list/change file
attributes on special files instead for ignoring them.

Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
---
 io/attr.c | 138 +++++++++++++++++++++++++++++++++++++-------------------------
 io/io.h   |   2 +-
 io/stat.c |   2 +-
 3 files changed, 84 insertions(+), 58 deletions(-)

diff --git a/io/attr.c b/io/attr.c
index fd82a2e73801..1005450ac9f9 100644
--- a/io/attr.c
+++ b/io/attr.c
@@ -8,6 +8,7 @@
 #include "input.h"
 #include "init.h"
 #include "io.h"
+#include "libfrog/file_attr.h"
 
 static cmdinfo_t chattr_cmd;
 static cmdinfo_t lsattr_cmd;
@@ -113,7 +114,7 @@ chattr_help(void)
 }
 
 void
-printxattr(
+print_xflags(
 	uint		flags,
 	int		verbose,
 	int		dofname,
@@ -156,36 +157,36 @@ lsattr_callback(
 	int			status,
 	struct FTW		*data)
 {
-	struct fsxattr		fsx;
-	int			fd;
+	struct file_attr	fa;
+	int			error;
 
 	if (recurse_dir && !S_ISDIR(stat->st_mode))
 		return 0;
 
-	if ((fd = open(path, O_RDONLY)) == -1) {
-		fprintf(stderr, _("%s: cannot open %s: %s\n"),
-			progname, path, strerror(errno));
-		exitcode = 1;
-	} else if ((xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
+        error = xfrog_file_getattr(AT_FDCWD, path, stat, &fa,
+				   AT_SYMLINK_NOFOLLOW);
+        if (error) {
 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
 			progname, path, strerror(errno));
 		exitcode = 1;
-	} else
-		printxattr(fsx.fsx_xflags, 0, 1, path, 0, 1);
+		return 0;
+	}
+
+	print_xflags(fa.fa_xflags, 0, 1, path, 0, 1);
 
-	if (fd != -1)
-		close(fd);
 	return 0;
 }
 
 static int
 lsattr_f(
-	int		argc,
-	char		**argv)
+	int			argc,
+	char			**argv)
 {
-	struct fsxattr	fsx;
-	char		*name = file->name;
-	int		c, aflag = 0, vflag = 0;
+	struct file_attr	fa;
+	char			*name = file->name;
+	int			c, aflag = 0, vflag = 0;
+	struct stat		st;
+	int			error;
 
 	recurse_all = recurse_dir = 0;
 	while ((c = getopt(argc, argv, "DRav")) != EOF) {
@@ -211,17 +212,28 @@ lsattr_f(
 	if (recurse_all || recurse_dir) {
 		nftw(name, lsattr_callback,
 			100, FTW_PHYS | FTW_MOUNT | FTW_DEPTH);
-	} else if ((xfsctl(name, file->fd, FS_IOC_FSGETXATTR, &fsx)) < 0) {
+		return 0;
+	}
+
+	error = stat(name, &st);
+	if (error)
+		return error;
+
+	error = xfrog_file_getattr(AT_FDCWD, name, &st, &fa,
+				   AT_SYMLINK_NOFOLLOW);
+	if (error) {
 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
 			progname, name, strerror(errno));
 		exitcode = 1;
-	} else {
-		printxattr(fsx.fsx_xflags, vflag, !aflag, name, vflag, !aflag);
-		if (aflag) {
-			fputs("/", stdout);
-			printxattr(-1, 0, 1, name, 0, 1);
-		}
+		return 0;
 	}
+
+	print_xflags(fa.fa_xflags, vflag, !aflag, name, vflag, !aflag);
+	if (aflag) {
+		fputs("/", stdout);
+		print_xflags(-1, 0, 1, name, 0, 1);
+	}
+
 	return 0;
 }
 
@@ -232,44 +244,45 @@ chattr_callback(
 	int			status,
 	struct FTW		*data)
 {
-	struct fsxattr		attr;
-	int			fd;
+	struct file_attr	attr;
+	int			error;
 
 	if (recurse_dir && !S_ISDIR(stat->st_mode))
 		return 0;
 
-	if ((fd = open(path, O_RDONLY)) == -1) {
-		fprintf(stderr, _("%s: cannot open %s: %s\n"),
-			progname, path, strerror(errno));
-		exitcode = 1;
-	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &attr) < 0) {
+        error = xfrog_file_getattr(AT_FDCWD, path, stat, &attr,
+                                   AT_SYMLINK_NOFOLLOW);
+        if (error) {
 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
 			progname, path, strerror(errno));
 		exitcode = 1;
-	} else {
-		attr.fsx_xflags |= orflags;
-		attr.fsx_xflags &= ~andflags;
-		if (xfsctl(path, fd, FS_IOC_FSSETXATTR, &attr) < 0) {
-			fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
-				progname, path, strerror(errno));
-			exitcode = 1;
-		}
+		return 0;
+	}
+
+	attr.fa_xflags |= orflags;
+	attr.fa_xflags &= ~andflags;
+	error = xfrog_file_setattr(AT_FDCWD, path, stat, &attr,
+				   AT_SYMLINK_NOFOLLOW);
+	if (error) {
+		fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
+			progname, path, strerror(errno));
+		exitcode = 1;
 	}
 
-	if (fd != -1)
-		close(fd);
 	return 0;
 }
 
 static int
 chattr_f(
-	int		argc,
-	char		**argv)
+	int			argc,
+	char			**argv)
 {
-	struct fsxattr	attr;
-	struct xflags	*p;
-	unsigned int	i = 0;
-	char		*c, *name = file->name;
+	struct file_attr	attr;
+	struct xflags		*p;
+	unsigned int		i = 0;
+	char			*c, *name = file->name;
+	struct stat		st;
+	int			error;
 
 	orflags = andflags = 0;
 	recurse_all = recurse_dir = 0;
@@ -326,19 +339,32 @@ chattr_f(
 	if (recurse_all || recurse_dir) {
 		nftw(name, chattr_callback,
 			100, FTW_PHYS | FTW_MOUNT | FTW_DEPTH);
-	} else if (xfsctl(name, file->fd, FS_IOC_FSGETXATTR, &attr) < 0) {
+		return 0;
+	}
+
+	error = stat(name, &st);
+	if (error)
+		return error;
+
+	error = xfrog_file_getattr(AT_FDCWD, name, &st, &attr,
+				   AT_SYMLINK_NOFOLLOW);
+	if (error) {
 		fprintf(stderr, _("%s: cannot get flags on %s: %s\n"),
 			progname, name, strerror(errno));
 		exitcode = 1;
-	} else {
-		attr.fsx_xflags |= orflags;
-		attr.fsx_xflags &= ~andflags;
-		if (xfsctl(name, file->fd, FS_IOC_FSSETXATTR, &attr) < 0) {
-			fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
-				progname, name, strerror(errno));
-			exitcode = 1;
-		}
+		return 0;
 	}
+
+	attr.fa_xflags |= orflags;
+	attr.fa_xflags &= ~andflags;
+	error = xfrog_file_setattr(AT_FDCWD, name, &st, &attr,
+				   AT_SYMLINK_NOFOLLOW);
+	if (error) {
+		fprintf(stderr, _("%s: cannot set flags on %s: %s\n"),
+			progname, name, strerror(errno));
+		exitcode = 1;
+	}
+
 	return 0;
 }
 
diff --git a/io/io.h b/io/io.h
index 259c034931b8..35fb8339eeb5 100644
--- a/io/io.h
+++ b/io/io.h
@@ -78,7 +78,7 @@ extern int		openfile(char *, struct xfs_fsop_geom *, int, mode_t,
 extern int		addfile(char *, int , struct xfs_fsop_geom *, int,
 				struct fs_path *);
 extern int		closefile(void);
-extern void		printxattr(uint, int, int, const char *, int, int);
+extern void		print_xflags(uint, int, int, const char *, int, int);
 
 extern unsigned int	recurse_all;
 extern unsigned int	recurse_dir;
diff --git a/io/stat.c b/io/stat.c
index c257037aa8ee..c1085f14eade 100644
--- a/io/stat.c
+++ b/io/stat.c
@@ -112,7 +112,7 @@ print_extended_info(int verbose)
 	}
 
 	printf(_("fsxattr.xflags = 0x%x "), fsx.fsx_xflags);
-	printxattr(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
+	print_xflags(fsx.fsx_xflags, verbose, 0, file->name, 1, 1);
 	printf(_("fsxattr.projid = %u\n"), fsx.fsx_projid);
 	printf(_("fsxattr.extsize = %u\n"), fsx.fsx_extsize);
 	printf(_("fsxattr.cowextsize = %u\n"), fsx.fsx_cowextsize);

-- 
2.49.0


