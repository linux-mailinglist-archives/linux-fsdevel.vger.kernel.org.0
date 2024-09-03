Return-Path: <linux-fsdevel+bounces-28447-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8255396A749
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 21:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B4FFD1C2316D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Sep 2024 19:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 240BE1C9DD0;
	Tue,  3 Sep 2024 19:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHMge7a1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881211D5CC6
	for <linux-fsdevel@vger.kernel.org>; Tue,  3 Sep 2024 19:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391355; cv=none; b=MgSxizs9xmET6mkVwQFc7IAMLRDsXFO9HKidF15xuR4j66VJ7WQoiVG8Pv9sM2tpLFV4y3ehh4c96XBPnEz5xkn0DLXUYe2vgEbiU7iR0QRNaXpNxk854ZwnY3/Kg0hzpWeCW0YoMmAEPX1FMr6rlNz0naWpPLHK1BXkONkURc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391355; c=relaxed/simple;
	bh=CTj3pW0xhCzokhbK5aIla62gd5xKlrfRVeSNyjndKA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n5hEoaLwIsELrZc+VRxY80F066DGEMTzTwVIXaYV9ozs92/taxnVtKuo96Qd0s1RIO39vEDnR9EaXB87NwKVbrtjrsWL0puDl2AVGZLpUZH4HekQn1BMBpbY9LpWoH35Yq2u06ZQxvtvc2I1Fd6GgDH5sIzDdb17DIgJyirw3ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHMge7a1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E639C4CEC4;
	Tue,  3 Sep 2024 19:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725391355;
	bh=CTj3pW0xhCzokhbK5aIla62gd5xKlrfRVeSNyjndKA0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kHMge7a1GuPlZ/XAGqkgOdn33nsDnuYfipHOHQmSR7JgGROZ4wHbKldY9l2Z9ZUMQ
	 VE/OTerg6ybSzqvhZjrOkPLws5vtc+rFncJygevc1aitMmT3pVGtlAP0oClC9tf+PO
	 y3W+/D628bPSlVk9s0BAJg+N62uNePcbSoQgTU3wR1JQdTMhedV3OuUdbn/z7G/BLb
	 r4AAZC279Z37y4Xe50NLBdVvS6j2jJ1YFU/KJ2u0ilq6jR791W+qEibVwMHKAWsdWG
	 RJwzGgqFOTNMXD6Acw0bqIC9JfZKF51CJjWvoh543lydmZ9cM5nVDWNrzUO2hPc2Qu
	 odFZCuCpZ90mQ==
Date: Tue, 3 Sep 2024 12:22:34 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
	Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 00/15] slab: add struct kmem_cache_args
Message-ID: <202409031220.FECC4BD9@keescook>
References: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903-work-kmem_cache_args-v2-0-76f97e9a4560@kernel.org>

On Tue, Sep 03, 2024 at 04:20:41PM +0200, Christian Brauner wrote:
> However, I came up with an alternative using _Generic() to create a
> compatibility layer that will call the correct variant of
> kmem_cache_create() depending on whether struct kmem_cache_args is
> passed or not. That compatibility layer can stay in place until we
> updated all calls to be based on struct kmem_cache_args.

Very nice!

Yeah, this looks good to me. I'd been long pondering something like this
for kmalloc itself (though codetags have taken that in a different
direction).

All the patches look like the right way forward to me:

Reviewed-by: Kees Cook <kees@kernel.org>

-- 
Kees Cook

