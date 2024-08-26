Return-Path: <linux-fsdevel+bounces-27214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990B695F98F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51492280D00
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773DF199248;
	Mon, 26 Aug 2024 19:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JWEURzJp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C0E7A15A;
	Mon, 26 Aug 2024 19:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724700014; cv=none; b=NgZ8ZxJkL5vi9iuNjQOwMIKrrGXN5kiQ/JbiyyNp+kBfa5Afwc05J54ByVAKjxIUYfBYs1Amz99xnzMesfeJ31uoa/iyfHrad751xcMqs3IU/EZ/fEYdE4vZBiciwkRMA27/Gt+JUx1LhfN/fkpppO5TBLqtm4av0WYulmjs5J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724700014; c=relaxed/simple;
	bh=eTLrYsdmdBE+wLoLDRD8KNqEIQ+NOGihDOwUj8S32FE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrK1qgVnN9qJaGpz8aHRQJkMbC9MoITV1d+ICFAuZCN1kYWJjl/XA0lEbGfOre0P0ECEwecSJUVX7mkxLOKErNlVrnt/vPaO/YgGs+66428EGCMSRRXfKaQlh+OAUTuDZc90FmU6QglgfP4btMwy/yBJePb27m/QDQAYNWR7JE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JWEURzJp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yjKrCodld8mbOV/lM4+5WUcrI6600Kgbv5GVWkH6l9I=; b=JWEURzJp5Uaqr7feHKFvhix5DO
	pW2WNEtWNsMJK99Z25yikjA4azTuEY5eCa8HC6WdG577dPxsJsjWZTureRmNt/frzwJCPccjNvzQQ
	2aCfU4WkOP+drKkSEcOs8jul4tJq9iW1JypZBytn9GYCGtvoCjo92SIlL83t0QsVCLoNexbqLphuv
	2WuufdPHfhbITSDR/dCS1n3fH6pjp2f4E4LRlKbUUqPqfXOcXJx6QS+ISMKYbkECoZaEHVtftYpfI
	b2kw7EQVKWJX+Y2q6+TqJNFamTZIfrAA8WfUCVRcaLN0LEDQhsbL9kZbPrZWjXr9SFY9lmMeHDSll
	VR19Q7Jw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sifFz-0000000FujW-1zIQ;
	Mon, 26 Aug 2024 19:20:03 +0000
Date: Mon, 26 Aug 2024 20:20:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>,
	Kent Overstreet <kent.overstreet@linux.dev>, jack@suse.cz,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: drop PF_MEMALLOC_NORECLAIM
Message-ID: <ZszVY_vDk229rf2y@casper.infradead.org>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-3-mhocko@kernel.org>
 <ZsyKQSesqc5rDFmg@casper.infradead.org>
 <ZsyyqxSv3-IbaAAO@tiehlicka>
 <ZszAI7oYsh7FvGgg@casper.infradead.org>
 <ZszU6dTOJYmujMPd@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZszU6dTOJYmujMPd@tiehlicka>

On Mon, Aug 26, 2024 at 09:18:01PM +0200, Michal Hocko wrote:
> On Mon 26-08-24 18:49:23, Matthew Wilcox wrote:
> > On Mon, Aug 26, 2024 at 06:51:55PM +0200, Michal Hocko wrote:
> [...]
> > > If a plan revert is preferably, I will go with it.
> > 
> > There aren't any other users of PF_MEMALLOC_NOWARN and it definitely
> > seems like something you want at a callsite rather than blanket for every
> > allocation below this point.  We don't seem to have many PF_ flags left,
> > so let's not keep it around if there's no immediate plans for it.
> 
> Good point. What about this?

Looks clean to me.

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

> >From 923cd429d4b1a3520c93bcf46611ae74a3158865 Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Mon, 26 Aug 2024 21:15:02 +0200
> Subject: [PATCH] Revert "mm: introduce PF_MEMALLOC_NORECLAIM,
>  PF_MEMALLOC_NOWARN"
> 
> This reverts commit eab0af905bfc3e9c05da2ca163d76a1513159aa4.
> 
> There is no existing user of those flags. PF_MEMALLOC_NOWARN is
> dangerous because a nested allocation context can use GFP_NOFAIL which
> could cause unexpected failure. Such a code would be hard to maintain
> because it could be deeper in the call chain.
> 
> PF_MEMALLOC_NORECLAIM has been added even when it was pointed out [1]
> that such a allocation contex is inherently unsafe if the context
> doesn't fully control all allocations called from this context.
> 
> While PF_MEMALLOC_NOWARN is not dangerous the way PF_MEMALLOC_NORECLAIM
> is it doesn't have any user and as Matthew has pointed out we are
> running out of those flags so better reclaim it without any real users.
> 
> [1] https://lore.kernel.org/all/ZcM0xtlKbAOFjv5n@tiehlicka/
> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  include/linux/sched.h    |  4 ++--
>  include/linux/sched/mm.h | 17 ++++-------------
>  2 files changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index f8d150343d42..731ff1078c9e 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1657,8 +1657,8 @@ extern struct pid *cad_pid;
>  						 * I am cleaning dirty pages from some other bdi. */
>  #define PF_KTHREAD		0x00200000	/* I am a kernel thread */
>  #define PF_RANDOMIZE		0x00400000	/* Randomize virtual address space */
> -#define PF_MEMALLOC_NORECLAIM	0x00800000	/* All allocation requests will clear __GFP_DIRECT_RECLAIM */
> -#define PF_MEMALLOC_NOWARN	0x01000000	/* All allocation requests will inherit __GFP_NOWARN */
> +#define PF__HOLE__00800000	0x00800000
> +#define PF__HOLE__01000000	0x01000000
>  #define PF__HOLE__02000000	0x02000000
>  #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_mask */
>  #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 91546493c43d..07c4fde32827 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -258,25 +258,16 @@ static inline gfp_t current_gfp_context(gfp_t flags)
>  {
>  	unsigned int pflags = READ_ONCE(current->flags);
>  
> -	if (unlikely(pflags & (PF_MEMALLOC_NOIO |
> -			       PF_MEMALLOC_NOFS |
> -			       PF_MEMALLOC_NORECLAIM |
> -			       PF_MEMALLOC_NOWARN |
> -			       PF_MEMALLOC_PIN))) {
> +	if (unlikely(pflags & (PF_MEMALLOC_NOIO | PF_MEMALLOC_NOFS | PF_MEMALLOC_PIN))) {
>  		/*
> -		 * Stronger flags before weaker flags:
> -		 * NORECLAIM implies NOIO, which in turn implies NOFS
> +		 * NOIO implies both NOIO and NOFS and it is a weaker context
> +		 * so always make sure it makes precedence
>  		 */
> -		if (pflags & PF_MEMALLOC_NORECLAIM)
> -			flags &= ~__GFP_DIRECT_RECLAIM;
> -		else if (pflags & PF_MEMALLOC_NOIO)
> +		if (pflags & PF_MEMALLOC_NOIO)
>  			flags &= ~(__GFP_IO | __GFP_FS);
>  		else if (pflags & PF_MEMALLOC_NOFS)
>  			flags &= ~__GFP_FS;
>  
> -		if (pflags & PF_MEMALLOC_NOWARN)
> -			flags |= __GFP_NOWARN;
> -
>  		if (pflags & PF_MEMALLOC_PIN)
>  			flags &= ~__GFP_MOVABLE;
>  	}
> -- 
> 2.46.0
> 
> 
> -- 
> Michal Hocko
> SUSE Labs

