Return-Path: <linux-fsdevel+bounces-57134-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D1FB1EEFD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 21:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9B67622F32
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Aug 2025 19:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FD6265CDD;
	Fri,  8 Aug 2025 19:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="GMfnUqFn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0C71E7C05
	for <linux-fsdevel@vger.kernel.org>; Fri,  8 Aug 2025 19:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754682481; cv=none; b=sNAvXJTbxn6nVaQb2DwArwuoPSSaDF10D5YYFIFj8VFDA0oBmJQ+LkepKjOGPFwQWcKWwtwXq8FtxeFwYMyKDQRjs6Ofhbvtq20AMMrSDpmB5qhxZTtqYLSk/CjPRh+lN66Sdu70KkSc8/5m6EvfelOrRzT5GxcJXCsu0CINem4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754682481; c=relaxed/simple;
	bh=ngy5VHL9l/TeIvSXra9PcwYgtYG0Gxcb3nXY48To+rA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=doApygJj4J57tQ+lLhbTQrmXA8czPfkCHfvJDhGtEi8EekWaXcMrF+NbSf7auG12+moyYaYFKq+TGUJNklec+JBrmUaJbSIbb1bainR2PEjBKPwuCiVVqoEQbW0MWvKJd2QliQLW3E+/BY7/+SmNhJbEPLKKTrZoOJfQQDi/G4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=GMfnUqFn; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-71bfdb6ff81so7207927b3.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 08 Aug 2025 12:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1754682477; x=1755287277; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4We17vxepM0iyG1YE7f8aB1lZkuhE2YUaCoxWVHXlz8=;
        b=GMfnUqFnJZaVPH4Wn4wBzS4G8h0Ml3OpTEle7GWjlfQtLznSixmKlU9cik4YKC7IP9
         Z+bGv5o0+i7XmSY2nowVQm6M23Vmbws5eQvRJy9dSnCaALqeMLp4EAxk/i4BKIwmEsMC
         DC9c4Femb8FODfTbstjBwne99lVG2ctcul/UGHiScpKf/6HvAhMFxUWVEjbe7K/4ewbL
         NItswyS7HprPpf1TrFwqLpEKU1cWILdOXev4A2Q2/Y/wPnyd3/Fkv1OAJkYheVecp4rR
         w2ypusT1aofPs1XJ4LTHl5WSVqJOd8C6EjM+GgzMb5xx9+iqwJCLDe58tDvuxEojyBf1
         Cu8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754682477; x=1755287277;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4We17vxepM0iyG1YE7f8aB1lZkuhE2YUaCoxWVHXlz8=;
        b=MCongOQDogHB6C8ZlrNTXLE6AvLx2Ab5kbYdJKsUE0wrKGy75Ed12yK419EnEoOhjl
         iziLYqnIQQTx1XwpoCtV4PCOPvLvzoOgnIwrf43iQeRz2yOPb9APkOgYAaRdN8m11oUV
         vUyZQRsKYBMuqD0oOZV4udrtPcZNnw0wsC/lWoQoG0tBDImr17ocCUfyrHlFWTrKzWFi
         bgDUUaVpb1hfy3G95bMjHdAIr/cnrreY+eubGCP+XJrFXyBfEL3qm4uwTDGXv6184SWW
         R5rNwT2rDE4xNGLYgq7N9SJZQ0oaLLOvLlXJIsWEuClTsLXIOPoaVCORSv/mww07/Qpx
         TtYQ==
X-Forwarded-Encrypted: i=1; AJvYcCUgx9fCRFDj0lbUTMAW8t/TW6Ih9hva8yizpTT1lj6ag/s3kTg4dkG8+WCsKeaDo/Qj2EHKuFgac+m3gDiW@vger.kernel.org
X-Gm-Message-State: AOJu0YydGSnDVQ0scEsQGhC1gS2Kz2w0a0xLFOxrHb3vrQymb83cE2A2
	jvjRCxS1s/4sUZfQ5pcrxiiPUY++6vh94EnoSuzfiS+wMz5ZY2HTzJouFzFWbfhVoc8=
