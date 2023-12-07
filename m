Return-Path: <linux-fsdevel+bounces-5201-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DAA29809280
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 21:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FFE01F211BE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F27757300
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 20:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OtQluZGX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB3FB10EF;
	Thu,  7 Dec 2023 12:09:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UfGaLfZYJj6lsws6XmqCysFAN6nlJ24xLl/Aq/2K4dM=; b=OtQluZGXuAaSUJzLZzAFOV08NY
	k1D7dSm+Y5+9FSb3kakZSPvNtfO3iemo1fmrona9PBir1Kw8aZUJ/uvvSP5o5G4+ueIZmTlEXm407
	hm55fLtch57THR6RAUI/ol50DEM35rTIZ6S9C/YCKosSxko7mFi1uHi0eRwIoNtYW+sjY7AsnVOui
	avwuiX54c1YLO3pDMiDzNAKMv5eDGF+sQO6TSsJUN4014BcbiLGIS6kPozrt8usZDKdjr3Vxb1Wp8
	j1eBC76TnnyZ5q8y4zg/orfcE9fd0jAEwSE0yVk2B/MIQP/M3UGjw0UowL2NUOFB73bI9OCkjLhfx
	EJl+d/5Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBKg9-004Jbe-6h; Thu, 07 Dec 2023 20:09:01 +0000
Date: Thu, 7 Dec 2023 20:09:01 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: Re: [PATCH 2/3] block: Rework bio_for_each_folio_all(), add
 bio_for_each_folio()
Message-ID: <ZXImXVPxeWTwDlNK@casper.infradead.org>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231122232818.178256-2-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122232818.178256-2-kent.overstreet@linux.dev>

On Wed, Nov 22, 2023 at 06:28:14PM -0500, Kent Overstreet wrote:
> This reimplements bio_for_each_folio_all() on top of the newly-reworked
> bvec_iter_all, and adds a new common helper biovec_to_foliovec() for
> both bio_for_each_folio_all() and bio_for_each_folio().

Something that annoys me about this is that for BIOs which contain
multiple folios, we end up calling compound_head() on each folio instead
of once per bio_vec.  Not sure if there's a way to avoid that ...

