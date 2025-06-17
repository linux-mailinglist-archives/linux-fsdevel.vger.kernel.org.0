Return-Path: <linux-fsdevel+bounces-51833-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 662E5ADC0E4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 06:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1456D16A858
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jun 2025 04:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0FF823B609;
	Tue, 17 Jun 2025 04:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qmY0Jt8Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF4E20297C;
	Tue, 17 Jun 2025 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750135025; cv=none; b=sw+d30zAo6hfsK0vpF2vhBWbMG3VGM+qqc0a+MVQg30i5C9A4NGFqEDo8f3uqgr+YXjEP584FOvMQiZJ74lVWz+laCdjijJz/nnAHZeox14sH7b8hAd5oZ9XVgvYMX7npzH3NHIh5EuDFEyAUa8b/QmYYIhS6Udf3G5bfwRuxfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750135025; c=relaxed/simple;
	bh=4Ap0FTrxAFUSBUQw14fr+2BkK/PM+PVKpjjbqIrGnz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CAjK74qHwvjzSVx2ALJxYkHXGNMIYIj5ZyGo4YRu2aEA+yliBYHcTlyn3cpDgIf/C/m65F1bun693z3wkAYjwscVUnPgt+BsSOJA895GXQ1GoW75CIinJtBwxASPtAZQud3H+Uw+Ppt224EwhvJM2sI7aJJIDrfoczHC2wT5Ma4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qmY0Jt8Y; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7i0c1GgBy5rS73Gz5YEPluflZTgX6Cm9Oozv7odL4Ow=; b=qmY0Jt8YKSbArZsVuF4IAnEHD1
	iac9zd03ob11Sjg/YPQn3Ue/AodgaLGz9YKoUmiXf9KLcWg3rqQLP/EQVv56ry8TWfZC1qTnkFG8N
	O3ED+rHo51tqEB60feC1UlYBirOuuUy91B6MmlxLzSzsjot94p5KnVXq4vifBUzz0cAIqRRwdMVTl
	OTQ8u2cQ/yzdMLRD8JqZqGM2kNK9C0t98mc4yeiYg5Boh28x1v0cLH3RgxFUN3CLBQgWxZBTNbDsP
	nbz6bcjKxz4+yex3xAudL92PZix2mWc2Cyzc3sI+RMRVx0oPpUtHhoNKve2kw+H9dmvFidYNeBsYr
	fPm5SZtA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRO4D-00000006Avl-3KRY;
	Tue, 17 Jun 2025 04:37:01 +0000
Date: Mon, 16 Jun 2025 21:37:01 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Layton <jlayton@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
	david.flynn@hammerspace.com
Subject: Re: need SUNRPC TCP to receive into aligned pages [was: Re: [PATCH
 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE for all IO]
Message-ID: <aFDw7QTtvJOxEg-o@infradead.org>
References: <aEnWhlXjzOmRfCJf@kernel.org>
 <7c48e17c4b575375069a4bd965f346499e66ac3a.camel@kernel.org>
 <aEn2-mYA3VDv-vB8@kernel.org>
 <110c7644b829ce158680979e6cd358193ea3f52b.camel@kernel.org>
 <d13ef7d6-0040-40ac-9761-922a1ec5d911@oracle.com>
 <f201c16677525288597becfd904d873931092cea.camel@kernel.org>
 <aEu7GSa7HRNNVJVA@infradead.org>
 <aEvuJP7_xhVk5R4S@kernel.org>
 <aFAOLAOsWngZV_aL@infradead.org>
 <aFBBToft6H-r51TH@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFBBToft6H-r51TH@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 16, 2025 at 12:07:42PM -0400, Mike Snitzer wrote:
> But that's OK... my test bdev is a bad example (archaic VMware vSphere
> provided SCSI device): it doesn't reflect expected modern hardware.
> 
> But I just slapped together a test pmem blockdevice (memory backed,
> using memmap=6G!18G) and it too has dma_alignment=511

That's the block layer default when not overriden by the driver, I guess
pmem folks didn't are enough.  I suspect it should not have any
alignment requirements at all.

> I'd like NFSD to be able to know if its bvec is dma-aligned, before
> issuing DIO writes to underlying XFS.  AFAIK I can do that simply by
> checking the STATX_DIOALIGN provided dio_mem_align...

Exactly.


