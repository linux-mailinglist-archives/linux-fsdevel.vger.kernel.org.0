Return-Path: <linux-fsdevel+bounces-36223-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F6E9DF9EF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 05:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52765B2170C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Dec 2024 04:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3261F941C;
	Mon,  2 Dec 2024 04:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef0Guuyu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DB61F8F1E;
	Mon,  2 Dec 2024 04:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733113897; cv=none; b=g+7QPE4+eKxPHbYyuPF/W9TxAes2mW5F/NWioF2qhKA28XwIl+HsT1ZzMTZymWYSsi83yVmP9DVBk3lc/pX64YDCSSWeHXHWYH8oFGmxuVggEFzAJdxcoYXZzZu9nJWxXVqENbLuiNLkE7QlrRRIbnzCFUm8VaSysjdRzquhF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733113897; c=relaxed/simple;
	bh=nP6q89VMPYBcSc3bkFze3v64dBfeGjwZ6jzt5hopwnc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NlGGtHrADcOpnFUkRSDFKfE3FiO1vAeDli6gidOHuF7jnlCauaYGsUdPzUfU8eHmlTTP756HLw5fJIpWzZX+21qIDtnKyx7q/V1rhKkubNsIAqHPqIG6rhg2EiFlj0HGokt642Ll6Fm2ZcZuK4TzyyfEGyyp/fzp5CM1ni100yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef0Guuyu; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa549d9dffdso621494566b.2;
        Sun, 01 Dec 2024 20:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733113894; x=1733718694; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nP6q89VMPYBcSc3bkFze3v64dBfeGjwZ6jzt5hopwnc=;
        b=ef0Guuyul+neA6oePeg0j/lsTs3dTLvYXbCQx77uhqbkLnJpY+5sNlDGZWCkSg7sPP
         UrzUfWFckt/BpdQ5dnJT/lIiTk1o/PktFNBuE8/tbK1HVzk1qYk+Fleb0t+ZGYZ/lbZH
         0uuiSXi9tQ89yITfCVYxgn46Wg/Fkb2pugdglh1gxKjwL1USHuXJmnA2gtGR2uluaJru
         cEYg4nJY7taZ5bfRvBqkZHO6VKzSZ67p1oj80ILRidKG3UW5SUI8TWObGaHc+f3b5ZTP
         CE8lKhGrPAFks13tGvhPEgOCOfhQJeraMiR75JGHPBQr1sWvz6VbHHGTULauSDQ4dA8t
         3uAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733113894; x=1733718694;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nP6q89VMPYBcSc3bkFze3v64dBfeGjwZ6jzt5hopwnc=;
        b=Sbut7sxiruPn1PFmGz8e4jNhLCho7MBwx7qqjXb+54tCaktEIQ5EzXPixuctdTV0Wv
         wbhShYnoHm8AWpkvrdg4Putn9+PjRIJwsFh4jGtiMP0mriJnnLRX3y5DFyQ7tj5PkpSo
         aMwPbQYb1GZjPilQg3tHYUwvtXdKJrO41r83Ed7luB8NAuBEI4VDCgJI7758Vz3W7YnY
         BECUK/wx+WdOXH7jp7gX+24Zcrl77jUv5TaeXK2W0hGM63f8egfx+KSetgxTA+Acm535
         OWY6BaTECTeT8Dmxsme8ENiLdkqRJ9tREuBe1OT7PM78WN/4aPo1rVajs2dC1nQkIuDm
         qECQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRUS9QZjKbd0VQRIyjCCDXfQ90oLuPuzleztjQ1/p2f2KHJHU5U04ZD8ZGd869Ve1vcm2vWUdjbWToaDA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf6wMM7y1pVhcJv2xbp9eZGK1bfdKjnABz1uzUfg2HDFj5jRvh
	H+QRTCZ18SQTF5bDIPcy+/Ou6s5a6v7MrDqrlXXFV6RgcxViAb+HMZ8ue15+YKhrycCai1U1to3
	Ql0FlkQTipCK2XLM4tgUbKy9Gx8eP+UOU
X-Gm-Gg: ASbGncseJRo3zr+7KGFClvpxStW+08vffMT6JK3J2QfvdKj8sHG6OSHIgEq1Y9bepk8
	DxWm9LgQt42gji1sK0I8dHAG1EJroy7DL
X-Google-Smtp-Source: AGHT+IG/BxKufK2xEWq/FlIo/lNZdA0vjxD9Oze68ycc32dTmLkD58uANCdSlfypJLXn0G76Fx/fHjkqA0wFUe/guvw=
X-Received: by 2002:a17:906:31cc:b0:a9a:bbcc:508c with SMTP id
 a640c23a62f3a-aa580ef2b02mr1733005766b.2.1733113894170; Sun, 01 Dec 2024
 20:31:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Mon, 2 Dec 2024 12:31:22 +0800
Message-ID: <CAKHoSAtp6Eu3HoUvdGuaHxt21zoHkVWmmGrRK9mw2T+-r-fEYw@mail.gmail.com>
Subject: =?UTF-8?Q?=E2=80=9CBUG=3A_unable_to_handle_kernel_paging_request_in_an?=
	=?UTF-8?Q?on=5Finode=5Fgetfile=E2=80=9D_in_Linux_Kenrel_Version_2=2E6=2E32?=
To: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 2.6.32, specifically on the PowerPC architecture.
This issue was discovered using our custom vulnerability discovery
tool.

Affected File:

File: fs/anon_inodes.c

Function: anon_inode_getfile

Detailed Call Stack:

b3f455be4663db/report0
sched_yield()
flistxattr(r7, &(0x7f0000003040)=""/124, 0x7c)
dup(r4)
#executor: Prog has number of calls = 30
0x0
Unable to handle kernel paging request for data at address 0x00000014
Oops: Kernel access of bad area, sig: 11 [#1]
Modules linked in:
REGS: c05cbc60 TRAP: 0300 Not tainted (2.6.32)
DEAR: 00000014, ESR: 00000000
GPR00: 00000000 c05cbd10 c0591330 00000009 c05cbd18 c78020c0 00000000 00000020
GPR16: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
NIP [c00f23c0] anon_inode_getfile+0x90/0x170
root/linux-2.6.32/fs/anon_inodes.c:109
Call Trace:
[c05cbd50] [c00f3e3c] eventfd_file_create+0x8c/0xe0
root/linux-2.6.32/fs/eventfd.c:341
[c05cbd90] [c0003174] execute_syscall+0xcc/0xf0
root/linux-2.6.32/init/executor.c:465
[c05cbfa0] [c00052e8] executor_main+0x2c/0x54
root/linux-2.6.32/init/executor.c:709
[c05cbff0] [c0000398] skpinv+0x2b0/0x2ec
7c00492d 40a2fff4 80090000 90610010 3f20c05d 3be0fff4 4bf28275 7c240b78
---[ end trace 31fd0ba7d8756001 ]---


Root Cause:

The root cause of this issue is the kernel's failure to properly
handle memory access during the execution of the anon_inode_getfile
function. This is likely due to invalid or uninitialized memory being
accessed, possibly as a result of a bug in memory allocation or an
issue with pointer dereferencing. The function attempts to access data
at an invalid address (0x00000014), which leads to a kernel paging
request error, causing a segmentation fault. This could be caused by
improper initialization of the anon_inode structures, incorrect memory
handling, or a bug in the relevant kernel subsystems dealing with
anonymous inodes or file operations.

Thank you for your time and attention.

Best regards

Wall

