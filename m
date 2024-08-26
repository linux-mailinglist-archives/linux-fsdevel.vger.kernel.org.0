Return-Path: <linux-fsdevel+bounces-27220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2553C95F9E5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 21:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585B71C224DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Aug 2024 19:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31C66199E9A;
	Mon, 26 Aug 2024 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="w4Xk4Ryg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8E8199397
	for <linux-fsdevel@vger.kernel.org>; Mon, 26 Aug 2024 19:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724701462; cv=none; b=mOE4c2vXPNEfoXMnqPotsESaXtyrOcBm4dmMpmes4Le8QPa/CT7XZmENa5yWWA1VvW4zUO5kBLG1tF1kb5eLPc1huqIeZYfTYiSTXMXc/1azdYe0w+5zpFv+lVeBzSXstOyzw9nGLJlOoV1au73LuPuBNiZIoj1SLwlMcyuynp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724701462; c=relaxed/simple;
	bh=4igx5teOukkMacDOV/PFpTCBebtak/4C2EERBn9gDyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qPbwKLyEpHnPiDK1GtsBc1dIkmPmQ7AIv1uE0iiGY0b2nUAlKQUuEWnew9d9onB9iFLnRFWkg4912a8KB/EJit9/5ZRJL1p+fedsLlgGg/N0muEw4OuqnEqrajlmnPkiJ2cHwvEgzC1yR8OcDpdPdw59j6qag6hJ8GpJ2AJ8cdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=w4Xk4Ryg; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Aug 2024 15:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724701459;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LDMGFe13GlJh0NWv8nNP4lXHShXehj8hyHhCkAKKMRg=;
	b=w4Xk4Rygb3gnraQzMrgeOnd5VokpeCG7H3A7QIdNjDHjxKCeD5EhqU4+HWXH1iQIr0caj4
	97D01bGu5X2qPnkm6H4dh02SZR6ePcPKIM/pUKjlavT39UrrsSL1SaB3gW9XjMNr7VAVCs
	59kbaU5PcOTAhootz5lVSuIhPCqP1W0=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Michal Hocko <mhocko@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Christoph Hellwig <hch@lst.de>, 
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz, Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-bcachefs@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 1/2] bcachefs: do not use PF_MEMALLOC_NORECLAIM
Message-ID: <3rfzqzmzzq5lvti3wndvctwi46ovntwume3h6nlvyfkym7b2md@is7sdli3ucaa>
References: <20240826085347.1152675-1-mhocko@kernel.org>
 <20240826085347.1152675-2-mhocko@kernel.org>
 <egma4j7om4jcrxwpks6odx6wu2jc5q3qdboncwsja32mo4oe7r@qmiviwad32lm>
 <Zszado75SnObVKG5@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zszado75SnObVKG5@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Aug 26, 2024 at 08:41:42PM GMT, Matthew Wilcox wrote:
> On Mon, Aug 26, 2024 at 03:39:47PM -0400, Kent Overstreet wrote:
> > Given the amount of plumbing required here, it's clear that passing gfp
> > flags is the less safe way of doing it, and this really does belong in
> > the allocation context.
> > 
> > Failure to pass gfp flags correctly (which we know is something that
> > happens today, e.g. vmalloc -> pte allocation) means you're introducing
> > a deadlock.
> 
> The problem with vmalloc is that the page table allocation _doesn't_
> take a GFP parameter.

and given the increasing usage of kvmalloc() this is something we really
should be thinking about

