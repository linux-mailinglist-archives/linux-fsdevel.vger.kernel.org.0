Return-Path: <linux-fsdevel+bounces-32455-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1D59A5CAD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 09:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A50441F21217
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1804B1D1E72;
	Mon, 21 Oct 2024 07:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="fnxRFywd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F701D14E2;
	Mon, 21 Oct 2024 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729495374; cv=none; b=Dh8fFtrBg3Dik2vI0cihZ7LO8/tH3OifSyD125DPeXLAMTAmUmMcJh9gZl7P95I+mAqL6aC/CWMhgg7VXsd47CiFoTHrvha6EtCHw0YlcoM/FlZrYzUBWCg/43dRqJZMXp3yICktTUOoc6WJgRXmJg5+folyUJix3HfiUYg337g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729495374; c=relaxed/simple;
	bh=j2o9aZZ2MpjYuhcSr3OChzYTBDv4hplxBC14TRULQI8=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=TtEU88xkeZM8Ji4n2xNUCZ+Nflh+Sw85TbE+szClsz59bDv20jWDu7s5mhSteReZh6dYN83sEGFZv4CV9gnWURdcySOuPXQWJEcCfFMgsdaL6+Kb27WnWIg1yhXNzwB9B9EaGNNFqiQnK5ZSRtt3lLTWVxRZAnED57ACA6yj8Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=fnxRFywd; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20241021072248euoutp0154700447ddf6f2066342e26bab501df4~AZt-x-Amy0550305503euoutp01m;
	Mon, 21 Oct 2024 07:22:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20241021072248euoutp0154700447ddf6f2066342e26bab501df4~AZt-x-Amy0550305503euoutp01m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1729495369;
	bh=7Vo8bdrcTD2TExgOyGSaPfXGd7Aa+ItF6FSKHNsruAQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=fnxRFywdKm9yix+Os5AePl5xtBGH7BesiJShYmaisTyJZ/AS4iGDhbklMvt9x1kEM
	 zPaQ2OJJ4T/lPQNPh4sf7AiPbu0Wstfk081wl8KgWVn05dVgeJ49CYQ0zb3V+7tuzC
	 yr4G/XvCuCQv+r4PENRyJdNjfV8WfhOtwbvyeYMs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20241021072248eucas1p1ac0b469a13d7941e669de1fa2b7f0fa0~AZt-gjzjO2488824888eucas1p1n;
	Mon, 21 Oct 2024 07:22:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 69.14.20409.84106176; Mon, 21
	Oct 2024 08:22:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20241021072248eucas1p127c01b427e01c363b0425b9f5e130811~AZt-DOXgy2553825538eucas1p17;
	Mon, 21 Oct 2024 07:22:48 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20241021072248eusmtrp2bc9e687864d5b91d6aadf0c7c223c017~AZt-BmeZp2870628706eusmtrp22;
	Mon, 21 Oct 2024 07:22:48 +0000 (GMT)
X-AuditID: cbfec7f4-c0df970000004fb9-92-671601482b13
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 05.B1.19654.74106176; Mon, 21
	Oct 2024 08:22:47 +0100 (BST)
