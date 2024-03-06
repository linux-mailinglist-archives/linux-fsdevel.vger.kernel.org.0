Return-Path: <linux-fsdevel+bounces-13746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8905C8735DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 12:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC4B1F2143D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Mar 2024 11:47:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712E07FBC1;
	Wed,  6 Mar 2024 11:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UAzp6+e3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FD17F7FC;
	Wed,  6 Mar 2024 11:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709725633; cv=none; b=nCt+6BXGavG/yrvjq+p60XRRDwD3sYcguoe5C1e9gNWpx0W9xfH2AF5NHtaEKoqNtSy4dGW7BdwYC0kwel2+l+Ovk22YOOvBwGeNPKr/9bJD9aBDqyYET+aXffEcUWrXpkinFkSHk+3fj1DhZwRaT8y8Y46Ce0KaIszxwAAhmWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709725633; c=relaxed/simple;
	bh=dMUjdKjTj+RHzTJn7EeiC5nAQml3X1bYXK4wvzEyszA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xh+GYH7g3IOKt6ZyjHJS2O4kdBmilsGsi2+2KN6Bb4Yf31/1IfCy2jpyurHhS6OhBEJh1/zTg2jmuoI+0CR+1W+POFzSKMh9TkvqDGN0HGy1sK6FYKhpjhIZp1DpFhmD3P1WgAzHVGK9VsZYtv/9q2bNXcSEaPRt7n7oTCI5Qxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UAzp6+e3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B396AC433F1;
	Wed,  6 Mar 2024 11:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709725633;
	bh=dMUjdKjTj+RHzTJn7EeiC5nAQml3X1bYXK4wvzEyszA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UAzp6+e3UZBg2JPvxIeFtqp4jSKQg4eSwfQV/fx/OHk5rlZOYh1I6Qlo257OM44dC
	 CaoCNBx2C4WC5lzhypFwhhkruSl7h2v6k0cTcfyEqYChyfc0WOCJnOpW1wO84+m1LA
	 QLFT8slMXxEnY8K4B64HR5ncaiLI7UmG7hgseuEA7SnkP7hQYi11h8eferGm+kVHxj
	 J0jraHGttWjtCeClH4ce4mNa/OXw5MAjN1em7aJpX+j8FBZhSfwMwg33zPmt5cSi1G
	 C/MeZ23BOfM+QsuD5AVFfrIBK918rtHUUyo6lA03SpD9QoYvDsicu3rH40ostZuplc
	 ht8dBEvwkgVrg==
Date: Wed, 6 Mar 2024 12:47:07 +0100
From: Christian Brauner <brauner@kernel.org>
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	kpsingh@google.com, jannh@google.com, jolsa@kernel.org, daniel@iogearbox.net, 
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 6/9] bpf: add acquire/release based BPF
 kfuncs for fs_struct's paths
Message-ID: <20240306-reitturnier-parolen-8589679861c8@brauner>
References: <cover.1709675979.git.mattbobrowski@google.com>
 <458617e6f11863ecf8b3f83710a6606977c4c9cd.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <458617e6f11863ecf8b3f83710a6606977c4c9cd.1709675979.git.mattbobrowski@google.com>

On Wed, Mar 06, 2024 at 07:40:12AM +0000, Matt Bobrowski wrote:
> Add the ability to obtain a reference on the root and pwd paths which
> are nested within the fs_struct associated with a supplied
> task_struct. Both fs_struct's root and pwd are commonly operated on in
> BPF LSM program types and at times are further handed off to BPF
> helpers and such. There needs to be a mechanism that supports BPF LSM
> program types the ability to obtain stable handles to such paths in
> order to avoid possible memory corruption bugs [0].
> 
> We provide this mechanism through the introduction of the following
> new KF_ACQUIRE/KF_RELEASE BPF kfuncs:
> 
> struct path *bpf_get_task_fs_root(struct task_struct *task);
> struct path *bpf_get_task_fs_pwd(struct task_struct *task);
> void bpf_put_path(struct path *path);
> 
> Note that bpf_get_task_fs_root() and bpf_get_task_fs_pwd() are

