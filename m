Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E11A360324B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiJRSXL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiJRSWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:52 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D682D17;
        Tue, 18 Oct 2022 11:22:35 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id a67so21724122edf.12;
        Tue, 18 Oct 2022 11:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7EZyBx7bCF7vqPgVGnwZCbGudLlBsaHfU69mkM4HyE=;
        b=EFgGOkHS5IKWaZDq1hhu4EfwcDUXmoGHBUJEgdApYbXePgsaRf7dWOlrQ31zLB/29X
         +FPWRzOsX0bQc0Wjdh9aBc2lqaPEgJYxQV1QU5/zc3dwbU9vEREOHQX5ZhKZrtEFBZLf
         8+0kDS+ofrC00JYtiJg6c+nMDf6wA/WuNUZzw0cQkAyWSrnEqoz9SsE/+X39fmJ2O6rt
         K9Vb5gYLRksgZZFkdr6D0XnVDMMt8x4uoOgPIp+xke9uFRYm73Uem6+AvYQ+/DrOTgfQ
         ud0gUnYhwvCLQu3dbUBj+1bNl7idDMm/9STqtVTCkL6U1XweWyxEtjzHtxlI7rRvNYdR
         rFpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7EZyBx7bCF7vqPgVGnwZCbGudLlBsaHfU69mkM4HyE=;
        b=N86QoADHPBqxtehxK4h7CoiJKWBJeaqmxyfjmoUdqTdKTrslY6DJzp2wZNq0pDBfxH
         MqZqunjtHT1BR4/VLwv2HVgAieDvAOREcnl2b/mE5xinavmW1o/mIr8EfKWQNJn1jnVP
         Jd9OBg7btggtRSNfx4+XG3QPtpgbXFeXZn5G9G9jgR+sDNtQAvIT11VHDKOLdC1XgG4I
         SKjGT0CtvspwvzykFVKClsWiUTMzU2/dM4MFkVMi2LGYtw6prdnwMCR7s4BFlyp8A2NH
         RKWAXrZwHtTJMcLqIReJuxwhzTH0xg9rSDgZS0gEGf7begkCodAwOXLzyaftmXQ6pXgc
         LhRg==
X-Gm-Message-State: ACrzQf3R86QDZzCQV7gUHXvpJpXXe2NRsXzzh3b7dZOCt7j6d8xT2hnN
        vk6+n3ptKp33tw4BOa1nK6BBHHzhQqE=
X-Google-Smtp-Source: AMsMyM5gIxzIgujRafkmWOhc9gf4BuqEf2y3KAewCwwvaq7mTWI9a9hYTPvMGmSlZAiywMu/bm0AYA==
X-Received: by 2002:a05:6402:34c7:b0:45c:c02c:e256 with SMTP id w7-20020a05640234c700b0045cc02ce256mr3973128edc.198.1666117354031;
        Tue, 18 Oct 2022 11:22:34 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:33 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Nathan Chancellor <nathan@kernel.org>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v10 06/11] selftests/landlock: Test open() and ftruncate() in multiple scenarios
Date:   Tue, 18 Oct 2022 20:22:11 +0200
Message-Id: <20221018182216.301684-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221018182216.301684-1-gnoack3000@gmail.com>
References: <20221018182216.301684-1-gnoack3000@gmail.com>
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
2.38.0

