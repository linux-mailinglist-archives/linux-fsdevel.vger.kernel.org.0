Return-Path: <linux-fsdevel+bounces-14550-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CF1A87D8BF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 05:30:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FB028252D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 04:29:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B96C522A;
	Sat, 16 Mar 2024 04:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LAU4Lffi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2CA4C89;
	Sat, 16 Mar 2024 04:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710563391; cv=none; b=vEjs+z8QWNSg2gZvsMnMn+HAex6MDLG1M6C4TuhUWFLsydWONs6fH7XFH5jWXMG1TfJxjZeSxAP4AiTnPbA3bOzLkD2VslKOgbp47LxnCzHWAvx16Qk1xjyonzZuvp0WYrabW/Ib0e4ditEUU/Wch0du/TH8BmCkqv3fY2nV5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710563391; c=relaxed/simple;
	bh=8P3uymRcBIKjGhm/+BH/Z8o+wXIMQJ/xJ6S3FnE1OXw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=hEkDoq9x9iFZnvX9Hjh1fCwkoazfuxYV2UVWpPPaiz4YyZvY12/11ZycaqqhoBg391v23AJ8tzEQjslGsxjuZF1Rn48o2gKfq3dFCCZ91rk4V/5TYf1Kx/lVISDUb2gKI73Kp6tPxYYp1kWz2i+gT5cGJSa2Ww5Gm2CXSp/ACKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LAU4Lffi; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a46a7b8e07fso9826166b.2;
        Fri, 15 Mar 2024 21:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710563388; x=1711168188; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FS67skdF0ndapq3FsIVz8N3Du2RWkbihnWlsJKNoYg4=;
        b=LAU4Lffi3GdZ2aXlwXX3I4yDth1P5ZIcPx/C103ruLX38NXRSTsDTRK341NxhhqFKW
         EptunGL/3ElGqArvhTWT4ZWJ9TCsRfOb7l3wXf6ywBE7syC8wkVPhrYW8NKSTmi4cVxx
         9QusvN1rHXxsztDhgRU/R5QlMPUrlVAjVMEYWwp2NpZhlWg1dtZmI9yLXAFsYrxJFKub
         QGngnAwS5xC0l8jE3ttLgPk+FBf0+wlRy4dDxHzuAm0NH3U8YDL60sUhDvGb+9zns2iz
         pvpynL/v4wOhBnMrtcowY9q8GtQE+SoCJDhdCCjGUoGR5eJ12fx3CDFk9WohtAx801wz
         Izmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710563388; x=1711168188;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FS67skdF0ndapq3FsIVz8N3Du2RWkbihnWlsJKNoYg4=;
        b=Krw+hBCs3XIR1OVH89NofxxVl6Vt78RSXnoKff1dAtAnrHbvbcsX8f8x3OpGs0e+f9
         a/HwAMEmnaUZzcIegxKexQ0r72mZThDnA7fSQ6B3nChKi2Xk/OYc33Fodid0KOpm0Qrc
         iuXXP0zBifrQADYDlmBC7ST7gSzOMOGMHd5+B3Fbo1NWE/7FtrULe6HOtMLuOHqt3xA9
         dpQrGvt8BTthN2I2+hyKmqCcNP4QAP7qYdiEO7NkFTSfNR+rKgeZiLTj/9rYfAjEjeeS
         XkpHvYf/OPlJ0nCq+MOhD0CgdTDgAefvI42nNTxFSxMoQXdJXOPQLcegt9dlrY+gca0U
         K2Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWzZipIkab5FjWEHlIalTyTYr1fJFzVnMjybUEGbsAEjWQVqH1CAYZ75CmHpkeeXi036H3unysibTHu6uUhO4L2rLBvwAcpNJ+Wtdv6190oa6v/+B4K3VP52PRI3E7zQMJgGnZKnKIi3xe8rw==
X-Gm-Message-State: AOJu0Yx20q5P4AkYdzu7JTcDepdJ5iy84Xyas5Wi1wIRmSRw0nCpT0ue
	wC9LzPPQSTEWgqJBd4vJFIaknFOhMg1edRrfCJvfflMxk2tl0YTb+nx+6RXtKShJQPbhxJlVU/c
	oAYFREqmyygUEO7O5afShklf5N6Q=
