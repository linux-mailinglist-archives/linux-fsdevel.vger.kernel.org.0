Return-Path: <linux-fsdevel+bounces-14049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2B33876F9A
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:54:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 699AF2820BF
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29458374F5;
	Sat,  9 Mar 2024 07:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IBfylzeh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20033374EF
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970823; cv=none; b=uUR3RIa4KP8R2aWwuJCiB7Hsyw9GchEYCOx1mICDlIuL+Kx5v9C+W4mmdDRmj4BlGxLrZTTzlJn5pihCxsTXZPRKFhI2OtzI9GIJTfBe9GYW0GtjB0Q+ppsT5Q1wCvFA1zq0pTySbj4KO/l85ltkSvL2mIHivR4l/zmex+sL8Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970823; c=relaxed/simple;
	bh=LnWWTWsCU0spX5jOHOmnt+NMIc+/Q5BpY3npXqS3RzI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G68nhrdaa2Q5AKVPuGI+BdzGhQPMt4czZRbUQyjuB0RQdr4pyxmqzdqsQ+rGUvUUej2JXzPhdcpUqgtH0J1mCkeb5TQ8HVqartuRp+6RIGU81yidmxgp7LZxA/W2WCHPWZSPa8vuKbundlXXsQ8jRdBg433JLjUhmKOUjlHuQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IBfylzeh; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dcc05887ee9so2454999276.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970821; x=1710575621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5KAFkt8c3ebWOo+/ZIaVQQgVH/0sXUyTE45VSTpW7Q=;
        b=IBfylzehtfWavxJqjabQCQqmz0uWw8FoIya53WhOykJNeMmL+vWbnW++8GSuDXGHPQ
         apc8pfEJJ9c4VsQ38vzFiQ739FaJoAAIzVz2UnkW5/PhIzyYZbeme70P20Wm1JPC5KXY
         lqI1fEuu/JXQr1+jkGYa0Q6kStGh7/0ER4IGsno8wdm5emiBd3UAGvsAEKI1TZa+3IrV
         ubf8aRajc5iSn/Q61qutG/PadfHRjsWvV7jzlENyDlOSJfyqnd2T4vHqSjNHkvnBGM82
         qAMpFdFx/0jKF8tmWcKibIqU8gK3f7S4yOibysf77cE6QBwZKdbM83pgPOjx32ia1PbZ
         WoAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970821; x=1710575621;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q5KAFkt8c3ebWOo+/ZIaVQQgVH/0sXUyTE45VSTpW7Q=;
        b=ApyXlp4HJO+skmNWQq9M1A/NaDbeF4POJ9/A3KmG/soJjXCAqY7umdZ8wFCePAoOfU
         a4CdMsayj43m+diAUxGtKTxdDczYWVAKeMlaD6imlOC/8ICX+0Ab2q8Pst5M8adDhXvq
         ZhEWo/RKORTdFIctaXE1bhwru/IUtPjehfa9N1giKglWQNfmA+RgW1bzsBEz54G2ioi3
         +GArI0Nm2VlYwdp9KQoHjKbfRSWV+0OMP5QSqxcLUyAm8UJman30hTp7sYdD4blIlTp0
         nt/KsrjS+cKW7TXgcq0ZwU/9IdbOF1jeQQB/l3yDo1NIFNPICa+DajD8+OtcMlqSt+Zh
         6Ojw==
X-Forwarded-Encrypted: i=1; AJvYcCX3Ag3Pj93rNLzO6TwkX5F7BEKkQUehBYfn69zqbHoGFIFGnG5zE5oqL9ZrEz+/zEMfUF90LDpcYitbfbMob5Y81BCkPJtBRN5GZwFdKQ==
X-Gm-Message-State: AOJu0Ywah5nxF1IEYP5/dIrbBPfOHDxBXPZWZsUOJbgI1wJX+JZSnXJ5
	RuPbsRBWYMitlqJ4gpk7zHquJo5S1iBNvky6z5eqCk/BEZlRJITiy0GV48FI7iqHpkhr69iu85u
	V8A==
X-Google-Smtp-Source: AGHT+IG2UzW8T2XXCnZ0WKef9syIHtSKgT7HVGMP7GTket6ehHLA9AR/ZmA/bywD9mEzzCuohI2AJvz0ozU=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1143:b0:dcd:59a5:7545 with SMTP id
 p3-20020a056902114300b00dcd59a57545mr64713ybu.10.1709970821249; Fri, 08 Mar
 2024 23:53:41 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:18 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-8-gnoack@google.com>
Subject: [PATCH v10 7/9] selftests/landlock: Check IOCTL restrictions for
 named UNIX domain sockets
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

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 53 ++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index d991f44875bc..941e6f9702b7 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -20,8 +20,10 @@
 #include <sys/mount.h>
 #include <sys/prctl.h>
 #include <sys/sendfile.h>
+#include <sys/socket.h>
 #include <sys/stat.h>
 #include <sys/sysmacros.h>
+#include <sys/un.h>
 #include <sys/vfs.h>
 #include <unistd.h>
=20
@@ -3976,6 +3978,57 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
 	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
 }
=20
+/* For named UNIX domain sockets, no IOCTL restrictions apply. */
+TEST_F_FORK(layout1, named_unix_domain_socket_ioctl)
+{
+	const char *const path =3D file1_s1d1;
+	int srv_fd, cli_fd, ruleset_fd;
+	socklen_t size;
+	struct sockaddr_un srv_un, cli_un;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+
+	/* Sets up a server */
+	srv_un.sun_family =3D AF_UNIX;
+	strncpy(srv_un.sun_path, path, sizeof(srv_un.sun_path));
+
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_LE(0, (srv_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
+
+	size =3D offsetof(struct sockaddr_un, sun_path) + strlen(srv_un.sun_path)=
;
+	ASSERT_EQ(0, bind(srv_fd, (struct sockaddr *)&srv_un, size));
+	ASSERT_EQ(0, listen(srv_fd, 10 /* qlen */));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Sets up a client connection to it */
+	cli_un.sun_family =3D AF_UNIX;
+	snprintf(cli_un.sun_path, sizeof(cli_un.sun_path), "%s%ld", path,
+		 (long)getpid());
+
+	ASSERT_LE(0, (cli_fd =3D socket(AF_UNIX, SOCK_STREAM, 0)));
+
+	size =3D offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path)=
;
+	ASSERT_EQ(0, bind(cli_fd, (struct sockaddr *)&cli_un, size));
+
+	bzero(&cli_un, sizeof(cli_un));
+	cli_un.sun_family =3D AF_UNIX;
+	strncpy(cli_un.sun_path, path, sizeof(cli_un.sun_path));
+	size =3D offsetof(struct sockaddr_un, sun_path) + strlen(cli_un.sun_path)=
;
+
+	ASSERT_EQ(0, connect(cli_fd, (struct sockaddr *)&cli_un, size));
+
+	/* FIONREAD and other IOCTLs should not be forbidden. */
+	EXPECT_EQ(0, test_fionread_ioctl(cli_fd));
+
+	ASSERT_EQ(0, close(cli_fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.278.ge034bb2e1d-goog


