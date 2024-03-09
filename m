Return-Path: <linux-fsdevel+bounces-14048-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB4A876F99
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF126B21208
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7181381CB;
	Sat,  9 Mar 2024 07:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yya/tQOJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FB8374D3
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970821; cv=none; b=fpRtK8EIc620K2f7pGAW+NGGGcDdKpD84K2sRVjguMw7BpezymB9dHa5xK32P8XbZD1N7jyBdOnJoL/SBydf3y7Hi8PW5G1M687+hI7CL8RbCUAoVIhuzC3lOZwHqST3BeOOSR578eUP82MNw1tI9/13ed/otf99ipViy3gbS44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970821; c=relaxed/simple;
	bh=Z3q8TUMjwgpivCigA4vrhz3RNGKNneAYDv1Up6/p3tU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bpiFlRPztyeGJh2vGGSbMujL3xArB9QASf7szbLAWAq7r+7R0qHRVI5hHUlZ2RA02znwz8jRvfczxsaNFnkF+tTg6KuIFuA51yXTHnla7Xxds5mMaJKqoEDkG+D7aVxqEUG4oXV2tdSSZCFzh33lFWlecZqEOAp19i8ip97lMek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yya/tQOJ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc746178515so4501530276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970819; x=1710575619; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6ZWDgBnbZIfaFhFVfT7jsQxJgGlWIGxyoXMZnZq9C5M=;
        b=yya/tQOJneI+zLKmXqGxuwnCMIBnhWvFzyn0ISx/shUGbptwgMnlxPh5Dpdptv1Uud
         bM1F2qtyybxnEIfsf+1bVFDuqgCyo2HsLD7Lyo5kq/s7eBPncopCqO87cWJuwtzfAjDF
         yQPUGpQhffpyoHxSOeBFKylR98D5B+WEGM5ZUOMV7Z1iPDWrnRy5nU7HAKW9yUoWyk/7
         tG/quUvQ/+Jz3bmLxHWLdypbAOFVNZLisJEb+slj/zHOldOsOiPioBiLFMzKy5yjqeDe
         iTXg2uU3Wfsctv/JjblcLZ4edDFlFO7x6OA1mK03xgOwpGkWtyUTygsmDdTNPFinwQpd
         o6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970819; x=1710575619;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6ZWDgBnbZIfaFhFVfT7jsQxJgGlWIGxyoXMZnZq9C5M=;
        b=h/f5RERtJ17jdhkcBxUjX1DvKGnNpMLRiDF88lqwyBJFD8W4Jx8WO5zkE8vqeTIY4n
         veCoXiuoflW5cIk6E8GrDpWCZUG1Fw4DBQxnf6sf5qddN+cwW0+rW7iqjyIw18pkzEK0
         Q1wsJgTEDWO8WVbT9f7/LyXSj1SB6ypmt0xuo8Pi/J3L/Vw3HG30FIyjRSaG6RW4iTMQ
         BNmj1UmVknADYxLQIvXW2wBI7UGui4Pa2wwgrCFVRZs5/PckDJxfGFvDRDpEnT/kahHd
         QT5zxl82mvOujLlorIh7GA9HAEjbyIhAoouBXi/L9br/d9avBZ4YtemFph0NHumcoV6E
         0vgA==
X-Forwarded-Encrypted: i=1; AJvYcCUVV3O367hHcUhfzNrtOmz0O8kNxcgfKo/ZLkV3Lu7oDRyrzLVGcfqoW+CaWlgTxQSW9IXnsoZ3syfd3qHc0Kw/dDXJBTq7Ixd3RSwOHw==
X-Gm-Message-State: AOJu0YxHsZaP4r1Hfq3C0BKhN/W1O3ZGxkGdAs+tadT/IoGgsWAGZZdL
	DiarjfgvOYN7OQpJd655iGDeD62cI7Lu2v8gCWr/hp1luSvBcxnYk6WEYkdFxOW3X8Y+YQwrs19
	OdQ==
X-Google-Smtp-Source: AGHT+IFG5DX7qqXVTepRoOI8ZJVWe6Gadhv8jhaw+KaBWoOHLKfMIfTCOYgc+feUd9HW5jsS6V5+s/3qXRM=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:120a:b0:dc6:ff54:249f with SMTP id
 s10-20020a056902120a00b00dc6ff54249fmr357788ybu.8.1709970818999; Fri, 08 Mar
 2024 23:53:38 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:17 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-7-gnoack@google.com>
Subject: [PATCH v10 6/9] selftests/landlock: Test IOCTLs on named pipes
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

Named pipes should behave like pipes created with pipe(2),
so we don't want to restrict IOCTLs on them.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 61 ++++++++++++++++++----
 1 file changed, 52 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 5c47231a722e..d991f44875bc 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3924,6 +3924,58 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+static int test_fionread_ioctl(int fd)
+{
+	size_t sz =3D 0;
+
+	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
+		return errno;
+	return 0;
+}
+
+/*
+ * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
+ * because they are not character or block devices.
+ */
+TEST_F_FORK(layout1, named_pipe_ioctl)
+{
+	pid_t child_pid;
+	int fd, ruleset_fd;
+	const char *const path =3D file1_s1d1;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_EQ(0, mkfifo(path, 0600));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* The child process opens the pipe for writing. */
+	child_pid =3D fork();
+	ASSERT_NE(-1, child_pid);
+	if (child_pid =3D=3D 0) {
+		fd =3D open(path, O_WRONLY);
+		close(fd);
+		exit(0);
+	}
+
+	fd =3D open(path, O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	/* FIONREAD is implemented by pipefifo_fops. */
+	EXPECT_EQ(0, test_fionread_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+	ASSERT_EQ(0, unlink(path));
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
@@ -3997,15 +4049,6 @@ static int test_tcgets_ioctl(int fd)
 	return 0;
 }
=20
-static int test_fionread_ioctl(int fd)
-{
-	size_t sz =3D 0;
-
-	if (ioctl(fd, FIONREAD, &sz) < 0 && errno =3D=3D EACCES)
-		return errno;
-	return 0;
-}
-
 TEST_F_FORK(ioctl, handle_dir_access_file)
 {
 	const int flag =3D 0;
--=20
2.44.0.278.ge034bb2e1d-goog


