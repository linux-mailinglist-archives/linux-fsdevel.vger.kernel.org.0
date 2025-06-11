Return-Path: <linux-fsdevel+bounces-51285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D0BAD527B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 12:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18C51BC0C1C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 10:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A35E927A935;
	Wed, 11 Jun 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5Fewh+B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0958226A0C7;
	Wed, 11 Jun 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749638652; cv=none; b=JjmuSWblAUb+caq4KTNWwyEZ6jP8v7qJpVSdhZaprp40fTBA9uFTxhu6/X4AaETFnwMBIkdXH5T92qqGhAgE+4EECmk5DnzC4DNt2+VM4ISFa78uwXfzmYBkQs44o3ri9HlFBpMdHAKSF1QnGLNkmYHendcwNp5fOZ505XwfmM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749638652; c=relaxed/simple;
	bh=L1BiHKGHoF+WJOUfUOC0toX/JFdirrVpJEGYABWCoT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azODqoK/UdY9n7af4bTtmDXo0hHch6iAeCfG7oSx54v5aLijMZB+NZiH/2Sp40p26QRDbDp88zKe/ryN4K9L1+dQq39e6uP3y9jeYxeb9hfGL0PuDfMvSMh//B+WRYGp/Ot9ty/qYaHaQ1Qb5WAVOaPGh0dCiyZGCqDLqPh8nvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5Fewh+B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5B2EC4CEF2;
	Wed, 11 Jun 2025 10:44:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749638651;
	bh=L1BiHKGHoF+WJOUfUOC0toX/JFdirrVpJEGYABWCoT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R5Fewh+BHlzuxEOmWF0fTcUi3Ct9X+6l862hvBwbDV3Me19BktS+z62h7+rj4QIkZ
	 q7GbECpW2EKtHvR6KV4Q/A6uoD6xJqwtf5OuJzhAqdNxXzoRNIPjWFa//+OiuGuirW
	 xElP1S2t6n4PoRyDA8UX8OgT3lMFkOYLBLXpzYY3S82aF+KBK6vPT2X6tL1MUvtzGs
	 OZWgkH9qxRCCgayLHm87YaCQxgrZpNNwAEsTRZdK7krjqQKHjDhOeIiZWgjD9l0tUm
	 rXY65Fn7Dmcu8vrJIXi8jUt+gaO2ZNBU/et+jQwQyFQd9vRSd2Bpyb4eDUAJ/IHHBx
	 hfOwK028WcTAg==
Date: Wed, 11 Jun 2025 06:44:10 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aEld-iBsy-vgXLoq@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <aEko3e_kpY-fA35R@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEko3e_kpY-fA35R@infradead.org>

On Tue, Jun 10, 2025 at 11:57:33PM -0700, Christoph Hellwig wrote:
> On Tue, Jun 10, 2025 at 04:57:32PM -0400, Mike Snitzer wrote:
> > Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> > read or written by NFSD will either not be cached (thanks to O_DIRECT)
> > or will be removed from the page cache upon completion (DONTCACHE).
> > 
> > enable-dontcache is 0 by default.  It may be enabled with:
> >   echo 1 > /sys/kernel/debug/nfsd/enable-dontcache
> 
> Having this as a global debug-only interface feels a bit odd.
> 

I generally agree, I originally proposed nfsd.nfsd_dontcache=Y
modparam:
https://lore.kernel.org/linux-nfs/20250220171205.12092-1-snitzer@kernel.org/

(and even implemented formal NFSD per-export "dontcache" control,
which Trond and I both think is probably needed).

But (ab)using debugfs is the approach Chuck and Jeff would like to
take for experimental NFSD changes so that we can kick the tires
without having to support an interface until the end of time. See
commit 9fe5ea760e64 ("NFSD: Add /sys/kernel/debug/nfsd") for more on
the general thinking.  First consumer was commit c9dcd1de7977 ("NFSD:
Add experimental setting to disable the use of splice read").

I'm fine with using debugfs, means to an end with no strings attached.

Once we have confidence in what is needed we can pivot back to
a modparam or per-export controls or whatever.

Mike

