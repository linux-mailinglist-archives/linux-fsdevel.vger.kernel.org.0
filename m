Return-Path: <linux-fsdevel+bounces-26658-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4533E95AC35
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 05:43:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C52C1B21D7B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F952E630;
	Thu, 22 Aug 2024 03:42:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC347134A0;
	Thu, 22 Aug 2024 03:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298173; cv=none; b=dWBhoSt6zgnWvYQDwXWyjW/KzVCJz3djLknIB9DXsOxyLmeNb8X9HLnsb2x5FaKw1aCtDAeXE3kdj4xSylm3D1V8IP37VMpVfJw4GdnF7+8x0iX9IX7z/3eFvWSBL5wdURXaFIY1UgxUgAf2V9+YfvW07OfCYrlK+W2II8nyMpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298173; c=relaxed/simple;
	bh=yUEHfyDLaWiZTw8amaEl28tKAAKHeLjHIGVqB9ST+nI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hWoJrVcCCuY/j0Sw2jI2JPsCh3Wv1goV6qLZr0XSBW73IgJch0dMQBdK0jom0uNMOd7o7PZhooIo7WhY46X5DPAKPLFenaV0seM6eeET0AVeJ9rsSok12bXP2DRmnGH68QYFgD4B2PTwtRbgBYNGFJ0J2ks2aB1eM6cBaNXmVsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7FE51227A8E; Thu, 22 Aug 2024 05:42:48 +0200 (CEST)
Date: Thu, 22 Aug 2024 05:42:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/5] xfs: use kfree_rcu_mightsleep to free the perag
 structures
Message-ID: <20240822034248.GC32681@lst.de>
References: <20240821063901.650776-1-hch@lst.de> <20240821063901.650776-2-hch@lst.de> <20240821161939.GC865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821161939.GC865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 21, 2024 at 09:19:39AM -0700, Darrick J. Wong wrote:
> I started wondering, have you seen any complaints from might_sleep when
> freeing pags after a failed growfs?

No, why would I?  We're not freeing perags with a spinlock held there.

> Then I wondered if growfs_data
> could actually take any locks that would prevent sleeping, which led me
> to another question: why do growfs_{data,log} hold m_growlock but
> growfs_rt doesn't?  Is that actually safe?

As far as I can tell growfs_rt is missing a m_growlock critical section
and right now we allow parallel calls to growfs_rt, which could lead
to unexpected results.


