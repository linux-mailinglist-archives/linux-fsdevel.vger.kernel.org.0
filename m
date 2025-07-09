Return-Path: <linux-fsdevel+bounces-54385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBF4AFF0BC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 20:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA8C41C42A9A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 18:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529682367AF;
	Wed,  9 Jul 2025 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="1XtU5UEh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145CE1CD1E4
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 18:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752085167; cv=none; b=mEYNsaXl8eSF7voLV+WU/HAD2RAOiWpyToAG0UcFwpjp0R7Y1QwNzx+9VDy86UDxPpNMdmKvX7a6wQPqx9Cm4Uc1jFzHMGqXPiEePgY+qeXHVLkvoaFBDerUEtN6LtYQjUHeOji5NjgrvCEY5Z3ikyksEaj+5wt4hcDDANz9OIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752085167; c=relaxed/simple;
	bh=pzf5RjzHvut3dfvHH69cAnHVpQZj0VzC7pDrIz+JNfY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IlhyU7K3Dwe54Rk///38W/IyZFAyStZIkrt0FVZktipSEYD8VCox/+WsO+3W+JutrtXuQKuL8aBXnyn/AyJ4f8AQjLYAueDvDiJwmgTVe+MVkVX3heBeAgZ7bvzs3MNmz3N77FAN4lIcGSiDA+N9TqpB9ouCSCDK/BYw3UisdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=1XtU5UEh; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8b3cc05665so87782276.2
        for <linux-fsdevel@vger.kernel.org>; Wed, 09 Jul 2025 11:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1752085164; x=1752689964; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aLD0Ollwxymd2kHnc0V2FEdYCktVSCuZPJJz9s5MBpI=;
        b=1XtU5UEh5lAkhuJs1cIBuF3jDq90i7lkzwPAKAg8WBT7OTC9XqUfjA77zkWCZcqw40
         wq5W9+KBN0HiRPs3Ok29qO1IaEObxPTd4VTtudghgEka/SN/WHqdIU2m7X+gcV2av51E
         6Ju+k3M3TPbUUMQ3b/PEnMZ5nT3V3rXjhECmkiYqByJoP/ii3OUQNybiERb0TViOQCPH
         HeLrJT//WBEiEI/C40y1uvT1aL1EN1WZIZM01xI+d24h/yqXj9ZhVs3ysDL3ZmmpJgRo
         VmPhDXo2h+yMylFdtLkBHN0FNNVUDaqn8mVAPaYKolZ0GB0YGsY9/v/mBPotm/P9xbWx
         1mPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752085164; x=1752689964;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aLD0Ollwxymd2kHnc0V2FEdYCktVSCuZPJJz9s5MBpI=;
        b=NiG6FCWPU0aKIDaLHhq80YtLwNqYVWX0S0XeICSTZsU8ZkWznTSPqbbWOmPHey0uiR
         PXzcTe4zX920pD0AMNKm+JEFp1JNgDN5FmrVhIZbOtiWEv6vbMY+irhBf8ZPhEphdLne
         9kEhWBR6bFmSKVT3eOnYFp5ydBnEJ1FgZP7kL1zpAGIFf8uUq4dqiNOCW+H+LGPsDlsS
         LDuES2/cjQ/dff4++h6itnrGLd/uR0QNHJWRFisdXJ85fqfKqgJXvQqpdCt0pBhDSEv/
         D3KHZYlyHLFJzJmVjPhD/Y3W9Gmg07V+0SzlEc+NRQq6i1njumoxyto5WxmNwGXH2rXW
         iUcA==
X-Forwarded-Encrypted: i=1; AJvYcCVgHdyaz8CYOBh38Oud7U5mk9LiCFy/v94vEaoneud6gy73hdTlf/TRBYWEDMwh4Xm5T/3NWBgnH2Iv9Tus@vger.kernel.org
X-Gm-Message-State: AOJu0YzSGpy4GQDy244f4AhuBZ0/eJ6V2J2XDpGSlMn1652hI5A1RrMr
	nZSNaWWrZc6Ors0A4ffhZdWvDLt+uu9Q+HZblkJm4Uh0jFpYJs9BdM/ycS00JRY15r0=
