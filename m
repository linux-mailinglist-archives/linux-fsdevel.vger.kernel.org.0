Return-Path: <linux-fsdevel+bounces-40473-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D39A23A6B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 09:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90561889B98
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jan 2025 08:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051215C15F;
	Fri, 31 Jan 2025 08:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Rx0n9vOb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5292C14A4C7;
	Fri, 31 Jan 2025 08:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310885; cv=none; b=PP1H3uLpBEyKoZRMHQcaCsbFjTAlL4hvI2ScEylsNz1yKuSYbZX7ghOxb3C6HXIiEymjwCP/bFS5UqYWdChKxXy1wh4VaBDYg/RafU6KPwMzFBzQSgsHd/EVI0/UMb5fX5gZG8A9o7i4sQ7zCaV4XkX3Yl1ogKakf+A0X6GiOAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310885; c=relaxed/simple;
	bh=j9qvXuG4t86XTJcNjP07aWnmSwBG3S1hrHy0W86xPBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3XGu3qg3ez5vvyglGdPZIdyF9jbORSRxWicLOBzAxqTMnCJYmPyfoPgKOiJhv+NMHL9PVPtNKdnKMBecoXPJasr2bHv2Gw1famJ6z5dGhME2zAmv9+lHze1DwbM4G87w84biuTyHqr+42buNT7pIf6z1Plr/BCA4LhhLK122ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Rx0n9vOb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
	:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=h7N47XdlHE0sKxDi4QUVBUG9AOPefj4OEoAX8WEJ8Y0=; b=Rx0n9vObBXe8jOFhAhl0aLRBYy
	bKdfsEDY4gsVcA9CfvJB4PbmIAKXtgZEaafBkAXmhpqC939RbYoXzDvxGTTLHcP6B66ENdcrcvIBe
	Jwrun2LAYxrbf8LiqSouu6tQySdJLfM30uOpVpZNMX180AqSCF7HK45j7WCgNTYoOiXJrp5ficaKX
	t0drSYKF1p2ccoyHYsIIYXW7jWAg/xBy+r8ml/oigYC3FiZG1wP5ILIuUaYfrnEH2EacB3CwPu/44
	4+9b200ReX0m3qmY3lJ4aq8+mhVJHiohe1rhqFj9RsRO6+41t/5laO1iN8Mmq+VB/3kkIEKU6puNw
	X7wONttA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tdm4J-0000000AAUt-444q;
	Fri, 31 Jan 2025 08:08:03 +0000
Date: Fri, 31 Jan 2025 00:08:03 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 3/7] iomap: refactor iter and advance continuation
 logic
Message-ID: <Z5yE419RpS52yTbq@infradead.org>
References: <20250130170949.916098-1-bfoster@redhat.com>
 <20250130170949.916098-4-bfoster@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250130170949.916098-4-bfoster@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Jan 30, 2025 at 12:09:44PM -0500, Brian Foster wrote:
> In preparation for future changes and more generic use of
> iomap_iter_advance(), lift the high level iter continuation logic
> out of iomap_iter_advance() into the caller. Also add some comments
> and rework iomap_iter() to jump straight to ->iomap_begin() on the
> first iteration.

It took me a bit to reoncile the commit log with the changes.

What this does is:

 1) factor out a iomap_iter_reset_iomap caller from iomap_iter_advance
 2) pass an explicit count to iomap_iter_advance instead of derіving
    it from iter->processed inside of iomap_iter_advance
 3) only call iomap_iter_advance condititional on iter->iomap.length,
    and thus skipping the code that is now in iomap_iter_reset_iomap
    when iter->iomap.length is 0.

All this looks fine, although I wonder why we didn't do 3) before and
if there is a risk of a regression for some weird corner case.

I hate nitpicking too much, but maybe split the three steps into
separate patches so that 3) is clearly documented and can be bisected
if problems arise?


