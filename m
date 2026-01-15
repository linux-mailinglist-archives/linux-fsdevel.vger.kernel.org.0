Return-Path: <linux-fsdevel+bounces-74003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FF5D2834A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 20:47:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47087309BCBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jan 2026 19:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAC931A55B;
	Thu, 15 Jan 2026 19:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="evK83rBN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BDC2D47F4;
	Thu, 15 Jan 2026 19:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768506208; cv=none; b=O4aft43SUqahlm940noLg3nR3dICz5K+fyjBidxAaQmUbP5QTJgBPXPeruRbIvkkJqIIk5CYBUOa69GgzbJ7viQTXdLTjjyg3dJahgxObq7EcF2G5MNorBw88CRIt6BJF48S7j5yT/sEVTUzyxCPFQ5nPFA8WT7eqpFdLfFhsyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768506208; c=relaxed/simple;
	bh=J/i0zM4xYyjjZ4XNZu9Wcc/shtujryOp7RV0PnnL0h8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o4IvblmsVKT6v+oMQmrno4XbiF8Q7ceX2n3TM6UaUhCSsDeTBj42mxWqdnxGeEJiy1bxg01v/UG8GAZzsR6LxztcVEIu0IJ2VAXYTzPa7+ps2cbRCqbR4XB26hu21nHLu7dBBCWj6sNeclj4IN9/PU3yyllVZ9SpsZbCPCGXCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=evK83rBN; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=A23V1QRMEvs5cA8OvtUBzyK5zu+Y6qwqjP41AnCooiw=; b=evK83rBNBmurb078aDPg0RCpe5
	lBegr58Fcbk5MC+bakyDeXD3jhwiYBs8JKTAdfCioAd9gwHOydNi/1JhvqQ6xQSdWrncKN4rB+bfU
	mTNAnm6fdzc+68gQX5nqz5slJy7F8I+DUiA8XM7TB6135ZWJdNNtGLQ7ryIOGKlstTGrIkkyNH4ud
	hpVK8rQd1i63UxCsMT6n5ecuybCO+5+EmxNdKr1CdSzBPm4QXAjKo9lyvCuVY1N807YsGqpwTZJj6
	JJzlzjc17yVqocbJ2Q7Ymg52LUIeqNo0p6XKgkY+td698I58vUVYgy3gJ6Mnw8O+woybuwuV4TWOb
	VVFPcVwg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.99 #2 (Red Hat Linux))
	id 1vgTH0-00000002NbF-3BWn;
	Thu, 15 Jan 2026 19:44:50 +0000
Date: Thu, 15 Jan 2026 19:44:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: linux-mm@kvack.org, Vlastimil Babka <vbabka@suse.cz>,
	Harry Yoo <harry.yoo@oracle.com>, linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Mateusz Guzik <mguzik@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 00/15] kmem_cache instances with static storage
 duration
Message-ID: <20260115194450.GA3634291@ZenIV>
References: <20260110040217.1927971-1-viro@zeniv.linux.org.uk>
 <0727b5a1-078f-0055-fc52-61b80bc5d59e@gentwo.org>
 <20260115020850.GX3634291@ZenIV>
 <806cbde4-fc0b-7bf7-d22a-2205b46eaa96@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <806cbde4-fc0b-7bf7-d22a-2205b46eaa96@gentwo.org>
Sender: Al Viro <viro@ftp.linux.org.uk>

On Thu, Jan 15, 2026 at 11:10:00AM -0800, Christoph Lameter (Ampere) wrote:

> Internal functions exist in the slab allocator that do what you want if
> the opaqueness requirement is dropped. F.e. for the creation of kmalloc
> caches we use do_kmem_cache_create():

Yes, I know.  Do you really want to expose e.g. slab_caches and slab_mutex
to the rest of the kernel?  Surgery needed to have __kmem_cache_create()
do everything is not large - see the mm/slab_common.c parts in the first
two commits in this series.

