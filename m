Return-Path: <linux-fsdevel+bounces-10997-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 499D684FAA7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66C811C27C0F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E2C7FBBC;
	Fri,  9 Feb 2024 17:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wvYgzuwv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523557E595
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 17:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498397; cv=none; b=XDnQdglzU2190OluJk0wr3TKY5RAFYjx9qqL1U6v8STv9KGyr74K0+JiASQ8uTyhwdw5xJQ0FgQyfTIYTJgUPAkFiKlkgiL4JXhGu6/Wku4D7Lezcny7Gibo+AFbdLf49ro42K78Rrs2mg/SNX+q28+VOwSNqMOS3mia1qHle0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498397; c=relaxed/simple;
	bh=ZOMMoEDQ5xIGIh13zw5bCfNnxE82fCIe2LgtgMyom98=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=axmgL6Iumr9SlIRvplrxV1KdF/kCZJbjX0sPjlnbfPluA8cfeum6D8asmOeZvOCtz+i3DPde3m5fNALvr71mTjrIcdooE47Ur+3Csls6zEnYmXAjRJ2a71EQlQLozSWDlrIp9b4ZD8D/KT882JasDWAsdby9WaVOA2Jh0OgOydM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wvYgzuwv; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-5589ce327e2so1005725a12.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 09:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498393; x=1708103193; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+kC6dT4IyBTfeBcHN42EnhFy5ZpJ2/rUmLiDKj8ztc=;
        b=wvYgzuwv0BVe4kqj49qaEVMDC8Rw0A+H/B/1rN+utWgvAOy4ycvKUt6lT33qUK1iMi
         w1pHzgAV7J9175qCvgVMwtbVQYyZO48Dgqa8B4LvDSq2DiTeVa8Tj1Gcje1RFkx5cKcy
         i+vO9T7vAYBhJqXdSIQvT3GbGiNjaDHCzCVYFTqija7gnGheALk+c550ziiTT5vAIWlc
         4iIpGzcllFqfkzYnFGy+XMvfnKopglsyEv/c4r/2mtZtOFNbC6eDT4FlFkPCQLVv8dWA
         NKRzFFVKflOnk668cy4pXz0aaqRfg6SmHs2Ra2kS4tqcVljxZUdP/HsQPZnytURI4wVN
         /C4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498393; x=1708103193;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o+kC6dT4IyBTfeBcHN42EnhFy5ZpJ2/rUmLiDKj8ztc=;
        b=Fc7lHnxAmO5padSs+IPJv047ZDv5aJboX+8/CvBBqgFBqyYgFiYY/v+kmO02zWQlnj
         k7uT3P/33PPyfLcwBXA756bgiKOXRQQxpP0RPNhNSK8T6iQMJwXhTW02zXDg9n/6+b/v
         CTvSL+NyLEDQ5P6COVgtJqHp73qpeqX1ua5uc9qLglmfTpMprFq7FwKz/NC0r/cnkMlW
         nVuYjT63ogBaJZ7JfoXFSEOsqQoBuvAdAoAVHrt3zpMKQ75h0kR5Oz2GLUVRbM8goPYp
         RyefxY9yjxT8gzbPvLbW2J0plK/rClssFv5ygpg82Zj/q0HRLeZmXfGPXPyeL1SFFLgl
         bF0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUAyYPBNK+OEGLCsNeDex7XtbTUFPXFzJvKGqUz/+reKEAcPp5xuvD5FSAZK/8WFjRcSBz+FNqFnBBoikRYsriJ1KpMaV1/4DtHsgE1Jw==
X-Gm-Message-State: AOJu0YzAQjy3bEa542L2ROA+xQfiF87PJGhHI5AFUcFs3Ehx9++hLF2H
	ES556dWoKabMVUuxBj/7TXN4wOjlMc+4YAHwbA8SNiFDIzU91Gi97fZgwS5D06KPmHt63N9N8Sb
	WZQ==
X-Google-Smtp-Source: AGHT+IE+S3vXTRJstlGpyHPrIzXl4dpZ7xz7gmneKPNSqhlpVLJgSelFzxDYg6Ih094UIcOnll2O2YPkRo8=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:6402:4009:b0:560:b996:189d with SMTP id
 d9-20020a056402400900b00560b996189dmr10674eda.2.1707498393599; Fri, 09 Feb
 2024 09:06:33 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:10 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-7-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 6/8] selftests/landlock: Check IOCTL restrictions for named
 UNIX domain sockets
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
index ae8b8b412828..59b57ff6915b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -18,8 +18,10 @@
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
@@ -3983,6 +3985,57 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL,
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
 /* clang-format on */
--=20
2.43.0.687.g38aa6559b0-goog


