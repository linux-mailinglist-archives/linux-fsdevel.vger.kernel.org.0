Return-Path: <linux-fsdevel+bounces-10999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCB7384FAAB
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 18:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09CC1C27F63
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Feb 2024 17:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4831080C0C;
	Fri,  9 Feb 2024 17:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PUrBSFKu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D98680BFB
	for <linux-fsdevel@vger.kernel.org>; Fri,  9 Feb 2024 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707498402; cv=none; b=R/LPN92cTxZEWzLjx104GH+Jz/t9oxwFY0IU4rPcFGp2EXdZzYcgJHG0DVVH6VAIRTvLyKjObF6/8z7IPW5lI6qTimV7bwt/yUKGs3Nc3yx6+2nuTQBXSiY50fMhykIdic4LYk7k5EICdH+6BqisxXJk55dhI3/9cDavx92uvMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707498402; c=relaxed/simple;
	bh=kk2+83Jnk/yTpdhOZPYnQFVonl0BESaWR3BPYChIpGo=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=K5TrSr+6NR1W/bzXlesjeR1Is/u02bAvbyG+9cXWfoPjIvf9CPvnW9oJXE4ey1ilAB5gB9tmbS2SfLQ6kYBl7vN3RCbMo8h4vGDPYdPpLKysSCt8NM5QlVqLSN6c/4JsImUhtOiiA0PTTsGhJZCJ0ExWSdHtNxB5aWTRCKkXFvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PUrBSFKu; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-604b6d55dfcso13125347b3.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 09 Feb 2024 09:06:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707498399; x=1708103199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNvcTp+W25e9LmdR8XoSXV4JuupjrHIFCzjVXEdIKbc=;
        b=PUrBSFKuoDNUzGb2QRQ6Vxibw3JSbbzRioqrjWO+2tnMkuwnVuoLz+WZsIB+uOklJq
         GyD5Kn7bNGsY9X1z/mMpPYAp/12u5A+RDYiRYfhcf8cminIKLCypJR2E2qFUGvHPWHL1
         hJ8PULr3WoUGz3Bl0HxJ6lvR+5vVEqCJI1+q7rvCeYBhNyfWTA7+umpGLzc1CmxFGLV8
         1lbadfzX5GpD8c8l0wEXslbDchSaLaLxYwUAd4YRbjMCNwGJ+NmfZoGjqIy+uBGnSJKN
         Xkw12tqVq6iMT5XYad7j22dgKTk9OunRk3XnVKeo3QE6AJbE+ww4jB5RhYC9oXkKa/UJ
         elDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707498399; x=1708103199;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yNvcTp+W25e9LmdR8XoSXV4JuupjrHIFCzjVXEdIKbc=;
        b=BVrQqiySmcd3NrsC1YaRRXo8W1FyzNgjZtG9pwehs9uiXBEpyA7ZyUYjH7MCqVz+oc
         OtcHEbpnLUOkBp0YmjQij69w+I4mvax/r0u44pdHorfHi5rTkdDTBTy6xMUWy6ySBpTC
         MB+94+3EGNlDCkg6E1WjaTcuzIIk0xZJBvWeI/BgT3MVFizm59MHlmdhmd7aiNbYe3sW
         pyIM+tCFfMiShI8IEH2lvH2iEy+yn6B/oEDxsCHqc+JDY5o581M33rGdmC16ACAs4HhP
         ZXMKB+7MAkH8qq3v8XbgDwtPRyulxL8o+AThZst3razYq9B1DjEdsMCAOUng8FnUpnnB
         V1BQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG3Dvo7R7wKc7zrHKU/f6MqyZFvyfPU3LY1jW114Tbq8+w22/LImdmWnzhVBpb9I8Eecbh5bW5WR618ApkMaQMbWwxS6G7L//RuAxCtQ==
X-Gm-Message-State: AOJu0YwOlv2bZTO8orErUDLenpKrbJFxgdYKT41cR8HY0/AFu9gAmFk0
	4s63qn83owqV+D9ciidcUXoBkr22DLBDQBNS//iHmIStJWMPx7quqnRlWw6j9MJmqM3pyrhzl97
	pJA==
X-Google-Smtp-Source: AGHT+IGi9LtbBw+CYZHCewjY6wNoK4x/xLKkQhRbDBfeUYmSqdt1T/96Qoe2cp4khXbra13QRVoQehLvfQE=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:3162:977f:c07:bcd8])
 (user=gnoack job=sendgmr) by 2002:a05:690c:4284:b0:604:982c:3c26 with SMTP id
 gj4-20020a05690c428400b00604982c3c26mr292358ywb.3.1707498399274; Fri, 09 Feb
 2024 09:06:39 -0800 (PST)
Date: Fri,  9 Feb 2024 18:06:12 +0100
In-Reply-To: <20240209170612.1638517-1-gnoack@google.com>
Message-Id: <20240209170612.1638517-9-gnoack@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240209170612.1638517-1-gnoack@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Subject: [PATCH v9 8/8] landlock: Document IOCTL support
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
 Documentation/userspace-api/landlock.rst | 121 ++++++++++++++++++++---
 1 file changed, 106 insertions(+), 15 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/users=
