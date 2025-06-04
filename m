Return-Path: <linux-fsdevel+bounces-50622-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A34AACE0EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 17:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1699188C5BF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 15:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105FA29116C;
	Wed,  4 Jun 2025 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="SpA45vI3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-4323.protonmail.ch (mail-4323.protonmail.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F8328F950;
	Wed,  4 Jun 2025 15:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749049440; cv=none; b=DXFX7RMpnWZmfJaeU8c18Mmzu1kvTA9QUd2Sbbr3J+j4Qiu07JDvmX769vnrufRNSomY+e1wiJLyh50jGZ8K1y7Irs5bewJqAZfBRaapufHX5qnUe+Pzrg9c2nc+d1QjFuNh3ZCcgOJbc/0+kPEvx6wDqhW6NRtxprt16k4X7Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749049440; c=relaxed/simple;
	bh=CIpzUojtQhvIyp+XnuiKf+nHjc5Qg2ySGvwqy1jh3ks=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P3mqM1uGj4Y/7tLHdI79YjPYv86dPRpaHfr357GPLhKwL/DMAhtficzloyQNWX3kpxJw+FpPPeGPGWfhE56yfIPpvCVvvEIH7nE86mMI8Zxi7F6GjEI8kaELEekfKL5KOBAknqLS+96msR6cvwh2YnZr5g0iUZhSBpdI6K375F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=SpA45vI3; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail3; t=1749049429; x=1749308629;
	bh=CIpzUojtQhvIyp+XnuiKf+nHjc5Qg2ySGvwqy1jh3ks=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=SpA45vI3ZnwLHT6abyQyNe5BGCt6rrUEnuwKqwWLQ3f9/72JVwREmRdA5Wks2jbYe
	 9JNCAT1x14UJPgXDuR4pnG30BCxIi/S3qVJltcoRiFcfhzGwOWZEvRZlSGae7hQF/g
	 UnRrMFKnGnQT0AXnJc4RyzAkF0/TuC9LsmwZTJzLAqZqUbqRnvLw3Q9EZqrXrs3MgF
	 kdOqf3DQ4wKygvHQIBpzmlP7JZlBxWKgmaRFXijAlBSrS3tyv/kCcjIPYapNfjRlng
	 n5DcQQyj9oZDVxf/ySjAf8GPn3O+UJUnERbBmbEYEDhoiJ2AAhJ7xLAtpk0jvOsx9z
	 m64DzRFU6lRLg==
Date: Wed, 04 Jun 2025 15:03:42 +0000
To: linux-fsdevel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Luca Boccassi <luca.boccassi@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] pidfs: never refuse ppid == 0 in PIDFD_GET_INFO
Message-ID: <20250604150238.42664-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: dcdfa44f123118e899d72f662f3bee462608b543
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

In systemd we spotted an issue after switching to ioctl(PIDFD_GET_INFO)
for obtaining pid number the pidfd refers to, that for processes
with a parent from outer pidns PIDFD_GET_INFO unexpectedly yields
-ESRCH [1]. It turned out that there's an arbitrary check blocking
this, which is not really sensible given getppid() happily returns
0 for such processes. Just drop the spurious check and userspace
ought to handle ppid =3D=3D 0 properly everywhere.

[1] https://github.com/systemd/systemd/issues/37715

Fixes: cdda1f26e74b ("pidfd: add ioctl to retrieve pid info")
Signed-off-by: Mike Yuan <me@yhndnzj.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Luca Boccassi <luca.boccassi@gmail.com>
Cc: <stable@vger.kernel.org>
---
 fs/pidfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index c1f0a067be40..69919be1c9d8 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -366,7 +366,7 @@ static long pidfd_info(struct file *file, unsigned int =
cmd, unsigned long arg)
 =09kinfo.pid =3D task_pid_vnr(task);
 =09kinfo.mask |=3D PIDFD_INFO_PID;
=20
-=09if (kinfo.pid =3D=3D 0 || kinfo.tgid =3D=3D 0 || (kinfo.ppid =3D=3D 0 &=
& kinfo.pid !=3D 1))
+=09if (kinfo.pid =3D=3D 0 || kinfo.tgid =3D=3D 0)
 =09=09return -ESRCH;
=20
 copy_out:

base-commit: 5abc7438f1e9d62e91ad775cc83c9594c48d2282
--=20
2.49.0



