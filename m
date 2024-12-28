Return-Path: <linux-fsdevel+bounces-38178-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A118E9FDA68
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 13:15:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480181882EF1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 12:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E4A15B13D;
	Sat, 28 Dec 2024 12:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IPmKL7Ab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B278157493;
	Sat, 28 Dec 2024 12:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735388106; cv=none; b=c9P74Fr2WXH4zkqZACaacSPjB6tBkGTOA5axiiZgUO3YlXt5fCxwSBF9KEB1yv757BkZHw1IQx/bSXjlu1nRXMfF93UpFDwfrmI8xoCUUr/i3E3I6cupVZNTOOjmw2NImyVCmvSiefkkvy88ZA+owGAJF3LE5jWQ+4d8Ac6AzeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735388106; c=relaxed/simple;
	bh=97/5224KtfCVtGhVMHx6krsVPkUDF0EY+TYp3O6MChU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsCScX3kgpdoM3GpmcBIMGPVlGasn8jGmPAl5/2eDwxaQlViRIkKEOQ4F/z+v4uuSrGokj4bgeAiskiO5djYmhcMYDp4mnLGTkinZo2G18LzA06LD9sCgtOOCZ6ja1Lcb07kXMFT7KbC5qXVXuA1xpWrpJ/IYYqvraRdocgtHtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IPmKL7Ab; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62852C4CECD;
	Sat, 28 Dec 2024 12:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735388106;
	bh=97/5224KtfCVtGhVMHx6krsVPkUDF0EY+TYp3O6MChU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IPmKL7AbU1Kqx31Ft9P9mrdb3gcll7S8m0Qfed5FXR1ytUSAQIbGF9qdOnyxed7Hq
	 jstjuYa3DV3wH/C2qaXbWwCo/rqhF7/nvV1cKQ9tLz3K5J8GyOFNzDsy2QpIjPO5xq
	 NepbzrZht8wPww1EphkIlzQverVOpEFgxAm3DtnjPK27lBBvnHBlq01mMQxJhMWBHC
	 mDunzRZm3w41CX0jK5/YcHTXirHiHIkYNa42270CjE/FXV0DcFfEox0AwYPYRdsOGR
	 zGnazmXNZEQwfDCiGXjJeQA7MvBYV412juQ3OdflPcnvQ6PuOuIfBBRCY1sTwmdRRv
	 pZvEd0sww2NqQ==
Date: Sat, 28 Dec 2024 13:15:00 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Kaixiong Yu <yukaixiong@huawei.com>
Cc: akpm@linux-foundation.org, mcgrof@kernel.org, 
	ysato@users.sourceforge.jp, dalias@libc.org, glaubitz@physik.fu-berlin.de, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, 
	hpa@zytor.com, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	kees@kernel.org, j.granados@samsung.com, willy@infradead.org, 
	Liam.Howlett@oracle.com, vbabka@suse.cz, lorenzo.stoakes@oracle.com, trondmy@kernel.org, 
	anna@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, 
	okorniev@redhat.com, Dai.Ngo@oracle.com, tom@talpey.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, paul@paul-moore.com, 
	jmorris@namei.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-nfs@vger.kernel.org, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, dhowells@redhat.com, 
	haifeng.xu@shopee.com, baolin.wang@linux.alibaba.com, shikemeng@huaweicloud.com, 
	dchinner@redhat.com, bfoster@redhat.com, souravpanda@google.com, hannes@cmpxchg.org, 
	rientjes@google.com, pasha.tatashin@soleen.com, david@redhat.com, 
	ryan.roberts@arm.com, ying.huang@intel.com, yang@os.amperecomputing.com, 
	zev@bewilderbeest.net, serge@hallyn.com, vegard.nossum@oracle.com, 
	wangkefeng.wang@huawei.com
Subject: Re: [PATCH v4 -next 00/15] sysctl: move sysctls from vm_table into
 its own files
Message-ID: <42tsyuvdvym6i3j4ppsluvx7kejxjzbma5z4jjgccni6kuwtj7@rhuklbyko7yf>
References: <20241223141550.638616-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241223141550.638616-1-yukaixiong@huawei.com>

On Mon, Dec 23, 2024 at 10:15:19PM +0800, Kaixiong Yu wrote:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.
> 
> All the modifications of this patch series base on
> linux-next(tags/next-20241219). To test this patch series, the code was
> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> x86_64 architectures. After this patch series is applied, all files
> under /proc/sys/vm can be read or written normally.
> 
> Changes in v4:
>  - change all "static struct ctl_table" type into
>    "static const struct ctl_table" type in patch1~10,12,13,14
>  - simplify result of rpcauth_cache_shrink_count() in patch11
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
>   sunrpc: simplify rpcauth_cache_shrink_count()
>   fs: dcache: move the sysctl to fs/dcache.c
>   x86: vdso: move the sysctl to arch/x86/entry/vdso/vdso32-setup.c
>   sh: vdso: move the sysctl to arch/sh/kernel/vsyscall/vsyscall.c
>   sysctl: remove unneeded include
This patchset looks strange. There seems to be 15 patches, but there are
30 e-mails in the thread? You can also see this when you look at it in
lore [1]. And they are different repeated e-mails (mutt does not
de-duplicate them). Also `b4 shazam ...` does not work. What happened?
Did you send it twice with the same mail ID? Am I the only one seeing
this?

I would suggest the following (hopefully you are using b4):
1. Check to see how things will be sent with b4. `b4 send --resend -o OUTPUT_DIR`
   If you see 30 emails in that dir from your patchset then something is
   still wrong.
2. After you make sure that everything is in order. Do the resend
   without bumping the version up (leave it at version 4)

Best

[1] : https://lore.kernel.org/all/20241223141550.638616-1-yukaixiong@huawei.com/

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

-- 

Joel Granados

