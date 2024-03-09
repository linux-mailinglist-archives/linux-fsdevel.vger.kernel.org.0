Return-Path: <linux-fsdevel+bounces-14047-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82014876F97
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CE62820A9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7951A381C2;
	Sat,  9 Mar 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kSUQ+KCL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F25381B0
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970818; cv=none; b=fm14ypLHQTmy1iom8Q6hDb9vmH1r/GJE8wGMpdzQtmQa3i9Gt6w3gUTzee339xHxHtH6kH7vGklKDBKo6g8D1T5mVafnvJ9rKNHvqoIP1dBNdFdu4HV9vFHr9sZ3/6+PP8mrG96DEROfPFe6jVKNgcXA8WiC6dXPDKBGtI9EFJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970818; c=relaxed/simple;
	bh=EM5NgZxl+/z295IW5qLK4Q86JjQrYvFmb5Dx8M6uibA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=iok+UtJks88mNXzDtJw+lUaoz+ar77G1Fid9zk3jKQu0dqm+Xk4RJeYNxIJlrCPlhdMxRMKOg+LKxJ9hb1q18xZMjDHBoD9XsLzdPOts75IO4NgSe9ASZLBE49q0W27/11jU+ySLDBMvihtk92yv0h0D1PI3/Ipae08tbZwW4xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kSUQ+KCL; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc647f65573so5072989276.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970816; x=1710575616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vTiLehS4LJD5o9HUwzF3rxHkb5AeJhq43H6981Ab20o=;
        b=kSUQ+KCLY+qebDJaMmdQfkK/NBx+YmGDL631ZTJHSSGFDLjVnuJNXdf/cF61Uw2W48
         MnuhEedFhP6sJElZsczvDcPt46NEcsuhaejrrdrxp9UZvDZ9xGuUHKAzDbj+0z8I759T
         W7HPXZG3A1sMCO53eQvMBpF8nKp2NqtVZfUE7ZrlTKloVdwckDR3sPw5qo5di67VAiYi
         43/yp/p0Qwp/xHKcmQjE2kGBfb87uRGrpNWqpwT11LNEPilnu2D1MOTuy+JFimuwqZk0
         WDrvPJpROKAtSj2LMCXdfGi1HzrI3FiH27quq99VHixwPyI2iClKuQlPJT3g5ilmsTpw
         mhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970816; x=1710575616;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vTiLehS4LJD5o9HUwzF3rxHkb5AeJhq43H6981Ab20o=;
        b=pMKxVAvIMB3O0Cq0yJ5zC2GAN4XVceGwDFfpJn6dxKBucj+y56mR8MhgchiQMp5Jbi
         +f1HuWcGNpJUTdCMYpV1TrvJepydvXH1aRNBeJEHSbe1VsOUzz8B0SQX0Jwe0ohq903V
         Cf+XwlzO/Tg1W1cNrtWTSwetynR2XQmVhPnUQdasBd3vBFeue0EE9KBef0y/i6X87grJ
         wYIJ2V7FrRaYACwaj1NR+/2YPagmrMYAOyYe3Q0xFXJyrU1dfmAwnXdqPpwDPMMpiz+u
         k3UvftZRN0Kcsk+HZC8XDBaNZQhXC0ZkP7muwLcqv3CRtcO1Od0NGWhBo1jUvz2U45Zd
         FGfg==
X-Forwarded-Encrypted: i=1; AJvYcCWj6k/JMsBWUIZQg2pkWFHIYbXk8FNVXAGw95FBzZYYyzDcELNzikw5ABK4D8F/+9relolQgq5k687FRW/cep82Y9ra2I7mN/ARPxNhRw==
X-Gm-Message-State: AOJu0YwYQeMyEbwbgFPBW4Zwe7GXJ/BKbITwwmNtYYMiuS3/AhhdQUSm
	bfCNznVCBo2MJbQ/6qpEK8kxG4U8+AihlOh/w0rMWK/42IPZleIcvsAJlwER3sx04r3mz+i4R6u
	8hg==
X-Google-Smtp-Source: AGHT+IHjhRMSidShXLUw0QQgJexcjKoFuZoKEuDKmaj/QYfeXCiIczp7cpV6e1rADR1i54xH/3kROGyCseI=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6902:1004:b0:dc7:48ce:d17f with SMTP id
 w4-20020a056902100400b00dc748ced17fmr289354ybt.10.1709970816715; Fri, 08 Mar
 2024 23:53:36 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:16 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-6-gnoack@google.com>
Subject: [PATCH v10 5/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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

ioctl(2) and ftruncate(2) operations on files opened with O_PATH
should always return EBADF, independent of the
LANDLOCK_ACCESS_FS_TRUNCATE and LANDLOCK_ACCESS_FS_IOCTL_DEV access
rights in that file hierarchy.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index f0e545c428eb..5c47231a722e 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3884,6 +3884,46 @@ TEST(memfd_ftruncate_and_ioctl)
 	}
 }
=20
+TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
+{
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd;
+
+	/*
+	 * Checks that for files opened with O_PATH, both ioctl(2) and
+	 * ftruncate(2) yield EBADF, as it is documented in open(2) for the
+	 * O_PATH flag.
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/*
+	 * Checks that after enabling Landlock,
+	 * - the file can still be opened with O_PATH
+	 * - both ioctl and truncate still yield EBADF (not EACCES).
+	 */
+	fd =3D open(dir_s1d1, O_PATH | O_CLOEXEC);
+	ASSERT_LE(0, fd);
+
+	EXPECT_EQ(EBADF, test_ftruncate(fd));
+	EXPECT_EQ(EBADF, test_fs_ioc_getflags_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.278.ge034bb2e1d-goog


