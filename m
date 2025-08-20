Return-Path: <linux-fsdevel+bounces-58419-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E784CB2E90D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BA0CA21F12
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Aug 2025 23:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92CF72E173E;
	Wed, 20 Aug 2025 23:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jlWqCAUd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4C32E1749
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Aug 2025 23:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755734008; cv=none; b=d2WXwyEpB+Q75W2tOTU/CGDOYqbzxBh5CUWJN4qb0UDfMYjmPIvv3O3lLI4fhtZQ1PYhEDr6Fh8MTyrj4jE4JSululdSTTIso7FH9rTAWrx2DyzlVMw4QHS9lY+uZRqgvJXY1RSDdLo+E5dUa1+HROXwvMSPWaS8V6YaiBv/140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755734008; c=relaxed/simple;
	bh=YOV7POjGAXStNJN2/AWGyI9G4pC5vwPwZEZDKij/f6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fffJHyLgHOY0NrmcuMYrmb3xW0ZVU/xx9QHfPZNqi5Del5U7VgCX199B5x11sqVVpxb3jzVl1nCYlUFZ91ABSgZ4nVlefzK7FpEedJ7HsCBe47EQ2QJLpHUDbSfI7Rir6IBYP2OQHuBuNvRkh26JNwIWTcR41bP2Rsffj7hiiFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jlWqCAUd; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 20 Aug 2025 16:53:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755733993;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hcMZ8t9IBgLGTLqUXyODk/78P2oc2QGoFTKM34aNlho=;
	b=jlWqCAUd9IZ3Rl+kmMX8pDSpmgTwgtM23zERkinX2y8Egh7KSodjhRESED1ehHRXXR3pvB
	JOuKhp7JynCFXX1oFbMLVh6b8oGpDqt9Y8AVM/qtziEawyIff+VB3ULBvbpheSFcgsS2g0
	hqQ8wDLE1LsELx5NMndeXK2lnNx4Opw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Boris Burkov <boris@bur.io>
Cc: Klara Modin <klarasmodin@gmail.com>, akpm@linux-foundation.org, 
	linux-btrfs@vger.kernel.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	kernel-team@fb.com, wqu@suse.com, willy@infradead.org, mhocko@kernel.org, 
	muchun.song@linux.dev, roman.gushchin@linux.dev, hannes@cmpxchg.org
Subject: Re: [PATCH v3 1/4] mm/filemap: add AS_UNCHARGED
Message-ID: <p7uqfmtrl5duh4zekgtf3vtl4jsstbdefar5nramp4aflcn25t@7pmvft4zmsid>
References: <cover.1755562487.git.boris@bur.io>
 <43fed53d45910cd4fa7a71d2e92913e53eb28774.1755562487.git.boris@bur.io>
 <hbdekl37pkdsvdvzgsz5prg5nlmyr67zrkqgucq3gdtepqjilh@ovc6untybhbg>
 <20250820225222.GA4100662@zen.localdomain>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820225222.GA4100662@zen.localdomain>
X-Migadu-Flow: FLOW_OUT

On Wed, Aug 20, 2025 at 03:52:22PM -0700, Boris Burkov wrote:
[...]
> 
> Thanks so much for the report and fix! I fear there might be some other
> paths that try to get memcg from lruvec or folio or whatever without
> checking it. I feel like in this exact case, I would want to go to the
> first sign of trouble and fix it at lruvec_memcg(). But then who knows
> what else we've missed.

lruvec_memcg() is not an issue but folio_memcg() can be. I found
following instances of folio_memcg() which are problematic (on
next-20250819):

mm/memcontrol.c:3246:   css_get_many(&__folio_memcg(folio)->css, new_refs);

include/trace/events/writeback.h:269:           __entry->page_cgroup_ino = cgroup_ino(folio_memcg(folio)->css.cgroup);

mm/workingset.c:244:    struct mem_cgroup *memcg = folio_memcg(folio);

mm/huge_memory.c:4020:  WARN_ON_ONCE(!mem_cgroup_disabled() && !folio_memcg(folio));

> 
> May I ask what you were running to trigger this? My fstests run (clearly
> not exercising enough interesting memory paths) did not hit it.
> 
> This does make me wonder if the superior approach to the original patch
> isn't just to go back to the very first thing Qu did and account these
> to the root cgroup rather than do the whole uncharged thing.

I don't have any strong preference one way or the other.

