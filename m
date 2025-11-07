Return-Path: <linux-fsdevel+bounces-67431-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 52981C3FDB5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 13:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3A7D34D765
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 12:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAA4327210;
	Fri,  7 Nov 2025 12:11:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C3A92DEA8C;
	Fri,  7 Nov 2025 12:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762517464; cv=none; b=COs6jWerBSkQPiE2pXm6Yqcw7jGjSTMKeO86VscZKKL/iq0h+euSzYZvejighJScj2dCpZErOddkIoUxSVyU97+Dk41CXAL9TrdOCrAmimwoEV/7blS5njnyiD3Qfa/Tr7+G2AEORnPWXuPi1615sE8ysV9IXbkWyZ6uMwBNc+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762517464; c=relaxed/simple;
	bh=Fnd/SIeh34D7h9LeaF0Ne1nbwIrfrrfk2p76HHV7aIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UF8KIXd+Y5ic/nRc87irpB6mDDot8RohZsz1R4axe8hyJU5Pziah5AB6qCiYs9sYB9UCJxFyE+EWA2uCvPzcSyPpCAX/vDsonFYQBIBBSbY4PEXzekbPD3kkylHsxfHMjoNLKqI1OqG+21TS7vVcchqFSBMetau+Lqi57VSQI/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 678C4227AAE; Fri,  7 Nov 2025 13:10:56 +0100 (CET)
Date: Fri, 7 Nov 2025 13:10:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry.yoo@oracle.com>, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 8/9] blk-crypto: use on-stack skciphers for fallback
 en/decryption
Message-ID: <20251107121056.GF30551@lst.de>
References: <20251031093517.1603379-1-hch@lst.de> <20251031093517.1603379-9-hch@lst.de> <20251107041859.GD47797@sol>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107041859.GD47797@sol>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 06, 2025 at 08:18:59PM -0800, Eric Biggers wrote:
> On Fri, Oct 31, 2025 at 10:34:38AM +0100, Christoph Hellwig wrote:
> > Allocating a skcipher dynamically can deadlock or cause unexpected
> > I/O failures when called from writeback context.  Sidestep the
> > allocation by using on-stack skciphers, similar to what the non
> > blk-crypto fscrypt already does.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> It might be worth leaving a note in the commit message that this also
> drops the incomplete support for asynchronous algorithms.  ("Incomplete"
> in the sense that they could be used, but only synchronously.)

sure.

> Also note that with asynchronous algorithms no being longer supported,
> the code can actually be simplified further because the
> DECLARE_CRYPTO_WAIT(wait) objects are no longer necessary.  The sequence
> of crypto_sync_skcipher calls that is used should be similar to what
> fscrypt_crypt_data_unit() does.

Ok.


