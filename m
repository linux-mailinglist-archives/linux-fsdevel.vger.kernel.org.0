Return-Path: <linux-fsdevel+bounces-14901-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038A68813DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 15:57:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 170DFB21239
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81157860;
	Wed, 20 Mar 2024 14:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6undZVR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B64457303;
	Wed, 20 Mar 2024 14:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710946505; cv=none; b=rRsCfMKoqj532+p9pSX0Zt8NeXjkAXjw4uHzWJkWUGKXSkjwpJXGXL3y3MnDuekYvCXfFh45tSEssMV5SXocuOZs7F++UxnIhPP5qQh89flzNxBiDsk3IDikXVemQ4eNLWJ/EwotVWQgJN5IpvqijZJ8XqiFYFcoSj5vX0Pqwfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710946505; c=relaxed/simple;
	bh=KeYT5UzdLaST/u42XA5RfF1bMjzLUwOAm2cvw7vsD3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZR8a1MzUcYnQ/AeeugWdFf5tMY3XSFnc3kUIdWtp0Ra1VoQETIlrKnEtZjNT7Kff0kQyAkcLe8acJAnhZkmpcL2cmIYUCJpjhlcD/t56DbZUiP0tXio30LgkmA0SFiYXsgP630tEBTWLxYDA//P7JP9bPYuVqEt36pwcHdX22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6undZVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02F1C433F1;
	Wed, 20 Mar 2024 14:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710946504;
	bh=KeYT5UzdLaST/u42XA5RfF1bMjzLUwOAm2cvw7vsD3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6undZVR+OkJrTnIn1k61vEXPdrTQs0C9gV1yMKG76H8McGbJmI34yn99Bxb32Fa2
	 k4YvXQclxwUjFtflEc9JFilu3+c+XaJiifHZtSxAiyQ2Xp2Lr0GqUVz5X645X/nEk9
	 qMWNODNOInATN7jHGYqLcdgF7qGh71OI5X0XeCmx6NW56RY4wRNEOiL1s+JQCvSqnT
	 E8XQDsZ8y2sFf/s5bo/2rIb8BA98MRjTSrr2o5TVkqozY0yiWXlhjJJOnU0FqcqVSt
	 o/7Ejh9spsCtJVEu/w2XSiIByYmYULaeked8IafwGwtmRU4zMHBpBHr2Cj7CoVhr1u
	 tkXPDlhez663g==
Date: Wed, 20 Mar 2024 07:55:04 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 08/29] fsverity: add per-sb workqueue for post read
 processing
Message-ID: <20240320145504.GY1927156@frogsfrogsfrogs>
References: <171035223299.2613863.12196197862413309469.stgit@frogsfrogsfrogs>
 <171035223488.2613863.7583467519759571221.stgit@frogsfrogsfrogs>
 <20240319233010.GV1927156@frogsfrogsfrogs>
 <ktc3ofsctond43xfc3lerr4evy3a3hsclyxm24cmhf7fsxxfsw@gjqnq57cbeoy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ktc3ofsctond43xfc3lerr4evy3a3hsclyxm24cmhf7fsxxfsw@gjqnq57cbeoy>

