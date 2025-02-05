Return-Path: <linux-fsdevel+bounces-40984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66788A29B6C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 21:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F360F165532
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 20:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AB92147E3;
	Wed,  5 Feb 2025 20:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b="acSko5Pc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-40136.proton.ch (mail-40136.proton.ch [185.70.40.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D481EE7B3
	for <linux-fsdevel@vger.kernel.org>; Wed,  5 Feb 2025 20:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738788464; cv=none; b=rhA/uTXACvEb/kdBljXowPv61w6PMTi+EAMOu5KFvAKnmeSaiLKrQrdxwK8zB5d4mPUdSm4M7jwX8X/tIfXg0IKwXtlWgDueGYjFF7U/uL/DopZPRXkp2mayeboXVX3U7x3JnQtkqnNRwwzYU6k+o64u6Cg87Ioh5J0CMEeiAgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738788464; c=relaxed/simple;
	bh=OMfQHNHB/80r6eS3wpbY3NXufO3OZxJRL26txj/dVVM=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=CeA9Hopjg4zLR3jqSBZ+j+9NwRJk91NS/2qL/BbdvevQ0Axc4HKotoQqp8pgZsZS6GwTDfYxPh5A7ULRx+XgaA5LiR98xliClnp44FKEU1IBg+SwSCwCqCOxWvrHBQEV6NH/MVL4Lpmv10UbTARlN3f7f8dZCEn9raDkAD6Ofi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com; spf=pass smtp.mailfrom=yhndnzj.com; dkim=pass (2048-bit key) header.d=yhndnzj.com header.i=@yhndnzj.com header.b=acSko5Pc; arc=none smtp.client-ip=185.70.40.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=yhndnzj.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yhndnzj.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yhndnzj.com;
	s=protonmail2; t=1738788452; x=1739047652;
	bh=OMfQHNHB/80r6eS3wpbY3NXufO3OZxJRL26txj/dVVM=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=acSko5PcgTpSp9e6wVuJo77+pZf62hXpDafNmRelFvwVYDjPFM5jbx5BGqHKmvuYg
	 E/1W3zzMFVAbwYOO9lmuIHrzW09/26VHR0ZgEIG/KppdhYNmS7Fd1wDveOSOtOXznl
	 opu4RuBKSCp+TxEnRZ52YcKXubKDkQNvhb1M3pbsJo0y3/lGmCMfKRQBqCiI4hBP5V
	 xeALwxGJD7AzDGf9XYsEG39SRCqVJG8RVnSewfNINa1dGkYU9b0/+225fBammnzAlq
	 RRm+aCR7vkcrfxDiH3ZLilz6Y0Q19WLCKEm/lROTohaCkXzyHuFH40CeY3brhRs4Ab
	 xmYX02J0zAylw==
Date: Wed, 05 Feb 2025 20:47:23 +0000
To: linux-fsdevel@vger.kernel.org
From: Mike Yuan <me@yhndnzj.com>
Cc: Mike Yuan <me@yhndnzj.com>, linux-kernel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, =?utf-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, Christian Brauner <brauner@kernel.org>, stable@vger.kernel.org
Subject: [PATCH] fs/xattr: actually support O_PATH fds in *xattrat() syscalls
Message-ID: <20250205204628.49607-1-me@yhndnzj.com>
Feedback-ID: 102487535:user:proton
X-Pm-Message-ID: fb475632d93aef10901c3530d8491305e77698c7
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cited from commit message of original patch [1]:

> One use case will be setfiles(8) setting SELinux file contexts
> ("security.selinux") without race conditions and without a file
> descriptor opened with read access requiring SELinux read permission.

Also, generally all *at() syscalls operate on O_PATH fds, unlike
f*() ones. Yet the O_PATH fds are rejected by *xattrat() syscalls
in the final version merged into tree. Instead, let's switch things
to CLASS(fd_raw).

Note that there's one side effect: f*xattr() starts to work with
O_PATH fds too. It's not clear to me whether this is desirable
(e.g. fstat() accepts O_PATH fds as an outlier).

[1] https://lore.kernel.org/all/20240426162042.191916-1-cgoettsche@seltendo=
of.de/

Fixes: 6140be90ec70 ("fs/xattr: add *at family syscalls")
Signed-off-by: Mike Yuan <me@yhndnzj.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian G=C3=B6ttsche <cgzones@googlemail.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: <stable@vger.kernel.org>
---
 fs/xattr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 02bee149ad96..15df71e56187 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -704,7 +704,7 @@ static int path_setxattrat(int dfd, const char __user *=
pathname,
=20
 =09filename =3D getname_maybe_null(pathname, at_flags);
 =09if (!filename) {
-=09=09CLASS(fd, f)(dfd);
+=09=09CLASS(fd_raw, f)(dfd);
 =09=09if (fd_empty(f))
 =09=09=09error =3D -EBADF;
 =09=09else
@@ -848,7 +848,7 @@ static ssize_t path_getxattrat(int dfd, const char __us=
er *pathname,
=20
 =09filename =3D getname_maybe_null(pathname, at_flags);
 =09if (!filename) {
-=09=09CLASS(fd, f)(dfd);
+=09=09CLASS(fd_raw, f)(dfd);
 =09=09if (fd_empty(f))
 =09=09=09return -EBADF;
 =09=09return file_getxattr(fd_file(f), &ctx);
@@ -978,7 +978,7 @@ static ssize_t path_listxattrat(int dfd, const char __u=
ser *pathname,
=20
 =09filename =3D getname_maybe_null(pathname, at_flags);
 =09if (!filename) {
-=09=09CLASS(fd, f)(dfd);
+=09=09CLASS(fd_raw, f)(dfd);
 =09=09if (fd_empty(f))
 =09=09=09return -EBADF;
 =09=09return file_listxattr(fd_file(f), list, size);
@@ -1079,7 +1079,7 @@ static int path_removexattrat(int dfd, const char __u=
ser *pathname,
=20
 =09filename =3D getname_maybe_null(pathname, at_flags);
 =09if (!filename) {
-=09=09CLASS(fd, f)(dfd);
+=09=09CLASS(fd_raw, f)(dfd);
 =09=09if (fd_empty(f))
 =09=09=09return -EBADF;
 =09=09return file_removexattr(fd_file(f), &kname);

base-commit: a86bf2283d2c9769205407e2b54777c03d012939
--=20
2.48.1



