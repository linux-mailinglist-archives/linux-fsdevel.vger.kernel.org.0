Return-Path: <linux-fsdevel+bounces-72593-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C0970CFC78C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 07 Jan 2026 08:58:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9914030A27D4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Jan 2026 07:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA9427FD5D;
	Wed,  7 Jan 2026 07:55:09 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD719B5B1;
	Wed,  7 Jan 2026 07:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767772509; cv=none; b=jmPECdy212B+Li3bpg/b6ZoS9MxYm9TC5cXFIWNxd5Rl+pLyHNsY5kr7+BOOdXkIfdGh3vqE7Q5NbJgdIhRPp+n3WUqM38A7RtiumIoenRdId9AYW7R2I1Z7A4KlNI0cXpJNtymVDnxEuBrcjP2dQDRvzAzzX9Bt+GpX7m92pO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767772509; c=relaxed/simple;
	bh=TTYbyIbZX1cjBDFxZ+ecuH4agBFLqqPo5rI1MmbSuq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wawm4hXrE8Zx3YBfGMfGv1UxqlwmrrcE+9+SfMrtOVYYOeCHR+x293xWBYnIn5R0fp8z02rBZR3ccUiKFu1RfHG8hHr4on1NYK63yGxqOB8K+dcUwE0I1G8NDIluOrc+y2imllarnG20ZGgqAm39qLAoVOkBmHA0kTQjjNxTWEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3E576227AA8; Wed,  7 Jan 2026 08:55:02 +0100 (CET)
Date: Wed, 7 Jan 2026 08:55:01 +0100
From: Christoph Hellwig <hch@lst.de>
To: Chuck Lever <cel@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] NFSD: Add aggressive write throttling control
Message-ID: <20260107075501.GA19005@lst.de>
References: <20251219141105.1247093-1-cel@kernel.org> <20251219141105.1247093-2-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219141105.1247093-2-cel@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 19, 2025 at 09:11:04AM -0500, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> On NFS servers with fast network links but slow storage, clients can
> generate WRITE requests faster than the server can flush payloads to
> durable storage. This can push the server into memory exhaustion as
> dirty pages accumulate across hundreds of concurrent NFSD threads.
> 
> The existing dirty page throttling (balance_dirty_pages()) uses
> per-task accounting with default ratelimits that allow each thread
> to dirty ~32 pages before throttling occurs. With many NFSD threads,
> this allows significant dirty page accumulation before any
> throttling kicks in.

What makes NFSD so special here vs say a userspace process with a bunch
of threads?  Also what is the actual problem we're trying to solve?

I kinda hate having this stuff in NFSD when there's nothing specific
about nfs serving here.


