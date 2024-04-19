Return-Path: <linux-fsdevel+bounces-17301-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 704498AB2EE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 18:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A13851C222F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B45130AF0;
	Fri, 19 Apr 2024 16:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EGztUAzk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA576130E5B
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 16:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543099; cv=none; b=Uc/iSNqNj4weHlIlBrGy6wl1gRsEnj2Z0Pfkf4YU1tykSG0LVXFexqLYq56dBfxI36VJhtAnryrfceasI5O+4OONKuMq1XwnwyABwIsjr9ABmh5mDYmGvD4wicL/PVG30Rb/U36c0abF/LFDy/DLtczS4dicBRpRaByJ5P5MjK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543099; c=relaxed/simple;
	bh=7d/RbSKpR3aY4FL0pO6CN0tfxMLVWk8XhMdOS8y3ssM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kbxoX0QjVWC5VMC48z57jbvQRMZY3P6izPjXClpzOilGzovuBxnzyxSfKBRN1LncgpLrZWRGtbgZgp0dTAsGLNEbmXAbVktAejmKwczGM/KT/aRD+ttwh9pqhOk6uEWiCxoNcXrcwTe6dtCM9LqsRz2dd6dgjmMiX4vkSF1/EvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EGztUAzk; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6183c4a6d18so37721147b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 09:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543097; x=1714147897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=stVtFYF+LnL18YF8nyIqbl9KBod0cDeM8+x9sNLHztU=;
        b=EGztUAzkPmn0kRVGsbhCyJlf2yIN5mPUe+B2O4y2JEuLIlH6xspnmcy8eCowBEyBf4
         vc3Bc/oGtvxy6r8XE2Wx4m+E5PMyuD3Ox4YgoD9RsYMf/7jzIph/3KdRah880PBiyCMt
         rsffNQ3cz+EIColnoTGyb/vPyiWhdRblzFL/7fZPxPTt+TUQl9liboTn/qxIimL2SKY8
         iGYs/hUlHd6bR4fwYbxTMRSpcCIWWLBEHtuS+nYMNA/EpHKUD1X7mVcOVa3d6umEN4Ck
         AiF4YAiJnfzeq7Ic2fHa5zGm2hHS3oqTabV44n9vLmIpBZfVAF+WT3an8mi8qiwD0C5p
         KRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543097; x=1714147897;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=stVtFYF+LnL18YF8nyIqbl9KBod0cDeM8+x9sNLHztU=;
        b=DQbaa56BraE0zwsix3g1fz5wWHJV92bycIGFJ4VWrsDvu5VDd4FOZnkSIOjOXs8h0D
         WafkKs6mx3dYZuYEgNh/LwJvxgqixV4vYr5zIo42/CR7Ux38RDRpEkTPAWfAYwRCmI93
         YvOyG4P77iFjIwq6vJbrif9wQg1ickvIC2yJgsh8cBu6FwaQALt1Eml/7diHZ2Hjeic5
         GJGyMbYS6pbB2XUs9bpDFTTTQ/RbwOr8h822XCev+X7q0jJ+s3cnX/5AS6RD0iVObOWS
         /d3szOaC046lQgDrl3Lvp40cPjHjGAYjC7mLksht5BmFuCaUydoi83ietxWUdT7OZChQ
         /aDQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNJaz71pyCTBUDUiSPTMDKglvz8IFEHv8zQL9wCSXPB1JzlxLWZsHSguAArKvFcBkJpdnNfuYJxKOBy8P8+uGpkpj5UBJELtqdKb/s7Q==
X-Gm-Message-State: AOJu0YwJOsDIGElRsu6zM/9bZmcP5F+Cr3wB20yONg0SMChSo6S0pXob
	AKb2G7IqWcpS5Qc1OlFGMT/2n7wgmOcOP7p/pXjWewgM1sTbS1IrWbtz+AElVAT7mK0GfjiXZc2
	3AQ==
X-Google-Smtp-Source: AGHT+IGI4BKwr0cL9YRBOG+ryUuic3GjJcK5yIXcHug+feKSxxoAvlNyZs29Z2yD3lwOvXRwrx+qf8GMrIc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:9e4b:0:b0:618:91c3:c8e2 with SMTP id
 n11-20020a819e4b000000b0061891c3c8e2mr520711ywj.1.1713543097028; Fri, 19 Apr
 2024 09:11:37 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:14 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-4-gnoack@google.com>
Subject: [PATCH v15 03/11] selftests/landlock: Test IOCTL with memfds
From: "=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
To: linux-security-module@vger.kernel.org, 
	"=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?=" <mic@digikod.net>
Cc: Jeff Xu <jeffxu@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, 
	"=?UTF-8?q?G=C3=BCnther=20Noack?=" <gnoack@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Because the LANDLOCK_ACCESS_FS_IOCTL_DEV right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 44 ++++++++++++++++++----
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index cb1382a887c9..6967e02ba3cb 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3842,20 +3842,48 @@ TEST_F_FORK(ftruncate, open_and_ftruncate_in_differ=
ent_processes)
 	ASSERT_EQ(0, close(socket_fds[1]));
 }
=20
-TEST(memfd_ftruncate)
+/* Invokes the FS_IOC_GETFLAGS IOCTL and returns its errno or 0. */
+static int test_fs_ioc_getflags_ioctl(int fd)
 {
-	int fd;
+	uint32_t flags;
+
+	if (ioctl(fd, FS_IOC_GETFLAGS, &flags) < 0)
+		return errno;
+	return 0;
+}
=20
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+TEST(memfd_ftruncate_and_ioctl)
+{
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
 static int test_fionread_ioctl(int fd)
--=20
2.44.0.769.g3c40516874-goog


