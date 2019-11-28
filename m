Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE64110CC59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2019 17:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbfK1P75 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Nov 2019 10:59:57 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35972 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbfK1P74 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Nov 2019 10:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574956795;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wNUceLOrPg3Ojt0+jzV1YE7ipnujQFhaT5nWXOsQUC8=;
        b=YiiZ2ahruH3Qrumm6OkN+xYBbpJW6ckXdmuXyxKwVBzarA2CoN2mx5v4gTPQUjzRcl3Rai
        34nEFFUMHsGRPUWlTHeSNJXZMGj/CyZz/wSKH94JOzQ3jeWPY9IMOxH/YSZkUhJN0gMd7p
        8eX6FNGZBgfm+YHHFSIxtjLkr9bJpTY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-6LABOQRdPdOjV5JHgGlyOA-1; Thu, 28 Nov 2019 10:59:52 -0500
Received: by mail-wr1-f71.google.com with SMTP id c12so12751347wrq.7
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2019 07:59:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6FebG/9swWxaWpyYUPZp3GybSxxVwd4FC4Ek6DX6CHk=;
        b=GugPghNFPuaWha1NTKcWXy6E/XF9lVNrASp0n7WMK9ALvBrcm2RUZs3NiGDyCiy7AD
         G2CY3xqi5CHFzNo7M4EBfjv8fajkhzaEOa2GmQBBre1mK9iWlQLq+Jd/tU+zZsra2sXx
         St4VH4U2/4M4QYyrpCNVKgV6mlWVQVX2KHHFmrVRt1KQPRCVWmKNoQtsQPRioRcb39We
         vEUXX/mXEz4pfSu7ApthMeAqAosbPaeWZWfe6ecyWT9MsoIcecJvEOwoxEb8NmnDDrYZ
         /IUCBZ/LEirsYfFGyi+yEjVLCeSp+ETNtnBUL/lIX0K1UDo+Kdxu23G0bhNsekRRrAqB
         Vg3w==
X-Gm-Message-State: APjAAAU5zUA46uijr743WZ6nUMn3y59pz+lmH/ntduL/15CXJ76bapzr
        3+J8SZIcUqKBG5P5/Q1PrQrkrmxR4DsAqPhkwaKfQ4igBy41Cb4da6OpX1D7+qWq7IqRL+zLMDX
        8zIx1b9oyfQeYcEyYZZafKoa8Uw==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr9469817wrx.147.1574956791688;
        Thu, 28 Nov 2019 07:59:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzIdXC8BX5EGsOQHtObeNRf8i4Cuwph0s8VBTuzdjw7D1anaxGwXrq6M3ONrwiABcsmwrnDJQ==
X-Received: by 2002:a05:6000:149:: with SMTP id r9mr9469808wrx.147.1574956791513;
        Thu, 28 Nov 2019 07:59:51 -0800 (PST)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id 2sm23689474wrq.31.2019.11.28.07.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2019 07:59:50 -0800 (PST)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 07/12] f*xattr: allow O_PATH descriptors
Date:   Thu, 28 Nov 2019 16:59:35 +0100
Message-Id: <20191128155940.17530-8-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128155940.17530-1-mszeredi@redhat.com>
References: <20191128155940.17530-1-mszeredi@redhat.com>
MIME-Version: 1.0
X-MC-Unique: 6LABOQRdPdOjV5JHgGlyOA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This allows xattr ops on symlink/special files referenced by an O_PATH
descriptor without having to play games with /proc/self/fd/NN (which
doesn't work for symlinks anyway).

This capability is the same as would be given by introducing ...at()
variants with an AT_EMPTY_PATH argument.  Looking at getattr/setattr type
syscalls, this is allowed for fstatat() and fchownat(), but not for
fchmodat() and utimensat().  What's the logic?

While this carries a minute risk of someone relying on the property of
xattr syscalls rejecting O_PATH descriptors, it saves the trouble of
introducing another set of syscalls.

Only file->f_path and file->f_inode are accessed in these functions.

Current versions return EBADF, hence easy to detect the presense of this
feature and fall back in case it's missing.

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/xattr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..fd1335b86e60 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -495,7 +495,7 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathnam=
e,
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 =09=09const void __user *,value, size_t, size, int, flags)
 {
-=09struct fd f =3D fdget(fd);
+=09struct fd f =3D fdget_raw(fd);
 =09int error =3D -EBADF;
=20
 =09if (!f.file)
@@ -587,7 +587,7 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathnam=
e,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 =09=09void __user *, value, size_t, size)
 {
-=09struct fd f =3D fdget(fd);
+=09struct fd f =3D fdget_raw(fd);
 =09ssize_t error =3D -EBADF;
=20
 =09if (!f.file)
@@ -662,7 +662,7 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathna=
me, char __user *, list,
=20
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-=09struct fd f =3D fdget(fd);
+=09struct fd f =3D fdget_raw(fd);
 =09ssize_t error =3D -EBADF;
=20
 =09if (!f.file)
@@ -727,7 +727,7 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, path=
name,
=20
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-=09struct fd f =3D fdget(fd);
+=09struct fd f =3D fdget_raw(fd);
 =09int error =3D -EBADF;
=20
 =09if (!f.file)
--=20
2.21.0

