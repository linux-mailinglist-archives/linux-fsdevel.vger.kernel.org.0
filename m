Return-Path: <linux-fsdevel+bounces-17302-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACEDE8AB2F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 18:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29819B221E1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Apr 2024 16:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433C3131BBB;
	Fri, 19 Apr 2024 16:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ghliW+mr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24490130E4F
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 16:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713543102; cv=none; b=pXe3k89B+QfPDqns/paQT3K0+4+2xz0POG200zamQMZG5mB3v8oBK+R7hHMuUY9D2tEpoZbANxa+sLvTUT+GaspgT1psCs34R/R7viTjVSXrWptHIxk0JKVAfO3IFEEUmh7O+sGdyEvDx8pxVugGSDpByVps1+8wTN1osHchif8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713543102; c=relaxed/simple;
	bh=r5UNgUM78q5XLuj5NMQgb9HQbedr3JCHVW3UzlU0A0c=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sRDP709jW6hZPMVH538Hkku1hFbyfKC6dhSm+ogcIA7Lmy5zuojfNRa6+ITkNh4xHbE1n1kVipk4NK0IjoXhc97LlnjJhSuo7Krwze9gBQvG/t2q9v68tjI18VxMLxyE5OXUXd1BllxwvYgVgtIXTp5FD1tWI+3lh/OVDiy9rpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ghliW+mr; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-a5238ca77adso361232766b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 Apr 2024 09:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713543099; x=1714147899; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6J5az365xK+ZzeSMyv+LbNjMTEu5kjOKEeh883eiHPw=;
        b=ghliW+mrI6gp5GPUugW2/3vuYipLaCVWr6n8+suqnNhu3olQtd6fm99VRP5LB8QmWG
         QV51VN5Tb1MRuQU2C75XH1b+EwYA72aweJRxB/UAbmf59H1gbFC1JFyjqD+ZEpUIctK3
         LISsn1TUWpSNS/47M6JtL1m7EZ1vglQbOXiyMkWKuQ/q75gEsDY9TgkftPVxU4lB4Xif
         /hqJl0wfzKfNKKwSvQKbnfl3y6NSMOT2Cm6XujVj4+c3T0PcWMtblXnX40UI1qKURDw8
         7We5taMl77ZLMCK4viLGpwNHYilMWAGwUBa83/AUqIGSKY1ICKBbdI4sdF1s6oRyz5Jg
         eHMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713543099; x=1714147899;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6J5az365xK+ZzeSMyv+LbNjMTEu5kjOKEeh883eiHPw=;
        b=I0RYonxO1YGx7uNzOZvBhntxoGhviHICCHqXWguda5LLmmADXAG7NQ7mQ2oWJoLd8+
         noa+TVrKrp2nDwVo9R2XV+L9XnjkDB06j45AffIY1/DcakmQS31FNqtMrdhMIjbnAAze
         lBmF1gPh9AVEI6CXyY98mMTkWs3+XI4r8T4DJvGcLRNiugjbIiENGuF1miZqHTtzOeiv
         WnAwfcqMioE0cr/QNLK61LIqblUydNpcRgpl0Mhvp/Yw+TUEdIQCbarLmrO1Y+jffHIo
         gMC+exoWBIizeuCL5wcuqtNyrHhlD2TUrP6NoxhFbm6/+7j31x2Nk7pdk2jr/2cC351O
         hP7A==
X-Forwarded-Encrypted: i=1; AJvYcCXUWPiNLoF5XhDJ+Zbx98qvGXVO51Qu1kRwvvWLCTjWr/RzS4kJCbnHzruqBcscc9RkruDtRc9Ll8IOvIduM2UMLzUFLKQsJXc5JBCYFw==
X-Gm-Message-State: AOJu0YxttPJt9jow2rz/Q0VDELCovTexz6bxXI2sPMylREZ66m335PJm
	TiAViK5Ce/DxoLXRs8TtFXBRW0m2TY2nrjo/O+nbie9YNaKbzegjW1/xLH1O0wVpjhZz4AGFnSQ
	0qQ==
X-Google-Smtp-Source: AGHT+IHisJXB+GsHOnfXBzfhkwHJ+2ZKhxXdPCwJnSFv+hBOjspSP9l3J/lisVR8sJ4EglnuqSdIBajCuW4=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:aa7:d654:0:b0:571:d7c8:9d5f with SMTP id
 v20-20020aa7d654000000b00571d7c89d5fmr1918edr.3.1713543099468; Fri, 19 Apr
 2024 09:11:39 -0700 (PDT)
Date: Fri, 19 Apr 2024 16:11:15 +0000
In-Reply-To: <20240419161122.2023765-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240419161122.2023765-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240419161122.2023765-5-gnoack@google.com>
Subject: [PATCH v15 04/11] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
index 6967e02ba3cb..2cfda6af71ab 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3895,6 +3895,46 @@ static int test_fionread_ioctl(int fd)
 	return 0;
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
2.44.0.769.g3c40516874-goog


