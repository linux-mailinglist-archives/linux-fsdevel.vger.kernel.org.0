Return-Path: <linux-fsdevel+bounces-15096-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D9A7886F7F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4BCF288EC4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 331DF481B3;
	Fri, 22 Mar 2024 15:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XUp8BC3H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F4950249
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120233; cv=none; b=VkWPpPd3f5kEU9W8z+1VeRXsWh2qWfkfaiKi4AFgYvlBVJpf7xd2z+Pyv7Y5gfL+SOwqgcNngchvXlN9KxJ4ILmg8uHikdz0pJUAGJXm7CORGw6HRIfRtCU9l+5xVt/IkDXv2Y4RMsKKcC9231QthQWiYHWkr9bX1I6RBfzPSpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120233; c=relaxed/simple;
	bh=Jdal8IKILETTWsojG5pDXheVDyQeR66rUe3RKtiUO/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gJBZxIA76A2KSaARLTUmSZk/jmPO0de5Eyrk/JToOoR9OCyrppM3mPvC9IG1xC6uz5k+EL1fTQ6zw84TmXint70RlO9kJoV9zbagtYjLNueGAPd6i5lXDF+JRoi9Nf8miI2dDM2t7FIH4jEqLd8kcG/ogilslEK8mEnHKO9qqlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XUp8BC3H; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a473555ec33so15899966b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120230; x=1711725030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qobHCRmb6cXg9TV4MF/PMa0SUI8jbJIaeOrvT83hbEo=;
        b=XUp8BC3HyI+X9G3Y6wmrELtKlRUSyz08pivvHaDOfGD2C/flbs4owpPajkuuLQpRHV
         i85XE1H7y4OuJ2i87dlIvULW5Vt5l0XNrQgHK39l9tIwAijzrxUQ680wDevN7GHamMEh
         6yhDl2ec7BRv2n/Y9KMCiFtmrqWCn35Kn9LvKxsVrLwxZAsbVr6CiZAOch2mSHV9svn5
         5Z54Fi3VXIFoSwyHEsV0pd/lbKAbGp21gwgWjVumFg5o2C5sgyr0Cz2UEs99Bw3m7cBR
         Zlcn0EydxpmeIfeChIiEtdUEBmZwbhByV8W+bwbOKnVUiKOWRHY+Z6yXeUDf9n6oGExo
         DvOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120230; x=1711725030;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qobHCRmb6cXg9TV4MF/PMa0SUI8jbJIaeOrvT83hbEo=;
        b=fn8yPWAsfX1NonjaMbwYY1k5KgUFVqDzI6QAtAsIRfHM7J+yPtu4m+PP/YFx3eMEN9
         iWT9R5LCOzd+b30hN83v8zf4raAGHry20Kupd3zN2o40kx/Xpa1nTEheKzLV8lpB6Cin
         R9rOLcRmSy28ZUlxsgUnUSBQMM0gaMYW+tvSNT268C5nS5FvpUonTsexuh6m2B1zVZq7
         5zvDVU5pWJI0Uh5ScABp07FNI2E2cPPDvuNkvqoo13qPIJjM0NQoWtZwD2rEGOPen+Oi
         TqJM0AsEj2qM2Zbp+LpuBu8lCvh4kKEvnmbK8vnsX0mIGcCBbv+6wB+kjmShGvYjDcCO
         HLgA==
X-Forwarded-Encrypted: i=1; AJvYcCWonZtpWonLpY1dlBaSBut7jPJh2wTxvLELlP+Fz7+dsilSYwVto0plDzXnVt2GfeTZjilIMtLpTIbSdQnJndwgtR3A03qZWVUPcVTx0w==
X-Gm-Message-State: AOJu0YyF68qILdGFbNn7X94hfe8n5oNNgkUzBY6sQcyPHU53L0FliFKF
	KIlwpItB6cZfxo3sIQPkhWv2yd1mAV0XOmKWmsP0aeszs0lHQm5VIfmORGXcgPNw1nc7brvVg3p
	uZw==
X-Google-Smtp-Source: AGHT+IGKONiWvctPFgaXTgXqq9xxHFVwjT49Su0OSiBo8MX70YapJ4UVh8nInJsSxxBNK14VBxvLp0hWONE=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:a1d0:b0:a47:1499:6de0 with SMTP id
 bx16-20020a170906a1d000b00a4714996de0mr0ejb.7.1711120230227; Fri, 22 Mar 2024
 08:10:30 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:57 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-5-gnoack@google.com>
Subject: [PATCH v11 4/9] selftests/landlock: Test IOCTL with memfds
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


