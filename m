Return-Path: <linux-fsdevel+bounces-28907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BE197060B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 11:26:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7A1E1C20E5D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  8 Sep 2024 09:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156791482E2;
	Sun,  8 Sep 2024 09:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/KW/9hU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26841B85DC;
	Sun,  8 Sep 2024 09:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725787589; cv=none; b=X9qnljPXQMKkyC/R8wV7+32gre9YT77ObC4d4zHZezU+iApBh2traGpMuvfy6wYcMVyGW4FUv0JZbtBN5lUzpfScFeyRQVQxVwwrll0QNikZoAkpVCX51gzWqEHONcyzcNSLDmZs/vwAJSD/QckwpoN+h61XdcMMLQloNRxpsN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725787589; c=relaxed/simple;
	bh=Kxu9i6PNiCM8oPUbEm2/QHZnTkSNpT8ECa0mt7bg+jA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=d6F/GkOqkYl0l16obis5PA61w7NUiIT16sbLgTQLXg/h7Nsujsr0pCwLzAqyZhM8QDPDERrEZNO6n6Iv9+kN183bh7yMH8HVfB6gAVo3jCwHr56O0lUYHbuT5mNsw8BBqbywjnVURziXDUOIYXg2FEe7C3ie+VZkA1fbjr1jKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/KW/9hU; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f759688444so12003941fa.1;
        Sun, 08 Sep 2024 02:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725787586; x=1726392386; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q9pH1lZTjkouoeocbR6eQCZHuEEIKemLRYYxwu2KQBs=;
        b=K/KW/9hUzewpmdmLM8Iplf7s5Cws+4ZWlyImZac+JkPYsnnNtaMiRGZF8eroOSdSlC
         3px6L3rJfpX0eWgBKCYojYGXURlomz8HK36SSU0VRH9YMae/G5a4a7gpDaoy8/HQtM9X
         vwZ1DlDRNWBrN6xyMW0cBfl/Va3jBld2D3HtB8wUZRTvnOh6t011qmCrfWYSFGE6R6v3
         vgq1WU6zUPxq78O3mkSu2vJjmqf58/4kfGwV+JPrB8Z6S7OkAwVnhfwEbare0ufYgAqT
         karPuod3oE6jhTZpHIaFu0v34r29oi5y3/XATe4oygYzhUdlt7JbDnEeNWGiGkDPaB4+
         1Rug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725787586; x=1726392386;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q9pH1lZTjkouoeocbR6eQCZHuEEIKemLRYYxwu2KQBs=;
        b=pWq5YjYhh0uesIwGFL00sWVmEgyaOA3a9Y3cJlIq8/QZr1NH5L3Q+KEwxCN0hJLFGW
         UkGP/W0IrEXncWQLhiAkKd6tA1Md15HgG8pj22og02ykWkgJ2n+5yXprFWxsX3qPMAdb
         z2IbrHwyuBqJ9LfRb1F6OV/m8aj4C6+b6Ducomtn3yeEWpcCD9cLTqF3sEzGYGzyA9Gm
         JOSK7jwoFz4rba15iQKaC60SUxVzTVIt7asm2a5e/xQLn+w414xLigva8Q4bt5I60Lhd
         1axADKnAMD9vMTZ52+dsuIrA97x9TJYLZHLJHCqbqJWbdahwu4bbWGvAs8JTpAkPU5LH
         TRfw==
X-Forwarded-Encrypted: i=1; AJvYcCX+TAd+wI3iKd1FfZYPxXPpUA0/JWUKLc+kDbEK3KdDm47fncxfmfMEZUKqJj2jFQWNgEtyLMGuoUW57AOp@vger.kernel.org
X-Gm-Message-State: AOJu0Yxq1FxuH/Xt93HsYKCu+qUkoDpSymlKSS7SBKZTxsTkCrYLAsrN
	7mjZnxv5uM80ToOLm+76PLiJ3NruwtS6GrGn0ZQUHHSNm27X7GB9XBY/
X-Google-Smtp-Source: AGHT+IGFJ60pS9WdXqEhObFpb6GDkX3qaXTzcW63DPkKf/MCB10B0KGC9vonCD18p7zGwsubAu543A==
X-Received: by 2002:a2e:8250:0:b0:2ef:2d3a:e70a with SMTP id 38308e7fff4ca-2f751ef7588mr42783551fa.18.1725787585316;
        Sun, 08 Sep 2024 02:26:25 -0700 (PDT)
Received: from p183 ([46.53.251.102])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c3ebd46909sm1707036a12.25.2024.09.08.02.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Sep 2024 02:26:24 -0700 (PDT)
Date: Sun, 8 Sep 2024 12:26:22 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] proc: use __auto_type more
Message-ID: <81bf02fd-8724-4f4d-a2bb-c59620b7d716@p183>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Switch away from quite chatty declarations using typeof_member().

