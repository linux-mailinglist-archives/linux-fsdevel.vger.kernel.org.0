Return-Path: <linux-fsdevel+bounces-38356-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D925A004E9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 08:25:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C631883E6F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jan 2025 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59B041C760A;
	Fri,  3 Jan 2025 07:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hxBGp+v4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B1D1C07E2;
	Fri,  3 Jan 2025 07:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735889116; cv=none; b=Uyj5vXyB/GPd5+paQ9ZhQBI+MsJ3cS/GY+/UBxaXt9GmkTnyMt7c9fCI7r1/iZ8gdFXOWjBYIZRd6RvRuXve73cCtBT9hwk1378l+7ABEJ7/r42gQqDG1jGBl4XAW6ojezG/cxpNsCyJ81zGzjj6KhX/o/RQHjAQNvwOpy00EPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735889116; c=relaxed/simple;
	bh=bTL24/4THKhRJpWlo4qYopl+MVCqhAS/bOoyXSgLc0A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qCuIcMOoHcq4MPaDxYLV7mSRq8t/DHbpD/2ftnlGnwnKhcCPg707wuNGObCygStVNvgGQFK6O/ewJi2OeuCaVHVJ1qx3YKX41dxzb0h71PsOErWhJqC+8PntOJWdTofbAwMUxihCItZ6opaQwJXMx82dRGuXaNvSxy885HMm8TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hxBGp+v4; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d27243ba8bso22846115a12.2;
        Thu, 02 Jan 2025 23:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735889113; x=1736493913; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bTL24/4THKhRJpWlo4qYopl+MVCqhAS/bOoyXSgLc0A=;
        b=hxBGp+v4ZrvLhBE3r8D9VCozfS02B1hvs/AamRVDL52dsXMzpeG+ZtOIj9wpuutQ+t
         NdHmgXtI88qDLqMXzc45u5cFWAXUJSt1T64O/CGjUWbVt+8hDRmc1jhQ9mawMOjtqIH7
         U966+LBJJEAs4+dQIltO692lNnnOKd21EtPHNRGGv0YBvBKWsz9B7LouVj/g+MBkPzD3
         QKtbngxjsjLkTKFW9wOPSWS5ZlrkySgd+DVSq+3yQwrJ3wX8xGDuyg/Xr28qEDcxB6Kf
         DW+PBnbDNkQ//aJ/9y5ItHSVuZVGbCXBkinECB/wFXVuO9HaDc8SxazRUa3s5HtaD2Od
         tRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735889113; x=1736493913;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bTL24/4THKhRJpWlo4qYopl+MVCqhAS/bOoyXSgLc0A=;
        b=r/4zKYAfz08swBh3FoYuEnW1reVE6qtH2WgUnChchDN1uPHMEM9mq7wkbXGmC3rFFD
         Veqxp+/NsWRiE7VQDzk1Y29s9XdPXsxcgLmNi1OGEgw7mcbvpZZjuifphAkknAh9VwDX
         YBSqvEaIZN3+UOvwMW06hLmp4+M6yAqZGUq6dB9w697Ds6zW6Y2D8auMQDGUCzS+v9E9
         /5VJwDvX5YlJIOcHyB9EbU+XV/PRlwL2VyP5O1UBaEnD+w+odV15SnEMDaL9n/aV0+Xv
         b/3WkLoHL1Vd5fWNtyTPWa1biyZyxtt1USrSCe/Q2BJfgBuDFz4Aiy/684OJg2FB4n2R
         ohmA==
X-Forwarded-Encrypted: i=1; AJvYcCWxOGkXV4Acu7S/40gCY4HgCVwEY8OdIl+SQu3JFclxYb+BgeyDkRFqeuCVBi2cKz5FH3SFTtHMBt3sMfU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk1v0IIp0F7t0i+TsYKrdfYdJwiQA85FDkI+Wdzc81Ow8wLGnn
	oWoDVQLyN7SI1FpdF97QZK5n/JnDiTWS2KU7h2e/qpb8esQQ4XddW5YpKPVlu+SGowhcAHi3XvS
	+ZtELMPF/SlHIrDuhNw8OxcmqQ4KNj3f1
X-Gm-Gg: ASbGncsF/0ylkmp28hgf53MLdSGdEhAlLQLUh+TKdFAoWAeMljgYXr1R4x0mVrirtJK
	tarWfgGj7kkv/PvwJyBHidjNmI5lgJca32vCMSJo=
