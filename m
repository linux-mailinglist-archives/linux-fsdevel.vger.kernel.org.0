Return-Path: <linux-fsdevel+bounces-10994-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0620E84FAA1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3159F1C277D8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFAA7EEF5;
	Fri,  9 Feb 2024 17:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CFTi9fAZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA81C7E595
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498389; cv=none; b=tu+9amg5lzVcknylfBFvK0zZ33mE3PyF8/xYx7/6Bi4KUuni08aJ4zcXHVj3mOQCzWsFCQ69Sk6iv2h/DkcqVUG9HcbAkkXGBiPkHaftq+G0UuQd4zG2120qWzAC5Z1OixWqDMikibqtjVUaqbwkXFhEwlkhXjNrlnSYi48IDyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498389; c=relaxed/simple;
	bh=qnVVQyk96V+29yOrH9p87U8Q4CRd3DD7DhbdDzGIkLk=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=kGs8MZ196sbIkUcmGzkEQzMufxYRRvGwRNfC8lCCBapsOqNAUsmPdxzGpaCtbSJgYi6Cn73Vxe0nurmVqW3EHDPmeFLPMeZ0/e3ZGX6pDJPEVonFX+G0zUpquvnkql7tzAVirsEWJMUQ+RSV+PsurNcRZNR3QrPVtt0LdSi5VPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CFTi9fAZ; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-55ffcfed2ffso2555343a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 09:06:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498386; x=1708103186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gbIxtpk2chw6jsiB6rCOoopjh/LiZGd5/fSxW0kPD1E=;
        b=CFTi9fAZ8SfLI02MxJyk2PoEZ1CFkiRFXgoqA+U3JhaQZJMWpJ3mfAwd2sYB8QARsf
         7eDBBYx/u4ki/8BhujqImLSWaRrGU/5VSkk8mypef5vPcAgQqQafjqNziXNhkrTM0FZ0
         0QGDzNPmZMzVRzNp/tAF5yyDBKh/D5isYuEb0iMTogVzytyBhM+Pn95mpUVJL9L4/9wf
         q0lrXVX0d6acl2uTw+mNsiWe/u6f4E/zTa+F8LajeeWqikjXUfeYAxxryITH6EaJ91x5
         9NIPVLS1o6MzTUMJXzCBQfqVrabcG59xDhvV57NeflBo6X6qzWFTF+kGLaf1WiQxJAY+
         PVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498386; x=1708103186;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gbIxtpk2chw6jsiB6rCOoopjh/LiZGd5/fSxW0kPD1E=;
        b=UBllnf4rGCgyhO3r7c6Us6KTmlDa72fJRQhzVdknGlLAvG8hQNjt+l+P0tzK0dATff
         nKU8B+mWJUOs5zU2kookRh+FVphM8liarDnFXbwHYarizOmNKItDP4DjsZ0Hf2Gf1LDP
         rxQmIHlc6LpIvaEzAL309M6TJxx2srJdIKFmNxoAFl9y2omo7YhyDvVUoAokdO9SBs/d
         B+XtTBiL6hCN7qNmj0cc54/80Uuf5G7F/rS8fJfj2PM1hLeEyCfp7g8Wysl0Lb42y0rC
         HZa1i55I1ulKkfpOgNYdG46phyAwC5Kz6lqAp1B2ILhHxswfjLFb9TEzGjtrpHfkgWF4
         Z18g==
X-Forwarded-Encrypted: i=1; AJvYcCW4p3K63paph3RL0/7RbbuxQITLUB0B+qZ9xQNM6vpwWbfSbQmw+/V7BYaklrbuPIZogq0YhklQMnEsBOi3DkoGNqMESaqV6tq2fidBEw==
X-Gm-Message-State: AOJu0Ywc+MBm2b1SGm7Jze4UZNvJIri+zB6v7Elta2AxH6wOOdQUG5Uz
	lTn1w4DLTdoZNgS1u2H68/xjVUpwDjoOGFjYuSXW/3liaj+Exw7HLgtCAVPwvZ3nuqmsLZXDaFn
	rmQ==
X-Google-Smtp-Source: AGHT+IEkXTF2JnkhhOCozajRd1N6fTjDERadCVkYE3Gcr63l6dmKM2d5Wmn7khHsRaEPtLo/oxdM9j/9THQ=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:400f:b0:560:aa2e:676f with SMTP id
 d15-20020a056402400f00b00560aa2e676fmr5547eda.3.1707498386021; Fri, 09 Feb
 2024 09:06:26 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:07 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-4-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 3/8] selftests/landlock: Test IOCTL with memfds
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

Because the LANDLOCK_ACCESS_FS_IOCTL right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 6ff1026c26c2..aa4e5524b22f 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3848,20 +3848,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
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
2.43.0.687.g38aa6559b0-goog


