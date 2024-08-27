Return-Path: <linux-fsdevel+bounces-27398-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B2196139A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 18:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7AC741C232EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Aug 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A93371C93B6;
	Tue, 27 Aug 2024 16:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0YiOHzs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1758A1C6F48
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Aug 2024 16:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724774720; cv=none; b=rVjdc014wycehNNLuIcB6p8qpDbjDVW6ANyBnxcAup+9IW/9/7Vs5Wx+s7aS+bVVl+bNP1++z1gC1gKzP9GLOQtjUvfUF4c2XyP0i1kTEOdAQBLvfsvOxMB9g7ENVxAbE4fuopUVAP4WuU3Ec3nejz3cyzwA0s94ZyqjEKDsLFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724774720; c=relaxed/simple;
	bh=s8P+tRPzYwjOiQdXkmPvI2R3fODV+CgoGK+rb+No/5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YqDk3mLkv77D3gCsyD34mkkUqU6Whdx5Boe+ifF9NRbROZbqyzxBYxB1rW5F48kL1++p5hR3RE9eybrsGTcINGR/GAw1iFmeVRjgX3wwGXfAPPZbS6Y3ABPApGeFThMZorseYTKf7uCNkdcKOFXXoo1k0Ydtck/+kESk/tXOJ7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0YiOHzs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC8CEC581B0;
	Tue, 27 Aug 2024 16:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724774719;
	bh=s8P+tRPzYwjOiQdXkmPvI2R3fODV+CgoGK+rb+No/5E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J0YiOHzsoM5+uuZINH/Z6B4l9eSV+FmfJWkRPLp1WvIAJkETEki3y1VPfBa7sezEk
	 7rsMTU6/kHKeCoir9ekKsrBPb0abF7qp2TkYmGp5bL+nUqjdLo/EZk+u1c/ljv02aj
	 2rNqiqGejhbfTlj0nTomSOKLsDaLjmf51VQ76BbKNkIzLu/UCAR7ZCPeSc0LIQvttV
	 Na8VLUir1DjFQvyys+f1XrrvLykaYBjIp5/cL0TbYGEkPUSyAPLq1taYiJQsBKHkYO
	 N0nSMC05aE0otO7UqxFPcyJl8aPwgdZsk7AgeqgMl6G7x/K24+c37sUUocgq5DiGl2
	 AHhLDS/sJAMZg==
Date: Tue, 27 Aug 2024 18:05:15 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Jann Horn <jannh@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, 
	linux-mm@kvack.org
Cc: linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs,mm: add kmem_cache_create_rcu()
Message-ID: <20240827-lehrjahr-bezichtigen-ecb2da63d900@brauner>
References: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240827-work-kmem_cache-rcu-v2-0-7bc9c90d5eef@kernel.org>

On Tue, Aug 27, 2024 at 05:59:41PM GMT, Christian Brauner wrote:
> When a kmem cache is created with SLAB_TYPESAFE_BY_RCU the free pointer
> must be located outside of the object because we don't know what part of
> the memory can safely be overwritten as it may be needed to prevent
> object recycling.
> 
> That has the consequence that SLAB_TYPESAFE_BY_RCU may end up adding a
> new cacheline. This is the case for .e.g, struct file. After having it
> shrunk down by 40 bytes and having it fit in three cachelines we still
> have SLAB_TYPESAFE_BY_RCU adding a fourth cacheline because it needs to
> accomodate the free pointer and is hardware cacheline aligned.
> 
> I tried to find ways to rectify this as struct file is pretty much
> everywhere and having it use less memory is a good thing. So here's a
> proposal.
> 
> I was hoping to get something to this effect into v6.12.
> 
> If we really want to switch to a struct to pass kmem_cache parameters I
> can do the preparatory patch to convert all kmem_cache_create() and
> kmem_cache_create_usercopy() callers to use a struct for initialization
> of course. I can do this as a preparatory work or as follow-up work to
> this series. Thoughts?

So one thing I can do is to add:

struct kmem_cache_args {
	.freeptr_offset,
	.useroffset,
	.flags,
	.name,
};

accompanied by:

int kmem_create_cache(struct kmem_cache_args *args);

and then switch both the filp cache and Jens' io_kiocb cache over to use
these two helpers. Then we can convert other callers one by one.

@Vlastimil, @Jens, @Linus what do you think?

