Return-Path: <linux-fsdevel+bounces-61445-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34820B583A1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 19:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0917205313
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Sep 2025 17:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB8F284679;
	Mon, 15 Sep 2025 17:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="V6zTyWu9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C23B20296E
	for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 17:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757957378; cv=none; b=jGTBvP/iSrkA8ggQjEesEKBo3cZ5iT1+PClABmC/awiEtJWTm9KYx7w85LNgxKKj95tkUuL+Ok3NC+bAxpFAyb5sImgvOBKntAS1Zihz98XR6mZy6igMkBH/jl56BeVCxZZj/GuwZPHilwnihYoxMx6x8zGNsiRECg0O2RZcXmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757957378; c=relaxed/simple;
	bh=SKx0SDMzGEGtQSRWkXgMCwAfnAfzQZG5OzGc5YKWQjA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9j7eJTfg96FIzHLaUDpnLni4JlyvAhYdfm7fzcjEmyh76XyddLNNQmkm7FRaMf38A5yeILWwafLIXPCgM9LtTvy9jKXTPINAIiB0z7mUrVGIGYVX379ir6ZTZJIhpX21TKcUdMUtb5aCmmRaUi5vJfPD0YrIFSvClX4XDzObUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=V6zTyWu9; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-73400edf776so11351097b3.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Sep 2025 10:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1757957375; x=1758562175; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SKx0SDMzGEGtQSRWkXgMCwAfnAfzQZG5OzGc5YKWQjA=;
        b=V6zTyWu9nc3pmZa9flfETcxsYZRWDSSnM+w8osZz8i12ulJ6qT0jXFQEwfG4nmkYlT
         61ShUZ+qJy0Aov7zwMJRPNjoD+295cS5DB8fQK0AoXshtnPOy7SyUDEvUHhGQWxFqa93
         4EUOOqY6URbRbiveZROD+8yAYqFPOD/Np4g89IhtN2Obvur7xm9D/KpGMSycDrQq89ii
         4EV+RgZr/k/j3qBytb4hfjihx7Fw4+xN463sAjxnVYHAgNVIYCN5AoVOWXJuIT6Y/PYd
         sUnwzb9yNN8ArfhfYQmFucgJVs9qKgUHLNs0NC8/+drJ1Un+FIntWOwUkMaVXc/EdQ78
         CxFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757957375; x=1758562175;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKx0SDMzGEGtQSRWkXgMCwAfnAfzQZG5OzGc5YKWQjA=;
        b=IdB1eSxoke2zyFIlNGpIBLmHh3dh3+wIQJWocZmqCKdTFuqX/1ZAMM2/xFa24JZpg4
         FwqcoPW12Bc5/cu2EG+6c+woxmkd3+G4o8T1jZBpWdX3eicKMuY62HEUFBcwOgsPTtsZ
         wY1QxCBK5pgIJubpGaMEN5oZUotSNSh0GgqZXQrvoH+BsjoNESCelBO8I4kxeXz36iu1
         V4MWop1tFwRb/RZb3PgaQjqDRiDNjOyTxibqKOzDFe11wwzTm7sHMMQ00XDsmPm3Pekh
         YEqc8ncgs8Zsyw8gCTnUL67fNy0jHmx+p5oPbA0BQw6nBWv8yf8FNvQUfGWQkK1jpx7t
         /orw==
X-Forwarded-Encrypted: i=1; AJvYcCUQu3xYsa7zqPLC8Br2i8EWSTXF/CDUI6u5A0qWAkdRjTLAJHG6Lk+WSsNrNMCHTRzZNKNjlROtiWJdgWZv@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0QdIaGn+FxBeSJwYKBlOmtfsTngxLbkuOfOoMjzCcSj3ZZ3//
	hgUH1lrmWNFqpV/BlvzpALyYCqHBxsiRGpWeD1fA+K7TvIlay7nAyD+G/ulOaeHtT+ICTfjAdMt
	xOab2
X-Gm-Gg: ASbGncvx+19tYOBv4SiLa3k9iW/DkcirzmTroUKcNNgbc0vaTPg9thyjLaMDd8iE4Mx
	EWvFQhgk7Hvjoi4QAXtP6uY04ayRxE1Vl4R0cL4m7a5/xNcajXrYYeNn518Y5GmiwjRsSfBLYFo
	DcTkBPcS2KSVS2jbw7mXHvuK4O7iMFNPuq6vnHc4wevnnXZe/ugjWYsej62nZnsNyRej3E1zikP
	w6RjsbdXcqQKptZ7cpdxWsrgBjpJqULw3U4QVB8OrIXzKDvuxbTmeFBp55KxSeLT6rpPlIpJe3W
	HtKJO2HWDyD1p+cddA4WcKEf3AfMNXwZTFvdJmycUh5OFAuQiGnx4ljrikdkluToT+GXQjwgVp8
	okYn6s4XqupL0nHLCKEmykI5V9946HvnLYQ==
