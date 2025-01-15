Return-Path: <linux-fsdevel+bounces-39220-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E77A116D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 02:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16F123A65A8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2025 01:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD83122D4FB;
	Wed, 15 Jan 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0lMl6Gl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6382B9A6
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Jan 2025 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736905812; cv=none; b=m+oxhqKkTqGHOLbacl+uFh2TLD+TZ4MfFbItLJt51SFtRq+kjEYWEWg/G89qWcMjDoqSSHJVVRIcq+Sv79wMFENY4uXg0jFWOAQ/I/rKS+A5Quy0d43Z664/JVr8OUd4Ateb8RIOGlwOn7pwpCeBeupfKaw9pHJ2gKN6FxXJ7Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736905812; c=relaxed/simple;
	bh=79MFVIqUuOtzGNPHpqDIhxG/oRviPGoQBum7jlcxVfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kH9vhoKf9lMbA1f+wt4vY1KYdtRPvyqZbDMDtUqzFRE2otgtkkcPrkjH0Bz9IFvfRuJN+6PxCOaqizut3EiwURGDK6XvKDUgflGMVBxnEC9kieH0N6zyWC2xpXR7bbNxlwl5jcfqgAkQFw2FbUDGIX+F57vS2SA2oN3bJ78TdnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0lMl6Gl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B85C4CEDD;
	Wed, 15 Jan 2025 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736905811;
	bh=79MFVIqUuOtzGNPHpqDIhxG/oRviPGoQBum7jlcxVfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0lMl6Gl0PHtDN2EyzDHRqE0h7nzcSrUUwF5QBr1+z3OVyFMvY2XPJ8PW2S7JzNDO
	 gbjbl0DQqAzAiVtxToBQhC2QOSnp1bnuTQhGRfc8qKlyAF5ML4eGgTIabxFrOetlGr
	 e7t3qRN/m6LuLRGPoDoXO+iTiDF0R0PF/lm+jLAHknwYiz/HXA9ChK6iWYfJLTzOmr
	 Rx7WCYbyEMRCxCTOyaT8XG/lWq63JT+IYR0R93qpnFX3ZTFOZnR0Pl/SPBe538htbd
	 rNPKrI1Is8fSWunCUeXZEZSWcHiBp0+qH1gjJ4rMcQ5P0ImqsFaGsemAOD3eTxEo61
	 P39kAoKQn1ruA==
Date: Tue, 14 Jan 2025 17:50:10 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Improving large folio writeback performance
Message-ID: <20250115015010.GD3561231@frogsfrogsfrogs>
References: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1a38pv3OgFZRfdTiDMXuPWuBgN8KY47XfOsYHj=N2wxAg@mail.gmail.com>

On Tue, Jan 14, 2025 at 04:50:53PM -0800, Joanne Koong wrote:
> Hi all,
> 
> I would like to propose a discussion topic about improving large folio
> writeback performance. As more filesystems adopt large folios, it
> becomes increasingly important that writeback is made to be as
> performant as possible. There are two areas I'd like to discuss:
> 
> 
> == Granularity of dirty pages writeback ==
> Currently, the granularity of writeback is at the folio level. If one
> byte in a folio is dirty, the entire folio will be written back. This
> becomes unscalable for larger folios and significantly degrades
> performance, especially for workloads that employ random writes.
> 
> One idea is to track dirty pages at a smaller granularity using a
> 64-bit bitmap stored inside the folio struct where each bit tracks a
> smaller chunk of pages (eg for 2 MB folios, each bit would track 32k
> pages), and only write back dirty chunks rather than the entire folio.
> 
> 
> == Balancing dirty pages ==
> It was observed that the dirty page balancing logic used in
> balance_dirty_pages() fails to scale for large folios [1]. For
> example, fuse saw around a 125% drop in throughput for writes when
> using large folios vs small folios on 1MB block sizes, which was
> attributed to scheduled io waits in the dirty page balancing logic. In
> generic_perform_write(), dirty pages are balanced after every write to
> the page cache by the filesystem. With large folios, each write
> dirties a larger number of pages which can grossly exceed the
> ratelimit, whereas with small folios each write is one page and so
> pages are balanced more incrementally and adheres more closely to the
> ratelimit. In order to accomodate large folios, likely the logic in
> balancing dirty pages needs to be reworked.

Hmrmm.... it's a pity that folio_account_dirtied charges the process
for all the pages in the folio even if it only wrote one byte, and then
the ratelimit thresholds haven't caught up to filesystems batching calls
to balance_dirty_pages.  But I'm no expert on how that ratelimiting
stuff works so that's all I have to say about that. :/

--D

> 
> Thanks,
> Joanne
> 
> [1] https://lore.kernel.org/linux-fsdevel/Z1N505RCcH1dXlLZ@casper.infradead.org/T/#m9e3dd273aa202f9f4e12eb9c96602b5fec2d383d
> 

