Return-Path: <linux-fsdevel+bounces-54070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ECAFAFAE94
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 10:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C277F4A0213
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 08:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA428A704;
	Mon,  7 Jul 2025 08:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WnC1+YD8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821D3220F2C
	for <linux-fsdevel@vger.kernel.org>; Mon,  7 Jul 2025 08:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751876865; cv=none; b=UA8NKePhdIgh87EB0qd2GVxc2Rip0BPm9R34VLS281zK4OB3Hn5TfkxGlSw3MXd7NXBX6SGSeJ+soQB/m8hQILvtFoYE3Q1IBbUUzVetqpcXNLjaij49hu3oIF2ji7vW7FuZWV1epfAx/yM51sKjGDVznwyiiabEYH4Q6M3xxxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751876865; c=relaxed/simple;
	bh=S0gxNspeTMFi/RnrEKnmOQT5PU/6Uofk+dJnZxLj5j0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DSEuVULJ/4wju7sF3WwoJvgPr5keK0OtO4lG0lfATmq8ELhDOdZt1fdevcXKhpIbQjSVh8tezoyVmeastF7DHWq6hO1rSDq9giGLYCR+G7ODGqlFMfo7q8ARPoVA9twc/l3duwWLGwxXh8K3uY3osL30dRqfeJUcy1wbbOkr1UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WnC1+YD8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB0C4CEE3;
	Mon,  7 Jul 2025 08:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751876865;
	bh=S0gxNspeTMFi/RnrEKnmOQT5PU/6Uofk+dJnZxLj5j0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WnC1+YD8jzkVlhqgz0wz0ic7T8vcF6VTIiTZ18EOpqZnmnnf+7NDguhVBiZ2KNFx8
	 5zDRMD0do7e5F5yP9dMI0UnX0HnS4uCNdQRdLo4S1y54o3+XkYdFvd0R6FxRiA3KlA
	 WrvSi7hp4ULY5znXyVq88mQWwKWyObOaVAD7oTqImT3nGaUYV1lpnUh+YEC+d3kGNj
	 loBKJ87Ph3qpteO3Qld+TfiCemhk7MMFuJ6ClLuDQV5oWeY+bwhLetpThe8o9HsRYN
	 RqMWCmvU6php/lHJxdWsxP/ZffE62+FRg3hXapTvG9/2mWvTafE77SZ91p3BkLv75w
	 SupsViROjKsqg==
Date: Mon, 7 Jul 2025 10:27:41 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH][RFC] kernel/acct.c: saner struct file treatment
Message-ID: <20250707-parkdeck-zusatz-614e95938757@brauner>
References: <20250706195844.GD1880847@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250706195844.GD1880847@ZenIV>

On Sun, Jul 06, 2025 at 08:58:44PM +0100, Al Viro wrote:
> 	Instead of switching ->f_path.mnt of an opened file to internal
> clone, resolve the pathname, get a struct path with ->mnt set to internal
> clone, then dentry_open() that to get the file with right ->f_path.mnt
> from the very beginning.
> 
> 	The only subtle part here is that on failure exits we need to
> close the file with __fput_sync() and make sure we do that *before*
> dropping the original mount.
> 
> 	With that done, only fs/{file_table,open,namei}.c ever store
> anything to file->f_path and only prior to file->f_mode & FMODE_OPENED
> becoming true.  Analysis of mount write count handling also becomes
> less brittle and convoluted...
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/kernel/acct.c b/kernel/acct.c
> index 6520baa13669..30ae403ee322 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -44,19 +44,14 @@
>   * a struct file opened for write. Fixed. 2/6/2000, AV.
>   */
>  
> -#include <linux/mm.h>
>  #include <linux/slab.h>
>  #include <linux/acct.h>
>  #include <linux/capability.h>
> -#include <linux/file.h>
>  #include <linux/tty.h>
> -#include <linux/security.h>
> -#include <linux/vfs.h>
> +#include <linux/statfs.h>
>  #include <linux/jiffies.h>
> -#include <linux/times.h>
>  #include <linux/syscalls.h>
> -#include <linux/mount.h>
> -#include <linux/uaccess.h>
> +#include <linux/namei.h>
>  #include <linux/sched/cputime.h>
>  
>  #include <asm/div64.h>
> @@ -217,84 +212,68 @@ static void close_work(struct work_struct *work)
>  	complete(&acct->done);
>  }
>  
> -static int acct_on(struct filename *pathname)
> +DEFINE_FREE(fput_sync, struct file *, if (!IS_ERR_OR_NULL(_T)) __fput_sync(_T))
> +static int acct_on(const char __user *name)
>  {
> -	struct file *file;
> -	struct vfsmount *mnt, *internal;
> +	/* Difference from BSD - they don't do O_APPEND */
> +	const int open_flags = O_WRONLY|O_APPEND|O_LARGEFILE;
>  	struct pid_namespace *ns = task_active_pid_ns(current);
> +	struct path path __free(path_put) = {};		// in that order
> +	struct path internal __free(path_put) = {};	// in that order
> +	struct file *file __free(fput_sync) = NULL;	// in that order

Very nice, I like it.
Reviewed-by: Christian Brauner <brauner@kernel.org>

