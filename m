Return-Path: <linux-fsdevel+bounces-27970-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC599655BA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 05:39:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A351F23948
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 03:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B862136326;
	Fri, 30 Aug 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="LzS0ZQ6o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F096236B0D
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Aug 2024 03:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724989182; cv=none; b=BdowCLjaujl0gGtoWl7bVICRy0mRXVxRikwEj8ZGn+Uq78G/h2WWR7wKnAQ9PDWfxcLkQ4IVhr3atNmO/RluaAsXebJFzCbAfdTJB+7fOPyHKj1AreDOtikeyvBlfL+fQg8xZu3CakeBr5dSIWSgFq6Bz/K1jB8ac/L5EcSQnP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724989182; c=relaxed/simple;
	bh=9g+fkzgNiLmkzb8kJYA3wu4o17li5UlZA5Js0dxJiRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lddTrgzUIyFYilJtZueOfUSlBJGAlr6rqAVGKDwR013vf9O2YTJFIxo8DxSeVyQRGvl3t3nQlnXwfhxXtD3HeIMwSx7MhtpaYP7CUWd4FQ1lq5OY369IBZnLZQiVloKHPxu7x8s5fsqRBeqh5AFJanZjbPDr6H1SXY5JL1bTIKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=LzS0ZQ6o; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-112-93.bstnma.fios.verizon.net [173.48.112.93])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 47U3d6d9028280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Aug 2024 23:39:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1724989148; bh=iBN1OqKISlzImerjylAD7DIlwprKTEvfPiiXXj/dLaQ=;
	h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
	b=LzS0ZQ6obZmSSsyjaPriURvOuAoToFy5I4SVjGhUGdpCwKSIXBwt3LZQJrgW740CJ
	 dGEwODnZCAyJ3lxGE+mn0WiD5tg+uRkVnfRYWXLozyKP18C+ODYuYythaN6+xaxz+t
	 T4lyl4FHjRVGVUKlVOCnTyQPjV59vymE0AlJP6uON6/0OsI8iCWuYLNW3D70vqgOm7
	 qtW7ZUA6diTVtP2gWnXCOEelkxj4N3xzrXFPs4cg3FHB+1SeNUvAvAvF/rrOd4IdXU
	 LohFASq22zl8qk2Yqh2KA26DCP9izryo8n3t5HLL4AxxV1HqAvwxPDx7qw8Ewvct1r
	 e3YMRiCA0OFug==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id B367C15C02C1; Thu, 29 Aug 2024 23:39:05 -0400 (EDT)
Date: Thu, 29 Aug 2024 23:39:05 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Dave Chinner <david@fromorbit.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
        Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: Re: [PATCH] bcachefs: Switch to memalloc_flags_do() for vmalloc
 allocations
Message-ID: <20240830033905.GC9627@mit.edu>
References: <20240828140638.3204253-1-kent.overstreet@linux.dev>
 <Zs9xC3OJPbkMy25C@casper.infradead.org>
 <gutyvxwembnzaoo43dzvmnpnbmj6pzmypx5kcyor3oeomgzkva@6colowp7crgk>
 <Zs959Pa5H5WeY5_i@tiehlicka>
 <xxs3s22qmlzby3ligct7x5a3fbzzjfdqqt7unmpih64dk3kdyx@vml4m27gpujw>
 <ZtBWxWunhXTh0bhS@tiehlicka>
 <wjfubyrzk4ovtuae5uht7uhhigkrym2anmo5w5vp7xgq3zss76@s2uy3qindie4>
 <ZtCFP5w6yv/aykui@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZtCFP5w6yv/aykui@dread.disaster.area>

On Fri, Aug 30, 2024 at 12:27:11AM +1000, Dave Chinner wrote:
> 
> We've been using __GFP_NOFAIL semantics in XFS heavily for 30 years
> now. This was the default Irix kernel allocator behaviour (it had a
> forwards progress guarantee and would never fail allocation unless
> told it could do so). We've been using the same "guaranteed not to
> fail" semantics on Linux since the original port started 25 years
> ago via open-coded loops.

Ext3/ext4 doesn't have quite the history as XFS --- it's only been
around for 23 years --- but we've also used __GFP_NOFAIL or its
moral equivalent, e.g.:

> 	do {
> 		p = kmalloc(size);
> 	while (!p);

For the entire existence of ext3.

> Put simply: __GFP_NOFAIL will be rendered completely useless if it
> can fail due to external scoped memory allocation contexts.  This
> will force us to revert all __GFP_NOFAIL allocations back to
> open-coded will-not-fail loops.

The same will be true for ext4.  And as Dave has said, the MM
developers want to have visibility to when file systems have basically
said, "if you can't allow us to allocate memory, our only alternative
is to cause user data loss, crash the kernel, or loop forever; we will
choose the latter".  The MM developers tried to make __GFP_NOFAIL go
away several years ago, and ext4 put the retry loop back, As a result,
the compromise was that the MM developers restored __GFP_NOFAIL, and
the file systems developers have done their best to reduce the use of
__GFP_NOFAIL as much as possible.

So if you try to break the GFP_NOFAIL promise, both xfs and ext4 will
back to the retry loop.  And the MM devs will be sad, and they will
forcibly revert your change to *ther* code, even if that means
breaking bcachefs.  Becuase otherwise, you will be breaking ext4 and
xfs, and so we will go back to using a retry loop, which will be worse
for Linux users.

Cheers,

					- Ted

