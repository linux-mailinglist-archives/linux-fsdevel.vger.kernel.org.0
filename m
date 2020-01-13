Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE3138BE5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 07:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733238AbgAMGku convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 01:40:50 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:50204 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732311AbgAMGku (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 01:40:50 -0500
Received: by mail-pj1-f68.google.com with SMTP id r67so3731612pjb.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 12 Jan 2020 22:40:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=kExGYfwhBDe/JLj4DdbRd5dLdG+WtWHG09NOf1OYrp8=;
        b=kdKNTPBcT/XbhdvLj8F+kRFyIM9HdahrGcTswK6JxRtZcacD0RwTj1M4ejGayKqi3P
         RRCZKRlKcwu3Fn772o+FYzoGaoqHL0tlJBV8/kgJqOCc9ip1qbTs28mIRgTQMbsEXJY2
         GUmOkpfKqDYSu8bmyseszPJogEBJqUa2KTBrUrEqTpDWe68GNO+MWpAeJp1ZSdZhOIpz
         VUHbgy+kabAZdHJeetZllCJQjywq05SHUChgIcp3qvrl3aVyxI4UPyfqJRMdKFcOs3UP
         3d/x/XHRKuvNdzLl8QOpCE47YRoYzfyo5xNsdIr8igl36fpx1dMuAxnrCermT8SYuXun
         lh3A==
X-Gm-Message-State: APjAAAWVgplnoNVQK2C1vZAgZS+AzzrdZwM6MveI3LrTkKDuSlRurQJH
        bsZYf8fD3q0JpB4pkwLM+xga+Ol+
X-Google-Smtp-Source: APXvYqzvJ9txXYszI0v7n/Igop07YBn8RDNsJPS/SoNYYJO9Kxpia8EBYOmp+M+E0nSJ7PBWYq7wMQ==
X-Received: by 2002:a17:902:708c:: with SMTP id z12mr12217481plk.15.1578897649164;
        Sun, 12 Jan 2020 22:40:49 -0800 (PST)
Received: from resnet-11-27.resnet.ucsb.edu (ResNet-11-27.resnet.ucsb.edu. [169.231.11.27])
        by smtp.gmail.com with ESMTPSA id q22sm12794161pfg.170.2020.01.12.22.40.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jan 2020 22:40:48 -0800 (PST)
From:   Saagar Jha <saagar@saagarjha.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.1\))
Subject: [PATCH] vfs: prevent signed overflow by using u64 over loff_t
Message-Id: <AECA23B8-C4AC-4280-A709-746DD9FC44F9@saagarjha.com>
Date:   Sun, 12 Jan 2020 22:40:47 -0800
Cc:     viro@zeniv.linux.org.uk
To:     linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.1)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

I think I’ve found a signed integer overflow when reconstructing the
64-bit offset from the two 32-bit values syscall arguments, and I believe
the patch below would fix this issue. Unfortunately I don't have in the
way of experience contributing to the kernel, so I would appreciate it if
someone would point out if I should

* not submit this at all,
* submit this somewhere else,
* fix it some other way,
* format this differently,
* test it using some method that I am unaware of,
* or am missing something else in general.

I've tried my best to align with the guidelines but if I've tripped up on
the details I would appreciate guidance on what I should be doing instead.

Thanks,
Saagar Jha

From c3525c7dfb9cede7cc246200ba70455855a3ec8b Mon Sep 17 00:00:00 2001
From: Saagar Jha <saagar@saagarjha.com>
Date: Sun, 12 Jan 2020 21:46:28 -0800
Subject: [PATCH] vfs: prevent signed overflow by using u64 over loff_t

32-bit system calls taking a 64-bit offset that arrive as split over two
32-bit unsigned integers overflow the signed loff_t when shifted over by
32 bits. Using unsigned intermediate types fixes the undefined behavior.

Signed-off-by: Saagar Jha <saagar@saagarjha.com>
---
 fs/read_write.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587f5bc1..3a1dfafcaf65 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -347,7 +347,7 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
 	if (whence > SEEK_MAX)
 		goto out_putf;

-	offset = vfs_llseek(f.file, ((loff_t) offset_high << 32) | offset_low,
+	offset = vfs_llseek(f.file, ((u64) offset_high << 32) | offset_low,
 			whence);

 	retval = (int)offset;
@@ -1250,7 +1250,7 @@ COMPAT_SYSCALL_DEFINE5(preadv, compat_ulong_t, fd,
 		const struct compat_iovec __user *,vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high)
 {
-	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
+	loff_t pos = (((u64)pos_high << 32) | pos_low;

 	return do_compat_preadv64(fd, vec, vlen, pos, 0);
 }
@@ -1272,7 +1272,7 @@ COMPAT_SYSCALL_DEFINE6(preadv2, compat_ulong_t, fd,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high,
 		rwf_t, flags)
 {
-	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
+	loff_t pos = ((u64)pos_high << 32) | pos_low;

 	if (pos == -1)
 		return do_compat_readv(fd, vec, vlen, flags);
@@ -1359,7 +1359,7 @@ COMPAT_SYSCALL_DEFINE5(pwritev, compat_ulong_t, fd,
 		const struct compat_iovec __user *,vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high)
 {
-	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
+	loff_t pos = ((u64)pos_high << 32) | pos_low;

 	return do_compat_pwritev64(fd, vec, vlen, pos, 0);
 }
@@ -1380,7 +1380,7 @@ COMPAT_SYSCALL_DEFINE6(pwritev2, compat_ulong_t, fd,
 		const struct compat_iovec __user *,vec,
 		compat_ulong_t, vlen, u32, pos_low, u32, pos_high, rwf_t, flags)
 {
-	loff_t pos = ((loff_t)pos_high << 32) | pos_low;
+	loff_t pos = ((u64)pos_high << 32) | pos_low;

 	if (pos == -1)
 		return do_compat_writev(fd, vec, vlen, flags);
--
2.24.1

