Return-Path: <linux-fsdevel+bounces-10688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755484D60D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 23:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3DA1F24E7A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 22:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784791D557;
	Wed,  7 Feb 2024 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wK1fjlEZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EF211CAF
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Feb 2024 22:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707346535; cv=none; b=svCOD2bZB7AzrutBl9UGFl2EhzMeo3dUC7QRTYN1X1jfldHuhdR6x8dAzypY9UeCiNH+u2m8YlGA0nyWK0MYGXgTdlDFfQIzyP1Ei/n2rjNRiS9ut0RmjRuQUFVmbS/lBi/NxXAAkQpcnyPo25klb+jjW7lfLc2pixJQ8+b1/3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707346535; c=relaxed/simple;
	bh=hQAgp0mGwwzaEbypQnIV2r+QBzY3mAXPykl8Hg1SWBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QjlExDk9QrqnZ8B+UGZSSWfDMvkbQqbx7udPBdIy2todMXUCifUdg0KAJlDItDR0eit1NEWwPiHD2K9jRtvk9v7QOH7NyzzdLzw6IuKQwRa69v3ffEIjmZWYnBH+/vpcN4CLz1maw4qi/OXUVTLYZt5RhcrDzyB4oQHR6p4o014=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=wK1fjlEZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pOrdeZFS2YKYdj84MGRJ+affSNfK3Z1PVnoSusmAKQU=; b=wK1fjlEZ/5C4x1L4z3s45PEwm0
	eLHUrugl74WFL9FRCl4cBxW9Sc+IgNaYV3rdhmApcZkxhHSs1iBHaHEtnRxvxTxW/lFhla0jCl/f9
	6iSdkPcOFd24OyXPtc5BRZR4RZ/rQhRo5kwcAqVdwYu4FuTo1osh9nnfR0iaqIiP0/vHj6yd4Fno0
	F66E616OPbXkAnr6E83R5+jwOxyGmKEqF5az9Kk199vRlHdQcWK0gbPPzrLb96QvrqmtzjqB8oTh8
	wX0BWYmnNrAeJCZa8dJj5HyQCpowW1IPZHUYL5YWvUiqyxtjHNtbqB5DUJcyHsVLXEHOrTV5VGXY0
	Y2TkC+oA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqpH-0000000GIqc-1OB5;
	Wed, 07 Feb 2024 22:55:31 +0000
Date: Wed, 7 Feb 2024 22:55:31 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [RFC] ->d_name accesses
Message-ID: <ZcQKYydYzCT04AyT@casper.infradead.org>
References: <20240207222248.GB608142@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240207222248.GB608142@ZenIV>

On Wed, Feb 07, 2024 at 10:22:48PM +0000, Al Viro wrote:
> 	One way to do that would be to replace d_name with
> 	union {
> 		const struct qstr d_name;
> 		struct qstr __d_name;
> 	};
> and let the the places that want to modify it use __d_name.
> Tempting, but the thing that makes me rather nervous about this
> approach is that such games with unions are straying into
> the nasal demon country (C99 6.7.3[5]), inviting the optimizers
> to play.  Matt Wilcox pointed out that mainline already has
> i_nlink/__i_nlink pair, but...  there are fewer users of those
> and the damage from miscompiles would be less sensitive.
> Patch along those lines would be pretty simple, though.

You're referring to this, I assume:

	If an attempt is made to modify an object defined with
	a const-qualified type through use of an lvalue with
	non-const-qualified type, the behavior is undefined

I'm not sure that's relevant.  As I see it, we're defining two objects,
one const-qualified and one not.  The union specifies that they share
the same storage ("a union is a type consisting of a sequence of members
whose storage overlap").

I see 6.7.3 as saying "even if you cast away the const from d_name,
modifyig d_name is undefined", but you're not modifying d_name,
you're modifying __d_name, which just happens to share storage with
d_name.

I think 6.7.2.1[14] is more likely to cause us problems:

	The value of at most one of the members can be stored in a union
	object at any time.

From that the compiler can assume that if it sees a store to __d_name
that accesses to d_name are undefined?  Perhaps?  My brain always starts
to hurt when people start spec-lawyering.

> * add an inlined helper,
> static inline const struct qstr *d_name(const struct dentry *d)
> {
> 	return &d->d_name;
> }

I'm in no way opposed to this solution.  I just thought that the i_nlink
solution might also work for you (and if the compiler people say the
i_nlink solution is actually not spec compliant, then I guess we can
adopt an i_nlink_read() function).

