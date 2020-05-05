Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129081C524D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 11:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgEEJ7b (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 05:59:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20355 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725766AbgEEJ71 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 05:59:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588672766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXPdPpU//6NLTX0yp76oURrl678mDyxymrzUtOnXBDU=;
        b=RANGwmgPMAJmIgf9ksc/LQwPiDDnALD4DC+JW2okD+e+cYig1Cij8SzkOE8QX+qUJPqIT2
        A9RfLvKOZZSgQL/Q8vI65ZzcOtp8aMkOJ00DY9UbZdJ8zOPnCD/37c4TRRCpo9x6mHJI7y
        +BG3vpXwKdIS2AHiiZaN/ip2AT5vOSc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-YxmsA8lpNVKpRdBwTr9_-A-1; Tue, 05 May 2020 05:59:24 -0400
X-MC-Unique: YxmsA8lpNVKpRdBwTr9_-A-1
Received: by mail-wm1-f70.google.com with SMTP id b203so615350wmd.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 May 2020 02:59:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uXPdPpU//6NLTX0yp76oURrl678mDyxymrzUtOnXBDU=;
        b=qn0Ja+ZRzZQJj6c0LOCP6VM+LwE43BHtzd6dyynHfjq5xtMYZuX6/WJC0kcdmfpBXs
         XnwiZeDRvMdlZjSNLglvKCXuEAx9d5WO3VCCwVAFWJ3E3m75WrXFevSz3B5vFwAD5Ju/
         y+Jpi3ExNZnHa97vtmhs5qJHL2W9SpVRuBj6Ivtp8K4KEOJz3vNXbiDvEV26liPf/2mK
         u31nTEBsctpxc24iasMSjPez4mQWWMwnHUwoEx9uIbBH4Yd/FB0VxQiJKkiWr1Xo+xZb
         07SAkhEt4iicCp1cRgzE7UEpaJ1+radS3aew1WVgLd7vOtg4kab6zoVQaA27buZbKSxr
         1T3g==
X-Gm-Message-State: AGi0PuYTwWCbJoeDe6CehMNWDP5XZHdSDdUneCASC8HPhjvOKRUjPjF/
        3jXCghKyaaSww0luSb3xL4+pl2X3fxHQWD2dwq5C2xQYnCcZ6YeSjRWI1aTSm405J3qqri5xtdR
        XlSbGbodntBgjnZSA3wDjkWapkA==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr2702548wrm.43.1588672763346;
        Tue, 05 May 2020 02:59:23 -0700 (PDT)
X-Google-Smtp-Source: APiQypJqRK1MS4jlWY5wrRzSEFNVi6UndErraZRRBZ6ElvdVgw78BsljCVXnnHyVBCvoB0wglhUmNQ==
X-Received: by 2002:adf:e4cf:: with SMTP id v15mr2702532wrm.43.1588672763129;
        Tue, 05 May 2020 02:59:23 -0700 (PDT)
Received: from miu.piliscsaba.redhat.com (catv-212-96-48-140.catv.broadband.hu. [212.96.48.140])
        by smtp.gmail.com with ESMTPSA id t16sm2862734wmi.27.2020.05.05.02.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 02:59:22 -0700 (PDT)
From:   Miklos Szeredi <mszeredi@redhat.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: [PATCH 05/12] f*xattr: allow O_PATH descriptors
Date:   Tue,  5 May 2020 11:59:08 +0200
Message-Id: <20200505095915.11275-6-mszeredi@redhat.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200505095915.11275-1-mszeredi@redhat.com>
References: <20200505095915.11275-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index e13265e65871..7080bb4f3f14 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -495,7 +495,7 @@ SYSCALL_DEFINE5(lsetxattr, const char __user *, pathname,
 SYSCALL_DEFINE5(fsetxattr, int, fd, const char __user *, name,
 		const void __user *,value, size_t, size, int, flags)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	int error = -EBADF;
 
 	if (!f.file)
@@ -587,7 +587,7 @@ SYSCALL_DEFINE4(lgetxattr, const char __user *, pathname,
 SYSCALL_DEFINE4(fgetxattr, int, fd, const char __user *, name,
 		void __user *, value, size_t, size)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
@@ -662,7 +662,7 @@ SYSCALL_DEFINE3(llistxattr, const char __user *, pathname, char __user *, list,
 
 SYSCALL_DEFINE3(flistxattr, int, fd, char __user *, list, size_t, size)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	ssize_t error = -EBADF;
 
 	if (!f.file)
@@ -727,7 +727,7 @@ SYSCALL_DEFINE2(lremovexattr, const char __user *, pathname,
 
 SYSCALL_DEFINE2(fremovexattr, int, fd, const char __user *, name)
 {
-	struct fd f = fdget(fd);
+	struct fd f = fdget_raw(fd);
 	int error = -EBADF;
 
 	if (!f.file)
-- 
2.21.1