X-Google-Smtp-Source: AGHT+IGPKn4+jGesSUiZO0jTijIDdEva7DpZdoJBObAivP3wUGu0i5hbq3vkp5vUl5EeefXLqS00Dw==
X-Received: by 2002:a05:690c:a0ae:10b0:731:6570:121 with SMTP id 00721157ae682-73165700b66mr71193097b3.38.1757957374819;
        Mon, 15 Sep 2025 10:29:34 -0700 (PDT)
Received: from pop-os.attlocal.net ([2600:1700:6476:1430:f9f0:b170:b9db:2d53])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-72f769292d4sm34016457b3.27.2025.09.15.10.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Sep 2025 10:29:34 -0700 (PDT)
Message-ID: <979490b3e038d93aebccfa9a55e79d3f906e1bb5.camel@dubeyko.com>
Subject: Re: [Linux Kernel Bug] KASAN: slab-out-of-bounds Read in
 hfsplus_strcasecmp
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Jiaming Zhang <r772577952@gmail.com>, frank.li@vivo.com, 
	glaubitz@physik.fu-berlin.de, linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, syzkaller@googlegroups.com
Date: Mon, 15 Sep 2025 10:29:32 -0700
In-Reply-To: <CANypQFak7_YYBa_zpa8YmoYzekV_f39jvWJ-STudDUTR2-B_3Q@mail.gmail.com>
References: 
	<CANypQFak7_YYBa_zpa8YmoYzekV_f39jvWJ-STudDUTR2-B_3Q@mail.gmail.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-09-15 at 11:04 +0800, Jiaming Zhang wrote:
> Dear Linux kernel developers and maintainers:
>=20
> We are writing to report a slab-out-of-bounds bug discovered in the
> hfsplus subsystem with our modified syzkaller. This bug is
> reproducible on the latest version (v6.17-rc6, commit
> f83ec76bf285bea5727f478a68b894f5543ca76e).
>=20

Thank you for the report. Issue has been created:

https://github.com/hfs-linux-kernel/hfs-linux-kernel/issues/238

Thanks,
Slava.

