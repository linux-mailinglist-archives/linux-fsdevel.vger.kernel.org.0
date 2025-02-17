Return-Path: <linux-fsdevel+bounces-41898-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB0B5A38E47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 22:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FDC16940F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2025 21:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83861A5BAB;
	Mon, 17 Feb 2025 21:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="snooRglJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC43B224F0;
	Mon, 17 Feb 2025 21:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739828901; cv=none; b=Inb1Qgnfr8D+RirbR9EZz6/QxzxLvLUW1Kri48I1wC1AxbCxqF9K0rZI3sIdbmUD/E9kiaXUEcqWVJttjP4L4Se4Rmxg2fwVGjxkWcSwa92+BdpUrDvbVy8XqE5EsLPP04LoA8vZWF3A3pKwGPr8xfQDemjM5mkfvIwrpLPi/go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739828901; c=relaxed/simple;
	bh=RgjaW9KZfsFHs0K08NbQFi+UWnirt22cvev6NtWhgAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XayeM4pgVkRMj5WgZ40AFyi6JouGJN7ArtpWiRI6HKoVJYYp+iCaF8pu12FHfY5IOXsrk7a3zFOcYBW2OD5qPqvNx4DzL7kHAE7+T0AlpDuvz3Gzulme5avEbyzCrYazGWyWgBW8jM5xHWHpYK75G/l9yoUWoc/vILcL9rSn+40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=snooRglJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7NX9+n2GikSH7WhNZS96Bu/nUIoIDhQGpH/Y02dbejM=; b=snooRglJtwQHv417bt1phSz65b
	N76elZcvJqgT8oosuO+2D4h8/jCPZi0PhC50+Niyeys8XUm7Pp91NXE/1f0ZXWt7cRAkIU+IkvTNX
	72mWC4Lis0+zKg1DViNxHyhhc6VcxpTd0Y/x2Q8TutFFqUQed83I+gIlJUi8DqWzZuw/8wF8LbinP
	tBzMFM3QiCF3+I6AY0usGxmOhZfigRcF6BMaPrYs3QpbRkr+GF+M9unOy4k9XYMC9JIX5Ba/rKpSh
	I4xxjXatdAA+t2Sk0fRULHkEE1cb7U/KhAEU16RCMPN46RskRWKhGGzLa7HrcngU4ENOPd3+20zUP
	dfAKsyzQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tk8yK-00000001zNZ-38tF;
	Mon, 17 Feb 2025 21:48:12 +0000
Date: Mon, 17 Feb 2025 21:48:12 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hare@suse.de, dave@stgolabs.net, david@fromorbit.com, djwong@kernel.org,
	kbusch@kernel.org, john.g.garry@oracle.com, hch@lst.de,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com,
	Hannes Reinecke <hare@kernel.org>
Subject: Re: [PATCH v2 3/8] fs/mpage: avoid negative shift for large blocksize
Message-ID: <Z7OunAU1UW3IEbeN@casper.infradead.org>
References: <20250204231209.429356-1-mcgrof@kernel.org>
 <20250204231209.429356-4-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250204231209.429356-4-mcgrof@kernel.org>

On Tue, Feb 04, 2025 at 03:12:04PM -0800, Luis Chamberlain wrote:
> From: Hannes Reinecke <hare@kernel.org>
> 
> For large blocksizes the number of block bits is larger than PAGE_SHIFT,
> so use instead use folio_pos(folio) >> blkbits to calculate the sector

"so calculate the sector number from the byte offset instead"

> number. This is required to enable large folios with buffer-heads.
> 
> Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Hannes Reinecke <hare@kernel.org>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>

