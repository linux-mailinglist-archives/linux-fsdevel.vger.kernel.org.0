Return-Path: <linux-fsdevel+bounces-20396-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717378D2C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 07:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D8DC2895DD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 05:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D415B989;
	Wed, 29 May 2024 05:14:46 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039EA15B96D;
	Wed, 29 May 2024 05:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716959685; cv=none; b=b6CgSfhfI0QBcECY0AUmSuNevf3Qw+YR217xSPLsNn0d9QvXZYyp8Z849aMmgpOZGgAp0fcLMyTaEY/vTRclQ+bQaCFzNmmGi9iDXHdzL63MG4YvYVZGgtBc/QD0ndLu9E1ZtBol7QZQjFjCnlQVSa85pABhVZs7OSWhAspsvQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716959685; c=relaxed/simple;
	bh=7BxKPLj69rLkJmA+tbroh+IL3zyP9SfRKrG7EjrLKu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r3gcatQu9N7ajxQwMjTQbVMTwidHE8OP2njn+uGz2ATMG7OE+HAg8MWyshr4t4+PMAPFmhDRwjKnrmeDXzXngTXpBcKvHvhy3PLmTdw4KV6RV6FpupWsF5xDYc9zuNFr8sGG9xVxHHpK1p6yxkddklW7VZxtpwl1I2Zs2o0M38o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id D9EB968AFE; Wed, 29 May 2024 07:14:32 +0200 (CEST)
Date: Wed, 29 May 2024 07:14:32 +0200
From: Christoph Hellwig <hch@lst.de>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: support large folios for NFS
Message-ID: <20240529051432.GA15188@lst.de>
References: <20240527163616.1135968-1-hch@lst.de> <ZlZHNsejJkJNhKHR@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlZHNsejJkJNhKHR@casper.infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, May 28, 2024 at 10:05:58PM +0100, Matthew Wilcox wrote:
> On Mon, May 27, 2024 at 06:36:07PM +0200, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series adds large folio support to NFS, and almost doubles the
> > buffered write throughput from the previous bottleneck of ~2.5GB/s
> > (just like for other file systems).
> > 
> > The first patch is an old one from willy that I've updated very slightly.
> > Note that this update now requires the mapping_max_folio_size helper
> > merged into Linus' tree only a few minutes ago.
> 
> Kind of surprised this didn't fall over given the bugs I just sent a
> patch for ... misinterpreting the folio indices seems like it should
> have caused a failure in _some_ fstest.

I've run quite few tests with different NFS protocol versions, and there
were no new failures, and the existing one is a MM one also reproducible
with local XFS.  That's indeed a bit odd.