X-Gm-Gg: ASbGncu2jJmsAsKkkwjzIQtQHASephSabAUVqy+V3OEq1hxEMA1NYuzeFLSoUiNeyG2
	HHSr4CmQ5Xp5yHnQtlTKyYtuWWtPDTbrWqUAVxzCecgjGbZKPSY52j7MBrb9635HkuZjxL4TkOd
	vuOgPZpCCHnohK+c06pxtn69Eo1CTU2Utux/4yavOUw6zJxKZEj+UJiAV/ZFoaTfMmT88CvIMWT
	/kzBBAFT2ztjyJHbL+nJMsCyX66/KOIwZhFj2HKnkUBKM7EYhPyALBnv5P9ZgrIgvqbDfiNZOno
	mjEyiL92jYa5qI0KMGZVgF4PfXYWznRln5Bc5k1Ut1Sf+jBrOQeoJchhfQV/YOQJH4A8zOoHaEa
	dU/g2GKVAdjCFy3o2W9JQptZDiBGKIQc=
X-Google-Smtp-Source: AGHT+IHcpUJVH3ioBDRkkAeXl/q+91ljPbp2A50FA3yXFNUkPgCC8qvDzwO2T5D2QU5mHnuxkEoHIQ==
X-Received: by 2002:a05:690c:63c8:b0:714:429:edc5 with SMTP id 00721157ae682-717c15f648emr6731437b3.4.1752085163551;
        Wed, 09 Jul 2025 11:19:23 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:a196:5446:bfe:6b17? ([2600:1700:6476:1430:a196:5446:bfe:6b17])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-716659a160asm26694087b3.42.2025.07.09.11.19.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 11:19:22 -0700 (PDT)
Message-ID: <26aabd1abacf57d2755cd0d04de7d7f0203d02b8.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix slab-out-of-bounds read in
 hfsplus_uni2asc()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, wenzhi.wang@uwaterloo.ca
Cc: Slava.Dubeyko@ibm.com
Date: Wed, 09 Jul 2025 11:19:21 -0700
In-Reply-To: <29d9127f-037b-46fe-8616-89d3526b64ae@vivo.com>
References: <20250703184150.239589-1-slava@dubeyko.com>
	 <29d9127f-037b-46fe-8616-89d3526b64ae@vivo.com>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.1 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-07-09 at 13:10 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> =E5=9C=A8 2025/7/4 02:41, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > The hfsplus_readdir() method is capable to crash by calling
