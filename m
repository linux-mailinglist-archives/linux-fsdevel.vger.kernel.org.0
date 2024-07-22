Return-Path: <linux-fsdevel+bounces-24076-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB56D939080
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 16:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7546E28209D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 14:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F8A816DC2F;
	Mon, 22 Jul 2024 14:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="eEMlUdYS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E6BE5E;
	Mon, 22 Jul 2024 14:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721658014; cv=none; b=VCxjP/tv0BZCRPBwA+7xGCRRlUtpt67HUy2YPzKegNGTZwQ1PRy3b/El1fU2chdzJoO8Mn5uolE7OlZy8t6bbTCn9ubQAhLIiFok7CcLO7geTkHhWyOsf/sIOJijycM51+8pLd7JH1+SRcJvPuTjF2ogf/4SiDFkSIERX32Ly/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721658014; c=relaxed/simple;
	bh=eRJdj80qjmtv6NXMLmeBALq5OoinabB/jn9+kU6thPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OvloKSfs0uFxpurGWL4kN95dSUwRCVoxOhzvRhEAhgybIN7v6m+e8NI8ISysjwaHlJ2Rfx8nXSu//cao3BzjvwOsz+BN5ecVDB+VmH5TBcjqsupE7V4svOWxl0gsHYAHu5MyIzXImiySf+2jzGQXs57tuxE9TlO4VPf89v4fKUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=eEMlUdYS; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WSMql1yPDz9snH;
	Mon, 22 Jul 2024 16:20:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721658003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eyz9qfBcUQtwZ0SLs3SHTA7dLaRuH46FDkD9b19ehTo=;
	b=eEMlUdYSPSSF/Ao3vUtkpcaasKr88s+aL4YohAA3FH5CfJI0Pl/fmByEU9imWjr6ENyn7d
	AeyTGGO7EdGNlXJgjchI0KNqjoVm5IY55IZY43nW+Q8jLjQcTGO/4LFkCSHbbdZsYprJPb
	T23Kzt8uwRpu3yoYwUZrIu1LgcQBXvbnKPC9ePOdv9Hg9qFjaPMaoIOUPcVvaQpOpD96x5
	7M7A7TP8SCF1Lo7KsFN18Bp7mIek8yFRUlf3hVHDKP3EIdP+x5LkylFKsYYolCUlXIv9ae
	NPABlzqOWDPdebgv3VZ4c9pNVxqAeorAarKW0lUhcvxGNVDSEOWGd1+5cqw4CA==
Date: Mon, 22 Jul 2024 14:19:57 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240722141957.yog434qio6okkdiq@quentin>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-2-kernel@pankajraghav.com>
 <ZpaRElX0HyikQ1ER@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpaRElX0HyikQ1ER@casper.infradead.org>

@willy:

I want to clarify before sending the next round of patches as I didn't
get any reply in the previous email.

IIUC your comments properly:

- I will go back to silent clamping in mapping_set_folio_order_range as
  before and remove VM_WARN_ONCE().

- I will move the mapping_max_folio_size_supported() to patch 10, and FSs
  can use them to check for the max block size that can be supported and
  take the respective action.

--
Pankaj

On Tue, Jul 16, 2024 at 04:26:10PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 15, 2024 at 11:44:48AM +0200, Pankaj Raghav (Samsung) wrote:
> > +/*
> > + * mapping_max_folio_size_supported() - Check the max folio size supported
> > + *
> > + * The filesystem should call this function at mount time if there is a
> > + * requirement on the folio mapping size in the page cache.
> > + */
> > +static inline size_t mapping_max_folio_size_supported(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
> > +	return PAGE_SIZE;
> > +}
> 
> There's no need for this to be part of this patch.  I've removed stuff
> from this patch before that's not needed, please stop adding unnecessary
> functions.  This would logically be part of patch 10.
> 
> > +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > +						 unsigned int min,
> > +						 unsigned int max)
> > +{
> > +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		return;
> > +
> > +	if (min > MAX_PAGECACHE_ORDER) {
> > +		VM_WARN_ONCE(1,
> > +	"min order > MAX_PAGECACHE_ORDER. Setting min_order to MAX_PAGECACHE_ORDER");
> > +		min = MAX_PAGECACHE_ORDER;
> > +	}
> 
> This is really too much.  It's something that will never happen.  Just
> delete the message.
> 
> > +	if (max > MAX_PAGECACHE_ORDER) {
> > +		VM_WARN_ONCE(1,
> > +	"max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
> > +		max = MAX_PAGECACHE_ORDER;
> 
> Absolutely not.  If the filesystem declares it can support a block size
> of 4TB, then good for it.  We just silently clamp it.
> 

