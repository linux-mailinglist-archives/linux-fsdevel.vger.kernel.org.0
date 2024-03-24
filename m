Return-Path: <linux-fsdevel+bounces-15169-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 396B4887BB5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 06:00:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D600B28254E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Mar 2024 05:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F3F13FFC;
	Sun, 24 Mar 2024 05:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gGdorOui"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12E6944F;
	Sun, 24 Mar 2024 05:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711256431; cv=none; b=m6uaeP1RJ4ru04+I8rxZhTdsQfpu/kwR2bd68OEhfDgbg6limvv9jeVIJuImflU1d1MmAsuJlbVowuZUHb0iBLdyDhL6run3r32kXvgcULibtdGP6xEnuJsL5/ufA2R+GZXmjpekjwNEAbYGLIP/p5xosoOWkfn8yLruYjOhdQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711256431; c=relaxed/simple;
	bh=s2PpLuMCSXF9aw2S1I7AerrJRZw6llL62KMpMWQBEEY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=FX72TdZNpfGllkpz55Smc3DceIlrheZdnsmewO8tKSAyrgZpubJk1LyeHckv3L5/J/AXlkCOLEABZyPmUxLCDpjIYp/GGCNxhfvkEUd+mck7JCLMhaMDrZpIsTSreuSaoXlyWRk3Thoz13xV5R8yYd5QHbqiaguljSgR5xLhwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gGdorOui; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-515a86daf09so321311e87.3;
        Sat, 23 Mar 2024 22:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711256427; x=1711861227; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yvEdxnpAVsEIe0YNE5Idfj6+Zl6YWvhI7C+nvup/Fgw=;
        b=gGdorOuih3uOmAu7ADmNnh9Y1GULQ0MbemyCYuqjXN6zipYOxzgA+BWf8uXPZDr/Sn
         0tEVxt4Z4/BL2a4NLaD8lzxNUl71sGuYFJ9WJPT235EYBgKQcYV1JaxsO6LIXzBS7TB5
         E/AaHcjx38+Y2vpx8PmxvpkhJ9ys+G21h0yzOaQ3zRj77jTHbDNaKcAtfJ5pC6WXKSRz
         5UgzeTwDOso7mi3fEs47+peW+oPLXQ55vxPXRLP3CUz5z6TJ7IDQJMUkop5v4y7XZU9s
         Q1QPF0RcfjBIH3e9tt68R+7Q39PaSLxOlDVLA6N7U0ftAlJ4sAX7o3iL/X3OxMLfE1P0
         HCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711256427; x=1711861227;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yvEdxnpAVsEIe0YNE5Idfj6+Zl6YWvhI7C+nvup/Fgw=;
        b=mH5Ra3Yu9doJlKM8GXZvVlpIrKLoBYqsSBF7nhidQudK40X/3ubfWccY0VadFtoRT0
         gn+8wG4tggVAgLlMmPgmVd6tvh1cvLlTJZSbJrx49h/HBQMZsKOfIayQA4LCVieEFGps
         PaS3+N1Mepe5PpqAEJOjMFiq4Dak/aLCHeBmkL34GoI25EbV4piu6Xo7GAboLH6OGrNk
         klkSh0AqXL5qox7WzmezcEBYR+HIUh+w/xJPPE+3Sn0pL5X27x6HdiOTdmdoFNh43C8g
         UKllPMLOx/6l1Dto+JsScEZllBY26sg/XUqeytHOeNyd54vTfYgQADMGEt5qhILKmdgP
         sGeA==
X-Forwarded-Encrypted: i=1; AJvYcCUni7DTRaI62rUnDl2UkbrpuuyxFA8lLi/losT/DS3hbOmmW/hfvNJj/H7JpzSsYXtnJ3KNHU6RXuIchev0V6sarg/wXFQUj01AkUPivA==
X-Gm-Message-State: AOJu0YxY/r6mBXiu5SMBV5ryjojJHA74ULptFj7qUsLaPEt1HyP3CpI9
	b0DEyID0CqtFxWXFnyzG3Lud8J0O2WOqai3A3fH/YlVeQDWhOknZs0++HpXEAU699+KFNpdWlPe
	6ujBQW+Xs5oxrwGaoPaApPYCfmYwQJT4F9v0=
X-Google-Smtp-Source: AGHT+IFDlM7PxTIiXR+ZmPGP67FVm99FaL3V3gogWvv54SBA4jhbjyqeg40wLbYRkAw2FRoxovQ6kGhRNxVIFuJTqso=
X-Received: by 2002:a05:6512:616:b0:513:ccec:a822 with SMTP id
 b22-20020a056512061600b00513cceca822mr2667910lfe.28.1711256427032; Sat, 23
 Mar 2024 22:00:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sun, 24 Mar 2024 00:00:15 -0500
