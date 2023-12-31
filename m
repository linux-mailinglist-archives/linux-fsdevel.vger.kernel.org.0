Return-Path: <linux-fsdevel+bounces-7049-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8DC820E29
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 21:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECAF0282529
	for <lists+linux-fsdevel@lfdr.de>; Sun, 31 Dec 2023 20:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D527BE4D;
	Sun, 31 Dec 2023 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hbWqIqfv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C5C7BA2B;
	Sun, 31 Dec 2023 20:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=OBpnVhlNs2ssovfDtUSVXqlWqzvDlYhVgo5wBqppX0w=; b=hbWqIqfvraHATw/bQQnskCHNgG
	OwRbsDQXiI80s09hM7xdg1hwKfJF2ITc2QSz+EHCP4pj8rskFiyBAs8J1Bmdje4vjshlkvX3dy+do
	1O0bWUrkYVL9dhdpNLCiyVmsx2T9Q0Sp8ukb9gVkzJjdqZnkfGQw/7FVds1VVHtro7fpPiVZRG7vA
	zIBmeKgZ46Lg5438e0sjgpcbt3B0WAuuMyoJpHvjZ5+BABVstjUR/imy2xVir7hf/TxenFUgeo4iF
	yflGzup5Vnup1HoARpBkw61c4ncEtKjF3uEafT91NGfjVR4TWndsFSI7PeDsxAOr/0sit2+uDdVlB
	UF1Q1iAw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rK2tg-00843F-Cj; Sun, 31 Dec 2023 20:59:00 +0000
Date: Sun, 31 Dec 2023 20:59:00 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Genes Lists <lists@sapience.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Message-ID: <ZZHWFOJln4I1A0sd@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>

On Sat, Dec 30, 2023 at 10:23:26AM -0500, Genes Lists wrote:
> Apologies in advance, but I cannot git bisect this since machine was
> running for 10 days on 6.6.8 before this happened.

This problem simply doesn't make sense.  There's just no way we shoud be
able to get a not-uptodate folio into the page tables.  We do have one
pending patch which fixes a situation in which we can get some very
odd-looking situations due to reusing a page which has been freed.
I appreciate your ability to reproduce this is likely nil, but if you
could add

https://lore.kernel.org/all/20231220214715.912B4C433CA@smtp.kernel.org/

to your kernel, it might make things more stable for you.