Received: from CAMSVWEXC02.scsc.local (unknown [106.1.227.72]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20241021072247eusmtip2b1ef0deb415b435079661bd6a9f0346a~AZt_l4KqO0165901659eusmtip2t;
	Mon, 21 Oct 2024 07:22:47 +0000 (GMT)
Received: from localhost (106.110.32.107) by CAMSVWEXC02.scsc.local
	(2002:6a01:e348::6a01:e348) with Microsoft SMTP Server (TLS) id 15.0.1497.2;
	Mon, 21 Oct 2024 08:22:46 +0100
Date: Mon, 21 Oct 2024 09:22:45 +0200
From: Joel Granados <j.granados@samsung.com>
To: Kaixiong Yu <yukaixiong@huawei.com>
CC: <akpm@linux-foundation.org>, <mcgrof@kernel.org>, <ysato@users.osdn.me>,
	<dalias@libc.org>, <glaubitz@physik.fu-berlin.de>, <luto@kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <viro@zeniv.linux.org.uk>,
	<brauner@kernel.org>, <jack@suse.cz>, <kees@kernel.org>,
	<willy@infradead.org>, <Liam.Howlett@oracle.com>, <vbabka@suse.cz>,
	<lorenzo.stoakes@oracle.com>, <trondmy@kernel.org>, <anna@kernel.org>,
	<chuck.lever@oracle.com>, <jlayton@kernel.org>, <neilb@suse.de>,
	<okorniev@redhat.com>, <Dai.Ngo@oracle.com>, <tom@talpey.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <paul@paul-moore.com>, <jmorris@namei.org>,
	<linux-sh@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-nfs@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <dhowells@redhat.com>,
	<haifeng.xu@shopee.com>, <baolin.wang@linux.alibaba.com>,
	<shikemeng@huaweicloud.com>, <dchinner@redhat.com>, <bfoster@redhat.com>,
	<souravpanda@google.com>, <hannes@cmpxchg.org>, <rientjes@google.com>,
	<pasha.tatashin@soleen.com>, <david@redhat.com>, <ryan.roberts@arm.com>,
	<ying.huang@intel.com>, <yang@os.amperecomputing.com>,
	<zev@bewilderbeest.net>, <serge@hallyn.com>, <vegard.nossum@oracle.com>,
	<wangkefeng.wang@huawei.com>, <sunnanyong@huawei.com>
Subject: Re: [PATCH v3 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
Message-ID: <ngknhtecptqk56gtiikvb5mdujhtxdyngzndiaz7ifslzrki7q@4wcykosdnsna>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241010152215.3025842-1-yukaixiong@huawei.com>
X-ClientProxiedBy: CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348) To
	CAMSVWEXC02.scsc.local (2002:6a01:e348::6a01:e348)
X-Brightmail-Tracker: H4sIAAAAAAAAA02TeUxUVxTGc986YLHDItwMiBaENqQsNiYeKza1rfWVRkvqVjVFpvIymALS
	GbCWLgFZBRkREBSQpRLZhsWBIKtQrSDbDC2iWOvSiahldwAtjAwdeNj633fOd373nu8mV0Ra
	dbES0aGQMF4eIg1yYsyp2rYZjTuHbGVehS9WQU6lioHY+nkK5pvbEIxNRsBklZGB4at6BPN3
	HxOQ93M1AwUzszQ8qYpHkKONoWC6cpaEnqFzLIwdM1Aw2KZjIXvcGUZqSkgoU2+DjIt2kJ0Z
	TcDMhVIWKirPE1AxqqWht1ZJw6XIByw0NXdQ0NeQw8A91bzJaO2iYeKEjoGcF+kkdGSVUKBt
	KKdhIGUQwe+t+QQ050VS0JZvC6mP9Cw86xpB0DnzA9xJzaQgrvAiAScaTyPQ9mpYGFc2ERCl
	SiLhtvYhA9Xq0yR0znYSoD9npCE7Somg55iKBu1cOw1Rk/cRGP4xbZJc2MGark4zPUbLcwbK
	5mtIuDHYS73vzT2PVVKcKleFuPw7n3JXR8ZJrqbkNsHlq8O5m417uZhfR2luqv4k4qqL3bjz
	TX8TnLr0OMOp9aksp8meoLgxjYblrp8xUL5v7DP3DuCDDh3h5Z7v+ZsHJvam06EDK4+Wnxih
	I9G4TSIyE2HxOjx3/BabiMxFVuJihHWzKUgophBOfVRICsUkwuml/cxLJO3JGCEYRQh3x5Yz
	/03dKile4msQ1hcZ6AWEErvgSGUPtaAZ8dtYO/InuaBtxG/iR+M9izQpblyGz55qXjSsxftx
	382cRcBCvA3PXeulBW2JO84+XOyTpoPyG/UmWGTS9rjIKFqQZuJNuH5WImzqhPtT7lKC/hE3
	R7cuBsXiY6/hqrxYVjA+woaoNlLQ1niovWap74Dn6/MIAUhDuMU4sUSXIXwhapoQpjbimBsP
	l4jNuDM6GS1sgcXL8cCopbDncpxam0kKbQucEGclTLvisnsjVApyznolWdYrybL+T5aPyFJk
	x4crgmW84p0Q/lsPhTRYER4i8zh4OFiNTP+ty9g+VYeKhp56XEGECF1BWEQ62Vg4ha2QWVkE
	SL+L4OWHD8jDg3jFFWQvopzsLFwCVvFWYpk0jP+a50N5+UuXEJlJIomtvn6OH9pteGBfF/jx
	bytXLyua8lnPtv3yeIPhoJnuTtal2e5QdDnxOrPCVeO7qtJDl5tzbbNO0mE7mqlqeWvt/bg/
	jmzcWG8f5RfySaGxoMZVdqpBs166+/PpOuwRN+Syu3vHqN83Ljurk9Ren63p3jWk/PKr/Z3D
	vnXJ3cjRLWDa+obDyjnJC52PrVfYsGT7lsoI26sVElm8ZkuCdcaeMM+BGHdf/czeYN3lA6E7
	g+f+GgS3nzrd8hwb/ZOednv6vG7f51iYy21aF2Gw7H9wm0zvO9wf+32yrPjMasUX209qvBQF
	7xrcd+2R73D4oEnpP+6cERP/THLUqG/PhX0JpZZrMrydKEWgdK0bKVdI/wXyI7Kl3gQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Te0yTZxTGfb9bi46kXNRvXCLWuCXIKgXKDhs4nX/sC85ly2IWvAw77MBR
	wLSFVKdZuc1xGSKiDCiW4WUDKki5iYXJgOEKgdahjLsLEXBYWiigo2hZoS7zv+fNc57fe3Jy
	Dht3naI82MfjZSJJvFDMpdYT3ba7Y299gDZF+7fcCgFltZqC9KYVAlZaOhGY5k/B/E0bBU/a
	LQhWRqcwUJXVUvDjkpWExzfPIlDq0whYrLbi0DNdwgJTyjIBE53jLCg2bwNjXTkOlZr9cKlm
	MxQXpGKwdL2CBVXVVzComtGTYGjIIaFR8RcLmlt0BPTdVlIwpl6xG63dJMxmj1OgfJ6Pg66o
	nAD97RskDOROIPijtRSDFpWCgM7STZA3aWHB024jgq6l0zCcV0DAt1drMMjWXkSgN/SywJzT
	jEGyOguHQf0jCmo1F3HosnZhYCmxkVCcnIOgJ0VNgv7FXRKS5x8iWP7H3sn3V3Us+9cX7MO4
	84yCypU6HO5PGIjdocyz9ByCUV9WI6Z0eB/TbjTjTF35IMaUahKZfm0Ek9YxQzILTecQU/uz
	L3Ol+W+M0VRkUIzGksdieotnCcbU28tifv9hmfh460FeqCQhUSbyiUmQysK4h/gQwOOHAC8g
	KITHD3z7yDsBAu7OXaHHROLjSSLJzl1HeTGZhnzyxIC3/Ea2kVQgs3smcmLTnCD6wmMTlonW
	s1051xCt0C6xHIYXXbPwgHRoN/p5fyblKJpD9PCTEdLxqEP0ZFoltVpFcLbTipweYlVTHD9a
	bxzBV7U750160tyzlsY52g104fmWNcONc4ju61euBZw5++kXvxleUnMRbZsbfWm40LrCR2sa
	t1NLtRY7iW3XnvRPNvaqdOKE0U1WD0enXPpBriNJc87QGdPdVC5yK3oFVPQKqOh/UCnCK5C7
	KFEaFx0nDeBJhXHSxPhoXlRCnAbZN76hc6nuFiqfnuO1IYyN2hDNxrnuzlzZxmhX52PCk6dE
	koRISaJYJG1DAvsozuMeG6MS7CcTL4vkB/sL+EHBIf6CkOBA7mZn6r7+S1dOtFAmihWJTogk
	/+UwtpOHAlMxh9NdI6as+jvys25cWdK9vfE6T1ty6OI2vNhTOvzLYLsyTGMouvRReJbFrCpq
	DOw2HS0Xf9NQ/53nhjw2e2xP7IiO2H2knr2uNyN1MGO+PWJ8ct2svF4a5JoVTn7xKTWY9dWK
	8l6fT7+VHhAslry/5GbxKvORjUpC/2zxde4cKtg+V+vSLn/vDYE2aW8YHrul6zM94SMQS4rP
	dHjv8fu6pmZh3n98KLfjYOTl4En9zI7UiEYXT9Un7uFphg8PDD1N1UdtPQmGw3G4d9mo3PQw
	heM38K7SeGC0zetXj/y86+KqgWprkxPK+vw1Ve4OaJVvqQ4716Pqep2VYTx9rZBLSGOEfF9c
	IhX+C6gKfYZ6BAAA
X-CMS-MailID: 20241021072248eucas1p127c01b427e01c363b0425b9f5e130811
X-Msg-Generator: CA
X-RootMTR: 20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd
References: <CGME20241010141133eucas1p1999f17c74198d3880cbd345276bcd3bd@eucas1p1.samsung.com>
	<20241010152215.3025842-1-yukaixiong@huawei.com>

On Thu, Oct 10, 2024 at 11:22:00PM +0800, Kaixiong Yu wrote:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.
> 
> All the modifications of this patch series base on
> linux-next(tags/next-20241010). To test this patch series, the code was
> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> x86_64 architectures. After this patch series is applied, all files
> under /proc/sys/vm can be read or written normally.
> 
> Changes in v3:
>  - change patch1~10, patch14 title suggested by Joel Granados
>  - change sysctl_stat_interval to static type in patch1
>  - add acked-by from Paul Moore in patch7
>  - change dirtytime_expire_interval to static type in patch9
>  - add acked-by from Anna Schumaker in patch11
> 
> Changes in v2:
>  - fix sysctl_max_map_count undeclared issue in mm/nommu.c for patch6
>  - update changelog for patch7/12, suggested by Kees/Paul
>  - fix patch8, sorry for wrong changes and forget to built with NOMMU
>  - add reviewed-by from Kees except patch8 since patch8 is wrong in v1
>  - add reviewed-by from Jan Kara, Christian Brauner in patch12
> 
> Kaixiong Yu (15):
>   mm: vmstat: move sysctls to mm/vmstat.c
>   mm: filemap: move sysctl to mm/filemap.c
>   mm: swap: move sysctl to mm/swap.c
>   mm: vmscan: move vmscan sysctls to mm/vmscan.c
>   mm: util: move sysctls to mm/util.c
>   mm: mmap: move sysctl to mm/mmap.c
>   security: min_addr: move sysctl to security/min_addr.c
>   mm: nommu: move sysctl to mm/nommu.c
>   fs: fs-writeback: move sysctl to fs/fs-writeback.c
>   fs: drop_caches: move sysctl to fs/drop_caches.c
>   sunrpc: use vfs_pressure_ratio() helper
>   fs: dcache: move the sysctl to fs/dcache.c
>   x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
>   sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
>   sysctl: remove unneeded include
> 
>  arch/sh/kernel/vsyscall/vsyscall.c |  14 ++
>  arch/x86/entry/vdso/vdso32-setup.c |  16 ++-
>  fs/dcache.c                        |  21 ++-
>  fs/drop_caches.c                   |  23 ++-
>  fs/fs-writeback.c                  |  30 ++--
>  include/linux/dcache.h             |   7 +-
>  include/linux/mm.h                 |  23 ---
>  include/linux/mman.h               |   2 -
>  include/linux/swap.h               |   9 --
>  include/linux/vmstat.h             |  11 --
>  include/linux/writeback.h          |   4 -
>  kernel/sysctl.c                    | 221 -----------------------------
>  mm/filemap.c                       |  18 ++-
>  mm/internal.h                      |  10 ++
>  mm/mmap.c                          |  54 +++++++
>  mm/nommu.c                         |  15 +-
>  mm/swap.c                          |  16 ++-
>  mm/swap.h                          |   1 +
>  mm/util.c                          |  67 +++++++--
>  mm/vmscan.c                        |  23 +++
>  mm/vmstat.c                        |  44 +++++-
>  net/sunrpc/auth.c                  |   2 +-
>  security/min_addr.c                |  11 ++
>  23 files changed, 330 insertions(+), 312 deletions(-)
> 
> -- 
> 2.34.1
> 
General comment for the patchset in general. I would consider making the
new sysctl tables const. There is an effort for doing this and it has
already lanted in linux-next. So if you base your patch from a recent
next release, then it should just work. If you *do* decide to add a
const qualifier, then note that you will create a dependency with the
sysctl patchset currently in next and that will have to go in before.

Best

-- 

Joel Granados