On Wed, Mar 20, 2024 at 11:37:28AM +0100, Andrey Albershteyn wrote:
> On 2024-03-19 16:30:10, Darrick J. Wong wrote:
> > On Wed, Mar 13, 2024 at 10:54:39AM -0700, Darrick J. Wong wrote:
> > > From: Andrey Albershteyn <aalbersh@redhat.com>
> > > 
> > > For XFS, fsverity's global workqueue is not really suitable due to:
> > > 
> > > 1. High priority workqueues are used within XFS to ensure that data
> > >    IO completion cannot stall processing of journal IO completions.
> > >    Hence using a WQ_HIGHPRI workqueue directly in the user data IO
> > >    path is a potential filesystem livelock/deadlock vector.
> > > 
> > > 2. The fsverity workqueue is global - it creates a cross-filesystem
> > >    contention point.
> > > 
> > > This patch adds per-filesystem, per-cpu workqueue for fsverity
> > > work. This allows iomap to add verification work in the read path on
> > > BIO completion.
> > > 
> > > Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
> > > Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> > > Signed-off-by: Darrick J. Wong <djwong@kernel.org>
> > > ---
> > >  fs/super.c               |    7 +++++++
> > >  include/linux/fs.h       |    2 ++
> > >  include/linux/fsverity.h |   22 ++++++++++++++++++++++
> > >  3 files changed, 31 insertions(+)
> > > 
> > > 
> > > diff --git a/fs/super.c b/fs/super.c
> > > index d35e85295489..338d86864200 100644
> > > --- a/fs/super.c
> > > +++ b/fs/super.c
> > > @@ -642,6 +642,13 @@ void generic_shutdown_super(struct super_block *sb)
> > >  			sb->s_dio_done_wq = NULL;
> > >  		}
> > >  
> > > +#ifdef CONFIG_FS_VERITY
> > > +		if (sb->s_read_done_wq) {
> > > +			destroy_workqueue(sb->s_read_done_wq);
> > > +			sb->s_read_done_wq = NULL;
> > > +		}
> > > +#endif
> > > +
> > >  		if (sop->put_super)
> > >  			sop->put_super(sb);
> > >  
> > > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > > index ed5966a70495..9db24a825d94 100644
> > > --- a/include/linux/fs.h
> > > +++ b/include/linux/fs.h
> > > @@ -1221,6 +1221,8 @@ struct super_block {
> > >  #endif
> > >  #ifdef CONFIG_FS_VERITY
> > >  	const struct fsverity_operations *s_vop;
> > > +	/* Completion queue for post read verification */
> > > +	struct workqueue_struct *s_read_done_wq;
> > >  #endif
> > >  #if IS_ENABLED(CONFIG_UNICODE)
> > >  	struct unicode_map *s_encoding;
> > > diff --git a/include/linux/fsverity.h b/include/linux/fsverity.h
> > > index 0973b521ac5a..45b7c613148a 100644
> > > --- a/include/linux/fsverity.h
> > > +++ b/include/linux/fsverity.h
> > > @@ -241,6 +241,22 @@ void fsverity_enqueue_verify_work(struct work_struct *work);
> > >  void fsverity_invalidate_block(struct inode *inode,
> > >  		struct fsverity_blockbuf *block);
> > >  
> > > +static inline int fsverity_set_ops(struct super_block *sb,
> > > +				   const struct fsverity_operations *ops)
> > > +{
> > > +	sb->s_vop = ops;
> > > +
> > > +	/* Create per-sb workqueue for post read bio verification */
> > > +	struct workqueue_struct *wq = alloc_workqueue(
> > > +		"pread/%s", (WQ_FREEZABLE | WQ_MEM_RECLAIM), 0, sb->s_id);
> > 
> > Looking at this more closely, why is it that the fsverity_read_queue
> > is unbound and tagged WQ_HIGHPRI, whereas this one is instead FREEZEABLE
> > and MEM_RECLAIM and bound?
> > 
> > If it's really feasible to use /one/ workqueue for all the read
> > post-processing then this ought to be a fs/super.c helper ala
> > sb_init_dio_done_wq.  That said, from Eric's comments on the v5 thread
> > about fsverity and fscrypt locking horns over workqueue stalls I'm not
> > convinced that's true.
> 
> There's good explanation by Dave why WQ_HIGHPRI is not a good fit
> for XFS (potential livelock/deadlock):
> 
> https://lore.kernel.org/linux-xfs/20221214054357.GI3600936@dread.disaster.area/
> 
> Based on his feedback I changed it to per-filesystem.

Ah, ok.  Why is the workqueue tagged with MEM_RECLAIM though?  Does
letting it run actually help out with reclaim?  I guess it does by
allowing pages involved in readahead to get to unlocked state where they
can be ripped out. :)

--D

> -- 
> - Andrey
> 
> 

