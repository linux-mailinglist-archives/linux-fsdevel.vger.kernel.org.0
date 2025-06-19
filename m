Return-Path: <linux-fsdevel+bounces-52168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E44A5AE005F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 10:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6694F189B1BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 08:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 304CD26561D;
	Thu, 19 Jun 2025 08:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6Gjk7/m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821CA200127;
	Thu, 19 Jun 2025 08:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750323003; cv=none; b=W1Bt9JMJUpCA8hNZ5NQAKZfcw1IDQRDKpLB6fOOQqJc1ynZVNt6jEnU3jnB1xUdRhR8vZ1bXDlz1/Dyk6udcak6MoFXA3TJ5UzxkRj9gsZQ0PBX1vg44PReD/ckxDkebUr9lhjm/RcZMClR2VzrjvKgiHORGtj0vQqa4I10uAec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750323003; c=relaxed/simple;
	bh=cBwxudyQikrHj8Bc2U1wr2xcmJ345R47XPGAlmaQVNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ImD0QZwY3PdvWwmheTJEe6QpTtw/tj4rnUHeguLJOxtXVhQMawHfjUTdAfpPALGQVxB1sPI28ZEKBe9SzlJiuO94yWFaDce3h3IgrQiPKe22MZfLpBuvC5Xa4XgWcWBVO8ZrAf17HakAuczH5Cx9IAzCDiKPCUaKDijjWht/fMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6Gjk7/m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76546C4CEEA;
	Thu, 19 Jun 2025 08:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750323003;
	bh=cBwxudyQikrHj8Bc2U1wr2xcmJ345R47XPGAlmaQVNM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6Gjk7/mZheo2Q1aYiVhSOkquWHmX0Nlx2B/A7hx3FvGdlxuOBNSkqLo6mOErzIKV
	 Gn4k315UgTdPk9s9HXu1llZaW+cYtFwrgtBIuX1ejG8ItrwLMxHbgPlm1MWehyohjU
	 eV90wNHS6+PT16miYoHeBkoqgecIXvNE2FC0uKHHKbSf7JX86EX5p63CNHgKTN7I4j
	 c6Jb31ZLVp50+Km6QWmyewzGolG4vbCIk+80iinRzFi+IAQ8mlvg9TVd84nBi1cBtS
	 +wh43GNH8dG4YmIfd2MbUDyMMmyrGpflEj1HIFCk68565bHDFn9oDpBe79M/YqnZdu
	 dEhjrOH/2+YlQ==
Date: Thu, 19 Jun 2025 10:49:56 +0200
From: Christian Brauner <brauner@kernel.org>
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, kernel-team@meta.com, 
	andrii@kernel.org, eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, viro@zeniv.linux.org.uk, jack@suse.cz, kpsingh@kernel.org, 
	mattbobrowski@google.com, amir73il@gmail.com, gregkh@linuxfoundation.org, tj@kernel.org, 
	daan.j.demeyer@gmail.com
Subject: Re: [PATCH bpf-next 2/4] bpf: Introduce bpf_kernfs_read_xattr to
 read xattr of kernfs nodes
Message-ID: <20250619-danksagung-besoldung-72cd313928b8@brauner>
References: <20250618233739.189106-1-song@kernel.org>
 <20250618233739.189106-3-song@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250618233739.189106-3-song@kernel.org>

On Wed, Jun 18, 2025 at 04:37:37PM -0700, Song Liu wrote:
> BPF programs, such as LSM and sched_ext, would benefit from tags on
> cgroups. One common practice to apply such tags is to set xattrs on
> cgroupfs files and folders.
> 
> Introduce kfunc bpf_kernfs_read_xattr, which allows reading kernfs
> xattr under RCU read lock.
> 
> Note that, we already have bpf_get_[file|dentry]_xattr. However, these
> two APIs are not ideal for reading cgroupfs xattrs, because:
> 
>   1) These two APIs only works in sleepable contexts;
>   2) There is no kfunc that matches current cgroup to cgroupfs dentry.
> 
> Signed-off-by: Song Liu <song@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 08412532db1b..7576dbc9b340 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -9,6 +9,7 @@
>  #include <linux/fs.h>
>  #include <linux/fsnotify.h>
>  #include <linux/file.h>
> +#include <linux/kernfs.h>
>  #include <linux/mm.h>
>  #include <linux/xattr.h>
>  
> @@ -322,6 +323,37 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentry *dentry, const char *name_
>  	return ret;
>  }
>  
> +/**
> + * bpf_kernfs_read_xattr - get xattr of a kernfs node
> + * @kn: kernfs_node to get xattr from
> + * @name__str: name of the xattr
> + * @value_p: output buffer of the xattr value
> + *
> + * Get xattr *name__str* of *kn* and store the output in *value_ptr*.
> + *
> + * For security reasons, only *name__str* with prefix "user." is allowed.
> + *
> + * Return: length of the xattr value on success, a negative value on error.
> + */
> +__bpf_kfunc int bpf_kernfs_read_xattr(struct kernfs_node *kn, const char *name__str,
> +				      struct bpf_dynptr *value_p)

Please pass struct cgroup, then go from struct cgroup to kernfs node.

