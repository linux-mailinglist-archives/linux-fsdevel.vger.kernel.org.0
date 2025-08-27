Return-Path: <linux-fsdevel+bounces-59391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7278AB3863C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 17:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC507B819E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Aug 2025 15:17:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2460930748C;
	Wed, 27 Aug 2025 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkeExU72"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DAD279910
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307765; cv=none; b=gwxWitUgRHGFcU9XXpevYaokBj5HAg0UTB2fCMxy2/1BB77EjjhZqul/v1nmXvCAUD3vsFpVy5m6B2C+GJT04c7suprPHxLqj2oxLAaHGV/jvgRJ+u4Wq8fi7F/kMIcQzZz2UCbO5vwPBrbQ4dgtNAXS04VdBewSNxgha6pNlig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307765; c=relaxed/simple;
	bh=jUlUkUZ/8dRb/EDcAZ1Z91+YLA2/sEZ0Hs2BlGpkv+4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qJK7KlJz19JvV4J6nowB8RzwQ9LHbtb1DUxkUOb2JwSBlumdSGKbwje76hr5eqbQg/fN2MlNbzLlpnfOiQs5RmGrzCiBkJcHuV5NiniWCwfJylYwKMuCYchl717fcmIDGsbcsEAhTjAN1oe3oazSi9JBf31c5dQgCSqN8cfxQs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkeExU72; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756307762;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vtMYdI+yafsqcqwR0/UzD8UhQwCzX1DzLMbhM3xXh8o=;
	b=MkeExU72W2/rr7UnB2spRGz1+MNM2mcqOxH8U69PqFGpHM0+LnmvWDUCf1KQ+G0StHjs0t
	sFetnIo48/mXQWwuYF0vJ1VA9kqCXWPJwWq+Db5ya0jkPDuQWdt9ByE0nQqrxyeO4tKwoN
	sHR5dP7uvsVDUg+ushwVnEwYgJQ+mZM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-z7rFtkrcP2yYcnX1I9a5hA-1; Wed, 27 Aug 2025 11:16:00 -0400
X-MC-Unique: z7rFtkrcP2yYcnX1I9a5hA-1
X-Mimecast-MFC-AGG-ID: z7rFtkrcP2yYcnX1I9a5hA_1756307759
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-45a1b0b46bbso31475705e9.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Aug 2025 08:16:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756307759; x=1756912559;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vtMYdI+yafsqcqwR0/UzD8UhQwCzX1DzLMbhM3xXh8o=;
        b=CcKPqB1CSocOqx5N8LOGKdxrZXJ/NWfrmDIVT+LlsEOETtTOH7rNCzCPqhEhCnTp8x
         vrYKyksDXg8oqSEh1WZHGwADtiZ/v+FcdrTtuxSgcHhjgrb0dACKJqV+C5jPlWb0F8iY
         DHynRSDE3678ZMmNTRrNlG8Tqi/5OurztG4d4cbmdcgczP3kbIbx8JroVviYqsUucTI8
         TWRGzihAQ47hmt4ZwS8vlpB6cpxpdEqLKQ15Is32BHrK/jkdw/xrnKmWv/aDWwT5vHwA
         rI8OWMHJ5vWFg/UnWj7PaReqPNQ4xCZNcuso7/xqRzLkvzPgHvBiUHMOjpJ6y5nNgeWm
         1yJw==
X-Forwarded-Encrypted: i=1; AJvYcCXdMrD1aE/Wi2mF1eW8qkEahVuCefGpTmthGhbHlUB9rnoMuxAw4sz2gX9eI1cOC6YCvjOV010/HgXBWQCN@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd/YKh3o6e0gX0Zw6rDZS9T5CLVF7rC+yN2XEQYtv59WE1hyng
	z54SYMpKrrjuxt5MP8uRxMxHWpZ0p6GXRaSyEOdpwv/8I92BRm48q/wtDvBbORMhvZxoI47Y35R
	XApxQTFvh5Oo/+PUlSA2MwHJHbzLflS4WSTri07e9bcgTDcCJr37ofVzyEWlpBLwA9Q==
X-Gm-Gg: ASbGnctDTLTDZPwgz5eFdT1pIuFPWxWBYl8Bfe9RGgAKZHxsXZuSOszWxu06MHi8+Z9
	v5cn+quDivbCjIuRsM7wItE20nlS++HViYxf3LDRDgfOXgb1xg0gBHwIrmzmGbmFpmgt/yb66t5
	kaY9vKi5+bSuQ6HGurmRGY23M1KyJ85RqF21M4NYQ8rLeCAU8LyTnz/Zreuy+hwg6vNSnZqfVx0
	/jzPCV5r6L4jeJNcKCCihb7L4OsQyGDDaQxyyo4SK6J/oUDTno3R52WAdZNYpxxFNRVby6OeJGt
	pVXC+TYlwcx8uwKnWQ==
X-Received: by 2002:a05:600c:1f8f:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45b517b9a7bmr144280505e9.22.1756307759284;
        Wed, 27 Aug 2025 08:15:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6CoMiqgq5dnrSq5DtIqWX8eEWXPPN2tOnWY/GpftY55mHm6cTRGAA5YOpuk+XbmMv3RzAOw==
X-Received: by 2002:a05:600c:1f8f:b0:456:1a41:f932 with SMTP id 5b1f17b1804b1-45b517b9a7bmr144280305e9.22.1756307758797;
        Wed, 27 Aug 2025 08:15:58 -0700 (PDT)
