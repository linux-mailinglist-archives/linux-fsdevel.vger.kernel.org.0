Return-Path: <linux-fsdevel+bounces-73456-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45BB0D1A0B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AB22302AFFE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 15:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B1B340D98;
	Tue, 13 Jan 2026 15:58:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DF2AD5A;
	Tue, 13 Jan 2026 15:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319890; cv=none; b=EjmoKcPzxMNBdpNS9NBKQVsHtn8sizsB5x2ayshjyggdplqBVkCaGlOyiqZvqIUAcz2LRW1D9AIyXFPcSDnRFzCPrYpwih1vVOTXvm51MxhK0xypMbmQCJWd4j9m62JGdOLxGG8mQF3tqQMFJO4ziNx14ELFh7Y/VB2RduPiG6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319890; c=relaxed/simple;
	bh=STwS1iOUfZ7Lwx6nnQwadfZDFDVePAofhZgw553iIAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEfy1obLvMoaH+sHiHrdJ7L8ake5vqtr0qwanIMQR9hznBEdDfX1W2U5mJqfFgnEpK2Ji7t59tRdXhKPFDOn6aVIcsHiU4Y7B7sksIFyybXP6vcDAKyFX1UUf8pyKpVGBMnGju6A1pI8+x5UMsxWhAZeolgGlGVHfSBoDE6pIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id CA716227AA8; Tue, 13 Jan 2026 16:58:05 +0100 (CET)
Date: Tue, 13 Jan 2026 16:58:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, brauner@kernel.org, bfoster@redhat.com,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: wait for batched folios to be stable in
 __iomap_get_folio
Message-ID: <20260113155805.GA3726@lst.de>
References: <20260113153943.3323869-1-hch@lst.de> <20260113154855.GH15583@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113154855.GH15583@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 07:48:55AM -0800, Darrick J. Wong wrote:
> I wonder if we ought to have a filemap_fbatch_next() that would take
> care of the relocking, revalidation, and stabilization... but this spot
> fix is good as-is.

Let's wait until we have another user or two.  Premature refactoring
tends to backfire.


