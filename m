Return-Path: <linux-fsdevel+bounces-55256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0088B08C87
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 14:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1011D4A2070
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 12:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820CE2BCF73;
	Thu, 17 Jul 2025 12:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Nbg/lMwq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F025A29E114;
	Thu, 17 Jul 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754067; cv=none; b=fJ7XH+mHaUa9f4Pqy7CJKhS/PzzRb3guW5L2LINCQHzXQr3M/6/DmT2UWWIRQCVRPzgMobBXW5vXyDFJo9RaeQGlSHoa4vpGBpKEJrCQAPuKA2ZxLESFUfGVikWjmJO+bi4106C64Z0G8+a9OemmMRm3BbzhbDk3V3qgHb/EYS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754067; c=relaxed/simple;
	bh=heLBpBS+UNyu400fsfQ7AHME4bX/Aw6S0dGsXsDJqx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKMFrsPx9xXHzjYaHYQBwhAGu7WXj199BAAB5dm8ManY8iIpzLrGcA9KMhVj1B0twUZJ/cYwY55Ij8w6wQ6t2g1uh1VgWXqSlk+S1WEDXW+m1ihRkIyuJdjc73sb+qBPbqHmer8LNxOOZ7zR6aPugK3v3ckyMzyEcaDlsm0QH3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Nbg/lMwq; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4bjWrt05HWz9spH;
	Thu, 17 Jul 2025 14:07:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1752754062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M2ybh1HtN61EqnwEX7w+RBXpg6drT9A8UjYiaAe7+9c=;
	b=Nbg/lMwqYQ7RdUmujBnBs7sqvXWbAL1VjgMtWdfg6Vod71r7uQGV6MlSF1iJS3sgoYwmjC
	ITsrV5wLVFlsVwEHveYY4MmVvDLIKioRhEbz8Tx1uqYCexUWMzJkrbSRQbEph6ZxD8YA+B
	hLjLl4ygK/sLIQosFGBKbpTYt6J1NGRIaF1aNgau5MhKsKxBOyQqh1IYGI+WtpsgaOZQfJ
	UNHCCsPxg+IUmX8KQLkhmEqbEAmAvHLYE3Aqfplup74bYRVuAVqE0cNHeNLx5h4GlL9Rq9
	eMNglH3B6JzyC/mexb8GCIii/yPfEZEbFJh1lAvCLkpgVcO9j5MoY+r7/JuYVg==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of kernel@pankajraghav.com designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=kernel@pankajraghav.com
Date: Thu, 17 Jul 2025 14:07:31 +0200
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: David Hildenbrand <david@redhat.com>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>, 
	"H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan <ziy@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Michal Hocko <mhocko@suse.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Nico Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org, 
	willy@infradead.org, linux-mm@kvack.org, x86@kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org, 
	gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 3/5] mm: add static PMD zero page
Message-ID: <pesfhdmkz2essyfcesxqekwkxbrkw343qifwkuzrvirw6yyn4i@xjkigwtyczrh>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-4-kernel@pankajraghav.com>
 <26fded53-b79d-4538-bc56-3d2055eb5d62@redhat.com>
 <fbcb6038-43a9-4d47-8cf7-f5ca32824079@redhat.com>
 <gr6zfputin56222rjxbvnsacvuhh3ghabjbk6dgf4mcvgm2bs6@w7jak5ywgskw>
 <ea55eb30-552a-4fca-83e0-342ec7c98768@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea55eb30-552a-4fca-83e0-342ec7c98768@redhat.com>
X-Rspamd-Queue-Id: 4bjWrt05HWz9spH

On Thu, Jul 17, 2025 at 01:46:03PM +0200, David Hildenbrand wrote:
> On 17.07.25 12:34, Pankaj Raghav (Samsung) wrote:
> > > > Then, we'd only need a config option to allow for that to happen.
> > > 
> > > Something incomplete and very hacky just to give an idea. It would try allocating
> > > it if there is actual code running that would need it, and then have it
> > > stick around forever.
> > > 
> > Thanks a lot for this David :) I think this is a much better idea and
> > reduces the amount code and reuse the existing infrastructure.
> > 
> > I will try this approach in the next version.
> > 
> > <snip>
> > > +       /*
> > > +        * Our raised reference will prevent the shrinker from ever having
> > > +        * success -> static.
> > > +        */
> > > +       if (atomic_read(&huge_zero_folio_is_static))
> > > +               return huge_zero_folio;
> > > +       /* TODO: memblock allocation if buddy is not up yet? Or Reject that earlier. */
> > 
> > Do we need memblock allocation? At least the use cases I forsee for
> > static pmd zero page are all after the mm is up. So I don't see why we
> > need to allocate it via memblock.
> 
> Even better!
> 
> We might want to detect whether allocation of the huge zeropage failed a
> couple of times and then just give up. Otherwise, each and every user of the
> largest zero folio will keep allocating it.

Yes, that makes sense. We need sort of like a global counter to count
the nr of failures and then give up trying to allocate it if it goes
above a threshold.

--
Pankaj