> > hfsplus_uni2asc():
> >=20
> > [=C2=A0 667.121659][ T9805]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > [=C2=A0 667.122651][ T9805] BUG: KASAN: slab-out-of-bounds in
> > hfsplus_uni2asc+0x902/0xa10
> > [=C2=A0 667.123627][ T9805] Read of size 2 at addr ffff88802592f40c by
> > task repro/9805
> > [=C2=A0 667.124578][ T9805]
> > [=C2=A0 667.124876][ T9805] CPU: 3 UID: 0 PID: 9805 Comm: repro Not
> > tainted 6.16.0-rc3 #1 PREEMPT(full)
> > [=C2=A0 667.124886][ T9805] Hardware name: QEMU Ubuntu 24.04 PC (i440FX
> > + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [=C2=A0 667.124890][ T9805] Call Trace:
> > [=C2=A0 667.124893][ T9805]=C2=A0 <TASK>
> > [=C2=A0 667.124896][ T9805]=C2=A0 dump_stack_lvl+0x10e/0x1f0
> > [=C2=A0 667.124911][ T9805]=C2=A0 print_report+0xd0/0x660
> > [=C2=A0 667.124920][ T9805]=C2=A0 ? __virt_addr_valid+0x81/0x610
> > [=C2=A0 667.124928][ T9805]=C2=A0 ? __phys_addr+0xe8/0x180
> > [=C2=A0 667.124934][ T9805]=C2=A0 ? hfsplus_uni2asc+0x902/0xa10
> > [=C2=A0 667.124942][ T9805]=C2=A0 kasan_report+0xc6/0x100
> > [=C2=A0 667.124950][ T9805]=C2=A0 ? hfsplus_uni2asc+0x902/0xa10
> > [=C2=A0 667.124959][ T9805]=C2=A0 hfsplus_uni2asc+0x902/0xa10
> > [=C2=A0 667.124966][ T9805]=C2=A0 ? hfsplus_bnode_read+0x14b/0x360
> > [=C2=A0 667.124974][ T9805]=C2=A0 hfsplus_readdir+0x845/0xfc0
> > [=C2=A0 667.124984][ T9805]=C2=A0 ? __pfx_hfsplus_readdir+0x10/0x10
> > [=C2=A0 667.124994][ T9805]=C2=A0 ? stack_trace_save+0x8e/0xc0
> > [=C2=A0 667.125008][ T9805]=C2=A0 ? iterate_dir+0x18b/0xb20
> > [=C2=A0 667.125015][ T9805]=C2=A0 ? trace_lock_acquire+0x85/0xd0
> > [=C2=A0 667.125022][ T9805]=C2=A0 ? lock_acquire+0x30/0x80
> > [=C2=A0 667.125029][ T9805]=C2=A0 ? iterate_dir+0x18b/0xb20
> > [=C2=A0 667.125037][ T9805]=C2=A0 ? down_read_killable+0x1ed/0x4c0
> > [=C2=A0 667.125044][ T9805]=C2=A0 ? putname+0x154/0x1a0
> > [=C2=A0 667.125051][ T9805]=C2=A0 ? __pfx_down_read_killable+0x10/0x10
> > [=C2=A0 667.125058][ T9805]=C2=A0 ? apparmor_file_permission+0x239/0x3e=
0
> > [=C2=A0 667.125069][ T9805]=C2=A0 iterate_dir+0x296/0xb20
> > [=C2=A0 667.125076][ T9805]=C2=A0 __x64_sys_getdents64+0x13c/0x2c0
> > [=C2=A0 667.125084][ T9805]=C2=A0 ? __pfx___x64_sys_getdents64+0x10/0x1=
0
> > [=C2=A0 667.125091][ T9805]=C2=A0 ? __x64_sys_openat+0x141/0x200
> > [=C2=A0 667.125126][ T9805]=C2=A0 ? __pfx_filldir64+0x10/0x10
> > [=C2=A0 667.125134][ T9805]=C2=A0 ? do_user_addr_fault+0x7fe/0x12f0
> > [=C2=A0 667.125143][ T9805]=C2=A0 do_syscall_64+0xc9/0x480
> > [=C2=A0 667.125151][ T9805]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0=
x7f
> > [=C2=A0 667.125158][ T9805] RIP: 0033:0x7fa8753b2fc9
> > [=C2=A0 667.125164][ T9805] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0=
f
> > 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 48
> > [=C2=A0 667.125172][ T9805] RSP: 002b:00007ffe96f8e0f8 EFLAGS: 00000217
> > ORIG_RAX: 00000000000000d9
> > [=C2=A0 667.125181][ T9805] RAX: ffffffffffffffda RBX: 0000000000000000
> > RCX: 00007fa8753b2fc9
> > [=C2=A0 667.125185][ T9805] RDX: 0000000000000400 RSI: 00002000000063c0
> > RDI: 0000000000000004
> > [=C2=A0 667.125190][ T9805] RBP: 00007ffe96f8e110 R08: 00007ffe96f8e110
> > R09: 00007ffe96f8e110
> > [=C2=A0 667.125195][ T9805] R10: 0000000000000000 R11: 0000000000000217
> > R12: 0000556b1e3b4260
> > [=C2=A0 667.125199][ T9805] R13: 0000000000000000 R14: 0000000000000000
> > R15: 0000000000000000
> > [=C2=A0 667.125207][ T9805]=C2=A0 </TASK>
> > [=C2=A0 667.125210][ T9805]
> > [=C2=A0 667.145632][ T9805] Allocated by task 9805:
> > [=C2=A0 667.145991][ T9805]=C2=A0 kasan_save_stack+0x20/0x40
> > [=C2=A0 667.146352][ T9805]=C2=A0 kasan_save_track+0x14/0x30
> > [=C2=A0 667.146717][ T9805]=C2=A0 __kasan_kmalloc+0xaa/0xb0
> > [=C2=A0 667.147065][ T9805]=C2=A0 __kmalloc_noprof+0x205/0x550
> > [=C2=A0 667.147448][ T9805]=C2=A0 hfsplus_find_init+0x95/0x1f0
> > [=C2=A0 667.147813][ T9805]=C2=A0 hfsplus_readdir+0x220/0xfc0
> > [=C2=A0 667.148174][ T9805]=C2=A0 iterate_dir+0x296/0xb20
> > [=C2=A0 667.148549][ T9805]=C2=A0 __x64_sys_getdents64+0x13c/0x2c0
> > [=C2=A0 667.148937][ T9805]=C2=A0 do_syscall_64+0xc9/0x480
> > [=C2=A0 667.149291][ T9805]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0=
x7f
> > [=C2=A0 667.149809][ T9805]
> > [=C2=A0 667.150030][ T9805] The buggy address belongs to the object at
> > ffff88802592f000
> > [=C2=A0 667.150030][ T9805]=C2=A0 which belongs to the cache kmalloc-2k=
 of
> > size 2048
> > [=C2=A0 667.151282][ T9805] The buggy address is located 0 bytes to the
> > right of
> > [=C2=A0 667.151282][ T9805]=C2=A0 allocated 1036-byte region
> > [ffff88802592f000, ffff88802592f40c)
> > [=C2=A0 667.152580][ T9805]
> > [=C2=A0 667.152798][ T9805] The buggy address belongs to the physical
> > page:
> > [=C2=A0 667.153373][ T9805] page: refcount:0 mapcount:0
> > mapping:0000000000000000 index:0x0 pfn:0x25928
> > [=C2=A0 667.154157][ T9805] head: order:3 mapcount:0 entire_mapcount:0
> > nr_pages_mapped:0 pincount:0
> > [=C2=A0 667.154916][ T9805] anon flags:
> > 0xfff00000000040(head|node=3D0|zone=3D1|lastcpupid=3D0x7ff)
> > [=C2=A0 667.155631][ T9805] page_type: f5(slab)
> > [=C2=A0 667.155997][ T9805] raw: 00fff00000000040 ffff88801b442f00
> > 0000000000000000 dead000000000001
> > [=C2=A0 667.156770][ T9805] raw: 0000000000000000 0000000080080008
> > 00000000f5000000 0000000000000000
> > [=C2=A0 667.157536][ T9805] head: 00fff00000000040 ffff88801b442f00
> > 0000000000000000 dead000000000001
> > [=C2=A0 667.158317][ T9805] head: 0000000000000000 0000000080080008
> > 00000000f5000000 0000000000000000
> > [=C2=A0 667.159088][ T9805] head: 00fff00000000003 ffffea0000964a01
> > 00000000ffffffff 00000000ffffffff
> > [=C2=A0 667.159865][ T9805] head: ffffffffffffffff 0000000000000000
> > 00000000ffffffff 0000000000000008
> > [=C2=A0 667.160643][ T9805] page dumped because: kasan: bad access
> > detected
> > [=C2=A0 667.161216][ T9805] page_owner tracks the page as allocated
> > [=C2=A0 667.161732][ T9805] page last allocated via order 3, migratetyp=
e
> > Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN9
> > [=C2=A0 667.163566][ T9805]=C2=A0 post_alloc_hook+0x1c0/0x230
> > [=C2=A0 667.164003][ T9805]=C2=A0 get_page_from_freelist+0xdeb/0x3b30
> > [=C2=A0 667.164503][ T9805]=C2=A0 __alloc_frozen_pages_noprof+0x25c/0x2=
460
> > [=C2=A0 667.165040][ T9805]=C2=A0 alloc_pages_mpol+0x1fb/0x550
> > [=C2=A0 667.165489][ T9805]=C2=A0 new_slab+0x23b/0x340
> > [=C2=A0 667.165872][ T9805]=C2=A0 ___slab_alloc+0xd81/0x1960
> > [=C2=A0 667.166313][ T9805]=C2=A0 __slab_alloc.isra.0+0x56/0xb0
> > [=C2=A0 667.166767][ T9805]=C2=A0 __kmalloc_cache_noprof+0x255/0x3e0
> > [=C2=A0 667.167255][ T9805]=C2=A0 psi_cgroup_alloc+0x52/0x2d0
> > [=C2=A0 667.167693][ T9805]=C2=A0 cgroup_mkdir+0x694/0x1210
> > [=C2=A0 667.168118][ T9805]=C2=A0 kernfs_iop_mkdir+0x111/0x190
> > [=C2=A0 667.168568][ T9805]=C2=A0 vfs_mkdir+0x59b/0x8d0
> > [=C2=A0 667.168956][ T9805]=C2=A0 do_mkdirat+0x2ed/0x3d0
> > [=C2=A0 667.169353][ T9805]=C2=A0 __x64_sys_mkdir+0xef/0x140
> > [=C2=A0 667.169784][ T9805]=C2=A0 do_syscall_64+0xc9/0x480
> > [=C2=A0 667.170195][ T9805]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0=
x7f
> > [=C2=A0 667.170730][ T9805] page last free pid 1257 tgid 1257 stack
> > trace:
> > [=C2=A0 667.171304][ T9805]=C2=A0 __free_frozen_pages+0x80c/0x1250
> > [=C2=A0 667.171770][ T9805]=C2=A0 vfree.part.0+0x12b/0xab0
> > [=C2=A0 667.172182][ T9805]=C2=A0 delayed_vfree_work+0x93/0xd0
> > [=C2=A0 667.172612][ T9805]=C2=A0 process_one_work+0x9b5/0x1b80
> > [=C2=A0 667.173067][ T9805]=C2=A0 worker_thread+0x630/0xe60
> > [=C2=A0 667.173486][ T9805]=C2=A0 kthread+0x3a8/0x770
> > [=C2=A0 667.173857][ T9805]=C2=A0 ret_from_fork+0x517/0x6e0
> > [=C2=A0 667.174278][ T9805]=C2=A0 ret_from_fork_asm+0x1a/0x30
> > [=C2=A0 667.174703][ T9805]
> > [=C2=A0 667.174917][ T9805] Memory state around the buggy address:
> > [=C2=A0 667.175411][ T9805]=C2=A0 ffff88802592f300: 00 00 00 00 00 00 0=
0 00
> > 00 00 00 00 00 00 00 00
> > [=C2=A0 667.176114][ T9805]=C2=A0 ffff88802592f380: 00 00 00 00 00 00 0=
0 00
> > 00 00 00 00 00 00 00 00
> > [=C2=A0 667.176830][ T9805] >ffff88802592f400: 00 04 fc fc fc fc fc fc
> > fc fc fc fc fc fc fc fc
> > [=C2=A0 667.177547][ T9805]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 ^
> > [=C2=A0 667.177933][ T9805]=C2=A0 ffff88802592f480: fc fc fc fc fc fc f=
c fc
> > fc fc fc fc fc fc fc fc
> > [=C2=A0 667.178640][ T9805]=C2=A0 ffff88802592f500: fc fc fc fc fc fc f=
c fc
> > fc fc fc fc fc fc fc fc
> > [=C2=A0 667.179350][ T9805]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > The hfsplus_uni2asc() method operates by struct hfsplus_unistr:
> >=20
> > struct hfsplus_unistr {
> > 	__be16 length;
> > 	hfsplus_unichr unicode[HFSPLUS_MAX_STRLEN];
> > } __packed;
> >=20
> > where HFSPLUS_MAX_STRLEN is 255 bytes. The issue happens if length
> > of the structure instance has value bigger than 255 (for example,
> > 65283). In such case, pointer on unicode buffer is going beyond of
> > the allocated memory.
> >=20
> > The patch fixes the issue by checking the length value of
> > hfsplus_unistr instance and using 255 value in the case if length
> > value is bigger than HFSPLUS_MAX_STRLEN. Potential reason of such
> > situation could be a corruption of Catalog File b-tree's node.
> >=20
> > Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > ---
> > =C2=A0 fs/hfsplus/unicode.c | 4 ++++
> > =C2=A0 1 file changed, 4 insertions(+)
> >=20
> > diff --git a/fs/hfsplus/unicode.c b/fs/hfsplus/unicode.c
> > index 73342c925a4b..7e62b3630fcd 100644
> > --- a/fs/hfsplus/unicode.c
> > +++ b/fs/hfsplus/unicode.c
> > @@ -132,7 +132,11 @@ int hfsplus_uni2asc(struct super_block *sb,
> > =C2=A0=20
> > =C2=A0=C2=A0	op =3D astr;
> > =C2=A0=C2=A0	ip =3D ustr->unicode;
> > +
> > =C2=A0=C2=A0	ustrlen =3D be16_to_cpu(ustr->length);
> > +	if (ustrlen > HFSPLUS_MAX_STRLEN)
> > +		ustrlen =3D HFSPLUS_MAX_STRLEN;
> > +
> > =C2=A0=C2=A0	len =3D *len_p;
> > =C2=A0=C2=A0	ce1 =3D NULL;
> > =C2=A0=C2=A0	compose =3D !test_bit(HFSPLUS_SB_NODECOMPOSE,
> > &HFSPLUS_SB(sb)->flags);
>=20
> I found that Liu Shixin already sent a similar patch [1].
>=20
> =C2=A0From [2], Long file names for hfsplus is 255 characters.
>=20
> Could we mark it as EIO?
>=20

The returning of -EIO was my first solution. But if we return -EIO,
then hfsplus_readdir() stop the iteration of names in folder. Even if
we have some issue or corruption, then it makes sense to show all names
in the folder but not to break the names iteration. Probably, we could
add the error message here to warn that something is going wrong here.

Thanks,
Slava.

