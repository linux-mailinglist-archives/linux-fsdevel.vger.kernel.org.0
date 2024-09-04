Return-Path: <linux-fsdevel+bounces-28501-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9EEA96B58C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 10:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FFE5B2A06B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2024 08:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E18BA1CCB2F;
	Wed,  4 Sep 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fD7LyJcp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522EF1C8714
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Sep 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725439811; cv=none; b=hvsyCup2AsuvBrz2EH6u/hk9Z7Szqo9Vo6fiOStCzcIHD2EEan9xJC3L691fs9Jf9d/V6KRetyYUfd0oq0ZKqBwEYJSD2D8Nzd1PKH1IBLCBLH+Roh5WiVot9e1UZwBq3fGmzc7YMc3eKDa4pFmI7OqpLZq3eGeAbbb5fCUY90Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725439811; c=relaxed/simple;
	bh=9LN28g4AsA0E3xhcLnzrLBKkPj5VO/TKLTeZXa+UCfw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAzcK/uAAZV2JDCOiZylIO68AmEe0dcKaHJc6YhmbR3lecBPCR4fj4Or3kL/XKaSjxchHo7WSQ7rsq+UCSmfZ5s7tQECu8ldripcdhdo9gsD2mjC1Xwjt27riCRJDrc91Xuz7R+qQPErH/rFzDLKOXShslsI3/+opnV5YiKDyVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fD7LyJcp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00B9EC4CEC2;
	Wed,  4 Sep 2024 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725439810;
	bh=9LN28g4AsA0E3xhcLnzrLBKkPj5VO/TKLTeZXa+UCfw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fD7LyJcpwmzh63xKahDlmv3EImu5NasIlg/WRsrPfWCG34FD9bwEc5Qptlpmwz3Qj
	 qP8mx3Y1sANGRhGlsU1bX9NVmRUJwD+ydbGWOCl7Y9QH+WmgEtgVjWE4TsxAlzSKkJ
	 Mnuu+aPPP64hwPnPqa7Eyj6Nr0mFe7KUFuMWlVGJFuJNKpjMENYJ5n4y1eWe7GKkOo
	 4LoAylMPJY3os5wiSTJx6uQM3++fc5NY/33QRpJXyKvN2+2txXx9NFR9P5SKsGwt0t
	 6Imdyu5j1C0iX40ffauqzALWNgHWOypbTdMMs0YOrDNzX2cHbAR40rC+ufbq7Peevf
	 n6WcNF3oGg7Cw==
Date: Wed, 4 Sep 2024 10:50:06 +0200
From: Christian Brauner <brauner@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Jann Horn <jannh@google.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 15/15] io_uring: port to struct kmem_cache_args
Message-ID: <20240904-enteignen-unpolitisch-b30e7313b8ed@brauner>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
 <20240903-work-kmem_cache_args-v2-15-76f97e9a4560@kernel.org>
 <40b37458-5f75-40c1-b07a-529072e4c4a1@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40b37458-5f75-40c1-b07a-529072e4c4a1@suse.cz>

On Wed, Sep 04, 2024 at 10:20:31AM GMT, Vlastimil Babka wrote:
> On 9/3/24 16:20, Christian Brauner wrote:
> > Port req_cachep to struct kmem_cache_args.
> 
> Fine but doesn't bring anything on its own, wouldn't Jens want to supply the
> freeptr_offset at the same time to benefit from it?

I just picked two victims that I knew do rely or want to rely on
features that weren't there before. Afterwards, Jens can just select or
add a free pointer to struct io_kiocb.

