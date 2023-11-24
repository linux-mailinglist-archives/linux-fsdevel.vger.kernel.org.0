Return-Path: <linux-fsdevel+bounces-3758-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9877F7A66
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02484B2151D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Nov 2023 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F89E39FE9;
	Fri, 24 Nov 2023 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TS8E9fdM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738C619A7
	for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ce4e0e2bdso1509744276.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 24 Nov 2023 09:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700847046; x=1701451846; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dqKMyUbOjp1pzrjHSa8fjOBv5M/NXQQHG22g8xcIt5c=;
        b=TS8E9fdMzLXFpiKNMTqANu2jHQ3Eb+Fyhz3lUr/w8JaiPIiSAOimkzEqOGzblO3P2u
         xbkDsG4ycG+nHb+YcOy7P3zD7IgMaPe7FNkI7s74YZV9SxFU+IXVI3xirtpgy7ycJGEc
         fF1Ox+HGlJKTKM2RHlxkTDVeKfBWXLr3ICvG9pGtLerpJZCYF6QfYtZQsxrzDWkjPnLI
         YoMsS7rkKPJzzqSNslkvHm7VOnCaf5b7y1Eds4ks/na5+8V+N7ld1AZNRfXgZx2yUZuH
         e9BYK80NUNGAjcQIdfryDEAYLILE1CIhX2mKtr1N3mPEq7O3mg7lllYygRiVuFNA38HS
         nvcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700847046; x=1701451846;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dqKMyUbOjp1pzrjHSa8fjOBv5M/NXQQHG22g8xcIt5c=;
        b=xKpcC/GXXxFvUdKL5Bm0O8S+wwfNDMT1XtCP1O+2ya5Q0BmBNWyRwPmG+hrDUQvCC3
         Cel23ra9w8tq0Kh03gbAvXuTNwl1DfHn9mx3cpcoQByOeL0ObTM1gg3xhMzy6cWt6mYY
         IuSIecDPUvPZqPh4JQCTcoMVC/34SPwjtftJK9lc/8K0P6kK0QVuQCjXCm54byU+tj9E
         JWpoaaUk4h1m5m9RnRJ65L73ZtOr8T2p5c5IPn59Gr1wxpPEQoDFDo+HwDVPsWizf2ei
         jSN+9oNd31MXjgoC2/y/lZJPioktKcigd4k6ydTpxws+bm/212kumSrZOevMtviEoART
         3Mvw==
X-Gm-Message-State: AOJu0YylHuAPgimO4mDAR/iWmGmk09X4ZprrYgEB30eLAQEAYgZQtzoG
	sR19sDQCND4cRuW53N4kJyAOrOUUvXE=
X-Google-Smtp-Source: AGHT+IEGMBW4lWTYeutsfau0rPAmfoob6PRsHdbStM7KPd/olF/IzC5pNmhu2qVF/mWoVcLTZZ9OU6RLy4w=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:9429:6eed:3418:ad8a])
 (user=gnoack job=sendgmr) by 2002:a25:e482:0:b0:d9a:42b5:d160 with SMTP id
 b124-20020a25e482000000b00d9a42b5d160mr103762ybh.10.1700847046654; Fri, 24
 Nov 2023 09:30:46 -0800 (PST)
Date: Fri, 24 Nov 2023 18:30:23 +0100
In-Reply-To: <20231124173026.3257122-1-gnoack@google.com>
Message-Id: <20231124173026.3257122-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231124173026.3257122-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Subject: [PATCH v6 6/9] selftests/landlock: Test IOCTL with memfds
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Jorge Lucangeli Obes <jorgelo@chromium.org>, 
	Allen Webb <allenwebb@google.com>, Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 94f54a61e508..734647f86564 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3780,20 +3780,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 	return 0;
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
 	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
=20
-	ASSERT_EQ(0, close(fd));
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
 }
=20
 /* clang-format off */
--=20
2.43.0.rc1.413.gea7ed67945-goog


