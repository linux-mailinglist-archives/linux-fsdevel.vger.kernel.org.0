Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EB877BEF1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Aug 2023 19:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHNR24 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Aug 2023 13:28:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjHNR2v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Aug 2023 13:28:51 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 550C2133
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:50 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id a640c23a62f3a-98e40d91fdfso267914566b.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Aug 2023 10:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692034129; x=1692638929;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3y+Q4IgcXaw8U/O/rkXVJ7BYtEcI6PYv5gdexTlLSGg=;
        b=76LNTaNIah1o+e6XeFaLssd4uycHXfK97IQH6AHGjHtLoh6b9kde4Ii6a4C8W8la3f
         8+iH3Yy0Hg9ym+ynWn2v63PPJb/Ny+icFkUFYHjL9gtSxEmXzEhztxIoLUfKtywHmUD8
         VnU384WXTthdvxw4yfv5w/VfMAokctotuBPvp0a3p6axWTiv1+QP6rTMF4TU6UeUYp1H
         6tsrJwYyQRFFiH3GCLGJOTOLvSghmDSsyaOQCEBKx7uBb8rC1kAZv6SrsmmxnyVYsUAc
         /7+YEO8WlxlmuHdt0TvV9vz8wEpIymFIwroe5nWKI4afWsnKGyWDRDifb/ZEWAGJsZ1C
         Cx+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692034129; x=1692638929;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3y+Q4IgcXaw8U/O/rkXVJ7BYtEcI6PYv5gdexTlLSGg=;
        b=EyfgQDqpa6qq4Lr8t7ciImPdmFjzbB0h09FglO4hOZi0oblwez5Fx5Bz+ZW35JGKOf
         OZwJO+xN2aeh4W7dXonRa4fRL5bZjnnmM8RmRvegdsdqeqdgeMaBgOfJY9UN4hIk0SUY
         5bVeHQCoRrILsE2wSZTlWN1N2wmC2RZQvYg6MLUhWvUjYtuLLnJNx9fOQ992/deBH28u
         sefsa50eeTpHKgv9mp+qBVNz8jt2Z6SlOu493EP463ox7X71PkAThdEOMJxLTjzW5hD4
         4y4sVgYXLkW+6Gq0gIR8kiQypE2JQBHPBYwsvWD3cj8YZSt+0R09hY/BvfOovf7dMOXB
         2KmA==
X-Gm-Message-State: AOJu0YyfyHPblqJUhlT9KhWi4H3kHHwncSO7xPpfBn6VO/5f3SdByIuZ
        6WM3N8GDikT0bqsxxapgDtQnw5ueNh4=
X-Google-Smtp-Source: AGHT+IFW4XpqyjomRR9EPf5Gq+z2WJPB0LttavYHYi6hcS3R6CAGGgvghrTtGhKZZUe5XQ84aS0BgC2gBSo=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9ca9:bbb1:765a:e929])
 (user=gnoack job=sendgmr) by 2002:a17:906:6b4e:b0:99b:ed53:6574 with SMTP id
 o14-20020a1709066b4e00b0099bed536574mr48745ejs.14.1692034129000; Mon, 14 Aug
 2023 10:28:49 -0700 (PDT)
Date:   Mon, 14 Aug 2023 19:28:14 +0200
In-Reply-To: <20230814172816.3907299-1-gnoack@google.com>
Message-Id: <20230814172816.3907299-4-gnoack@google.com>
Mime-Version: 1.0
References: <20230814172816.3907299-1-gnoack@google.com>
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Subject: [PATCH v3 3/5] selftests/landlock: Test ioctl with memfds
From:   "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To:     linux-security-module@vger.kernel.org,
        "=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc:     Jeff Xu <jeffxu@google.com>,
        Jorge Lucangeli Obes <jorgelo@chromium.org>,
        Allen Webb <allenwebb@google.com>,
        Dmitry Torokhov <dtor@google.com>,
        Paul Moore <paul@paul-moore.com>,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
        Matt Bobrowski <repnop@google.com>,
        linux-fsdevel@vger.kernel.org,
        "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Because the ioctl right is associated with the opened file,
we expect that it will work with files which are opened by means
other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 50 +++++++++++++++-------
 1 file changed, 34 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 456bd681091d..4eb989d5ff39 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3716,22 +3716,6 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differe=
nt_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
-TEST(memfd_ftruncate)
-{
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
-
-	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
-	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
-
-	ASSERT_EQ(0, close(fd));
-}
-
 /* Invokes the FIOQSIZE ioctl(2) and returns its errno or 0. */
 static int test_fioqsize_ioctl(int fd)
 {
@@ -3742,6 +3726,40 @@ static int test_fioqsize_ioctl(int fd)
 	return 0;
 }
=20
+TEST(memfd_ftruncate_and_ioctl)
+{
+	struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
+
+	/*
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
+	 */
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
+
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fioqsize_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd)
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
+}
+
 /*
  * Attempt ioctls on regular files, with file descriptors opened before an=
d
  * after landlocking.
--=20
2.41.0.694.ge786442a9b-goog