Received: from [127.0.0.2] ([91.245.205.131])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6f0e27b2sm33896285e9.10.2025.08.27.08.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 08:15:58 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
X-Google-Original-From: Andrey Albershteyn <aalbersh@kernel.org>
Date: Wed, 27 Aug 2025 17:15:54 +0200
Subject: [PATCH v2 2/4] xfs_quota: utilize file_setattr to set prjid on
 special files
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250827-xattrat-syscall-v2-2-82a2d2d5865b@kernel.org>
References: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
In-Reply-To: <20250827-xattrat-syscall-v2-0-82a2d2d5865b@kernel.org>
To: aalbersh@kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-xfs@vger.kernel.org
Cc: Andrey Albershteyn <aalbersh@redhat.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7109; i=aalbersh@kernel.org;
 h=from:subject:message-id; bh=OCAVYG258W7Af2EdQLExdEEBR5XHyJJSbqHxIhWHiTE=;
 b=owJ4nJvAy8zAJea2/JXEGuOHHIyn1ZIYMtYr6qh51OjJzD/1JqzxgNXJ2dm8WoFPpHzOi820P
 iv+IIpd711HKQuDGBeDrJgiyzppralJRVL5Rwxq5GHmsDKBDGHg4hSAiSyVZWT4IFiexX7/qf2c
 d07+e3YevJr5zcCzZrKJGZtVu4xLg0UUI8P+vZMeP7WPvPwtZa721Mz27nnPvl56X/ah5+jhpwa
 nHktzAQDePUd8
X-Developer-Key: i=aalbersh@kernel.org; a=openpgp;
 fpr=AE1B2A9562721A6FC4307C1F46A7EA18AC33E108

From: Andrey Albershteyn <aalbersh@redhat.com>

Utilize new file_getattr/file_setattr syscalls to set project ID on
special files. Previously, special files were skipped due to lack of the
way to call FS_IOC_SETFSXATTR ioctl on them. The quota accounting was
therefore missing these inodes (special files created before project
setup). The ones created after project initialization did inherit the
projid flag from the parent.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 quota/project.c | 142 +++++++++++++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 68 deletions(-)

diff --git a/quota/project.c b/quota/project.c
index adb26945fa57..857b1abe71c7 100644
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
+	struct file_attr	fa;
 
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
+	error = xfrog_file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error && errno == EOPNOTSUPP) {
+		if (SPECIAL_FILE(stat->st_mode)) {
+			fprintf(stderr, _("%s: skipping special file %s: %s\n"),
+					progname, path, strerror(errno));
+			return 0;
+		}
+	}
+	if (error) {
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
@@ -141,32 +137,32 @@ clear_project(
 		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
 		return 0;
 	}
-	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
-		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
-		return 0;
+
+	error = xfrog_file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error && errno == EOPNOTSUPP) {
+		if (SPECIAL_FILE(stat->st_mode)) {
+			fprintf(stderr, _("%s: skipping special file %s: %s\n"),
+					progname, path, strerror(errno));
+			return 0;
+		}
 	}
 
-	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
-		exitcode = 1;
-		fprintf(stderr, _("%s: cannot open %s: %s\n"),
-			progname, path, strerror(errno));
-		return 0;
-	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
-		exitcode = 1;
+	if (error) {
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
+	error = xfrog_file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error) {
 		fprintf(stderr, _("%s: cannot clear project on %s: %s\n"),
 			progname, path, strerror(errno));
+		exitcode = 1;
 	}
-	close(fd);
 	return 0;
 }
 
@@ -177,8 +173,8 @@ setup_project(
 	int			flag,
 	struct FTW		*data)
 {
-	struct fsxattr		fsx;
-	int			fd;
+	struct file_attr	fa;
+	int			error;
 
 	if (recurse_depth >= 0 && data->level > recurse_depth)
 		return 0;
@@ -188,32 +184,33 @@ setup_project(
 		fprintf(stderr, _("%s: cannot stat file %s\n"), progname, path);
 		return 0;
 	}
-	if (EXCLUDED_FILE_TYPES(stat->st_mode)) {
-		fprintf(stderr, _("%s: skipping special file %s\n"), progname, path);
-		return 0;
+
+	error = xfrog_file_getattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error && errno == EOPNOTSUPP) {
+		if (SPECIAL_FILE(stat->st_mode)) {
+			fprintf(stderr, _("%s: skipping special file %s\n"),
+					progname, path);
+			return 0;
+		}
 	}
 
-	if ((fd = open(path, O_RDONLY|O_NOCTTY)) == -1) {
-		exitcode = 1;
-		fprintf(stderr, _("%s: cannot open %s: %s\n"),
-			progname, path, strerror(errno));
-		return 0;
-	} else if (xfsctl(path, fd, FS_IOC_FSGETXATTR, &fsx) < 0) {
-		exitcode = 1;
+	if (error) {
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
+	error = xfrog_file_setattr(dfd, path, stat, &fa, AT_SYMLINK_NOFOLLOW);
+	if (error) {
 		fprintf(stderr, _("%s: cannot set project on %s: %s\n"),
 			progname, path, strerror(errno));
+		exitcode = 1;
 	}
-	close(fd);
 	return 0;
 }
 
@@ -223,6 +220,13 @@ project_operations(
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
@@ -237,6 +241,8 @@ project_operations(
 		nftw(dir, clear_project, 100, FTW_PHYS|FTW_MOUNT);
 		break;
 	}
+
+	close(dfd);
 }
 
 static void

-- 
2.49.0


