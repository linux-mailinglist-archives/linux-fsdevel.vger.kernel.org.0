Return-Path: <linux-fsdevel+bounces-26098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 811B6954409
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 10:24:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 157C9B2540B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Aug 2024 08:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24EC113DBB7;
	Fri, 16 Aug 2024 08:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oEB+QiZs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A311D69E
	for <linux-fsdevel@vger.kernel.org>; Fri, 16 Aug 2024 08:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796561; cv=none; b=O63LsroN7LWhiLDtJCBsWby/Qq+3kGgd8U4doqpp8lKWIzV6oSpRD+/jITBjrGLX0lWhO+clRXbe9ZOallwHKFh6eccqONYLQX3oiodDZ/dHp4CdLgiPfhGLf03RbzWQNBznimcW5R3a8qseUHUBfMh1brLSDUKGZ5puV10R7kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796561; c=relaxed/simple;
	bh=TzG0cJHkMmTQupV18hGHoHBePBtm5asgEqrR+hmMnXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHpreLbRTH6kozpe+VivxustFiSM98802dR7a4zZBJztyLBmrvgosBEVDu9VH6yhm6Oplnjta948KnWlhZi9ThxWCbPtM1QtahLbJs0sdQzuv8ayrBKNRDngMxD3jSuYVfZ7+W/PbCCXW2FvyG3KJkAz8VwHFaMPON6k0njHtbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oEB+QiZs; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1S/vCZY/lYJ8pslrqPz+xqOl/J9nwoWDT9AWGDSsP44=; b=oEB+QiZsFKmyhkvNImi3V0Fich
	vpUD7VopM8jsaiicBA3QwHHWKVgbh8raIWUQIJ7LpZAB2NasctXiFIC7bpxWM0gZzJMY/hOJ15DaU
	uh9nvHkuSUXEeqHJipVA2gp4vDFVjnfsLMNueKsFozd3ZqewPrMZ04ESXyj5nAbG+hXFXujS0WIms
	2d/xhszx7S9aQzBSKZziSnycSJYipFf0yBZ55bPu+8wz6DSWsz123YKAnGrdCS+XB5aPnAwdElMh8
	+s8gY8wsmc8cQGfh8ZUwPPaKIicqaccXjb9edn/hIBKQH39TZJ2KbGYylFSh+4im8ail79+RjLixS
	sHGiF15w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sesEH-0000000CFuR-1J3U;
	Fri, 16 Aug 2024 08:22:37 +0000
Date: Fri, 16 Aug 2024 01:22:37 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Yafang Shao <laoar.shao@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>, viro@zeniv.linux.org.uk,
	brauner@kernel.org, jack@suse.cz, david@fromorbit.com,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	Kent Overstreet <kent.overstreet@linux.dev>
Subject: Re: [PATCH] mm: document risk of PF_MEMALLOC_NORECLAIM
Message-ID: <Zr8MTWiz6ULsZ-tD@infradead.org>
References: <Zrn0FlBY-kYMftK4@infradead.org>
 <CALOAHbBd2oCVKsMwcH_YGUWT5LGLWmNSUAZzRPp8j7bBaqc1PQ@mail.gmail.com>
 <Zrxfy-F1ZkvQdhNR@tiehlicka>
 <CALOAHbCLPLpi39-HVVJvUj=qVcNFcQz=3cd95wFpKZzUntCtdw@mail.gmail.com>
 <ZrymePQHzTHaUIch@tiehlicka>
 <CALOAHbDw5_hFGsQGYpmaW2KPXi8TxnxPQg4z7G3GCyuJWWywpQ@mail.gmail.com>
 <Zr2eiFOT--CV5YsR@tiehlicka>
 <CALOAHbCnWDPnErCDOWaPo6vc__G56wzmX-j=bGrwAx6J26DgJg@mail.gmail.com>
 <Zr2liCOFDqPiNk6_@tiehlicka>
 <Zr8LMv89fkfpmBlO@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zr8LMv89fkfpmBlO@tiehlicka>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 16, 2024 at 10:17:54AM +0200, Michal Hocko wrote:
> Andrew, could you merge the following before PF_MEMALLOC_NORECLAIM can
> be removed from the tree altogether please? For the full context the 
> email thread starts here: https://lore.kernel.org/all/20240812090525.80299-1-laoar.shao@gmail.com/T/#u

I don't think that's enough.  We just need to kill it given that it was
added without ACKs and despite explicit earlier objections to the API.

That might leave bcachefs with broken inode allocation handling, but so
what - it's marked experimental and there should be other ways to sort
this out.

