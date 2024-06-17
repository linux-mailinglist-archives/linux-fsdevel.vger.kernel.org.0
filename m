Return-Path: <linux-fsdevel+bounces-21808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ED790A8BF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 10:48:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD9BC1C21EB5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 08:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA80190699;
	Mon, 17 Jun 2024 08:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L00F5III"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B31171B0;
	Mon, 17 Jun 2024 08:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718614103; cv=none; b=i82A1PEczVzbUT6kYg05Qk0sN0x0hiuyAGo7nJvOshVGS8c7OV0RlqKlZjynXWxdGA5uoS/ZYoCLhsQ8WOYcOKF1FpX1HG86ZU9cRAAPsuok83GtUpFL2mtq999iv3TsB+GoC7WHv1xN155tll+J1XMQndgmAGdWW3WJx+ZZib8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718614103; c=relaxed/simple;
	bh=ahwV9Ju+1SVJkhYWRx0d6aXsj0gx6TEzit8ir2IL5ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z/yUdiPAaF5900D74dtLa9tTeTnj/oUrtPusgq+7JQsPpuxY6sX/iqyLSDvllj4n4l88t5ZLw2sXJa5orXrN5ow1uKlq3cJWVPW2z47Ochdr/keKOP0G496PWrkAJ/GBlWQmjon2tWsA+BTml47vbQTMM72gmHtQSlFFTdeLy0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L00F5III; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89ABFC3277B;
	Mon, 17 Jun 2024 08:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718614102;
	bh=ahwV9Ju+1SVJkhYWRx0d6aXsj0gx6TEzit8ir2IL5ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L00F5IIIJU/Fb9oPuacRQh6JHjKe9JMFXskYnMjttHXSAgJ8ou7NmS/FIeYizdwmc
	 NHwqNJFdtXYG4l18e+GzQPvHj074YOzawnPrd0wMw/YrhT4AUarBDd37pcSzQljmyx
	 /RPuuCXHchprbHKk80lNIYkfA0YqRLX9c1MWLkwFkZAaEn3W9nJGU474yqI/vLzo2Q
	 La5U7uKtpsAMJ9tlwVXejVZRkUC0zz9fOX/iFpMvvBh1RIxE8Mu9tAvdM9tANRVwMz
	 7lo8ttXGiZ3Nd2qoiRXa8lt3CeOMGfHiRuSwsnPccpvWn4ZGXU8theqd3tPS/9R428
	 H8ipiRkNtR0kQ==
Date: Mon, 17 Jun 2024 10:48:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
	kernel@collabora.com, gbiv@google.com, ryanbeltran@google.com, inglorion@google.com, 
	ajordanr@google.com, jorgelo@chromium.org, Jann Horn <jannh@google.com>, 
	Kees Cook <keescook@chromium.org>, Jeff Xu <jeffxu@google.com>, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v6 1/2] proc: pass file instead of inode to proc_mem_open
Message-ID: <20240617-emanzipation-ansiedeln-6fd2ae7659c8@brauner>
References: <20240613133937.2352724-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240613133937.2352724-1-adrian.ratiu@collabora.com>

On Thu, Jun 13, 2024 at 04:39:36PM GMT, Adrian Ratiu wrote:
> The file struct is required in proc_mem_open() so its
> f_mode can be checked when deciding whether to allow or
> deny /proc/*/mem open requests via the new read/write
> and foll_force restriction mechanism.
> 
> Thus instead of directly passing the inode to the fun,
> we pass the file and get the inode inside it.
> 
> Cc: Jann Horn <jannh@google.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Christian Brauner <brauner@kernel.org>
> Cc: Jeff Xu <jeffxu@google.com>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> Reviewed-by: Kees Cook <kees@kernel.org>
> ---

I've tentatively applies this patch to #vfs.procfs.
One comment, one question:

> No changes in v6
> ---
>  fs/proc/base.c       | 6 +++---
>  fs/proc/internal.h   | 2 +-
>  fs/proc/task_mmu.c   | 6 +++---
>  fs/proc/task_nommu.c | 2 +-
>  4 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/proc/base.c b/fs/proc/base.c
> index 72a1acd03675..4c607089f66e 100644
> --- a/fs/proc/base.c
> +++ b/fs/proc/base.c
> @@ -794,9 +794,9 @@ static const struct file_operations proc_single_file_operations = {
>  };
>  
>  
> -struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
> +struct mm_struct *proc_mem_open(struct file  *file, unsigned int mode)
>  {
> -	struct task_struct *task = get_proc_task(inode);
> +	struct task_struct *task = get_proc_task(file->f_inode);

Comment: This should use file_inode(file) but I've just fixed that when I
applied.

Question: Is this an equivalent transformation. So is the inode that was
passed to proc_mem_open() always the same inode as file_inode(file)?

>  	struct mm_struct *mm = ERR_PTR(-ESRCH);
>  
>  	if (task) {
> @@ -816,7 +816,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
>  
>  static int __mem_open(struct inode *inode, struct file *file, unsigned int mode)
>  {
> -	struct mm_struct *mm = proc_mem_open(inode, mode);
> +	struct mm_struct *mm = proc_mem_open(file, mode);
>  
>  	if (IS_ERR(mm))
>  		return PTR_ERR(mm);
> diff --git a/fs/proc/internal.h b/fs/proc/internal.h
> index a71ac5379584..d38b2eea40d1 100644
> --- a/fs/proc/internal.h
> +++ b/fs/proc/internal.h
> @@ -295,7 +295,7 @@ struct proc_maps_private {
>  #endif
>  } __randomize_layout;
>  
> -struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode);
> +struct mm_struct *proc_mem_open(struct file *file, unsigned int mode);
>  
>  extern const struct file_operations proc_pid_maps_operations;
>  extern const struct file_operations proc_pid_numa_maps_operations;
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index f8d35f993fe5..fe3b2182b0aa 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -210,7 +210,7 @@ static int proc_maps_open(struct inode *inode, struct file *file,
>  		return -ENOMEM;
>  
>  	priv->inode = inode;
> -	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
>  	if (IS_ERR(priv->mm)) {
>  		int err = PTR_ERR(priv->mm);
>  
> @@ -1030,7 +1030,7 @@ static int smaps_rollup_open(struct inode *inode, struct file *file)
>  		goto out_free;
>  
>  	priv->inode = inode;
> -	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
>  	if (IS_ERR(priv->mm)) {
>  		ret = PTR_ERR(priv->mm);
>  
> @@ -1754,7 +1754,7 @@ static int pagemap_open(struct inode *inode, struct file *file)
>  {
>  	struct mm_struct *mm;
>  
> -	mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	mm = proc_mem_open(file, PTRACE_MODE_READ);
>  	if (IS_ERR(mm))
>  		return PTR_ERR(mm);
>  	file->private_data = mm;
> diff --git a/fs/proc/task_nommu.c b/fs/proc/task_nommu.c
> index bce674533000..a8ab182a4ed1 100644
> --- a/fs/proc/task_nommu.c
> +++ b/fs/proc/task_nommu.c
> @@ -259,7 +259,7 @@ static int maps_open(struct inode *inode, struct file *file,
>  		return -ENOMEM;
>  
>  	priv->inode = inode;
> -	priv->mm = proc_mem_open(inode, PTRACE_MODE_READ);
> +	priv->mm = proc_mem_open(file, PTRACE_MODE_READ);
>  	if (IS_ERR(priv->mm)) {
>  		int err = PTR_ERR(priv->mm);
>  
> -- 
> 2.44.2
> 