X-Google-Smtp-Source: AGHT+IEf7nybpprXjHOWj43lPXSB5yakTAaaV8rFjPdlN1C1/C2m66mjLMB5DBBA2UUPtfgtwRM0x9oZv6vcwpfZHqo=
X-Received: by 2002:a17:907:948b:b0:aac:1e96:e7d2 with SMTP id
 a640c23a62f3a-aac33667eb4mr4426685766b.54.1735889113171; Thu, 02 Jan 2025
 23:25:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Fri, 3 Jan 2025 15:25:01 +0800
Message-ID: <CAKHoSAsMYWOYfqw6h74cEzucg1vGZaY4ShT3e35NnX2v_Ro04w@mail.gmail.com>
Subject: "divide error in bdi_set_min_bytes" in Linux kernel version 6.13.0-rc2
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

I am writing to report a potential vulnerability identified in the
Linux Kernel version 6.13.0-rc2. This issue was discovered using our
custom vulnerability discovery tool.

HEAD commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4 (tag: v6.13-rc2)

Affected File: mm/page-writeback.c

File: mm/page-writeback.c

Function: bdi_set_min_bytes

Detailed Call Stack:

------------[ cut here begin]------------

RIP: 0010:div64_u64 include/linux/math64.h:69 [inline]
RIP: 0010:bdi_ratio_from_pages mm/page-writeback.c:695 [inline]
RIP: 0010:bdi_set_min_bytes+0x9f/0x1d0 mm/page-writeback.c:799
Code: ff 48 39 d8 0f 82 3b 01 00 00 e8 ac fd e7 ff 48 69 db 40 42 0f
00 48 8d 74 24 40 48 8d 7c 24 20 e8 c6 f1 ff ff 31 d2 48 89 d8 <48> f7
74 24 40 48 89 c3 3d 40 42 0f 00 0f 87 08 01 00 00 e8 79 fd
RSP: 0018:ffff88810a5f7b60 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff9c9ef057
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88810a5f7ab8
RBP: 1ffff110214bef6c R08: 0000000000000000 R09: fffffbfff4081c7b
R10: ffffffffa040e3df R11: 0000000000032001 R12: ffff888105c65000
R13: dffffc0000000000 R14: ffff888105c65000 R15: ffff888105c65800
FS: 00007fdfc7c37580(0000) GS:ffff88811b280000(0000) knlGS:0000000000000000
CS: 0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055adcdc786c8 CR3: 0000000104128000 CR4: 0000000000350ef0
Call Trace:
<TASK>
min_bytes_store+0xba/0x120 mm/backing-dev.c:385
dev_attr_store+0x58/0x80 drivers/base/core.c:2439
sysfs_kf_write+0x136/0x1a0 fs/sysfs/file.c:139
kernfs_fop_write_iter+0x323/0x530 fs/kernfs/file.c:334
new_sync_write fs/read_write.c:586 [inline]
vfs_write+0x51e/0xc80 fs/read_write.c:679
ksys_write+0x110/0x200 fs/read_write.c:731
do_syscall_x64 arch/x86/entry/common.c:52 [inline]
do_syscall_64+0xa6/0x1a0 arch/x86/entry/common.c:83
entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdfc7b4d513
Code: 8b 15 81 29 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 00 64 8b 04 25 18 00 00 00 85 c0 75 14 b8 01 00 00 00 0f 05 <48> 3d
00 f0 ff ff 77 55 c3 0f 1f 40 00 48 83 ec 28 48 89 54 24 18
RSP: 002b:00007ffe7796ae28 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000055adcdc766c0 RCX: 00007fdfc7b4d513
RDX: 0000000000000002 RSI: 000055adcdc766c0 RDI: 0000000000000001
RBP: 0000000000000002 R08: 000055adcdc766c0 R09: 00007fdfc7c30be0
R10: 0000000000000070 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000002 R14: 7fffffffffffffff R15: 0000000000000000

------------[ cut here end]------------

Root Cause:

The crash is caused by a division by zero error within the Linux
kernel's page-writeback subsystem. Specifically, the bdi_set_min_bytes
function attempts to calculate a ratio using bdi_ratio_from_pages,
which internally calls div64_u64. During this calculation, a
denominator value unexpectedly becomes zero, likely due to improper
handling or validation of input data provided through the sysfs
interface during the min_bytes_store operation. This erroneous zero
value leads to a divide error exception when the kernel tries to
perform the division. The issue occurs while processing a sysfs write
operation (min_bytes_store), suggesting that invalid or uninitialized
data supplied through sysfs triggers the faulty calculation,
ultimately causing the kernel to crash.

Thank you for your time and attention.

Best regards

Wall

