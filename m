Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1102D5F0F87
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Sep 2022 18:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbiI3QC6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Sep 2022 12:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbiI3QCS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Sep 2022 12:02:18 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 054751B34B9;
        Fri, 30 Sep 2022 09:02:14 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id a13so6606044edj.0;
        Fri, 30 Sep 2022 09:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7mkbYIT0lyMbYQ60i8bXJR6CMNT1pJkoeHZZ5DPZ4IM=;
        b=OaP+7KFzTlEnJt+iZNALX3EGzH6HiqJvDEEO8jC2klp8ppaRpH+kBqLgnAu2RkNsI7
         Bg8BELHbdgH1fO0kkr1/Sw7R+A+EmyJgYfB5ihvi1gRr7+lNhwLCabcbnU933I/DvVYq
         aaa4x2VqKqlAcnKnn30HBFWjAbKXQbICpXOOLyoAB5e7oebeHCfzQP7QZnxEzyvB4tfX
         sKk0HqRxkzeBzHBDe5dQKQSSo5isMFHd9TC4fvoBxoC8MrkhCrQ9lEQKAN3bwdqKvOkV
         MRJ53mQT4V7Sd678ksvdBgAQpXOsLYdbp+M2BXbGzCGG+kUlnhcL5MeeOW+4WDFCKffD
         geAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7mkbYIT0lyMbYQ60i8bXJR6CMNT1pJkoeHZZ5DPZ4IM=;
        b=IYIDVSimY+os7f8X2UmQVTlN51YwI3EqtTOsZSgD98clWxruG0UeqcjfmbLwR5V3L+
         5LrDf1mxIXVxpK2ZhaH2IA28swAicDgVTCaobCOK8RNWd4k0H3wq/js9bG2reNBEo4vK
         Gf2nwtAb9pIDKxQZeN66fgqbh7Iqnpbm2N6JCb9nAWsrUVmZeQNXzQUc/660RGpYFL3V
         3i21+9d6dqNMc9Cot5dtbjUaQcig+V2ls7ZTyvPwRYgnN9WEu2r/lZQy3SBhzAx4OuK9
         g90WKjjagNz+tvuTfyNUvw44i/AmCz8au7bFES52F5XYwZXf14OYBoRgyWf7z9e6LvX2
         bSGw==
X-Gm-Message-State: ACrzQf2CssB5fEhmT+P4x3x+c/YHhnJmvQLeP+jajA6aA+BzbOrFWtWd
        2X9PzZwhSd1Y86S+HGGD4HKEC9/YnQI=
X-Google-Smtp-Source: AMsMyM7wWy7UXrzkHV/brcq/gODLW68ZQaRz2XmrOK/WFpJ+QUarqJTevlqyAk99KQ9oBM2tjbfpgQ==
X-Received: by 2002:a50:cdd8:0:b0:457:269a:decf with SMTP id h24-20020a50cdd8000000b00457269adecfmr8394285edj.359.1664553733081;
        Fri, 30 Sep 2022 09:02:13 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id f18-20020a05640214d200b004588ef795easm927583edx.34.2022.09.30.09.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 09:02:12 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v7 4/7] selftests/landlock: Test open() and ftruncate() in multiple scenarios
Date:   Fri, 30 Sep 2022 18:01:41 +0200
Message-Id: <20220930160144.141504-5-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220930160144.141504-1-gnoack3000@gmail.com>
References: <20220930160144.141504-1-gnoack3000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This test uses multiple fixture variants to exercise a broader set of
scnenarios.

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 96 ++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 718543fd3dfc..308f6f36e8c0 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3445,6 +3445,102 @@ TEST_F_FORK(layout1, ftruncate)
 	ASSERT_EQ(0, close(fd_layer3));
 }
 
+/* clang-format off */
+FIXTURE(ftruncate) {};
+/* clang-format on */
+
+FIXTURE_SETUP(ftruncate)
+{
+	prepare_layout(_metadata);
+	create_file(_metadata, file1_s1d1);
+}
+
+FIXTURE_TEARDOWN(ftruncate)
+{
+	EXPECT_EQ(0, remove_path(file1_s1d1));
+	cleanup_layout(_metadata);
+}
+
+FIXTURE_VARIANT(ftruncate)
+{
+	const __u64 handled;
+	const __u64 permitted;
+	const int expected_open_result;
+	const int expected_ftruncate_result;
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ftruncate, w_w) {
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.expected_open_result = 0,
+	.expected_ftruncate_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ftruncate, t_t) {
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_TRUNCATE,
+	.permitted = LANDLOCK_ACCESS_FS_TRUNCATE,
+	.expected_open_result = 0,
+	.expected_ftruncate_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ftruncate, wt_w) {
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
+	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE,
+	.expected_open_result = 0,
+	.expected_ftruncate_result = EACCES,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ftruncate, wt_wt) {
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
+	.permitted = LANDLOCK_ACCESS_FS_WRITE_FILE |
+		     LANDLOCK_ACCESS_FS_TRUNCATE,
+	.expected_open_result = 0,
+	.expected_ftruncate_result = 0,
+};
+
+/* clang-format off */
+FIXTURE_VARIANT_ADD(ftruncate, wt_t) {
+	/* clang-format on */
+	.handled = LANDLOCK_ACCESS_FS_WRITE_FILE | LANDLOCK_ACCESS_FS_TRUNCATE,
+	.permitted = LANDLOCK_ACCESS_FS_TRUNCATE,
+	.expected_open_result = EACCES,
+};
+
+TEST_F_FORK(ftruncate, open_and_ftruncate)
+{
+	const char *const path = file1_s1d1;
+	const struct rule rules[] = {
+		{
+			.path = path,
+			.access = variant->permitted,
+		},
+		{},
+	};
+	int fd, ruleset_fd;
+
+	/* Enable Landlock. */
+	ruleset_fd = create_ruleset(_metadata, variant->handled, rules);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd = open(path, O_WRONLY);
+	EXPECT_EQ(variant->expected_open_result, (fd < 0 ? errno : 0));
+	if (fd >= 0) {
+		EXPECT_EQ(variant->expected_ftruncate_result,
+			  test_ftruncate(fd));
+		ASSERT_EQ(0, close(fd));
+	}
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.37.3

