Return-Path: <linux-fsdevel+bounces-17812-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C39A8B2720
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 19:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDB71C22665
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Apr 2024 17:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEEB914EC55;
	Thu, 25 Apr 2024 17:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uBf7vaIN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8451A14D6F1;
	Thu, 25 Apr 2024 17:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064693; cv=none; b=CFTcy0zGEU2xZDPVDioLqRBUkPKh2jwO3dAji/GOsRCrG0ZI8o8SIzIeO5n5CjeE+2X7UXikoW1dut4rFqATmWGuQCkhvZCDHN0oXgMxO6MyXrUHmYhbZojFXUHbGrgW+KxC7YucghJPFryDnE7bw301Pvhz30uCGOAkI9zxDro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064693; c=relaxed/simple;
	bh=4V+nwQ62yoOaniGzfu6EhpUzGiATL26RVF2l6yZTAjk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktzAzbwZGcPQhWwPpYBITZlClE12LcW/26g9FkUgRP15JEa5Cgs6rYwKjy4zeW0JYG22OCmNUKytPR3HhkqhsjZiNURFlgP15npzVgAeJi+CGkuBiD5MIFYjiB61GnwXmjcKDcgUukoPiFg8T1aZgX42QtlCFhjaRRdMuZJzqoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uBf7vaIN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZC3pg5ImZ5cpQcMeqKjqfQ5Go+U+qRekmVjKTp+jCBA=; b=uBf7vaINTqulMQSoR6jlevtP6X
	t0HEUh+4AuUZ+92586alWwxA8tRgGJ2r6xSv+hQr2zHPA627RNj9nOfQ3uMWHU8uDzB2AfcaMXa1m
	CiQuKncJo60jXO/7ScXBcZiX0sHLPaXIVDpY2QRjt+mnd4TopPNq9H6yBtUeyNexWX3sZ8uUHHpEI
	tim9gLbvjUbdk8IQKxxTl33x2qKno+oUXYu7J/PHEf0j+KujYGslbW1ryTFHN1i2ui6PZjqCXfBfy
	oiP/DFQ8LKwWrFMRFJfLoJAQa/maidtdv4hbK2OqSHbE1iqYzgcM6F+LWjaYVSObBv74B1o/9grs7
	tZdCOogw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s02We-00000003R0o-0mco;
	Thu, 25 Apr 2024 17:04:48 +0000
Date: Thu, 25 Apr 2024 18:04:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jeongjun Park <aha310510@gmail.com>
Cc: brauner@kernel.org, jfs-discussion@lists.sourceforge.net,
	jlayton@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, shaggy@kernel.org,
	syzbot+241c815bda521982cb49@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] jfs: Fix array-index-out-of-bounds in diFree
Message-ID: <ZiqNMLWFIvf43Mr-@casper.infradead.org>
References: <Zipl4PQ9Q7sBlMCt@casper.infradead.org>
 <20240425142434.47481-1-aha310510@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425142434.47481-1-aha310510@gmail.com>

On Thu, Apr 25, 2024 at 11:24:34PM +0900, Jeongjun Park wrote:
> Matthew Wilcox wrote:
> > It should be checked earlier than this.  There's this code in
> > dbMount().  Why isn't this catching it?
> 
> This vulnerability occurs because a very large value can be passed 
> to iagp->agstart. So that code doesn't prevent the vulnerability.

In your earlier mail, you said the large value was found in db_agl2size.
If the problem is in agstart then diRead() is the right place to check it.