> The kernel console output, kernel config, syzkaller reproducer, and C
> reproducer are attached to this email to help analysis. The KASAN
> report from v6.17-rc6, formatted by syz-symbolize, is listed below:
>=20
> hfsplus: invalid length 63743 has been corrected to 255
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: slab-out-of-bounds in hfsplus_strcasecmp+0x1bc/0x490
> fs/hfsplus/unicode.c:47
> Read of size 2 at addr ffff88804b8d640c by task repro.out/9757
>=20
> CPU: 1 UID: 0 PID: 9757 Comm: repro.out Not tainted 6.17.0-rc6 #1
> PREEMPT(full)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
> 04/01/2014
> Call Trace:
> =C2=A0<TASK>
> =C2=A0__dump_stack lib/dump_stack.c:94 [inline]
> =C2=A0dump_stack_lvl+0x1c1/0x2a0 lib/dump_stack.c:120
> =C2=A0print_address_description mm/kasan/report.c:378 [inline]
> =C2=A0print_report+0x17e/0x810 mm/kasan/report.c:482
> =C2=A0kasan_report+0x147/0x180 mm/kasan/report.c:595
> =C2=A0hfsplus_strcasecmp+0x1bc/0x490 fs/hfsplus/unicode.c:47
> =C2=A0hfs_find_rec_by_key+0xa6/0x1e0 fs/hfsplus/bfind.c:89
> =C2=A0__hfsplus_brec_find+0x18b/0x480 fs/hfsplus/bfind.c:124
> =C2=A0hfsplus_brec_find+0x289/0x500 fs/hfsplus/bfind.c:184
> =C2=A0hfsplus_brec_read+0x2b/0x120 fs/hfsplus/bfind.c:211
> =C2=A0hfsplus_lookup+0x2aa/0x890 fs/hfsplus/dir.c:52
> =C2=A0__lookup_slow+0x294/0x3d0 fs/namei.c:1808
> =C2=A0lookup_slow+0x53/0x70 fs/namei.c:1825
> =C2=A0walk_component+0x2d4/0x400 fs/namei.c:2129
> =C2=A0lookup_last fs/namei.c:2630 [inline]
> =C2=A0path_lookupat+0x163/0x430 fs/namei.c:2654
> =C2=A0filename_lookup+0x212/0x570 fs/namei.c:2683
> =C2=A0user_path_at+0x3a/0x60 fs/namei.c:3127
> =C2=A0ksys_umount fs/namespace.c:2112 [inline]
> =C2=A0__do_sys_umount fs/namespace.c:2120 [inline]
> =C2=A0__se_sys_umount fs/namespace.c:2118 [inline]
> =C2=A0__x64_sys_umount+0xee/0x160 fs/namespace.c:2118
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0xf3/0x3b0 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x452627
> Code: 06 00 48 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66
> 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 a6 00 00 00 0f 05 <48>
> 3d
> 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc5dd08ae8 EFLAGS: 00000206 ORIG_RAX:
> 00000000000000a6
> RAX: ffffffffffffffda RBX: 00000000004004a0 RCX: 0000000000452627
> RDX: 0000000000000009 RSI: 0000000000000009 RDI: 00007ffc5dd08b90
> RBP: 00007ffc5dd09bd0 R08: 0000000000000015 R09: 00007ffc5dd08980
> R10: 00000000004b9560 R11: 0000000000000206 R12: 000000000040a070
> R13: 0000000000000000 R14: 00000000004bc018 R15: 00000000004004a0
> =C2=A0</TASK>
>=20
> Allocated by task 9757:
> =C2=A0kasan_save_stack mm/kasan/common.c:47 [inline]
> =C2=A0kasan_save_track+0x3e/0x80 mm/kasan/common.c:68
> =C2=A0poison_kmalloc_redzone mm/kasan/common.c:388 [inline]
> =C2=A0__kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:405
> =C2=A0kasan_kmalloc include/linux/kasan.h:260 [inline]
> =C2=A0__do_kmalloc_node mm/slub.c:4376 [inline]
> =C2=A0__kmalloc_noprof+0x27a/0x4f0 mm/slub.c:4388
> =C2=A0kmalloc_noprof include/linux/slab.h:909 [inline]
> =C2=A0hfsplus_find_init+0x8c/0x1d0 fs/hfsplus/bfind.c:21
> =C2=A0hfsplus_lookup+0x19c/0x890 fs/hfsplus/dir.c:44
> =C2=A0__lookup_slow+0x294/0x3d0 fs/namei.c:1808
> =C2=A0lookup_slow+0x53/0x70 fs/namei.c:1825
> =C2=A0walk_component+0x2d4/0x400 fs/namei.c:2129
> =C2=A0lookup_last fs/namei.c:2630 [inline]
> =C2=A0path_lookupat+0x163/0x430 fs/namei.c:2654
> =C2=A0filename_lookup+0x212/0x570 fs/namei.c:2683
> =C2=A0user_path_at+0x3a/0x60 fs/namei.c:3127
> =C2=A0ksys_umount fs/namespace.c:2112 [inline]
> =C2=A0__do_sys_umount fs/namespace.c:2120 [inline]
> =C2=A0__se_sys_umount fs/namespace.c:2118 [inline]
> =C2=A0__x64_sys_umount+0xee/0x160 fs/namespace.c:2118
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0xf3/0x3b0 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> The buggy address belongs to the object at ffff88804b8d6000
> =C2=A0which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 0 bytes to the right of
> =C2=A0allocated 1036-byte region [ffff88804b8d6000, ffff88804b8d640c)
>=20
> The buggy address belongs to the physical page:
> page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
> pfn:0x4b8d0
> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0
> pincount:0
> anon flags: 0x4fff00000000040(head|node=3D1|zone=3D1|lastcpupid=3D0x7ff)
> page_type: f5(slab)
> raw: 04fff00000000040 ffff88801a442000 0000000000000000
> dead000000000001
> raw: 0000000000000000 0000000080080008 00000000f5000000
> 0000000000000000
> head: 04fff00000000040 ffff88801a442000 0000000000000000
> dead000000000001
> head: 0000000000000000 0000000080080008 00000000f5000000
> 0000000000000000
> head: 04fff00000000003 ffffea00012e3401 00000000ffffffff
> 00000000ffffffff
> head: ffffffffffffffff 0000000000000000 00000000ffffffff
> 0000000000000008
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask
> 0xd2040(__GFP_IO|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALL
> OC),
> pid 8133, tgid 8133 (sh), ts 23500816499, free_ts 23484371257
> =C2=A0set_page_owner include/linux/page_owner.h:32 [inline]
> =C2=A0post_alloc_hook+0x240/0x2a0 mm/page_alloc.c:1851
> =C2=A0prep_new_page mm/page_alloc.c:1859 [inline]
> =C2=A0get_page_from_freelist+0x21e4/0x22c0 mm/page_alloc.c:3858
> =C2=A0__alloc_frozen_pages_noprof+0x181/0x370 mm/page_alloc.c:5148
> =C2=A0alloc_pages_mpol+0x232/0x4a0 mm/mempolicy.c:2416
> =C2=A0alloc_slab_page mm/slub.c:2492 [inline]
> =C2=A0allocate_slab+0x8a/0x370 mm/slub.c:2660
> =C2=A0new_slab mm/slub.c:2714 [inline]
> =C2=A0___slab_alloc+0xbeb/0x1420 mm/slub.c:3901
> =C2=A0__slab_alloc mm/slub.c:3992 [inline]
> =C2=A0__slab_alloc_node mm/slub.c:4067 [inline]
> =C2=A0slab_alloc_node mm/slub.c:4228 [inline]
> =C2=A0__do_kmalloc_node mm/slub.c:4375 [inline]
> =C2=A0__kmalloc_noprof+0x305/0x4f0 mm/slub.c:4388
> =C2=A0kmalloc_noprof include/linux/slab.h:909 [inline]
> =C2=A0kzalloc_noprof include/linux/slab.h:1039 [inline]
> =C2=A0tomoyo_init_log+0x1a32/0x1f30 security/tomoyo/audit.c:275
> =C2=A0tomoyo_supervisor+0x340/0x1490 security/tomoyo/common.c:2198
> =C2=A0tomoyo_audit_env_log security/tomoyo/environ.c:36 [inline]
> =C2=A0tomoyo_env_perm+0x149/0x1e0 security/tomoyo/environ.c:63
> =C2=A0tomoyo_environ security/tomoyo/domain.c:672 [inline]
> =C2=A0tomoyo_find_next_domain+0x15cf/0x1aa0 security/tomoyo/domain.c:888
> =C2=A0tomoyo_bprm_check_security+0x11c/0x180 security/tomoyo/tomoyo.c:102
> =C2=A0security_bprm_check+0x89/0x270 security/security.c:1302
> =C2=A0search_binary_handler fs/exec.c:1660 [inline]
> =C2=A0exec_binprm fs/exec.c:1702 [inline]
> =C2=A0bprm_execve+0x8ee/0x1450 fs/exec.c:1754
> =C2=A0do_execveat_common+0x521/0x6b0 fs/exec.c:1860
> =C2=A0do_execve fs/exec.c:1934 [inline]
> =C2=A0__do_sys_execve fs/exec.c:2010 [inline]
> =C2=A0__se_sys_execve fs/exec.c:2005 [inline]
> =C2=A0__x64_sys_execve+0x94/0xb0 fs/exec.c:2005
> page last free pid 5289 tgid 5289 stack trace:
> =C2=A0reset_page_owner include/linux/page_owner.h:25 [inline]
> =C2=A0free_pages_prepare mm/page_alloc.c:1395 [inline]
> =C2=A0__free_frozen_pages+0xbc0/0xd40 mm/page_alloc.c:2895
> =C2=A0discard_slab mm/slub.c:2758 [inline]
> =C2=A0__put_partials+0x156/0x1a0 mm/slub.c:3223
> =C2=A0put_cpu_partial+0x17c/0x250 mm/slub.c:3298
> =C2=A0__slab_free+0x2d5/0x3c0 mm/slub.c:4565
> =C2=A0qlink_free mm/kasan/quarantine.c:163 [inline]
> =C2=A0qlist_free_all+0x97/0x140 mm/kasan/quarantine.c:179
> =C2=A0kasan_quarantine_reduce+0x148/0x160 mm/kasan/quarantine.c:286
> =C2=A0__kasan_slab_alloc+0x22/0x80 mm/kasan/common.c:340
> =C2=A0kasan_slab_alloc include/linux/kasan.h:250 [inline]
> =C2=A0slab_post_alloc_hook mm/slub.c:4191 [inline]
> =C2=A0slab_alloc_node mm/slub.c:4240 [inline]
> =C2=A0kmem_cache_alloc_node_noprof+0x1bb/0x3c0 mm/slub.c:4292
> =C2=A0__alloc_skb+0x12a/0x2f0 net/core/skbuff.c:659
> =C2=A0netlink_sendmsg+0x5c6/0xb30 net/netlink/af_netlink.c:1871
> =C2=A0sock_sendmsg_nosec net/socket.c:714 [inline]
> =C2=A0__sock_sendmsg+0x219/0x270 net/socket.c:729
> =C2=A0____sys_sendmsg+0x507/0x840 net/socket.c:2614
> =C2=A0___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
> =C2=A0__sys_sendmsg net/socket.c:2700 [inline]
> =C2=A0__do_sys_sendmsg net/socket.c:2705 [inline]
> =C2=A0__se_sys_sendmsg net/socket.c:2703 [inline]
> =C2=A0__x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
> =C2=A0do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> =C2=A0do_syscall_64+0xf3/0x3b0 arch/x86/entry/syscall_64.c:94
> =C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f
>=20
> Memory state around the buggy address:
> =C2=A0ffff88804b8d6300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> =C2=A0ffff88804b8d6380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> > ffff88804b8d6400: 00 04 fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^
> =C2=A0ffff88804b8d6480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> =C2=A0ffff88804b8d6500: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> Please let me know if any further information is required.
>=20
> Best Regards,
> Jiaming Zhang.

