Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07FE113A2F4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 09:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgANI2z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jan 2020 03:28:55 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:52023 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbgANI2y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jan 2020 03:28:54 -0500
Received: by mail-pj1-f68.google.com with SMTP id d15so4018170pjw.1
        for <linux-fsdevel@vger.kernel.org>; Tue, 14 Jan 2020 00:28:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=m9b1pSGH7HLnrN4R5uQS7g3iEVK6O9KHMl/q9QbuZ1w=;
        b=jcuJi1ypFOwjpHWRSddeQAjWzYZhcLk5IP15g9lwCJ78puU7mKb4txavAlytGVva+i
         geyFGWDbJUP+KQHizCaywzmqIH1qo/2GL4ybKfzsgQvqqwKszRYQou6zli4wHOVIKKMb
         eGgfen9r7Fit4VziPAfMGP551b+C+jFWxU4/LInFTU4dHeZbs5QpbzlUmBWlXq6jjK9a
         xGLDjAsm2uLy1qHy+PRH8y+KA+hLHx5VKbuZXJFqprpEY50/IVJp3X7Oyf9O7PCqyB1f
         M8Aavt4E+tOSB0AM9wAYC0MNgDNrPNgxKmlWLknhPrG5jeVZKR5/e64Zy9KwkEbIASmA
         GOiA==
X-Gm-Message-State: APjAAAVNCN6WWVJDDAFvPMXE6jd6BbJoVktDK7auzHhoidnO3nMZkLnt
        /+QeakwltbakRpfHnxpkbkm4obZW
X-Google-Smtp-Source: APXvYqw7ru11ObZIKaVtj/8+xVC/emVMYpXCflhk6fwRmYljmuGZyrmYF0YYoy7cr41TR19l1X2wfA==
X-Received: by 2002:a17:902:758e:: with SMTP id j14mr24243891pll.95.1578990533947;
        Tue, 14 Jan 2020 00:28:53 -0800 (PST)
Received: from resnet-11-27.resnet.ucsb.edu (ResNet-11-27.resnet.ucsb.edu. [169.231.11.27])
        by smtp.gmail.com with ESMTPSA id z64sm17588083pfz.23.2020.01.14.00.28.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jan 2020 00:28:53 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.1\))
Subject: Re: [PATCH v2] vfs: prevent signed overflow by using u64 over loff_t
From:   Saagar Jha <saagar@saagarjha.com>
In-Reply-To: <202001141531.7tVBJ9ap%lkp@intel.com>
Date:   Tue, 14 Jan 2020 00:28:51 -0800
Cc:     kbuild-all@lists.01.org, viro@zeniv.linux.org.uk,
        kbuild test robot <lkp@intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <D0C172BE-3683-4E76-ADE8-F37E4B5B43DA@saagarjha.com>
References: <AECA23B8-C4AC-4280-A709-746DD9FC44F9@saagarjha.com>
 <202001141531.7tVBJ9ap%lkp@intel.com>
To:     linux-fsdevel@vger.kernel.org
X-Mailer: Apple Mail (2.3608.60.0.2.1)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Oops, I accidentally had accidentally added an extra parenthesis to my
patch; sorry about that. I think I fixed the issue now and I added the
"Reported-by" line to the new patch below. Is there anything else I need
to do?

Regards,
Saagar Jha

From 4867a403decc364c8b0f4cb533bce8419e070e06 Mon Sep 17 00:00:00 2001
From: Saagar Jha <saagar@saagarjha.com>
Date: Sun, 12 Jan 2020 21:46:28 -0800
Subject: [PATCH] vfs: prevent signed overflow by using u64 over loff_t

32-bit system calls taking a 64-bit offset that arrive as split over two
32-bit unsigned integers overflow the signed loff_t when shifted over by
32 bits. Using unsigned intermediate types fixes the undefined behavior.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Saagar Jha <saagar@saagarjha.com>
---
 fs/read_write.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 5bbf587f5bc1..0f40eaa6c315 100644
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
+	loff_t pos = ((u64)pos_high << 32) | pos_low;
 
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


