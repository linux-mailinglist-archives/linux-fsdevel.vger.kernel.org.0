Return-Path: <linux-fsdevel+bounces-5070-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BACC2807D4F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 01:40:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E1551F2107F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E112F539E
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0mHgeuF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [IPv6:2001:41d0:1004:224b::b3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1AB0D51
	for <linux-fsdevel@vger.kernel.org>; Wed,  6 Dec 2023 15:27:28 -0800 (PST)
Date: Wed, 6 Dec 2023 18:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701905247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Djvwm+NPL6KXNphuoX3SYP1l8zLR8DawFWvuOOS0zcY=;
	b=X0mHgeuFEdJN25R3pVyyRGOuJ8VMx7iU2WW7t+F0KYePQvt4qYYBFsx+oiB30InJZXQYiR
	btTC1UZmAt3+VdslhVKsbF0WUdlttsW6WycQkW/qx7dvzmeoNieD0F6ujzLywIjHS9K+ly
	cNfn1giO1n8FP5lH6ylGQY736QR3Jdc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Phillip Lougher <phillip@squashfs.org.uk>
Subject: Re: [PATCH 1/3] block: Rework bio_for_each_segment_all()
Message-ID: <20231206232724.hitl4u7ih7juzxev@moria.home.lan>
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
X-Migadu-Flow: FLOW_OUT

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

Well, there was quite a bit of back and forth before, mainly over code
size - which was addressed; and the only tricky parts were to squashfs
which Phillip looked at and tested.

