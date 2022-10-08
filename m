Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A105F84BD
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 12:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJHKKC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 06:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJHKJr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:09:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92517E030;
        Sat,  8 Oct 2022 03:09:45 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id o21so15857221ejm.11;
        Sat, 08 Oct 2022 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U7EZyBx7bCF7vqPgVGnwZCbGudLlBsaHfU69mkM4HyE=;
        b=UlTRsMsoil36bhQi0nZxlF9l6pAittSuiEgua2XcGOb2T0PONZEUt4NSM+be88IZNY
         J9c1VyL5HAqj30Mk5BTZnoi8fsFOtdslYxuU94K9MSI1X1CXMWNxeRjc36hhhHJ9Oabg
         0HXQmI4JJpyzYfo2pE75HwkL1zLoRVcQo50hyYA8+SFARwaY/RpcqUOoaeek0bTA+ESL
         F8loHfqCJI5NWTnDGmCM8/H2Lp/s1p1EfYUP2Njq0eBEa+bAagkq051KZJ+/Z/sP+8xM
         lGjE3GgcxDjGEFuJlD97rI+4Itr2LUKVF16CFztUJuO2b2XiuWd3Rf0iBgEvDEdrWWMn
         HbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U7EZyBx7bCF7vqPgVGnwZCbGudLlBsaHfU69mkM4HyE=;
        b=wPF/1WGNxDkZz05VAkk1xZfY1fmXX4BG5qvIDbjCkwsW6NoKjmaQ8CrP2uUZQoOYFY
         2zZY57x+aqcx3YxmesEwFTqUGYjUoiyaa9koKn0T+38fmUgcba3PAPiY9SjqgdMs1dfn
         GMs7UJI8rQ0WkZS0a9bHTNXDxOtm7TfR4Ta8l1brCfEkFtz/lEcDW+8ICkihDjmEM9BU
         kjceiZP2ctV5LWQMi9Lc3bhyKPDX/hmSJ5oFTbH6iWxQf/Ya3zXQRuSYmH/G4zQC+QUD
         osZrOYHWU7ctaZ0zWoXFoR0/Fok5ybfPvkcMl92LF/eC25XwBVZZPUvGWgf9qUj3Chbm
         bm+Q==
X-Gm-Message-State: ACrzQf2KJqrwBdRf8yx8TiNw2RJwZ96IKveazkE88PZJYICLS1YZllkG
        go3wWKN2AdfEOTWIaO2skZBh8BF0iHU=
X-Google-Smtp-Source: AMsMyM6QuNag39owg0zIYZ37JHWtEvIZqkhRUov69252VCziGYJcEBYuNDgNHRQyAK5G0/XRKWxBCA==
X-Received: by 2002:a17:907:96a5:b0:78d:9e77:f967 with SMTP id hd37-20020a17090796a500b0078d9e77f967mr246284ejc.702.1665223784189;
        Sat, 08 Oct 2022 03:09:44 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm3092012eds.97.2022.10.08.03.09.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 03:09:43 -0700 (PDT)
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
Subject: [PATCH v9 06/11] selftests/landlock: Test open() and ftruncate() in multiple scenarios
Date:   Sat,  8 Oct 2022 12:09:32 +0200
Message-Id: <20221008100935.73706-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221008100935.73706-1-gnoack3000@gmail.com>
References: <20221008100935.73706-1-gnoack3000@gmail.com>
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

