Return-Path: <linux-fsdevel+bounces-51787-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2C0ADB656
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 18:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5DC13B6D5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Jun 2025 16:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17298286421;
	Mon, 16 Jun 2025 16:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIbNymSw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721BE21E0A8;
	Mon, 16 Jun 2025 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750090240; cv=none; b=k1HbeQ1lHCfA6k6Rs7tfJcqnASNHJ7ecqBGU1LKrQvLktRFamrBy53zUls19xinQAoA/oHElfswJatsDTwE7wtTB4Hk07MANGBTUR+JawICv3O4+VQcPxnd7rH+8tSBKKybs/RJknnwvH25eM7zl9g/Prxlin17UXH2bIyLiKEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750090240; c=relaxed/simple;
	bh=msta/VbRK4gFFOO94yUWl0CZPF3iEp7ftLxtL7Ax3sY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5+o+ccHdrbZREkuBjThnceOlGndeavsCN4NJYNlserEXq4Lqit+/iUoZ+k7kluVJJtiC7/NTdWleHKwd2vgdtIU8gmulj4CJ4uRqV5j9jZ9POS5PaG/oq309WekIiR4Jsc3/YpmQCoQ6AoNiSzgRfTtFilsmZYgQQqIy15/TcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIbNymSw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B36C4CEEA;
	Mon, 16 Jun 2025 16:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750090239;
	bh=msta/VbRK4gFFOO94yUWl0CZPF3iEp7ftLxtL7Ax3sY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIbNymSwIC0PE9FjaRW1bOtcNfLgHmkCYGTYGLFUXf4LGIeX3Is1J34xu+QOv3/nb
	 kMJ+KsuzfTpn/QpCaRh2pnT3E7adiiRmwCl5VzqPtvllbkZ2emMWwuEte4V/S11EJB
	 3B9sVrF4fNaJiMAAF3AKsntwsWQ2TLn//fqnGrkZCaPu3oatQ0+uAFC/nxky3h/Wuo
	 oCmuWZiFAukkXHvhfLTc7j6XK8BmnSQ1VQPG6S88NQpQlQG7BjYX/LEnFnSopincwP
	 frqd9Zz6jHiu7G/LuzlVl3U5yTA/eYq/SQkKndsGOB4GJQlqSMvsnMUs15JoHkPY2f
	 Ud/R0Is17oOjw==
Date: Mon, 16 Jun 2025 12:10:38 -0400
From: Mike Snitzer <snitzer@kernel.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aFBB_txzX19E-96H@kernel.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
 <4b858fb1-25f6-457f-8908-67339e20318e@oracle.com>
 <aEnWhlXjzOmRfCJf@kernel.org>
 <d8d01c41-f37f-42e0-9d46-62a51e95ab82@oracle.com>
 <aEr5ozy-UnHT90R9@kernel.org>
 <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5dc44ffd-9055-452c-87c6-2572e5a97299@oracle.com>

On Mon, Jun 16, 2025 at 09:32:16AM -0400, Chuck Lever wrote:
> On 6/12/25 12:00 PM, Mike Snitzer wrote:
> > On Thu, Jun 12, 2025 at 09:21:35AM -0400, Chuck Lever wrote:
> >> On 6/11/25 3:18 PM, Mike Snitzer wrote:
> >>> On Wed, Jun 11, 2025 at 10:31:20AM -0400, Chuck Lever wrote:
> >>>> On 6/10/25 4:57 PM, Mike Snitzer wrote:
> >>>>> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> >>>>> read or written by NFSD will either not be cached (thanks to O_DIRECT)
> >>>>> or will be removed from the page cache upon completion (DONTCACHE).
> >>>>
> >>>> I thought we were going to do two switches: One for reads and one for
> >>>> writes? I could be misremembering.
> >>>
> >>> We did discuss the possibility of doing that.  Still can-do if that's
> >>> what you'd prefer.
> >>
> >> For our experimental interface, I think having read and write enablement
> >> as separate settings is wise, so please do that.
> >>
> >> One quibble, though: The name "enable_dontcache" might be directly
> >> meaningful to you, but I think others might find "enable_dont" to be
> >> oxymoronic. And, it ties the setting to a specific kernel technology:
> >> RWF_DONTCACHE.
> >>
> >> So: Can we call these settings "io_cache_read" and "io_cache_write" ?
> >>
> >> They could each carry multiple settings:
> >>
> >> 0: Use page cache
> >> 1: Use RWF_DONTCACHE
> >> 2: Use O_DIRECT
> >>
> >> You can choose to implement any or all of the above three mechanisms.
> > 
> > I like it, will do for v2. But will have O_DIRECT=1 and RWF_DONTCACHE=2.
> 
> For io_cache_read, either settings 1 and 2 need to set
> disable_splice_read, or the io_cache_read setting has to be considered
> by nfsd_read_splice_ok() when deciding to use nfsd_iter_read() or
> splice read.

Yes, I understand.
 
> However, it would be slightly nicer if we could decide whether splice
> read can be removed /before/ this series is merged. Can you get NFSD
> tested with IOR with disable_splice_read both enabled and disabled (no
> direct I/O)? Then we can compare the results to ensure that there is no
> negative performance impact for removing the splice read code.

I can ask if we have a small window of opportunity to get this tested,
will let you know if so.

