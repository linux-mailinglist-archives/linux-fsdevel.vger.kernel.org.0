Return-Path: <linux-fsdevel+bounces-20285-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2B488D105D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 00:44:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB3EB22070
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 May 2024 22:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31561167D95;
	Mon, 27 May 2024 22:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V0xJwy3T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B306167270;
	Mon, 27 May 2024 22:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716849831; cv=none; b=b5eju4NuUhLDpDx6KRwOnV1ZwdyEjY63Vko/At4vZLvPFOk3uSsuaPXr+noYia2ELSBJqaGqieGcPzs73yrPK8tf7XZQ4GeNloD2lAG8+jRYvrAT2JGCa7lhVkhi+UxBMhs6m1P6XIKO3ekA9OscKrStDHzNxWeKluL1s+UDTrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716849831; c=relaxed/simple;
	bh=X88AQkZU65Pz1b3ukWsS0Ogt+/WyFAiRIA7j44e0Kzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LeG6gcOpTtWPGCw6PCv3RagweBetP/89F6LzgmOjjfionPKqZ9/zkW1/F8aodd6mE5xYw8rth91AeWRn8DuiN1BGxb5rQxzYGt4BW6XbIMlOHOUwN7EPNA2clXhckkhRsc5wtA/HWsCcYLwiXlIzguVTGKDAFLBIwHEdgr3pJ+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V0xJwy3T; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BjImrOXWpiU+qfhtgMroV+a4YBMofEiDr/E3tuD1jnY=; b=V0xJwy3TXOuogSAGXMhcWBWnjF
	FZs7GkipX1fnkdpZ6tE7jhjadXJTdBGEHSstp36IYKmhTUUM+5V3eRfmgAKXMz+sbo+xsBdcLz+Oa
	QvXQf11ZK/P9kD4O9zVTq1aoeqiwVtOyiNGGvHf9mpxghWRgdoyDK48kWYKnSOLBUxy3Yhh2JRfZ9
	ACLDWAp9iHr9SrK+BreozIIgI6NfKY/keHWHTZJEBGGl8qzsgurYhMDbt7pkE6wK4V05r3UEY+LJY
	QzPXzo4X14bFw/FpGOVgzffvCOh7rB4SkBY7gYQw9/uH0snwkTPl0u7nQ7bPhttR2FqHjHYx9CbQD
	VVy+OKOg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sBj4B-0000000842A-3b3r;
	Mon, 27 May 2024 22:43:43 +0000
Date: Mon, 27 May 2024 23:43:43 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <ZlUMnx-6N1J6ZR4i@casper.infradead.org>
References: <20240527210125.1905586-1-willy@infradead.org>
 <20240527220926.3zh2rv43w7763d2y@quentin>
 <ZlULs_hAKMmasUR8@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZlULs_hAKMmasUR8@casper.infradead.org>

On Mon, May 27, 2024 at 11:39:47PM +0100, Matthew Wilcox wrote:
> > > +	AS_FOLIO_ORDER_MIN = 16,
> > > +	AS_FOLIO_ORDER_MAX = 21, /* Bits 16-25 are used for FOLIO_ORDER */
> > >  };
> > >  
> > > +#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
> > > +#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
> > 
> > As you changed the mapping flag offset, these masks also needs to be
> > changed accordingly.
> 
> That's why I did change them?

How about:

-#define AS_FOLIO_ORDER_MIN_MASK 0x001f0000
-#define AS_FOLIO_ORDER_MAX_MASK 0x03e00000
+#define AS_FOLIO_ORDER_MIN_MASK (31 << AS_FOLIO_ORDER_MIN)
+#define AS_FOLIO_ORDER_MAX_MASK (31 << AS_FOLIO_ORDER_MAX)


