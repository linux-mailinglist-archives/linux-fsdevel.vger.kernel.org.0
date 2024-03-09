Return-Path: <linux-fsdevel+bounces-14051-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB63876F9F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 08:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 928ED282084
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Mar 2024 07:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEA9383A3;
	Sat,  9 Mar 2024 07:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a9lEBZjN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A652B38396
	for <linux-fsdevel@vger.kernel.org>; Sat,  9 Mar 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709970829; cv=none; b=h1Nmsnaqpi2JiOn+hMsmzL4ExYQt00GYDAzMVBTZTFdyBsBFjS3dwUF4dcIfEQJoLZCoydoFLC+ACL6Xxl4VGO6TYodoFs727Hsq9G7jgIHxSpQj/Thc4wQ0/K1dL8NBgnJnDPp2MemAAb19bw/sjmbvpyemKnSbhbyYNi5mb8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709970829; c=relaxed/simple;
	bh=iNASLIvdJe+G6gv4UkYZwtV4xslMi/uxI/J6OfYzLr4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BW4rm7fv3pDgov68HXuVkyLsLkzvjlLDcFHb0HzU3Kvhbpx1Me/cORYzv7sIvt7ex48SZRjsuS9lL6MZ+UFgHWpJ2i/eyoFHZeqXX3pun2gmk6+3hsG1WtGkxbCEvNIh2lphB85CokBSK9CHwcWag/KwBfb+kA8iq45+GzEEhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a9lEBZjN; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-56800fe8d84so838090a12.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Mar 2024 23:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709970826; x=1710575626; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6xXJZ8Luy05jNZz1hxoLS/0EOiBPDRz4nsKqPpejmYo=;
        b=a9lEBZjNLqLYqxlfU6QcctJoL42PqqBJG/wKXQqzvuPWkiZYDQlW4OKg4gcJcch5OF
         f1eUg7Iz97s9wCTTkO+lyOZZlFom2d5VW2hpgq37yJ/3OQinVK0K/lLlavMhF09mK7ar
         bmyjupsrq2cQCZvvVUUiF4jkOwHShqLUnCLzf62Q1E0hfdBSsq3Rxt3ZccgM2iVbfQO6
         6Rd9hpjoYXNgpKcS/+XZF4FIvgpZ9N/A767hfNfLOaI6RG2HuKYXHoL7FpNwieWn2zn4
         VnJxy0mLlcaikWdfEBMqPAnFGREaRjtqLD5WSMu7jOEUJhID68zcabGmlLjgAcDXSonD
         GlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709970826; x=1710575626;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6xXJZ8Luy05jNZz1hxoLS/0EOiBPDRz4nsKqPpejmYo=;
        b=bIPf6xVou3PkT5JIDtokPr3raWLQkLHQKCrSN7gTWjIYQKs+cMIRy6NtbtX0djs+p9
         Td/hq7jox2GcDGtETycnqqn/6xzNZwGwGerbOC4G22Qq1626mUGq+wGr6fFQ82IQCR0F
         Us2bWaHY9AeM2WvzuIc1GCPxfJG4zkbmeZI0FZhj+glVA0n1Mf4LSI4gGWAPvzoxyfQ8
         rHmjOnnmyzlDoZ6MhhypUGwPJg3HWDXPxyvytYmfvIDVG6O6NVvwpZGwmAreT1hx5M3e
         Jf6KDViI9VckjEQvgbRxbNUInqmJgRn2Z6/o6iprjS5aSOErPEXBJv/YY1fDSfK0cf56
         0+Gw==
X-Forwarded-Encrypted: i=1; AJvYcCVPlLOsWlKmVz8QNugwqQNw4QPwuTtl1U4hqx5qnTypvAXCKvAJLJiBdG6CwzdUr+y89kE1tmF7evDAEcF0dLmhf348vDYp1KteXoeesQ==
X-Gm-Message-State: AOJu0YwQdPhyQWqhfgmevkd9ELD4oWDOyawItLa+u5I05nP2btmy+U8U
	oxs45fmWLeZ4TYJRJQtVFuhM3r4/jtjyRftnxfA5CTQphab4tNIg1RTUJZM08pirDjLcPkygTQT
	95A==
X-Google-Smtp-Source: AGHT+IEB16Vl/CLO+9oSUIXkxJcIHM6QCLqVnsRZhcK17ONeugIEM3ZuOtBIVdNkYYAcgICZia0DsXcQOBc=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a05:6402:f0a:b0:566:c465:20cf with SMTP id
 i10-20020a0564020f0a00b00566c46520cfmr7206eda.1.1709970826003; Fri, 08 Mar
 2024 23:53:46 -0800 (PST)
Date: Sat,  9 Mar 2024 07:53:20 +0000
In-Reply-To: <20240309075320.160128-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240309075320.160128-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240309075320.160128-10-gnoack@google.com>
Subject: [PATCH v10 9/9] landlock: Document IOCTL support
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

In the paragraph above the fallback logic, use the shorter phrasing
from the landlock(7) man page.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 76 +++++++++++++++++++-----
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 838cc27db232..32391247f19a 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -76,7 +76,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
-            LANDLOCK_ACCESS_FS_TRUNCATE,
+            LANDLOCK_ACCESS_FS_TRUNCATE |
+            LANDLOCK_ACCESS_FS_IOCTL_DEV,
         .handled_access_net =3D
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
@@ -85,10 +86,10 @@ to be explicit about the denied-by-default access right=
s.
 Because we may not know on which kernel version an application will be
 executed, it is safer to follow a best-effort security approach.  Indeed, =
