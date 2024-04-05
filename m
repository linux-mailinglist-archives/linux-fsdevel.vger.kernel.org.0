Return-Path: <linux-fsdevel+bounces-16236-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E53AB89A633
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 148421C210C3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5693E17555C;
	Fri,  5 Apr 2024 21:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JpfQD9XZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43CCE17555D
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353286; cv=none; b=sjW0BwlPhehWhsqoblr5r1i5+zp7+hRnC0m4t5Px83wmq1x+rb7flx1/JtwUe06kSTctSCApG2dEK5zXfeaVAvRO2n9u4beEQIumxfKePw6rxU6BlhKUPqbUEyjTYoz0O8BCf3WpKXmi/nzSr9BMGMUOh+XUuI0BwbIqdMWspBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353286; c=relaxed/simple;
	bh=XrnYYxI+KCCO+Qa5vPr3MeDGJNYdQzakwnKE59Nzsts=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c9VgvVE2s8W9cVNn0UzookxcmNfRNs+sXgV8a2nEs06/FhRY+IK2mqNM/jJf5pS9zuCW5BUfurQP17UbHlrhGmfNt1kP9BiY0X1VgIYjET4oHgktCKAFl7Wgjy65vMM1djTMoX8ENTNvuMI+wU3CjuoUHkuCi+i6HZaCdaU02U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JpfQD9XZ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc743cc50a6so3649098276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353284; x=1712958084; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nBbNmNFl+n5lpfyI1mNxnpRrGBsCnYQndb3n58WFmTI=;
        b=JpfQD9XZoe4ha97rfIvq5FRM1dXGLRDwp0FKxuxpjURBHQ5hkrRaf+pYzQfdM930x4
         8tBaBJriY46QpY9vhgToDOdAfKNAJ8kq1iUQGCKmMxFgUQkPgFJEAnC4Aaq7iTL9+Vqj
         Hn+e01OegOtYAFIqRX6n9zxQ6H3lVcZZFQpALV5QtkxMX8DXJQpCQ1sXO0lJhZGccmIv
         i8K4cwBk/hEs0DgxQpTWrSP+Z2GMk3Z9GwRSI6zovzG2wcCPX9RutA4L2B2KaGDpWlDi
         /DU8Zyp/SI8+a5l0bs6NA9GefdGGjExziZ00YJCJWGkcGvCgcA0bFOCMen2GPQwWj7dI
         80uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353284; x=1712958084;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nBbNmNFl+n5lpfyI1mNxnpRrGBsCnYQndb3n58WFmTI=;
        b=hpxlr6f5YG6T8YQUtWkqllvKCmqCwtVyBRxDOu/EF7IfZLSoGhusO2Qm5P6YNHMQgP
         YxmTyeNjTXKFfZ1l4omX7AvBoMPsVAe60ENXgf5HVHMVgjQC9dIspDyr+nc1q78gjK71
         5E9HD9JpUkC9OW3zNkeKKYdxhKt372PURGMgns97LHCs57kxben0Po1gzETJyye/GH2L
         uh9gWl21zH1ssweXAS3+MagteoviXIGDIlnhMb1uwAUJlmO71jJ2Ks35LRQhMo7nepqi
         o7Nnl9rnNVhJqIsEmijnhWBzApMwYthNs/5naBUGAPUOx4tBy9x8C63j6RJ6XnjjxVkj
         S4bQ==
X-Forwarded-Encrypted: i=1; AJvYcCV+VBGKHv7n16AxYOmmYIsDROh+B3kEtfqHa3VDQEDmmhCXOzN74Vj8N7tXkj3eZtBGircGJhEjn7WlCFUS1rAjftEdpefgQIB2ew3IGw==
X-Gm-Message-State: AOJu0YzkZsvtXh1msOUK5sAZR3PqBSeerTUNpS36zDZNH2BR8aPUw8D/
	lPNgl6PE3mudJKgvbuokqgQYatLZoqYT8+AVt4t+fMn/cPN6hQkPQsJCVbkcfn8dBHvLCXYx94S
	xZA==
X-Google-Smtp-Source: AGHT+IGlCqhV+FVUp2mV1SdfkGDRhN8E7j+1Aly5UutobdCKC56eYKvbcj9nPfvjhlxl9RyHI6kcUe7DqJA=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1502:b0:dd9:1b94:edb5 with SMTP id
 q2-20020a056902150200b00dd91b94edb5mr220907ybu.10.1712353284398; Fri, 05 Apr
 2024 14:41:24 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:35 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-8-gnoack@google.com>
Subject: [PATCH v14 07/12] selftests/landlock: Check IOCTL restrictions for
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
index 215f0e8bcd69..10b29a288e9c 100644
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
@@ -3978,6 +3980,55 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
2.44.0.478.gd926399ef9-goog


