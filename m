Return-Path: <linux-fsdevel+bounces-58844-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E23B320CE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 18:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2F3188F747
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Aug 2025 16:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF9193126D6;
	Fri, 22 Aug 2025 16:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KL7tIz7h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E965302740;
	Fri, 22 Aug 2025 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755881477; cv=none; b=AS8A2NEW7c0HHdoBxeJkeX5jwR2TdzmIi3xNLgn4NO56wkLTWwd2AZaUJkJKcGpEta58Gv5vd2d2zCrgKmAqGI1/wYy79J6AHwmmTY8ljJ2/7+pCJ/c2IEhQim+3lAlvjkylex40Ywh+9dQKzGNqJmv9Z2okHXyrXLSztCLMpYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755881477; c=relaxed/simple;
	bh=uRry2CIjiEcSnH960J5NOlseuN3XmHmd33F+6CJVqvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=drbECsiyi3WWLKP35qONNuHxZySbm49Jzesug20nxkdnTScyPgaitbT6YiAorF9egitiACM005+g+OmoO8nzHlmLtz3SGaqk4HA9Y2O8FTevN8GSOeOwfQajElxAmig+ebzK6df4nyQIEX8wJ8vjlB2LnJh864zp6k6tR4rOKJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KL7tIz7h; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uxEENz6oloxCKZRngq4FPRiV3fTmt3ZU4b9lbdy3wsg=; b=KL7tIz7huO8uK1YpoFS4ymVYyR
	KsSQtjYru7NLpH+XFf79/YtiSt8kC61NQr0ImRB1oJoD1t446+EPpLqf5MZY1pQcVbnZ/HNwPLpKF
	znai4LW1Zcd5wIB4qDUTB2jr/1ReCzGbQ/xci1g2jWAesh+2vTr+7F6LIfS5j7TB2juhkFpxno/Pq
	S/2TXhlaehldPbDMUDkRMm7Nx3rwxO8ztyBlrihHQ5gpSGO57cNDhqICNMtdK3v9uQSCyycB4HpaS
	5w7bxfrQZ8HUUWJ73o9JoIMjQxsggWEcpILvVWJBerIIhKHyjJPKzMbmQt+dFGbiXGmC/i8+wEkam
	TKprpMfg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1upUyu-0000000AHKJ-0Qo7;
	Fri, 22 Aug 2025 16:51:12 +0000
Date: Fri, 22 Aug 2025 17:51:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>,
	Fengnan Chang <changfengnan@bytedance.com>, brauner@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH] iomap: allow iomap using the per-cpu bio cache
Message-ID: <aKif_644529sRXhN@casper.infradead.org>
References: <20250822082606.66375-1-changfengnan@bytedance.com>
 <20250822150550.GP7942@frogsfrogsfrogs>
 <aKiP966iRv5gEBwm@casper.infradead.org>
 <877byv9w6z.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877byv9w6z.fsf@gmail.com>

On Fri, Aug 22, 2025 at 09:37:32PM +0530, Ritesh Harjani wrote:
> Matthew Wilcox <willy@infradead.org> writes:
> > On Fri, Aug 22, 2025 at 08:05:50AM -0700, Darrick J. Wong wrote:
> >> Is there a reason /not/ to use the per-cpu bio cache unconditionally?
> >
> > AIUI it's not safe because completions might happen on a different CPU
> > from the submission.
> 
> At max the bio de-queued from cpu X can be returned to cpu Y cache, this
> shouldn't be unsafe right? e.g. bio_put_percpu_cache(). 
> Not optimal for performance though.
> 
> Also even for io-uring the IRQ completions (non-polling requests) can
> get routed to a different cpu then the submitting cpu, correct?
> Then the completions (bio completion processing) are handled via IPIs on
> the submtting cpu or based on the cache topology, right?
> 
> > At least, there's nowhere that sets REQ_ALLOC_CACHE unconditionally.
> >
> > This could do with some better documentation ..
> 
> Agreed. Looking at the history this got added for polling mode first but
> later got enabled for even irq driven io-uring rw requests [1]. So it
> make sense to understand if this can be added unconditionally for DIO
> requests or not.

So why does the flag now exist at all?  Why not use the cache
unconditionally?

