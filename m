Return-Path: <linux-fsdevel+bounces-70211-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D0568C93B03
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 10:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4EE724E1BC1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Nov 2025 09:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44F942773CB;
	Sat, 29 Nov 2025 09:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GtCGuny0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B3A245014
	for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 09:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764407736; cv=none; b=Y9iydAwUXBKh/3ZGYQ3FEqSM+Sd4yfVN9x2SvatvORpHehvXOulRXpamsCOGTp4vePH3SK0zXCkn7hiWByREKJ8VY6dVDqz7/Al/Uj3b3bg4gXoePwtPJkt0IdjdPj3JRKVGUD7WditgtHdZ2iJO8HoRZ+xaduH6Kh7+LxfZd0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764407736; c=relaxed/simple;
	bh=g44NCATS1TCM4N3MVgj2aM+W4i89Z9A+wULVk7cS86E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy0rj9rKW/2Et2a3zSs57ozc0p9MfZ7Xb5NGlEUG5s2sGE14HvnbZJLrAEAikOEQmqm3tkiy+JDPQa1kSM8NYNiwQEQZIilShjBKXs6kzHhMr1Tbjt6/iqqt0b9eUR4g++uqKF7pC8hvRvwFGEtOaX0z508Jwi6y86wcLoQk210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GtCGuny0; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7bc0cd6a13aso1601029b3a.0
        for <linux-fsdevel@vger.kernel.org>; Sat, 29 Nov 2025 01:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764407734; x=1765012534; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dR6VknWnQZF4bSIzafZo2V382x8cKwTyyx/xFmReEY=;
        b=GtCGuny0JKPxy1lgupIwYdq780gZdI1gIqBA7ZYsW5vGohRQ2yxZlxtwfPvKUPRVUe
         aG5RfvHUe/kXgLzRTHTT6Z5OqoxrjmZEfjQZODiqj1Ll4da6XglLyXg+A69kl+QcMk1p
         nE52RahsgFr1vKAPZkAVjeEZpF0gN1zgDiZNd4blvcA2WG+Qy6Ap/pk/Mu5h1HB8JG3o
         4doO5lZl23X3wo9DxleVnYu0F92ee4UHKd5CQwAOTHqpW1iFOg2nlWbxV5w1r4hyFlVU
         fqG/bCdqHNSqnE557D8QNiaWRi3+B2gxlpXazwKHHlH7OQNf/z9N8DNYcxHFJo2OzAjx
         BYvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764407734; x=1765012534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8dR6VknWnQZF4bSIzafZo2V382x8cKwTyyx/xFmReEY=;
        b=f+Yp9iP99Wru4qmd1i0jr/rDlCOvvfpIAQstOZ9Wb0j0WVvdzr9AdsjWRQMf8psSoi
         wIQ2FzrkmPPiEQCTTffJqRF53jd09lowytR+uk573Tk4uhsWekSdLdncMQ69fWUpp84n
         w5YngvLrnwagVKGLqGR0lrrWFYWC2KZiYVnMv0duDse+UYl/gpM/kfjkCP7jRkpSHnnQ
         WX21FhtDu4XlsUF+C0E4FUJyiaVwy53nUaDe5DCIL5Xb2D43AWcyeYEUuJhR979EJVr2
         IL9651T4/1YpPWUII/fbLlw4Pb2C42bWDHS/WuGi+Tb454mwYsfM3FWPgjF2MpaIug4J
         oJFg==
X-Gm-Message-State: AOJu0Yxj5SeKZLddL+0Y4UZCdCtBDuebcydSbYKE+KVuSqcUMd3zWaao
	pukxMjnvyjg2sfjDEi0XUZioc9BhUrkNh1w6n1x6gEVJDRMR+IT7PZJI
