Return-Path: <linux-fsdevel+bounces-5203-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607B180959C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 23:47:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163361F2120A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C31557889
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 22:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cnvsC8gS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B95011715;
	Thu,  7 Dec 2023 12:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=s2bX7E6e8D6a63dwUpJhiSVLKSTI5dOIQtVs9RW31jk=; b=cnvsC8gSENUuuZQq+BfG+aCepS
	gKcHTqQIXlqo0gqjHyu5hl20y9psgwlB3Xuy9M5ZYgLSs+MA2lwR+JrExYE3nGLoVwqIuF+SZ6T7U
	qDLQf/SM5GNZZljj1sUW6rX3jhdggG/jy+EZhIAEk658Ajz+zvdbQq8z62do9ma76VAGf4xhDK2mm
	CWmY/j3G7WKTGzDAUe6LuafRcMRW4iYfWa5yMV6NCefcw6E8fNJBVM82hVSOL3B+MO4u92orQZ7Ao
	6dWNsMuZryJCjlTUcwN7cdmh+lsIe2497IirpuaDovZHnTCliJ2XBDmUChCb+pwAekemKQd6QpMi3
	Har+44bw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rBLS8-004Mkh-7n; Thu, 07 Dec 2023 20:58:36 +0000
Date: Thu, 7 Dec 2023 20:58:36 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Message-ID: <ZXIx/FVRYb8E5r37@casper.infradead.org>
References: <20231122232818.178256-1-kent.overstreet@linux.dev>
 <20231206213424.rn7i42zoyo6zxufk@moria.home.lan>
 <72bf57b0-b5fb-4309-8bfb-63a207a52df7@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72bf57b0-b5fb-4309-8bfb-63a207a52df7@kernel.dk>

On Wed, Dec 06, 2023 at 03:40:38PM -0700, Jens Axboe wrote:
> On 12/6/23 2:34 PM, Kent Overstreet wrote:
> > On Wed, Nov 22, 2023 at 06:28:13PM -0500, Kent Overstreet wrote:
> >> This patch reworks bio_for_each_segment_all() to be more inline with how
> >> the other bio iterators work:
> >>
> >>  - bio_iter_all_peek() now returns a synthesized bio_vec; we don't stash
> >>    one in the iterator and pass a pointer to it - bad. This way makes it
> >>    clearer what's a constructed value vs. a reference to something
> >>    pre-existing, and it also will help with cleaning up and
> >>    consolidating code with bio_for_each_folio_all().
> >>
> >>  - We now provide bio_for_each_segment_all_continue(), for squashfs:
> >>    this makes their code clearer.
> > 
> > Jens, can we _please_ get this series merged so bcachefs isn't reaching
> > into bio/bvec internals?
> 
> Haven't gotten around to review it fully yet, and nobody else has either
> fwiw. Would be nice with some reviews.

Could you apply this conflicting patch first, so it's easier to
backport>

https://lore.kernel.org/linux-block/20230814144100.596749-1-willy@infradead.org/

