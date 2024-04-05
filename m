Return-Path: <linux-fsdevel+bounces-16237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9E0B89A636
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F116283547
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F92D175565;
	Fri,  5 Apr 2024 21:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TIsUASRU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23709176FA6
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353289; cv=none; b=E+rx2tz/a/NUbBe7GxmRSEx19q4aHZcKiDxhK3qZxl8PWrVyF9VbmsrMGyxIQlSnd4CklF2m9m1mqEHBevwxkjl8aGnrFuBRxY99K0cpXqzGsnTJSgXyeUa8l6nnn2BK/7j3sHQqCVDX5dvZ3dPZAO0kTmHY1tvNg1KGZ2jRl+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353289; c=relaxed/simple;
	bh=qLMDwtyoGcqvFMu9EgR1JHLn66RlQNI/pH5oSg2jAJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TRDAQLmep6fPAAT6O06qS5v8iQsvx1490sjFU+4gYR15a4nqZ0uJRMU8/hD78pVXHOB/i+t70cECPkV9XBk/ZAYBVBjJN4lRXkv9U979y17CALn8QYsKyumvIbx1o+sjuAoUlfhbQ7AWCcXcz09wDFe0Dj0FwBG7Rglvkwmx9qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TIsUASRU; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56c25ebc347so982921a12.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353287; x=1712958087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Fc14ktG9ishMSkK8oO4f2RF7Hc8qCkHa2Mip9JK5uP8=;
        b=TIsUASRUNvHEB6EPNkNhzpI/KHtjt+fSWcKUiS9TGX2Vn9bEYjvknmFFqxgq02vJUj
         gg6JrnGIexYBCz7Vwvmen+xxKU7/Zn5lFfhWqcImrxGpoTczhczdW/gpRwgjEsCJScOu
         Zvaa+ZBs+05TZR17PADuAd1TcnLLIj9OGfb1FAMy9XIoEMeQpynassqNYCEZ6X4t58xP
         7n1xGBvk0v8ZWiN1R++OX2QJcpPGENbcGMZZPFIGjLhEa4+P97b35nNd/zyuRu4PVTzf
         x+Q58Cvf+lA3DcJb3oyeRUlq7lg+eX5iAoFNwi7v0pafrU4YvbgTNc/+AuCnI/MqoYn5
         U+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353287; x=1712958087;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fc14ktG9ishMSkK8oO4f2RF7Hc8qCkHa2Mip9JK5uP8=;
        b=mav4WtkZ8jgCgdMJIdrszWcKv6NciKv/y+xJA52qJlXbiDnFtod9iVAqmKRUVmBBdC
         zmZ+ckjP27XkPM56Gw7EZwgvNIcElF6eQdz2HE+1z0XuPptgj6qvJypJaLdeczK+Fd5g
         V20UaIt33C3ftOJ7iYR5ryh2ApirtnoLmoWslwtzDO2O26fqZkyDkS3qG7/f8rk2oCtu
         Ry3NYnvGWEf/qUwqxOGad07y9h+FbeMjFEJ37JLDj90009uzMQ+5Hpay+Hh8gZPeSdWg
         2+xOQ08b0YcxH2pHi2neeqAqaS7xrvt+BYautw1Ry/H1rrt89FQe5YyevtRtN00Uk4m+
         xpug==
X-Forwarded-Encrypted: i=1; AJvYcCVzrgjV0D5OqQy+pKkUo3L/jMhjd14ujFrPOhNoXAH9Z6DBjVPTDH6zjLJjOlwSgdR+Fret9NmNHAcxvWGkt9ftbLesRi0JOaG07pRcvw==
X-Gm-Message-State: AOJu0Yz3egm7Oefb8xEj/vv3/MmRlvKe+Omt8TdqR21SEQ5fR7mzmPd0
	IkK1SUnhb3ylIsyEpJuqsiFiHHwLU/O8U3ZSesMAudwojE09FTBcRxozvDgl3ihPFiEVTaspcwR
	VDg==