X-Gm-Gg: ASbGnctSuX45v32x77qBEDoYiZm/rS9Yli3Y4yMeKj0MG5EZyWVsXZ9t+BwqVCywQVC
	YT8gt0fYBnayo+HDGLNF/4Q60qje4kCgAUQ7Rk0t68o9qIZeEE+3I2wcfBiC23eHaXB/hE5ADnt
	vJKVssy+KDjKlUYwzYu5LExRqhP5WJE5wRmBwN6uy0DTQiZ7LEpcpNadxekTDhBL0h2WDjBZZix
	2f8L3ie5BAzFIsIXkjHlxLtY/XsEs44gsIsYorxAVH2RnjeD31H3S++ZzriZY8pTb95eEItiziL
	Jpct4U8IQeMTcPs4xwHSBv75fQ14NrHaqObnN2kVHbVPoJROSYK2UmjHG9KldwZKFvb6dJ2XUVl
	6zKknC+6h4+EuyVp9xd4milJ63h2tSRnjYZtn7LeCgLhxSVti+hmKAnNkSAAMJDUg/cExOyyAUn
	SWR0uBashhYE8=
X-Google-Smtp-Source: AGHT+IHruZIAOHm6EMOKF1APwodVcDGXlfmCY/BJnPMVAX/ATWPHaJ22ObFNln7/rm4RyHPip0Lemg==
X-Received: by 2002:a05:6a00:cc8:b0:77d:98ee:e1c5 with SMTP id d2e1a72fcca58-7c42066e5f7mr37864729b3a.15.1764407733645;
        Sat, 29 Nov 2025 01:15:33 -0800 (PST)
