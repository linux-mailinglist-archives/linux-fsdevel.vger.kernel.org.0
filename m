Return-Path: <linux-fsdevel+bounces-52372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D1AAE271E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 04:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E00781BC292A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 02:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3324114A0B7;
	Sat, 21 Jun 2025 02:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlYceuU9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A21EED7;
	Sat, 21 Jun 2025 02:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750473881; cv=none; b=az6u5mrk5vX1m1BlrVaWTKTnXVvu6iuaV8j0bspMBuDm5siKxyB/lGe+9IixfLTpOoIXV1rlNP+q5sZRuOWyE0rc13U6daQCvPUwVsNokJwyktaK6MtOJt8YoGpvxY21VjVT7UTBb4qZSq8xxp0Eh40XqrGB8wDR1KS0ZYUN40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750473881; c=relaxed/simple;
	bh=HozVrZqVjuX7vUbn+808ik80PslBbRRFfupD4/mrc1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D9dubTdtV72/5113a2k9bXsdtRk4cqaWn67OQS2Ov3xdOdmHXXsNi4kAZNBLkKL9QshW3qiGU2MBTcXi6vsVUB5aJM2n/eylWeBFht5DeCO3eUYjOAkCe38rPeCF2+1LIA2HxmdURn4PLtooB899BJOqDNL0AECUGMvnhP/FqGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dlYceuU9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2ABC4CEE3;
	Sat, 21 Jun 2025 02:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750473881;
	bh=HozVrZqVjuX7vUbn+808ik80PslBbRRFfupD4/mrc1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dlYceuU9ZhWgtjiDdbXo/5YUu1/eK4C92c1C8VaQXB8zRu0hAWmxDxaC3jFtlktw4
	 VHbv0QaNOaiZHSkUq/fp/VpNOFLrFwqWCurfoSRnxVdrtikW8pPIcopcPBhfsMq05Z
	 +003e4e7z+K9CK6FTULwgJhpZ9honrIqHCCeUQmio0MxjDMP+ljP7QLYBo5B/K/86j
	 Bk3q98McC1bHFFcE2GixM72EeCnQC9t8qX5h3l5O1yIGqMbRpF9fVCc/XPeb+DikHv
	 0koPRM3ZcL7GQsuqYyAfkNEudUgpcbiNvFpfBO3cr9z/UjNHfnAAlQFM8fTyMPwED7
	 MJuYwIDcFVKiw==
Date: Fri, 20 Jun 2025 16:44:39 -1000
From: Tejun Heo <tj@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
	kernel-team@meta.com, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
	viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	kpsingh@kernel.org, mattbobrowski@google.com, amir73il@gmail.com,
	gregkh@linuxfoundation.org, daan.j.demeyer@gmail.com
Subject: Re: [PATCH v2 bpf-next 2/5] bpf: Introduce bpf_cgroup_read_xattr to
 read xattr of cgroup's node
Message-ID: <aFYcl8KQU9upkZ0f@slm.duckdns.org>
References: <20250619220114.3956120-1-song@kernel.org>
 <20250619220114.3956120-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619220114.3956120-3-song@kernel.org>

On Thu, Jun 19, 2025 at 03:01:11PM -0700, Song Liu wrote:
> BPF programs, such as LSM and sched_ext, would benefit from tags on
> cgroups. One common practice to apply such tags is to set xattrs on
> cgroupfs folders.
> 
> Introduce kfunc bpf_cgroup_read_xattr, which allows reading cgroup's
> xattr.
> 
> Note that, we already have bpf_get_[file|dentry]_xattr. However, these
> two APIs are not ideal for reading cgroupfs xattrs, because:
> 
>   1) These two APIs only works in sleepable contexts;
>   2) There is no kfunc that matches current cgroup to cgroupfs dentry.
> 
> Signed-off-by: Song Liu <song@kernel.org>
...
> +__bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__str,
> +					struct bpf_dynptr *value_p)
> +{
> +	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
> +	u32 value_len;
> +	void *value;
> +
> +	/* Only allow reading "user.*" xattrs */
> +	if (strncmp(name__str, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LEN))
> +		return -EPERM;

Just out of curiosity, what security holes are there if we allow BPF
programs to read other xattrs? Given how priviledged BPF programs already
are, does this make meaningful difference?

From cgroup POV:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun

