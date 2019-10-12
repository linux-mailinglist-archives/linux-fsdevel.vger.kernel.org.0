Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C537D4D93
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2019 08:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbfJLGeG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 12 Oct 2019 02:34:06 -0400
Received: from mail-wr1-f52.google.com ([209.85.221.52]:35380 "EHLO
        mail-wr1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbfJLGeG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 12 Oct 2019 02:34:06 -0400
Received: by mail-wr1-f52.google.com with SMTP id v8so14069188wrt.2;
        Fri, 11 Oct 2019 23:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=yX5F7UQ9XF6+RagIHPxa9+er8AVmn045CyrMl3Uj8II=;
        b=vZ8xgYMuZtf2K6miCpSfiKIWBcIiN4f7xMdAW1E/JFPPSxKimGzy/nt9SZ4EclWSCr
         SiN7qQp2vPL+aLEYATYMY0pdwhIFnMLdxAzKrJAh9V/Xyx6aoo0B9WtfdS8vOJIZWK2z
         e8UnoGVRDABmn4L6EWMrzibBdrpT81TWNJNWCx1s0pIwLSQHfpBQA5WZRzYtfduvVJlz
         guQU4qV7oBxclyYwDyMh/4yO/EXH45+18IHMAOS021i57nr14Um7CUXucOmjIvxPGT5R
         G1Qkvss+BjCKBorwBFcTIinWuFamTzdlFmBuy6PPAc6Q+qWiBcafrMdFifi6wo6yriU9
         0ssg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=yX5F7UQ9XF6+RagIHPxa9+er8AVmn045CyrMl3Uj8II=;
        b=BeIVaaggx2YCZUHmWlBHTeRbke2hph4aLy92qk3NNYO+09ITp8HGdD+s/ULzXLglch
         ugQJnPRGLYCt2iPhzgOGn9lTCQ9xM4xKtUoww6HM6EYReoWq5yytVxW6yNKIej42uXkE
         N16GRzbJFpaff9A8vLIUdQApREngG4wdcDqvJguwAgUvIKG3dRNFrSqQunhvwL4h2sj1
         uYp5IClHLD8e2ZjeHrrc2h8dgzQtduna63LQeZ5QLUomqCOxNoZwesKH8N810r7KtNQZ
         R0EjEqeCTLJoJSZVROs2GC8S+C13Dva94Q1qRPm6dgYqaLJgukGfXQRnZ6VMzqIKrEAA
         lYgg==
X-Gm-Message-State: APjAAAXHsgNrMcWYsL5hLHIwMu5a22We5MGg7iwy8eurvGFlaOWd/YSY
        85slG7bQI0WTVEUmg1dveDgcxwqFg8Wrzkcl87bKL6Pkid0=
X-Google-Smtp-Source: APXvYqw/sLpBqdBHOPU9qSM2L8NublyOyWrSLwEFjTf+YsKt7TtPut7dovRhNhmqzW2j39UQAjzxVd9jsFKttBMVXNg=
X-Received: by 2002:a5d:638b:: with SMTP id p11mr10510005wru.372.1570862043467;
 Fri, 11 Oct 2019 23:34:03 -0700 (PDT)
MIME-Version: 1.0
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Sat, 12 Oct 2019 14:33:36 +0800
Message-ID: <CAP9B-QmQ-mbWgJwEWrVOMabsgnPwyJsxSQbMkWuFk81-M4dRPQ@mail.gmail.com>
Subject: [Project Quota]file owner could change its project ID?
To:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Andreas Dilger <adilger@dilger.ca>, Li Xi <lixi@ddn.com>,
        Wang Shilong <wshilong@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Steps to reproduce:
[wangsl@localhost tmp]$ mkdir project
[wangsl@localhost tmp]$ lsattr -p project -d
    0 ------------------ project
[wangsl@localhost tmp]$ chattr -p 1 project
[wangsl@localhost tmp]$ lsattr -p -d project
    1 ------------------ project
[wangsl@localhost tmp]$ chattr -p 2 project
[wangsl@localhost tmp]$ lsattr -p -d project
    2 ------------------ project
[wangsl@localhost tmp]$ df -Th .
Filesystem     Type  Size  Used Avail Use% Mounted on
/dev/sda3      xfs    36G  4.1G   32G  12% /
[wangsl@localhost tmp]$ uname -r
5.4.0-rc2+

As above you could see file owner could change project ID of file its self.
As my understanding, we could set project ID and inherit attribute to account
Directory usage, and implement a similar 'Directory Quota' based on this.

But Directories could easily break this limit by change its file to
other project ID.

And we used vfs_ioc_fssetxattr_check() to only allow init userspace to
change project quota:

        /*

         * Project Quota ID state is only allowed to change from within the init

         * namespace. Enforce that restriction only if we are trying to change

         * the quota ID state. Everything else is allowed in user namespaces.

         */

        if (current_user_ns() != &init_user_ns) {

                if (old_fa->fsx_projid != fa->fsx_projid)

                        return -EINVAL;

                if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &

                                FS_XFLAG_PROJINHERIT)

                        return -EINVAL;

        }

Shall we have something like following to limit admin change for
Project state too?

diff --git a/fs/inode.c b/fs/inode.c

index fef457a42882..3e324931ee84 100644

--- a/fs/inode.c

+++ b/fs/inode.c

@@ -2273,7 +2273,7 @@ int vfs_ioc_fssetxattr_check(struct inode
*inode, const struct fsxattr *old_fa,

         * namespace. Enforce that restriction only if we are trying to change

         * the quota ID state. Everything else is allowed in user namespaces.

         */

-       if (current_user_ns() != &init_user_ns) {

+       if (current_user_ns() != &init_user_ns || !capable(CAP_SYS_ADMIN)){

                if (old_fa->fsx_projid != fa->fsx_projid)

                        return -EINVAL;

                if ((old_fa->fsx_xflags ^ fa->fsx_xflags) &
