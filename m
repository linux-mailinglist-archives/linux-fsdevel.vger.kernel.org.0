Return-Path: <linux-fsdevel+bounces-27957-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 851EB965245
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 23:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B68D01C24286
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 21:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0F31B81C4;
	Thu, 29 Aug 2024 21:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pVNm5JVp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2473514B949;
	Thu, 29 Aug 2024 21:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968081; cv=none; b=tfdpQQM97oigNLtc6N5Y1U2sC++S9RoE0Ogin+G+WvLleZaKRHwbInCZrdQbYVfFzcgjBEk/eMmYGqlq+trp4CyKVJuyOjj85FCFnbnGopK4osroBKngmTDCGQkvwFNTpaL88eCCdBZFdh6MHCRogLvtDu/EpRfTT96J+Y+RORk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968081; c=relaxed/simple;
	bh=jdL4iPrfjVqmWKvY79bM8nTWOf36pz6vTbbIvl4E1m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mONxDSnzYpEmbcnVN3lDoqfvh2OwzXFOxLl2SdObqfB3uTFCzYcnkp7j+JfazZB86UOZwfkvK9yqKgaiAaAjOGZ9uIK/tl+heecresv9RrommS/enE347R+6qfRgezCG8G/pyTYr6qp3LdzyLC0hS6DooAeCzWY/H+Y+wjLUk00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pVNm5JVp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FE35C4CEC1;
	Thu, 29 Aug 2024 21:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724968080;
	bh=jdL4iPrfjVqmWKvY79bM8nTWOf36pz6vTbbIvl4E1m8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pVNm5JVpTe67LxlS4RsmT/JbvVpKC3E3ZDX+JhjBj9k9gHnxzVsdH2eYY9+biP1cx
	 rTp7qsLjxtltNQnJyA+RM9NK1exemSq0ZGyJkor49HGDcNwtfyEfkIKqNrAv7XBhfm
	 GyFMBnUhg2jd34Zkz4WqvVo66UO+tx7ndeCtjcZSUAnonBPE6phJuPeh/HoBzD/lpM
	 N+tuOUsWWSXjj0rQFowjnyOMqGlWKARkP9k/EkPjDY17SIi1gxxZDByEdXG30OwOvG
	 S97/DfjEaok8ZUIKWznUwxK5hwD/VOCViD5jZWygHTAB7SEDioNtdtdQFbfFF7GMVp
	 B2+UYntm8f4/w==
Date: Thu, 29 Aug 2024 14:48:00 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, josef@toxicpanda.com,
	david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <20240829214800.GQ6224@frogsfrogsfrogs>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
 <Zs3hTiXLtuwXkYgU@bfoster>
 <Zs6oY91eFfaFVrMw@infradead.org>
 <Zs8Zo3V1G3NAQEnK@bfoster>
 <ZtAKJH_NGhjxFQHa@infradead.org>
 <ZtCOVzK4KlPbcnk_@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCOVzK4KlPbcnk_@bfoster>

On Thu, Aug 29, 2024 at 11:05:59AM -0400, Brian Foster wrote:
> On Wed, Aug 28, 2024 at 10:41:56PM -0700, Christoph Hellwig wrote:
> > On Wed, Aug 28, 2024 at 08:35:47AM -0400, Brian Foster wrote:
> > > Yeah, it was buried in a separate review around potentially killing off
> > > iomap_truncate_page():
> > > 
> > > https://lore.kernel.org/linux-fsdevel/ZlxUpYvb9dlOHFR3@bfoster/
> > > 
> > > The idea is pretty simple.. use the same kind of check this patch does
> > > for doing a flush, but instead open code and isolate it to
> > > iomap_truncate_page() so we can just default to doing the buffered write
> > > instead.
> > > 
> > > Note that I don't think this replaces the need for patch 1, but it might
> > > arguably make further optimization of the flush kind of pointless
> > > because I'm not sure zero range would ever be called from somewhere that
> > > doesn't flush already.
> > > 
> > > The tradeoffs I can think of are this might introduce some false
> > > positives where an EOF folio might be dirty but a sub-folio size block
> > > backing EOF might be clean, and again that callers like truncate and
> > > write extension would need to both truncate the eof page and zero the
> > > broader post-eof range. Neither of those seem all that significant to
> > > me, but just my .02.
> > 
> > Looking at that patch and your current series I kinda like not having
> > to deal with the dirty caches in the loop, and in fact I'd also prefer
> > to not do any writeback from the low-level zero helpers if we can.
> > That is not doing your patch 1 but instead auditing the callers if
> > any of them needs them and documenting the expectation.

I looked, and was pretty sure that XFS is the only one that has that
expectation.

> I agree this seems better in some ways, but I don't like complicating or
> putting more responsibility on the callers. I think if we had a high
> level iomap function that wrapped a combination of this proposed variant
> of truncate_page() and zero_range() for general inode size changes, that
> might alleviate that concern.
> 
> Otherwise IME even if we audited and fixed all callers today, over time
> we'll just reintroduce the same sorts of errors if the low level
> mechanisms aren't made to function correctly.

Yeah.  What /are/ the criteria for needing the flush and wait?  AFAICT,
a filesystem only needs the flush if it's possible to have dirty
pagecache backed either by a hole or an unwritten extent, right?

I suppose we could amend the iomap ops so that filesystems could signal
that they allow either of those things, and then we wouldn't have to
query the mapping for filesystems that don't, right?  IOWs, one can opt
out of safety features if there's no risk of a garbage, right?

(Also: does xfs allow dirty page cache backed by a hole?  I didn't think
that was possible.)

> > But please let Dave and Darrick chime in first before investing any
> > work into this.
> > 
> > 
> 
> Based on the feedback to v2, it sounds like there's general consensus on
> the approach modulo some code factoring discussion. Unless there is
> objection, I think I'll stick with that for now for the sake of progress
> and keep this option in mind on the back burner. None of this is really
> that hard to change if we come up with something better.
> 
> Brian
> 
> 

