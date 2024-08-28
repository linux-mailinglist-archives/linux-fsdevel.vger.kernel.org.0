Return-Path: <linux-fsdevel+bounces-27519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB173961DC5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 06:53:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5981284629
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2024 04:53:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6969814A4DD;
	Wed, 28 Aug 2024 04:52:58 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39150145FFF;
	Wed, 28 Aug 2024 04:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724820778; cv=none; b=js31nkh5vMpLk/vjX1/WcnT/BksfR8rieSyApYrEh96pA/Npmi3H4lC9h4XRSH6MyahwgH1N3q+a1i7FRVvpRjHXFIjM+GJEuuNdogVxrJMDXaiBpFiAjVqdzqux1Pj6W0C2W42kVuXqYuA7Fz+mAqwr03CkJyQcqPdrPkz85Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724820778; c=relaxed/simple;
	bh=XdRMWpI7VfLF8kAv/SP9cCPhoRpzJ6x/21suRcCEvmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2PWyqoWsllu30PF5XO/lUbET9xoTY8kWmwSR+IPIhZu07HH1u0CjLizVF29RWzvTyytVGuRTQrOYFdNhKuXEOg8Vt3Yvlx0yVI3P9LYXTGAReFuSCKINmdBtdepxcd6BJvw86jFvaKLCAoZLu6cDFlXDY5ZGfTIbBkA51ryGMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6AF7F68B05; Wed, 28 Aug 2024 06:52:53 +0200 (CEST)
Date: Wed, 28 Aug 2024 06:52:52 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Christian Brauner <brauner@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 06/10] iomap: remove the
 iomap_file_buffered_write_punch_delalloc return value
Message-ID: <20240828045252.GD31463@lst.de>
References: <20240827051028.1751933-1-hch@lst.de> <20240827051028.1751933-7-hch@lst.de> <20240827163613.GA865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827163613.GA865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Aug 27, 2024 at 09:36:13AM -0700, Darrick J. Wong wrote:
> > 
> > As the only instance of ->punch never returns an error, an such an error
> > would be fatal anyway remove the entire error propagation and don't
> > return an error code from iomap_file_buffered_write_punch_delalloc.
> 
> Not sure I like this one -- if the ->iomap_begin method returns some
> weird error to iomap_seek_{data,hole}, then I think we'd at least want
> to complain about that?

iomap_file_buffered_write_punch_delalloc never calls into
iomap_seek_{data,hole} and thus ->iomap_begin.  It just uses the lower
level mapping_seek_hole_data that checks dirty state, and that always
returns either an offset or -ENXIO, which is a special signal and not
an error.

> Though I guess we're punching delalloc mappings for a failed pagecache
> write, so we've already got ourselves a juicy EIO to throw up to the
> application so maybe it's fine not to bother with the error recovery
> erroring out.  Right?

But that is true as well.


