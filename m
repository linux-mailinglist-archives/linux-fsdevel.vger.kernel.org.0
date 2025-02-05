Return-Path: <linux-fsdevel+bounces-40911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 947F3A28A6D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 13:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B73FA3A4122
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Feb 2025 12:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 192F722D4C3;
	Wed,  5 Feb 2025 12:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FirndxN8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F73C151987;
	Wed,  5 Feb 2025 12:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738759162; cv=none; b=Rn0QqgSjcBuv4uiWjEGRXBPHzGjd2AvddbpvWAgSQ5+kNDyCyHWVKaMV5d2PQZgOFmNwC68iwXKyNhJvKjcDrQSIYDhDem46U4VwuUf3iqvep7PspHTNH/sMi8F+icKhC3i/6BnKpxOVirheDwt/DJoczGhMYUkvZbeN86PJx/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738759162; c=relaxed/simple;
	bh=gjnkul5ze2O0TEqEsn7OrVw4FMjwajJjo6S7dUZaW4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3fW8TFv3BV+7rSqZowxaFELEDHoio5gpWYb7aq13sFMkKiH0HMWq4+MF4l7cACfXcFGfty0dYlzsqjxF3BxMWnZg3NqgYCN5IFWGRUwTr5MnqeR0CfmGq/7nbfeq4mDJyesS3VqXLNFzAE+HzQHOXRI6p1gkD1iMSdHBDk5Xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FirndxN8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44319C4CED1;
	Wed,  5 Feb 2025 12:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738759161;
	bh=gjnkul5ze2O0TEqEsn7OrVw4FMjwajJjo6S7dUZaW4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FirndxN80c8BwhrQKHqUA3H3IyK6Z35QESZV0Q/tHAAfdtmgm96CtwtBwTpXyqLOq
	 jXvQdKIydOOavEq6cyQBtqcRsZUt2WpPgU1W1k5TE1oGi9lz0ip7i60lA86Lo90/JL
	 Hw77WHEsSxMVS/PKd0SV1ruEi+NsVMZBZUqXCYuQyq+ntHobO8bzuspDxpsocD2vxu
	 R2xBOJXR7zex9YourhtUnlriMOg90vsjLVQtojJop1XXxs7dNvmKx/VSKrVgkx+aYq
	 SJfUou2wMAcowi7UPUTr+odb0fM9fyNIET6DHzD3wl2cAYBuBp3ytpoaAkwtKQUA/8
	 ORK2DMl1+xAGg==
Date: Wed, 5 Feb 2025 13:39:16 +0100
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
Subject: Re: [PATCH v5 -next 00/16] sysctl: move sysctls from vm_table into
 its own files
Message-ID: <lmfy2wd6ke6pa7pfxwohmb4r5krvwcau4ybu6snkunpgod452b@24edzgbtf4ru>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
 <2asuqwd4rpml6ylxce7mpz2vpvlm2gpdtwpp4lwuf4mdlylig2@dxdj4a73x2sb>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2asuqwd4rpml6ylxce7mpz2vpvlm2gpdtwpp4lwuf4mdlylig2@dxdj4a73x2sb>

On Tue, Jan 14, 2025 at 02:50:12PM +0100, Joel Granados wrote:
> On Sat, Jan 11, 2025 at 03:07:35PM +0800, Kaixiong Yu wrote:
> > This patch series moves sysctls of vm_table in kernel/sysctl.c to
> > places where they actually belong, and do some related code clean-ups.
> > After this patch series, all sysctls in vm_table have been moved into its
> > own files, meanwhile, delete vm_table.
> > 
> > All the modifications of this patch series base on
> > linux-next(tags/next-20250110). To test this patch series, the code was
> > compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> > x86_64 architectures. After this patch series is applied, all files
> > under /proc/sys/vm can be read or written normally.
> 
> It is looking good! Here is how I think we should move it upstream:
> 
> 1. These should queued in for 6.15 instead of the next merge window.
>    It is too late in the current cycle and if we put it in now, it will
>    not properly tested in linux-next.
> 
> 2. I am putting this in sysctl-testing with the expectation of pushing this
>    up for the 6.15 merge window. Please tell me if you want this to go
>    through some other tree.
I have rebased on top of 6.14-rc1 and sent it out for sysctl-testing
once more. I'll add it to sysctl-next by the end of the week (unless we
see something pop-up in the testing).

Best

> 
> Thx for the contribution
> 
> Best
> > 
> > my test steps as below listed:
> > 
> > Step 1: Set CONFIG_SYSCTL to 'n' and compile the Linux kernel on the
> > arm64 architecture. The kernel compiles successfully without any errors
> > or warnings.
> > 
> ...
> >  mm/swap.c                          |  16 ++-
> >  mm/swap.h                          |   1 +
> >  mm/util.c                          |  67 +++++++--
> >  mm/vmscan.c                        |  23 +++
> >  mm/vmstat.c                        |  44 +++++-
> >  net/sunrpc/auth.c                  |   2 +-
> >  security/min_addr.c                |  11 ++
> >  23 files changed, 336 insertions(+), 312 deletions(-)
> > 
> > -- 
> > 2.34.1
> > 
> 
> -- 
> 
> Joel Granados

-- 

Joel Granados

