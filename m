Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D4172CF16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 21:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbjFLTOs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 15:14:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbjFLTOo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:14:44 -0400
Received: from smtp-42a8.mail.infomaniak.ch (smtp-42a8.mail.infomaniak.ch [IPv6:2001:1600:4:17::42a8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E083E4E;
        Mon, 12 Jun 2023 12:14:43 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qg1b53tgczMqF05;
        Mon, 12 Jun 2023 19:14:41 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qg1b46W9qzMrmKM;
        Mon, 12 Jun 2023 21:14:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686597281;
        bh=yM3ocDBO/Eg5sd6nYID1ic7x3D8b2b9Uxb3jAajmQN8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CcgqZnvDpDUbp/ClAitSSlsAmm3yM036dkWaRmUYjSfBKEModzzz2wGVVR2zlIp1T
         PglReVajuDfG0mH04oJ2R/1W52+f+VcNGYQl/T3wR489vk+Zu0rF1/A0aLVeu3bVbV
         xnzQ7SEbVlBcZE5n8loEuVcJrJbEupWyi0PPaz9Q=
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
Subject: [PATCH v2 3/6] selftests/landlock: Add supports_filesystem() helper
Date:   Mon, 12 Jun 2023 21:14:27 +0200
Message-ID: <20230612191430.339153-4-mic@digikod.net>
In-Reply-To: <20230612191430.339153-1-mic@digikod.net>
References: <20230612191430.339153-1-mic@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Replace supports_overlayfs() with supports_filesystem() to be able to
check several filesystems.  This will be useful in a following commit.

Only check for overlay filesystem once in the setup step, and then rely
on self->skip_test.

Cc: Guenter Roeck <groeck@chromium.org>
Cc: Jeff Xu <jeffxu@google.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++--------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 0438651f61d2..c1e655fc06bb 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -107,8 +107,10 @@ static bool fgrep(FILE *const inf, const char *const str)
 	return false;
 }
 
-static bool supports_overlayfs(void)
+static bool supports_filesystem(const char *const filesystem)
 {
+	char str[32];
+	int len;
 	bool res;
 	FILE *const inf = fopen("/proc/filesystems", "r");
 
@@ -119,7 +121,12 @@ static bool supports_overlayfs(void)
 	if (!inf)
 		return true;
 
-	res = fgrep(inf, "nodev\toverlay\n");
+	len = snprintf(str, sizeof(str), "nodev\t%s\n", filesystem);
+	if (len >= sizeof(str))
+		/* Ignores too-long filesystem names. */
+		return true;
+
+	res = fgrep(inf, str);
 	fclose(inf);
 	return res;
 }
@@ -4044,14 +4051,17 @@ static const char (*merge_sub_files[])[] = {
  *         └── work
  */
 
-/* clang-format off */
-FIXTURE(layout2_overlay) {};
-/* clang-format on */
+FIXTURE(layout2_overlay)
+{
+	bool skip_test;
+};
 
 FIXTURE_SETUP(layout2_overlay)
 {
-	if (!supports_overlayfs())
-		SKIP(return, "overlayfs is not supported");
+	if (!supports_filesystem("overlay")) {
+		self->skip_test = true;
+		SKIP(return, "overlayfs is not supported (setup)");
+	}
 
 	prepare_layout(_metadata);
 
@@ -4089,8 +4099,8 @@ FIXTURE_SETUP(layout2_overlay)
 
 FIXTURE_TEARDOWN(layout2_overlay)
 {
-	if (!supports_overlayfs())
-		SKIP(return, "overlayfs is not supported");
+	if (self->skip_test)
+		SKIP(return, "overlayfs is not supported (teardown)");
 
 	EXPECT_EQ(0, remove_path(lower_do1_fl3));
 	EXPECT_EQ(0, remove_path(lower_dl1_fl2));
@@ -4123,8 +4133,8 @@ FIXTURE_TEARDOWN(layout2_overlay)
 
 TEST_F_FORK(layout2_overlay, no_restriction)
 {
-	if (!supports_overlayfs())
-		SKIP(return, "overlayfs is not supported");
+	if (self->skip_test)
+		SKIP(return, "overlayfs is not supported (test)");
 
 	ASSERT_EQ(0, test_open(lower_fl1, O_RDONLY));
 	ASSERT_EQ(0, test_open(lower_dl1, O_RDONLY));
@@ -4289,8 +4299,8 @@ TEST_F_FORK(layout2_overlay, same_content_different_file)
 	size_t i;
 	const char *path_entry;
 
-	if (!supports_overlayfs())
-		SKIP(return, "overlayfs is not supported");
+	if (self->skip_test)
+		SKIP(return, "overlayfs is not supported (test)");
 
 	/* Sets rules on base directories (i.e. outside overlay scope). */
 	ruleset_fd = create_ruleset(_metadata, ACCESS_RW, layer1_base);
-- 
2.41.0

