Return-Path: <linux-fsdevel+bounces-15101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4188C886F8D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 16:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC74C2891BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Mar 2024 15:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BF85677C;
	Fri, 22 Mar 2024 15:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0m7yw4D0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35156770
	for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 15:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711120245; cv=none; b=FlC9fvIqQiok0WvUyhYyEgoOf9sZo3H5ndvUacuwE93+19SKMTQbDAwmqmO31pt9Dox97sRMXenLIYRklazPQ3E9f3UacX60e2vZqxpghxUnMnvo8JdHSTIJD+MVubF9WbtTr1fTAnDJKpvxzSDqFT7tr1EdiigLjPVrUI0AA4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711120245; c=relaxed/simple;
	bh=4g64X2z2I9w1oZROI2GSCgDSQPRm3AXX/Vq984hPUy8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uOCI6Aq83EmYW5grxfhoqoLxv0sygGnjLrQbx2r2UXuXOs91h3FVS846TMAE8dcvyf1SlZudF4ookXAHtERTM4br71LAwtmnDnMG25PuOGe7kX9P03Y7tpYIvwgygNXz8P6fmNpfNltlXyXt9sPbYyFolbAO5TkRqtKbWx9zgW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0m7yw4D0; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-a4488afb812so108113066b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Mar 2024 08:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711120242; x=1711725042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AL+pLtjmOCqOyTizrp229Q3mbwzX+z6isjzKlV0osFY=;
        b=0m7yw4D0krYCO3VRb9/2a3l8Pk/uNe0ufMF0hK/3HJ3hg2tO3ZuIOBe70DyX73T/kx
         XRY1wDlohe6V9hocZYP9Ar20bLmZesIZT5s7JVQvZovi3YId/81IWeaPoG1EXuclpl0b
         NasxomgE+vGhI0uVDaPVBBxKopMZaOy7xKIyL33+FlsafzubXLnic4yb8FGMs7WkQRjG
         SXWJ+GOIA7xRbPMgCIGYUw+mcGtbEEhJ2yFCvVJ7iKEY/uJi5/in0Nus7Fydlr8O5xgD
         hZVZmX1nAsqNDIqSzoGBCDf+ozVQBqdu+5cORdm/ij8IBtShq1SXx3PdENpOojh7NBCx
         WD8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711120242; x=1711725042;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AL+pLtjmOCqOyTizrp229Q3mbwzX+z6isjzKlV0osFY=;
        b=MiFE64m6C6NTMkpt0WU6kA3uIL9SkIuFVF4JQE58A0x3piZ8VuIpsKSekoWdPuEI72
         j6RjTIsq/nqcOHEyD4+k+Bk8+FsKu01L35x5vvQpGoe8/GOzxLeszblRPtFGfoFXyw+L
         KHvnyQ0kJ/VSwHmlPVdxCGkkhQWnaYkmBlkcecN5/x3wRhHSt0+q/Hn0NVWreg1/KW7A
         NYm7fh0ILFNspGAZ8amC3dfu1yB0HQe76z0shuksB10SekhYHQeH7r+rVpSdICODaxVp
         pKrBexTfVyG9STJMgl4UIDC1KanaGe5lr3/97O552MD0rGl2GFt5lALWof1QFDsYzdG9
         V8Xw==
X-Forwarded-Encrypted: i=1; AJvYcCXN+hARys6vP38LTmpsGO/2FZqfTVPvXLinOVxZ+8evse3IlarVTV7hm/iIumql6NhQ/ze5xPAHwVczw2lUplt0TXb+Wro3jFdtf5+qBA==
X-Gm-Message-State: AOJu0YwyCcmUqZqhrm5C7V1Lz/PknPVeo6zpDx25DjcgJxVRlkdxn/xM
	08e8E727fyhX14rVGX65vDYO+hWUHZjM4upxGk9jdYZdcPQA7sNGJySxUUzOeppJ5AqvP8ajPWa
	DjQ==
X-Google-Smtp-Source: AGHT+IG2d2rmjGvZ8L0npAA4kPj345zFaKtlFzju5GVoQKkLNIQahXhY8zVyvi0udqKsdH8/yQOGcOsUFFY=
X-Received: from swim.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:1605])
 (user=gnoack job=sendgmr) by 2002:a17:906:b110:b0:a45:a016:4ea1 with SMTP id
 u16-20020a170906b11000b00a45a0164ea1mr1ejy.13.1711120242064; Fri, 22 Mar 2024
 08:10:42 -0700 (PDT)
Date: Fri, 22 Mar 2024 15:10:02 +0000
In-Reply-To: <20240322151002.3653639-1-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240322151002.3653639-1-gnoack@google.com>
X-Mailer: git-send-email 2.44.0.396.g6e790dbe36-goog
Message-ID: <20240322151002.3653639-10-gnoack@google.com>
Subject: [PATCH v11 9/9] landlock: Document IOCTL support
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

In the paragraph above the fallback logic, use the shorter phrasing
from the landlock(7) man page.

Signed-off-by: G=C3=BCnther Noack <gnoack@google.com>
---
 Documentation/userspace-api/landlock.rst | 76 +++++++++++++++++++-----
 1 file changed, 61 insertions(+), 15 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 9dd636aaa829..145bd869c684 100644
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
2.44.0.396.g6e790dbe36-goog


