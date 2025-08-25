Return-Path: <linux-fsdevel+bounces-59100-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6CFB346DC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 18:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C2A75E2D46
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 16:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63983019AA;
	Mon, 25 Aug 2025 16:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="CGCqD/QG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A95A21E091
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756138278; cv=none; b=a6kydBGFO6Cj4McMuZZAq+WbEtVeCBnOmt10TU9wqYPTx2jnYSaM/Iok3pstnm3thgqmxbfTxMCK1+VSspDnoK8mVXDoavH2CpThLiM7kdQ+4pVb236S6AmYNb7iRckEXRyTSmcmP+PagHok7PRvfuUHRFcyNqiNeTXOirJo3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756138278; c=relaxed/simple;
	bh=mOUANxq0FL/kO8/y2mUUFmIGMYjQNkYZpFC/rZgoapY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hD/QxAKqWseRo3GGfK8W0bE06dNtuouqzki1LIboWnoXkE6KuH4Q0YkINHLCmdbcvGkKeWQTXoqMnccLUh9me7bc6xdvYGp2qhEUXE+JwfXjbmaK8Gk2jqA66QgaPwPlRqs4zh6+YnXusYzqW8XFMaQWbYpngY/rQwem2sf06Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=CGCqD/QG; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dNUziqvRHknZyYEmeMOJJjowHPP4bSBzceBfhYYgnQc=; b=CGCqD/QG5LCYbcx6xfcMSojIk+
	aW7WhUtH7U55doW7UZk+aIzOTjpji80rowYWu/iOcLyGRVkBSG8M4g41pRJl49Jw953nkLDonuB8j
	+a1SO98QCJhJPRBDJD4LGYuS7HdXc0CYxj8BNtjjtVaNpTywVjxr1eX8roxJ/7kZLwtvo63yxt8nj
	B5bykVZP5v7kEsPVEgv6r1YuurJDau75vC3F/Rj9RRaf75IxNUM33ZIY+hicIzvpjcCBiRLMN+zdn
	A6bqFT8oan6CjHw142buh82aLXOGlXK3+5CWoozReuJErxflwqAIX8NiwqxC0oZMNYpy2Na3iZ7XR
	4M10nPFQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqZms-0000000GB3S-2QHi;
	Mon, 25 Aug 2025 16:11:14 +0000
Date: Mon, 25 Aug 2025 17:11:14 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250825161114.GM39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825-glanz-qualm-bcbae4e2c683@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825-glanz-qualm-bcbae4e2c683@brauner>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 02:43:43PM +0200, Christian Brauner wrote:
> On Mon, Aug 25, 2025 at 05:40:46AM +0100, Al Viro wrote:
> > 	Most of this pile is basically an attempt to see how well do
> > cleanup.h-style mechanisms apply in mount handling.  That stuff lives in
> > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> > Rebased to -rc3 (used to be a bit past -rc2, branched at mount fixes merge)
> > Individual patches in followups.
> > 
> > 	Please, help with review and testing.  It seems to survive the
> > local beating and code generation seems to be OK, but more testing
> > would be a good thing and I would really like to see comments on that
> > stuff.
> 
> Btw, I just realized that basically none of your commits have any lore
> links in them. That kinda sucks because I very very often just look at a
> commit and then use the link to jump to the mailing list discussion for
> more context about a change and how it came about.
> 
> So pretty please can you start adding lore links to your commits when
> applying if it's not fucking up your workflow too much?

Links to what, at the first posting?  Confused...

