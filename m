Return-Path: <linux-fsdevel+bounces-56158-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A51FBB142AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 22:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FF867A94AC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Jul 2025 19:59:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC9121D585;
	Mon, 28 Jul 2025 20:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="CzT+fijz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE661EB5B
	for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 20:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753732847; cv=none; b=Wc2Elvr1JpcX78Cf5y1/9p4nnLYMi+GKTBjpWg+3ftwWUYQa35ZyT/1o6ioJ8I1teP/QnIjpu/H3huzzgQhzhOp2TG6UzvnBjt7zrjSDibNYnu3jqmfsn4dHhKIjujUwGRiGaSGaf0q42/zqKM66OnHOfdCh8ElQ4hScAguCxsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753732847; c=relaxed/simple;
	bh=PleguoDTxtEXi6KFUTjw5elvIUtSRUBhEGENQnSQ+rc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FTIhM8eWUfQ7PLRz2fgJRskqu4uEmTTpig+B24N6efpYVtQp2gNXc7fpGhamG71+pTmJ/Haz9EOfmOXW04sFxeJxbA1Iz52NU1Rtv1iZg6OZQqb6CibdecJXsufSYroT80eRVhzqWxCuqJ/iNkFsl4DhXX0xA2dZBRRGDiYCadA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=CzT+fijz; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-713fba639f3so39303017b3.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Jul 2025 13:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1753732844; x=1754337644; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glxwVREGcgfYH4JC/a5Dj8aLRO6ELtBTXdQxfvU6b28=;
        b=CzT+fijzynzBiO1+zYj0NL7kf2HXC0RpWkcLFQstoy/IqDZ99m+F1UGc52HevYFqRt
         dAC8vLyoiHZ2b2XuG/zUoZbjAJImwPzRvZ9ZY+U4u+e9h6r3CoTyW3cBhIug4cP/eulm
         0w0brWFFZ3CeXMCS9PWvrcUi6+oJ/P8y7NRF6O2F5+59BzOKbgBU9HmS4HdL/bcC3NTc
         3s/lszno+N4oIcnmH3JoOWILkP08B0ykvQFDdL6ydvri7g98BwjnGDDmyhRCtOX4BpHv
         HxCpyczWXp/1XR3nqcOzYhJn/9jky0ZKxtXH6xexczM+knISHG1oBiUIgbt2Tf1dEFUf
         RtEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753732844; x=1754337644;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glxwVREGcgfYH4JC/a5Dj8aLRO6ELtBTXdQxfvU6b28=;
        b=tggfw+tGOLa8gWytKeCP+yG4tgdWxRMdRIXUe6B3Su0ZZDuNKlS0+bLuKqpxTFiFiu
         bQX9/1ivSmvOKU0ub9AuiQihNeWrg7zN1qLWYWLv5uzjxQPhiv1a1LM3KX4FBbDRRGoX
         tT1k+5/pxu+2EOrlgN6CnWZM4Zj4uTn9B8i0BNQW1YlQvdXhxfHXBcCg1QW0dRDycdQD
         7BO7xQQrfzcNxPu3zt3T1l7qAxJOy8f+7m9lElwEsTjN9gDZ98ybjmiDL+L9ppDXQ2DB
         EwY4ZCgghbTYd6Npvvu35BfceBGTkXArdBRNzlJCeMDpdf9/wKnWLXWaeTYCCgMHuWry
         5D4A==
X-Forwarded-Encrypted: i=1; AJvYcCU37cJISUTcVAc/DlsacIJfQSoxkolD5lZJLK0khTSBfh+A+yCWo8YuT6J3ae46g/DSdAl/hwotKzkOOtPa@vger.kernel.org
X-Gm-Message-State: AOJu0YwwWOfe+bRZIXJUBJ4nf7B+t2mv2PFjAY+nzMng4rgMb4GDaVF/
	FZ9oYj89u9tUYngdW9/I7NDHkqyUS8G6mvLi0Yjog03i2ii45iWwJG0Pr8WzJG3vtChyg463njj
	C4IS8
