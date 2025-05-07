Return-Path: <linux-fsdevel+bounces-48423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B53BFAAED33
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 22:43:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6B279E0C71
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 May 2025 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D0E128FA94;
	Wed,  7 May 2025 20:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjUPPMbY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D8F28C5B5
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 May 2025 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746650594; cv=none; b=VJ//dJPDs1d8NqDvIqKkBX9GTOpH5EMH6wFbZD0t246Idq/UU6WkAGsj9YFK+iFVyw+6eVT89yjT/PPLfvoR11GQQ0awuWP7jbXHNOf/ftWuSv7DgEH+alyfa05cfGov0heBZcEc6+kADzAmQu8YV/oQOAKQW95KvCv+VmZjQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746650594; c=relaxed/simple;
	bh=pQIP0b2IDPAjbOmgZmJxpzYYunZ+YoelplaKIVBMRlY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sE2K5CEKOtybBV7GVFnvwbhTlm1P0E+QHrECaa0vIXb6GU6XYczTn1g0dknC8uZa8h5eKOURGgi1jaIYENa/1vytNcpuCPCu8Bh3tyYpcXJ5gs62hV6s0cI/FCJZCtgck2sL/RlqQRWsfiXFGK94WrH2bxH2fxXlRSoDY5ze2To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjUPPMbY; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5fc5bc05f99so178032a12.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 07 May 2025 13:43:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746650591; x=1747255391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8YhDo0rkarAG2AwN3hGXeYia62FmTMcLkS9tbbVKP/I=;
        b=bjUPPMbYvhfFjsNyMZYIwfRZupCkFYJBr+trjLP40eeqJO4WB/OLePoyrn45hbe2zp
         Ff6H6N05N/qqlQLknZZ05MMKtLnZ51cGnHdzb+mFl2kt1ATe+0MqyCg2J35GsS59OZhG
         vrXCczoa88EW7mgJ3VVfv6E4sfbaqauNJGlda5a9NePZEevtOPM+yrLjUPbCnz1yMXdK
         0fhQDmnG9nvozebKkpOjXe01du5RgQV7nhcG0l35+fG4+3RMmheAdCoeggl9u/6PINBd
         /ab90CE1Ez5MCELgRKFGj2kRFUsZ6N4hTNY1BfJ2sq2ppFq8W19YMu7NowRriH+yl1tA
         qBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746650591; x=1747255391;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YhDo0rkarAG2AwN3hGXeYia62FmTMcLkS9tbbVKP/I=;
        b=nYTD7IwLDS3DNcZXcnY6rSxxY5qdnoJ4kxaeDSmeBTMOyKzTr+ZQKu5jnJe6VNP2Gq
         F/8x4op0vPgYjbyX8wVMzMw0dnL0GOgFOtLkJudDqE/+QBZdYX4QK1ulmEQ2IauEjtQ9
         oWSBdO/Arb3Cln3tHoVlOn8rsw4LQoGjbfTYRM7D9oRgS+m+zzT7JGFyCSMA0TTYdVhz
         YIEF3QNWK2VrnUXiF0yqAOta+u4nL9C7dCX/n2ZfvYYhmRHvwvgBx/WKY39gMkT/0Zeu
         TfCfVznxJe+ntLCusRlBtdJfDGS6hdS7Vp2JLtDc7wBbHxeMYwQdSO4xOdrRz2wNUuaQ
         drQA==
X-Forwarded-Encrypted: i=1; AJvYcCU0l4KDeCDd/fS3jnezwcyJL/4xf8aD08r/ITGK760pk4y98Pxrk9ECuPDUsPhj6w+bWTwTyBGjPp06nRDC@vger.kernel.org
X-Gm-Message-State: AOJu0YwDA/uQpg1j8+7K3WPie2MTYzCa1LgQcUz9r2uAfijL9HIv2CZy
	E3sKnRqaXWOmCtcZ+6wQhWJKlUjPEFlv1SNQAXKfYwbu7t681biw
