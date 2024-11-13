Return-Path: <linux-fsdevel+bounces-34619-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D46C19C6C9C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 11:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9960228555E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Nov 2024 10:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB761FBC9A;
	Wed, 13 Nov 2024 10:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJ6IH4cH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F7DE1FB8AD;
	Wed, 13 Nov 2024 10:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731492890; cv=none; b=rJG1l/SvNg8iWHdiHTAuwVo5nPuJipV7g4Xe6PZCWXIo7s8PkqfjYHMli9OMi9ImGkcIaCp8Ri4WrghtDpTy13MmKGofCnGuMxmu7Mam2Ic/TQ3k9Q5WpaJmqBd68J1iFJxCPKwzQfOtv5Rn/Vr1WJ0G4bF1G/E1v3aHUYnp65w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731492890; c=relaxed/simple;
	bh=cTvviGsJ5Zk+RwbF0t22eInjdnQ+6D0bd3mqCVudOrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XnJB96jfkCxxAEaAhqrxFFt6AnojQ0MXuuMuAJkwUkAo3RAO5o+rDqJAIehowIbLwKJfrkWLeZVeq+Hb5c7rKHh7hZG9PzHOW+3DzXVW1Sz2OyH0T87dR0Y6ocQYM8fesklQwXaJQyftXcOwK9EKyScX9u/CzGz/cUjJoYE9wRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJ6IH4cH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503F1C4CECD;
	Wed, 13 Nov 2024 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731492889;
	bh=cTvviGsJ5Zk+RwbF0t22eInjdnQ+6D0bd3mqCVudOrU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kJ6IH4cH3EXenBS0xxRERG9dRGYdwkrqnMOYdbVAbOEY0eS+UnGGO/8A1BSU08w10
	 qBgHgJ5hAPuiuayV74hQp1w2phzL9LYnKQS0ttFvexKEKKwwilRgQWQA3jO5o1iUWK
	 MXhsRBWqrGYwZsyQpzUE1gAPdOc3C1CzCfTV07FX1Jfk3m+gTlxF18AGykIqGLMXS9
	 1TaqZFsBZYjUGUa164upV1C00GP2sQeyA0z16D4HMEjVJhKsznA+p8/WCVH6BIREda
	 vgRASk6RUYySFSIIih653tghbiypDmiLFCOqY3xmozI43a2TTJTledU8E6aGZlPipH
	 iC6Wvj1WTLqng==
Date: Wed, 13 Nov 2024 11:14:44 +0100
From: Christian Brauner <brauner@kernel.org>
To: Hugh Dickins <hughd@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Christoph Hellwig <hch@lst.de>, David Howells <dhowells@redhat.com>, 
	Matthew Wilcox <willy@infradead.org>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] iov_iter: fix copy_page_from_iter_atomic() for highmem
Message-ID: <20241113-zutun-fortgehen-fa386e78e731@brauner>
References: <20241112-geregelt-hirte-ab810337e3c0@brauner>
 <d2ede383-3f4e-fbe5-efff-dc5f63cead4c@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d2ede383-3f4e-fbe5-efff-dc5f63cead4c@google.com>

On Tue, Nov 12, 2024 at 08:51:04AM -0800, Hugh Dickins wrote:
> On Tue, 12 Nov 2024, Christian Brauner wrote:
> 
> > When fixing copy_page_from_iter_atomic() in c749d9b7ebbc ("iov_iter: fix
> > copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP") the check for
> > PageHighMem() got moved out of the loop. If copy_page_from_iter_atomic()
> > crosses page boundaries it will use a stale PageHighMem() check for an
> > earlier page.
> > 
> > Fixes: 908a1ad89466 ("iov_iter: Handle compound highmem pages in copy_page_from_iter_atomic()")
> > Fixes: c749d9b7ebbc ("iov_iter: fix copy_page_from_iter_atomic() if KMAP_LOCAL_FORCE_MAP")
> > Cc: stable@vger.kernel.org
> > Reviewed-by: David Howells <dhowells@redhat.com>
> > Signed-off-by: Christian Brauner <brauner@kernel.org>
> > ---
> > Hey Linus,
> > 
> > I think the original fix was buggy but then again my knowledge of
> > highmem isn't particularly detailed. Compile tested only. If correct, I
> > would ask you to please apply it directly.
> 
> I haven't seen whatever discussion led up to this.  I don't believe
> my commit was buggy (setting uses_kmap once at the top was intentional);
> but I haven't looked at the other Fixee, and I've no objection if you all
> prefer to add this on.
> 
> I imagine you're worried by the idea of a folio getting passed in, and
> its first struct page is in a lowmem pageblock, but the folio somehow
> spans pageblocks so that a later struct page is in a highmem pageblock.
> 
> That does not happen - except perhaps in the case of a hugetlb gigantic
> folio, cobbled together from separate pageblocks.  But the code here,
> before my change and after it and after this mod, does not allow for
> that case anyway - the "page += offset / PAGE_SIZE" is assuming that
> struct pages are contiguous.  If there is a worry here (I assumed not),
> I think it would be that.

Thank you for the detailed reply that really cleared a lot of things up
for me. I was very confused at first by the change and that's why I
thought to just send a patch and see whether I can get a good
explanation. :)

