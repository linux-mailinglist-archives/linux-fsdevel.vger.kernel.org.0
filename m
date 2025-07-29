Return-Path: <linux-fsdevel+bounces-56269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80028B152ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 20:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C756E5A070C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jul 2025 18:38:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD44255E30;
	Tue, 29 Jul 2025 18:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HujKt5/o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5B2512D8;
	Tue, 29 Jul 2025 18:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753814307; cv=none; b=hzn7VgZHJf2G00sh9FQB3ZojcGwMvuXkwcxql9nsnq94JjQJjfjQMa2vnfO8TCKGLW5gEgsyQlgojO2o7foy+Rs1ORimU5J53t6q6cc+JPb+7vhaOk+cNlx7n6EbqA0paiIeS/xj/9gcUGFfOGRqYG3TtVkUVVMZQXMny9Eb4L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753814307; c=relaxed/simple;
	bh=zurAIv8QJCiY4sCrzsrfx3On7ABYVu1QaUaxnbJm7mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smNmssWX92dmAdaCmCPVNkBm+Hs/OmND9tdExkJh9lgaQVcE1LQ6WJPlyc1z2raUHDArLu9kUTIZNfx7YdZEePGxdYaBDEugX9B962XxK98VroHlNFTDVeajKZEzZaXKoqjEvvp/ZPLYgOqVoWcaMhr/GBswbV3x8qwKI01lBew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HujKt5/o; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rbTOQvtnp+cahdtxatioeM/MAABw3lsWvLX8gCzBEH4=; b=HujKt5/obGxAkpEGMebhaWNp8H
	4WC30uPMs0xPxHl3aOvQF6mCLuxzG9cWsIkyjGNMk22jOnyOQN6P2QNE/5QNGHPWx1tfJw72AH4uA
	bZKrLR2SaHv+Ndc3Ir9RS4TjkKXlBtc8pN9xV2igLOGvdgjD13UUvV7VNPKOcbg1HLPxPMX+D9L5e
	Mp3H+zB14bKjwfzV0+NuxL4cqCRfYmcSK5h+481GrCdkBY5GsvS6qXoAiFZRW1cTpZTNdLANpZTbu
	fVz9rtr9qaf6YViG8xaLQQ8QIahQ9p1434i8X2f9HuPkEuJUfLuBsmnFQGV7Oh3YHVYG3mMDf9a6J
	NNiCgFtA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugpDR-0000000GJKg-0L4w;
	Tue, 29 Jul 2025 18:38:21 +0000
Date: Tue, 29 Jul 2025 19:38:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tony Battersby <tonyb@cybernetics.com>
Cc: Song Liu <song@kernel.org>, Yu Kuai <yukuai3@huawei.com>,
	Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-raid@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iomap: align writeback to RAID stripe boundaries
Message-ID: <aIkVHBsC6M5ZHGzQ@casper.infradead.org>
References: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55deda1d-967d-4d68-a9ba-4d5139374a37@cybernetics.com>

On Tue, Jul 29, 2025 at 12:13:42PM -0400, Tony Battersby wrote:
> Improve writeback performance to RAID-4/5/6 by aligning writes to stripe
> boundaries.  This relies on io_opt being set to the stripe size (or
> a multiple) when BLK_FEAT_RAID_PARTIAL_STRIPES_EXPENSIVE is set.

When you say "aligning writes to stripe boundaries", what you actually
seem to be doing here is sending writes down once we hit a write stripe
boundary, instead of accumulating writes that cross stripe boundaries.
Do I understand correctly?

If so, the performance gain we see here is presumably from the DM/MD
driver not having to split bios that cross boundaries?

Further, wouldn't it be simpler to just put a new condition in
iomap_can_add_to_ioend() rather than turning iomap_add_to_ioend()
into a nested loop?


