Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 634A811EA6F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Dec 2019 19:36:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728838AbfLMSgl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Dec 2019 13:36:41 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41220 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfLMSgl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Dec 2019 13:36:41 -0500
Received: by mail-io1-f68.google.com with SMTP id c16so619884ioo.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Dec 2019 10:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fmQ/i8Hv9KuLkHqebIqqpi0bvHKZix85zq5Fj72/GSc=;
        b=xGrEF5HicQOGceBwIlUOAP0NP9x+3itij83BXMCYcjLxd613mMzXkX1g8vFi9WML9F
         EhjouRDmF7zHwuZxV1+ZxUh43UwOCIuxRkyyKbnz0TSgwJDUzGkYP+Z0jqRGDzr9SRd0
         aUqSTXdEdUPBVC83cHZusrnN7POVTuD97s2R9PrtuZRxKZmR7fxC99TX/6i7AoHcejjy
         rd55K2o4bJ7KF2mUmM9sYwwEofP6kOPT6a+X4byGGCTaJS6G3mvHDGIFWcx0psQ43Npn
         vEct+GGmd/T4aPT7wmzRDUkxUNNyTSksUj342AK/vD14n7NWv126LKK59pr3Vvhm0nQ5
         vVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fmQ/i8Hv9KuLkHqebIqqpi0bvHKZix85zq5Fj72/GSc=;
        b=M8Ok+qiKrVizusUMnUfcxoSOUSbXyfkkRIoJLY6kKLsv71/bDY8l0WMBXDBM1tmfD9
         8RU/LnjCiU5LJ2WbXg3Jttao9FAO2RVJ+u4ZBU6d9nfy7u3By0Oq+zhRrD7i8WvmyQPm
         XJmLoHL7mT9gDgy0zp+f5iLjTnTW8UEqq15u6kCpIZT5sBgp2CJXyGnOoMUi7qvo1bsE
         wxj8NtqrctP4C/Lxb6PCJixNdgMXAjgOb9ev2zuBQR55AzXGIerQiqj8NC1RKgtelAs6
         5OZuCWtK5WZSwp2GmgoJj25yWgokBwG/2iD5jJp35vBgFo29lfLOO2hYwiW6oSeBrEAk
         +vqw==
X-Gm-Message-State: APjAAAWw+N21CwdjRkX5m4KUwBnQrHnCCUNBQEAcsmO/9zmJRiOyKUo+
        uOLZxOESMCxIIOIsci5u7oOeDAe2o2/bOQ==
X-Google-Smtp-Source: APXvYqzwM6u0hVV7Go6ppFNmkO3+1q2lXIEXPw9kBKlyzB0CMcc+u/85LdwCV9HsWKqXK/flrtjyXw==
X-Received: by 2002:a6b:f605:: with SMTP id n5mr8172162ioh.61.1576262200820;
        Fri, 13 Dec 2019 10:36:40 -0800 (PST)
Received: from x1.thefacebook.com ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id w24sm2932031ilk.4.2019.12.13.10.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 10:36:39 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/10] fs: make build_open_flags() available internally
Date:   Fri, 13 Dec 2019 11:36:26 -0700
Message-Id: <20191213183632.19441-5-axboe@kernel.dk>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191213183632.19441-1-axboe@kernel.dk>
References: <20191213183632.19441-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a prep patch for supporting non-blocking open from io_uring.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/internal.h | 1 +
 fs/open.c     | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/internal.h b/fs/internal.h
index 315fcd8d237c..001f17815984 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -124,6 +124,7 @@ extern struct file *do_filp_open(int dfd, struct filename *pathname,
 		const struct open_flags *op);
 extern struct file *do_file_open_root(struct dentry *, struct vfsmount *,
 		const char *, const struct open_flags *);
+extern int build_open_flags(int flags, umode_t mode, struct open_flags *op);
 
 long do_sys_ftruncate(unsigned int fd, loff_t length, int small);
 long do_faccessat(int dfd, const char __user *filename, int mode);
diff --git a/fs/open.c b/fs/open.c
index b62f5c0923a8..24cb5d58bbda 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -955,7 +955,7 @@ struct file *open_with_fake_path(const struct path *path, int flags,
 }
 EXPORT_SYMBOL(open_with_fake_path);
 
-static inline int build_open_flags(int flags, umode_t mode, struct open_flags *op)
+inline int build_open_flags(int flags, umode_t mode, struct open_flags *op)
 {
 	int lookup_flags = 0;
 	int acc_mode = ACC_MODE(flags);
-- 
2.24.1

