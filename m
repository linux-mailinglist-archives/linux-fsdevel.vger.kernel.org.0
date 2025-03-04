Return-Path: <linux-fsdevel+bounces-43171-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CEBA4EE2B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 21:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E442174E46
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Mar 2025 20:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BC521FAC34;
	Tue,  4 Mar 2025 20:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ooWuvNfL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDC01F8BBF
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Mar 2025 20:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741119373; cv=none; b=uK/Beg7nrgwrN7XU6TK3273ckNv8Rn8Z2p1jyd+TehEDAI5VMVE/L+qtp2BSj9tvDx5iGzpoa/En3cag0d10v7eIO4SrQ2CI1sFUXTJtXQEGufsSpuQ12uQBYNcreKX7R58URE8DXdWElppJSi2aQ65p6pSHEYSwLl91mvKP1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741119373; c=relaxed/simple;
	bh=NWHnTmp8jK1cj+XZ7WloG3n8EFqy0+m5sZXHFi9R7RE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RmXhy2LG9J+iU9yfexMj5RBcsdZrzD8LedUNV7zrVFMqJkjOdTnRlZlbzUk3+CPQ6PnYadrbsNwQfSB0MHUu2mYli3WmEKrDhTMvnJSimLf+a8uB+Y2jzHA3n9sRVdOnBS+CZeeS5VC4uyqdfco6Qhqmh6pK3il23e2B5A+y7bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ooWuvNfL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DB1C4CEE5;
	Tue,  4 Mar 2025 20:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741119373;
	bh=NWHnTmp8jK1cj+XZ7WloG3n8EFqy0+m5sZXHFi9R7RE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ooWuvNfLlLzmU1IuRjMUWQjRpo91mPTeNqFXXy8mgZYeg8pG3v/Qufnu1cCytBSD2
	 DMsv04vSpb8xTQr8zuozmd35/ZxCfxoxlPp49F6+39omTJIgKIb8onxUuLaD9WZ4ll
	 8ppyo8KFiNiWcEimXgIx4UMPYG+CoItIts9jStDn3KMPCKyLZz4h2VKsL4wEYv9uA5
	 jOdn7to5RztsxgqtfUYwvFNBUonXPaEYTXm063SMJspNSpqKUFX6fr+HxJ6xvHyQx1
	 36dvKQMFwP+maJZMCs3BJeqpFJYNIBXBIwnyNs9iwS7MYJGalrPZQ1ZGxvOTAJ5i4b
	 z2arrSDbPziqA==
Date: Tue, 4 Mar 2025 21:16:09 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH v2 06/15] pidfs: allow to retrieve exit information
Message-ID: <20250304-gehilfen-dorfgemeinschaft-8e42ba62f12a@brauner>
References: <20250304-work-pidfs-kill_on_last_close-v2-0-44fdacfaa7b7@kernel.org>
 <20250304-work-pidfs-kill_on_last_close-v2-6-44fdacfaa7b7@kernel.org>
 <20250304172255.GC5756@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304172255.GC5756@redhat.com>

On Tue, Mar 04, 2025 at 06:22:55PM +0100, Oleg Nesterov wrote:
> On 03/04, Christian Brauner wrote:
> >
> > @@ -248,6 +260,37 @@ static long pidfd_info(struct task_struct *task, unsigned int cmd, unsigned long
> >  	if (copy_from_user(&mask, &uinfo->mask, sizeof(mask)))
> >  		return -EFAULT;
> >
> > +	task = get_pid_task(pid, PIDTYPE_PID);
> > +	if (!task) {
> > +		if (!(mask & PIDFD_INFO_EXIT))
> > +			return -ESRCH;
> > +
> > +		if (!current_in_pidns(pid))
> > +			return -ESRCH;
> > +	}
> > +
> > +	if (mask & PIDFD_INFO_EXIT) {
> > +		exit_info = READ_ONCE(pidfs_i(inode)->exit_info);
> > +		if (exit_info) {
> > +#ifdef CONFIG_CGROUPS
> > +			kinfo.cgroupid = exit_info->cgroupid;
> > +			kinfo.mask |= PIDFD_INFO_EXIT | PIDFD_INFO_CGROUPID;
> > +#endif
> > +			kinfo.exit_code = exit_info->exit_code;
> > +		}
> 
> Confused... so, without CONFIG_CGROUPS pidfd_info() will never report
> PIDFD_INFO_EXIT in kinfo.mask ?

Fixed.

> 
> > --- a/include/uapi/linux/pidfd.h
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -20,6 +20,7 @@
> >  #define PIDFD_INFO_PID			(1UL << 0) /* Always returned, even if not requested */
> >  #define PIDFD_INFO_CREDS		(1UL << 1) /* Always returned, even if not requested */
> >  #define PIDFD_INFO_CGROUPID		(1UL << 2) /* Always returned if available, even if not requested */
> > +#define PIDFD_INFO_EXIT			(1UL << 3) /* Always returned if available, even if not requested */
>                                                               ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> The comment doesn't match the "if (mask & PIDFD_INFO_EXIT)" check above...

Also fixed.

