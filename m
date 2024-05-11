Return-Path: <linux-fsdevel+bounces-19336-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 033AF8C33C4
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 22:32:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2BDF28201D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 May 2024 20:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1DBB224DE;
	Sat, 11 May 2024 20:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="S/OdTq1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A4C2261D
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 May 2024 20:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715459514; cv=none; b=C2swrbI17xUoInFNBoXc0hMjxzwQO/9SUEHHNPgPj71puyqGYiOpMve7pN0sGmcbS4Js6iwi/X5nW/zVKZXugYjnQ0lb41ctLQApGdCo3nLAMomUtTf0I9z8kzyQ4WbBSlQHrsNZezQaiU7cyrMY3XjrrDeFCotLKDlhfyWCGMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715459514; c=relaxed/simple;
	bh=EoP640UcQQPaVzp37JGi3au4stKAWj4mPx/DUFJB7FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSulv2hlJhFARutqszDgn/XIIP4BVWrRE6OYaf49ChHWgnQvjuhcNgz3txoNbHSzufaQPDRtVcKvC8BnQYFn0p7UdPLDvSNXuzaVOob/h1l6ZuKfXBEU/GYHSIPAQi2yBoQ2mttlZ87oV/m5JvVJUivcucREt2A1t1o9n4wJiFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=S/OdTq1Y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=qARV5L/IyfEOoLDSAgR6DUSBoq9emjGw1vLCVrEm7Nw=; b=S/OdTq1Ye52ZWYJYZXGKMRe+lq
	03r6FKB/VkuDSWJOrwYXRiIdf8jpq2lR6OSQKrByhLzCpvBHyS3ciHphwjYfvaq+jdCxgenpTEHLL
	DJk4wJha0JXY68sYBaeybW64HCSFRzBG4cQ/zBeRrubyB0jnfXG/4A12NRgwcFLRj0jE8gWEWGwS2
	PlQk9aHHEofKjK7b4GehKD5VKxNqzrkpUPBZAdSI/kRB7R3Ml74k+49itZRaEKny2pF7Odz4tczd6
	DkN8LemYB7wJolgzrLMCnjXDFfTSPwDQtsV1CObLHVkzDskInx/cIgEaleocMC8xfLp58ipz3OjfF
	jy8Nxsgw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
	id 1s5tNf-003qoy-1u;
	Sat, 11 May 2024 20:31:43 +0000
Date: Sat, 11 May 2024 21:31:43 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: brauner@kernel.org, jack@suse.cz, laoar.shao@gmail.com,
	linux-fsdevel@vger.kernel.org, longman@redhat.com,
	walters@verbum.org, wangkai86@huawei.com, willy@infradead.org
Subject: Re: [PATCH] vfs: move dentry shrinking outside the inode lock in
 'rmdir()'
Message-ID: <20240511203143.GD2118490@ZenIV>
References: <CAHk-=whvo+r-VZH7Myr9fid=zspMo2-0BUJw5S=VTm72iEXXvQ@mail.gmail.com>
 <20240511182625.6717-2-torvalds@linux-foundation.org>
 <CAHk-=wijTRY-72qm02kZAT_Ttua0Qwvfms5m5NbR4EWbS02NqA@mail.gmail.com>
 <20240511192824.GC2118490@ZenIV>
 <CAHk-=wi7BtsC7wvTqnYOtAiWzM2Q5tK=TG=V=7D6SKfbzhoCKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi7BtsC7wvTqnYOtAiWzM2Q5tK=TG=V=7D6SKfbzhoCKw@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Sat, May 11, 2024 at 12:55:29PM -0700, Linus Torvalds wrote:
> On Sat, 11 May 2024 at 12:28, Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Sat, May 11, 2024 at 11:42:34AM -0700, Linus Torvalds wrote:
> > >
> > > And that outside lock is the much more important one, I bet.
> >
> > ... and _that_ is where taking d_delete outside of the lock might
> > take an unpleasant analysis of a lot of code.
> 
> Hmm. It really shouldn't matter. There can only be negative children
> of the now deleted directory, so there are no actual effects on
> inodes.
> 
> It only affects the d_child list, which is protected by d_lock (and
> can be modified outside of the inode lock anyway due to memory
> pressure).
> 
> What am I missing?

fsnotify and related fun, basically.  I'll need to redo the analysis,
but IIRC there had been places where correctness had been guaranteed
by the fact that this had been serialized by the lock on parent.

No idea how easy would it be to adapt to that change; I'll check,
but it'll take a few days, I'm afraid.

