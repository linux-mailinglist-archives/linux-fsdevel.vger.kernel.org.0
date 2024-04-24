Return-Path: <linux-fsdevel+bounces-17674-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDB58B1535
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 23:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 40399B23643
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Apr 2024 21:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D68B156F53;
	Wed, 24 Apr 2024 21:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eQkDkwBo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57DB15699A;
	Wed, 24 Apr 2024 21:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713994429; cv=none; b=XiGzE3h1zirZPepgvB5eP9EJ7GeQYXp6w/GfPh9FD7TVm4KDAIrQgfo4V9RtpfqckGbUzo88y65+cpvs2IG2N8EtIjf3tm/ohJmhR1nycAvZWLjXoAIbyV5mtxs1wb1qLFVpVjtcwIQ8/ob4bvjFq/pexLvzaNx8xhLTbcCZfOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713994429; c=relaxed/simple;
	bh=d+DuxbhXHwl3vHEqlUX9jc4epAOXgZV8SAPWIws7yrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j9gULek7Z4rPv1frwZ37KZqgmNaRI+6/QS9JhZIyZVb8MiHrlcrZw0VoW6bqT3boZAZTRCH+dXi1FJQu5mIrPzQ1PetMCaC++dgIFlQqEDNxZ1SQfkfSIhwfYY23JqzAeVVtUa7ORFW/8sLGCvtMkI8OMm+Uyo7HSwBMMxqwLM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eQkDkwBo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC4BC113CD;
	Wed, 24 Apr 2024 21:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713994429;
	bh=d+DuxbhXHwl3vHEqlUX9jc4epAOXgZV8SAPWIws7yrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eQkDkwBoGYhZinzy9DKYa+u2QWUIkLpxfFap4zGDMNPdivEniK3r4BmuVSTsqCLp1
	 YCqjbCAz/Pg4eI7NVCDZr3Hyo6WDe86vnZUrFe1P+EVS7dNEFHjBmoncQnDE9xajSt
	 uJGPvL6evodup+m/S3y2TMeNeqe72l7C7BEdXHvoyW3PEJTz+WRzZu1twW557CeifK
	 va/OLZjUtuc5GgpJB7FS8Hqv4VtXQ7Ay+zJckHty+DXmXa1mDzzEHacXg3qsX0mPZP
	 HF84/DK30Wu/pu9SDfX38eReo/5kfCKoeoegs845NYGK5yMbd3pm0H0g4n8ZCmXave
	 K3eNrsnuZubXg==
Date: Wed, 24 Apr 2024 14:33:48 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: aalbersh@redhat.com, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, fsverity@lists.linux.dev
Subject: Re: [PATCH 04/13] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240424213348.GP360919@frogsfrogsfrogs>
References: <171175867829.1987804.15934006844321506283.stgit@frogsfrogsfrogs>
 <171175867930.1987804.1200988399612926993.stgit@frogsfrogsfrogs>
 <20240405023953.GC1958@quark.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240405023953.GC1958@quark.localdomain>

On Thu, Apr 04, 2024 at 10:39:53PM -0400, Eric Biggers wrote:
> On Fri, Mar 29, 2024 at 05:33:43PM -0700, Darrick J. Wong wrote:
> > diff --git a/fs/super.c b/fs/super.c
> > index 71d9779c42b10..aaa75131f6795 100644
> > --- a/fs/super.c
> > +++ b/fs/super.c
> > @@ -637,6 +637,13 @@ void generic_shutdown_super(struct super_block *sb)
> >  			sb->s_dio_done_wq = NULL;
> >  		}
> >  
> > +#ifdef CONFIG_FS_VERITY
> > +		if (sb->s_verify_wq) {
> > +			destroy_workqueue(sb->s_verify_wq);
> > +			sb->s_verify_wq = NULL;
> > +		}
> > +#endif
> 
> Should it maybe be s_verity_wq with a t?
> 
> I guess it could be argued that the actual data verification is just part of
> fsverity, and there could be other workqueues related to fsverity, e.g. one for
> enabling fsverity.  But in practice this is the only one.

Yeah.  If someone wants to add another wq for enabling verity then we
can deal with that

> Also, the runtime name of the workqueue is "fsverity/$s_id", which is more
> consistent with s_verity_wq than s_verify_wq.

Ok, s_verity_wq (with a t) it is.

I'll change __fsverity_init_verify_wq to __fsverity_init_wq since we're
getting rid of the "verify" wording.

> > +int __fsverity_init_verify_wq(struct super_block *sb)
> > +{
> > +	struct workqueue_struct *wq, *old;
> > +
> > +	wq = alloc_workqueue("fsverity/%s", WQ_MEM_RECLAIM | WQ_FREEZABLE, 0,
> > +			sb->s_id);
> > +	if (!wq)
> > +		return -ENOMEM;
> > +
> > +	/*
> > +	 * This has to be atomic as readaheads can race to create the
> > +	 * workqueue.  If someone created workqueue before us, we drop ours.
> > +	 */
> > +	old = cmpxchg(&sb->s_verify_wq, NULL, wq);
> > +	if (old)
> > +		destroy_workqueue(wq);
> > +	return 0;
> > +}
> 
> The cmpxchg thing makes no sense because this is only called at mount time, when
> there is no chance of a race condition.

Aha, right.  That was a dumb leftover from an earlier version that could
turn it on at runtime.  Removed.

--D

> - Eric
> 