Right now all I'm seeing are requests for exporting a bunch of helpers
with no clear explanation other than "This is common in BPF LSM
programs.". So not going to happen if this is some private users pet bpf
program. Where's that bpf lsm program that has to use this?

> effectively open-coded variants of the in-kernel helpers get_fs_root()
> and get_fs_pwd(). We don't lean on these in-kernel helpers directly
> within the newly introduced BPF kfuncs as leaning on them would be
> rather awkward as we're wanting to return referenced path pointers
> directly BPF LSM program types.
> 
> [0] https://lore.kernel.org/bpf/CAG48ez0ppjcT=QxU-jtCUfb5xQb3mLr=5FcwddF_VKfEBPs_Dg@mail.gmail.com/
> 
> Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
> ---
>  kernel/trace/bpf_trace.c | 83 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 539c58db74d7..84fd87ead20c 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -10,6 +10,7 @@
>  #include <linux/bpf_perf_event.h>
>  #include <linux/btf.h>
>  #include <linux/filter.h>
> +#include <linux/fs_struct.h>
>  #include <linux/uaccess.h>
>  #include <linux/ctype.h>
>  #include <linux/kprobes.h>
> @@ -1569,6 +1570,83 @@ __bpf_kfunc void bpf_put_file(struct file *f)
>  	fput(f);
>  }
>  
> +/**
> + * bpf_get_task_fs_root - get a reference on the fs_struct's root path for the
> + * 			  supplied task_struct
> + * @Task: task_struct of which the fs_struct's root path to get a reference on
> + *
> + * Get a reference on the root path nested within the fs_struct of the
> + * associated *task*. The referenced path retruned from this kfunc must be
> + * released using bpf_put_path().
> + *
> + * Return: A referenced path pointer to the root path nested within the
> + * fs_struct of the supplied *task*, or NULL.
> + */
> +__bpf_kfunc struct path *bpf_get_task_fs_root(struct task_struct *task)
> +{
> +	struct path *root;
> +	struct fs_struct *fs;
> +
> +	task_lock(task);
> +	fs = task->fs;
> +	if (unlikely(fs)) {
> +		task_unlock(task);
> +		return NULL;
> +	}
> +
> +	spin_lock(&fs->lock);
> +	root = &fs->root;
> +	path_get(root);
> +	spin_unlock(&fs->lock);
> +	task_unlock(task);
> +
> +	return root;
> +}
> +
> +/**
> + * bpf_get_task_fs_pwd - get a reference on the fs_struct's pwd path for the
> + * 			 supplied task_struct
> + * @task: task_struct of which the fs_struct's pwd path to get a reference on
> + *
> + * Get a reference on the pwd path nested within the fs_struct of the associated
> + * *task*. The referenced path retruned from this kfunc must be released using
> + * bpf_put_path().
> + *
> + * Return: A referenced path pointer to the root path nested within the
> + * fs_struct of the supplied *task*, or NULL.
> + */
> +__bpf_kfunc struct path *bpf_get_task_fs_pwd(struct task_struct *task)
> +{
> +	struct path *pwd;
> +	struct fs_struct *fs;
> +
> +	task_lock(task);
> +	fs = task->fs;
> +	if (unlikely(fs)) {
> +		task_unlock(task);
> +		return NULL;
> +	}
> +
> +	spin_lock(&fs->lock);
> +	pwd = &fs->pwd;
> +	path_get(pwd);
> +	spin_unlock(&fs->lock);
> +	task_unlock(task);
> +
> +	return pwd;
> +}
> +
> +/**
> + * bpf_put_path - put a reference on the supplied path
> + * @path: path of which to put a reference on
> + *
> + * Put a reference on the supplied *path*.
> +  */
> +__bpf_kfunc void bpf_put_path(struct path *path)
> +{
> +	path_put(path);
> +}

Probably ok since it's exported to modules but same condition as
mentioned in my earlier mail.

