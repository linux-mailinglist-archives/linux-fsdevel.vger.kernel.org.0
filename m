Return-Path: <linux-fsdevel+bounces-45727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 953F9A7B7FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 08:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E8A53B7E67
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 06:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EFC186295;
	Fri,  4 Apr 2025 06:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="nC/0zeiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2BF13CA9C
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 06:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743749424; cv=none; b=nU49JQ0q6pUSkAci+Z6aQfy28i6XkxLLg/PvIga/JARbyYWoDOAAdALnlQU6CjQxiyUULH12l7IEGIMscuK+9tH6YJhFhrQDIhkl7dgVbx1bHKAW73MN8fPUuCY4W3niQXrzVgBMMsHH9n3Jg9wizoqRFGrHLLmiVv5tPownMc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743749424; c=relaxed/simple;
	bh=N/19r93zuptDoO+6OyWDOPVOUfeAr+MHAk9YQ6dXOQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpldeWj5YGcIfl1XG3qBsksM1HcArswlkJ4XpRXGQGRTk5tZ6wFNsg9Gb0eFtk70793t77pXxI3MbrnitnIGJ6W3oFOfv5EOoFGb4YGic7T+ocHKbKhzMyeshEwRk/EuU76ldvh2zc6qAmt687AoQR0+Ex8WFmeylluxIg110HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=nC/0zeiP; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UEaARN/T4VUCYsqb0Go9I0Z+DeW2I8LQreNqa0BMKRY=; b=nC/0zeiPhygZL7Ab3eGscV2Mwb
	wssPyc61PXoisZ+n2eoKZ2x+yx9p+lLoOi163/4b1QhZL0AkTl3H5+3uHmUNPPSeanhuSGBrzwb7r
	3Q+ivTr6pMk3tH3SagfDAFT1vwkiQtdcyg7offznYdYESySZgp50qCwAvr9iqlNRu+dHtpf5XaGrX
	t8X/hYnTCD5n4l0hI1/Ik6utKlFAfWHVX9QKd9aXM5krMKfYGlwZfAQ3FroIz2cdrXHj2IGg+udWP
	9c8kgLmfwg9KrI/R5SXv0My1ciEDDMDb7YMss7AW9CMdOm1oxxcUjnuo+ht8pQbfsJde4526ULmCy
	oJLBSZtQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0asd-00000002Pz0-16aW;
	Fri, 04 Apr 2025 06:50:19 +0000
Date: Fri, 4 Apr 2025 07:50:19 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [GIT PULL] fixes for bugs caught as part of tree-in-dcache work
Message-ID: <20250404065019.GO2023217@ZenIV>
References: <20250404030627.GN2023217@ZenIV>
 <CAHk-=wjEsEnLC-PXfTHXtKQMjxZGi8VoJa3H0s39CoCTMmpz3g@mail.gmail.com>
 <CAHk-=wgYm1VZgB4v=_cjQ3wBeB9SYck0iGuK8GzSMjxi4isJ9Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYm1VZgB4v=_cjQ3wBeB9SYck0iGuK8GzSMjxi4isJ9Q@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Apr 03, 2025 at 09:13:43PM -0700, Linus Torvalds wrote:
> On Thu, 3 Apr 2025 at 21:12, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > On Thu, 3 Apr 2025 at 20:06, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > >
> > >   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
> >
> > Uhhuh - can you humor me and make it a signed tag?
> 
> Oh, never mind. I see the tag.
> 
> It's just called "pull-fixes" rather than just "fixes".

Hmm...  I wonder if it would make sense to add a flag to git-pull-request
that would verify that object in question is a tag - we already have
a chunk that extracts the tag contents when the 3rd argument happens
to be a tag...