Message-ID: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
Subject: kernel crash in mknod
To: LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>, 
	Christian Brauner <christian@brauner.io>
Content-Type: text/plain; charset="UTF-8"

Anyone else seeing this kernel crash in do_mknodat (I see it with a
simple "mkfifo" on smb3 mount).  I started seeing this in 6.9-rc (did
not see it in 6.8).   I did not see it with the 3/12/23 mainline
(early in the 6.9-rc merge Window) but I do see it in the 3/22 build
so it looks like the regression was introduced by:

commit 08abce60d63fb55f440c393f4508e99064f2fd91
Author: Roberto Sassu <roberto.sassu@huawei.com>
Date:   Thu Feb 15 11:31:02 2024 +0100

    security: Introduce path_post_mknod hook

    In preparation for moving IMA and EVM to the LSM infrastructure, introduce
    the path_post_mknod hook.

    IMA-appraisal requires all existing files in policy to have a file
    hash/signature stored in security.ima. An exception is made for empty files
    created by mknod, by tagging them as new files.

    LSMs could also take some action after files are created.

    The new hook cannot return an error and cannot cause the operation to be
    reverted.

Dmesg showing the crash it causes below:

[   84.862122] RIP: 0010:security_path_post_mknod+0x9/0x60
[   84.862139] Code: 41 5e 5d 31 d2 31 f6 31 ff c3 cc cc cc cc 0f 1f
00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 44 00 00 48
8b 46 30 <f6> 40 0d 02 75 43 55 48 89 e5 41 55 49 89 fd 41 54 49 89 f4
53 48
[   84.862149] RSP: 0018:ffffa22dc1f6bdc8 EFLAGS: 00010246
[   84.862159] RAX: 0000000000000000 RBX: ffff8d4fc85da000 RCX: 0000000000000000
[   84.862167] RDX: 0000000000000000 RSI: ffff8d502473a900 RDI: ffffffffaa26f6e0
[   84.862174] RBP: ffffa22dc1f6be28 R08: 0000000000000000 R09: 0000000000000000
[   84.862181] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
[   84.862187] R13: ffff8d502473a900 R14: 0000000000001000 R15: 0000000000000000
[   84.862195] FS:  00007d2c5c075800(0000) GS:ffff8d573b880000(0000)
knlGS:0000000000000000
[   84.862204] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   84.862211] CR2: 000000000000000d CR3: 000000018d63a005 CR4: 00000000003706f0
[   84.862219] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   84.862225] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   84.862232] Call Trace:
[   84.862238]  <TASK>
[   84.862248]  ? show_regs+0x6c/0x80
[   84.862262]  ? __die+0x24/0x80
[   84.862273]  ? page_fault_oops+0x96/0x1b0
[   84.862290]  ? do_user_addr_fault+0x30c/0x730
[   84.862304]  ? exc_page_fault+0x82/0x1b0
[   84.862318]  ? asm_exc_page_fault+0x27/0x30
[   84.862338]  ? security_path_post_mknod+0x9/0x60
[   84.862350]  ? do_mknodat+0x191/0x2c0
[   84.862365]  __x64_sys_mknodat+0x37/0x50
[   84.862376]  do_syscall_64+0x81/0x180
[   84.862387]  ? count_memcg_events.constprop.0+0x2a/0x50
[   84.862402]  ? handle_mm_fault+0xaf/0x330
[   84.862418]  ? do_user_addr_fault+0x33f/0x730
[   84.862430]  ? irqentry_exit_to_user_mode+0x6a/0x260
[   84.862442]  ? irqentry_exit+0x43/0x50
[   84.862453]  ? exc_page_fault+0x93/0x1b0
[   84.862464]  entry_SYSCALL_64_after_hwframe+0x6c/0x74
[   84.862476] RIP: 0033:0x7d2c5bf19e07
[   84.862536] Code: 9c ff ff ff e9 0a 00 00 00 66 2e 0f 1f 84 00 00
00 00 00 f3 0f 1e fa 48 89 c8 48 c1 e8 20 75 2b 41 89 ca b8 03 01 00
00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 8b 15 e1 3f 0e 00 f7 d8 64 89
02 b8
[   84.862544] RSP: 002b:00007ffc1b2c4568 EFLAGS: 00000246 ORIG_RAX:
0000000000000103
[   84.862556] RAX: ffffffffffffffda RBX: 00007ffc1b2c4718 RCX: 00007d2c5bf19e07
[   84.862563] RDX: 00000000000011b6 RSI: 00007ffc1b2c6712 RDI: 00000000ffffff9c
[   84.862570] RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
[   84.862576] R10: 0000000000000000 R11: 0000000000000246 R12: 00007d2c5bffe428
[   84.862582] R13: 0000000000000000 R14: 00007ffc1b2c6712 R15: 00007d2c5c199000
[   84.862597]  </TASK>


--
Thanks,

Steve

