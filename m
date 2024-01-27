Return-Path: <linux-fsdevel+bounces-9218-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A10DA83EF5D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 19:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3767FB21D49
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 18:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA2872D61B;
	Sat, 27 Jan 2024 18:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YsgnMGxW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0992D043
	for <linux-fsdevel@vger.kernel.org>; Sat, 27 Jan 2024 18:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706378808; cv=none; b=lPl1/G0kPKDE/s0m72ufQZ5DeMcr/VIvmnFaNYxU+yZ623TsK5vkmWRPJBNd0kcAiA2TRYaACQxYUz4lunbnLA0EUCZKKzhaDJ+LyfPS/ZsJ+0rS+ZXNMvIuszUuNWLqJmqrOt7Ui3D5Qo2jwH1rag3kPiTuGdBqkJmMDbClEb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706378808; c=relaxed/simple;
	bh=rAzSwyPzByr0gvE5lmx+LKK+vSpI7Pj7bQaPQhMMKZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uE2XVuGlztSH1pZIEyUEpf9HLR75U70WzdYSvLl9jV4y2o0KQEIelOLk9ckeWANF3O0BjOm3oXGw/fn+BxSnC4ByQtVt2CJfCGFrSzc/sRJkP8hwfje4i9WqJCpuVHlhAaGAf63TdrOu5QxYobRHNh9VslzoK6s77QLhzyeYfS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YsgnMGxW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YrRyKQKMOdyRil31O+f58cq56VSF58YjdceSVVv9JJ8=; b=YsgnMGxWb1w/1jTC9/BogT+wNz
	lzBof+rBzIFt9XPfZBbAPjoFCn4T5QnluZy9ePTc8rOllAOHhzyruwTx4H8QdUK894JdTo+3yyFpb
	OuJdCrcuowiZYzSPH+vIZgPQlst7Mdqsmn9eqylsxxToiH0SuJHGFYt8d2NzVHb2Y6PI7t5HBB+cj
	Pa+/FEFH9MXIm9quItMvSFAilpmmjUFgyoCo8UCPtyhzNfZzB8uwsxGjlp5DO8qGO/2+ytPCKCY0d
	Lilk1BLy+YY1YZEZ3e0Prdb51QcZJFrOmNso+44ZObwadHJ6efBt9yJ8V9xcoi9tnach6MegiZ/un
	OxeIBYbg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTn4f-0000000HZrk-1Q7z;
	Sat, 27 Jan 2024 18:06:37 +0000
Date: Sat, 27 Jan 2024 18:06:37 +0000
From: Matthew Wilcox <willy@infradead.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [LSF/MM TOPIC] Making pseudo file systems inodes/dentries more
 like normal file systems
Message-ID: <ZbVGLXu4DuomEvJH@casper.infradead.org>
References: <2024012522-shorten-deviator-9f45@gregkh>
 <20240125205055.2752ac1c@rorschach.local.home>
 <2024012528-caviar-gumming-a14b@gregkh>
 <20240125214007.67d45fcf@rorschach.local.home>
 <2024012634-rotten-conjoined-0a98@gregkh>
 <20240126101553.7c22b054@gandalf.local.home>
 <2024012600-dose-happiest-f57d@gregkh>
 <20240126114451.17be7e15@gandalf.local.home>
 <CAOQ4uxjRxp4eGJtuvV90J4CWdEftusiQDPb5rFoBC-Ri7Nr8BA@mail.gmail.com>
 <d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d661e4a68a799d8ae85f0eab67b1074bfde6a87b.camel@HansenPartnership.com>

On Sat, Jan 27, 2024 at 09:59:10AM -0500, James Bottomley wrote:
> On Sat, 2024-01-27 at 12:15 +0200, Amir Goldstein wrote:
> > I would like to attend the talk about what happened since we
> > suggested that you use kernfs in LSFMM 2022 and what has happened
> > since. I am being serious, I am not being sarcastic and I am not
> > claiming that you did anything wrong :)
> 
> Actually, could we do the reverse and use this session to investigate
> what's wrong with the VFS for new coders?  I had a somewhat similar
> experience when I did shiftfs way back in 2017.  There's a huge amount
> of VFS knowledge you simply can't pick up reading the VFS API.  The way
> I did it was to look at existing filesystems (for me overlayfs was the
> closes to my use case) as well (and of course configfs which proved to
> be too narrow for the use case).  I'd say it took a good six months
> before I understood the subtleties enough to propose a new filesystem
> and be capable of answering technical questions about it.  And
> remember, like Steve, I'm a fairly competent kernel programmer.  Six
> months plus of code reading is an enormous barrier to place in front of
> anyone wanting to do a simple filesystem, and it would be way bigger if
> that person were new(ish) to Linux.

I'd suggest that eventfs and shiftfs are not "simple filesystems".
They're synthetic filesystems that want to do very different things
from block filesystems and network filesystems.  We have a lot of
infrastructure in place to help authors of, say, bcachefs, but not a lot
of infrastructure for synthetic filesystems (procfs, overlayfs, sysfs,
debugfs, etc).

I don't feel like I have a lot to offer in this area; it's not a
part of the VFS I'm comfortable with.  I don't really understand the
dentry/vfsmount/... interactions.  I'm more focused on the fs/mm/block
interactions.  I would probably also struggle to write a synthetic
filesystem, while I could knock up something that's a clone of ext2 in
a matter of weeks.