X-Google-Smtp-Source: AGHT+IHqFS5AI9UI/vpOn5k0bm6lPACo3o++vVDdnl0yWHrksyzS5WQtUNQe7q479q6p/ykpoXJPgD3hAtg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:321e:b0:56c:4d33:10a5 with SMTP id
 g30-20020a056402321e00b0056c4d3310a5mr4155eda.2.1712353286763; Fri, 05 Apr
 2024 14:41:26 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:36 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-9-gnoack@google.com>
Subject: [PATCH v14 08/12] selftests/landlock: Exhaustive test for the IOCTL allow-list
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

This test checks all IOCTL commands implemented in do_vfs_ioctl().

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 95 ++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 10b29a288e9c..e4ba149cf6fd 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -10,6 +10,7 @@
 #define _GNU_SOURCE
 #include <asm/termbits.h>
 #include <fcntl.h>
+#include <linux/fiemap.h>
 #include <linux/landlock.h>
 #include <linux/magic.h>
 #include <sched.h>
@@ -3937,6 +3938,100 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/*
+ * ioctl_error - generically call the given ioctl with a pointer to a
+ * sufficiently large memory region
+ *
+ * Returns the IOCTLs error, or 0.
+ */
+static int ioctl_error(int fd, unsigned int cmd)
+{
+	char buf[1024]; /* sufficiently large */
+	int res =3D ioctl(fd, cmd, &buf);
+
+	if (res < 0)
+		return errno;
+
+	return 0;
+}
+
+/* Define some linux/falloc.h IOCTL commands which are not available in ua=
pi headers. */
+struct space_resv {
+	__s16 l_type;
+	__s16 l_whence;
+	__s64 l_start;
+	__s64 l_len; /* len =3D=3D 0 means until end of file */
+	__s32 l_sysid;
+	__u32 l_pid;
+	__s32 l_pad[4]; /* reserved area */
+};
+
+#define FS_IOC_RESVSP _IOW('X', 40, struct space_resv)
+#define FS_IOC_UNRESVSP _IOW('X', 41, struct space_resv)
+#define FS_IOC_RESVSP64 _IOW('X', 42, struct space_resv)
+#define FS_IOC_UNRESVSP64 _IOW('X', 43, struct space_resv)
+#define FS_IOC_ZERO_RANGE _IOW('X', 57, struct space_resv)
+
+/*
+ * Tests a series of blanket-permitted and denied IOCTLs.
+ */
+TEST_F_FORK(layout1, blanket_permitted_ioctls)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+	int ruleset_fd, fd;
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	fd =3D open("/dev/null", O_RDWR | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	/*
+	 * Checks permitted commands.
+	 * These ones may return errors, but should not be blocked by Landlock.
+	 */
+	EXPECT_NE(EACCES, ioctl_error(fd, FIOCLEX));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIONCLEX));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIONBIO));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIOASYNC));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIOQSIZE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIFREEZE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FITHAW));
+	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_FIEMAP));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIGETBSZ));
+	EXPECT_NE(EACCES, ioctl_error(fd, FICLONE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FICLONERANGE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FIDEDUPERANGE));
+	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSUUID));
+	EXPECT_NE(EACCES, ioctl_error(fd, FS_IOC_GETFSSYSFSPATH));
+
+	/*
+	 * Checks blocked commands.
+	 * A call to a blocked IOCTL command always returns EACCES.
+	 */
+	EXPECT_EQ(EACCES, ioctl_error(fd, FIONREAD));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_GETFLAGS));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_SETFLAGS));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_FSGETXATTR));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_FSSETXATTR));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FIBMAP));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_RESVSP));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_RESVSP64));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_UNRESVSP));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_UNRESVSP64));
+	EXPECT_EQ(EACCES, ioctl_error(fd, FS_IOC_ZERO_RANGE));
+
+	/* Default case is also blocked. */
+	EXPECT_EQ(EACCES, ioctl_error(fd, 0xc00ffeee));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /*
  * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
  * because they are not character or block devices.
--=20
2.44.0.478.gd926399ef9-goog


