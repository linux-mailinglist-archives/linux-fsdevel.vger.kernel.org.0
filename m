Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F52B5977FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 22:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiHQUai (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 16:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241966AbiHQUaY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 16:30:24 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9671DA98D3;
        Wed, 17 Aug 2022 13:30:22 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o22so18962563edc.10;
        Wed, 17 Aug 2022 13:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CU7UfL6wEL0y5Oi4r0g+oADsGvcV7i1sDoIV91jwnLs=;
        b=PEWURrXXCLkgFJ3pkzJ3Srt7LI+5ZeJbeD3eSLjEYdk06WlkEqBEPTVkjMNtvoR065
         Kcvi3oPMl9eSeQmSwQKtGp8Z5GZXVZCQNhuVrndvkOUhomKCcclfyM9vM4OcPfZYh6NO
         eijY78QeEsz/4itqsZP0PnP0e3qISobB3cRqCSVPOestWyNzrk3nB+vnTEv1Wp+vSAIJ
         GjVqtmDR87P8gydoVCZz9Un8CAb2k275geZNULv4b2fQxn17ULeUde9UGnwhmAc9v/3+
         R7eUi8wrcRF7/h3oogBxUnJn+NuSEA0/PPE4G3HRBnceZxN7mYoNjgivDhC5vIqI45kp
         f21w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CU7UfL6wEL0y5Oi4r0g+oADsGvcV7i1sDoIV91jwnLs=;
        b=yamFvWzpKOMW1Z5CTFeEjX3pCaLR5i0EbYJpzlmd6VNflFQdUJqANWgIemFnUUqZ7j
         Nkt7ngZHXfXbdQ30VlpgmZUeEJLwhJMn5t6cJ200NSG/bKsmTaJHAiUebcWXj5+blySs
         MxP0hqtnu1Cilk0klVRsxtA9cmJW1zUvdkkSsw+BtT8kyI7TahpGU3x9SYWd6S8vZoBF
         o+SnDUNZRPa3J7N0L+dX/2EjgpfmvQ1B/veHXHvF+TqmbsxeteiiNQAx2cxVaYMtfyse
         ZnpaCt4doxNhWRzwi8I2wPzXNqQl5P4Z4unChUsdKQiEWxuuaHzc9kgIrmmvf/735fP6
         oCew==
X-Gm-Message-State: ACgBeo3HJwQPQ+rkUafj7Q8jluNm2AFMZq43a1+Wky/7mFT35lW0l2w8
        ypatW3pNPFsqYvZzCwsZzTJDaTc60QQ=
X-Google-Smtp-Source: AA6agR5mk7L2cu2kL3cjj1YR8oNJBXUAjAjfHL3pl7YtjhQva2sdWaKc+9lfRcjWjsQsHujhOBtrQA==
X-Received: by 2002:a05:6402:500d:b0:440:9bc5:d0c1 with SMTP id p13-20020a056402500d00b004409bc5d0c1mr24733908eda.202.1660768221088;
        Wed, 17 Aug 2022 13:30:21 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id p7-20020a17090653c700b0073b0c2d420dsm512042ejo.217.2022.08.17.13.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 13:30:20 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v5 2/4] selftests/landlock: Selftests for file truncation support
Date:   Wed, 17 Aug 2022 22:30:04 +0200
Message-Id: <20220817203006.21769-3-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220817203006.21769-1-gnoack3000@gmail.com>
References: <20220817203006.21769-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

These tests exercise the following truncation operations:

* truncate() (truncate by path)
* ftruncate() (truncate by file descriptor)
* open with the O_TRUNC flag
* special case: creat(), which is open with O_CREAT|O_WRONLY|O_TRUNC.

in the following scenarios:

* Files with read, write and truncate rights.
* Files with read and truncate rights.
* Files with the truncate right.
* Files without the truncate right.

In particular, the following scenarios are enforced with the test:

* ftruncate() requires the truncate right,
  even when the thread already has the right to write to the file.
* open() with O_TRUNC requires the truncate right, if it truncates a file.
  open() already checks security_path_truncate() in this case,
  and it required no additional check in the Landlock LSM's file_open hook.
* creat() requires the truncate right
  when called with an existing filename.
* creat() does *not* require the truncate right
  when it's creating a new file.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 250 +++++++++++++++++++++
 1 file changed, 250 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index cb77eaa01c91..010d4c59139e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -58,6 +58,7 @@ static const char file1_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f1";
 static const char file2_s2d3[] = TMP_DIR "/s2d1/s2d2/s2d3/f2";
 
 static const char dir_s3d1[] = TMP_DIR "/s3d1";
+static const char file1_s3d1[] = TMP_DIR "/s3d1/f1";
 /* dir_s3d2 is a mount point. */
 static const char dir_s3d2[] = TMP_DIR "/s3d1/s3d2";
 static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
