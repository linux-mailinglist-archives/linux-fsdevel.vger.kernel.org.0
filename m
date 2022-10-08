Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F65F84C3
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 12:10:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiJHKK2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 06:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiJHKJs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 06:09:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941F13E29;
        Sat,  8 Oct 2022 03:09:47 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id d26so8813928eje.10;
        Sat, 08 Oct 2022 03:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TcJinYSqP/P8butZE17/ltEboJUG5yfSi0K+q7kH9Mo=;
        b=Gc586E66aRWub1D3GwjfjWcSbm8C7Fv6Czzbp8ZoJDsl7KnN3ogn/ANN43P8WrB3nm
         dJLheHypnf0RQgEU2IrxDcGETBFMabcMZHI/a7APdds+J13h8HGVvWVQaf+AyeduBwu3
         Ra+1RhnqlnD3kzpzJmtOd27xMqxL0pvJfWQoHQwLczsb13htB0t4lZWrZXbX5fGOxh92
         lb9tQUvUnS0ZVRHYWdZlTGO/FLlc0Jd7llN0YSusWaXPwUzPfUBhUIhOrM7y2dclx09Z
         IwNHjgjGlbsl244ucmW9F2OLUN4UQQaMNeEv3F5Wvoy3BNGtf5/sZRLNNNedzhd3iMyL
         ea1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TcJinYSqP/P8butZE17/ltEboJUG5yfSi0K+q7kH9Mo=;
        b=J+de1bTcOZpdNyE/cyT0927GFcmatSNUXLbTzmML5GwCB2aSHIxE/TwjGHQW6Dvj6W
         SUuYVG90+lnVoELbQNoYcv69r5GZQNVPnj+HpB64XUDFKUtG7SHtjCSFBQVA1juvs7VV
         zRdIGG7ezadgWf6BBHk1WCHhh4Dmrk/B9FPrJo6oizrdR9B05j5qCRPe/olvD2XYIaUL
         DBQTpDIp1yBz7JWPIVBLuhY04kXZPF+Wuqt/LGkuwOEvOURCPF9r7C7T25aJH1G4JNby
         3Y32moMIqGH5fJABlxO/aERU1rMvDtcZB03ZWSq3RmQUdJsHUgxNGtybiWqp9+35XTRp
         OHcQ==
X-Gm-Message-State: ACrzQf2YsR5pyf643DUAGjCplfQaLOEnU1iIw177Fkg031u9VnZ2AnYR
        ju5KrpEXwiHpAJHuiu2yg/TTDnH3AVY=
X-Google-Smtp-Source: AMsMyM5yPT8Zx2JGwZkZovchKDm8Dvn9BbIOJwiEmbKsnfbHrEWSIuZQMhPo/JaIlJr8cFfN3dlxuw==
X-Received: by 2002:a17:907:1691:b0:78d:4051:9429 with SMTP id hc17-20020a170907169100b0078d40519429mr7505157ejc.721.1665223786304;
        Sat, 08 Oct 2022 03:09:46 -0700 (PDT)
Received: from nuc.i.gnoack.org ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id e9-20020aa7d7c9000000b00452878cba5bsm3092012eds.97.2022.10.08.03.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 03:09:45 -0700 (PDT)
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
Subject: [PATCH v9 09/11] selftests/landlock: Test ftruncate on FDs created by memfd_create(2)
Date:   Sat,  8 Oct 2022 12:09:35 +0200
Message-Id: <20221008100935.73706-10-gnoack3000@gmail.com>
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

