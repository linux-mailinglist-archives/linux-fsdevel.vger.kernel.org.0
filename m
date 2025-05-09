Return-Path: <linux-fsdevel+bounces-48612-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 915DDAB154E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 15:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B30C3B1BA0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 May 2025 13:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDC2528F52F;
	Fri,  9 May 2025 13:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRYop5ak"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884222918E1
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 May 2025 13:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746797573; cv=none; b=aFg70Nt+g78G0BeFduumGx4xWi3a/QCrZVL7VYwwB9+ZpeCx3vDVQS1uIILPKqLmWbCrrDcrwcSTBsM4iTJCuuSCmq4EZRF1qILy0mByuqlhC7y/nq5cpFlqVOBvyEz5cHQoVDTfIjXRK6SHpK3jxNSSToKG+jpfFrX3BGYwfww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746797573; c=relaxed/simple;
	bh=cTOwbCpvYGSOnJGl6ki1g8MZR3R1xkq+0E2YJngKAek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jD5XxUI8Cu1aNGSmtlDMjHE65asCNou5E3XhHEMw7JuIhPZSolliCbR1NvgR3aPfWcyWV1lesvVzvBDpa0ykwIC0xPMXHa49yCRbL/fBlSYPBTyOY5XrJ+7LuYE41OlwVkLP3Bt+MYFXCrjxK8GCUD8l7oPI0AUaOIo95idFSOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRYop5ak; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cf848528aso17268875e9.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 May 2025 06:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746797570; x=1747402370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=COfxu+JA3dfGaL/mm6QWwzuGzKY4rL+C3h2tf46O/Lw=;
        b=TRYop5ak6dJdU33E+WKur5ueGbN/XDhRX0+AiDP2X1nBvewC/WPK9K6IL+ppQTsINJ
         9E0ZMDy4jBlZCQEgnNQhcEMJU4j4tAM0MrA4nuXEaDXI6xhYryhU9yXeR2/Aacq+eOlE
         GaI6+F1NCWu/rsS63QFOgbceh3U7Mj2xJwrhpCWg89O8WeqYrY3gFvTsJ98hb9Cj09aj
         enzryKP0WArsVnH33f+I+sQteZUpCcFebWQ7bx9B6K0z+Sk+YmxNL+Qtieqv6apg6Pew
         owNOZDb4fyR/tPBQUQZhvDC9GDnCdRetuIIqPX6SadDfRsPSRo+YyCByc+o85fh8WjHd
         tE1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746797570; x=1747402370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=COfxu+JA3dfGaL/mm6QWwzuGzKY4rL+C3h2tf46O/Lw=;
        b=YXHe5T8/pN6lMo5OyI/KlTsKZZON0MT3z5F0dnxIVDHUiYhPMz0lxSpgeq/kQ/yFvP
         TCZw7xSRjxpXzAV7W/+Nml9DUhhXwODThdnvUfN5eHY1L+JYXtYG5aEdvcIvig63UVfZ
         TVh9YgFeVluIy7sS3ZuedNZahj+LHEy2LvDRjyFiIq9bPMQCMiQz/XI0RfP3ycw3U/9k
         N36vmkF5ye8vtltQJ145HJPQvzafsY6j7sVe8/TbYUZxK/AC6eepm3RvxbpUAdzNpsE7
         omDke28VOMMann6L32uvoApiel1EWSJkorkKsLBGsV2x9jH6fI/GBcqvFj7bqCXsN/LS
         eiHQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjI8sBsZNpJfW187DaHibrkM6zmuOklmmhd6erbIKPgr2jxjW2T5FCxjLnw1psgZ1a0ZvdDTREzg9fkel7@vger.kernel.org
X-Gm-Message-State: AOJu0YzTjyiMuJWaoGNB5vitXhbqqa8MWAVE/jH4MQ6s0QyY7yp/CoJM
	fKyr6JGgk4eQt1UOTjalhN4PSdcB339IWLXLfNbVUFely8XVcZya
X-Gm-Gg: ASbGnctHUh2ruRi2bNHtkcBsXrY4lFPj1s4cfAS1FL6yQALwOfb7kaFcU5iafqLDrTF
	Dyv1nQWCObmKVmJ78IUp2B/2JH0eiforgiJD6DOjL1wDrb6p8bx5eBZDSUrWfYlQavzhP5fJbuo
	g1uQxnXBALviHjxdQx2EABZhGVTjlV0hwYtThfFnNwEInU63N5DduO1hII69vDVl7AguNP972+B
	hx0eX4dRyvYzde/ccSgMfRkbQiJ6jWj//3UF6kCvcywhjqr0V2wM33gsjsFQ7Dj+CW5bvFk2R3L
	cyKTBYon5pKJeUKdQjPoQ7XouwC0upmBkAP8ph+2q2qkHb7acQ72onVa2BPET1K/TRhIiT1UKOw
	0mKx3EGOqZKJecWyIKts1jzp2XeKEquAMEt92yA==
X-Google-Smtp-Source: AGHT+IH8yU8Q2kNCSZMIB/6Rn1cMNzJHgTRK6wcmXBrszdvU9nk1b2rDzxYTQ+kFiBxNiA5+oO49FQ==
X-Received: by 2002:a05:6000:1845:b0:3a0:b84d:805c with SMTP id ffacd0b85a97d-3a1f64c0b60mr2959723f8f.49.1746797569597;
        Fri, 09 May 2025 06:32:49 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddfd6sm3232899f8f.4.2025.05.09.06.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 06:32:49 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 7/8] selftests/filesystems: create setup_userns() helper
