Return-Path: <linux-fsdevel+bounces-42902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 452FBA4B2C1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 16:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCD223B063B
	for <lists+linux-fsdevel@lfdr.de>; Sun,  2 Mar 2025 15:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7864D1E98F4;
	Sun,  2 Mar 2025 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leUV2vxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63241D799D
	for <linux-fsdevel@vger.kernel.org>; Sun,  2 Mar 2025 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740931185; cv=none; b=EVuJBTDBj1Szk+D9u8xwHRJEMZjErj3VqMqBu0qrJovxcwpcfRHrZYvNZNqypFkN+uzwNTAbt+9we62TklR6LRkR7RrYVSlF2/FFxs4/uOp2YnONOYv8ZM06OSKd2QzqqW/A9O7ASoKE3ktZsDPVWNLCTrpKcC3L5tcezhTarRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740931185; c=relaxed/simple;
	bh=GNKdp/XfG977D//T2G7VfPctI1BlolI2HjqvmlfyAko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLC2eyb/wLervqmyBLcnDS/c+psqNl9gnL11cnXu9pkuPzLUWqPXIbn+AC+QTZWPlHoj39pPQQDvZSnaOYkAYplhbtrE3/+cEpTgH/ob1KNnRvrlGUoJFzrpk8gyYDMKl8mtrp08djYSiJHDMi2bFltIvLpfZiRg0Mmaj5n4c2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leUV2vxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B69C4CED6;
	Sun,  2 Mar 2025 15:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740931184;
	bh=GNKdp/XfG977D//T2G7VfPctI1BlolI2HjqvmlfyAko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=leUV2vxtfy+xj4WlOHoGDa0CzHMum8ZB9TodXGLSH6LAUHN4moE3GDmPD81pxwhDc
	 FXz3YT9Nxi/H56317+s3zfc6J/YthdOvNtV4xZSBZLcnnZD0A0CvmSxKUp+iN9tACf
	 HQcPqd0y/jDQ+oZ/eHphPx4PgPXDhzphsvuPDEKGhKByW32JHPxtpXiaiT92PFCkrJ
	 U/QVnVIVPx8I4FdYbb843XcrdY5ljDR4NfLssBW9nTVgJBzUUjhKsMzAdHz4TzMP43
	 vRWpqJoqqI5l7IXS+nzsKzIO+7hr+kwuqL63pp/jTNWcXi+6ijVERPBjPlhhxSeIKs
	 KY68A93fV/Kiw==
Date: Sun, 2 Mar 2025 16:59:40 +0100
From: Christian Brauner <brauner@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
	Lennart Poettering <lennart@poettering.net>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Mike Yuan <me@yhndnzj.com>
Subject: Re: [PATCH RFC 03/10] pidfs: move setting flags into
 pidfs_alloc_file()
Message-ID: <20250302-erbsen-leihen-e30d8feff54e@brauner>
References: <20250228-work-pidfs-kill_on_last_close-v1-0-5bd7e6bb428e@kernel.org>
 <20250228-work-pidfs-kill_on_last_close-v1-3-5bd7e6bb428e@kernel.org>
 <20250302130936.GB2664@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250302130936.GB2664@redhat.com>

On Sun, Mar 02, 2025 at 02:09:36PM +0100, Oleg Nesterov wrote:
> On 02/28, Christian Brauner wrote:
> >
> > @@ -696,6 +696,10 @@ struct file *pidfs_alloc_file(struct pid *pid, unsigned int flags)
> >  		return ERR_PTR(ret);
> >
> >  	pidfd_file = dentry_open(&path, flags, current_cred());
> > +	/* Raise PIDFD_THREAD explicitly as dentry_open() strips it. */
>                                             ^^^^^^^^^^^^^^^^^^^^^^^
> Hmm, does it?
> 
> dentry_open(flags) just passes "flags" to alloc_empty_file()->init_file(),
> and init_file(flags) does
> 
> 	f->f_flags      = flags;
> 
> so it seems that

dentry_open()
-> do_dentry_open()
   {
           f->f_flags &= ~(O_CREAT | O_EXCL | O_NOCTTY | O_TRUNC);
	           f->f_iocb_flags = iocb_flags(f);
   }

> 
> > @@ -2042,11 +2042,6 @@ static int __pidfd_prepare(struct pid *pid, unsigned int flags, struct file **re
> >  	if (IS_ERR(pidfd_file))
> >  		return PTR_ERR(pidfd_file);
> >
> > -	/*
> > -	 * anon_inode_getfile() ignores everything outside of the
> > -	 * O_ACCMODE | O_NONBLOCK mask, set PIDFD_THREAD manually.
> > -	 */
> > -	pidfd_file->f_flags |= (flags & PIDFD_THREAD);
> 
> we can just kill this outdated code?

Unfortunately not.

