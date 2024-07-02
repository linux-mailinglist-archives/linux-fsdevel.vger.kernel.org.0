Return-Path: <linux-fsdevel+bounces-22961-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C22F9243EC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 18:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 297E61F22CFB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Jul 2024 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FED1BD50E;
	Tue,  2 Jul 2024 16:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gdEun3Yo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A5511BC08A;
	Tue,  2 Jul 2024 16:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719939020; cv=none; b=dKP/CfdY5wd+sCjAPZIONg/K+sQHx7KItLyOIF7DYZG6a9HK/VhqrQRL1vwLhtPDXaBoMioIjbNZSn2JPRTnZNNTK/xP4PnmLyfrzC5XUOJsoqWeD9mlyc24BY0OLfTkxpXo+L620yhl77R5KH2XTbQBwHNPpJl4172yZcqbHFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719939020; c=relaxed/simple;
	bh=NBU8FpE3Irj66yKw+4xwB67VdXxsBFU30+zKXbrRKJ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPnx4rlLgBgJZMufSulbt0a2nmbCTiKnKhvxZTMYH7AIkp9fHvedLb06Hh8xmOz6rc42D5hhVusuapoA78tIQ8jmlPOqDP6YmedM7Sud2bD1+u0niYNZbn468HeLQMMuaLGt4W6iZeiC0vTHagPmtrXmJjRgP6mQZNYEBL3YWTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gdEun3Yo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DyQD/12RCuPa/pHvJFloMLSkNit2iJNd6Y55+8X+S9o=; b=gdEun3Yo7nq+uQsT+MfWgV2pI0
	NHKpEb0uH816likmx6uDX2hKw+Uc1cgxWuJzGWdM0N2ToOKGE37jkxuzGKaHDc56W+fqj7rKhaUap
	NZ6wzMLKNNHlKgNOfy07Fmma9XVs3WvxXNZo9XIZc6hM9rE8E8YXjAEV8QTKm7nhNynBKr0xGhfw/
	81zSiGZJlgL0iwa/YVtUsnEZfKvD1d21JVYUa+FWbJxHtji1EBsNmd04aAg7jmyorIlSoqDO3dqi4
	OWNJ9Z6aOIkh37x35qi0IT0MhNYZzaSVujIMrIvDDj6wcl91BkUS03IR0zOXzV7eZswDOjHcc/0Hw
	5QXNhjFQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOghm-00000000xck-3ywy;
	Tue, 02 Jul 2024 16:50:10 +0000
Date: Tue, 2 Jul 2024 17:50:10 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, Zi Yan <zi.yan@sent.com>
Subject: Re: [PATCH v8 06/10] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZoQvwkcL3uWONfzV@casper.infradead.org>
References: <20240625114420.719014-1-kernel@pankajraghav.com>
 <20240625114420.719014-7-kernel@pankajraghav.com>
 <20240702074203.GA29410@lst.de>
 <20240702101556.jdi5anyr3v5zngnv@quentin>
 <20240702120250.GA17373@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240702120250.GA17373@lst.de>

On Tue, Jul 02, 2024 at 02:02:50PM +0200, Christoph Hellwig wrote:
> On Tue, Jul 02, 2024 at 10:15:56AM +0000, Pankaj Raghav (Samsung) wrote:
> > Willy suggested we could use raw pages as we don't need the metadata
> > from using a folio. [0]
> 
> Ok, that feels weird but I'll defer to his opinion in that case.

Let me see if I can make you feel less weird about it, since I think
this is something that people should have a clear feeling about.

In the Glorious Future, when we've separated pages and folios from each
other, folios are conceptually memory that gets mapped to userspace.
They have refcounts, mapcounts, a pointer to a file's mapping or an anon
vma's anon_vma, an index within that object, an LRU list, a dirty flag,
a lock bit, and so on.

We don't need any of that here.  We might choose to use a special memdesc
for accounting purposes, but there's no need to allocate a folio for it.
For now, leaving it as a plain allocation of pages seems like the smartest
option, and we can revisit in the future.

