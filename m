Return-Path: <linux-fsdevel+bounces-15213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B615D88A802
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 17:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E77B51C61CD7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8A012BEAF;
	Mon, 25 Mar 2024 13:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jb7vZnjS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0CD12BE8F
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 13:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711374020; cv=none; b=otEdIUq5RhOXhwIfGhorJah6WPfPVsOcMvDcz1e6ATY7oa506R3GpjAYwd27MbZmXuZx6gdedkcQbeisSO3Wlb92Jbojy4sdl236Sjz75Zhrzit1RwXHB33Z01x7iQc2yO0GmQuxZ4bIabe0TU5iLbWItJ77izmgaJz5/IRC+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711374020; c=relaxed/simple;
	bh=Jdal8IKILETTWsojG5pDXheVDyQeR66rUe3RKtiUO/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qW8kirZ0CVpmG3MdR9MzUs/XR96ak0LLhyhZWh+wHlD4C3m+FLmlZOVCnnj+63ZWOQrn9nJSdX5eGlpFQiqDSLrvmC518wLycb6JmEEPCQ1pMtGOly5Lhumr7wGvHSGdtFvOqrUBq25ymXX2HUcBMo3PUCyhOLtxSRyABH4rnoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jb7vZnjS; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60cd073522cso79713197b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Mar 2024 06:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711374018; x=1711978818; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qobHCRmb6cXg9TV4MF/PMa0SUI8jbJIaeOrvT83hbEo=;
        b=Jb7vZnjSP02X1E130s6/cGvsm02xfx2ewtS3Qnvzq0Ul8KtMV9izPfXp5SS2nHM1XD
         9FkwJSDZTlwip8k/ZZrTgkYWScvkmlYayNsqIg1yoyDPedx89AcAyAEae1StxC/niIES
         JceMt3MrNGzwCTRMPb3IUNIPn33ZCJfv9NVmcT/YAksVRqpbxZRbYMo3THRx4db8TNEg
         F0zYDjeN8lMZ0Y/ZsABh4o5kTYASIZEkCtbBhEM3V9TLuLfDv6JxCfSaKSSX+m7HpkrE
         2iCpPoMRiTT3u7ZYylOj0V1XmTnKGAE27tEN36FXm7Zzoqt3z6tNsuiqPKSRJdStjaE8
         zjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711374018; x=1711978818;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qobHCRmb6cXg9TV4MF/PMa0SUI8jbJIaeOrvT83hbEo=;
        b=eBwcsvz4pYhDWuw51D8Dlii9rSqG7D6QSlJ/b7nHNEB3ZDGNUi+6y7FMJ4aSE2zFVc
         WR5Rt7ih+Gj+1dJSn8jeX4C11Axr8D2ILo4r18NDS2DdVtN6mrUbqtzkXpJrmOhMUjL+
         VHH/IcuBkqkiw6lfJx8X7Rj7Rg5/+tyFDrwwZi+ewjykWhUFuKGd42GqCwScv4an+1vx
         yegUKhieC6e+sa+Eun7cwdojGc9duex/4BlOrPXkfP/QXjTaWVvxhbc4AaNMdb/j8tRd
         d3+lZ4SpIuRwc/jC/dNxbJS+XOYskeAM06kyxE+dRRqa5r7qV+HH8KtToFSmmIpVIto6
         BWlg==
X-Forwarded-Encrypted: i=1; AJvYcCVDnB6uQHbkxPItqGm6cgkeDEy+t4cnUdcSgsq/jBGNWLmjM3MKhNbYM647WioBNRMl7FcO8d6uHNAMKVgzNkW0U7BR8IiZPnd2DGBW0w==
X-Gm-Message-State: AOJu0YwrSu5mxYKOCNIzEtV2gL99t+NB4Vt2GupCudYnCzktMSjctEGB
	Yx9Of84aacCazO0vSKHJdE62HZG/Rn++W88ezfAN13dlMmJaf+iPYq1GqzHpMbCEJgsemayPwTK
	7DQ==
X-Google-Smtp-Source: AGHT+IEdigQlldnlW6O3u3vZKh6579LMgFCjDlkpzU14xq0MVYQt6eWrAigFxnjSi+SF3zfjt5fIZJLHrzc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:a0ce:0:b0:611:3096:bf60 with SMTP id
 x197-20020a81a0ce000000b006113096bf60mr1940238ywg.7.1711374018427; Mon, 25
 Mar 2024 06:40:18 -0700 (PDT)
Date: Mon, 25 Mar 2024 13:39:59 +0000
In-Reply-To: <20240325134004.4074874-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240325134004.4074874-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240325134004.4074874-5-gnoack@google.com>
Subject: [PATCH v12 4/9] selftests/landlock: Test IOCTL with memfds
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

Because the LANDLOCK_ACCESS_FS_IOCTL_DEV right is associated with the
opened file during open(2), IOCTLs are supposed to work with files
which are opened by means other than open(2).

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 36 ++++++++++++++++------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 22229fe3e403..32a77757462b 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3850,20 +3850,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
 	return 0;
 }
=20
-TEST(memfd_ftruncate)
+TEST(memfd_ftruncate_and_ioctl)
 {
-	int fd;
-
-	fd =3D memfd_create("name", MFD_CLOEXEC);
-	ASSERT_LE(0, fd);
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D ACCESS_ALL,
+	};
+	int ruleset_fd, fd, i;
=20
 	/*
-	 * Checks that ftruncate is permitted on file descriptors that are
-	 * created in ways other than open(2).
+	 * We exercise the same test both with and without Landlock enabled, to
+	 * ensure that it behaves the same in both cases.
 	 */
-	EXPECT_EQ(0, test_ftruncate(fd));
+	for (i =3D 0; i < 2; i++) {
+		/* Creates a new memfd. */
+		fd =3D memfd_create("name", MFD_CLOEXEC);
+		ASSERT_LE(0, fd);
=20
-	ASSERT_EQ(0, close(fd));
+		/*
+		 * Checks that operations associated with the opened file
+		 * (ftruncate, ioctl) are permitted on file descriptors that are
+		 * created in ways other than open(2).
+		 */
+		EXPECT_EQ(0, test_ftruncate(fd));
+		EXPECT_EQ(0, test_fs_ioc_getflags_ioctl(fd));
+
+		ASSERT_EQ(0, close(fd));
+
+		/* Enables Landlock. */
+		ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+		enforce_ruleset(_metadata, ruleset_fd);
+		ASSERT_EQ(0, close(ruleset_fd));
+	}
 }
=20
 static int test_fionread_ioctl(int fd)
--=20
2.44.0.396.g6e790dbe36-goog