X-Gm-Gg: ASbGnct9QogG55/oou38u7kJlpV6tGpMt8BZFSaIO4zX9VN23L/cOl8BC1R4H1SnEC6
	GG2Le1PoIoffhJjghILVnycjCYR2zotGjKEV+wN5lpv0bYJ893eq2GOD05b8FK5JE6aaTLzRcbW
	qEUUaQYqecxQLIVTxx5QSskb6jXiqw3ttqICD6JiZxRZ5p4AugbK+Ygfspc3jb7BmsV7x6sZC1E
	Tw3pGP3ws/0Br7rVxSDbhHffckmsnn1EpOq+huteBFOwzjdBHBEUmT7wlUqr8zIB7Kg1cwqygr4
	0sFx4lzA8KY0SRtQc/FzFNcaxztvpRbeYv+kjBeJH7HO119x5zH8VG7JdyO6/pVB7P8K8AAdaCt
	KbFH9PJWPWvJt3Wq14HGMDGIzxrDuyGoKKELivA==
X-Google-Smtp-Source: AGHT+IGpHP4KaEp6zZKiKGMrmx8dlU0sb/BqOLgiKLSUmJHFF+he2bHkei5xSr9bm1msu28SXCbHIQ==
X-Received: by 2002:a05:6402:90e:b0:5ee:497:89fc with SMTP id 4fb4d7f45d1cf-5fbe9fb19admr4199958a12.33.1746650590818;
        Wed, 07 May 2025 13:43:10 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5fbfbe5c5bfsm965615a12.9.2025.05.07.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 13:43:10 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	John Hubbard <jhubbard@nvidia.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 5/5] selftests/filesystems: create setup_userns() helper
Date: Wed,  7 May 2025 22:43:02 +0200
Message-Id: <20250507204302.460913-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250507204302.460913-1-amir73il@gmail.com>
References: <20250507204302.460913-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper to utils and use it in statmount userns tests.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 .../filesystems/statmount/statmount_test_ns.c | 60 +----------------
 tools/testing/selftests/filesystems/utils.c   | 65 +++++++++++++++++++
 tools/testing/selftests/filesystems/utils.h   |  1 +
 3 files changed, 68 insertions(+), 58 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index 375a52101d08..3c5bc2e33821 100644
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
@@ -200,7 +144,7 @@ static void test_statmount_mnt_ns_id(void)
 		return;
 	}
 
-	ret = setup_namespace();
+	ret = setup_userns();
 	if (ret != NSID_PASS)
 		exit(ret);
 	ret = _test_statmount_mnt_ns_id();
diff --git a/tools/testing/selftests/filesystems/utils.c b/tools/testing/selftests/filesystems/utils.c
index 9b5419e6f28d..9dab197ddd9c 100644
--- a/tools/testing/selftests/filesystems/utils.c
+++ b/tools/testing/selftests/filesystems/utils.c
@@ -18,6 +18,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/xattr.h>
+#include <sys/mount.h>
 
 #include "utils.h"
 
@@ -447,6 +448,70 @@ static int create_userns_hierarchy(struct userns_hierarchy *h)
 	return fret;
 }
 
+static int write_file(const char *path, const char *val)
+{
+	int fd = open(path, O_WRONLY);
+	size_t len = strlen(val);
+	int ret;
+
+	if (fd == -1) {
+		syserror("opening %s for write: %s\n", path, strerror(errno));
+		return -1;
+	}
+
+	ret = write(fd, val, len);
+	if (ret == -1) {
+		syserror("writing to %s: %s\n", path, strerror(errno));
+		return -1;
+	}
+	if (ret != len) {
+		syserror("short write to %s\n", path);
+		return -1;
+	}
+
+	ret = close(fd);
+	if (ret == -1) {
+		syserror("closing %s\n", path);
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
+		syserror("unsharing mountns and userns: %s\n", strerror(errno));
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
+		syserror("making mount tree private: %s\n", strerror(errno));
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


