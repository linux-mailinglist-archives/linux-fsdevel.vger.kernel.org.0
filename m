Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A5472CF23
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 21:15:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbjFLTPK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 15:15:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238094AbjFLTOw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:14:52 -0400
Received: from smtp-bc0e.mail.infomaniak.ch (smtp-bc0e.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5340E55
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 12:14:45 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qg1b81s3LzMqCyZ;
        Mon, 12 Jun 2023 19:14:44 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qg1b75Tf7z1WQB;
        Mon, 12 Jun 2023 21:14:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686597284;
        bh=rdq7EKwH+l6EhCxvoupgKx8qdCnnuE3Os8siRpqviNw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Aj6RUB32YFovramb9TLjqqZlUyMhPrODkprhKMa2gNJOB5yCe3nk0/Q+cJ0nS93Za
         o44bVYwF5zkBAKig0VZO37R6v7p2lg9tUq45TXjF1v1tfiavqA0brzv2CXQaj0PbBI
         5F3+Hctn70LtjlTYCg+XNXutHIDkeJ5/DPFMB4EI=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Richard Weinberger <richard@nod.at>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        James Morris <jmorris@namei.org>, Jeff Xu <jeffxu@google.com>,
        Kees Cook <keescook@chromium.org>,
        Paul Moore <paul@paul-moore.com>,
        Ritesh Raj Sarraf <ritesh@collabora.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sjoerd Simons <sjoerd@collabora.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: [PATCH v2 6/6] selftests/landlock: Add hostfs tests
Date:   Mon, 12 Jun 2023 21:14:30 +0200
Message-ID: <20230612191430.339153-7-mic@digikod.net>
In-Reply-To: <20230612191430.339153-1-mic@digikod.net>
References: <20230612191430.339153-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add tests for the hostfs filesystems to make sure it has a consistent
inode management, which is required for Landlock's file hierarchy
identification.  This adds 5 new tests for layout3_fs with the hostfs
variant.

Add hostfs to the new (architecture-specific) config.um file.

The hostfs filesystem, only available for an User-Mode Linux kernel, is
special because we cannot explicitly mount it.  The layout3_fs.hostfs
variant tests are skipped if the current test directory is not backed by
this filesystem.

The layout3_fs.hostfs.tag_inode_dir_child and
layout3_fs.hostfs.tag_inode_file tests pass thanks to a previous commit
fixing hostfs inode management.  Without this fix, the deny-by-default
policy would apply and all access requests would be denied.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/config.um |  1 +
 tools/testing/selftests/landlock/fs_test.c | 28 +++++++++++++++++++++-
 2 files changed, 28 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/landlock/config.um

diff --git a/tools/testing/selftests/landlock/config.um b/tools/testing/selftests/landlock/config.um
new file mode 100644
index 000000000000..40937c0395d6
--- /dev/null
+++ b/tools/testing/selftests/landlock/config.um
@@ -0,0 +1 @@
+CONFIG_HOSTFS=y
diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 2911b5241583..83d565569512 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -10,6 +10,7 @@
 #define _GNU_SOURCE
 #include <fcntl.h>
 #include <linux/landlock.h>
+#include <linux/magic.h>
 #include <sched.h>
 #include <stdio.h>
 #include <string.h>
@@ -19,6 +20,7 @@
 #include <sys/sendfile.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
+#include <sys/vfs.h>
 #include <unistd.h>
 
 #include "common.h"
@@ -135,6 +137,19 @@ static bool supports_filesystem(const char *const filesystem)
 	return res;
 }
 
+static bool cwd_matches_fs(unsigned int fs_magic)
+{
+	struct statfs statfs_buf;
+
+	if (!fs_magic)
+		return true;
+
+	if (statfs(".", &statfs_buf))
+		return true;
+
+	return statfs_buf.f_type == fs_magic;
+}
+
 static void mkdir_parents(struct __test_metadata *const _metadata,
 			  const char *const path)
 {
@@ -4500,6 +4515,7 @@ FIXTURE_VARIANT(layout3_fs)
 {
 	const struct mnt_opt mnt;
 	const char *const file_path;
+	unsigned int cwd_fs_magic;
 };
 
 /* clang-format off */
@@ -4538,13 +4554,23 @@ FIXTURE_VARIANT_ADD(layout3_fs, sysfs) {
 	.file_path = TMP_DIR "/kernel/notes",
 };
 
+FIXTURE_VARIANT_ADD(layout3_fs, hostfs) {
+	.mnt = {
+		.source = TMP_DIR,
+		.flags = MS_BIND,
+	},
+	.file_path = TMP_DIR "/dir/file",
+	.cwd_fs_magic = HOSTFS_SUPER_MAGIC,
+};
+
 FIXTURE_SETUP(layout3_fs)
 {
 	struct stat statbuf;
 	const char *slash;
 	size_t dir_len;
 
-	if (!supports_filesystem(variant->mnt.type)) {
+	if (!supports_filesystem(variant->mnt.type) ||
+	    !cwd_matches_fs(variant->cwd_fs_magic)) {
 		self->skip_test = true;
 		SKIP(return, "this filesystem is not supported (setup)");
 	}
-- 
2.41.0

