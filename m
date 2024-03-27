Return-Path: <linux-fsdevel+bounces-15428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCE0088E686
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 15:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 542541F30CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Mar 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87300156F41;
	Wed, 27 Mar 2024 13:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ldoDiu0k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706C513A411
	for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 13:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711545060; cv=none; b=m1FNQJaf7wI65cZWZmKPxprDwQFiT5x+NiHeNIU8YkSPt0FHlEf8jYPp7+kL89LpI7rCv8npbmv+WEiLsiCHxSKkGMC0sByyX/kqeNcVVn1cWJfBZli+hfy5Xv/fhs3IaNjcaZN7YPZXuTGnwRQxOu0fb3uGT2Vpi917aLjs4vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711545060; c=relaxed/simple;
	bh=Zr/KugKji7M81YV0YKphEwA77inYy4yJELp0VfE8Ads=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qNQUQQEKGQIqkeyrkv5foxiGcRmxecSlpWYUrI5iuEzOOYABWeJseDyT1eBd8iHchhzsJ1ZPX2U496NIJWhJumuNSP9wSKCR34NpI9MRJHVoUZDXERZVkFMqG23mzsZR/n1HOXkijA+30OiZoMzE5RI8fi2KLaismT0r3dc5mww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ldoDiu0k; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-56bf8c6d3e8so1544999a12.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 27 Mar 2024 06:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711545057; x=1712149857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YxZd2chnrRI0sO2yw3frYH98RG2jgZqJMfn25Lxv/84=;
        b=ldoDiu0k6iYKezlkQHYWInN8CmxmufJ0gbQhQHFe/T3ZGzOl1FFbttQhR/1cxjPb3A
         Ng1uggj6s/hIPycugpfJolNTJjQw0rzgKppmFBe4y0gFT/SECd6jBMo7iXI5ogqQrpMt
         L2UDRclafmIROS2zbpvcdbGwK/u1D6+xPqwqzYh/eZOovZLDsf1LpmLP3PlyGiqS5qfM
         sDWkkecOnV9hVr3I1t9PmQ9LEQrzi6unwsIEHkjH8V1SriKqyPhowCeWKIYsJm+FVc0S
         a6aYNfxQ/DzbTS230QQbqsJzoB7EVKLZJARln2heSSl/fLwiDlzFhOHNSmuBAReVN3qo
         W/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711545057; x=1712149857;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YxZd2chnrRI0sO2yw3frYH98RG2jgZqJMfn25Lxv/84=;
        b=VA6J7QQahSajzA5xTOnGwYv5knLB6sbvFe/iD9JbJxn67k+TEI6nyAN+gIVO/8VBX1
         J76nb9YnQM+5h/jV97dgIiFqpFrLUa9f7zv3GS9qW1dtfNHrps5n1H/kQznl3L6mAKvd
         Wa27CYmXAycDgoqNJgU0+0kT9GVHZnzbvFP30IMt9wLQ1YWBRpmTqgVqJxFdQ4oj6h+h
         huJrzkkiqDOa6zVmxeSWQ/iueTvnDv3sX02uM95oz5XazXrZyDEFUbhQaCk76pOl66k3
         3KcSqqAvMnKWSw2L7U2qBlfbuI+2UM2XzvcTCGqE/LDhsirVHyZhvdVncW3ZnnjkXeyE
         msrw==
X-Forwarded-Encrypted: i=1; AJvYcCXEEpfK1sM/n+e5hdrVvJkJShdrZLcqfwyYiHgOrGdPEU6HKVLW+BBheWcCALgVz3q/skq0o/Je3Uyn4WjnXwm8Py/VMDBoNxyfXBD/Tg==
X-Gm-Message-State: AOJu0Yzcvf78vwEKdSXq38Dki3OAsYvT8PqvN9bP0wn+jTJku0NJd8HD
	Q+9pTGXyFLkx+G6esylJpOoHqN1/0fqSWoHNlqh3NueOZgkIyBl65tDTC/Kn/wr0zdA4n/KEQmd
	MQw==
X-Google-Smtp-Source: AGHT+IEyERHUzZYUEW4wsuYmT/QMoXMJb8gsnPI5fBkTu8JdO+5jJ3w6Ubp/UtdYTHVmNiRJGPSmvz/o26g=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:3809:b0:568:d696:6871 with SMTP id
 es9-20020a056402380900b00568d6966871mr91147edb.6.1711545056629; Wed, 27 Mar
 2024 06:10:56 -0700 (PDT)
Date: Wed, 27 Mar 2024 13:10:35 +0000
In-Reply-To: <20240327131040.158777-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240327131040.158777-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240327131040.158777-6-gnoack@google.com>
Subject: [PATCH v13 05/10] selftests/landlock: Test IOCTLs on named pipes
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

Named pipes should behave like pipes created with pipe(2),
so we don't want to restrict IOCTLs on them.

Suggested-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 tools/testing/selftests/landlock/fs_test.c | 43 ++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/sel=
ftests/landlock/fs_test.c
index 84e5477d2e36..215f0e8bcd69 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -3935,6 +3935,49 @@ TEST_F_FORK(layout1, o_path_ftruncate_and_ioctl)
 	ASSERT_EQ(0, close(fd));
 }
=20
+/*
+ * Named pipes are not governed by the LANDLOCK_ACCESS_FS_IOCTL_DEV right,
+ * because they are not character or block devices.
+ */
+TEST_F_FORK(layout1, named_pipe_ioctl)
+{
+	pid_t child_pid;
+	int fd, ruleset_fd;
+	const char *const path =3D file1_s1d1;
+	const struct landlock_ruleset_attr attr =3D {
+		.handled_access_fs =3D LANDLOCK_ACCESS_FS_IOCTL_DEV,
+	};
+
+	ASSERT_EQ(0, unlink(path));
+	ASSERT_EQ(0, mkfifo(path, 0600));
+
+	/* Enables Landlock. */
+	ruleset_fd =3D landlock_create_ruleset(&attr, sizeof(attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* The child process opens the pipe for writing. */
+	child_pid =3D fork();
+	ASSERT_NE(-1, child_pid);
+	if (child_pid =3D=3D 0) {
+		fd =3D open(path, O_WRONLY);
+		close(fd);
+		exit(0);
+	}
+
+	fd =3D open(path, O_RDONLY);
+	ASSERT_LE(0, fd);
+
+	/* FIONREAD is implemented by pipefifo_fops. */
+	EXPECT_EQ(0, test_fionread_ioctl(fd));
+
+	ASSERT_EQ(0, close(fd));
+	ASSERT_EQ(0, unlink(path));
+
+	ASSERT_EQ(child_pid, waitpid(child_pid, NULL, 0));
+}
+
 /* clang-format off */
 FIXTURE(ioctl) {};
=20
--=20
2.44.0.396.g6e790dbe36-goog


