Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0C9603250
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 20:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiJRSXP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 14:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229963AbiJRSWx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:22:53 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A228285D;
        Tue, 18 Oct 2022 11:22:37 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fy4so34325045ejc.5;
        Tue, 18 Oct 2022 11:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcJinYSqP/P8butZE17/ltEboJUG5yfSi0K+q7kH9Mo=;
        b=C/BrBsO/fjmYpEtPhev7MOzB19mSNdrIy2k0A0Upgmqcq2RPMYEpWE0oaQqaF80V+v
         oGt2OZmIBmPOsFAbSuT2k81SlVlQH+ruIb9EGHWVWf2B8wOVfHA4Bs7VJFSQgA2ZKvEQ
         UyYzO8ZvjA4KPYA3Nlt7biDfdpLxVnU3UMW4a5LVbbE2yC02rsrFJ/NgOylfeRggxg5I
         PEZ6dFGWus/GEtqZlw3wiuy2TI2DpJTCFpEFsGBo30mCFub4Tzl/KYzIIGN0pSJqJtdV
         clQssrqRJyf/Ub1LXNVn8bJvRO1sRYVzFJG5xJOQPQY/oOC8V6j5uTHBv1a49vNHNAA4
         p+cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcJinYSqP/P8butZE17/ltEboJUG5yfSi0K+q7kH9Mo=;
        b=RvWX/rK7+s4lv7OGwxyOGaji7/VFUY71MFGLDYPoFFclvUDmbd7NeTumtK+2+DAH4a
         Q7H76q7LU33EuKZUAD2z/DOsx5OZJf7EEOozcp8x4KvCtylfbKdKeCPcp+8jYxgetGxS
         z/l90RANuHaMkYDCQKA+loQWYb9BrlYql6vyXMHEYqRQ9xY1ZO8vlLRoPLgcRUhTCo84
         uShipNpEfHVNlDdW3o9T3TK1O6lPiNUeqv1VtBrmm72pHM6Qt7khP9sB+BwEf5AjJuw8
         eXfdNvhvWnRhUFhlbhvZm1VHsHE6usxUHB/7bHlybSida/4bO25ohFh2R7ffn7C5Rzn9
         fAQA==
X-Gm-Message-State: ACrzQf03mfrxGTe1yN0/L+eePrEUZFWqj49lXQbfH9zySlidqDygYzPG
        bnOEiXRyoJt8U6FzY1OFe4e1dLuxLfQ=
X-Google-Smtp-Source: AMsMyM4a7MYzCA6gtauY4jAJgKFn0FbIHpNjVzv6uPJZ8QQOtLRtUGZzVuCktsxw+IcepgObczuy4w==
X-Received: by 2002:a17:907:6eac:b0:78d:ce9c:3761 with SMTP id sh44-20020a1709076eac00b0078dce9c3761mr3475496ejc.738.1666117356268;
        Tue, 18 Oct 2022 11:22:36 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id i18-20020a0564020f1200b00458a03203b1sm9358395eda.31.2022.10.18.11.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 11:22:35 -0700 (PDT)
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
Subject: [PATCH v10 09/11] selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
Date:   Tue, 18 Oct 2022 20:22:14 +0200
Message-Id: <20221018182216.301684-10-gnoack3000@gmail.com>
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

All file descriptors that are truncatable need to have the Landlock
access rights set correctly on the file's Landlock security blob. This
is also the case for files that are opened by other means than
open(2).

Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 tools/testing/selftests/landlock/fs_test.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index f8aae01a2409..d5dab986f612 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3603,6 +3603,22 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_different_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
 
+TEST(memfd_ftruncate)
+{
+	int fd;
+
+	fd = memfd_create("name", MFD_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * Checks that ftruncate is permitted on file descriptors that are
+	 * created in ways other than open(2).
+	 */
+	EXPECT_EQ(0, test_ftruncate(fd));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(layout1_bind) {};
 /* clang-format on */
-- 
2.38.0

