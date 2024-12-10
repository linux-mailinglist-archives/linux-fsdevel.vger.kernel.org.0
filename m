Return-Path: <linux-fsdevel+bounces-36914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE389EAF90
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7397016AC69
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C59722B8D7;
	Tue, 10 Dec 2024 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K48mnW+r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF8227561;
	Tue, 10 Dec 2024 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829080; cv=none; b=dYLPh6RlWkhWg2jDVrNetdzxycJNIOXV4XwKlr3c8pNU+nkiX2yVUbq4YiEJ0OTMh2W1xfganjmIwZfzDSaS2pDpkJEe49a45A/nD3TJVMPzA4FjrYl+5degpz54xzP87V8iK0NnV0T9o354R7rgYnPAewrt6NNk5Txfh50wFkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829080; c=relaxed/simple;
	bh=iLW6hTTHJgWBde6+7jTFJ09suumCOGuj4BpMGT9vrAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgdGAZW+wp9vj+d0Kr21ePw/mGVoRwl62f3vsgo9P052ecVpPxNumNp3euZ01XsigpTZ7KYn/NAZky7JUElwXoeWUuXDFCtmbIaj1l4xkIXW4v+waqsFrFwjp8wvEFZYa2wBclCqeakc6i/o/QtF0guptlGS3TxPlXqfteIHEPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K48mnW+r; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bUILBoZfromCihqyWRVaFv8ULn8h6kpUAYpKGdu84rM=; b=K48mnW+roZ/GELEyybAgqBD1qx
	oYj2TH3BIzwxc15/FkakkJvOEXqlzsyaOzUVd9sT2lPsKQGjyJDX2DRMyDtzl7sS3YolaWtiSxL+f
	7QvF6eDHgbzNaNo8vGJbxBzD8Ky8D4ioMYCrhDMjjdecVEB3Fp098IhH0751v3MEcbVjcnYAjpXPT
	O3w+LftlgHC8nvb7hvFRrIKnx3zpt+POL9Qz31DWYUyrbqXw43871bFZC2ruN/tjkjFRJN/y1Upb7
	bg11g9Yg3twpnr5zuA55y5R8ovfCbIepP9+Av10EbbYbDNf+Ba737Xc68gyUgjTrdW+TMO9swnauX
	my7EqP0A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKy94-0000000BGZ4-2pZe;
	Tue, 10 Dec 2024 11:11:14 +0000
Date: Tue, 10 Dec 2024 03:11:14 -0800
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>,
	"Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, clm@meta.com,
	linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCHSET v6 0/12] Uncached buffered IO
Message-ID: <Z1gh0lCqkCoUKHtC@infradead.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <e31a698c-09f0-c551-3dfe-646816905e65@gentwo.org>
 <668f271f-dc44-49e1-b8dc-08e65e1fec23@kernel.dk>
 <36599cce-42ba-ddfb-656f-162548fdb300@gentwo.org>
 <f70b7fa7-f88e-4692-ad07-c1da4aba9300@kernel.dk>
 <20241204055241.GA7820@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204055241.GA7820@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 03, 2024 at 09:52:41PM -0800, Darrick J. Wong wrote:
> <shrug> RWF_DONTCACHE, to match {I,DCACHE}_DONTCACHE ? ;)
> 
> They sound pretty similar ("load this so I can do something with it,
> evict it immediately if possible") though I wouldn't rely on people
> outside the kernel being familiar with the existing dontcaches.

FYI, another word for dontcache.  uncached just has too many conotations
in the kernel context.


