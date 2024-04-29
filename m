Return-Path: <linux-fsdevel+bounces-18054-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCC58B5077
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 07:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E3B71C219FD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 05:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D504ED524;
	Mon, 29 Apr 2024 05:07:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABB372;
	Mon, 29 Apr 2024 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714367254; cv=none; b=hpV7JfOaaVj9PBchEI1h3Ql++322SQNInrgcxpFY65zjl126a9mBRo2K0nwdejLmHqVTyMH5biHk9U64GueGFI8gOXfsFP0gNFbp0P8jTop4Tsm/c1wZv5f4xSo1jcSU9gIowtw8aL6jmsMzKphUmvAkcqLKzQVVQLGRrIzPe2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714367254; c=relaxed/simple;
	bh=kbn7PxVwurIVF4qAgP40Pzs1MIUTt8g+oieHBZuxykg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d3cWz1MLve6YxXj4PiafHt8tquXCsDmje4kQ81GKW7R7QV8juchHIlBEEoBLIlH304xG6Ja3aoJXm1veGA/MP8LFEIL7FliPoJE0hD2zKwYKZqEvhHPd1KoVYVaQIKrJiOT4OOFaNWBSzIOPuAKnQaRt79pV3VN9a+myn2T1A7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id B6225227A87; Mon, 29 Apr 2024 07:07:29 +0200 (CEST)
Date: Mon, 29 Apr 2024 07:07:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-btrfs@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/7] pktcdvd: sort set_blocksize() calls out
Message-ID: <20240429050729.GB32416@lst.de>
References: <20240427210920.GR2118490@ZenIV> <20240427211032.GB1495312@ZenIV>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240427211032.GB1495312@ZenIV>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Apr 27, 2024 at 10:10:32PM +0100, Al Viro wrote:
> 1) it doesn't make any sense to have ->open() call set_blocksize() on the
> device being opened - the caller will override that anyway.
> 
> 2) setting block size on underlying device, OTOH, ought to be done when
> we are opening it exclusive - i.e. as part of pkt_open_dev().  Having
> it done at setup time doesn't guarantee us anything about the state
> at the time we start talking to it.  Worse, if you happen to have
> the underlying device containing e.g. ext2 with 4Kb blocks that
> is currently mounted r/o, that set_blocksize() will confuse the hell
> out of filesystem.

I brought some of this before and didn't dare to touch it because I
have no way of testing this code.  The changes looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>

But I really wish we could find a dedicated tester for pktcdvd or
just drop this code..

