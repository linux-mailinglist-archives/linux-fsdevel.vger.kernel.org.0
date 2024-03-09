Return-Path: <linux-fsdevel+bounces-14046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 558AE876F95
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3938CB211D2
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:53:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4196E3714C;
	Sat,  9 Mar 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CwHRRfsR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6DD3770B
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970816; cv=none; b=BbG7+YZWUX9EFVda8iJMfPSTjknUPyP0QTTtBM2rDv+zasbWAp4eKGXhTLJMvoLaMTtrhP4HgiKnKQ/doY5Dz1Q5etQcCQfxjclOKAShCpaPSB2ENNr05Lf2VdLYGuvnoYofZoOtXzLwFMuRVDAa9xG54D+tyGd3+jx1djXE22o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970816; c=relaxed/simple;
	bh=/obajl3ZkTVmUpPImQ3RvaB01jwki71f/zy6U85I5dI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YVBmiRb6a1Gw/RhpFq00Sy1MHfve38kySomo9Mr1/umZvJTN3JIKYXKWyzXQiOiV81DNaMpmalyJATEmZszMASP5tyUU46l7xJ832XGP1wlxDeIt5wRNMU9yg1uVDjm2xkbXGpS7sL0exghw0DC/Xw621xkJaXjwd5OyRyU/ixY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CwHRRfsR; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc58cddb50so4677619276.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970814; x=1710575614; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ReQG+ixmkuinsSdC9mIa5zvbWLbunHkO4cyd1gwaqNw=;
        b=CwHRRfsRAEboLvRB/dGeuc6idIET1LYy5XN2TlKysrd5Ibpa7ecWCXfHTJN5QE0mQO
         R4/eznZHDrz5f5doHFRZD0sXsuHrBgOK4/2D0bSyDpeHc/SEFTRJ8xyyRir/lJNOftNL
         cK1esdk+TKPijnJNQXRuYUmO64s2jlzDUau0QDr6LsXNpEnEMq1ac57kCr+wHsxIbd3d
         NxPhBxwPS8HVEET/4xWmBHqE/UiG7fPu5rpHqNQwxCNkhRXz1NQSsF0Fba9dHlOuZ4QK
         FP7AHL5/0r7MDkPu368+H4oVd2ebwod18xcAHG7jd3EDomNbxsQPIyLWALCivO+2Ll/2
         7TBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970814; x=1710575614;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ReQG+ixmkuinsSdC9mIa5zvbWLbunHkO4cyd1gwaqNw=;
        b=vA6gCvy0zJEUmWvUpE/om+SsWpHEslJ6MuPztm6piSerUcSflD30Wu/Xht7aG93LmG
         oTRKJfpvySi7WNVlullzwIpVIGS4E4tC3gpkKIJ+iy9pHUizJkLkGf48A++5XoAPb8rS
         aqXj1G1LQu9WzVfKpEMoaHlJgysQuy66qjkY3Yl5TuvW99Vs6je1hhJoDuYRxBHZPoW2
         jFZXnbSMpofV0oPDg6scC5mHDFhclGjQnP0FGTze0agseC4wlz2rh1PqZKiqRNFAhMhf
         dCz6Z3VOoqiejAU7PNH2hgpRyw5dEUC9whm2LsDuju5AfKN4l/3HnkWFK6ehdO9Um2P9
         uvTA==
X-Forwarded-Encrypted: i=1; AJvYcCUkpVU+0qSV2p7OZN7cEki9ibxpsotP7H/YvBHKY8WOSrURP7hlzfp0CMiIrRaxK7uu6TVHM2cqL7YKEJTELAema7lAMFIaNJLd/0OpoQ==
X-Gm-Message-State: AOJu0YyQrPhtHDrpb0JWTKcNblAvCxpmrRLOQnj2ULWluSjxO5g4cY5o
	VuRxP7tTaMrBqGDXOGleVjHwITO6UlyG/fayjE0APUbuI+qM4yVlamTOqBT/NO849auCKtlma/I
	mWg==
X-Google-Smtp-Source: AGHT+IFsQK6KdZUXqxfmMwTeeireKmqfBtR3AMf5Sfdx/sdIj9m6huXfYFh5Tj7ElM47vS97G0KcCMnW+V8=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1889:b0:dc6:dfc6:4207 with SMTP id
 cj9-20020a056902188900b00dc6dfc64207mr350796ybb.10.1709970814386; Fri, 08 Mar
 2024 23:53:34 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:15 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-5-gnoack@google.com>
Subject: [PATCH v10 4/9] selftests/landlock: Test IOCTL with memfds
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
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 91567e5db0fd..f0e545c428eb 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3850,20 +3850,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
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
2.44.0.278.ge034bb2e1d-goog


