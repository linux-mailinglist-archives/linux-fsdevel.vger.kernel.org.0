Return-Path: <linux-fsdevel+bounces-57442-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 104CDB21853
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 00:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2234646371D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Aug 2025 22:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 625A92E2F16;
	Mon, 11 Aug 2025 22:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V5wMDi/g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B73B1D61B7;
	Mon, 11 Aug 2025 22:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951042; cv=none; b=YjO9fdhwn2JWH4TmcaNHzjxGcJ3HnCyjbLvW+ukLES4fKI74rrOy9DM2nAw3tbN3+y5LcY+eYeUjESmZG4BB3GVDh/aAsIq59f1Jeurtuk1JtN3sOmGG42SaTflRGg5V3hvi+dZmSqQEzbbQZn/FI18NzIlmxHqy5B+fjIgxu5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951042; c=relaxed/simple;
	bh=98ykCNdNjNFSoyI0ITIiZdyle5+j2R/y/7umcgQAvy8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQbciifF70ohsbWyFgBT0EmWxuor2AZB0W+51z+nrk0+wo8uvCANv25UhkWzlMEpTatR8/h++CzyZNA64m1TXPrLxjyuYiNyr8LDKAHgGaJnZKasb0T+gR47U9HE1slZljpDF0lGQF2oJ16ulAeXes9AUcV0N9JtYQCB1hS5/xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V5wMDi/g; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NlAqg/7Oyr3wS5iGZ4uIxYUTz0VW9QeMIoSSCMaE47E=; b=V5wMDi/g0idtCjGqzjARU+zjAH
	srv3bOvcej/mmYohat69G7az4oakF3m++wuqOaKwBLXCs0ItnZtnzW80gINoDcFuaFFbwI6XkmSbk
	KKN3IdYiJhc+wO51oWdsMmLNnehAVDKYOFc5X0pNHEZjxhk1PFJhDLlopQgyg6WrD/9Of/GKOF0Ly
	o/KJ4qpM54eRhtevG8CNdcdzcNUYQ557Q7qMS5fTqd9+mX45yU+LWzRzsoBydFFSjNzYOr703QH7S
	AO5vu+yh9UXsIH1zrVBLsuQqgXGi0AvWCIF4+zCbgMd6qTAOx+wJ0jd5nuB+LMHKuRDQwK7n/tpJ1
	w1t8wBhg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulavv-0000000A3EA-0fw7;
	Mon, 11 Aug 2025 22:23:59 +0000
Date: Mon, 11 Aug 2025 23:23:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: Hans de Goede <hansg@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vboxsf: Convert vboxsf_write_end() to use
 kmap_local_folio()
Message-ID: <aJptfu79PV4TaCq3@casper.infradead.org>
References: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250811-vboxsf_folio-v1-1-fe31a8b37115@columbia.edu>

On Mon, Aug 11, 2025 at 05:42:00PM -0400, Tal Zussman wrote:
> Now that vboxsf_write_end() takes a folio, convert the kmap() call to
> kmap_local_folio(). This removes two instances of &folio->page as
> well.

Oh; something I should have said.  If you have an interest in vboxsf,
it looks like there's a communication protocol that lets you pass in a
physical address and length rather than a virtual address and length.
Redesigning the Linux driver to use that would be a big win and we could
drop the kmap calls entirely.

