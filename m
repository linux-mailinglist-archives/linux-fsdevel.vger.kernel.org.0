Return-Path: <linux-fsdevel+bounces-2502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0367E6728
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D819928130C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 09:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342A513AEA;
	Thu,  9 Nov 2023 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWtoxDXZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666ED13AC2;
	Thu,  9 Nov 2023 09:53:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EEAC433C7;
	Thu,  9 Nov 2023 09:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699523602;
	bh=DE6zRh88bFCXD27bxRqdFPBWWJlvXc87IUKONSgEtiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AWtoxDXZuMYt+P1ipspcysIalJ9bpOp+5lv5G9IiAHB0Vqa2sxPIKGKdUV+tjnNRm
	 fMfZu/q3Jo94nNwRj3o3RmmrpxD92kQQmOKTjcguhdrEvhRrnRa6gCErhMssRWeSvC
	 AF9CtwSxty+4LQl+i0E0NquiCtWQsib3YRXAqV9sbqvO4kQ/mY49lqSMmYtXiDQlU7
	 FQjLY0BysizzUnvEk+9uBLKVX/wS81XLeP6CosCCDh9MsMQBJpzq9CfMA0e82ps3FU
	 j4PEPzAVwSS7rdmlBMGRubsnx2JktM5SoMnZ46VSpCRF1cq52erYtIn8AIJD0xwtFd
	 LUvKWPu7ZIrhg==
Date: Thu, 9 Nov 2023 10:53:17 +0100
From: Christian Brauner <brauner@kernel.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: cgroups@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Haitao Huang <haitao.huang@linux.intel.com>,
	Kamalesh Babulal <kamalesh.babulal@oracle.com>,
	Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 4/6] misc cgroup: introduce an fd counter
Message-ID: <20231108-ernst-produktiv-f0f5d2ceeade@brauner>
References: <20231108002647.73784-1-tycho@tycho.pizza>
 <20231108002647.73784-5-tycho@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231108002647.73784-5-tycho@tycho.pizza>

> @@ -411,9 +453,22 @@ struct files_struct *dup_fd(struct files_struct *oldf, unsigned int max_fds, int
>  
>  	rcu_assign_pointer(newf->fdt, new_fdt);
>  
> -	return newf;
> +	if (!charge_current_fds(newf, count_open_files(new_fdt)))
> +		return newf;


> @@ -542,6 +600,10 @@ static int alloc_fd(unsigned start, unsigned end, unsigned flags)
>  	if (error)
>  		goto repeat;
>  
> +	error = -EMFILE;
> +	if (charge_current_fds(files, 1) < 0)
> +		goto out;

Whoops, I had that message ready to fire but didn't send it.

This may have a noticeable performance impact as charge_current_fds()
calls misc_cg_try_charge() which looks pretty expensive in this
codepath.

We're constantly getting patches to tweak performance during file open
and closing and adding a function that does require multiple atomics and
spinlocks won't exactly improve this.

On top of that I really dislike that we're pulling cgroups into this
code here at all.

Can you get a similar effect through a bpf program somehow that you
don't even tie this to cgroups?

