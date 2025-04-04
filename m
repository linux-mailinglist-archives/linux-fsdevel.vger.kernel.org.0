Return-Path: <linux-fsdevel+bounces-45768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A147FA7BE5A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:52:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46C9F177B11
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A1591F236C;
	Fri,  4 Apr 2025 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YADbW3Qz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028B71F3BAF;
	Fri,  4 Apr 2025 13:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774674; cv=none; b=AyHwWecIy/JWMeg7FutaF3tiB0fRtromazgZjEGLw4dy1fauSPKfUdupab0SQWcwfkoiGDA25XZri56pi4KktPrYU/ajlharfW7g5r8hkl4qwCfk+vyn8Hqh+BgpoVBhXTYBmRSgxUt9ASvveHP+foFKkacvUnVQwmkiNEkepng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774674; c=relaxed/simple;
	bh=vAMCgBLH3zFTnYXYmc9/+vXM0iaYHzR+FagrVctwrg8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RK4DzsdYlNrNP137MY6HHY7jdpXMeDq5tP1mbpyEd+3uFipLbSRRWmHOH06d/aC2LNP5cU7JJzPX4G2HpTzRVs29X0XQsRWSWGJoART/C5T2ff+7jQilQ3EN4h0EQgzYypWxg2j8jNKqOROScT8wJUmlL9zWTcL5/ZlVApIULtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YADbW3Qz; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=O1WYJ2sr778I+hZD/wg3UX/tFyzh0UfBLllp1RqHz6s=; b=YADbW3Qz5gz3nayfM9I8rYwXAN
	Z8/PqwU372LC0QifYgvyycVjwtC6/+T7at1nbchVS6lHE/tmTCqwZzamS4jUMNpo333+vcKncDA/3
	ip9VLU/B0callUb3Ws8KNCETQkyV3vKlo9C7UmhkIjrV7oQXdVJFj4zF+HGSFKXgTH0hs4zs3JZaf
	H6uCTNodocjSFI9GQZ4ofp4vXoVYViwqhlcabe9WB+hpXmBnY39OWJBG7bVJDpkLWLyqFCy/qhxS4
	xl89n6iQhS5gwc5d8arN8aWVUAXkHdiI27FjKwCcpchPlvp2Ele4fhYRyAvMTTBsfWFQiQxskC1/D
	GFXRbuSw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0hRh-0000000Fbbe-3KrQ;
	Fri, 04 Apr 2025 13:50:57 +0000
Date: Fri, 4 Apr 2025 14:50:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Matt Fleming <matt@readmodwrite.com>, adilger.kernel@dilger.ca,
	akpm@linux-foundation.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, luka.2016.cs@gmail.com, tytso@mit.edu,
	Barry Song <baohua@kernel.org>, kernel-team@cloudflare.com,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	Dave Chinner <david@fromorbit.com>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>
Subject: Re: Potential Linux Crash: WARNING in ext4_dirty_folio in Linux
 kernel v6.13-rc5
Message-ID: <Z-_jwWm5hsEp51h1@casper.infradead.org>
References: <Z8kvDz70Wjh5By7c@casper.infradead.org>
 <20250326105914.3803197-1-matt@readmodwrite.com>
 <CAENh_SSbkoa3srjkAMmJuf-iTFxHOtwESHoXiPAu6bO7MLOkDA@mail.gmail.com>
 <Z-7BengoC1j6WQBE@casper.infradead.org>
 <aadb65f3-7656-4051-99a4-909fc1f61fc7@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aadb65f3-7656-4051-99a4-909fc1f61fc7@suse.cz>

On Fri, Apr 04, 2025 at 11:09:37AM +0200, Vlastimil Babka wrote:
> On 4/3/25 19:12, Matthew Wilcox wrote:
> > Ideas still on the table:
> > 
> >  - Convert all filesystems to use the XFS inode management scheme.
> >    Nobody is thrilled by this large amount of work.
> >  - Find a simpler version of the XFS scheme to implement for other
> >    filesystems.
> 
> I don't know the XFS scheme, but this situation seems like a match for the
> mempool semantics? (I assume it's also a lot of work to implement)

Ah; no.  evicting an inode may consume an arbitrary amount of memory,
run transactions, wait for I/O, etc, etc.  We really shouldn't be doing
it as part of memory reclaim.  I should probably have said that as part
of this writeup, so thanks for bringing it up.

