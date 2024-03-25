Return-Path: <linux-fsdevel+bounces-15216-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C4B88A83C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6851B34410A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AD12BEB7;
	Mon, 25 Mar 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g/9MyPC8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9412BE8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 13:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374028; cv=none; b=G4bCaCxkjbOEx7AakqRv1oU8Al41coowKnIcezl33x9h2VbAakjNILCu4z0IltEEcWW37DJol3mOKAe0kBGZ3u8CE+avwFnJwUPl9NmSPv6nuurhnVVWb4EnljpgPwrXpRj1bf2WE1EYlthP0CxLYgzgzkD8ShUJjVuJSBUMp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374028; c=relaxed/simple;
	bh=R63P4N4ut3QWcKBwrsSKNW9gphHCqTPMh/5hYUZu3qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LrgdJJ/JY3kO1PYIxf4gxKClp5rqe5rXFBVNx2t2mAjk+R/VvPCclVTq5azG5RXDnepvLA1+dzKbPa+27Neem236uJR4VOoDcLx/rEcQeF9FHxAD5vcFdRQHO5Mi5wbs1JV7ywfIKOqOmdIzgBRbLugp0EUQJoDgAu5icjSRRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g/9MyPC8; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-56c180359b6so295544a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 06:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374025; x=1711978825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9xd0irwbkgB8QE4v3yIoFgRxbZM8RilcqJPUwmelvc=;
        b=g/9MyPC8r9cvrtK8X+tPnkleQLYja49leCqb2LLSOpH9c+5tJ5KJKSxA4lqWB/pDfo
         O+XeNF1Ri6WBgVDg2kO6vbY2sDFobN75dQDcvtMyAcAYczk8sBV7FfOnxarxBTCZSTO7
         OloWs3gfJ+khaAEFyibG7iD4feMg1wkU25zsRg7sraeJDt3yyah/fuOhxpr1lhMJuCLZ
         tqAEYQEDqZPXIueQ54J8f2e1NkBivQnqxkbnAJ2XnRmLie92YpAFk1a8KCD3j7rH3S9f
         CH9YHT5ei/p0MsdrIpOui7rSI9eOi1cli+58jhK1uyI0YSoLsaRikeSzrpuKEDQOywJu
         H9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374025; x=1711978825;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M9xd0irwbkgB8QE4v3yIoFgRxbZM8RilcqJPUwmelvc=;
        b=bnEEvsrGDt0xITzJ2ZzgrCVbU8npw+nSt+EwnuoGFtqiZOvfvHtr8RR9J8pAdwBogS
         bpHVo85LuGeBoGiGas2V26MJp+mct9HQfB+bLpnXW/7H0SyWTuWAMISAtzb/q+v14Kre
         ZwT/HmHf6pRwrJpKBOEedmK0e3jKe+B9w+D3TriQql0laIuaH6CDZAtZeTN8YA1sg9B1
         lPsnrS2pPJ1soXe4gmrHeqUwMstAW6FunJLk0qjSEoySKc3DtHKOcI+sC2/kZa0DilH4
         WbqXsDhzUYFCDRGvQSmZr4xzv06p5bLujCEBFJ5r3vv4jvYrtxCbHM6RItoeSZI/CVty
         tCAg==
X-Forwarded-Encrypted: i=1; AJvYcCXxiHSKEzmWw064jbLcW7Q04P4SQtLCptWwpvYP6Wi/5tvLVv+DKeOxcaLUpdfG6smfjk4nvkVZ1zK5xih/NhzOKB9TrxB/tLjLst0Uww==
X-Gm-Message-State: AOJu0YyJgdB435g1ckAtRTIMbfr8vX9YOh52462gZjasOvuVjPnqKjEt
	qC8iBp1+WMN8ElxIQTzbdwbJT4+4cf02LC6cO2TfhALdIk123O+OCumSsNvfiCwQuy7SDe6M5fK
	OSQ==
X-Google-Smtp-Source: AGHT+IEIY5Bfx+JYLmFaMkAFu6cve0vWsUrlwgoqaS2K3lT/XnxiKeTJS/mOOkJptd6y2TUHDf3S+kkM3Mg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:b9d2:b0:a4d:2281:101c with SMTP id
 xa18-20020a170907b9d200b00a4d2281101cmr4329ejc.7.1711374025551; Mon, 25 Mar
 2024 06:40:25 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:40:02 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-8-gnoack@google.com>
Subject: [PATCH v12 7/9] selftests/landlock: Check IOCTL restrictions for
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
 tools/testing/selftests/landlock/fs_test.c | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index d3aaa343f6e4..2ade195bde56 100644
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
@@ -3976,6 +3978,55 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
2.44.0.396.g6e790dbe36-goog