X-Gm-Gg: ASbGncv1Dt692tl0+kqZ4KvYsTKQ69Cvx90SArZumabel5e5LfbRozgGfEaGJwL1vSQ
	cd5TqWKURnYgpsAUOngR018NhqXEm6W+SNT3zEwWrev8t9CiWkNNg7QHHy1S6KBplomuemt3IQ3
	NsZGopBK/oJfOzD5Gzc8qp8UzPqZMGPtnsUr3xk179FhTSk021WIbibUFEsBrgitIQM4xG05R0W
	sNZ5cdxaXQKj3c9JHg7DRgLAmotrxbvVdGEU+d23q9kAFwsB5jPQTBQsJrtgq6yAEhv+MOlLHoU
	Fn099BkSU8yn5J0fjMX5IuDIEwHMr7bg0TTab/2Dkray6/rJ9HN3wGXvs//15KlGfEkbBpY6xLh
	qLGW39oZAUIiZpcxHdW/BXV0VTy4=
X-Google-Smtp-Source: AGHT+IH6B9Kc5mZ15rXGzkwEmsmorFNf933cVC8JVgRzzAFYlgUxpWyx9EtyNsSLuno1XufNlu8RWw==
X-Received: by 2002:a05:690c:7487:b0:71a:44c6:ef53 with SMTP id 00721157ae682-71bf0cc2b22mr49807347b3.5.1754682477311;
        Fri, 08 Aug 2025 12:47:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430::3d? ([2600:1700:6476:1430::3d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71bf7dd7baasm4351307b3.54.2025.08.08.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 12:47:56 -0700 (PDT)
Message-ID: <4b2b24bb3489d52293ea951cff829536ca7dfe5b.camel@dubeyko.com>
Subject: Re: [PATCH] hfsplus: fix KMSAN: uninit-value in hfsplus_lookup()
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Yangtao Li <frank.li@vivo.com>, glaubitz@physik.fu-berlin.de, 
	linux-fsdevel@vger.kernel.org
Cc: Slava.Dubeyko@ibm.com, syzbot
	 <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
Date: Fri, 08 Aug 2025 12:47:55 -0700
In-Reply-To: <894eb3d4-b7eb-474e-ae4d-457a099deb76@vivo.com>
References: <20250804195058.2327861-1-slava@dubeyko.com>
	 <894eb3d4-b7eb-474e-ae4d-457a099deb76@vivo.com>
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

On Wed, 2025-08-06 at 00:18 +0800, Yangtao Li wrote:
> Hi Slava,
>=20
> =E5=9C=A8 2025/8/5 3:50, Viacheslav Dubeyko =E5=86=99=E9=81=93:
> > If Catalog File contains corrupted record for the case of
> > hidden directory (particularly, entry.folder.id is lesser
> > than HFSPLUS_FIRSTUSER_CNID), then it can trigger the issue:
> >=20
> > [=C2=A0=C2=A0 65.773760][ T9320] BUG: KMSAN: uninit-value in
> > hfsplus_lookup+0xcd7/0x11f0
> > [=C2=A0=C2=A0 65.774362][ T9320]=C2=A0 hfsplus_lookup+0xcd7/0x11f0
> > [=C2=A0=C2=A0 65.774756][ T9320]=C2=A0 __lookup_slow+0x525/0x720
> > [=C2=A0=C2=A0 65.775160][ T9320]=C2=A0 lookup_slow+0x6a/0xd0
> > [=C2=A0=C2=A0 65.775513][ T9320]=C2=A0 walk_component+0x393/0x680
> > [=C2=A0=C2=A0 65.775896][ T9320]=C2=A0 path_lookupat+0x257/0x6c0
> > [=C2=A0=C2=A0 65.776313][ T9320]=C2=A0 filename_lookup+0x2ac/0x800
> > [=C2=A0=C2=A0 65.776693][ T9320]=C2=A0 user_path_at+0x8f/0x3c0
> > [=C2=A0=C2=A0 65.777078][ T9320]=C2=A0 __x64_sys_umount+0x146/0x250
> > [=C2=A0=C2=A0 65.777484][ T9320]=C2=A0 x64_sys_call+0x2806/0x3d90
> > [=C2=A0=C2=A0 65.777851][ T9320]=C2=A0 do_syscall_64+0xd9/0x1e0
> > [=C2=A0=C2=A0 65.778263][ T9320]=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x77/0x7f
> > [=C2=A0=C2=A0 65.778716][ T9320]
> > [=C2=A0=C2=A0 65.778906][ T9320] Uninit was created at:
> > [=C2=A0=C2=A0 65.779294][ T9320]=C2=A0 __alloc_frozen_pages_noprof+0x71=
4/0xe60
> > [=C2=A0=C2=A0 65.779750][ T9320]=C2=A0 alloc_pages_mpol+0x295/0x890
> > [=C2=A0=C2=A0 65.780148][ T9320]=C2=A0 alloc_frozen_pages_noprof+0xf8/0=
x1f0
> > [=C2=A0=C2=A0 65.780597][ T9320]=C2=A0 allocate_slab+0x216/0x1190
> > [=C2=A0=C2=A0 65.780961][ T9320]=C2=A0 ___slab_alloc+0x104c/0x33c0
> > [=C2=A0=C2=A0 65.781543][ T9320]=C2=A0 kmem_cache_alloc_lru_noprof+0x8f=
6/0xe70
> > [=C2=A0=C2=A0 65.782135][ T9320]=C2=A0 hfsplus_alloc_inode+0x5a/0xd0
> > [=C2=A0=C2=A0 65.782608][ T9320]=C2=A0 alloc_inode+0x82/0x490
> > [=C2=A0=C2=A0 65.783055][ T9320]=C2=A0 iget_locked+0x22e/0x1320
> > [=C2=A0=C2=A0 65.783495][ T9320]=C2=A0 hfsplus_iget+0xc9/0xd70
> > [=C2=A0=C2=A0 65.783944][ T9320]=C2=A0 hfsplus_btree_open+0x12b/0x1de0
> > [=C2=A0=C2=A0 65.784456][ T9320]=C2=A0 hfsplus_fill_super+0xc1c/0x27b0
> > [=C2=A0=C2=A0 65.784922][ T9320]=C2=A0 get_tree_bdev_flags+0x6e6/0x920
> > [=C2=A0=C2=A0 65.785403][ T9320]=C2=A0 get_tree_bdev+0x38/0x50
> > [=C2=A0=C2=A0 65.785819][ T9320]=C2=A0 hfsplus_get_tree+0x35/0x40
> > [=C2=A0=C2=A0 65.786275][ T9320]=C2=A0 vfs_get_tree+0xb3/0x5c0
> > [=C2=A0=C2=A0 65.786674][ T9320]=C2=A0 do_new_mount+0x73e/0x1630
> > [=C2=A0=C2=A0 65.787135][ T9320]=C2=A0 path_mount+0x6e3/0x1eb0
> > [=C2=A0=C2=A0 65.787564][ T9320]=C2=A0 __se_sys_mount+0x73a/0x830
> > [=C2=A0=C2=A0 65.787944][ T9320]=C2=A0 __x64_sys_mount+0xe4/0x150
> > [=C2=A0=C2=A0 65.788346][ T9320]=C2=A0 x64_sys_call+0x3904/0x3d90
> > [=C2=A0=C2=A0 65.788707][ T9320]=C2=A0 do_syscall_64+0xd9/0x1e0
> > [=C2=A0=C2=A0 65.789090][ T9320]=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x77/0x7f
> > [=C2=A0=C2=A0 65.789557][ T9320]
> > [=C2=A0=C2=A0 65.789744][ T9320] CPU: 0 UID: 0 PID: 9320 Comm: repro No=
t
> > tainted 6.14.0-rc5 #5
> > [=C2=A0=C2=A0 65.790355][ T9320] Hardware name: QEMU Ubuntu 24.04 PC (i=
440FX
> > + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [=C2=A0=C2=A0 65.791197][ T9320]
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > [=C2=A0=C2=A0 65.791814][ T9320] Disabling lock debugging due to kernel=
 taint
> > [=C2=A0=C2=A0 65.792419][ T9320] Kernel panic - not syncing: kmsan.pani=
c set
> > ...
> > [=C2=A0=C2=A0 65.793000][ T9320] CPU: 0 UID: 0 PID: 9320 Comm: repro Ta=
inted:
> > G=C2=A0=C2=A0=C2=A0 B=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 6.14.0-rc5 #5
> > [=C2=A0=C2=A0 65.793830][ T9320] Tainted: [B]=3DBAD_PAGE
> > [=C2=A0=C2=A0 65.794235][ T9320] Hardware name: QEMU Ubuntu 24.04 PC (i=
440FX
> > + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > [=C2=A0=C2=A0 65.795211][ T9320] Call Trace:
> > [=C2=A0=C2=A0 65.795519][ T9320]=C2=A0 <TASK>
> > [=C2=A0=C2=A0 65.795797][ T9320]=C2=A0 dump_stack_lvl+0x1fd/0x2b0
> > [=C2=A0=C2=A0 65.796256][ T9320]=C2=A0 dump_stack+0x1e/0x25
> > [=C2=A0=C2=A0 65.796677][ T9320]=C2=A0 panic+0x505/0xca0
> > [=C2=A0=C2=A0 65.797112][ T9320]=C2=A0 ? kmsan_get_metadata+0xf9/0x150
> > [=C2=A0=C2=A0 65.797625][ T9320]=C2=A0 kmsan_report+0x299/0x2a0
> > [=C2=A0=C2=A0 65.798105][ T9320]=C2=A0 ? kmsan_internal_unpoison_memory=
+0x14/0x20
> > [=C2=A0=C2=A0 65.798696][ T9320]=C2=A0 ? __msan_metadata_ptr_for_load_4=
+0x24/0x40
> > [=C2=A0=C2=A0 65.799291][ T9320]=C2=A0 ? __msan_warning+0x96/0x120
> > [=C2=A0=C2=A0 65.799785][ T9320]=C2=A0 ? hfsplus_lookup+0xcd7/0x11f0
> > [=C2=A0=C2=A0 65.800294][ T9320]=C2=A0 ? __lookup_slow+0x525/0x720
> > [=C2=A0=C2=A0 65.800772][ T9320]=C2=A0 ? lookup_slow+0x6a/0xd0
> > [=C2=A0=C2=A0 65.801239][ T9320]=C2=A0 ? walk_component+0x393/0x680
> > [=C2=A0=C2=A0 65.801730][ T9320]=C2=A0 ? path_lookupat+0x257/0x6c0
> > [=C2=A0=C2=A0 65.802225][ T9320]=C2=A0 ? filename_lookup+0x2ac/0x800
> > [=C2=A0=C2=A0 65.802720][ T9320]=C2=A0 ? user_path_at+0x8f/0x3c0
> > [=C2=A0=C2=A0 65.803202][ T9320]=C2=A0 ? __x64_sys_umount+0x146/0x250
> > [=C2=A0=C2=A0 65.803683][ T9320]=C2=A0 ? x64_sys_call+0x2806/0x3d90
> > [=C2=A0=C2=A0 65.804177][ T9320]=C2=A0 ? do_syscall_64+0xd9/0x1e0
> > [=C2=A0=C2=A0 65.804634][ T9320]=C2=A0 ? entry_SYSCALL_64_after_hwframe=
+0x77/0x7f
> > [=C2=A0=C2=A0 65.805251][ T9320]=C2=A0 ? kmsan_get_metadata+0x70/0x150
> > [=C2=A0=C2=A0 65.805764][ T9320]=C2=A0 ? vprintk_default+0x3f/0x50
> > [=C2=A0=C2=A0 65.806256][ T9320]=C2=A0 ? vprintk+0x36/0x50
> > [=C2=A0=C2=A0 65.806659][ T9320]=C2=A0 ? _printk+0x17e/0x1b0
> > [=C2=A0=C2=A0 65.807107][ T9320]=C2=A0 ? kmsan_get_metadata+0xf9/0x150
> > [=C2=A0=C2=A0 65.807621][ T9320]=C2=A0 __msan_warning+0x96/0x120
> > [=C2=A0=C2=A0 65.808103][ T9320]=C2=A0 hfsplus_lookup+0xcd7/0x11f0
> > [=C2=A0=C2=A0 65.808587][ T9320]=C2=A0 ? kmsan_get_metadata+0x70/0x150
> > [=C2=A0=C2=A0 65.809108][ T9320]=C2=A0 ? kmsan_get_metadata+0xf9/0x150
> > [=C2=A0=C2=A0 65.809627][ T9320]=C2=A0 ? kmsan_get_metadata+0xf9/0x150
> > [=C2=A0=C2=A0 65.810142][ T9320]=C2=A0 ? __pfx_hfsplus_lookup+0x10/0x10
> > [=C2=A0=C2=A0 65.810669][ T9320]=C2=A0 ? kmsan_get_shadow_origin_ptr+0x=
4a/0xb0
> > [=C2=A0=C2=A0 65.811258][ T9320]=C2=A0 ? __pfx_hfsplus_lookup+0x10/0x10
> > [=C2=A0=C2=A0 65.811787][ T9320]=C2=A0 __lookup_slow+0x525/0x720
> > [=C2=A0=C2=A0 65.812258][ T9320]=C2=A0 lookup_slow+0x6a/0xd0
> > [=C2=A0=C2=A0 65.812700][ T9320]=C2=A0 walk_component+0x393/0x680
> > [=C2=A0=C2=A0 65.813178][ T9320]=C2=A0 ? kmsan_get_metadata+0xf9/0x150
> > [=C2=A0=C2=A0 65.813697][ T9320]=C2=A0 path_lookupat+0x257/0x6c0
> > [=C2=A0=C2=A0 65.814196][ T9320]=C2=A0 filename_lookup+0x2ac/0x800
> > [=C2=A0=C2=A0 65.814677][ T9320]=C2=A0 ? strncpy_from_user+0x255/0x470
> > [=C2=A0=C2=A0 65.815193][ T9320]=C2=A0 ? kmsan_get_metadata+0xf9/0x150
> > [=C2=A0=C2=A0 65.815706][ T9320]=C2=A0 ? kmsan_get_shadow_origin_ptr+0x=
4a/0xb0
> > [=C2=A0=C2=A0 65.816290][ T9320]=C2=A0 ? __msan_metadata_ptr_for_load_8=
+0x24/0x40
> > [=C2=A0=C2=A0 65.816886][ T9320]=C2=A0 user_path_at+0x8f/0x3c0
> > [=C2=A0=C2=A0 65.817342][ T9320]=C2=A0 ? __x64_sys_umount+0x6d/0x250
> > [=C2=A0=C2=A0 65.817834][ T9320]=C2=A0 __x64_sys_umount+0x146/0x250
> > [=C2=A0=C2=A0 65.818333][ T9320]=C2=A0 ?
> > kmsan_internal_set_shadow_origin+0x79/0x110
> > [=C2=A0=C2=A0 65.818945][ T9320]=C2=A0 x64_sys_call+0x2806/0x3d90
> > [=C2=A0=C2=A0 65.819420][ T9320]=C2=A0 do_syscall_64+0xd9/0x1e0
> > [=C2=A0=C2=A0 65.819876][ T9320]=C2=A0 ? irqentry_exit+0x16/0x60
> > [=C2=A0=C2=A0 65.820353][ T9320]=C2=A0 entry_SYSCALL_64_after_hwframe+0=
x77/0x7f
> > [=C2=A0=C2=A0 65.820951][ T9320] RIP: 0033:0x7f822cb8fb07
> > [=C2=A0=C2=A0 65.821427][ T9320] Code: 23 0d 00 f7 d8 64 89 01 48 83 c8=
 ff c3
> > 66 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 08
> > [=C2=A0=C2=A0 65.823225][ T9320] RSP: 002b:00007fff4858f038 EFLAGS: 000=
00202
> > ORIG_RAX: 00000000000000a6
> > [=C2=A0=C2=A0 65.824037][ T9320] RAX: ffffffffffffffda RBX: 00000000000=
00000
> > RCX: 00007f822cb8fb07
> > [=C2=A0=C2=A0 65.824818][ T9320] RDX: 0000000000000009 RSI: 00000000000=
00009
> > RDI: 00007fff4858f0e0
> > [=C2=A0=C2=A0 65.825568][ T9320] RBP: 00007fff48590120 R08: 00007f822cc=
23040
> > R09: 00007fff4858eed0
> > [=C2=A0=C2=A0 65.826329][ T9320] R10: 00007f822cc22fc0 R11: 00000000000=
00202
> > R12: 000055bd891e22d0
> > [=C2=A0=C2=A0 65.827086][ T9320] R13: 0000000000000000 R14: 00000000000=
00000
> > R15: 0000000000000000
> > [=C2=A0=C2=A0 65.827850][ T9320]=C2=A0 </TASK>
> > [=C2=A0=C2=A0 65.828677][ T9320] Kernel Offset: disabled
> > [=C2=A0=C2=A0 65.829095][ T9320] Rebooting in 86400 seconds..
> >=20
> > It means that if hfsplus_iget() receives inode ID lesser than
> > HFSPLUS_FIRSTUSER_CNID, then it treats it as system inode and
> > hfsplus_system_read_inode() will be called. As result,
> > struct hfsplus_inode_info is not initialized properly for
> > the case of hidden directory. The hidden directory is the record of
> > Catalog File and hfsplus_cat_read_inode() should be called
> > for the proper initalization of hidden directory's inode.
> >=20
> > This patch adds checking of entry.folder.id for the case of
> > hidden directory in hfsplus_fill_super(). The CNID of hidden folder
> > cannot be lesser than HFSPLUS_FIRSTUSER_CNID. And if we receive
> > such invalid CNID, then record is corrupted and
> > hfsplus_fill_super()
> > returns the EIO error. Also, patch adds invalid CNID declaration
> > and
> > declarations of another reserved CNIDs.
> >=20
> > Reported-by: syzbot
> > <syzbot+91db973302e7b18c7653@syzkaller.appspotmail.com>
> > Closes:
> > https://syzkaller.appspot.com/bug?extid=3D91db973302e7b18c7653
> > Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> > cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > cc: Yangtao Li <frank.li@vivo.com>
> > cc: linux-fsdevel@vger.kernel.org
> > ---
> > =C2=A0 fs/hfsplus/hfsplus_raw.h | 7 +++++++
> > =C2=A0 fs/hfsplus/super.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 ++++
> > =C2=A0 2 files changed, 11 insertions(+)
> >=20
> > diff --git a/fs/hfsplus/hfsplus_raw.h b/fs/hfsplus/hfsplus_raw.h
> > index 68b4240c6191..bdd4deab46c6 100644
> > --- a/fs/hfsplus/hfsplus_raw.h
> > +++ b/fs/hfsplus/hfsplus_raw.h
> > @@ -194,6 +194,7 @@ struct hfs_btree_header_rec {
> > =C2=A0 #define HFSPLUS_BTREE_HDR_USER_BYTES		128
> > =C2=A0=20
> > =C2=A0 /* Some special File ID numbers (stolen from hfs.h) */
> > +#define HFSPLUS_INVALID_CNID		0	/* Invalid id */
>=20
>=20
> Could we drop those for this patch?
>=20
> If they're needed, we can add them in other patches.
>=20
> I don't see their usage.
>=20
>=20

I have spent last two weeks on discussing these declarations for HFS
case. And I see a lot of sense to add these declarations with the goal
not to spend more time for advising not to use hardcoded plain values
instead of human-friendly constants declarations. :) The main point of
these declarations is to clearly define that zero is invalid CNID.

>=20
> > =C2=A0 #define HFSPLUS_POR_CNID		1	/* Parent Of the
> > Root */
> > =C2=A0 #define HFSPLUS_ROOT_CNID		2	/* ROOT directory
> > */
> > =C2=A0 #define HFSPLUS_EXT_CNID		3	/* EXTents B-tree
> > */
> > @@ -202,6 +203,12 @@ struct hfs_btree_header_rec {
> > =C2=A0 #define HFSPLUS_ALLOC_CNID		6	/* ALLOCation file
> > */
> > =C2=A0 #define HFSPLUS_START_CNID		7	/* STARTup file */
> > =C2=A0 #define HFSPLUS_ATTR_CNID		8	/* ATTRibutes file
> > */
> > +#define HFSPLUS_RESERVED_CNID_9		9
> > +#define HFSPLUS_RESERVED_CNID_10	10
> > +#define HFSPLUS_RESERVED_CNID_11	11
> > +#define HFSPLUS_RESERVED_CNID_12	12
> > +#define HFSPLUS_RESERVED_CNID_13	13
> > +#define HFSPLUS_REPAIR_CAT_CNID		14	/* Repair
> > CATalog File id */
>=20
>=20
> Same.
>=20

The HFSPLUS_REPAIR_CAT_CNID is defined in HFS+ specification [1]. So,
it makes sense to add it here. And the rest declarations show the
reserved CNID values. Now it can be used in the code and I don't need
to advice again to declare these constants.

Thanks,
Slava.


[1]
https://developer.apple.com/library/archive/technotes/tn/tn1150.html#Catalo=
gFile

>=20
> > =C2=A0 #define HFSPLUS_EXCH_CNID		15	/* ExchangeFiles
> > temp id */
> > =C2=A0 #define HFSPLUS_FIRSTUSER_CNID		16	/* first
> > available user id */
> > =C2=A0=20
> > diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
> > index 86351bdc8985..8f2790a78e08 100644
> > --- a/fs/hfsplus/super.c
> > +++ b/fs/hfsplus/super.c
> > @@ -527,6 +527,10 @@ static int hfsplus_fill_super(struct
> > super_block *sb, struct fs_context *fc)
> > =C2=A0=C2=A0			err =3D -EINVAL;
> > =C2=A0=C2=A0			goto out_put_root;
> > =C2=A0=C2=A0		}
> > +		if (be32_to_cpu(entry.folder.id) <
> > HFSPLUS_FIRSTUSER_CNID) {
> > +			err =3D -EIO;
> > +			goto out_put_root;
> > +		}
>=20
>=20
> Otherwise, LGTM.
>=20
> Reviewed-by: Yangtao Li <frank.li <http://frank.li/>@vivo.com=20
> <http://vivo.com/>>
>=20
> Thx,
>=20
> Yangtao

