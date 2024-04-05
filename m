Return-Path: <linux-fsdevel+bounces-16233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0CB189A62C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1681C20C43
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C8D175573;
	Fri,  5 Apr 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Pr3V5wGG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3167175566
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353280; cv=none; b=URKHp3monjySeliYzFZ5dCeW9wxbWPqS71GjdBNpt1CvNoMQnh4TZkgKuy/JnCBJ9qW4L977Rr39mubD9b1do3ZknQWMf6OB8IPXSPZs12vNqJopG4lAylDkaqReXChecVslHxU+bmDNUyOzICDjAvZleZjUQltjYPElGHdKBPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353280; c=relaxed/simple;
	bh=mTGd0atLVM8A70V3jLnT5qjUJDUe0jZM2W1J5PkVDac=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=QAzVhsBX7yUAuEQC+4Q7x2HL9Z0AW5zwHKCYfVP6Uk8gRx4qyNIyUyB4mD1XP6ozJsl5IagYyd7OpvbLZxaHjBvTKQQ/+Zf6fnaIECb/P1Aq3h65mEtECyWHJ/IZegrBXxuV1x1bNG/2NFlqMIrrJun/EugSxZlT/GERDGT+3Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Pr3V5wGG; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a51acf7c214so23405966b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353277; x=1712958077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQsxKlrfUUBg5XpcWZn3PX2WqaAgMSpXIdj6//RRCTY=;
        b=Pr3V5wGGzvCYBT0cGjvHsAnx8SBaEpKu/NVbrIleH1Sy31y/BglNewgzmvuZCwCXEy
         k/30XjYKyd7e+hUS033wpxw7O9JKyZ0XL6HNOyMXA14KX5oOUsUJrGRhNNtJa2ffXAAT
         0U3q9npxpGH1M6wYBCpoBUodoPK6oqKVIj6EufYetOA8P/zA4NZU2tRDxj5cqXYo/1ch
         fjxFSFz7rRhFVK+/p89wweDPQsroqs7yWhfAXse+BYS5FrYCo9Mb9kcJ7bRJyM+qkPEt
         2p4vv0krtlW4gUObQVKpJ4tbWB/IP3qCs+xeDSrm/z2IelMqR9O/ZZASbOSozFJ9HrHI
         V0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353277; x=1712958077;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQsxKlrfUUBg5XpcWZn3PX2WqaAgMSpXIdj6//RRCTY=;
        b=ZkmyV5AS58JHVR07FAUmazSv/C8O9K+lUn+3DOiOGueiuIARk9DOt+Kfkt9E7tXBz4
         NMFXnvQWiKUqMrEwc6eM3F9ivmzD23B07hAChnW+NNgdHQ4GiKsCxHhMGIEuk6w5dJrE
         lFqSF5ha+1zwWegRZjzfNT84SEChI4DnMPG6ehNzxdRnlxBsHg+9K1LWOchnaPEm5AGW
         xnskSf+5QUYACJmUqlG6rb42bHqafcljS9H2jvMtOTlYZh19k/SBg1KI9GwUGbVB6fmt
         2sQgXgZzqEN5blEtMtl4SnfV1g4eDOTkntxmP6MkpvEZu5SdHfGbVFWQr13qEyaDutOf
         ztGw==
X-Forwarded-Encrypted: i=1; AJvYcCXajNnbaXYeri/zAKvoeuAQ3iQasPbG2JSwC4uQ/AVzChZotbjf3YeAYb17RkXBORAkFcduG9zBr933JWBKYYSCffEa9z4cRin4E4KBdw==
X-Gm-Message-State: AOJu0YxrC4hBQvGofFEIT/7mf6N3P7bcVt0nfNWyVSuL8ZmqU9/7GBXj
	DnY5V0gWTJnfla3GJlGJMuMVbmbDx0bIQeTplMez5pyy828jfMzk/DLl77SjLd2AZQcGdB57sVl
	mLQ==
X-Google-Smtp-Source: AGHT+IHc7ZnRf9A4OQGK/czqVVD9KSBBMChv4wWI41HPw7YFWsTFeHHYpppwlobrqfsWzdUXKh92rqCxbMc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:907:77d2:b0:a51:9148:1938 with SMTP id
 kz18-20020a17090777d200b00a5191481938mr3232ejc.15.1712353276946; Fri, 05 Apr
 2024 14:41:16 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:32 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-5-gnoack@google.com>
Subject: [PATCH v14 04/12] selftests/landlock: Test IOCTL with memfds
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
index 8a72e26d4977..70a05651619d 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3852,20 +3852,38 @@ static int test_fs_ioc_getflags_ioctl(int fd)
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
2.44.0.478.gd926399ef9-goog


