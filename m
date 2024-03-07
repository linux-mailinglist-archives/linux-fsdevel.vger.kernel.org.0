Return-Path: <linux-fsdevel+bounces-13933-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA838759D7
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 22:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 918B21F22EEF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Mar 2024 21:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BADA13C9DB;
	Thu,  7 Mar 2024 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdWpuIPc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E165713B7BE;
	Thu,  7 Mar 2024 21:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709848739; cv=none; b=PNyGHoCAaepEzjpffxZdc1ZjfQmQ9WTjt7JCLur6WJtaFJJ6ffYhxK93VDEBPb4S+PSaR8D91WHjVj9UePKV1Rd3bD6UDYJSg5KLC92niXlw07peTwdVm2F71S2Qy1kyd/EKopg55sFf3lnfOvI1n8jtTsua7j1cyI/INEXcQvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709848739; c=relaxed/simple;
	bh=0T5Vg1WBZy9Tq6yxxivRyO+uA+lB4cp22W46V2U/rnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UFHIP6mPUy2Lqm5BXzCiX0DVtvCdcKb/cjk5UgDJcy3BHQazdm0dw0qHMjC2OWcf7GjwvKgYLI0YXOB/xb3ozW441vYaUuK/1rJerdIyLKj1NupKtnePxtLbgq4uZNFzCZ7ux0aA9uuMtRSwL4EwUZ5hVw1Brw6Spc1hFEKCGyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdWpuIPc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB5FC433C7;
	Thu,  7 Mar 2024 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709848738;
	bh=0T5Vg1WBZy9Tq6yxxivRyO+uA+lB4cp22W46V2U/rnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdWpuIPcUmyeQ1Co6CS2KBY/fiQIkkzy7KmLsUOR3cErU8YvaOnpuw3KwPo/Zlbx0
	 ZK+saUrF9E2Rk3cf3GoVeSrOcaAD8xwV6j5XcyN/sf9r4peCn+LGfocwE48fkyQc2C
	 S9CEUoe4M6n3vvnYjTzO7er8X5X81QpKl+bVZS8xKZjrPkP7f24TeKmenvnUOltUIw
	 ISIBZp8ETHq02I8BjlatT0OZIIUMZJ2pit4D0SyV2cbbZ1UPDhjxHtAnJu56Lrl3me
	 +8h2KtS+GpycocRTBZpkgpJI+EaIWTGOKXPerZNBhMpzoPiJna1xehnhA234R9uZrF
	 bx25oTWVi4Z7A==
Date: Thu, 7 Mar 2024 13:58:57 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	chandan.babu@oracle.com
Subject: Re: [PATCH v5 08/24] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240307215857.GS1927156@frogsfrogsfrogs>
References: <20240304191046.157464-2-aalbersh@redhat.com>
 <20240304191046.157464-10-aalbersh@redhat.com>
 <20240305010805.GF17145@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240305010805.GF17145@sol.localdomain>

On Mon, Mar 04, 2024 at 05:08:05PM -0800, Eric Biggers wrote:
> On Mon, Mar 04, 2024 at 08:10:31PM +0100, Andrey Albershteyn wrote:
> > For XFS, fsverity's global workqueue is not really suitable due to:
> > 
> > 1. High priority workqueues are used within XFS to ensure that data
> >    IO completion cannot stall processing of journal IO completions.
> >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> >    path is a potential filesystem livelock/deadlock vector.
> > 
> > 2. The fsverity workqueue is global - it creates a cross-filesystem
> >    contention point.
> > 
> > This patch adds per-filesystem, per-cpu workqueue for fsverity
> > work. This allows iomap to add verification work in the read path on
> > BIO completion.
> > 
> > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> 
> Should ext4 and f2fs switch over to this by converting
> fsverity_enqueue_verify_work() to use it?  I'd prefer not to have to maintain
> two separate workqueue strategies as part of the fs/verity/ infrastructure.

(Agreed.)

> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 1fbc72c5f112..5863519ffd51 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -1223,6 +1223,8 @@ struct super_block {
> >  #endif
> >  #ifdef CONFIG_FS_VERITY
> >  	const struct fsverity_operations *s_vop;
> > +	/* Completion queue for post read verification */
> > +	struct workqueue_struct *s_read_done_wq;
> >  #endif
> 
> Maybe s_verity_wq?  Or do you anticipate this being used for other purposes too,
> such as fscrypt?  Note that it's behind CONFIG_FS_VERITY and is allocated by an
> fsverity_* function, so at least at the moment it doesn't feel very generic.

Doesn't fscrypt already create its own workqueues?

> > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > index 0973b521ac5a..45b7c613148a 100644
> > --- a/include/linux/fsverity.h
> > +++ b/include/linux/fsverity.h
> > @@ -241,6 +241,22 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
> >  void fsverity_invalidate_block(struct inode *inode,
> >  		struct fsverity_blockbuf *block);
> >  
> > +static inline int fsverity_set_ops(struct super_block *sb,
> > +				   const struct fsverity_operations *ops)
> 
> This doesn't just set the ops, but also allocates a workqueue too.  A better
> name for this function might be fsverity_init_sb.
> 
> Also this shouldn't really be an inline function.

Yeah.

> > +{
> > +	sb->s_vop = ops;
> > +
> > +	/* Create per-sb workqueue for post read bio verification */
> > +	struct workqueue_struct *wq = alloc_workqueue(
> > +		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
> 
> "pread" is short for "post read", I guess?  Should it really be this generic?

I think it shouldn't use a term that already means "positioned read" to
userspace.

> > +static inline int fsverity_set_ops(struct super_block *sb,
> > +				   const struct fsverity_operations *ops)
> > +{
> > +	return -EOPNOTSUPP;
> > +}
> 
> I think it would be better to just not have a !CONFIG_FS_VERITY stub for this.
> 
> You *could* make it work like fscrypt_set_ops(), which the ubifs folks added,
> where it can be called unconditionally if the filesystem has a declaration for
> the operations (but not necessarily a definition).  In that case it would need
> to return 0, rather than an error.  But I think I prefer just omitting the stub
> and having filesystems guard the call to this by CONFIG_FS_VERITY, as you've
> already done in XFS.

Aha, I was going to ask why XFS had its own #ifdef guards when this
already exists. :)

--D

> - Eric
> 