we
 should try to protect users as much as possible whatever the kernel they a=
re
-using.  To avoid binary enforcement (i.e. either all security features or
-none), we can leverage a dedicated Landlock command to get the current ver=
sion
-of the Landlock ABI and adapt the handled accesses.  Let's check if we sho=
uld
-remove access rights which are only supported in higher versions of the AB=
I.
+using.
+
+To be compatible with older Linux versions, we detect the available Landlo=
ck ABI
+version, and only use the available subset of access rights:
=20
 .. code-block:: c
=20
@@ -114,6 +115,10 @@ remove access rights which are only supported in highe=
r versions of the ABI.
         ruleset_attr.handled_access_net &=3D
             ~(LANDLOCK_ACCESS_NET_BIND_TCP |
               LANDLOCK_ACCESS_NET_CONNECT_TCP);
+        __attribute__((fallthrough));
+    case 4:
+        /* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
+        ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
     }
=20
 This enables to create an inclusive ruleset that will contain our rules.
@@ -225,6 +230,7 @@ access rights per directory enables to change the locat=
ion of such directory
 without relying on the destination directory access rights (except those t=
hat
 are required for this operation, see ``LANDLOCK_ACCESS_FS_REFER``
 documentation).
+
 Having self-sufficient hierarchies also helps to tighten the required acce=
ss
 rights to the minimal set of data.  This also helps avoid sinkhole directo=
ries,
 i.e.  directories where data can be linked to but not linked from.  Howeve=
r,
@@ -318,18 +324,26 @@ It should also be noted that truncating files does no=
t require the
 system call, this can also be done through :manpage:`open(2)` with the fla=
gs
 ``O_RDONLY | O_TRUNC``.
=20
-When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE=
``
-right is associated with the newly created file descriptor and will be use=
d for
-subsequent truncation attempts using :manpage:`ftruncate(2)`.  The behavio=
r is
-similar to opening a file for reading or writing, where permissions are ch=
ecked
-during :manpage:`open(2)`, but not during the subsequent :manpage:`read(2)=
` and
+The truncate right is associated with the opened file (see below).
+
+Rights associated with file descriptors
+---------------------------------------
+
+When opening a file, the availability of the ``LANDLOCK_ACCESS_FS_TRUNCATE=
`` and
+``LANDLOCK_ACCESS_FS_IOCTL_DEV`` rights is associated with the newly creat=
ed
+file descriptor and will be used for subsequent truncation and ioctl attem=
pts
+using :manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is si=
milar
+to opening a file for reading or writing, where permissions are checked du=
ring
+:manpage:`open(2)`, but not during the subsequent :manpage:`read(2)` and
 :manpage:`write(2)` calls.
=20
-As a consequence, it is possible to have multiple open file descriptors fo=
r the
-same file, where one grants the right to truncate the file and the other d=
oes
-not.  It is also possible to pass such file descriptors between processes,
-keeping their Landlock properties, even when these processes do not have a=
n
-enforced Landlock ruleset.
+As a consequence, it is possible that a process has multiple open file
+descriptors referring to the same file, but Landlock enforces different th=
ings
+when operating with these file descriptors.  This can happen when a Landlo=
ck
+ruleset gets enforced and the process keeps file descriptors which were op=
ened
+both before and after the enforcement.  It is also possible to pass such f=
ile
+descriptors between processes, keeping their Landlock properties, even whe=
n some
+of the involved processes do not have an enforced Landlock ruleset.
=20
 Compatibility
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -458,6 +472,28 @@ Memory usage
 Kernel memory allocated to create rulesets is accounted and can be restric=
ted
 by the Documentation/admin-guide/cgroup-v1/memory.rst.
=20
+IOCTL support
+-------------
+
+The ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right restricts the use of
+:manpage:`ioctl(2)`, but it only applies to *newly opened* device files.  =
This
+means specifically that pre-existing file descriptors like stdin, stdout a=
nd
+stderr are unaffected.
+
+Users should be aware that TTY devices have traditionally permitted to con=
trol
+other processes on the same TTY through the ``TIOCSTI`` and ``TIOCLINUX`` =
IOCTL
+commands.  Both of these require ``CAP_SYS_ADMIN`` on modern Linux systems=
, but
+the behavior is configurable for ``TIOCSTI``.
+
+On older systems, it is therefore recommended to close inherited TTY file
+descriptors, or to reopen them from ``/proc/self/fd/*`` without the
+``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right, if possible.
+
+Landlock's IOCTL support is coarse-grained at the moment, but may become m=
ore
+fine-grained in the future.  Until then, users are advised to establish th=
e
+guarantees that they need through the file hierarchy, by only allowing the
+``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right on files where it is really require=
d.
+
 Previous limitations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -495,6 +531,16 @@ bind and connect actions to only a set of allowed port=
s thanks to the new
 ``LANDLOCK_ACCESS_NET_BIND_TCP`` and ``LANDLOCK_ACCESS_NET_CONNECT_TCP``
 access rights.
=20
+IOCTL (ABI < 5)
+---------------
+
+IOCTL operations could not be denied before the fifth Landlock ABI, so
+:manpage:`ioctl(2)` is always allowed when using a kernel that only suppor=
ts an
+earlier ABI.
+
+Starting with the Landlock ABI version 5, it is possible to restrict the u=
se of
+:manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` access =
right.
+
 .. _kernel_support:
=20
 Kernel support
--=20
2.44.0.278.ge034bb2e1d-goog


