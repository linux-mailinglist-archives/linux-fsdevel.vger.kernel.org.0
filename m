Return-Path: <linux-fsdevel+bounces-51417-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870F9AD68FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 223387ADC34
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7782C20FA84;
	Thu, 12 Jun 2025 07:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="4ekjrKND"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB071E5B8A;
	Thu, 12 Jun 2025 07:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713157; cv=none; b=aeyZp6mGMo7W1WVWv24+Y5FleQwpz9CxAE/5MxQ9xymoYhmv0uA8NyY9EFwA8Lq8eRjus6lYkiupwjbv+bzl/YTroOrC06vFMci+0ZvffBadPzhCkSxTBz1ETuaxZxqIJt/EjBmhG0C3LI7hlr4AmWdhP3jN2FkMitvsGQIpf5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713157; c=relaxed/simple;
	bh=yPLDwAlq3Rj+1DtumRTM3W/4qMHMv/DeCHQj0Q6H5E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmyvmUlOuuMvPVIC2RmL//fuN+plwvk+477lqKF7DTnbH3uG9aUprPgp0r1PkTSw7cKubUob/K35Oxgf75e+Z+g7yxFoDqskE9hLaQYy1VSZcyKWZ0C/sXzxL/WsD581OOvebap3m8x36MINKoTqgC2xogWvwVXub17VNBni90g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=4ekjrKND; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5agKR/rSrFv1hhjzF+ZeVAhyoX35rJp4gSrzaIIVwRo=; b=4ekjrKND1HjBw8YNFj8xFny6pS
	Yis+wWdi9Q672+YKEvb78sezBoHygBTF6RIHDaQRbGDnL99XqmjUTTs0HSRrs7El313reiJe9w+5F
	/zFRJ+PrQFM6YMcis+EA45df7iK/VUlWQn/4sWoNuc6iqdzqzdikoEJ8CtmOVNo+jsR1hvt84vppO
	fAsgoyKdni5PBCznLnl1eSufuZ2EWccsN1wxh4oFxlGCQrHE5qiLiNHSx6xJyehw26aQyqQ2Fm0MI
	axBMFd6cuHGVcA5PTTiqmSJzWrd+MSz2tPE2BgPMuBRtdIxX0iqBwYKWNrDB6HlL8odpD2JIHldVv
	G6QmYgbg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPcJw-0000000CRWr-0T6R;
	Thu, 12 Jun 2025 07:25:56 +0000
Date: Thu, 12 Jun 2025 00:25:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEqBBLe0gi8w_VEl@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <36698c20-599a-4968-a06c-310204474fe8@oracle.com>
 <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 11:07:20AM -0400, Jeff Layton wrote:
> > write data at least until the client sends a COMMIT. Otherwise the
> > server will have to convert all UNSTABLE writes to FILE_SYNC writes,
> > and that can have performance implications.
> > 
> 
> If we're doing synchronous, direct I/O writes then why not just respond
> with FILE_SYNC? The write should be on the platter by the time it
> returns.

Only if you do O_DSYNC writes.  Which are painfully slow for lots of
configurations.  Otherwise you still need to issue an fdatasync.

But can you help me refreshing why UNSTABLE semantics require having
the data in the page cache?


