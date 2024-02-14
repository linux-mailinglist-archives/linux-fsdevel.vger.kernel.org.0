Return-Path: <linux-fsdevel+bounces-11597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 522A88552A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 19:50:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E468E1F2DC7A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Feb 2024 18:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D280713A25E;
	Wed, 14 Feb 2024 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OvyXhtJ8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7462312F594;
	Wed, 14 Feb 2024 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936596; cv=none; b=AOgLRiTRl3V4UKLBGXqqMNAr+qTeu7/MCd7LjGSHyIbFAa6BV4i9zlYarVSwhN3obva8tamBBaAa+z58vok3tpoql0FaO+yYDUhm84OHaIzEbbFC1+j02EzJxlYZG0a1DjPpQB/GyAoaJOdCtVMWux9nMcUw5/yqhugeUUzhPqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936596; c=relaxed/simple;
	bh=iBeIw0o1R3URh7naf47rO/sCII+0g4wVjBf/jxJYoeo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIJw+fKy7Chij//vWDmNyMPbFdyhbrlu7tly4vIAJ+uAB67u/IRS58mlz90uYT7ZdvkNJ/HS/elwevLeQOWXHEHQNJlsDHF82jB+/I0vw/8PVNDOhfBaJme/rzzl8O0X0mRD+N1ivWs3brZegnv19fxWOBfu6RDzIkBdxoJawzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OvyXhtJ8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0KOsHR0mivN1ZZPk/2uGmtXwkoKyWymL79tieqRNs30=; b=OvyXhtJ8mQgx4SgxaUeo7jx9L4
	bjPJWNX+T7lTnlXe/fI6JNH3/RIBdDr1g2KQNWbeblnK1FMIf5ZtSM6Y35/vtq8XdW4bld4YqAune
	mmIuNNz/a9ISDWOwrCc1fJ/MoFgbbE8Fl8sTaU3v58DBQsVo+IU58Lcmvsw3jMMzXkTOrOZZ80hXR
	BvLXvH+4XHO8oaiaC7ALXQhUU2OTz9jJnaU2xcAvKzuX5/ke82xeUcmPHaa7HS4QdJaEm6kZgCn+R
	p74VQqWy8sZv/9g+3ejyqe/ugYMLllAZQi3jFyq9CHL0JXL//stNzydkLuK2+14+CcN90N4+tGFNP
	jdB6FYjQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1raKKL-0000000HKRe-3RpX;
	Wed, 14 Feb 2024 18:49:49 +0000
Date: Wed, 14 Feb 2024 18:49:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	kbusch@kernel.org, djwong@kernel.org, chandan.babu@oracle.com,
	p.raghav@samsung.com, linux-kernel@vger.kernel.org, hare@suse.de,
	linux-mm@kvack.org, david@fromorbit.com
Subject: Re: [RFC v2 01/14] fs: Allow fine-grained control of folio sizes
Message-ID: <Zc0LTcCcgBJnuQRN@casper.infradead.org>
References: <20240213093713.1753368-1-kernel@pankajraghav.com>
 <20240213093713.1753368-2-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240213093713.1753368-2-kernel@pankajraghav.com>

On Tue, Feb 13, 2024 at 10:37:00AM +0100, Pankaj Raghav (Samsung) wrote:
> +static inline void mapping_set_folio_orders(struct address_space *mapping,
> +					    unsigned int min, unsigned int max)
> +{
> +	if (min == 1)
> +		min = 2;

If you order the "support order-1 folios" patch first, you can drop
these two lines.

> +static inline unsigned int mapping_min_folio_nrpages(struct address_space *mapping)

I'm not sure if you need this, but it should return unsigned long, not
unsigned int.  With 64KiB pages on Arm, a PMD page is 512MiB (order 13)
and a PUD page will be order 26, which is far too close to 2^32 for
my comfort.


