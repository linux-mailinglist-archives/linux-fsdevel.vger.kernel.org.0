Return-Path: <linux-fsdevel+bounces-28584-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F4696C3B5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 18:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A150B24B24
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 16:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A399940C03;
	Wed,  4 Sep 2024 16:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OSWlWl0y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238996E619
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 16:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725466526; cv=none; b=DhaLj4L3tbdDbKuJUL6uyCuf3wHVee/PRMiKWQ4lEvAF+9jAgvVRnB3bOZ3QGuW7k32T+s8aR90qKwnGRpFWDWt47z4gCYa70dWHEbyDkJEh7W1l2DP3i1anBuq599VbXN/d8Z3Vi7Ku3YTKKJcN0wCfYXlrLT4Nd73sFzFJl88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725466526; c=relaxed/simple;
	bh=i24P1pP2DSRPvREOe+kgy1xDpWGvVqGe7mo8BMTbudg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b8uXxu5w67wO+BHimbE5Lx2VkahN3PFYZPK1XyAwu64t2Qgpax8ErQhnm6SPmJevrFHa2q8WmTPu7SEnsMtzqjWsWHJ2sEB3aytxQhxufpQTpJ0Fqm2eytSplxPyoXKrq26gj85EpD0LfBZC5bbsxZ9jm/k41czcnYAl5X+uefY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OSWlWl0y; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 4 Sep 2024 12:15:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725466521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gFEcuTW9GDd5R6/s9Ksgowfe9BJ1JWP/ZMXulaxqbcg=;
	b=OSWlWl0yQRlbiZ0Q2PnP/1MUfPHPqQY2Vtmznt8DU97IsUs2JjjIyV45FCjfImOpyIQECz
	F+8Qul2/k8BAWHy8aJ1wqdv5cDJOXlXprRVoO4U7WY+VlIRCxyuwZJmUVVN+bH99o0dT9s
	0z1NTY1JvtiD6Q/WC4XdwboIullwJAc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, 
	Vlastimil Babka <vbabka@suse.cz>, Dave Chinner <dchinner@redhat.com>, 
	Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-bcachefs@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <zdrwzpzbe5oqawyklyb4gmdf6evhvmw3on5w2ewjyqfmdv2ndy@w7kdgpakbqv3>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <yewfyeumr2vj3o6dqcrv6b2giuno66ki7vzib3syitrstjkksk@e2k5rx3xbt67>
 <Zta1aZA4u8PCHQae@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zta1aZA4u8PCHQae@tiehlicka>
X-Migadu-Flow: FLOW_OUT

On Tue, Sep 03, 2024 at 09:06:17AM GMT, Michal Hocko wrote:
> On Mon 02-09-24 18:32:33, Kent Overstreet wrote:
> > On Mon, Sep 02, 2024 at 02:52:52PM GMT, Andrew Morton wrote:
> > > On Mon, 2 Sep 2024 05:53:59 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > > 
> > > > On Mon, Sep 02, 2024 at 11:51:48AM GMT, Michal Hocko wrote:
> > > > > The previous version has been posted in [1]. Based on the review feedback
> > > > > I have sent v2 of patches in the same threat but it seems that the
> > > > > review has mostly settled on these patches. There is still an open
> > > > > discussion on whether having a NORECLAIM allocator semantic (compare to
> > > > > atomic) is worthwhile or how to deal with broken GFP_NOFAIL users but
> > > > > those are not really relevant to this particular patchset as it 1)
> > > > > doesn't aim to implement either of the two and 2) it aims at spreading
> > > > > PF_MEMALLOC_NORECLAIM use while it doesn't have a properly defined
> > > > > semantic now that it is not widely used and much harder to fix.
> > > > > 
> > > > > I have collected Reviewed-bys and reposting here. These patches are
> > > > > touching bcachefs, VFS and core MM so I am not sure which tree to merge
> > > > > this through but I guess going through Andrew makes the most sense.
> > > > > 
> > > > > Changes since v1;
> > > > > - compile fixes
> > > > > - rather than dropping PF_MEMALLOC_NORECLAIM alone reverted eab0af905bfc
> > > > >   ("mm: introduce PF_MEMALLOC_NORECLAIM, PF_MEMALLOC_NOWARN") suggested
> > > > >   by Matthew.
> > > > 
> > > > To reiterate:
> > > > 
> > > 
> > > It would be helpful to summarize your concerns.
> > > 
> > > What runtime impact do you expect this change will have upon bcachefs?
> > 
> > For bcachefs: I try really hard to minimize tail latency and make
> > performance robust in extreme scenarios - thrashing. A large part of
> > that is that btree locks must be held for no longer than necessary.
> > 
> > We definitely don't want to recurse into other parts of the kernel,
> > taking other locks (i.e. in memory reclaim) while holding btree locks;
> > that's a great way to stack up (and potentially multiply) latencies.
> 
> OK, these two patches do not fail to do that. The only existing user is
> turned into GFP_NOWAIT so the final code works the same way. Right?

https://lore.kernel.org/linux-mm/20240828140638.3204253-1-kent.overstreet@linux.dev/

> > But gfp flags don't work with vmalloc allocations (and that's unlikely
> > to change), and we require vmalloc fallbacks for e.g. btree node
> > allocation. That's the big reason we want MEMALLOC_PF_NORECLAIM.
> 
> Have you even tried to reach out to vmalloc maintainers and asked for
> GFP_NOWAIT support for vmalloc? Because I do not remember that. Sure
> kernel page tables are have hardcoded GFP_KERNEL context which slightly
> complicates that but that doesn't really mean the only potential
> solution is to use a per task flag to override that. Just from top of my
> head we can consider pre-allocating virtual address space for
> non-sleeping allocations. Maybe there are other options that only people
> deeply familiar with the vmalloc internals can see.

That sounds really overly complicated.

