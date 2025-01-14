Return-Path: <linux-fsdevel+bounces-39137-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C346A10827
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 14:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4233A814F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2025 13:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16CC535DC;
	Tue, 14 Jan 2025 13:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B3WYSv8m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC2D382;
	Tue, 14 Jan 2025 13:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736862618; cv=none; b=uYDd7FKgMKuf+hKD3yX7Tn9Xe3GA2gFPwcNzXOqd7VvaPvgmqXRzXeRF+Cdb7tZRlFE4wLjIDHu1b6rQbJlojQ6tWrGbESBPJVHQ5VhqrxSmped+cvyH04sClzrVdL3o1azSKBpl4P1Fjv2SApKvtIXM7gdYhxhLcYMuH1/dzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736862618; c=relaxed/simple;
	bh=E9WCKWqZDdWrhuOJ8T3MRR+Wdu7159qHRnRM7zfR6Ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LzEIY8nVUCaC1PEBMeN3I1t31ktPu3cWlty5aoyxoh2PeOW498cBwJ0n7cbIeAZtVBKnuPDkVEnPgiMX7jCsctZi7L+iAOBWwVSpakwfhlg87o3vByRrYPl295PjvYEkqUq+mbK4X0cW/rpBsceDqtAv6MeRV1Q6eUXUr8IGvrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B3WYSv8m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FC1C4CEDD;
	Tue, 14 Jan 2025 13:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736862617;
	bh=E9WCKWqZDdWrhuOJ8T3MRR+Wdu7159qHRnRM7zfR6Ps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B3WYSv8m4sWSylXp9W3Sf17zPbMaNvU2ichDqWJ/pV+WhqBkiLI/x0mixcZekP/aV
	 7IPatKNy77Ep4aVGaq7/e5nrblpErKiiUZ0utc/rib3Bb7eqQylyqJOPn+a5aoJ7tS
	 9V3/DBK6XIWKUe4dkKp3i//29eH+tgB4F5QfCjIbsRhJjyAxbB1ba2DCm6IHk8nw2P
	 biqr9P1Wy+gXBaNqjgJGV/r23EWsD8jZNVMdkIPnxyCBU1x/TMKREi0xDCXR0DRQIH
	 PLualSGnHYpy1D1fcUUvDGZRtkr+MQKg+IlH4/HDClH4Ly4UOEfuXu0coYhf2di1Dr
	 Kcz4QrkfD9Z0w==
Date: Tue, 14 Jan 2025 14:50:12 +0100
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
Message-ID: <2asuqwd4rpml6ylxce7mpz2vpvlm2gpdtwpp4lwuf4mdlylig2@dxdj4a73x2sb>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250111070751.2588654-1-yukaixiong@huawei.com>

On Sat, Jan 11, 2025 at 03:07:35PM +0800, Kaixiong Yu wrote:
> This patch series moves sysctls of vm_table in kernel/sysctl.c to
> places where they actually belong, and do some related code clean-ups.
> After this patch series, all sysctls in vm_table have been moved into its
> own files, meanwhile, delete vm_table.
> 
> All the modifications of this patch series base on
> linux-next(tags/next-20250110). To test this patch series, the code was
> compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> x86_64 architectures. After this patch series is applied, all files
> under /proc/sys/vm can be read or written normally.

It is looking good! Here is how I think we should move it upstream:

1. These should queued in for 6.15 instead of the next merge window.
   It is too late in the current cycle and if we put it in now, it will
   not properly tested in linux-next.

2. I am putting this in sysctl-testing with the expectation of pushing this
   up for the 6.15 merge window. Please tell me if you want this to go
   through some other tree.

Thx for the contribution

Best
> 
> my test steps as below listed:
> 
> Step 1: Set CONFIG_SYSCTL to 'n' and compile the Linux kernel on the
> arm64 architecture. The kernel compiles successfully without any errors
> or warnings.
> 
...
>  mm/swap.c                          |  16 ++-
>  mm/swap.h                          |   1 +
>  mm/util.c                          |  67 +++++++--
>  mm/vmscan.c                        |  23 +++
>  mm/vmstat.c                        |  44 +++++-
>  net/sunrpc/auth.c                  |   2 +-
>  security/min_addr.c                |  11 ++
>  23 files changed, 336 insertions(+), 312 deletions(-)
> 
> -- 
> 2.34.1
> 

-- 

Joel Granados

