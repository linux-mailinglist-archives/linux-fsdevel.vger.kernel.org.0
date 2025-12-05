Return-Path: <linux-fsdevel+bounces-70753-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B01CA6071
	for <lists+linux-fsdevel@lfdr.de>; Fri, 05 Dec 2025 04:41:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5163B3121096
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Dec 2025 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09C7D26F462;
	Fri,  5 Dec 2025 03:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsxVmgkH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAC398FAE;
	Fri,  5 Dec 2025 03:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764906024; cv=none; b=CukPoYZPLjIVxKM5hqsIGCd3insyh2OIOfonCC9KllkRifm5wjX/7ZxE1UtW9ixx/BlVn38yQjo78P/MsQDW9N1MU7Rm15V6GdsGpwOoUQOMJan1oBoHzxxjY4iB3ZdtoKfN6cYGyI08sD88q4uLknXvmmPiQDbBrzDmW54r898=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764906024; c=relaxed/simple;
	bh=pmtBP/IRAchq9Y+Of4LdB+8xUK6lrQZOgkP3KGgymBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G92w4g/qND+PoJGnAvMuA3r8I8DQ8XzaKv7uXcJI957X4hHpkTiz0kXRO3Lgd8ITEYtZt/Z8gXOPqXHdJZrvk9fAkfrfnq/bfsGLOocZDmc7GLZi+NJkgFkwlW7HIajAe8ISxV0lGn6sQ4fa2gG0Elrkqw61/Z5cqvZRUFrwgm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsxVmgkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB03C4CEFB;
	Fri,  5 Dec 2025 03:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764906023;
	bh=pmtBP/IRAchq9Y+Of4LdB+8xUK6lrQZOgkP3KGgymBs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TsxVmgkHn5wz5hbY7X9e3YNY1yGivGCcIOtNeg3iaYGszqvV7YnRbUAHyCeXbbKgz
	 FUdcYygxNjaB9gm3Q41cR98Ivd1A94Q5fiiOwHbgm3cg8DFnYKJkAFjciSp/WTQWSM
	 8vk1nl3T+71SZ4FTbQLNjV6Z4SvdD7jNc6i1XSGATq4IHdyZI7aWQvZ+SSs4vTBd1R
	 9NVxrTKMKfsq6lXfhnSv0tMxb/+hWqP5A/Q6ReMb4dNM1opuVkh+Ax2p0li7qNbNWk
	 pG9ABSvmz6ibZwjC+ayCzcinjeWngw046Nxs71xsBefPtZ9CjiPdWBCPFXDorKRZE9
	 KC3xE1ArkomLg==
Date: Thu, 4 Dec 2025 19:40:23 -0800
From: Kees Cook <kees@kernel.org>
To: Andrei Vagin <avagin@google.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, cgroups@vger.kernel.org, criu@lists.linux.dev,
	Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Vipin Sharma <vipinsh@google.com>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH 1/3] cgroup, binfmt_elf: Add hwcap masks to the misc
 controller
Message-ID: <202512041939.63DA7C96C2@keescook>
References: <20251205005841.3942668-1-avagin@google.com>
 <20251205005841.3942668-2-avagin@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205005841.3942668-2-avagin@google.com>

On Fri, Dec 05, 2025 at 12:58:29AM +0000, Andrei Vagin wrote:
> Add an interface to the misc cgroup controller that allows masking out
> hardware capabilities (AT_HWCAP) reported to user-space processes. This
> provides a mechanism to restrict the features a containerized
> application can see.
> 
> The new "misc.mask" cgroup file allows users to specify masks for
> AT_HWCAP, AT_HWCAP2, AT_HWCAP3, and AT_HWCAP4.
> 
> The output of "misc.mask" is extended to display the effective mask,
> which is a combination of the masks from the current cgroup and all its
> ancestors.
> 
> Signed-off-by: Andrei Vagin <avagin@google.com>
> ---
>  fs/binfmt_elf.c             |  24 +++++--
>  include/linux/misc_cgroup.h |  25 +++++++
>  kernel/cgroup/misc.c        | 126 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 171 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 3eb734c192e9..59137784e81d 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -47,6 +47,7 @@
>  #include <linux/dax.h>
>  #include <linux/uaccess.h>
>  #include <uapi/linux/rseq.h>
> +#include <linux/misc_cgroup.h>
>  #include <asm/param.h>
>  #include <asm/page.h>
>  
> @@ -182,6 +183,21 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
>  	int ei_index;
>  	const struct cred *cred = current_cred();
>  	struct vm_area_struct *vma;
> +	struct misc_cg *misc_cg;
> +	u64 hwcap_mask[4] = {0, 0, 0, 0};
> +
> +	misc_cg = get_current_misc_cg();
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP, misc_cg, &hwcap_mask[0]);
> +#ifdef ELF_HWCAP2
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP2, misc_cg, &hwcap_mask[1]);
> +#endif
> +#ifdef ELF_HWCAP3
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP3, misc_cg, &hwcap_mask[2]);
> +#endif
> +#ifdef ELF_HWCAP4
> +	misc_cg_get_mask(MISC_CG_MASK_HWCAP4, misc_cg, &hwcap_mask[3]);
> +#endif

Can we avoid having the open-coded 4, 0, 1, 2, 3 where these are used?
I imagine it also doesn't need to be a 4 element array if ELF_HWCAP4
isn't defined, etc?

-- 
Kees Cook