Received: from fedora ([2405:201:3017:184:2d1c:8c4c:2945:3f7c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7d15e7db416sm7300563b3a.41.2025.11.29.01.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 01:15:33 -0800 (PST)
From: Bhavik Sachdev <b.sachdev1904@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	criu@lists.linux.dev,
	Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Bhavik Sachdev <b.sachdev1904@gmail.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	Andrei Vagin <avagin@gmail.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	John Hubbard <jhubbard@nvidia.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Andrew Donnellan <ajd@linux.ibm.com>
Subject: [PATCH v7 3/3] selftests: statmount: tests for STATMOUNT_BY_FD
Date: Sat, 29 Nov 2025 14:41:22 +0530
Message-ID: <20251129091455.757724-4-b.sachdev1904@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251129091455.757724-1-b.sachdev1904@gmail.com>
References: <20251129091455.757724-1-b.sachdev1904@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tests for STATMOUNT_BY_FD flag, which adds support for passing a
file descriptors to statmount(). The fd can also be on a "unmounted"
mount (mount unmounted with MNT_DETACH), we also include tests for that.

Co-developed-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Bhavik Sachdev <b.sachdev1904@gmail.com>
---
 .../filesystems/statmount/statmount.h         |  15 +-
 .../filesystems/statmount/statmount_test.c    | 261 +++++++++++++++++-
 .../filesystems/statmount/statmount_test_ns.c | 101 ++++++-
 3 files changed, 354 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/filesystems/statmount/statmount.h b/tools/testing/selftests/filesystems/statmount/statmount.h
index 99e5ad082fb1..e1cba4bfd8d9 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount.h
+++ b/tools/testing/selftests/filesystems/statmount/statmount.h
@@ -43,19 +43,24 @@
 	#endif
 #endif
 
-static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint64_t mask,
-			    struct statmount *buf, size_t bufsize,
+static inline int statmount(uint64_t mnt_id, uint64_t mnt_ns_id, uint32_t fd,
+			    uint64_t mask, struct statmount *buf, size_t bufsize,
 			    unsigned int flags)
 {
 	struct mnt_id_req req = {
 		.size = MNT_ID_REQ_SIZE_VER0,
-		.mnt_id = mnt_id,
 		.param = mask,
 	};
 
-	if (mnt_ns_id) {
+	if (flags & STATMOUNT_BY_FD) {
 		req.size = MNT_ID_REQ_SIZE_VER1;
-		req.mnt_ns_id = mnt_ns_id;
+		req.mnt_fd = fd;
+	} else {
+		req.mnt_id = mnt_id;
+		if (mnt_ns_id) {
+			req.size = MNT_ID_REQ_SIZE_VER1;
+			req.mnt_ns_id = mnt_ns_id;
+		}
 	}
 
 	return syscall(__NR_statmount, &req, buf, bufsize, flags);
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test.c b/tools/testing/selftests/filesystems/statmount/statmount_test.c
index f048042e53e9..4790a349806e 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test.c
@@ -33,15 +33,24 @@ static const char *const known_fs[] = {
 	"sysv", "tmpfs", "tracefs", "ubifs", "udf", "ufs", "v7", "vboxsf",
 	"vfat", "virtiofs", "vxfs", "xenfs", "xfs", "zonefs", NULL };
 
-static struct statmount *statmount_alloc(uint64_t mnt_id, uint64_t mask, unsigned int flags)
+static struct statmount *statmount_alloc(uint64_t mnt_id, int fd, uint64_t mask, unsigned int flags)
 {
 	size_t bufsize = 1 << 15;
-	struct statmount *buf = NULL, *tmp = alloca(bufsize);
+	struct statmount *buf = NULL, *tmp = NULL;
 	int tofree = 0;
 	int ret;
 
+	if (flags & STATMOUNT_BY_FD && fd < 0)
+		return NULL;
+
+	tmp = alloca(bufsize);
+
 	for (;;) {
-		ret = statmount(mnt_id, 0, mask, tmp, bufsize, flags);
+		if (flags & STATMOUNT_BY_FD)
+			ret = statmount(0, 0, (uint32_t) fd, mask, tmp, bufsize, flags);
+		else
+			ret = statmount(mnt_id, 0, 0, mask, tmp, bufsize, flags);
+
 		if (ret != -1)
 			break;
 		if (tofree)
@@ -237,7 +246,7 @@ static void test_statmount_zero_mask(void)
 	struct statmount sm;
 	int ret;
 
-	ret = statmount(root_id, 0, 0, &sm, sizeof(sm), 0);
+	ret = statmount(root_id, 0, 0, 0, &sm, sizeof(sm), 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount zero mask: %s\n",
 				      strerror(errno));
@@ -263,7 +272,7 @@ static void test_statmount_mnt_basic(void)
 	int ret;
 	uint64_t mask = STATMOUNT_MNT_BASIC;
 
-	ret = statmount(root_id, 0, mask, &sm, sizeof(sm), 0);
+	ret = statmount(root_id, 0, 0, mask, &sm, sizeof(sm), 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount mnt basic: %s\n",
 				      strerror(errno));
@@ -323,7 +332,7 @@ static void test_statmount_sb_basic(void)
 	struct statx sx;
 	struct statfs sf;
 
-	ret = statmount(root_id, 0, mask, &sm, sizeof(sm), 0);
+	ret = statmount(root_id, 0, 0, mask, &sm, sizeof(sm), 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount sb basic: %s\n",
 				      strerror(errno));
@@ -375,7 +384,7 @@ static void test_statmount_mnt_point(void)
 {
 	struct statmount *sm;
 
-	sm = statmount_alloc(root_id, STATMOUNT_MNT_POINT, 0);
+	sm = statmount_alloc(root_id, 0, STATMOUNT_MNT_POINT, 0);
 	if (!sm) {
 		ksft_test_result_fail("statmount mount point: %s\n",
 				      strerror(errno));
@@ -405,7 +414,7 @@ static void test_statmount_mnt_root(void)
 	assert(last_dir);
 	last_dir++;
 
-	sm = statmount_alloc(root_id, STATMOUNT_MNT_ROOT, 0);
+	sm = statmount_alloc(root_id, 0, STATMOUNT_MNT_ROOT, 0);
 	if (!sm) {
 		ksft_test_result_fail("statmount mount root: %s\n",
 				      strerror(errno));
@@ -438,7 +447,7 @@ static void test_statmount_fs_type(void)
 	const char *fs_type;
 	const char *const *s;
 
-	sm = statmount_alloc(root_id, STATMOUNT_FS_TYPE, 0);
+	sm = statmount_alloc(root_id, 0, STATMOUNT_FS_TYPE, 0);
 	if (!sm) {
 		ksft_test_result_fail("statmount fs type: %s\n",
 				      strerror(errno));
@@ -467,7 +476,7 @@ static void test_statmount_mnt_opts(void)
 	char *line = NULL;
 	size_t len = 0;
 
-	sm = statmount_alloc(root_id, STATMOUNT_MNT_BASIC | STATMOUNT_MNT_OPTS,
+	sm = statmount_alloc(root_id, 0, STATMOUNT_MNT_BASIC | STATMOUNT_MNT_OPTS,
 			     0);
 	if (!sm) {
 		ksft_test_result_fail("statmount mnt opts: %s\n",
@@ -557,7 +566,7 @@ static void test_statmount_string(uint64_t mask, size_t off, const char *name)
 	uint32_t start, i;
 	int ret;
 
-	sm = statmount_alloc(root_id, mask, 0);
+	sm = statmount_alloc(root_id, 0, mask, 0);
 	if (!sm) {
 		ksft_test_result_fail("statmount %s: %s\n", name,
 				      strerror(errno));
@@ -586,14 +595,14 @@ static void test_statmount_string(uint64_t mask, size_t off, const char *name)
 	exactsize = sm->size;
 	shortsize = sizeof(*sm) + i;
 
-	ret = statmount(root_id, 0, mask, sm, exactsize, 0);
+	ret = statmount(root_id, 0, 0, mask, sm, exactsize, 0);
 	if (ret == -1) {
 		ksft_test_result_fail("statmount exact size: %s\n",
 				      strerror(errno));
 		goto out;
 	}
 	errno = 0;
-	ret = statmount(root_id, 0, mask, sm, shortsize, 0);
+	ret = statmount(root_id, 0, 0, mask, sm, shortsize, 0);
 	if (ret != -1 || errno != EOVERFLOW) {
 		ksft_test_result_fail("should have failed with EOVERFLOW: %s\n",
 				      strerror(errno));
@@ -658,6 +667,226 @@ static void test_listmount_tree(void)
 	ksft_test_result_pass("listmount tree\n");
 }
 
+static void test_statmount_by_fd(void)
+{
+	struct statmount *sm = NULL;
+	char tmpdir[] = "/statmount.fd.XXXXXX";
+	const char root[] = "/test";
+	char subdir[PATH_MAX], tmproot[PATH_MAX];
+	int fd;
+
+	if (!mkdtemp(tmpdir)) {
+		ksft_perror("mkdtemp");
+		return;
+	}
+
+	if (mount("statmount.test", tmpdir, "tmpfs", 0, NULL)) {
+		ksft_perror("mount");
+		rmdir(tmpdir);
+		return;
+	}
+
+	snprintf(subdir, PATH_MAX, "%s%s", tmpdir, root);
+	snprintf(tmproot, PATH_MAX, "%s/%s", tmpdir, "chroot");
+
+	if (mkdir(subdir, 0755)) {
+		ksft_perror("mkdir");
+		goto err_tmpdir;
+	}
+
+	if (mount(subdir, subdir, NULL, MS_BIND, 0)) {
+		ksft_perror("mount");
+		goto err_subdir;
+	}
+
+	if (mkdir(tmproot, 0755)) {
+		ksft_perror("mkdir");
+		goto err_subdir;
+	}
+
+	fd = open(subdir, O_PATH);
+	if (fd < 0) {
+		ksft_perror("open");
+		goto err_tmproot;
+	}
+
+	if (chroot(tmproot)) {
+		ksft_perror("chroot");
+		goto err_fd;
+	}
+
+	sm = statmount_alloc(0, fd, STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT, STATMOUNT_BY_FD);
+	if (!sm) {
+		ksft_test_result_fail("statmount by fd failed: %s\n", strerror(errno));
+		goto err_chroot;
+	}
+
+	if (sm->size < sizeof(*sm)) {
+		ksft_test_result_fail("unexpected size: %u < %u\n",
+				      sm->size, (uint32_t) sizeof(*sm));
+		goto err_chroot;
+	}
+
+	if (sm->mask & STATMOUNT_MNT_POINT) {
+		ksft_test_result_fail("STATMOUNT_MNT_POINT unexpectedly set in statmount\n");
+		goto err_chroot;
+	}
+
+	if (!(sm->mask & STATMOUNT_MNT_ROOT)) {
+		ksft_test_result_fail("STATMOUNT_MNT_ROOT not set in statmount\n");
+		goto err_chroot;
+	}
+
+	if (strcmp(root, sm->str + sm->mnt_root) != 0) {
+		ksft_test_result_fail("statmount returned incorrect mnt_root,"
+			"statmount mnt_root: %s != %s\n",
+			sm->str + sm->mnt_root, root);
+		goto err_chroot;
+	}
+
+	if (chroot(".")) {
+		ksft_perror("chroot");
+		goto out;
+	}
+
+	free(sm);
+	sm = statmount_alloc(0, fd, STATMOUNT_MNT_ROOT | STATMOUNT_MNT_POINT, STATMOUNT_BY_FD);
+	if (!sm) {
+		ksft_test_result_fail("statmount by fd failed: %s\n", strerror(errno));
+		goto err_fd;
+	}
+
+	if (sm->size < sizeof(*sm)) {
+		ksft_test_result_fail("unexpected size: %u < %u\n",
+				      sm->size, (uint32_t) sizeof(*sm));
+		goto out;
+	}
+
+	if (!(sm->mask & STATMOUNT_MNT_POINT)) {
+		ksft_test_result_fail("STATMOUNT_MNT_POINT not set in statmount\n");
+		goto out;
+	}
+
+	if (!(sm->mask & STATMOUNT_MNT_ROOT)) {
+		ksft_test_result_fail("STATMOUNT_MNT_ROOT not set in statmount\n");
+		goto out;
+	}
+
+	if (strcmp(subdir, sm->str + sm->mnt_point) != 0) {
+		ksft_test_result_fail("statmount returned incorrect mnt_point,"
+			"statmount mnt_point: %s != %s\n", sm->str + sm->mnt_point, subdir);
+		goto out;
+	}
+
+	if (strcmp(root, sm->str + sm->mnt_root) != 0) {
+		ksft_test_result_fail("statmount returned incorrect mnt_root,"
+			"statmount mnt_root: %s != %s\n", sm->str + sm->mnt_root, root);
+		goto out;
+	}
+
+	ksft_test_result_pass("statmount by fd\n");
+	goto out;
+err_chroot:
+	chroot(".");
+out:
+	free(sm);
+err_fd:
+	close(fd);
+err_tmproot:
+	rmdir(tmproot);
+err_subdir:
+	umount2(subdir, MNT_DETACH);
+	rmdir(subdir);
+err_tmpdir:
+	umount2(tmpdir, MNT_DETACH);
+	rmdir(tmpdir);
+}
+
+static void test_statmount_by_fd_unmounted(void)
+{
+	const char root[] = "/test.unmounted";
+	char tmpdir[] = "/statmount.fd.XXXXXX";
+	char subdir[PATH_MAX];
+	int fd;
+	struct statmount *sm = NULL;
+
+	if (!mkdtemp(tmpdir)) {
+		ksft_perror("mkdtemp");
+		return;
+	}
+
+	if (mount("statmount.test", tmpdir, "tmpfs", 0, NULL)) {
+		ksft_perror("mount");
+		rmdir(tmpdir);
+		return;
+	}
+
+	snprintf(subdir, PATH_MAX, "%s%s", tmpdir, root);
+
+	if (mkdir(subdir, 0755)) {
+		ksft_perror("mkdir");
+		goto err_tmpdir;
+	}
+
+	if (mount(subdir, subdir, 0, MS_BIND, NULL)) {
+		ksft_perror("mount");
+		goto err_subdir;
+	}
+
+	fd = open(subdir, O_PATH);
+	if (fd < 0) {
+		ksft_perror("open");
+		goto err_subdir;
+	}
+
+	if (umount2(tmpdir, MNT_DETACH)) {
+		ksft_perror("umount2");
+		goto err_fd;
+	}
+
+	sm = statmount_alloc(0, fd, STATMOUNT_MNT_POINT | STATMOUNT_MNT_ROOT, STATMOUNT_BY_FD);
+	if (!sm) {
+		ksft_test_result_fail("statmount by fd unmounted: %s\n",
+				      strerror(errno));
+		goto err_sm;
+	}
+
+	if (sm->size < sizeof(*sm)) {
+		ksft_test_result_fail("unexpected size: %u < %u\n",
+				      sm->size, (uint32_t) sizeof(*sm));
+		goto err_sm;
+	}
+
+	if (sm->mask & STATMOUNT_MNT_POINT) {
+		ksft_test_result_fail("STATMOUNT_MNT_POINT unexpectedly set in mask\n");
+		goto err_sm;
+	}
+
+	if (!(sm->mask & STATMOUNT_MNT_ROOT)) {
+		ksft_test_result_fail("STATMOUNT_MNT_ROOT not set in mask\n");
+		goto err_sm;
+	}
+
+	if (strcmp(sm->str + sm->mnt_root, root) != 0) {
+		ksft_test_result_fail("statmount returned incorrect mnt_root,"
+			"statmount mnt_root: %s != %s\n",
+			sm->str + sm->mnt_root, root);
+		goto err_sm;
+	}
+
+	ksft_test_result_pass("statmount by fd on unmounted mount\n");
+err_sm:
+	free(sm);
+err_fd:
+	close(fd);
+err_subdir:
+	umount2(subdir, MNT_DETACH);
+	rmdir(subdir);
+err_tmpdir:
+	umount2(tmpdir, MNT_DETACH);
+	rmdir(tmpdir);
+}
+
 #define str_off(memb) (offsetof(struct statmount, memb) / sizeof(uint32_t))
 
 int main(void)
@@ -669,14 +898,14 @@ int main(void)
 
 	ksft_print_header();
 
-	ret = statmount(0, 0, 0, NULL, 0, 0);
+	ret = statmount(0, 0, 0, 0, NULL, 0, 0);
 	assert(ret == -1);
 	if (errno == ENOSYS)
 		ksft_exit_skip("statmount() syscall not supported\n");
 
 	setup_namespace();
 
-	ksft_set_plan(15);
+	ksft_set_plan(17);
 	test_listmount_empty_root();
 	test_statmount_zero_mask();
 	test_statmount_mnt_basic();
@@ -693,6 +922,8 @@ int main(void)
 	test_statmount_string(all_mask, str_off(fs_type), "fs type & all");
 
 	test_listmount_tree();
+	test_statmount_by_fd_unmounted();
+	test_statmount_by_fd();
 
 
 	if (ksft_get_fail_cnt() + ksft_get_error_cnt() > 0)
diff --git a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
index 605a3fa16bf7..6449b50dde0c 100644
--- a/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
+++ b/tools/testing/selftests/filesystems/statmount/statmount_test_ns.c
@@ -102,7 +102,7 @@ static int _test_statmount_mnt_ns_id(void)
 	if (!root_id)
 		return NSID_ERROR;
 
-	ret = statmount(root_id, 0, STATMOUNT_MNT_NS_ID, &sm, sizeof(sm), 0);
+	ret = statmount(root_id, 0, 0, STATMOUNT_MNT_NS_ID, &sm, sizeof(sm), 0);
 	if (ret == -1) {
 		ksft_print_msg("statmount mnt ns id: %s\n", strerror(errno));
 		return NSID_ERROR;
@@ -128,6 +128,98 @@ static int _test_statmount_mnt_ns_id(void)
 	return NSID_PASS;
 }
 
+static int _test_statmount_mnt_ns_id_by_fd(void)
+{
+	struct statmount sm;
+	uint64_t mnt_ns_id;
+	int ret, fd, mounted = 1, status = NSID_ERROR;
+	char mnt[] = "/statmount.fd.XXXXXX";
+
+	ret = get_mnt_ns_id("/proc/self/ns/mnt", &mnt_ns_id);
+	if (ret != NSID_PASS)
+		return ret;
+
+	if (!mkdtemp(mnt)) {
+		ksft_print_msg("statmount by fd mnt ns id mkdtemp: %s\n", strerror(errno));
+		return NSID_ERROR;
+	}
+
+	if (mount(mnt, mnt, NULL, MS_BIND, 0)) {
+		ksft_print_msg("statmount by fd mnt ns id mount: %s\n", strerror(errno));
+		status = NSID_ERROR;
+		goto err;
+	}
+
+	fd = open(mnt, O_PATH);
+	if (fd < 0) {
+		ksft_print_msg("statmount by fd mnt ns id open: %s\n", strerror(errno));
+		goto err;
+	}
+
+	ret = statmount(0, 0, fd, STATMOUNT_MNT_NS_ID, &sm, sizeof(sm), STATMOUNT_BY_FD);
+	if (ret == -1) {
+		ksft_print_msg("statmount mnt ns id statmount: %s\n", strerror(errno));
+		status = NSID_ERROR;
+		goto out;
+	}
+
+	if (sm.size != sizeof(sm)) {
+		ksft_print_msg("unexpected size: %u != %u\n", sm.size,
+			       (uint32_t)sizeof(sm));
+		status = NSID_FAIL;
+		goto out;
+	}
+	if (sm.mask != STATMOUNT_MNT_NS_ID) {
+		ksft_print_msg("statmount mnt ns id unavailable\n");
+		status = NSID_SKIP;
+		goto out;
+	}
+
+	if (sm.mnt_ns_id != mnt_ns_id) {
+		ksft_print_msg("unexpected mnt ns ID: 0x%llx != 0x%llx\n",
+			       (unsigned long long)sm.mnt_ns_id,
+			       (unsigned long long)mnt_ns_id);
+		status = NSID_FAIL;
+		goto out;
+	}
+
+	mounted = 0;
+	if (umount2(mnt, MNT_DETACH)) {
+		ksft_print_msg("statmount by fd mnt ns id umount2: %s\n", strerror(errno));
+		goto out;
+	}
+
+	ret = statmount(0, 0, fd, STATMOUNT_MNT_NS_ID, &sm, sizeof(sm), STATMOUNT_BY_FD);
+	if (ret == -1) {
+		ksft_print_msg("statmount mnt ns id statmount: %s\n", strerror(errno));
+		status = NSID_ERROR;
+		goto out;
+	}
+
+	if (sm.size != sizeof(sm)) {
+		ksft_print_msg("unexpected size: %u != %u\n", sm.size,
+			       (uint32_t)sizeof(sm));
+		status = NSID_FAIL;
+		goto out;
+	}
+
+	if (sm.mask == STATMOUNT_MNT_NS_ID) {
+		ksft_print_msg("unexpected STATMOUNT_MNT_NS_ID in mask\n");
+		status = NSID_FAIL;
+		goto out;
+	}
+
+	status = NSID_PASS;
+out:
+	close(fd);
+	if (mounted)
+		umount2(mnt, MNT_DETACH);
+err:
+	rmdir(mnt);
+	return status;
+}
+
+
 static void test_statmount_mnt_ns_id(void)
 {
 	pid_t pid;
@@ -148,6 +240,9 @@ static void test_statmount_mnt_ns_id(void)
 	if (ret != NSID_PASS)
 		exit(ret);
 	ret = _test_statmount_mnt_ns_id();
+	if (ret != NSID_PASS)
+		exit(ret);
+	ret = _test_statmount_mnt_ns_id_by_fd();
 	exit(ret);
 }
 
@@ -179,7 +274,7 @@ static int validate_external_listmount(pid_t pid, uint64_t child_nr_mounts)
 	for (int i = 0; i < nr_mounts; i++) {
 		struct statmount sm;
 
-		ret = statmount(list[i], mnt_ns_id, STATMOUNT_MNT_NS_ID, &sm,
+		ret = statmount(list[i], mnt_ns_id, 0, STATMOUNT_MNT_NS_ID, &sm,
 				sizeof(sm), 0);
 		if (ret < 0) {
 			ksft_print_msg("statmount mnt ns id: %s\n", strerror(errno));
@@ -275,7 +370,7 @@ int main(void)
 	int ret;
 
 	ksft_print_header();
-	ret = statmount(0, 0, 0, NULL, 0, 0);
+	ret = statmount(0, 0, 0, 0, NULL, 0, 0);
 	assert(ret == -1);
 	if (errno == ENOSYS)
 		ksft_exit_skip("statmount() syscall not supported\n");
-- 
2.52.0