Date: Fri,  9 May 2025 15:32:39 +0200
Message-Id: <20250509133240.529330-8-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509133240.529330-1-amir73il@gmail.com>
References: <20250509133240.529330-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper to utils.c and use it in statmount userns tests.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/statmount/statmount_test_ns.c | 58 +---------------
 tools/testing/selftests/filesystems/utils.c   | 66 +++++++++++++++++++
 tools/testing/selftests/filesystems/utils.h   |  1 +
 3 files changed, 68 insertions(+), 57 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index 375a52101d08..605a3fa16bf7 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -79,66 +79,10 @@ static int get_mnt_ns_id(const char *mnt_ns, uint64_t *mnt_ns_id)
 	return NSID_PASS;
 }
 
-static int write_file(const char *path, const char *val)
-{
-	int fd = open(path, O_WRONLY);
-	size_t len = strlen(val);
-	int ret;
-
-	if (fd == -1) {
-		ksft_print_msg("opening %s for write: %s\n", path, strerror(errno));
-		return NSID_ERROR;
-	}
-
-	ret = write(fd, val, len);
-	if (ret == -1) {
-		ksft_print_msg("writing to %s: %s\n", path, strerror(errno));
-		return NSID_ERROR;
-	}
-	if (ret != len) {
-		ksft_print_msg("short write to %s\n", path);
-		return NSID_ERROR;
-	}
-
-	ret = close(fd);
-	if (ret == -1) {
-		ksft_print_msg("closing %s\n", path);
-		return NSID_ERROR;
-	}
-
-	return NSID_PASS;
-}
-
 static int setup_namespace(void)
 {
-	int ret;
-	char buf[32];
-	uid_t uid = getuid();
-	gid_t gid = getgid();
-
-	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
-	if (ret == -1)
-		ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
-				   strerror(errno));
-
-	sprintf(buf, "0 %d 1", uid);
-	ret = write_file("/proc/self/uid_map", buf);
-	if (ret != NSID_PASS)
-		return ret;
-	ret = write_file("/proc/self/setgroups", "deny");
-	if (ret != NSID_PASS)
-		return ret;
-	sprintf(buf, "0 %d 1", gid);
-	ret = write_file("/proc/self/gid_map", buf);
-	if (ret != NSID_PASS)
-		return ret;
-
-	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
-	if (ret == -1) {
-		ksft_print_msg("making mount tree private: %s\n",
-			       strerror(errno));
+	if (setup_userns() != 0)
 		return NSID_ERROR;
-	}
 
 	return NSID_PASS;
 }
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index 5a114af822af..c43a69dffd83 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -18,6 +18,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/xattr.h>
+#include <sys/mount.h>
 
 #include "../kselftest.h"
 #include "wrappers.h"
@@ -449,6 +450,71 @@ static int create_userns_hierarchy(struct userns_hierarchy *h)
 	return fret;
 }
 
+static int write_file(const char *path, const char *val)
+{
+	int fd = open(path, O_WRONLY);
+	size_t len = strlen(val);
+	int ret;
+
+	if (fd == -1) {
+		ksft_print_msg("opening %s for write: %s\n", path, strerror(errno));
+		return -1;
+	}
+
+	ret = write(fd, val, len);
+	if (ret == -1) {
+		ksft_print_msg("writing to %s: %s\n", path, strerror(errno));
+		return -1;
+	}
+	if (ret != len) {
+		ksft_print_msg("short write to %s\n", path);
+		return -1;
+	}
+
+	ret = close(fd);
+	if (ret == -1) {
+		ksft_print_msg("closing %s\n", path);
+		return -1;
+	}
+
+	return 0;
+}
+
+int setup_userns(void)
+{
+	int ret;
+	char buf[32];
+	uid_t uid = getuid();
+	gid_t gid = getgid();
+
+	ret = unshare(CLONE_NEWNS|CLONE_NEWUSER|CLONE_NEWPID);
+	if (ret) {
+		ksft_exit_fail_msg("unsharing mountns and userns: %s\n",
+				   strerror(errno));
+		return ret;
+	}
+
+	sprintf(buf, "0 %d 1", uid);
+	ret = write_file("/proc/self/uid_map", buf);
+	if (ret)
+		return ret;
+	ret = write_file("/proc/self/setgroups", "deny");
+	if (ret)
+		return ret;
+	sprintf(buf, "0 %d 1", gid);
+	ret = write_file("/proc/self/gid_map", buf);
+	if (ret)
+		return ret;
+
+	ret = mount("", "/", NULL, MS_REC|MS_PRIVATE, NULL);
+	if (ret) {
+		ksft_print_msg("making mount tree private: %s\n", strerror(errno));
+		return ret;
+	}
+
+	return 0;
+}
+
 /* caps_down - lower all effective caps */
 int caps_down(void)
 {
diff --git a/tools/testing/selftests/filesystems/utils.h b/tools/testing/selftests/filesystems/utils.h
index d9cf145b321a..70f7ccc607f4 100644
--- a/tools/testing/selftests/filesystems/utils.h
+++ b/tools/testing/selftests/filesystems/utils.h
@@ -27,6 +27,7 @@ extern int caps_down(void);
 extern int cap_down(cap_value_t down);
 
 extern bool switch_ids(uid_t uid, gid_t gid);
+extern int setup_userns(void);
 
 static inline bool switch_userns(int fd, uid_t uid, gid_t gid, bool drop_caps)
 {
-- 
2.34.1


