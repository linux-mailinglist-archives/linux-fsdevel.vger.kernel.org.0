Return-Path: <linux-fsdevel+bounces-59112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6582B34918
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 19:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFDD5189922E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 17:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3AE9304BBD;
	Mon, 25 Aug 2025 17:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WAib8ZUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2E72FF648
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 17:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756143796; cv=none; b=aTblKhDVxV6LaoPLOjpm6vgPtQF6sQ2Kgrlm1AfPB5l6YHh+nGwqMDE+9D5Bbf12phmMywmQtT5FJ4V9oa/AZbD21mNxMRebrw9MM0XqumHWi/bRx5V0wN15V8HrIDJvmYRDvBaD+EnCVKlMxpvwnlhrh5Bkvgwb0COQji3P36c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756143796; c=relaxed/simple;
	bh=Iq43Mjm3yflG12BNUZFSDcFCHr6B9+AbC0yjeQfAU50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g6Kn4u4W+sYXym47g1s8egQTshBcbVM92P2cbiD2S8poqx7TvaOjoXG5XpsLmXTKnn8u6Th/RRyuonrce9s4i7tD5gZEDkV0EQ+UgxRo7Y5jDOg7Ch+rTJB0Z+xLM7XNmbRRcj280KFYE1zusi46LEZZPeL4VZemohJYUZeX9/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WAib8ZUd; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8Uq8vj6IRBTlX7NexXM5YTsSUuOKWtAmEDsAMmZyW24=; b=WAib8ZUdylwRvaZz7vQrtvnxvx
	FSKgXA2sVvhHs32+M0hqqxCY7K0cxk8rrT1fTkRMI0ztzZ8WYUTVLoCBZkP1oNWmyY3TtdaFuZWV7
	4eVFSpjSu9OqaeYmKAE0c0DgNB5e/0hKvl1z+ezr1Cy/SUW1ZCMa4M2JcYwi77i6u+3So/9iRDuDZ
	BZWnTzGTylP1Y2CF/ayuPKx1L8WQNmHXH6AlDDjbIhbpbN/ljW3eiHF8z1kDKfHNL45ldyjNRSpyS
	r0yf4cd4HFzVxKXhtF0hvLRNOyLnVUPVIyfYQ2ZkEmTeekEi6AOoUKfHOnNlEWD/ZpCla90ULfx1z
	1X0GmuhA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqbDs-0000000HXeu-0dHv;
	Mon, 25 Aug 2025 17:43:12 +0000
Date: Mon, 25 Aug 2025 18:43:12 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [PATCHED][RFC][CFT] mount-related stuff
Message-ID: <20250825174312.GQ39973@ZenIV>
References: <20250825044046.GI39973@ZenIV>
 <20250825-glanz-qualm-bcbae4e2c683@brauner>
 <20250825161114.GM39973@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250825161114.GM39973@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Mon, Aug 25, 2025 at 05:11:14PM +0100, Al Viro wrote:
> On Mon, Aug 25, 2025 at 02:43:43PM +0200, Christian Brauner wrote:
> > On Mon, Aug 25, 2025 at 05:40:46AM +0100, Al Viro wrote:
> > > 	Most of this pile is basically an attempt to see how well do
> > > cleanup.h-style mechanisms apply in mount handling.  That stuff lives in
> > > git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #work.mount
> > > Rebased to -rc3 (used to be a bit past -rc2, branched at mount fixes merge)
> > > Individual patches in followups.
> > > 
> > > 	Please, help with review and testing.  It seems to survive the
> > > local beating and code generation seems to be OK, but more testing
> > > would be a good thing and I would really like to see comments on that
> > > stuff.
> > 
> > Btw, I just realized that basically none of your commits have any lore
> > links in them. That kinda sucks because I very very often just look at a
> > commit and then use the link to jump to the mailing list discussion for
> > more context about a change and how it came about.
> > 
> > So pretty please can you start adding lore links to your commits when
> > applying if it's not fucking up your workflow too much?
> 
> Links to what, at the first posting?  Confused...

I mean, this _is_ what I hope would be a discussion of that stuff -
that's what request for comments stands for, after all.  How is that
supposed to work?  Going back through the queue and slapping lore links
at the same time as the reviewed-by etc. are applied?  I honestly have
no idea what practice do you have in mind - ~95% of the time I'm sitting
in nvi - it serves as IDE for me; mutt takes a large part of the rest.
Browser is something that gets used occasionally when I have to...

