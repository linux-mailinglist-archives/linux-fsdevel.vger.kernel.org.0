Return-Path: <linux-fsdevel+bounces-15429-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C87B88E68A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23182C453E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B07156F42;
	Wed, 27 Mar 2024 13:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKve6U5Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82276156F3F
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545062; cv=none; b=Qn8RstByxYjyz61pSOwAeLdsDWZOGG7NvWMOtP24tMH9jlgX6O95d2+IfID8lYwxVfcdZkA+8pxPujMQXL9PmdnFtAPHGg7ZA3vs+xcZmKPZ7FAXj6+qFcmXWOlmiLS+0vvm/N7hzdcWa2+yhNOQI9aZXQAhkWpTIfQTrj5MAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545062; c=relaxed/simple;
	bh=w5NZPXoa5e+UU8u8LM2lYlYzhtTpZtoIr4OrSEnz7DY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=t+PbWQpFI1YBBIt6SoiNF87xTV+tuHyN7JNSD2uxMnUgtGmwMrszRneSDjK+GPUcg0tE/EanJUvnGRBQc+DvTYockboWYFgZKNetWistLTl0a/ltDmt6OG8cwQulvchVLU3uyKqWqTgQLuzMLfVXplA72EremQcP3ZWg+yD2vMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKve6U5Z; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd1395fd1bfso10075175276.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 06:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545059; x=1712149859; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EZr8gmdyZqHNU6brJhRO5fL37vIq4UUfcmqdsBaCEyI=;
        b=cKve6U5Zc6BBQ0PhgVf6IzuK6mdnh7+IvrX5L2e0dYh8JuLeF12zoYLSaqaLUdHV6B
         qZVc0Ps8sb7tPEQQLzi+FFTya6WYsN1l7aTNOtf/yX0gPTWYk9KIuBjLYJ8opYL5q+nw
         SFfibj8XxHILNV5nLBkbShi4vuFAPN4ZsnEXYPrqR6gZ1hWpMEuLdZqJrQJ+4ZNixJfe
         t0EJ7OE1GvZ4DlSatyczWGip5ysydLjO/h6YvSABBY2bijGushvmkee6+VBtIfyqPFcF
         c+ttnDjyYj/dm5Xdy6FSYQjmndTmgto/pUAZuHJxeiLPgkBaVwWaFnmRK/vJmdaQ3uI9
         3oJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545059; x=1712149859;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=EZr8gmdyZqHNU6brJhRO5fL37vIq4UUfcmqdsBaCEyI=;
        b=sd0uvaeS796OrKzprejyHIFC/ZqHZQXOpm+R+QK7wcuePps9+SaSlIHu0VTrHp51bq
         nkfS9ZF4bq9qD3ZHX2ryZm8Jt5r2vNiCiCNJ4bCVlimvShNfEO9MH5v+OXovn/HNHDWd
         yNBgGf+Brz/J7+ojI/7r25DEyhAn15PXiRGiYks0s/5uZ3Cg/OETFqJdY7AdLHDrrulw
         89hhK2ZGbcyYSOQylEp5nxAhn5s2wtSu2mGFy9DJnqygJU2tJwyU/qVJmsVqJijgAzr/
         k9OBFaBgKRddtfEpkz50UanNNxF55EwNo8cVCXAq23PisN2f3vb9h0iY8njPQWoCJNIP
         bZ3w==
X-Forwarded-Encrypted: i=1; AJvYcCUv2sgxP6oYnuknEIO98sFcU8kKs5h+BUnbmvx+stNhNnGgorL/rfXAXALXJ1j4RZoWVnKzK4GjlZVoWx2y2ZOHH2jli7a8N48wdkM3Kw==
X-Gm-Message-State: AOJu0YzKx9VyqSFp4qGyaoEkW2m1R5hcU8JwuKA/WeLsd/GHRNC11bkZ
	etSUXLFtfCOqdd39Faw6h1XFm7E2xVvNFPVeMvvFxw5hnFc7cCBpkivWncTHcXNO6S3CKYZbBzK
	1wQ==
X-Google-Smtp-Source: AGHT+IFzzqHYTZilzWyh+2S5xqAY80ZoLVdTaQozlSuBaq52wbG37G9gUKw2rZMNekUtuwkso0TSLYrHT9A=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1021:b0:dc7:49a9:6666 with SMTP id
 x1-20020a056902102100b00dc749a96666mr4115658ybt.3.1711545059509; Wed, 27 Mar
 2024 06:10:59 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:36 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-7-gnoack@google.com>
Subject: [PATCH v13 06/10] selftests/landlock: Check IOCTL restrictions for
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
2.44.0.396.g6e790dbe36-goog


