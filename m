Return-Path: <linux-fsdevel+bounces-25250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B1E94A4BE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 11:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09366B25871
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 09:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8771D1742;
	Wed,  7 Aug 2024 09:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M0ZdMHXs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC0E1AE87B;
	Wed,  7 Aug 2024 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723024267; cv=none; b=kk0JFv07oZiahElpm1fdqGKy7ji2TziFdLH55hPyDBuTHhZph/eScxE3FgHp6T5+1SjNmCxxq7eTIIpq+QGCOMsBEzF6RMP4JyolUFNmWP0abFGJwoUGszXxSH3eAcCGNwk6gBs6SNTAsrVR1W0FMwigsJimqiM7WTfGgOs6Czo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723024267; c=relaxed/simple;
	bh=bujS5tNHpPQZuSVa4aVCvUXPM+htXR7bDrzdJ/qKEAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UcrZ3c0Zt7rOQhk7Ik2/B339PCI/7Ge0DmoAcfRP9Xxwpn/boKgFJ6FDr4x6Gul2BSpMX1OunykKLMSwiM1cZA034CLeTKK+6FD6LDh17ZhUnVvluZmoVrq1uMG5gAVCX69cPlf+6mz0oaLDc5N8b/3FdbeI8pI1zNfOYxm9sN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M0ZdMHXs; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7d89bb07e7so201715766b.3;
        Wed, 07 Aug 2024 02:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723024264; x=1723629064; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hXnNRuyOF/eWPZMzqKvL4vKAqfDFwvUatk3tLmfpuAc=;
        b=M0ZdMHXsi2PleYfnnERcrKEhIsrA5fX/x+xNQNSWXrN3+LqDb2PuZkPINy3/bCEYJh
         7rFGk7LlOAmrD9/4yf+c50YjG7X2yovzEoYuZQk9JN0vEmH+QjuwszC2VJsYBOl+++Ng
         9GJBnY0F2wm0n7ZcFbYR6VWufR5ua/td4J47jqxcVIOgVRoOU82uKRjLqHSxSVijuF34
         CXUbKRg/K0zpBEyE2w2l00l9hgo/yCattMYNklXsxZyJXuaqMGfXYQzRtvH7/DimUY39
         J2zboDzJB90Z8HuTioP+t2STINfMqi8z0oFJI0OXQbVkNIKoiLpwr0+gHkjtTS9PksMb
         dPDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723024264; x=1723629064;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hXnNRuyOF/eWPZMzqKvL4vKAqfDFwvUatk3tLmfpuAc=;
        b=W7N4nlZdahiEdjCDvzWdwXa2w55T1pAdEJr4Z3Lfr8VtgPF6UUatkIPZOFRwfHEWp9
         ILx6gFRMZtHPJSU/bQ62/gN9lRpmgC8LDO+8EFDCSV7fBRZ3CdqbN4vse63HkmrcTwBD
         +QG/NkXSKhBJYegMQiStVvAYbM+jCuQ1ArMwcXiYB+iQmfgV+SjMSZVzCsmg6qSgC3ov
         mPV1M6QxUI43Kir3yph1gR5EJnXoo7GV7BFEWtUXZmFIpL0eogSJIex0U7qCm8oz0hOJ
         tzTVm1KMPnNLieUGn1mrEpes6Q8S+1BWior8R99W8v8Oii3hyiHQp5mNgBHilt2NUI43
         YZ3g==
X-Forwarded-Encrypted: i=1; AJvYcCXGtTfHmwcTYDDzmjllSKiWBjPgQNuyFyeNmvQSk1IEz9jvVB+LWSP7TMRBLf/GLJAEBcB+8rMv0prGtFQc8FcP2Toyy6Tb5NEOfXSxBsL3X3iyJFbJMLVAZ6Pb2LqwNdsY2223znhOgadjvA==
X-Gm-Message-State: AOJu0YwfGOxLgrsnFT8+PsCYwRklOveCMhSckuSCGTJL32HVaJ1IizO7
	sLgx17xtNekYJ2wk6/b9w/8HcAdMTtefNUNu4YUwFjQhvdLd/3Pnqfy6cE0s/kP/m/AjpOnJd/O
	+VeL0aaM08n7DvRAgbY2BedmqY6I=
X-Google-Smtp-Source: AGHT+IFuJJSAfymoexc0xceu8yZeIOR19MjOxo/KrMwNuaFAvLrwDjZiBvHSS4OvimC9+1oqlh885P3WoOUlevBROHo=
X-Received: by 2002:a17:907:3d8c:b0:a7a:b643:654b with SMTP id
 a640c23a62f3a-a7dc507105dmr1388891266b.50.1723024263619; Wed, 07 Aug 2024
 02:51:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806144628.874350-1-mjguzik@gmail.com> <20240806155319.GP5334@ZenIV>
 <CAGudoHFgtM8Px4mRNM_fsmi3=vAyCMPC3FBCzk5uE7ma7fdbdQ@mail.gmail.com>
 <20240807033820.GS5334@ZenIV> <CAGudoHFJe0X-OD42cWrgTObq=G_AZnqCHWPPGawy0ur1b84HGw@mail.gmail.com>
 <20240807062300.GU5334@ZenIV> <20240807063350.GV5334@ZenIV>
 <CAGudoHH29otD9u8Eaxhmc19xuTK2yBdQH4jW11BoS4BzGqkvOw@mail.gmail.com>
 <20240807070552.GW5334@ZenIV> <CAGudoHGMF=nt=Dr+0UDVOsd4nfGRr4xC8=oeQqs=Av9s0tXXXA@mail.gmail.com>
 <20240807075218.GX5334@ZenIV> <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