@@ -83,6 +84,7 @@ static const char dir_s3d3[] = TMP_DIR "/s3d1/s3d2/s3d3";
  * │           ├── f1
  * │           └── f2
  * └── s3d1
+ *     ├── f1
  *     └── s3d2
  *         └── s3d3
  */
@@ -208,6 +210,7 @@ static void create_layout1(struct __test_metadata *const _metadata)
 	create_file(_metadata, file1_s2d3);
 	create_file(_metadata, file2_s2d3);
 
+	create_file(_metadata, file1_s3d1);
 	create_directory(_metadata, dir_s3d2);
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	ASSERT_EQ(0, mount("tmp", dir_s3d2, "tmpfs", 0, "size=4m,mode=700"));
@@ -230,6 +233,7 @@ static void remove_layout1(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(file1_s2d2));
 	EXPECT_EQ(0, remove_path(file1_s2d1));
 
+	EXPECT_EQ(0, remove_path(file1_s3d1));
 	EXPECT_EQ(0, remove_path(dir_s3d3));
 	set_cap(_metadata, CAP_SYS_ADMIN);
 	umount(dir_s3d2);
@@ -3023,6 +3027,252 @@ TEST_F_FORK(layout1, proc_pipe)
 	ASSERT_EQ(0, close(pipe_fds[1]));
 }
 
