Return-Path: <linux-fsdevel+bounces-39389-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9DA13753
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 11:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6EE1165000
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 10:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DEBE1DDC19;
	Thu, 16 Jan 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IAgqR2f6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA3319259A;
	Thu, 16 Jan 2025 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737021843; cv=none; b=d4N9JCIUGro4IBgT5bbU2MOqgoOyZAYyIwqxPN20xNH/xU5NNKZk6BL6/7gqzN3YcQ/SwnQAOSMZv5H/JVuBN6gpyhIRwTGmto9xPbGBVCeuOZ9NcFfzMcBcB8G9/nPUI9cRGJOytLt1+Nyf+/sgrT63YxfwPQDlK6qnVoaj1dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737021843; c=relaxed/simple;
	bh=vOWQM+I3YRBGjUYDIowHfBe+kql+W0wxpSJ3h1dp89U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTTt3fL1i6hDd/AeZSkB7i+ORX0KuUwxO0QEalyG/UhFginyJiToOZ5ry4DSe1Pvk0lnn7JSKM3q4oiWFRCqQWSI7JJO3tVpU+hJEX2f9A1bZxMHmDHJTzsb+YqKA4r2DMgYW7bCEqDq9mm2jOmTXqWTrh+IAU8+K3lnhn2vRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IAgqR2f6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8394EC4CED6;
	Thu, 16 Jan 2025 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737021843;
	bh=vOWQM+I3YRBGjUYDIowHfBe+kql+W0wxpSJ3h1dp89U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IAgqR2f66QLIyDnlJbSk0pURydWNxseM1FJspSLBkNINi0tBhfM9rafMRa8Fh7jXI
	 X/IP3yQAnuTRRWVUMeZreOqI759pDr0UfGfwD6rxNXDM8bopEelBPpsrHjqB0dq8+Z
	 f7INV4NNHfjOuSUxgJvNmSniqiSaAOd/F4iyTma5i6Vp7kMzpIK5WuY4DJjAJYUGV5
	 SybOjcbKgQOt6adDDGmfohqQAh2Wurvyjc4q5ngWeI4K+I/El+T/pSa1BmM0z6vulg
	 JaRJP2M2hymQq+cuTQPeXzoDhAFUTQvtWiPUncRVXrccXXxEnHYXgKekjrM1OSnKQS
	 grprVO8ZExbiQ==
Date: Thu, 16 Jan 2025 11:03:58 +0100
From: Joel Granados <joel.granados@kernel.org>
To: yukaixiong <yukaixiong@huawei.com>
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
Subject: Re: Re: [PATCH v5 -next 00/16] sysctl: move sysctls from vm_table
 into its own files
Message-ID: <lxskw5notxchwlmwl2bspjqsxl52yjd6gknfyssr6xggnj2nll@2nqm5b3itvjh>
References: <20250111070751.2588654-1-yukaixiong@huawei.com>
 <2asuqwd4rpml6ylxce7mpz2vpvlm2gpdtwpp4lwuf4mdlylig2@dxdj4a73x2sb>
 <a3b4dcf9-7055-33f9-396c-c90b8cfa68d6@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3b4dcf9-7055-33f9-396c-c90b8cfa68d6@huawei.com>

On Wed, Jan 15, 2025 at 09:53:53AM +0800, yukaixiong wrote:
> 
> 
> On 2025/1/14 21:50, Joel Granados wrote:
> > On Sat, Jan 11, 2025 at 03:07:35PM +0800, Kaixiong Yu wrote:
> > > This patch series moves sysctls of vm_table in kernel/sysctl.c to
> > > places where they actually belong, and do some related code clean-ups.
> > > After this patch series, all sysctls in vm_table have been moved into its
> > > own files, meanwhile, delete vm_table.
> > > 
> > > All the modifications of this patch series base on
> > > linux-next(tags/next-20250110). To test this patch series, the code was
> > > compiled with both the CONFIG_SYSCTL enabled and disabled on arm64 and
> > > x86_64 architectures. After this patch series is applied, all files
> > > under /proc/sys/vm can be read or written normally.
> > It is looking good! Here is how I think we should move it upstream:
> > 
> > 1. These should queued in for 6.15 instead of the next merge window.
> >     It is too late in the current cycle and if we put it in now, it will
> >     not properly tested in linux-next.
> > 
> > 2. I am putting this in sysctl-testing with the expectation of pushing this
> >     up for the 6.15 merge window. Please tell me if you want this to go
> >     through some other tree.
> > 
> > Thx for the contribution
> > 
> > Best
> 
> Thank you! I don't want this to go through some other tree.
This was more for the mm, net and security maintainers :)


> 
> Best ...
> > > my test steps as below listed:
> > > 
> > > Step 1: Set CONFIG_SYSCTL to 'n' and compile the Linux kernel on the
> > > arm64 architecture. The kernel compiles successfully without any errors
> > > or warnings.
> > > 
> > ...
> > >   mm/swap.c                          |  16 ++-
> > >   mm/swap.h                          |   1 +
> > >   mm/util.c                          |  67 +++++++--
> > >   mm/vmscan.c                        |  23 +++
> > >   mm/vmstat.c                        |  44 +++++-
> > >   net/sunrpc/auth.c                  |   2 +-
> > >   security/min_addr.c                |  11 ++
> > >   23 files changed, 336 insertions(+), 312 deletions(-)
> > > 
> > > -- 
> > > 2.34.1
> > > 
> 

-- 

Joel Granados