In-Reply-To: <CAGudoHE1dPb4m=FsTPeMBiqittNOmFrD-fJv9CmX8Nx8_=njcQ@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 7 Aug 2024 11:50:50 +0200
Message-ID: <CAGudoHFm07iqjhagt-SRFcWsnjqzOtVD4bQC86sKBFEFQRt3kA@mail.gmail.com>
Subject: Re: [PATCH] vfs: avoid spurious dentry ref/unref cycle on open
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This eventually broke:

[ 1297.949437] BUG: kernel NULL pointer dereference, address: 0000000000000028
[ 1297.951840] #PF: supervisor read access in kernel mode
[ 1297.953548] #PF: error_code(0x0000) - not-present page
[ 1297.954984] PGD 109590067 P4D 0
[ 1297.955533] Oops: Oops: 0000 [#1] PREEMPT SMP NOPTI
[ 1297.956340] CPU: 18 UID: 0 PID: 1113 Comm: cron Not tainted
6.11.0-rc1-00003-g80efb96e5cd4 #291
[ 1297.958090] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
BIOS rel-1.16.1-0-g3208b098f51a-prebuilt.qemu.org 04/01/2014
[ 1297.959926] RIP: 0010:vfs_tmpfile+0x162/0x230
[ 1297.960666] Code: b2 8b 55 48 83 e2 20 83 fa 01 19 ff 81 e7 00 f0
ff ff 81 c7 20 10 00 00 a9 00 40 00
04 75 90 48 8b 85 a0 00 00 00 4c 8b 48 30 <49> 8b 51 28 48 8b 92 b8 03
00 00 48 85 d2 0f 84 71 ff ff ff 48 8b
[ 1297.963682] RSP: 0018:ff38d126c19c3cc0 EFLAGS: 00010246
[ 1297.964549] RAX: ff2c2c8c89a3b980 RBX: 0000000000000000 RCX: 0000000000000002
[ 1297.965714] RDX: 0000000000000000 RSI: ff2c2c8c89a3ba30 RDI: 0000000000000020
[ 1297.966872] RBP: ff2c2c8c91917b00 R08: 0000000000000000 R09: 0000000000000000
[ 1297.968046] R10: 0000000000000000 R11: ff2c2c8c91cd23f0 R12: ffffffffb7b91e20
[ 1297.969202] R13: ff38d126c19c3d48 R14: ff2c2c8c89a3b980 R15: ff2c2c8c89a00a58
[ 1297.970364] FS:  00007ff81cb63840(0000) GS:ff2c2c91e7a80000(0000)
knlGS:0000000000000000
[ 1297.971694] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1297.972645] CR2: 0000000000000028 CR3: 000000010cf58001 CR4: 0000000000371ef0
[ 1297.973825] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 1297.974996] DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
[ 1297.976175] Call Trace:
[ 1297.976609]  <TASK>
[ 1297.976978]  ? __die+0x23/0x70
[ 1297.977501]  ? page_fault_oops+0x15c/0x480
[ 1297.978191]  ? jbd2_journal_stop+0x13c/0x2d0
[ 1297.978903]  ? exc_page_fault+0x78/0x170
[ 1297.979564]  ? asm_exc_page_fault+0x26/0x30
[ 1297.980262]  ? vfs_tmpfile+0x162/0x230
[ 1297.980891]  path_openat+0xc70/0x12b0
[ 1297.981507]  ? __count_memcg_events+0x58/0xf0
[ 1297.982233]  ? handle_mm_fault+0xb9/0x260
[ 1297.982903]  ? do_user_addr_fault+0x2ed/0x6e0
[ 1297.983636]  do_filp_open+0xb0/0x150
[ 1297.984241]  do_sys_openat2+0x91/0xc0
[ 1297.984855]  __x64_sys_openat+0x57/0xa0
[ 1297.985504]  do_syscall_64+0x52/0x150
[ 1297.986128]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

tripping ip:
vfs_tmpfile+0x162/0x230:
fsnotify_parent at include/linux/fsnotify.h:81
(inlined by) fsnotify_file at include/linux/fsnotify.h:131
(inlined by) fsnotify_open at include/linux/fsnotify.h:401
(inlined by) vfs_tmpfile at fs/namei.c:3781

-- 
Mateusz Guzik <mjguzik gmail.com>

