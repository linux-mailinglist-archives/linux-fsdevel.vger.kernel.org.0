Return-Path: <linux-fsdevel+bounces-22155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95EB8912E40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 22:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7181C23F02
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Jun 2024 20:04:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5280716D306;
	Fri, 21 Jun 2024 20:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EXbXWieb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3EC15F30F;
	Fri, 21 Jun 2024 20:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719000291; cv=none; b=IVZZ8if4KBxdXxahDT5wkphmOeOtjXLIrc4Z4ICFiqgEvyMgiKe/ejIt0WyWicxMkXJyeCDH2lSFt7SFxQBfbUlJLN52WyA0Z226xendjSE4CyfeWWnERQ1ih1W90KVBRckoTKOMs0VOuEQkqUO7EZ0qoaP3pAinaSMyfN38lMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719000291; c=relaxed/simple;
	bh=YQ5qopKr9R81wRXRZpyOHU2UirBbeQkBZPcGEJcWJ8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B+Ds3zZxpo78oB9t0z5V7hiUBUYouqOHx685yEcWpzLQfW2vzvPzkpoFWqG7xf35hjjB7oKww/SaOasPb1rbQ5NiKz7HEgMf+3YoosFzCtX7cW0oCEYpu1ptLkwltNnpOsuungOyZOygtGWhOya7c7Hyl9IROT9we1LIUf+zbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EXbXWieb; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9COVBQENN0t3oGjClhlT9+/MO8u8oPrewnmAyx93pxI=; b=EXbXWiebsLfQVAfNCjLRWINX3O
	JXRxNKIp4lmfbWDk/OSFsTBof/FtYtHfQa7zSviQpB87qV3QjeCIA9sE7OinSQqpt++adXU0UIyFZ
	Rixiz2nA1xrTetQj/BJ8KCb8CKZUBs+FH6Bjn38geW4tJTKTzs7t2vT8MMy4QwjPlJ73Z0Ve1oNST
	WYDHId1KOfYZliP5GpvUL5ZztIoiYneacSfmwm0H16uqT8KxG5eKtOWkZZDuyInxAtnfiWbbmHSjP
	CdhuAmf1glg+j96InsxMHcJT+4Gp7kZXJzblQcyq2le1M603BlRdKC7u9Cu6O4INc5x3zrfQIDXpk
	7ALMwvwA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sKkV0-00000007YT4-1sDe;
	Fri, 21 Jun 2024 20:04:42 +0000
Date: Fri, 21 Jun 2024 21:04:42 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: Re: FYI: path walking optimizations pending for 6.11
Message-ID: <ZnXc2qDZsZrCIxSQ@casper.infradead.org>
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
 <ZnNDbe8GZJ1gNuzk@casper.infradead.org>
 <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi1zgFX__roHZvpYdAdae4G9Qkc-P6nGhg93AfGPzcG2A@mail.gmail.com>

On Wed, Jun 19, 2024 at 03:08:47PM -0700, Linus Torvalds wrote:
> On Wed, 19 Jun 2024 at 13:45, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Funnily, I'm working on rosebush v2 today.  It's in no shape to send out
> > (it's failing ~all of its selftests) but *should* greatly improve the
> > cache friendliness of the hash table.  And it's being written with the
> > dcache as its first customer.
> 
> I'm interested to see if you can come up with something decent, but
> I'm not hugely optimistic.

Well, I've now come up with something _working_.  There are still things
to be fixed, but it might be interesting for a performance comparison.
So I've pushed it out to
http://git.infradead.org/?p=users/willy/pagecache.git;a=shortlog;h=refs/heads/rosebush
where I hope 01.org will pick up on it and run some performance tests.

> From what I saw, you planned on comparing with rhashtable hash chains of 10.

That was the comparison I made (and it turns out I misunderstood
rhashtable entirely; the length is where it does an emergency resize,
and usually its size is such that the average hash length is <1)

What I was reacting to in your email was this:

: And on my arm64 machine, it turns out that the best optimization for the
: load I tested would be to make that hash table smaller to actually be a
: bit denser in the cache, But that's such a load-dependent optimization
: that I'm not doing this.

And that's exactly what rosebush does; it starts out incredibly small
(512 bytes) and then resizes as the buckets overflow.  So if you suspect
that a denser hashtable would give you better performance, then maybe
it'll help.

Or maybe not; it's not like I've done thorough testing.

