Return-Path: <linux-fsdevel+bounces-15097-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9FC886F82
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:10:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B25A81C2237F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56B651C23;
	Fri, 22 Mar 2024 15:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QBIX9Kdh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCB14F897
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120235; cv=none; b=GuSL5ylKelK655g430ni1hm6mTYLdZZNSQk1QjV+CcD93M7gXuFOq0oG/yFZjAacPXts1Yz6G9RC+zU3EhWiNeHwaaL6SbDFpqWC2sy6I1fHN72jVBJTSOaUi3K6tI/5cIK6KCSZF2DmWub8KqI75XXxm2o6RKqM16S95ehucAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120235; c=relaxed/simple;
	bh=HzbXoAKj1O2Axw/b80Ha7oRq747pOMPBeo9PHNh77I4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AH+ijm6L5nQiqMoWjrPUpBLuYfIm/eOBiESgN4YSj1XC4Rn1a8F71Yx/W4itEElB3dHYXHoVd8ay2DWpuYIYqssyDVpWorQ8jdhrmX3ez+zzxG51hPoLXIC0tN/2L6/oL3/OUG/X8As9VuFD4SgoyhMdHJ84eDBCUxrf92wTSMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QBIX9Kdh; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-61100c749afso40104367b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120232; x=1711725032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WK2iXIrfoq6Fz3IO0C5eVV32OG2FmcAULBO6/ELXu64=;
        b=QBIX9KdhgFRcPZhX55SAdjX0AX0CPPlQvQVqd6h1lrE4b3MQl9FAF9nZQL/GR/UOhQ
         xLQd6NwBxLrx4fFtNz9ww6JBKlphMFJFVR2rIYc6DVWsxW+DMpCQeAclB3BwRiEVJrZz
         8wCzefRfhIuxgUT6jdimzude9g567dfxoXjJy7zvq0f7N+R0/NGMGWakZiWlO6yNM/oI
         jYLh59rAQwMKc9vvaDu83ZFnnnf3CCIF+fy9nSZQKNpbM4+EQMBtemJLouapwcKJfkg6
         eLr1p6+HwBAtu+B12ZHjmKfJ0TthxdmgaWjuVmk8YZc5mNo0uPtkvjUDCKPtnBA8XCei
         3GHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120232; x=1711725032;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WK2iXIrfoq6Fz3IO0C5eVV32OG2FmcAULBO6/ELXu64=;
        b=Y145LUPSwq4gsYliHbbZGXoIKw/za6+vA+KxNUbBiANB+Mt6vVdmua26u7FRICsTbF
         gVFeJxMn/RL5qEURzv4EkocwAjnZog4AV6ZLpsIWbbxNPn1FTvJBK38REHBqJdIW2MDR
         s44rcmBbUV5PgP8FkRlngWsV5GoyfGC4sMN7E93bO3BiZJoTVlo2Y1eK6VIMjA2B3Pt7
         Mh2VpmH2pfGxccPnK57zPMABkaiUMc1phukPrQ4gT/j3xbOQT6RC52ylx0MA+JroVnk0
         oF7UNwA4K5pGrfRb4WDPv6ISxec1zouEFyobuW/p/2khF9evKrbnCjPANSSt9dLhhHkG
         gLKA==
X-Forwarded-Encrypted: i=1; AJvYcCVmf6DHLC4xe79xDGOnM1MElodXb9l726NTFwZrI2UA0QXrSG/BxA0WGwnkZkMfm9fpm0ZscNdC8P/tsX7jBSQ5Xn7HdjICH3O9HohWVw==
X-Gm-Message-State: AOJu0YxSvyoYiJnJRLTDYafkWgiIilDQQrJrZ7DOY+ptbDxwLCfhyyu7
	nsp/7Qz+BKKzvKyulc4Da88fH7xEXU9Zb/Y4njuyfE+ykOVejWQLytZWAUwsEh10DWtdhGm9q44
	ltA==
X-Google-Smtp-Source: AGHT+IE/skOcqhwr+ZTj08fMTLjErgP9sxDZA9kKjc1KHwbR43EKvperDiZY9OJDs96Y5WSECFwxnpc28bg=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a81:9c0d:0:b0:611:2ae5:2ea7 with SMTP id
 m13-20020a819c0d000000b006112ae52ea7mr151930ywa.6.1711120232760; Fri, 22 Mar
 2024 08:10:32 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:09:58 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-6-gnoack@google.com>
Subject: [PATCH v11 5/9] selftests/landlock: Test ioctl(2) and ftruncate(2)
 with open(O_PATH)
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
index 32a77757462b..dde4673e2df4 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3893,6 +3893,46 @@ static int test_fionread_ioctl(int fd)
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
2.44.0.396.g6e790dbe36-goog


