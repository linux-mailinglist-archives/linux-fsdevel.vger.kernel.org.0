Return-Path: <linux-fsdevel+bounces-25391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D0D94B59D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 05:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B646B23700
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2024 03:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BFF83A17;
	Thu,  8 Aug 2024 03:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="WUA7L4p9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FB176F31E
	for <linux-fsdevel@vger.kernel.org>; Thu,  8 Aug 2024 03:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723088768; cv=none; b=M1laacCJrUgeirHwm9oSFAmPbI5cGRM9L11aLhnREtr0pcu9nSsJ0WAgJeqGdgOuL7YUs9u7jncdsPuj7EQjzeK5XF6NiNMgX86d2WC/ETyEfYsIVYneVb2JsZ6jVavhK/oQZstfG5uNJBzKBcgVmLh82pOzXBQIug+DruQZWg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723088768; c=relaxed/simple;
	bh=LqoiOWPj1xEzobcLIxeL0eUb/HrLj3HRbNtGB9iqv8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ty+SGDmtrrcKV0Wybn5xmPMU9rWV0ByAKwbQKeVb/caqWvsQMuVozNITxf9L6i3UUWRy8uIasqK+jfkKKtHRQRdhaDhl7AGSAwYaaZ7agYTkEgQu4ZTQujv1LinoOI53rj9lZkHXVKpa4sRH39B4ixO+mpIJEgvxuz+zG3/Cusw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=WUA7L4p9; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cdxZKuTwj1uWMuPwzg0uGBp8/VGNsA4zXguS82/fi0I=; b=WUA7L4p9kqoIyHn1M5avDfoVbH
	MZhvTmVJPUrZrvAhRVS1kE/rc0AGGS8DbcT8rrq3/++qm9dJf/1fx7oJuNBekkm1n6oXpb0c3O9k1
	W82dvxzGzQwhSuXgjC+0ZZuaM0bxwTO0IdO+whkPUubpbsr2HUfNyDscerOauYqRs1gyvvbHzD3Rp
	2G2EmWf5o7mblYpQUK4jVcBvn5qPEVoh4KodlpGKoH3gytf0Vy6QvHCle+OwB2bRTOeooIJRGVPKm
	u68XmmhlmFZp/Lua8A0GJ9emeEDy7Vd/5UMF+Orr7rsQEF6vAAzCYbJWLc7i2ruf+vSJUUWzccQYd
	z9inuN1A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sbu6C-00000002ZiP-41FK;
	Thu, 08 Aug 2024 03:46:00 +0000
Date: Thu, 8 Aug 2024 04:46:00 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mjguzik@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: [RFC] why do we need smp_rmb/smp_wmb pair in
 fd_install()/expand_fdtable()?
Message-ID: <20240808034600.GD5334@ZenIV>
References: <20240808025029.GB5334@ZenIV>
 <CAHk-=wgse0ui5sJgNGSvqvYw_BDTcObqdqcwN1BxgCqKBiiGzQ@mail.gmail.com>
 <20240808033505.GC5334@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240808033505.GC5334@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Aug 08, 2024 at 04:35:05AM +0100, Al Viro wrote:
> On Wed, Aug 07, 2024 at 08:06:31PM -0700, Linus Torvalds wrote:

> > But release/acquire is the RightThing(tm), and the fact that alpha
> > based its ordering on the bad old model is not really our problem.
> 
> alpha would have fuckloads of full barriers simply from all those READ_ONCE()
> in rcu reads...
> 
> smp_rmb() is on the side that is much hotter - fd_install() vs. up to what, 25 calls
> of expand_fdtable() per files_struct instance history in the worst possible case?
> With rather big memcpy() done by those calls, at that...

BTW, an alternative would be to have LSB of ->fdt (or ->fd, if we try to
eliminate that extra dereference) for ->resize_in_progress.  Then no barrier
is needed for ordering of those.  Would cost an extra &~1 on ->fdt fetches,
though...

