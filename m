Return-Path: <linux-fsdevel+bounces-48185-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E442AABD9C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 10:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5A804C51E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 May 2025 08:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 583E92620E7;
	Tue,  6 May 2025 08:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcC8lBvF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB02E24FBE7;
	Tue,  6 May 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746521127; cv=none; b=ivnXnj7ApWK7Pz32WpZAmLmK8gO7G5UgoEHMRbYbBQbXH2E1OWCe9uYBNGTHwcChyTlzurin9Ai/Tm+/JH0CJ9+kNsoTyFoanYxglacpvp/J6iblIs0sNCL3Yd6sodLDG4FBE6vE+6lQpjd+f//2iPbyQ7aDyfAZoToAuR6V4aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746521127; c=relaxed/simple;
	bh=IEMRExOPF7Vp+ar6JIpFYEDCf7kGx3fzTEEPhvJ1EeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0xOrMKmFj3ii24uc10+kgYEdBvIcDNwQnztEDcENAp+MUojSTDVeishBuztyjTh2EArhUrtGbaZ6NZ6JK1SUvUAZ02oK7aU0W4vo0+QRqpzZuC+lqhnU1DbBCdKLxfAv6EfNSqIgYEgtLmlZmDyz4K18nC3oXq1vOe7tjW67yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcC8lBvF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAE31C4CEE4;
	Tue,  6 May 2025 08:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746521127;
	bh=IEMRExOPF7Vp+ar6JIpFYEDCf7kGx3fzTEEPhvJ1EeQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qcC8lBvF+kjjhPKC6nCzecuoDuECcD6LlSKkfS7u+xY2PKBBek1xgrmerA6UtgFTw
	 BEtSsfwOSWLFQ0qQby0zvUu96+Q++JJTm5omuwJJv43oN+oN3ofolRlC5QNtP69KiT
	 1ctv86iVXmqG8E9XCRXM8OBCUjTWW6Hcmoo4WyFIVBJS9C8L/5y8R2nUAE6aHbCN7b
	 x6RJ3nOqsdG9Ij0hdbH8yhnY0XFAL5P8l6UB7SyfTvf0nvNZwsa3lSXAb0T11RAMiD
	 UuvHzvV1+iITI3j+oFkegxT3Uyb46wVW8c97XPaMHGWStkvollXpQ7mC1rBWb3Phk9
	 EttuM/0kCzqtQ==
Date: Tue, 6 May 2025 10:45:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Yunseong Kim <ysk@kzalloc.com>, Jan Kara <jack@suse.cz>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	byungchul@sk.com, max.byungchul.park@gmail.com, linux-fsdevel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Prevent panic from NULL dereference in
 alloc_fs_context() during do_exit()
Message-ID: <20250506-hochphase-kicken-7fa895216c2a@brauner>
References: <20250505203801.83699-2-ysk@kzalloc.com>
 <20250505223615.GK2023217@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250505223615.GK2023217@ZenIV>

On Mon, May 05, 2025 at 11:36:15PM +0100, Al Viro wrote:
> On Tue, May 06, 2025 at 05:38:02AM +0900, Yunseong Kim wrote:
> > The function alloc_fs_context() assumes that current->nsproxy and its
> > net_ns field are valid. However, this assumption can be violated in
> > cases such as task teardown during do_exit(), where current->nsproxy can
> > be NULL or already cleared.
> > 
> > This issue was triggered during stress-ng's kernel-coverage.sh testing,
> > Since alloc_fs_context() can be invoked in various contexts — including
> > from asynchronous or teardown paths like do_exit() — it's difficult to
> > guarantee that its input arguments are always valid.
> > 
> > A follow-up patch will improve the granularity of this fix by moving the
> > check closer to the actual mount trigger(e.g., in efivarfs_pm_notify()).
> 
> UGH.
> 
> > diff --git a/fs/fs_context.c b/fs/fs_context.c
> > index 582d33e81117..529de43b8b5e 100644
> > --- a/fs/fs_context.c
> > +++ b/fs/fs_context.c
> > @@ -282,6 +282,9 @@ static struct fs_context *alloc_fs_context(struct file_system_type *fs_type,
> >  	struct fs_context *fc;
> >  	int ret = -ENOMEM;
> >  
> > +	if (!current->nsproxy || !current->nsproxy->net_ns)
> > +		return ERR_PTR(-EINVAL);
> > +
> >  	fc = kzalloc(sizeof(struct fs_context), GFP_KERNEL_ACCOUNT);
> >  	if (!fc)
> >  		return ERR_PTR(-ENOMEM);
> 
> That might paper over the oops, but I very much doubt that this will be
> a correct fix...  Note that in efivarfs_pm_notify() we have other
> fun issues when run from such context - have task_work_add() fail in
> fput() and if delayed_fput() runs right afterwards and
>         efivar_init(efivarfs_check_missing, sfi->sb, false);
> in there might end up with UAF...

We've already accepted a patch that removes the need for
vfs_kern_mount() from efivarfs completely.