pace-api/landlock.rst
index 2e3822677061..a6e55912139b 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -75,7 +75,8 @@ to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_BLOCK |
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
-            LANDLOCK_ACCESS_FS_TRUNCATE,
+            LANDLOCK_ACCESS_FS_TRUNCATE |
+            LANDLOCK_ACCESS_FS_IOCTL,
         .handled_access_net =3D
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
@@ -84,10 +85,10 @@ to be explicit about the denied-by-default access right=
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
@@ -113,6 +114,10 @@ remove access rights which are only supported in highe=
r versions of the ABI.
         ruleset_attr.handled_access_net &=3D
             ~(LANDLOCK_ACCESS_NET_BIND_TCP |
               LANDLOCK_ACCESS_NET_CONNECT_TCP);
+        __attribute__((fallthrough));
+    case 4:
+        /* Removes LANDLOCK_ACCESS_FS_IOCTL for ABI < 5 */
+        ruleset_attr.handled_access_fs &=3D ~LANDLOCK_ACCESS_FS_IOCTL;
     }
=20
 This enables to create an inclusive ruleset that will contain our rules.
@@ -224,6 +229,7 @@ access rights per directory enables to change the locat=
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
@@ -317,18 +323,72 @@ It should also be noted that truncating files does no=
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
+``LANDLOCK_ACCESS_FS_IOCTL`` rights is associated with the newly created f=
ile
+descriptor and will be used for subsequent truncation and ioctl attempts u=
sing
+:manpage:`ftruncate(2)` and :manpage:`ioctl(2)`.  The behavior is similar =
to
+opening a file for reading or writing, where permissions are checked durin=
g
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
+
+Restricting IOCTL commands
+--------------------------
+
+When the ``LANDLOCK_ACCESS_FS_IOCTL`` right is handled, Landlock will rest=
rict
+the invocation of IOCTL commands.  However, to *allow* these IOCTL command=
s
+again, some of these IOCTL commands are then granted through other, preexi=
sting
+access rights.
+
+For example, consider a program which handles ``LANDLOCK_ACCESS_FS_IOCTL``=
 and
+``LANDLOCK_ACCESS_FS_READ_FILE``.  The program *allows*
+``LANDLOCK_ACCESS_FS_READ_FILE`` on a file ``foo.log``.
+
+By virtue of granting this access on the ``foo.log`` file, it is now possi=
ble to
+use common and harmless IOCTL commands which are useful when reading files=
, such
+as ``FIONREAD``.
+
+When both ``LANDLOCK_ACCESS_FS_IOCTL`` and other access rights are
+handled in the ruleset, these other access rights may start governing
+the use of individual IOCTL commands instead of
+``LANDLOCK_ACCESS_FS_IOCTL``.  For instance, if both
+``LANDLOCK_ACCESS_FS_IOCTL`` and ``LANDLOCK_ACCESS_FS_READ_FILE`` are
+handled, allowing ``LANDLOCK_ACCESS_FS_READ_FILE`` will make it
+possible to use ``FIONREAD`` and other IOCTL commands.
+
+The following table illustrates how IOCTL attempts for ``FIONREAD`` are
+filtered, depending on how a Landlock ruleset handles and allows the
+``LANDLOCK_ACCESS_FS_IOCTL`` and ``LANDLOCK_ACCESS_FS_READ_FILE`` rights:
+
++-------------------------+--------------+--------------+--------------+
+|                         | ``FS_IOCTL`` | ``FS_IOCTL`` | ``FS_IOCTL`` |
+|                         | not handled  | handled and  | handled and  |
+|                         |              | allowed      | not allowed  |
++-------------------------+--------------+--------------+--------------+
+| ``FS_READ_FILE``        | allow        | allow        | deny         |
+| not handled             |              |              |              |
++-------------------------+              +--------------+--------------+
+| ``FS_READ_FILE``        |              | allow                       |
+| handled and allowed     |              |                             |
++-------------------------+              +-----------------------------+
+| ``FS_READ_FILE``        |              | deny                        |
+| handled and not allowed |              |                             |
++-------------------------+--------------+-----------------------------+
+
+The full list of IOCTL commands and the access rights which affect them is
+documented below.
=20
 Compatibility
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
@@ -457,6 +517,27 @@ Memory usage
 Kernel memory allocated to create rulesets is accounted and can be restric=
ted
 by the Documentation/admin-guide/cgroup-v1/memory.rst.
=20
+IOCTL support
+-------------
+
+The ``LANDLOCK_ACCESS_FS_IOCTL`` right restricts the use of :manpage:`ioct=
l(2)`,
+but it only applies to newly opened files.  This means specifically that
+pre-existing file descriptors like stdin, stdout and stderr are unaffected=
.
+
+Users should be aware that TTY devices have traditionally permitted to con=
trol
+other processes on the same TTY through the ``TIOCSTI`` and ``TIOCLINUX`` =
IOCTL
+commands.  It is therefore recommended to close inherited TTY file descrip=
tors,
+or to reopen them from ``/proc/self/fd/*`` without the
+``LANDLOCK_ACCESS_FS_IOCTL`` right, if possible.  The :manpage:`isatty(3)`
+function checks whether a given file descriptor is a TTY.
+
+Landlock's IOCTL support is coarse-grained at the moment, but may become m=
ore
+fine-grained in the future.  Until then, users are advised to establish th=
e
+guarantees that they need through the file hierarchy, by only allowing the
+``LANDLOCK_ACCESS_FS_IOCTL`` right on files where it is really harmless.  =
In
+cases where you can control the mounts, the ``nodev`` mount option can hel=
p to
+rule out that device files can be accessed.
+
 Previous limitations
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -494,6 +575,16 @@ bind and connect actions to only a set of allowed port=
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
+:manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL`` access righ=
t.
+
 .. _kernel_support:
=20
 Kernel support
--=20
2.43.0.687.g38aa6559b0-goog


