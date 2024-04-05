Return-Path: <linux-fsdevel+bounces-16234-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB02389A630
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 23:41:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199741C20CBF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Apr 2024 21:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B65CF17556D;
	Fri,  5 Apr 2024 21:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="alJAh4bU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF333175570
	for <linux-fsdevel@vger.kernel.org>; Fri,  5 Apr 2024 21:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353282; cv=none; b=GrgyMZnzzUasBbB73T1DJXw9ampXUTSp8IGTnMG+FNND0A5vhTJxvSplIn05GNjEVIXLl+17eTJF0/PYSdpVVBqqJ6ojbbYDLGebKVwTnqZUDxTjDkO5LE8in7TNB6obfhgg82Obq8HJDNZiHwtU8y+NtQJmY01l4VTxxh1os1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353282; c=relaxed/simple;
	bh=cn1OktrYxfexIxvnLjxZnl8EEiqk8pa4E/agZ8LAcHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WBfD2YKxk6aUNyz635WwJKBg9e1fH9rVTMN9OSGURWCh9NwvNw1Gw8ZOcl0xQQKJgbjl7ouq1SdnCV26AzMCG9gsWaEV1fX+5RfH1JIK4VbM47sIHhnIKuQbQjui9iesYW4qFuIeiySn1bz5uMbW+4O+0WNiY5+GjUXIZEERG2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=alJAh4bU; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615110c3472so46946787b3.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 05 Apr 2024 14:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712353279; x=1712958079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g0G0jOKR0aVvhcJWNUSzc1F+nw52n1gf12u/GuQVyXU=;
        b=alJAh4bUiM1dgZwRe+h9N/02FFyepbflXfMQD/jI8hPDJ4y4He3sDVTBS4lkK/5ovl
         6bhRKrXX/Tfv/KYLwFEtgYy4vjnWLiMSJDrfKzDqjgKzAXdnueVt8yXHu08zX4w5UY1J
         F3ybTWJCNJcuDKDszsSuKFSc1PfsPNDo0NqG7aX6L58xgaNdwZRQj7X8yCNOpugCieNh
         sjbCv8X7hG0VnpElOhtfCRKaOVJ5fxbY63EPCEuS9CEqg1DAL7/NatFgNBCGSahWbMbY
         HlPCZSVj+O8fYQiRWzYB4/uRudp490FK0aMqJ4Uvp2dF+PBg3AcoDRYI4ROIwZ8VdrJy
         2G+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712353279; x=1712958079;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g0G0jOKR0aVvhcJWNUSzc1F+nw52n1gf12u/GuQVyXU=;
        b=nL65WKl2Oe+8g9SHvlIJ9V3IdCRaVttQqCVKp3xmPbFOD3RFw34YYlg7XIgMgNQ5Qe
         b24mS0Cop56Exq1FvRN50JDqBGcdOTbcrRz1bG+9uqCNzPXc42oAlQuebNDBruAG6swz
         KYrcWVSIYS0/C7fsLBf0Rvh5qAS/8OMsuzu8yysRiA9bJYT9Ty3tlzILHJqeJruAtCGu
         QBlXoMD5bYNmGSstLk6AJ2XkiQPD6R0CbHTm8fgZohKG6xOzkYnLxdjGfzejw4vtg4lZ
         eUNcTC0mxuW2/+zQUtcuXx95s2FF20clWf2PD+CUd/qp18K3ebzVA/s3VOyZt6RJfLWo
         kbXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWTqtwSR1ZeYU10bJSusTlKibrBYNa5BiAJe2T6HB41JA/H4eJTgZRqThqNzauMYM5hm2eNevTOb9GGL1yCOFSwIbJ9EmCLhWXJBeXTfQ==
X-Gm-Message-State: AOJu0YzoSS0FJ1SXEv6MY1LgERPnRvKC0Hx8Ol1CnGni9cle38OQEo/O
	iKt2rSKAhYIdBt5XDUwNA2tlwCGR6tueHIBl8fBCkRAlccWub+5EuzR9Hp10WMlE/rvtudmLOv7
	HaA==
X-Google-Smtp-Source: AGHT+IFk7eYL+6vrQYJifJQ2QGJFdPZ/x9sRIPx8+ra6M5qJeWO0gO4hfdcb+sSyaa8EDcRQy1jdz59QZMQ=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:690c:6e09:b0:615:33de:61d5 with SMTP id
 jb9-20020a05690c6e0900b0061533de61d5mr643105ywb.1.1712353279626; Fri, 05 Apr
 2024 14:41:19 -0700 (PDT)
Date: Fri,  5 Apr 2024 21:40:33 +0000
In-Reply-To: <20240405214040.101396-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240405214040.101396-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Message-ID: <20240405214040.101396-6-gnoack@google.com>
Subject: [PATCH v14 05/12] selftests/landlock: Test ioctl(2) and ftruncate(2)
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
index 70a05651619d..84e5477d2e36 100644
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
2.44.0.478.gd926399ef9-goog