+/* Invokes truncate(2) and returns its errno or 0. */
+static int test_truncate(const char *const path)
+{
+	if (truncate(path, 10) < 0)
+		return errno;
+	return 0;
+}
+
+/* Invokes ftruncate(2) and returns its errno or 0. */
+static int test_ftruncate(int fd)
+{
+	if (ftruncate(fd, 10) < 0)
+		return errno;
+	return 0;
+}
+
+/*
+ * Invokes creat(2) and returns its errno or 0.
+ * Closes the opened file descriptor on success.
+ */
+static int test_creat(const char *const path, mode_t mode)
+{
+	int fd = creat(path, mode);
+
+	if (fd < 0)
+		return errno;
+
+	/*
+	 * Mixing error codes from close(2) and creat(2) should not lead to any
+	 * (access type) confusion for this test.
+	 */
+	if (close(fd) < 0)
+		return errno;
+	return 0;
+}
+
+/*
+ * Exercises file truncation when it's not restricted,
+ * as it was the case before LANDLOCK_ACCESS_FS_TRUNCATE existed.
+ */
+TEST_F_FORK(layout1, truncate_unhandled)
+{
+	const char *const file_r = file1_s1d1;
+	const char *const file_w = file2_s1d1;
+	const char *const file_none = file1_s1d2;
+	int file_r_fd, file_w_fd, file_none_fd;
+	const struct rule rules[] = {
+		{
+			.path = file_r,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE,
+		},
+		{
+			.path = file_w,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		/* Implicitly: No rights for file_none. */
+		{},
+	};
+
+	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
+			      LANDLOCK_ACCESS_FS_WRITE_FILE;
+	int ruleset_fd;
+
+	/*
+	 * Open some writable file descriptors before enabling Landlock, so that
+	 * we can test ftruncate() without making open() a prerequisite.
+	 */
+	file_r_fd = open(file_r, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_r_fd);
+	file_w_fd = open(file_w, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_w_fd);
+	file_none_fd = open(file_none, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_none_fd);
+
+	/* Enable Landlock. */
+	ruleset_fd = create_ruleset(_metadata, handled, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks read right: truncate, ftruncate and open with O_TRUNC work,
+	 * unless the file is attempted to be opened for writing.
+	 */
+	EXPECT_EQ(0, test_truncate(file_r));
+	EXPECT_EQ(0, test_ftruncate(file_r_fd));
+	EXPECT_EQ(0, test_open(file_r, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_r, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_creat(file_r, 0600));
+
+	/*
+	 * Checks write right: truncate, ftruncate and open with O_TRUNC work,
+	 * unless the file is attempted to be opened for reading.
+	 */
+	EXPECT_EQ(0, test_truncate(file_w));
+	EXPECT_EQ(0, test_ftruncate(file_w_fd));
+	EXPECT_EQ(EACCES, test_open(file_w, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(0, test_open(file_w, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(0, test_creat(file_w, 0600));
+
+	/*
+	 * Checks "no rights" case: truncate and ftruncate work but all open
+	 * attempts fail, including creat.
+	 */
+	EXPECT_EQ(0, test_truncate(file_none));
+	EXPECT_EQ(0, test_ftruncate(file_none_fd));
+	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_creat(file_none, 0600));
+
+	ASSERT_EQ(0, close(file_r_fd));
+	ASSERT_EQ(0, close(file_w_fd));
+	ASSERT_EQ(0, close(file_none_fd));
+}
+
+TEST_F_FORK(layout1, truncate)
+{
+	const char *const file_rwt = file1_s1d1;
+	const char *const file_rw = file2_s1d1;
+	const char *const file_rt = file1_s1d2;
+	const char *const file_t = file2_s1d2;
+	const char *const file_none = file1_s1d3;
+	const char *const dir_t = dir_s2d1;
+	const char *const file_in_dir_t = file1_s2d1;
+	const char *const dir_w = dir_s3d1;
+	const char *const file_in_dir_w = file1_s3d1;
+	int file_rwt_fd, file_rw_fd, file_rt_fd, file_t_fd, file_none_fd;
+	int file_in_dir_t_fd, file_in_dir_w_fd;
+	const struct rule rules[] = {
+		{
+			.path = file_rwt,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE |
+				  LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = file_rw,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{
+			.path = file_rt,
+			.access = LANDLOCK_ACCESS_FS_READ_FILE |
+				  LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = file_t,
+			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		/* Implicitly: No access rights for file_none. */
+		{
+			.path = dir_t,
+			.access = LANDLOCK_ACCESS_FS_TRUNCATE,
+		},
+		{
+			.path = dir_w,
+			.access = LANDLOCK_ACCESS_FS_WRITE_FILE,
+		},
+		{},
+	};
+	const __u64 handled = LANDLOCK_ACCESS_FS_READ_FILE |
+			      LANDLOCK_ACCESS_FS_WRITE_FILE |
+			      LANDLOCK_ACCESS_FS_TRUNCATE;
+	int ruleset_fd;
+
+	/*
+	 * Open some writable file descriptors before enabling Landlock, so that
+	 * we can test ftruncate() without making open() a prerequisite.
+	 */
+	file_rwt_fd = open(file_rwt, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_rwt_fd);
+	file_rw_fd = open(file_rw, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_rw_fd);
+	file_rt_fd = open(file_rt, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_rt_fd);
+	file_t_fd = open(file_t, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_t_fd);
+	file_none_fd = open(file_none, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_none_fd);
+	file_in_dir_t_fd = open(file_in_dir_t, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_in_dir_t_fd);
+	file_in_dir_w_fd = open(file_in_dir_w, O_WRONLY | O_CLOEXEC);
+	ASSERT_LE(0, file_in_dir_w_fd);
+
+	/* Enable Landlock. */
+	ruleset_fd = create_ruleset(_metadata, handled, rules);
+
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Checks read, write and truncate rights: truncation works. */
+	EXPECT_EQ(0, test_truncate(file_rwt));
+	EXPECT_EQ(0, test_ftruncate(file_rwt_fd));
+	EXPECT_EQ(0, test_open(file_rwt, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(0, test_open(file_rwt, O_WRONLY | O_TRUNC));
+
+	/* Checks read and write rights: no truncate variant works. */
+	EXPECT_EQ(EACCES, test_truncate(file_rw));
+	EXPECT_EQ(EACCES, test_ftruncate(file_rw_fd));
+	EXPECT_EQ(EACCES, test_open(file_rw, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_rw, O_WRONLY | O_TRUNC));
+
+	/*
+	 * Checks read and truncate rights: truncation works.
+	 *
+	 * Note: Files can get truncated using open() even with O_RDONLY.
+	 */
+	EXPECT_EQ(0, test_truncate(file_rt));
+	EXPECT_EQ(0, test_ftruncate(file_rt_fd));
+	EXPECT_EQ(0, test_open(file_rt, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_rt, O_WRONLY | O_TRUNC));
+
+	/* Checks truncate right: truncate works, but can't open file. */
+	EXPECT_EQ(0, test_truncate(file_t));
+	EXPECT_EQ(0, test_ftruncate(file_t_fd));
+	EXPECT_EQ(EACCES, test_open(file_t, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_t, O_WRONLY | O_TRUNC));
+
+	/* Checks "no rights" case: No form of truncation works. */
+	EXPECT_EQ(EACCES, test_truncate(file_none));
+	EXPECT_EQ(EACCES, test_ftruncate(file_none_fd));
+	EXPECT_EQ(EACCES, test_open(file_none, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_none, O_WRONLY | O_TRUNC));
+
+	/*
+	 * Checks truncate right on directory: truncate works on contained
+	 * files.
+	 */
+	EXPECT_EQ(0, test_truncate(file_in_dir_t));
+	EXPECT_EQ(0, test_ftruncate(file_in_dir_t_fd));
+	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_RDONLY | O_TRUNC));
+	EXPECT_EQ(EACCES, test_open(file_in_dir_t, O_WRONLY | O_TRUNC));
+
+	/*
+	 * Checks creat in dir_w: This requires the truncate right when
+	 * overwriting an existing file, but does not require it when the file
+	 * is new.
+	 */
+	EXPECT_EQ(EACCES, test_creat(file_in_dir_w, 0600));
+
+	ASSERT_EQ(0, unlink(file_in_dir_w));
+	EXPECT_EQ(0, test_creat(file_in_dir_w, 0600));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.37.2

