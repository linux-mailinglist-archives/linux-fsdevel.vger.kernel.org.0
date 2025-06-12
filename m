Return-Path: <linux-fsdevel+bounces-51418-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3162AD68FF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 09:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8016F17A271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Jun 2025 07:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 530D620E021;
	Thu, 12 Jun 2025 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="krhUYbK7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5B579E1;
	Thu, 12 Jun 2025 07:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749713323; cv=none; b=gj1ZxMDUriAQwuGUZp/BNTpDcd+9hk3LBGdbLa5LXnfgFHSxmu5K1PRIkTzzlYM9RjStpo+uVNkGV0vx7pN2xzdmhE5tlr0avwM0GwGIVjHiAvHI8T6tL4oAW6XwXi00VJn7SgeOpgiOSNlb+EA6VFHyHqzAdOGbTwyF+J8gDkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749713323; c=relaxed/simple;
	bh=a/bPi1YtHwCfXqHYoCe98m+B5lVIj/Mhel2rxTSMSz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nE/SlkKB2yEQXZLwoAhl8pr+lTbewz9ViAy6nhKRbkMAnSOvbueanVLRg3zurAueXRPEaqNpFDRnpad17+aSXWAuNZjnePIG5KY1Mz/wboRWOd4Hny9cF8fdL11I6Rc1G9JKSdkRAzUJz6aTLSQe/S/Gt+O/llQf7edWlbOT8g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=krhUYbK7; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mxyMsvPYel9EBjosZMr60a7+G5GuUxjrr6qQL5OAlgs=; b=krhUYbK7ZyNwiwf/Qxfi3yQlbL
	VpiNUSyEDV/yShEUkIQ6TeAp1f8U9ufOZIKqJIcgfZrQADtUZOkM53TPn9xEen7S9nIzDwxDhnUsD
	kCBJs4OyC1JS6wtJn+WR1EaSRvLUvpD9KzVyvcL8S8gZnjYmgrraaauzs8DeU5UYptGEzrHMnDZuN
	0V1Gm1oNWV9WqdvHDxsv0nQDbOnW4rwHSly+vVHHPHm9v0vP/7JCdqxTfcdI93tDevZWNUrZh39JT
	XvjpWlw5k+1umI3XsG3GnZEqUJaU6yEcSaAXEG1FSv0kffPAKdUkhwhUH1dlNwqThsiEKbmBMPVTw
	pr6oVAMw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPcMc-0000000CRjv-06Tw;
	Thu, 12 Jun 2025 07:28:42 +0000
Date: Thu, 12 Jun 2025 00:28:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Chuck Lever <chuck.lever@oracle.com>
Cc: Jeff Layton <jlayton@kernel.org>, Mike Snitzer <snitzer@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 5/6] NFSD: leverage DIO alignment to selectively issue
 O_DIRECT reads and writes
Message-ID: <aEqBqlLErTQ0ZNYZ@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-6-snitzer@kernel.org>
 <36698c20-599a-4968-a06c-310204474fe8@oracle.com>
 <21a1a0e28349824cc0a2937f719ec38d27089e3b.camel@kernel.org>
 <27bc1d2d-7cc8-449c-9e4c-3a515631fa87@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27bc1d2d-7cc8-449c-9e4c-3a515631fa87@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Jun 11, 2025 at 11:11:28AM -0400, Chuck Lever wrote:
> > If we're doing synchronous, direct I/O writes then why not just respond
> > with FILE_SYNC? The write should be on the platter by the time it
> > returns.
> 
> Because "platter". On some devices, writes are slow.
> 
> For some workloads, unstable is faster. I have an experimental series
> that makes NFSD convert all NFS WRITEs to FILE_SYNC. It was not an
> across the board win, even with an NVMe-backed file system.

For everything that is not a pure overwrite on a file system that passes
them through, and a device not having a volatile write cache FILE_SYNC
currently is slower.  That might change for file systems logging
synchronous writes (I'm playing with that for XFS a bit again), but even
then you only want to selectively do that when the client specifically
requests O_DSYNC semantics as you'd easily overwhelm the log and
introduce a log write amplification.


