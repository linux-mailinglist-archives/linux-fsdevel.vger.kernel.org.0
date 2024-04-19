Return-Path: <linux-fsdevel+bounces-17304-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6018AB2F8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 18:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 041D1286318
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F75F1327F4;
	Fri, 19 Apr 2024 16:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wPssourf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E137130E21
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543107; cv=none; b=LItxYLKrVJp/Q4DpCbIT7qJuKWYae6Psk332QfzWoKqdintnAbjnelq38mC7AByOOQHytTv6o/6q6Q+rrCF93wubcQjSA2DseLrtiKo8L+0SsVI0wE8+ox71/o+Xa6ZqJ16O5hRANQ5oiwnLonaHwwBzbsYoo+sc3G5G6lXLAbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543107; c=relaxed/simple;
	bh=/T2ATdVre3nC66getn9D+RTNZJEh2jhYoVCDuKPjn0M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sd/wyle2uXVu6w2vZVFQ4bdr/3vsaFhjTT7bDL+nWWD09eEq5t5Ofa6mP9ggK6KeApFcvYL+jzTok+yBqGnGGMg2Tln2jXaisYjjuUshqqCSVz191eXsv7RVEBykcFMe6CgM5Dg8SwWY79eD77Zr6H0+wWUs+qSQTvwINJL2NxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wPssourf; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a5217f85620so108541066b.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 09:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543104; x=1714147904; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u3Q8PluHQ2WZfMWH5jOIaXU1wUR7CEGtaUVFi0VXGVQ=;
        b=wPssourfpyTE4vEMuTgDdOWNg0yyPAZRJWCh/u8VHIy9aywxmI2vuzB9ZHxo+4armT
         x0+DImDrnhO2meWjty7eZkAkuBpVJk7X//4gnky9z8hDI2rdAvdFGx/DrP4eRURJGWaw
         C4KsBhcU3/oUP0iEWuZzaEgVaAAUrRBrJ8nB47rHMhtqt6bz0u/5znWsWSJzxTWN90jk
         gKQebl0BqMTkCGvK0dWL55KMTQMmXJ5BPc4wiEkZh/ew6U/jmOzYvIH6ASXj7sZegjWy
         1DNf/+W6SFZAjbCh5Vaz1qf4FK572jzOuo6qeXrA8b2hvE0H0jwb55JkbEKX2OS9UaMD
         KMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543104; x=1714147904;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u3Q8PluHQ2WZfMWH5jOIaXU1wUR7CEGtaUVFi0VXGVQ=;
        b=V2YITDpEsBDrTxBxEbqgYBujiUTxAof0zQWhqgiZxCBso0s1VuCaEWqT7bMFImgSl0
         MmnJDG+AfKuidP5UNT6Iphu4EsOFHAp39EIy+nfMtv80Z7Qs2Ju2s47v1tD77QCEFBFN
         TtDcYgVyzR924t3I1QI05bQIZBRHf1fGqv5CWzYmqU3GN5YXkIGnuN2+QtoLsbPEWKue
         0AvkXTeVsc06SsHnXZmgZvzLyrUAteckF4WfANRf1cttvMUsJRL109FrTq3p+KdI7b4e
         J7cC3hevqOeRSUyfvsq1A178KBUqbEDmjqf8lAX7as/ely7Bp77J2E1RRlUJYFojch93
         TGqg==
X-Forwarded-Encrypted: i=1; AJvYcCVg/q2xN8ZUSS0oxJtscSnxwuM+ppvFpiiIN+EeBj4KkTVG76LR0RNN0gBkal3AXU7VC1K++OdN9X4LS1d3giTz2nCRhk2Qyj6t7S+ubw==
X-Gm-Message-State: AOJu0Yz61C5LL8kq5IaFxkEHnPnXcJhF06s6J0/JUEBPHy7dABOAHUR8
	TwqS2rm/sUPAtZXhef6c0LdmnvXI3Da4BtYZY9nJvmgTWgjLXOSyoE2RuT44JRLGp1lDEuDHmDs
	U+Q==
X-Google-Smtp-Source: AGHT+IHcOl5SAaDcp7T7q5bwPlujuHOYqKTXXleyT6wfMJpe6DECCqjIK5YVX2PlOrj5a5ETvyGSrhnpYKg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:2bcd:b0:a51:d7c5:31af with SMTP id
 n13-20020a1709062bcd00b00a51d7c531afmr1768ejg.13.1713543104653; Fri, 19 Apr
 2024 09:11:44 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:17 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-7-gnoack@google.com>
Subject: [PATCH v15 06/11] selftests/landlock: Check IOCTL restrictions for
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

The LANDLOCK_ACCESS_FS_IOCTL_DEV right should have no effect on the use of
named UNIX domain sockets.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 52 ++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index f4c6b9fadef8..232ab02f829d 100644
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
@@ -3978,6 +3980,56 @@ TEST_F_FORK(layout1, named_pipe_ioctl)
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
+	srv_fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, srv_fd);
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
+	cli_fd =3D socket(AF_UNIX, SOCK_STREAM, 0);
+	ASSERT_LE(0, cli_fd);
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
2.44.0.769.g3c40516874-goog


