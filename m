Return-Path: <linux-fsdevel+bounces-21938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE77390F7B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 22:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498871F23E2C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 20:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0676615A49F;
	Wed, 19 Jun 2024 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cgp8C30k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6052282EA;
	Wed, 19 Jun 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718829938; cv=none; b=KKqTfgzUUMOrxJnVjqP7SrXTWwpO9ZcEdn4QHjeg3vCXbCko//IIa6YnjQQ0E3AItpA5b/WOi7wmzCRA/H8pQGpaOiSbqiDOlok48lvtMp+6Dz2s2ybH6Z0lqKsi/CI6k49YmCGwdrdzqV8hmllFaPxYrDVc/Kyv5dktQb+7IV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718829938; c=relaxed/simple;
	bh=TS23xKUKQqMPdlikefFBlyBu6PXWq69uofk7oIjoLxs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jlu+j3LQYlzhmrttGKh8MUNXz4iVqXFq/NUI905XFyIoHr8HnEaG7Z4Ih+OE5NarmBezO+w85vzmWe2GKuGYmg5u7jo1flG923gYVfcQH5DnmpOlSqytRUS4zP+Nc+SN2VF0nR5FE8AVvHfkJX0T//ljme7kLiYSmuQSdWjGcB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cgp8C30k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zdrw1HXcfRzkXantfTS7wHoQ7r0VLrtgD6MifONxoRI=; b=Cgp8C30k4Feko+f/+cUjJ28F4J
	4OSg9BKZN0qZwOZbcnn+rYg689R120F16ETYmztNVIAwaYwC4IEfbnrFWSnVzwHPvgDvdjjNyGWj/
	N0D7uaSPTDD+Sc9AU8J+ulX3K6aA9KTi0U1sMM9Air2mx7VXe9UN1GJT98UyhVTGfb5p+2EQEGD6Q
	NjMMJFIwGw2O2BKTdRMG2/za8Y7Q1yDs7r4v0X2bzAV9TX5Ey+nRjGxKNvMp2Xco/sLYhDzq8++hi
	GG7yBEQu6DBIbOlbsIx3lHn//HFunckkmN9W/Y3R0H4lJLSOjsiTwVJe1oM5isAa9DJMscWHkW/Ug
	Db52pD+g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sK2BR-00000005AQh-0gK8;
	Wed, 19 Jun 2024 20:45:33 +0000
Date: Wed, 19 Jun 2024 21:45:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FYI: path walking optimizations pending for 6.11
Message-ID: <ZnNDbe8GZJ1gNuzk@casper.infradead.org>
References: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whHvMbfL2ov1MRbT9QfebO2d6-xXi1ynznCCi-k_m6Q0w@mail.gmail.com>

On Wed, Jun 19, 2024 at 01:25:02PM -0700, Linus Torvalds wrote:
> For example, making d_hash() avoid indirection just means that now
> pretty much _all_ the cost of __d_lookup_rcu() is in the cache misses
> on the hash table itself. Which was always the bulk of it. And on my
> arm64 machine, it turns out that the best optimization for the load I
> tested would be to make that hash table smaller to actually be a bit
> denser in the cache, But that's such a load-dependent optimization
> that I'm not doing this.
> 
> Tuning the hash table size or data structure cacheline layouts might
> be worthwhile - and likely a bigger deal - but is _not_ what these
> patches are about.

Funnily, I'm working on rosebush v2 today.  It's in no shape to send out
(it's failing ~all of its selftests) but *should* greatly improve the
cache friendliness of the hash table.  And it's being written with the
dcache as its first customer.