X-Gm-Gg: ASbGncuQRzMFGLpLpCv3HN9VXQuQ/tOJ0Es/Jd8QFlOYY/S18UZ9IyoSPFqAppbNE/Y
	sienars3HudJlc8nt8c3NeC5HhEFmPioiilfCatuUyZFj0ebOXtSS53Eu84y/hOqDgoZ9WKMz2d
	fQR8lrK1waHvNupfCJCGiJCOUYuLq7ZG886Z8USvVbcX78oaJiKgUUTa9bFjxEDzPu6XxabLENV
	c5ykxYLP4gobXqy6YwZOz4fWXof4y+WPE6bFj/D9l9CZssDQxbGAqPq069Z3aynQPiT/xJq9bQD
	87FqJIt3iRBUT1TRcBB/gp7szgMkD45xRgVg7/IoZAtse7kYgqhMqrAFH8tpUGPe6j38E+84ZSP
	M/9KJ8C2kYUDdRtfFxA2Y7G12cuSeEXFy2b6+WRcjFxVdtOI5Elc+nKb2GedAJXgWxtc=
X-Google-Smtp-Source: AGHT+IEdoqUfdswejpj95Yckf94sXXaZE+aX8G4BoaGkm1ix/JkR7KDs2iSrTCjIWGHMk84qLGylgw==
X-Received: by 2002:a05:690c:6211:b0:6fb:1c5a:80ea with SMTP id 00721157ae682-719e34466c9mr171209507b3.32.1753732843667;
        Mon, 28 Jul 2025 13:00:43 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:38e:fb39:4709:1385? ([2600:1700:6476:1430:38e:fb39:4709:1385])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-719f241325asm14008587b3.101.2025.07.28.13.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 13:00:42 -0700 (PDT)
Message-ID: <3a2bed4b86d8000695d86c3956e3d5cd6cc92601.camel@dubeyko.com>
Subject: Re: [PATCH] hfs: fix general protection fault in hfs_find_init()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org, wenzhi.wang@uwaterloo.ca
Cc: Slava.Dubeyko@ibm.com
Date: Mon, 28 Jul 2025 13:00:41 -0700
In-Reply-To: <feb8ff05-90a9-4ab4-a820-99118918cd2b@vivo.com>
References: <20250710213657.108285-1-slava@dubeyko.com>
	 <feb8ff05-90a9-4ab4-a820-99118918cd2b@vivo.com>
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

