Return-Path: <linux-fsdevel+bounces-27764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 824149639FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 07:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B59FF1C23BB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 05:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B8E01487D1;
	Thu, 29 Aug 2024 05:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dYXwYRNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608DDEAD5;
	Thu, 29 Aug 2024 05:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724910119; cv=none; b=V2IQ86CMNV+l7vNnJ/8U+A4oDqxW6Gi5Inf9OsehssfDww+TsVT1YKEwy4EL/9+2S/BDOY/nPT9dwpt/anuZoxsRq9fqrJ7vQ0572n6BScPYq+C96C5zw5B06WmK/DgkvNqVue8uDWUDkO5RWeHmXCH4Anliyi5LoMjHZH/IVyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724910119; c=relaxed/simple;
	bh=jyGaQPMnPj2tCjOQqCi+8gEJCAbKmNuFE7iNOsFeeRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vAuwuQpL6uX+HjGAAMh14hCHj5uWyVAQsh0jpmxD5tjP+t+JJGRyUCN3ySZdjPeta/6OsVLseIyeJrsEiD4c+fYAemPeSuEyYuw0VaNoDC6XSVH6N4KYqgFp3iC9qK4ZKVh5sm8CfoVCjdvGy2J2YGJg9d9Ucy/cXhKYjuOctqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dYXwYRNo; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rGBPdhvxamoPQC5N4zLYkm5U4PqPbkWwmIYWe0iQNH8=; b=dYXwYRNoALCdq32TetQv6F26DM
	HtW8apiPBK/Cu0mSKr4/ByORfMAftsFUbgvt7Qr0HjdU+xP+R96NTruCUano4rMAjM3zdWmSfx7fn
	58kcbJapKfnC1KdxSeWjsAe6mQQVRYoRnrUNn9T2zQLWHNTh9tYQTLmnFEEqD6NMsBLzD50yTl21K
	bQCNQ+DQQtprAOk/a/yBlsq49L2H/Mts9cUJ0Yqfoy2/kJG7AhxP9M1CdONT03SY9L3jBuFFQosC/
	sE7zz8in3t2H288/q2vCrGxh4QaPYKXvfJbOuKU7Hnhtkv2O8PLgycaasWQMbMYfPXS+fcchxZa/Z
	c3xzDvbw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sjXuu-00000000d0n-1k7l;
	Thu, 29 Aug 2024 05:41:56 +0000
Date: Wed, 28 Aug 2024 22:41:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	djwong@kernel.org, josef@toxicpanda.com, david@fromorbit.com
Subject: Re: [PATCH 2/2] iomap: make zero range flush conditional on
 unwritten mappings
Message-ID: <ZtAKJH_NGhjxFQHa@infradead.org>
References: <20240822145910.188974-1-bfoster@redhat.com>
 <20240822145910.188974-3-bfoster@redhat.com>
 <Zs1uHoemE7jHQ2bw@infradead.org>
 <Zs3hTiXLtuwXkYgU@bfoster>
 <Zs6oY91eFfaFVrMw@infradead.org>
 <Zs8Zo3V1G3NAQEnK@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs8Zo3V1G3NAQEnK@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Aug 28, 2024 at 08:35:47AM -0400, Brian Foster wrote:
> Yeah, it was buried in a separate review around potentially killing off
> iomap_truncate_page():
> 
> https://lore.kernel.org/linux-fsdevel/ZlxUpYvb9dlOHFR3@bfoster/
> 
> The idea is pretty simple.. use the same kind of check this patch does
> for doing a flush, but instead open code and isolate it to
> iomap_truncate_page() so we can just default to doing the buffered write
> instead.
> 
> Note that I don't think this replaces the need for patch 1, but it might
> arguably make further optimization of the flush kind of pointless
> because I'm not sure zero range would ever be called from somewhere that
> doesn't flush already.
> 
> The tradeoffs I can think of are this might introduce some false
> positives where an EOF folio might be dirty but a sub-folio size block
> backing EOF might be clean, and again that callers like truncate and
> write extension would need to both truncate the eof page and zero the
> broader post-eof range. Neither of those seem all that significant to
> me, but just my .02.

Looking at that patch and your current series I kinda like not having
to deal with the dirty caches in the loop, and in fact I'd also prefer
to not do any writeback from the low-level zero helpers if we can.
That is not doing your patch 1 but instead auditing the callers if
any of them needs them and documenting the expectation.

But please let Dave and Darrick chime in first before investing any
work into this.


