Return-Path: <linux-fsdevel+bounces-74581-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3912D3C082
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 08:33:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4F9EA409231
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Jan 2026 07:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1020B39901F;
	Tue, 20 Jan 2026 07:26:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8206538BDB3;
	Tue, 20 Jan 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768894008; cv=none; b=Ot/HhSNh+CpC56l7g1knqCSvcVqbj3yeaLItFjUAUxfpLrDCemBXyzz2QbJLG9iQzf1dnGBz4u0rg6a8T5QhPMXlFVq9vGch7sKhEpoeMPeIS/KWIZ0GcnfkAB+QUwQZ0/XbtSeq3ou2iKSbpqieU+oSwqpBMkwuaOmRuGEXs8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768894008; c=relaxed/simple;
	bh=VgY2ji32iqF7Zuuu6BiSatJ5aQnP5AIYedVUgiM0m6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCNHvwZ8CFdIdW5jraZyKMmZ2cQf2qO/xZlKN8gky1XO/bqH+NTm7YTIBjZRgodMcU/ct0TwoxiNBYvPpkhnnkBA1X/gn0BDNS4VPQ6Bz1TNX/wB8Z6swriw6RSybFp16Dmio3p+Z50dJs65kT1NxEsB75O8EK3xS4UiCQEJ7eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9F343227AA8; Tue, 20 Jan 2026 08:26:38 +0100 (CET)
Date: Tue, 20 Jan 2026 08:26:38 +0100
From: Christoph Hellwig <hch@lst.de>
To: Dai Ngo <dai.ngo@oracle.com>
Cc: chuck.lever@oracle.com, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, tom@talpey.com, hch@lst.de,
	alex.aring@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSD: Enforce recall timeout for layout conflict
Message-ID: <20260120072638.GA6380@lst.de>
References: <20260119174737.3619599-1-dai.ngo@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119174737.3619599-1-dai.ngo@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 19, 2026 at 09:47:24AM -0800, Dai Ngo wrote:
> When a layout conflict triggers a recall, enforcing a timeout
> is necessary to prevent excessive nfsd threads from being tied
> up in __break_lease and ensure the server can continue servicing
> incoming requests efficiently.
> 
> This patch introduces two new functions in lease_manager_operations:
> 
> 1. lm_breaker_timedout: Invoked when a lease recall times out,
>    allowing the lease manager to take appropriate action.
> 
>    The NFSD lease manager uses this to handle layout recall
>    timeouts. If the layout type supports fencing, a fence
>    operation is issued to prevent the client from accessing
>    the block device.
> 
> 2. lm_need_to_retry: Invoked when there is a lease conflict.
>    This allows the lease manager to instruct __break_lease
>    to return an error to the caller, prompting a retry of
>    the conflicting operation.
> 
>    The NFSD lease manager uses this to avoid excessive nfsd
>    from being blocked in __break_lease, which could hinder
>    the server's ability to service incoming requests.
> 
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>

This looks reasonable to me, but I don't really feel confident
enough about the locks.c code that you should consider this a
review.


