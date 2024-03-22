Return-Path: <linux-fsdevel+bounces-15099-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9FC886F86
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7298E2892A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2078B5337F;
	Fri, 22 Mar 2024 15:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ewoz0dWy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9394CE13
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120240; cv=none; b=uKm2UEzkLbszmMzHlb3VSICwXlNJbG+ShcxM8Ct5we4SBCEVyW2CYfazzzy5C9Pb+GVzVhU80KRbrnV6/MVEDU7aVP9RN2Xm0QbCT1/oHICVkO3wfLBwr6pr1JmLmFNzyc/0gGiTTUQxHJiQMqYSw789uVuQgtlrPwJr/cLhAXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120240; c=relaxed/simple;
	bh=R63P4N4ut3QWcKBwrsSKNW9gphHCqTPMh/5hYUZu3qs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iZhcY311wgO0lDqe81l7mngwHqz5mDycJqwNtZo6W9JDT+xsv34ldd++Ryn8eVhwuq0+CEC43jV69Eqq+vrsnIxIRZWuAUfm30i8Yqn3Da6hSq61Eb8tfO8eXLnR85QkkmtijszkOrfQJUA4UGsDfUIaIbkzYUajqwKbQ9/nPUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ewoz0dWy; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a3fb52f121eso123200166b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120237; x=1711725037; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9xd0irwbkgB8QE4v3yIoFgRxbZM8RilcqJPUwmelvc=;
        b=ewoz0dWyIF+K1vM6OUHqH5W5QorCX/A1EP3v23t1GR6KaLFTgJmyyasA6v9ROw63kq
         fe8jeer+hfuzSRlvI21ZGDoBlg3RBywahSZ1ryccd2mCmoOhUJHHJP6+QQGVjYowOpsX
         TQK6zdaZI+PGXrSVg0WBOFqyYaEqxCeNnCCllJY0FLrlvsuS3hCUfOjR09I7siaCQNlu
         hT49iDq795ma8UD5wcpo5JL1XHJ1shmEsn5uWlTyIqk6kAFiuNQx2J1qNGUFPdTqTOqE
         IlVuWy8kISMxsoH1eRYdE95Nw2t/DvRiQZCgh7uNq7MNGoAQGKjsmsPEixXnEvVGXvux
         08cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120237; x=1711725037;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=M9xd0irwbkgB8QE4v3yIoFgRxbZM8RilcqJPUwmelvc=;
        b=xKB4GbkAmOoEObUPl1Mf+GXmhu8nWnCuK9fMLcSGAOgs5Tsbzb4f7CSAMOUZ4VozjO
         Iv97A1ZPsFTIAf7hGR1jyZ5ZhJcPko9gW9cDSge2U4LBz78YJXkVJ8rPO5nwW5E1s1BB
         KOUxd9XQVbsdeVXpT4P7kRVNOFbdZfMxbW+RQpHkws9N7zGQdTfE5c8yiT+Wtrhud89H
         7fc1x8KJF3AY9zmWuDJ2Ne6OcFA8et7pwLPicfjc4ixoVdrYpuluISaHHzoExsDu6TlV
         QBlQMmtgCMY0X8ptp44piiRQlQaBF/YN8RjUthePixR1SwrNZgW5T6RBBEHWkj/iBBAN
         ZE0w==
X-Forwarded-Encrypted: i=1; AJvYcCVIoLEMtX5K491r00EWXwjOOR/GAMYRlPGG3bywDQJSU7LM1hwEd+b25idtoRh4PQ4PWffoXovaaEIfdP3SbxF7HBNtNFByDTEeQOA/fg==
X-Gm-Message-State: AOJu0YwDenDexecIskiVgCvUeKY9zT4IJSLK4BcxjrOvzAr9rcqxWBpL
	Gp3vc5gEObowUTzmA7bD5rftZXJRghgxz6qUngyubWimD90JqO/HSDlIs5TnlrAhvcK9rFSHD1r
	Cew==
X-Google-Smtp-Source: AGHT+IHn7g7WhrbCoj+qwr3+lnHh3Nzxk3BhHeFxtHPYejqb8fDsbQYGnt/pSY23Iu2Eb9T3/kTLwpxNCzo=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:4c4b:b0:a47:31bb:1581 with SMTP id
 d11-20020a1709064c4b00b00a4731bb1581mr4777ejw.9.1711120237415; Fri, 22 Mar
 2024 08:10:37 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:10:00 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-8-gnoack@google.com>
Subject: [PATCH v11 7/9] selftests/landlock: Check IOCTL restrictions for
 named UNIX domain sockets
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


