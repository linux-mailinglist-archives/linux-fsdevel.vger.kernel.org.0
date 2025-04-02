Return-Path: <linux-fsdevel+bounces-45483-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7750A78650
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 03:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443B33AF0F4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 01:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110903F9D2;
	Wed,  2 Apr 2025 01:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YuGBn8eR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C0517BA1;
	Wed,  2 Apr 2025 01:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743559116; cv=none; b=TeKb+VQA/64JKxK5PX0Fq2sLqfLtT1SeLj1Yw06ekPX54v5luV1QaBEJrdJVoJnsThQ4R0oLpdBI0re5t7g5l04SC7whlHoYighRIVYcQbkP33FQzdA18XwkGUutGZjco4evEolPmcIem90A4oCvnx8GUNcY9vS0Vu9mQahT4Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743559116; c=relaxed/simple;
	bh=ErM2c6qycS5jxEogBG+K32z1vC56lTZ9MLORUkfYFeE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+H6nAB/5VXQ7Oz23cWt1OTR9LLXRlJ2LpgfW5MJAwFNh/+t5alZ/fs7AzM6shFZJtLD9mu3/3Dg39KN/Fe86j+9K1/BoeDzJXrPIyIwSMDygKcgqIJs045M96yuSWYnYWlE/nlIvfasL2a+QD7x2s291lByLFZRL+63QPuF0K0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YuGBn8eR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pG3NsSLm9LD+16fsWTHmooG5YCXnksp9x3D1wkKamj0=; b=YuGBn8eRNptdheJ3KMV/cdOFDY
	nlvo0r6nUd8sCFDtpFcmoe9Wnpxs3U/fL7OfFVvgk+KXSmUQ7bPY9wlSCfG8A/pFKxqyEb7lPfPG3
	WN0Sq6ZzsTPmz1a9J3e2MHgCLDxs3oompq/Daxu9sKgYaIFWm3pnJ+0q1n8FxD/iKRWKbNzBPHtJ8
	pHt6yWBRzG53IrK7I+y+vqwkUZcCN+C6KjocXbwTRzqtQtV5IsfZO6E18lpf3bDhUL0i4bEnJyhJs
	+UjSAoqAvZYfPO3XaMiBl3k9mdHEHxg3zKfijQ2ls67lYqzqzI5cdbZYRIhUWZ2hHEmEPWAp3tiYd
	G32vIuKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1tznN6-00000008YS0-2Dgm;
	Wed, 02 Apr 2025 01:58:28 +0000
Date: Wed, 2 Apr 2025 02:58:28 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>, Luis Chamberlain <mcgrof@kernel.org>,
	brauner@kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org, riel@surriel.com, hannes@cmpxchg.org,
	oliver.sang@intel.com, david@redhat.com, axboe@kernel.dk,
	hare@suse.de, david@fromorbit.com, djwong@kernel.org,
	ritesh.list@gmail.com, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	gost.dev@samsung.com, p.raghav@samsung.com, da.gomez@samsung.com
Subject: Re: [PATCH 2/3] fs/buffer: avoid races with folio migrations on
 __find_get_block_slow()
Message-ID: <Z-yZxMVJgqOOpjHn@casper.infradead.org>
References: <20250330064732.3781046-1-mcgrof@kernel.org>
 <20250330064732.3781046-3-mcgrof@kernel.org>
 <lj6o73q6nev776uvy7potqrn5gmgtm4o2cev7dloedwasxcsmn@uanvqp3sm35p>
 <20250401214951.kikcrmu5k3q6qmcr@offworld>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250401214951.kikcrmu5k3q6qmcr@offworld>

On Tue, Apr 01, 2025 at 02:49:51PM -0700, Davidlohr Bueso wrote:
> So the below could be tucked in for norefs only (because this is about the addr
> space i_private_lock), but this also shortens the hold time; if that matters
> at all, of course, vs changing the migration semantics.

I like this approach a lot better.  One wrinkle is that it doesn't seem
that we need to set the BH_Migrate bit on every buffer; we could define
that it's only set on the head BH, right?