X-Google-Smtp-Source: AGHT+IFH+j0YktLEbqExK6/TpGRt0ywFM0kfV4d8tOYG2R83VG1IcHy7Uz3B7Otrsn1z0vmLQMXpnzH7G3aqTAIN4Ps=
X-Received: by 2002:a17:906:bfe6:b0:a46:4c8e:1afd with SMTP id
 vr6-20020a170906bfe600b00a464c8e1afdmr4850766ejb.6.1710563388233; Fri, 15 Mar
 2024 21:29:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: cheung wall <zzqq0103.hey@gmail.com>
Date: Sat, 16 Mar 2024 12:29:36 +0800
Message-ID: <CAKHoSAuCUF8kNFdv5Chb2Fnup2vwDb0W+UPOxHzgCg_O=KJA0A@mail.gmail.com>
Subject: WARNING in mark_buffer_dirty
To: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,


when using Healer to fuzz the latest Linux Kernel, the following crash

was triggered on:


HEAD commit: 0dd3ee31125508cd67f7e7172247f05b7fd1753a  (tag: v6.7)

git tree: upstream

console output: https://pastebin.com/raw/DnYhuiCu

kernel config: https://pastebin.com/raw/VecrLrRN

C reproducer: https://pastebin.com/raw/3tXH4hvU

Syzlang reproducer: https://pastebin.com/raw/Jxcujpb3


If you fix this issue, please add the following tag to the commit:

Reported-by: Qiang Zhang <zzqq0103.hey@gmail.com>

----------------------------------------------------------

WARNING: CPU: 0 PID: 2920 at fs/buffer.c:1176
mark_buffer_dirty+0x232/0x290
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/buffer.c:1176
Modules linked in:
CPU: 0 PID: 2920 Comm: syz-executor247 Not tainted 6.7.0 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
RIP: 0010:mark_buffer_dirty+0x232/0x290
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/buffer.c:1176
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
Code: 00 00 00 00 00 fc ff df 48 c1 ea 03 80 3c 02 00 75 69 48 8b 3b
be 04 00 00 00 e8 29 5f fd ff e9 8e fe ff ff e8 bf 5d c3 ff 90 <0f> 0b
90 e9 ea fd ff ff 48 89 df e8 de b6 ef ff e9 14 fe ff ff 48
RSP: 0018:ffff88800918f9f0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff88800e9897e0 RCX: ffffffffabfb13b1
RDX: ffff88800c44e600 RSI: 0000000000000008 RDI: ffff88800e9897e0
RBP: 0000000000000200 R08: 0000000000000000 R09: ffffed1001d312fc
R10: ffff88800e9897e7 R11: 0000000000000000 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff88800e9897e0 R15: 0000000000000200
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
FS:  00005555557ca480(0000) GS:ffff8880a4200000(0000) knlGS:0000000000000000
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020400000 CR3: 0000000006c94005 CR4: 0000000000770ef0
PKRU: 55555554
Call Trace:
 <TASK>
 __block_commit_write+0xe9/0x200
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/buffer.c:2191
 block_write_end+0xb1/0x1f0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/buffer.c:2267
 iomap_write_end+0x461/0x8c0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/iomap/buffered-io.c:857
 iomap_write_iter
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/iomap/buffered-io.c:938
[inline]
 iomap_file_buffered_write+0x4eb/0x800
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/iomap/buffered-io.c:987
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 blkdev_buffered_write
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/block/fops.c:646
[inline]
 blkdev_write_iter+0x4ae/0xa40
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/block/fops.c:696
 call_write_iter
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/./include/linux/fs.h:2020
[inline]
 new_sync_write
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/read_write.c:491
[inline]
 vfs_write+0x835/0xb30
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/read_write.c:584
 ksys_write+0x104/0x210
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/fs/read_write.c:637
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
sr 1:0:0:0: [sr0] tag#0 unaligned transfer
 do_syscall_x64
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/entry/common.c:52
[inline]
 do_syscall_64+0x46/0xf0
root/zhangqiang/kernel_fuzzing/zq-LLM-OS/llm-syz-environment/linux-6.7/arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x6f/0x77
RIP: 0033:0x7f9c88c542fd
Code: c3 e8 b7 24 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd984ca008 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00000000000bc285 RCX: 00007f9c88c542fd
RDX: 00000000fffffec2 RSI: 0000000020000040 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd984ca04c
R13: 00007ffd984ca070 R14: 0000000000000370 R15: 00007f9c88ca5025
 </TASK>

