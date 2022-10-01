Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE365F1D57
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Oct 2022 17:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbiJAPu2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 1 Oct 2022 11:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiJAPts (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 1 Oct 2022 11:49:48 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06729D13E;
        Sat,  1 Oct 2022 08:49:40 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id m3so9466172eda.12;
        Sat, 01 Oct 2022 08:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=7mkbYIT0lyMbYQ60i8bXJR6CMNT1pJkoeHZZ5DPZ4IM=;
        b=m1UvZG3gNS747cKp/1WkBIKlxN+Mke29qdMpgHNIKxbbZBJfZTlI5WihDAvlzTrltc
         QjGNJ5B/zdcdo1RWUJFnb1gd8gZujAyk0/ASRTjr0DoQ74y0KpAiMzmO2+ht9v1n56hM
         nKwn1K+EGiO+6Z31qWDRdooyR2U2DvAqw8Jd82WZNUb7yFl7rFpa7oeEMppo/zqJEeEQ
         hVpp2lsRMpl6C/MlN4HOvlqrBtwvlFYw8T5doNo0yjWwaY2+bQuwjhXFwyMDmrWj+FOY
         eZkcEA/wPi4/XQo9Px0ETeMj8XzTOKkQy8OTW5CS2tIKw6vFQ9r/BOZpm3N0Ze/31zIt
         5vpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=7mkbYIT0lyMbYQ60i8bXJR6CMNT1pJkoeHZZ5DPZ4IM=;
        b=2ixDltnCs6RBKV0VaSI0v6zvG4s/oivk5P4Qhj29cq03mIR4HQpx1BLLmX76fyXqRk
         8DdORuV9Z4fUVmzLlAgq34/WQXn83hC4xDCnweWxYIAHBc1ZOrvOWukIZI65Vx5B0+v2
         KwfA2wxuzH/0a81T96O0lhgdudTdi7xrE21yhA7pTrIiZVTUXvXXErMmVmimicUFsvKE
         jN2tAHjjdbRcXuvSZnYBmQABYvpb1M3Lcr47BUqf0IL34lbbb+Qfc6daKUi/aen9cRjQ
         A/gR1flFWvOi5inQaDA+Yi4yzLsylAQb3M5xHxsTARGmfpgxDNmeSrtWfzF3EhiSanSu
         fcFw==
X-Gm-Message-State: ACrzQf3oi2K8KNkLh50P19uy26vd5Qps8c3qqzb6D/qIPvmvgiXWfFwl
        HhgQteH0E2WoaAFDPOFrtHmAUD9Nt0s=
X-Google-Smtp-Source: AMsMyM7QFjAREh0CarflFCNUBOcnfEbtT2/qAq27zkWW5vyI3tjfzpw51o5DNa9Kl0isrMI+63r3SQ==
X-Received: by 2002:a05:6402:847:b0:453:943b:bf4 with SMTP id b7-20020a056402084700b00453943b0bf4mr12026809edz.301.1664639372516;
        Sat, 01 Oct 2022 08:49:32 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id d26-20020aa7d69a000000b00458cc5f802asm617151edr.73.2022.10.01.08.49.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Oct 2022 08:49:31 -0700 (PDT)
From:   =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
To:     linux-security-module@vger.kernel.org
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH v8 6/9] selftests/landlock: Test open() and ftruncate() in multiple scenarios
Date:   Sat,  1 Oct 2022 17:49:05 +0200
Message-Id: <20221001154908.49665-7-gnoack3000@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221001154908.49665-1-gnoack3000@gmail.com>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
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

