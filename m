Return-Path: <linux-fsdevel+bounces-20008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4928CC567
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 19:14:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF4181C220C3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 May 2024 17:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86CEE1422C1;
	Wed, 22 May 2024 17:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VBh336lN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563D1762FF;
	Wed, 22 May 2024 17:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716398046; cv=none; b=jtP/uYM0b6f/Le1yLNyWb4OT9x9ZRxxgl4pksG5SldqkxUeY1/AgqmcLbMu/TbuAtyiQbM6LbdHCmCPYXqJoW06Spp3Yl4Px0NEuASAIV6UDiYyii7UvTq+5J9rL5ksK7KYd4rBq/iE/WILgWt8DLOBBpezEWNWlUuzp26KMkTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716398046; c=relaxed/simple;
	bh=mbmrUgoWc/irdBq3b+5a3FMGIAtSnhpi9AUa/pCz9n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oUOMtXyi48Gc0HnOn/QFZlor6CYGfN1UZ2xcqKezycv6hmQJnuHeAH+GbFvNfcE4CXZ4Yaa2TlIMDDoVpLKE5JFAzVg7zfPYcBlEWzRFkmyqOOV0Ae7UnoIRTIEfFiWLqJ1IZpcIO7RMLLf2VD8Am77TG8AE2WWfiLTwKiiWt+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VBh336lN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=tTs5GqkH792WkQ5uou1WjI1GQqIun7xt5FNmVzrUoKY=; b=VBh336lNsDVUCmD5sKjJynTTOh
	g791d7gHmi1Fk0v2aqXU+C+DyODxr3tIORHuNoGSbhfb2slTVoVTl2uFIPrn37YqWi26hN0KsDqw5
	2KhmSp9dzPE6HM0kh+R41fRhe5dpes8HAKZWjx6tw8sHax/GhqN7JpQ52k1wurVhMys2G3lgtaNAP
	SdQxtE6X4eDiXexmnCf0GIyqNKg4hDO5hJdvkRGrRYfTlf/EUctSuaRAb2URt58u+IE9aoCOh50Mv
	fkyNht8QFQCvA/o06TuCmu/IQoWdWf0GJCCuAZJoCUtsKKsXpe8raiRvAJevNdylYnxyZTPPRp2k+
	Ui/x+jiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s9pXJ-00000000rO0-2wvS;
	Wed, 22 May 2024 17:13:57 +0000
Date: Wed, 22 May 2024 18:13:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: kernel test robot <oliver.sang@intel.com>,
	Yafang Shao <laoar.shao@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Waiman Long <longman@redhat.com>, Wangkai <wangkai86@huawei.com>,
	Colin Walters <walters@verbum.org>, linux-fsdevel@vger.kernel.org,
	ying.huang@intel.com, feng.tang@intel.com, fengwei.yin@intel.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vfs: Delete the associated dentry when deleting a file
Message-ID: <Zk4n1eXLXkbKWFs2@casper.infradead.org>
References: <20240515091727.22034-1-laoar.shao@gmail.com>
 <202405221518.ecea2810-oliver.sang@intel.com>
 <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wg2jGRLWhT1-Od3A74Cr4cSM9H+UhOD46b3_-mAfyf1gw@mail.gmail.com>

On Wed, May 22, 2024 at 09:00:03AM -0700, Linus Torvalds wrote:
> Of course, if you do billions of lookups of different files that do
> not exist in the same directory, I suspect you just have yourself to
> blame, so the "lots of negative lookups" load doesn't sound
> particularly realistic.

Oh no.  We have real customers that this hits and it's not even stupid.

Every time an "event" happens, they look up something like a hash in three
different directories (like $PATH or multiple -I flags to the compiler).
Order is important, so they can't just look it up in the directory that
it's most likely to exist in.  It usually fails to exist in directory A
and B, so we create dentries that say it doesn't.  And those dentries are
literally never referenced again.  Then directory C has the file they're
looking for (or it doesn't and it gets created because the process has
write access to C and not A or B).

plan9 handles this so much better because it has that union-mount stuff
instead of search paths.  So it creates one dentry that tells it which of
those directories it actually exists in.  But we're stuck with unix-style
search paths, so life is pain.

