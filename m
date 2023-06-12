Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD11A72CF21
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238096AbjFLTPI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 15:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237961AbjFLTOp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:14:45 -0400
Received: from smtp-8fac.mail.infomaniak.ch (smtp-8fac.mail.infomaniak.ch [IPv6:2001:1600:4:17::8fac])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70679E53
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jun 2023 12:14:43 -0700 (PDT)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Qg1b4394NzMqDSp;
        Mon, 12 Jun 2023 19:14:40 +0000 (UTC)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4Qg1b372g6z1WPQ;
        Mon, 12 Jun 2023 21:14:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1686597280;
        bh=P+NG44GeB352YmZfkyCH+rwl59d+cokXdydyw6QtJEc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBc1YY1v9bK7iX4/hxv685DlcNbdqJldO+DGaUT0J0IpHI0KzasE86xVEIpyqkc/S
         zMVDMh/u8VdUL1DV9lVtv57ERDAFJ8R0MvhcyiJiXErJNO7XyRaWttBZxv4m2nxR0K
         B2eoZZRMegrogXuBEw6gDZXiyFf9bzyxayW7BBy4=
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
Subject: [PATCH v2 2/6] selftests/landlock: Don't create useless file layouts
Date:   Mon, 12 Jun 2023 21:14:26 +0200
Message-ID: <20230612191430.339153-3-mic@digikod.net>
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

Add and use a layout0 test fixture to not populate the tmpfs filesystem
if it is not required for tests: unknown_access_rights, proc_nsfs,
unpriv and max_layers.

This doesn't change these tests but it speeds up their setup and makes
them less prone to error.  This prepare the ground for a next commit.

Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 26 +++++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index b6c4be3faf7a..0438651f61d2 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -231,6 +231,20 @@ static void cleanup_layout(struct __test_metadata *const _metadata)
 	EXPECT_EQ(0, remove_path(TMP_DIR));
 }
 
+/* clang-format off */
+FIXTURE(layout0) {};
+/* clang-format on */
+
+FIXTURE_SETUP(layout0)
+{
+	prepare_layout(_metadata);
+}
+
+FIXTURE_TEARDOWN(layout0)
+{
+	cleanup_layout(_metadata);
+}
+
 static void create_layout1(struct __test_metadata *const _metadata)
 {
 	create_file(_metadata, file1_s1d1);
@@ -510,7 +524,7 @@ TEST_F_FORK(layout1, file_and_dir_access_rights)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
-TEST_F_FORK(layout1, unknown_access_rights)
+TEST_F_FORK(layout0, unknown_access_rights)
 {
 	__u64 access_mask;
 
@@ -608,7 +622,7 @@ static void enforce_ruleset(struct __test_metadata *const _metadata,
 	}
 }
 
-TEST_F_FORK(layout1, proc_nsfs)
+TEST_F_FORK(layout0, proc_nsfs)
 {
 	const struct rule rules[] = {
 		{
@@ -657,11 +671,11 @@ TEST_F_FORK(layout1, proc_nsfs)
 	ASSERT_EQ(0, close(path_beneath.parent_fd));
 }
 
-TEST_F_FORK(layout1, unpriv)
+TEST_F_FORK(layout0, unpriv)
 {
 	const struct rule rules[] = {
 		{
-			.path = dir_s1d2,
+			.path = TMP_DIR,
 			.access = ACCESS_RO,
 		},
 		{},
@@ -1301,12 +1315,12 @@ TEST_F_FORK(layout1, inherit_superset)
 	ASSERT_EQ(0, test_open(file1_s1d3, O_RDONLY));
 }
 
-TEST_F_FORK(layout1, max_layers)
+TEST_F_FORK(layout0, max_layers)
 {
 	int i, err;
 	const struct rule rules[] = {
 		{
-			.path = dir_s1d2,
+			.path = TMP_DIR,
 			.access = ACCESS_RO,
 		},
 		{},
-- 
2.41.0