In theory this is faster to compile too because there is no macro
expansion and there is less type checking.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/proc/inode.c |   31 ++++++++-----------------------
 1 file changed, 8 insertions(+), 23 deletions(-)

--- a/fs/proc/inode.c
+++ b/fs/proc/inode.c
@@ -303,9 +303,7 @@ static ssize_t proc_reg_read_iter(struct kiocb *iocb, struct iov_iter *iter)
 
 static ssize_t pde_read(struct proc_dir_entry *pde, struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	typeof_member(struct proc_ops, proc_read) read;
-
-	read = pde->proc_ops->proc_read;
+	__auto_type read = pde->proc_ops->proc_read;
 	if (read)
 		return read(file, buf, count, ppos);
 	return -EIO;
@@ -327,9 +325,7 @@ static ssize_t proc_reg_read(struct file *file, char __user *buf, size_t count,
 
 static ssize_t pde_write(struct proc_dir_entry *pde, struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 {
-	typeof_member(struct proc_ops, proc_write) write;
-
-	write = pde->proc_ops->proc_write;
+	__auto_type write = pde->proc_ops->proc_write;
 	if (write)
 		return write(file, buf, count, ppos);
 	return -EIO;
@@ -351,9 +347,7 @@ static ssize_t proc_reg_write(struct file *file, const char __user *buf, size_t
 
 static __poll_t pde_poll(struct proc_dir_entry *pde, struct file *file, struct poll_table_struct *pts)
 {
-	typeof_member(struct proc_ops, proc_poll) poll;
-
-	poll = pde->proc_ops->proc_poll;
+	__auto_type poll = pde->proc_ops->proc_poll;
 	if (poll)
 		return poll(file, pts);
 	return DEFAULT_POLLMASK;
@@ -375,9 +369,7 @@ static __poll_t proc_reg_poll(struct file *file, struct poll_table_struct *pts)
 
 static long pde_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	typeof_member(struct proc_ops, proc_ioctl) ioctl;
-
-	ioctl = pde->proc_ops->proc_ioctl;
+	__auto_type ioctl = pde->proc_ops->proc_ioctl;
 	if (ioctl)
 		return ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -400,9 +392,7 @@ static long proc_reg_unlocked_ioctl(struct file *file, unsigned int cmd, unsigne
 #ifdef CONFIG_COMPAT
 static long pde_compat_ioctl(struct proc_dir_entry *pde, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	typeof_member(struct proc_ops, proc_compat_ioctl) compat_ioctl;
-
-	compat_ioctl = pde->proc_ops->proc_compat_ioctl;
+	__auto_type compat_ioctl = pde->proc_ops->proc_compat_ioctl;
 	if (compat_ioctl)
 		return compat_ioctl(file, cmd, arg);
 	return -ENOTTY;
@@ -424,9 +414,7 @@ static long proc_reg_compat_ioctl(struct file *file, unsigned int cmd, unsigned
 
 static int pde_mmap(struct proc_dir_entry *pde, struct file *file, struct vm_area_struct *vma)
 {
-	typeof_member(struct proc_ops, proc_mmap) mmap;
-
-	mmap = pde->proc_ops->proc_mmap;
+	__auto_type mmap = pde->proc_ops->proc_mmap;
 	if (mmap)
 		return mmap(file, vma);
 	return -EIO;
@@ -483,7 +471,6 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	struct proc_dir_entry *pde = PDE(inode);
 	int rv = 0;
 	typeof_member(struct proc_ops, proc_open) open;
-	typeof_member(struct proc_ops, proc_release) release;
 	struct pde_opener *pdeo;
 
 	if (!pde->proc_ops->proc_lseek)
@@ -510,7 +497,7 @@ static int proc_reg_open(struct inode *inode, struct file *file)
 	if (!use_pde(pde))
 		return -ENOENT;
 
-	release = pde->proc_ops->proc_release;
+	__auto_type release = pde->proc_ops->proc_release;
 	if (release) {
 		pdeo = kmem_cache_alloc(pde_opener_cache, GFP_KERNEL);
 		if (!pdeo) {
@@ -547,9 +534,7 @@ static int proc_reg_release(struct inode *inode, struct file *file)
 	struct pde_opener *pdeo;
 
 	if (pde_is_permanent(pde)) {
-		typeof_member(struct proc_ops, proc_release) release;
-
-		release = pde->proc_ops->proc_release;
+		__auto_type release = pde->proc_ops->proc_release;
 		if (release) {
 			return release(inode, file);
 		}

