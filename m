Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45316403270
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Sep 2021 04:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234672AbhIHCEw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 22:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234035AbhIHCEq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 22:04:46 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73940C061575
        for <linux-fsdevel@vger.kernel.org>; Tue,  7 Sep 2021 19:03:39 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id e20so438279uam.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 Sep 2021 19:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=TUZehpOFPB3yt5leMr/6/OazC7wLvc9Jvehr8v/eUuk=;
        b=Y1CH3lSw9UgJvVw3t0qpwGhAZfm+rgf3BezmCEdeeHItVqdPybSO/BLlStNu03cg0T
         sdvmZmItVX76yO6Y7b5rw5Vo4b+JMBIuY7Fw/A75r/bBWwC7Pr6x3xilpBTBcC1jGtaR
         AYF5tnzFqEULdSelr0QrfYx1tawTtsWR7qjSh4Y8P9N4dvQ3poqPdCBHD6mgAWcGgoda
         E03hc3aCjR05vPIOZHzXsGhm+PKA5D5nz1f2ki9LVw0s+LAD9UqgLuVzfIXilWIDnASk
         Cit7jlvEpD3eLeVOTAq7FqSKS27aKqRh0rDDIRjhPCtQP2G7kv0rM91dkUsYyDVv2ATi
         F++Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=TUZehpOFPB3yt5leMr/6/OazC7wLvc9Jvehr8v/eUuk=;
        b=Jf5EUUSehX2pqC6d4jCvEwhBgXXo+Vz+PL6xubsRmkgJ+zHY6aGspxBwMuL7XAtltJ
         cuXME9C+e5c/uysxTkzIK2709vHX6/Iz4TzJETxV8hPKAS52ftAKsXKZ/fS1GkzlXwXf
         pUhp91/pGQKFEIVLjvtGYfYuM/BSBI43J/HP+6pDWFcWKhv2mkW5rHElk2w1DeEA343f
         m4XVf4U9dCnF2YVyfikZxrzPcwIzaqFOd9jLsU0QQtW3SeI5qEvT7w6FQPBsnfpaZwxP
         Il259coHeeXUrBm4BemSZ+11gQPupinSNIG546VZ39g94Uata53RAKSPGC0xzrgT6LKd
         YkkQ==
X-Gm-Message-State: AOAM53126TU2udFUSSeJTJ0i+eyU/hVZAhvxl+v7OYGW3pSQ2CpAM+Aw
        hnotwYvCdAK0SdyeuBJ0vDcO8zAX84T36OfPSpySNNIuotlcxg==
X-Google-Smtp-Source: ABdhPJw+4rSBg7b39xZMWMwmYtzvG9uz6IdRyGKCFR00M3utMsTShbkHd7NR8vrMvRQoGFjButN0lFTGt/49tH4IWxw=
X-Received: by 2002:ab0:2755:: with SMTP id c21mr835497uap.68.1631066618380;
 Tue, 07 Sep 2021 19:03:38 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Peng <flyingpenghao@gmail.com>
Date:   Wed, 8 Sep 2021 10:03:10 +0800
Message-ID: <CAPm50a+MKpDFSoNr9gtYRaE4FQgeihpvc6NDdcs8za8X1ZVQGQ@mail.gmail.com>
Subject: [PATCH v2] fuse: Use kmap_local_page()
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From : Peng Hao <flyingpeng@tencent.com>

Due to the introduction of kmap_local_*, the storage of slots
used for short-term mapping has changed from per-CPU to per-thread.
kmap_atomic() disable preemption, while kmap_local_*() only disable
migration.
There is no need to disable preemption in several kamp_atomic
places used in fuse.
The detailed introduction of kmap_local_*d can be found here:
https://lwn.net/Articles/836144/

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 fs/fuse/dev.c     | 8 ++++----
 fs/fuse/ioctl.c   | 4 ++--
 fs/fuse/readdir.c | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
index dde341a6388a..491c092d427b 100644
--- a/fs/fuse/dev.c
+++ b/fs/fuse/dev.c
@@ -756,7 +756,7 @@ static int fuse_copy_do(struct fuse_copy_state
*cs, void **val, unsigned *size)
 {
        unsigned ncpy = min(*size, cs->len);
        if (val) {
-               void *pgaddr = kmap_atomic(cs->pg);
+               void *pgaddr = kmap_local_page(cs->pg);
                void *buf = pgaddr + cs->offset;

                if (cs->write)
@@ -764,7 +764,7 @@ static int fuse_copy_do(struct fuse_copy_state
*cs, void **val, unsigned *size)
                else
                        memcpy(*val, buf, ncpy);

-               kunmap_atomic(pgaddr);
+               kunmap_local(pgaddr);
                *val += ncpy;
        }
        *size -= ncpy;
@@ -949,10 +949,10 @@ static int fuse_copy_page(struct fuse_copy_state
*cs, struct page **pagep,
                        }
                }
                if (page) {
-                       void *mapaddr = kmap_atomic(page);
+                       void *mapaddr = kmap_local_page(page);
                        void *buf = mapaddr + offset;
                        offset += fuse_copy_do(cs, &buf, &count);
-                       kunmap_atomic(mapaddr);
+                       kunmap_local(mapaddr);
                } else
                        offset += fuse_copy_do(cs, NULL, &count);
        }
diff --git a/fs/fuse/ioctl.c b/fs/fuse/ioctl.c
index 546ea3d58fb4..fbc09dab1f85 100644
--- a/fs/fuse/ioctl.c
+++ b/fs/fuse/ioctl.c
@@ -286,11 +286,11 @@ long fuse_do_ioctl(struct file *file, unsigned
int cmd, unsigned long arg,
                    in_iovs + out_iovs > FUSE_IOCTL_MAX_IOV)
                        goto out;

-               vaddr = kmap_atomic(ap.pages[0]);
+               vaddr = kmap_local_page(ap.pages[0]);
                err = fuse_copy_ioctl_iovec(fm->fc, iov_page, vaddr,
                                            transferred, in_iovs + out_iovs,
                                            (flags & FUSE_IOCTL_COMPAT) != 0);
-               kunmap_atomic(vaddr);
+               kunmap_local(vaddr);
                if (err)
                        goto out;

diff --git a/fs/fuse/readdir.c b/fs/fuse/readdir.c
index bc267832310c..e38ac983435a 100644
--- a/fs/fuse/readdir.c
+++ b/fs/fuse/readdir.c
@@ -76,11 +76,11 @@ static void fuse_add_dirent_to_cache(struct file *file,
            WARN_ON(fi->rdc.pos != pos))
                goto unlock;

-       addr = kmap_atomic(page);
+       addr = kmap_local_page(page);
        if (!offset)
                clear_page(addr);
        memcpy(addr + offset, dirent, reclen);
-       kunmap_atomic(addr);
+       kunmap_local(addr);
        fi->rdc.size = (index << PAGE_SHIFT) + offset + reclen;
        fi->rdc.pos = dirent->off;
 unlock:
--
2.27.0
