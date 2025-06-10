Return-Path: <linux-fsdevel+bounces-51095-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C59AD2C61
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 06:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E0916ECA3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 04:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C74B725D20D;
	Tue, 10 Jun 2025 04:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KTjcCnwG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF4A184F;
	Tue, 10 Jun 2025 04:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749528194; cv=none; b=MZB73qO3G34T6V5G7niyaFbAmsZHAuwURZRrR4g6CK7UG/DJ2X8dfj9ZY5NcBBe5lcBtnAx1IQa/D0v4YvYMn8LWOQhq8LadokOb/X1brGAWAhrMqFMSthZlS2odR2suXo0zuq64Mk8GA6a1txO9+0lm9p98FXu9YO1QK6ArOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749528194; c=relaxed/simple;
	bh=kG0SdhxFyHxMdZIV24VdbiBMEajAnpezDv1r8LzVj4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJZe8+snMSbaFFLrpcmDB3hqQEMg44E/Ie6MgJJVRBr+PLGvwqXTP3+g4d81OTxwa0LiJFLeWdwNxgXZpaV64uAV4xNAG2e1XM3is4P0AeXdPuePQMFy7pBqm2n+t8cz+r/vwGu0e/upaTkIwLUc9XihpW8/hHfQ5TavrNzpA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=KTjcCnwG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=N4QrxRCcDLUTRh2vzj1HAwXbjFIiuLcEoWtCk7b5+hg=; b=KTjcCnwGHivyAUddbkygghACnN
	ztBlxRhmS8hY/IXz2c0v61VLQs38sJD51BYjFQZF0kcvXRiF/3Kge9pQBAMpk9AORCoyhh8hfJNyV
	CeQ4UgUj9FyQ9L2EY5X2Bttk3IiSI2bCWtRNNOW15GiMbjL50QL20HL6Sp6NmSFhIfn0od2NqYWaf
	8puU51qIkgfa/2g3P8RfpI+5Tmulo6cQoCKNUsxog05+aAZciKKR1BvohQTJ8zJL1gzSV0HZmezqh
	Znzg6gjg/sPb0QKPs3vzSbzjUcdR4E0YyNfiZRWqy6D7aejVBBc9aVX1GU8ikBQKI4F8GVXYlj/iI
	5hU9Ce6Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOqCe-00000005ipE-2D9s;
	Tue, 10 Jun 2025 04:03:12 +0000
Date: Mon, 9 Jun 2025 21:03:12 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, miklos@szeredi.hu,
	djwong@kernel.org, brauner@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	bernd.schubert@fastmail.fm, kernel-team@meta.com
Subject: Re: [PATCH v1 5/8] iomap: add iomap_writeback_dirty_folio()
Message-ID: <aEeugGsbNvNMZ8lS@infradead.org>
References: <20250606233803.1421259-1-joannelkoong@gmail.com>
 <20250606233803.1421259-6-joannelkoong@gmail.com>
 <aEZoau3AuwoeqQgu@infradead.org>
 <CAJnrk1ZT08U808k=4b23pKfXCub7wLv97feG_xbaJp81pBtdOQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJnrk1ZT08U808k=4b23pKfXCub7wLv97feG_xbaJp81pBtdOQ@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 09, 2025 at 04:30:14PM -0700, Joanne Koong wrote:
> > When writing this code I was under the impression that
> > folio_end_writeback needs to be called after unlocking the page.
> >
> > If that is not actually the case we can just move the unlocking into the
> > caller and make things a lot cleaner than the conditional locking
> > argument.
> 
> I don't think we can move this into the caller of ->writeback_folio()
> / ->map_blocks(). iomap does some preliminary optimization checking
> (eg skipping writing back truncated ranges) in
> iomap_writepage_handle_eof() which will unlock the folio if succesful
> and is called separately from those callbacks. As well it's not clear
> for the caller to know when the folio can be unlocked (eg if the range
> being written back / mapped is the last range in that folio).

Note that with caller I meant the immediate caller of
iomap_writepage_map, i.e. iomap_writepages only for the existing code
that needs the unlock, and your new iomap_writeback_dirty_folio
that doesn't.


