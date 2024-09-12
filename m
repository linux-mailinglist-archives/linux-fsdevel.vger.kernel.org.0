Return-Path: <linux-fsdevel+bounces-29160-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15045976894
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 14:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE48B1F24052
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2024 12:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29D11A0BE7;
	Thu, 12 Sep 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r9/z9LIM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EABC28F4
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Sep 2024 12:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726142680; cv=none; b=MOOIgbSg74mM5ormV+e/385guaC/6NR6vclDKxrtCm95pvLAlG3Wue5IyxohgnLEL1D4YTAh//uR8gLw836ArBg4jkliijgjHsiAI/pWUmtuh9rE3eLOWJedwhl7eN3TP69VYPukqTKULrF2fCOxGjaYs5Z71sNKjlrKC6AcZuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726142680; c=relaxed/simple;
	bh=Th7eA52r6l3hMIu88VejGbUxQXhaAgoCza6asAVe1Mo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k53H6FG6lWvD/m8rZ3o4B5t4Ob4YMK9d5Qvwwa5+g7ySkGgtTWsctW7LnuuuDWhbTJ0L92ZJAQ6+/W/HPI9pDxtWkgXnM6GlfCi7g/SEQIfBkYd0XKsdilmB7CbIQfkCHxl7hNlNM3sght5eEpVIp/kO33yAdOQeYxFtHXPzcWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r9/z9LIM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78153C4CEC4;
	Thu, 12 Sep 2024 12:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726142679;
	bh=Th7eA52r6l3hMIu88VejGbUxQXhaAgoCza6asAVe1Mo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=r9/z9LIMErzIkqATK9sfPPd0oHD8yhh2l/Q7ex/bNPNwwibwZDFsC2tUT0qbiQUeX
	 R9HTFtt0ViTchMjxIxI+puGEP+ORzP3IOjF9VfMHaQ+OJ792ocEoD/r2Sa9JfM5joN
	 2mN1M3kbvUJf0SP68XlwZGKMK8y6SefPLHhcLnm3NvIZzfg4FhAny8HxTMRNvhxYDm
	 KGf4wA92iznsdr9MbPy94EgNOyLT+JYiUVIQEU1jL+5tiPGAR5LCzZ6mPzJbG1C8vr
	 XsYVOdil7IaA4hE02q2GJoblvHOB+jc1qEHky/KlFs5cBuFXSBx3qsLJLtZ3+p/DbI
	 VMm7StYNAbu5Q==
Date: Thu, 12 Sep 2024 14:04:35 +0200
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Yafang Shao <laoar.shao@gmail.com>, torvalds@linux-foundation.org, 
	viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] vfs: Introduce a new open flag to imply dentry
 deletion on file removal
Message-ID: <20240912-programm-umgibt-a1145fa73bb6@brauner>
References: <20240912091548.98132-1-laoar.shao@gmail.com>
 <20240912105340.k2qsq7ao2e7f4fci@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240912105340.k2qsq7ao2e7f4fci@quack3>

On Thu, Sep 12, 2024 at 12:53:40PM GMT, Jan Kara wrote:
> On Thu 12-09-24 17:15:48, Yafang Shao wrote:
> > Commit 681ce8623567 ("vfs: Delete the associated dentry when deleting a
> > file") introduced an unconditional deletion of the associated dentry when a
> > file is removed. However, this led to performance regressions in specific
> > benchmarks, such as ilebench.sum_operations/s [0], prompting a revert in
> > commit 4a4be1ad3a6e ("Revert 'vfs: Delete the associated dentry when
> > deleting a file'").
> > 
> > This patch seeks to reintroduce the concept conditionally, where the
> > associated dentry is deleted only when the user explicitly opts for it
> > during file removal.
> > 
> > There are practical use cases for this proactive dentry reclamation.
> > Besides the Elasticsearch use case mentioned in commit 681ce8623567,
> > additional examples have surfaced in our production environment. For
> > instance, in video rendering services that continuously generate temporary
> > files, upload them to persistent storage servers, and then delete them, a
> > large number of negative dentries—serving no useful purpose—accumulate.
> > Users in such cases would benefit from proactively reclaiming these
> > negative dentries. This patch provides an API allowing users to actively
> > delete these unnecessary negative dentries.
> > 
> > Link: https://lore.kernel.org/linux-fsdevel/202405291318.4dfbb352-oliver.sang@intel.com [0]
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Al Viro <viro@zeniv.linux.org.uk>
> > Cc: Christian Brauner <brauner@kernel.org>
> > Cc: Jan Kara <jack@suse.cz>
> 
> Umm, I don't think we want to burn a FMODE flag and expose these details of
> dentry reclaim to userspace. BTW, if we wanted to do this, we already have
> d_mark_dontcache() for in-kernel users which we could presumably reuse.
> 
> But I would not completely give up on trying to handle this in an automated
> way inside the kernel. The original solution you mention above was perhaps
> too aggressive but maybe d_delete() could just mark the dentry with a
> "deleted" flag, retain_dentry() would move such dentries into a special LRU
> list which we'd prune once in a while (say once per 5 s). Also this list
> would be automatically pruned from prune_dcache_sb(). This way if there's
> quick reuse of a dentry, it will get reused and no harm is done, if it
> isn't quickly reused, we'll free them to not waste memory.
> 
> What do people think about such scheme?

I agree that a new open flag is not the right way to go and it also
wastes a PF_* flag.

I think it'll probably be rather difficult to ensure that we don't see
performance regressions for some benchmark. Plus there will be users
that want aggressive negative dentry reclaim being fine with possibly
increased lookup cost independent of the directory case.

So imo the simple option is to add 681ce8623567 back behind a sysctl
that users that need aggressive negative dentry reclaim can simply turn on.