On Mon, 2025-07-28 at 14:17 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> Sorry for the late reply.
>=20
> =E5=9C=A8 2025/7/11 05:36, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > The hfs_find_init() method can trigger the crash
> > if tree pointer is NULL:
> >=20
> > [=C2=A0=C2=A0 45.746290][ T9787] Oops: general protection fault, probab=
ly for
> > non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KAI
> > [=C2=A0=C2=A0 45.747287][ T9787] KASAN: null-ptr-deref in range
> > [0x0000000000000040-0x0000000000000047]
> > [=C2=A0=C2=A0 45.748716][ T9787] CPU: 2 UID: 0 PID: 9787 Comm: repro No=
t
> > tainted 6.16.0-rc3 #10 PREEMPT(full)
> > [=C2=A0=C2=A0 45.750250][ T9787] Hardware name: QEMU Ubuntu 24.04 PC (i=
440FX
> > + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [=C2=A0=C2=A0 45.751983][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
> > [=C2=A0=C2=A0 45.752834][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01=
 00 00
> > 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
> > [=C2=A0=C2=A0 45.755574][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 000=
10202
> > [=C2=A0=C2=A0 45.756432][ T9787] RAX: dffffc0000000000 RBX: 00000000000=
00000
> > RCX: ffffffff819a4d09
> > [=C2=A0=C2=A0 45.757457][ T9787] RDX: 0000000000000008 RSI: ffffffff819=
acd3a
> > RDI: ffffc900151576e8
> > [=C2=A0=C2=A0 45.758282][ T9787] RBP: ffffc900151576d0 R08: 00000000000=
00005
> > R09: 0000000000000000
> > [=C2=A0=C2=A0 45.758943][ T9787] R10: 0000000080000000 R11: 00000000000=
00001
> > R12: 0000000000000004
> > [=C2=A0=C2=A0 45.759619][ T9787] R13: 0000000000000040 R14: ffff88802c5=
0814a
> > R15: 0000000000000000
> > [=C2=A0=C2=A0 45.760293][ T9787] FS:=C2=A0 00007ffb72734540(0000)
> > GS:ffff8880cec64000(0000) knlGS:0000000000000000
> > [=C2=A0=C2=A0 45.761050][ T9787] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
> > 0000000080050033
> > [=C2=A0=C2=A0 45.761606][ T9787] CR2: 00007f9bd8225000 CR3: 00000001097=
9a000
> > CR4: 00000000000006f0
> > [=C2=A0=C2=A0 45.762286][ T9787] Call Trace:
> > [=C2=A0=C2=A0 45.762570][ T9787]=C2=A0 <TASK>
> > [=C2=A0=C2=A0 45.762824][ T9787]=C2=A0 hfs_ext_read_extent+0x190/0x9d0
> > [=C2=A0=C2=A0 45.763269][ T9787]=C2=A0 ? submit_bio_noacct_nocheck+0x2d=
d/0xce0
> > [=C2=A0=C2=A0 45.763766][ T9787]=C2=A0 ? __pfx_hfs_ext_read_extent+0x10=
/0x10
> > [=C2=A0=C2=A0 45.764250][ T9787]=C2=A0 hfs_get_block+0x55f/0x830
> > [=C2=A0=C2=A0 45.764646][ T9787]=C2=A0 block_read_full_folio+0x36d/0x85=
0
> > [=C2=A0=C2=A0 45.765105][ T9787]=C2=A0 ? __pfx_hfs_get_block+0x10/0x10
> > [=C2=A0=C2=A0 45.765541][ T9787]=C2=A0 ? const_folio_flags+0x5b/0x100
> > [=C2=A0=C2=A0 45.765972][ T9787]=C2=A0 ? __pfx_hfs_read_folio+0x10/0x10
> > [=C2=A0=C2=A0 45.766415][ T9787]=C2=A0 filemap_read_folio+0xbe/0x290
> > [=C2=A0=C2=A0 45.766840][ T9787]=C2=A0 ? __pfx_filemap_read_folio+0x10/=
0x10
> > [=C2=A0=C2=A0 45.767325][ T9787]=C2=A0 ? __filemap_get_folio+0x32b/0xbf=
0
> > [=C2=A0=C2=A0 45.767780][ T9787]=C2=A0 do_read_cache_folio+0x263/0x5c0
> > [=C2=A0=C2=A0 45.768223][ T9787]=C2=A0 ? __pfx_hfs_read_folio+0x10/0x10
> > [=C2=A0=C2=A0 45.768666][ T9787]=C2=A0 read_cache_page+0x5b/0x160
> > [=C2=A0=C2=A0 45.769070][ T9787]=C2=A0 hfs_btree_open+0x491/0x1740
> > [=C2=A0=C2=A0 45.769481][ T9787]=C2=A0 hfs_mdb_get+0x15e2/0x1fb0
> > [=C2=A0=C2=A0 45.769877][ T9787]=C2=A0 ? __pfx_hfs_mdb_get+0x10/0x10
> > [=C2=A0=C2=A0 45.770316][ T9787]=C2=A0 ? find_held_lock+0x2b/0x80
> > [=C2=A0=C2=A0 45.770731][ T9787]=C2=A0 ? lockdep_init_map_type+0x5c/0x2=
80
> > [=C2=A0=C2=A0 45.771200][ T9787]=C2=A0 ? lockdep_init_map_type+0x5c/0x2=
80
> > [=C2=A0=C2=A0 45.771674][ T9787]=C2=A0 hfs_fill_super+0x38e/0x720
> > [=C2=A0=C2=A0 45.772092][ T9787]=C2=A0 ? __pfx_hfs_fill_super+0x10/0x10
> > [=C2=A0=C2=A0 45.772549][ T9787]=C2=A0 ? snprintf+0xbe/0x100
> > [=C2=A0=C2=A0 45.772931][ T9787]=C2=A0 ? __pfx_snprintf+0x10/0x10
> > [=C2=A0=C2=A0 45.773350][ T9787]=C2=A0 ? do_raw_spin_lock+0x129/0x2b0
> > [=C2=A0=C2=A0 45.773796][ T9787]=C2=A0 ? find_held_lock+0x2b/0x80
> > [=C2=A0=C2=A0 45.774215][ T9787]=C2=A0 ? set_blocksize+0x40a/0x510
> > [=C2=A0=C2=A0 45.774636][ T9787]=C2=A0 ? sb_set_blocksize+0x176/0x1d0
> > [=C2=A0=C2=A0 45.775087][ T9787]=C2=A0 ? setup_bdev_super+0x369/0x730
> > [=C2=A0=C2=A0 45.775533][ T9787]=C2=A0 get_tree_bdev_flags+0x384/0x620
> > [=C2=A0=C2=A0 45.775985][ T9787]=C2=A0 ? __pfx_hfs_fill_super+0x10/0x10
> > [=C2=A0=C2=A0 45.776453][ T9787]=C2=A0 ? __pfx_get_tree_bdev_flags+0x10=
/0x10
> > [=C2=A0=C2=A0 45.776950][ T9787]=C2=A0 ? bpf_lsm_capable+0x9/0x10
> > [=C2=A0=C2=A0 45.777365][ T9787]=C2=A0 ? security_capable+0x80/0x260
> > [=C2=A0=C2=A0 45.777803][ T9787]=C2=A0 vfs_get_tree+0x8e/0x340
> > [=C2=A0=C2=A0 45.778203][ T9787]=C2=A0 path_mount+0x13de/0x2010
> > [=C2=A0=C2=A0 45.778604][ T9787]=C2=A0 ? kmem_cache_free+0x2b0/0x4c0
> > [=C2=A0=C2=A0 45.779052][ T9787]=C2=A0 ? __pfx_path_mount+0x10/0x10
> > [=C2=A0=C2=A0 45.779480][ T9787]=C2=A0 ? getname_flags.part.0+0x1c5/0x5=
50
> > [=C2=A0=C2=A0 45.779954][ T9787]=C2=A0 ? putname+0x154/0x1a0
> > [=C2=A0=C2=A0 45.780335][ T9787]=C2=A0 __x64_sys_mount+0x27b/0x300
> > [=C2=A0=C2=A0 45.780758][ T9787]=C2=A0 ? __pfx___x64_sys_mount+0x10/0x1=
0
> > [=C2=A0=C2=A0 45.781232][ T9787]=C2=A0 do_syscall_64+0xc9/0x480
> > [=C2=A0=C2=A0 45.781631][ T9787]=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x77/0x7f
> > [=C2=A0=C2=A0 45.782149][ T9787] RIP: 0033:0x7ffb7265b6ca
> > [=C2=A0=C2=A0 45.782539][ T9787] Code: 48 8b 0d c9 17 0d 00 f7 d8 64 89=
 01 48
> > 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48
> > [=C2=A0=C2=A0 45.784212][ T9787] RSP: 002b:00007ffc0c10cfb8 EFLAGS: 000=
00206
> > ORIG_RAX: 00000000000000a5
> > [=C2=A0=C2=A0 45.784935][ T9787] RAX: ffffffffffffffda RBX: 00000000000=
00000
> > RCX: 00007ffb7265b6ca
> > [=C2=A0=C2=A0 45.785626][ T9787] RDX: 0000200000000240 RSI: 00002000000=
00280
> > RDI: 00007ffc0c10d100
> > [=C2=A0=C2=A0 45.786316][ T9787] RBP: 00007ffc0c10d190 R08: 00007ffc0c1=
0d000
> > R09: 0000000000000000
> > [=C2=A0=C2=A0 45.787011][ T9787] R10: 0000000000000048 R11: 00000000000=
00206
> > R12: 0000560246733250
> > [=C2=A0=C2=A0 45.787697][ T9787] R13: 0000000000000000 R14: 00000000000=
00000
> > R15: 0000000000000000
> > [=C2=A0=C2=A0 45.788393][ T9787]=C2=A0 </TASK>
> > [=C2=A0=C2=A0 45.788665][ T9787] Modules linked in:
> > [=C2=A0=C2=A0 45.789058][ T9787] ---[ end trace 0000000000000000 ]---
> > [=C2=A0=C2=A0 45.789554][ T9787] RIP: 0010:hfs_find_init+0x86/0x230
> > [=C2=A0=C2=A0 45.790028][ T9787] Code: c1 ea 03 80 3c 02 00 0f 85 9a 01=
 00 00
> > 4c 8d 6b 40 48 c7 45 18 00 00 00 00 48 b8 00 00 00 00 00 fc
> > [=C2=A0=C2=A0 45.792364][ T9787] RSP: 0018:ffffc90015157668 EFLAGS: 000=
10202
> > [=C2=A0=C2=A0 45.793155][ T9787] RAX: dffffc0000000000 RBX: 00000000000=
00000
> > RCX: ffffffff819a4d09
> > [=C2=A0=C2=A0 45.794123][ T9787] RDX: 0000000000000008 RSI: ffffffff819=
acd3a
> > RDI: ffffc900151576e8
> > [=C2=A0=C2=A0 45.795105][ T9787] RBP: ffffc900151576d0 R08: 00000000000=
00005
> > R09: 0000000000000000
> > [=C2=A0=C2=A0 45.796135][ T9787] R10: 0000000080000000 R11: 00000000000=
00001
> > R12: 0000000000000004
> > [=C2=A0=C2=A0 45.797114][ T9787] R13: 0000000000000040 R14: ffff88802c5=
0814a
> > R15: 0000000000000000
> > [=C2=A0=C2=A0 45.798024][ T9787] FS:=C2=A0 00007ffb72734540(0000)
> > GS:ffff8880cec64000(0000) knlGS:0000000000000000
> > [=C2=A0=C2=A0 45.799019][ T9787] CS:=C2=A0 0010 DS: 0000 ES: 0000 CR0:
> > 0000000080050033
> > [=C2=A0=C2=A0 45.799822][ T9787] CR2: 00007f9bd8225000 CR3: 00000001097=
9a000
> > CR4: 00000000000006f0
> > [=C2=A0=C2=A0 45.800747][ T9787] Kernel panic - not syncing: Fatal exce=
ption
> >=20
> > The hfs_fill_super() calls hfs_mdb_get() method that tries
> > to construct Extents Tree and Catalog Tree:
> >=20
> > HFS_SB(sb)->ext_tree =3D hfs_btree_open(sb, HFS_EXT_CNID,
> > hfs_ext_keycmp);
> > if (!HFS_SB(sb)->ext_tree) {
> > 	pr_err("unable to open extent tree\n");
> > 	goto out;
> > }
> > HFS_SB(sb)->cat_tree =3D hfs_btree_open(sb, HFS_CAT_CNID,
> > hfs_cat_keycmp);
> > if (!HFS_SB(sb)->cat_tree) {
> > 	pr_err("unable to open catalog tree\n");
> > 	goto out;
> > }
> >=20
> > However, hfs_btree_open() calls read_mapping_page() that
> > calls hfs_get_block(). And this method calls hfs_ext_read_extent():
> >=20
> > static int hfs_ext_read_extent(struct inode *inode, u16 block)
> > {
> > 	struct hfs_find_data fd;
> > 	int res;
> >=20
> > 	if (block >=3D HFS_I(inode)->cached_start &&
> > 	=C2=A0=C2=A0=C2=A0 block < HFS_I(inode)->cached_start + HFS_I(inode)-
> > >cached_blocks)
> > 		return 0;
> >=20
> > 	res =3D hfs_find_init(HFS_SB(inode->i_sb)->ext_tree, &fd);
> > 	if (!res) {
> > 		res =3D __hfs_ext_cache_extent(&fd, inode, block);
> > 		hfs_find_exit(&fd);
> > 	}
> > 	return res;
> > }
> >=20
> > The problem here that hfs_find_init() is trying to use
> > HFS_SB(inode->i_sb)->ext_tree that is not initialized yet.
> > It will be initailized when hfs_btree_open() finishes
> > the execution.
> >=20
> > The patch adds checking of tree pointer in hfs_find_init()
> > and it reworks the logic of hfs_btree_open() by reading
> > the b-tree's header directly from the volume. The
> > read_mapping_page()
> > is exchanged on filemap_grab_folio() that grab the folio from
> > mapping. Then, sb_bread() extracts the b-tree's header
> > content and copy it into the folio.
> >=20
> > Reported-by: Wenzhi Wang <wenzhi.wang@uwaterloo.ca>
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > cc: Yangtao Li <frank.li@vivo.com>
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> > =C2=A0 fs/hfs/bfind.c=C2=A0 |=C2=A0 3 +++
> > =C2=A0 fs/hfs/btree.c=C2=A0 | 57 ++++++++++++++++++++++++++++++++++++++=
+-----
> > -----
> > =C2=A0 fs/hfs/extent.c |=C2=A0 2 +-
> > =C2=A0 fs/hfs/hfs_fs.h |=C2=A0 1 +
> > =C2=A0 4 files changed, 51 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/fs/hfs/bfind.c b/fs/hfs/bfind.c
> > index ef9498a6e88a..34e9804e0f36 100644
> > --- a/fs/hfs/bfind.c
> > +++ b/fs/hfs/bfind.c
> > @@ -16,6 +16,9 @@ int hfs_find_init(struct hfs_btree *tree, struct
> > hfs_find_data *fd)
> > =C2=A0 {
> > =C2=A0=C2=A0	void *ptr;
> > =C2=A0=20
> > +	if (!tree || !fd)
> > +		return -EINVAL;
> > +
> > =C2=A0=C2=A0	fd->tree =3D tree;
> > =C2=A0=C2=A0	fd->bnode =3D NULL;
> > =C2=A0=C2=A0	ptr =3D kmalloc(tree->max_key_len * 2 + 4, GFP_KERNEL);
> > diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> > index 2fa4b1f8cc7f..e86e1e235658 100644
> > --- a/fs/hfs/btree.c
> > +++ b/fs/hfs/btree.c
> > @@ -21,8 +21,12 @@ struct hfs_btree *hfs_btree_open(struct
> > super_block *sb, u32 id, btree_keycmp ke
> > =C2=A0=C2=A0	struct hfs_btree *tree;
> > =C2=A0=C2=A0	struct hfs_btree_header_rec *head;
> > =C2=A0=C2=A0	struct address_space *mapping;
> > -	struct page *page;
> > +	struct folio *folio;
> > +	struct buffer_head *bh;
> > =C2=A0=C2=A0	unsigned int size;
> > +	u16 dblock;
> > +	sector_t start_block;
> > +	loff_t offset;
> > =C2=A0=20
> > =C2=A0=C2=A0	tree =3D kzalloc(sizeof(*tree), GFP_KERNEL);
> > =C2=A0=C2=A0	if (!tree)
> > @@ -75,12 +79,40 @@ struct hfs_btree *hfs_btree_open(struct
> > super_block *sb, u32 id, btree_keycmp ke
> > =C2=A0=C2=A0	unlock_new_inode(tree->inode);
> > =C2=A0=20
> > =C2=A0=C2=A0	mapping =3D tree->inode->i_mapping;
> > -	page =3D read_mapping_page(mapping, 0, NULL);
> > -	if (IS_ERR(page))
>=20
> We need to read hfs_btree_header_rec(106 bytes) from first block,
> which is much smaller than a sector(512 bytes) or a page (4k or
> bigger?).
>=20
> Maybe we don't need to read a full page?

The tree->inode->i_mapping contains memory pages for all nodes in the
b-tree. So, we will need to access not only header but the node's
content too in the future. As a result, this read not only extract the
header but also retrieve the node content for future b-tree operations.

>=20
> > +	folio =3D filemap_grab_folio(mapping, 0);
> > +	if (IS_ERR(folio))
> > =C2=A0=C2=A0		goto free_inode;
> > =C2=A0=20
> > +	folio_zero_range(folio, 0, folio_size(folio));
> > +
> > +	dblock =3D hfs_ext_find_block(HFS_I(tree->inode)-
> > >first_extents, 0);
> > +	start_block =3D HFS_SB(sb)->fs_start + (dblock * HFS_SB(sb)-
> > >fs_div);
>=20
> It's not elegant to expose such mapping logic code.
> Could we have a common map func converting logic block to physical=20
> block, xxx_get_block uses it, and here uses it?
>=20

Technically speaking, this whole mapping logic requires some polishing.
Here, I am simply adopting the existing logic. Yes, we need to make
this code more clean and easy understandable. But to make all of these
modifications in one patch is pretty impossible. So, this is why I am
simply copying this logic. But you are very welcome to share the patch
with elegant solution of mapping logic. :)

> > +
> > +	size =3D folio_size(folio);
> > +	offset =3D 0;
> > +	while (size > 0) {
> > +		size_t len;
> > +
> > +		bh =3D sb_bread(sb, start_block);
> > +		if (!bh) {
> > +			pr_err("unable to read tree header\n");
> > +			goto put_folio;
> > +		}
> > +
> > +		len =3D min_t(size_t, folio_size(folio), sb-
> > >s_blocksize);
> > +		memcpy_to_folio(folio, offset, bh->b_data, sb-
> > >s_blocksize);
> > +
> > +		brelse(bh);
> > +
> > +		start_block++;
> > +		offset +=3D len;
> > +		size -=3D len;
> > +	}
>=20
> We don't need to read full page, and it might be a good optimization
> for=20
> hfsplus too=EF=BC=9F

As I mentioned above, we are reading full page with the goal of pre-
fetching the node's content that will be inevitably read in the near
future. =20

>=20
> Could we get rid of using buffer_head?
>=20

I am not sure that we can do it easily without buffer_head. Because,
HFS operates by 512 bytes b-tree nodes. I would love to get rid of
buffer_head, but it definitely the huge modification that requires slow
and careful step-by-step change in logic. And, again, I am not sure
that we can completely forget buffer_head in HFS.

Thanks,
Slava.

> I'm not sure weather bdev_rw_virt is a good choice to simplify it.
>=20
> Thx=EF=BC=8C
> Yangtao

