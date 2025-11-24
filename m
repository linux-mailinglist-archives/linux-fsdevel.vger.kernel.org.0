Return-Path: <linux-fsdevel+bounces-69641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 01830C7F76A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 10:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C053E347105
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 09:05:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EF52F49EA;
	Mon, 24 Nov 2025 09:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jth+pbiK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18C87260D;
	Mon, 24 Nov 2025 09:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763975152; cv=none; b=dQ9RAt1OCwJsKgXJzBfbYsiXjjyh6LgEi/9WCP7J166m0dGdH9S52R6ZjbC+6mxIP1WwMjFwkYEPkfBeThDdyTUUZuvkZ1MBC7Ef/u1CLQ+iluVfzTpOx8qaMssGjLyhIeboz1FiCLvTzyt81HvKF/x/e7O3aoC9W+bWQbKVhDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763975152; c=relaxed/simple;
	bh=igpNggHLjat6VkcqnkhQ2+JHg8zdgs7JFd0aarYxg0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GlhjG07fV34LVwNmtIUcknl2L/M5XeeFOA3/TcB8CHSL5xkGsmeRiZIammviPwdg/AyuakJx+YeV4LBCMQDeepIrU9KG2k7JMu3WJVTIY0r4f+iDh4I7pYEkYSExGzE5lMxLQ0tVEpQ5x9p7sxmUatJYJWAKhdHm7THx+hTu4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jth+pbiK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ta3in+nZ0jcLh5+n6gKE3wiAJ+TnQJQrZa4m8Ta5yv8=; b=Jth+pbiKqkts57x866+EMNehsu
	FZ4vNXW0eYjR7Tn3gSfO+iM1aqnM0NNeHDt2HIxBZcPWCmz1WkEejPx8i7H1ibiGQ3PCYq9sQNqg8
	woV/KX2GeQW1Cuirw3R5mv742YCSLECy1G9x3zDplqwRZxCW9O37PEbqnjZIzwpeAVn4/QyW6W+te
	C4KIhbqbOlJXakVErk2IJwSJ5Yq6sRVEp6vKemwzwhrCAETI/8Hgva+DIwt5FdoGETXoObTD4fXSk
	mpapNlFhCL6MGkOWlf4glFiGhj4q/3tAaABW/cEFO3Tlpfta3J301Dl89/3igwkgFx7XhKOOqjv7k
	D8316xnw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNSW2-0000000BJGp-37YI;
	Mon, 24 Nov 2025 09:05:46 +0000
Date: Mon, 24 Nov 2025 01:05:46 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
	Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
	Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org
Subject: Re: calling into file systems directly from ->queue_rq, was Re:
 [PATCH V5 0/6] loop: improve loop aio perf by IOCB_NOWAIT
Message-ID: <aSQf6gMFzn-4ohrh@infradead.org>
References: <20251015110735.1361261-1-ming.lei@redhat.com>
 <aSP3SG_KaROJTBHx@infradead.org>
 <aSQfC2rzoCZcMfTH@fedora>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSQfC2rzoCZcMfTH@fedora>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Nov 24, 2025 at 05:02:03PM +0800, Ming Lei wrote:
> On Sun, Nov 23, 2025 at 10:12:24PM -0800, Christoph Hellwig wrote:
> > FYI, with this series I'm seeing somewhat frequent stack overflows when
> > using loop on top of XFS on top of stacked block devices.
> 
> Can you share your setting?
> 
> BTW, there are one followup fix:
> 
> https://lore.kernel.org/linux-block/20251120160722.3623884-1-ming.lei@redhat.com/
> 
> I just run 'xfstests -q quick' on loop on top of XFS on top of dm-stripe,
> not see stack overflow with the above fix against -next.

This was with a development tree with lots of local code.  So the
messages aren't applicable (and probably a hint I need to reduce my
stack usage).  The observations is that we now stack through from block
submission context into the file system write path, which is bad for a
lot of reasons.  journal_info being the most obvious one.

> > In other words:  I don't think issuing file system I/O from the
> > submission thread in loop can work, and we should drop this again.
> 
> I don't object to drop it one more time.
> 
> However, can we confirm if it is really a stack overflow because of
> calling into FS from ->queue_rq()?

Yes.

> If yes, it could be dead end to improve loop in this way, then I can give up.

I think calling directly into the lower file system without a context
switch is very problematic, so IMHO yes, it is a dead end.


