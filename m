Return-Path: <linux-fsdevel+bounces-20342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0248D19C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 13:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA22528A690
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2024 11:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F6216C847;
	Tue, 28 May 2024 11:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Zm9g0deC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9619182B3;
	Tue, 28 May 2024 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716896275; cv=none; b=t/03ntKfMqKWGGeOzETsidPEA3HxsRfYqEtodff3OXWQWBwLqBAUL57X4vqIvMOmcZA5yUT/jdDmd9XSC46AZZcqf7jqNGe19UxwoUkE6oHJJlOvKEwhHX4TugfBoFHbQTo0AB8rs1LtNIaVL4voRIWCwt9xzeBXwnaTE7OOLow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716896275; c=relaxed/simple;
	bh=BPx3/5wdXsJGI4AJO7t/7IynKbNRWk2jWU84tK70+xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ul0ybJJNzIcbAEi8CWvjd24DjlGJiM2pIFj89Kk//60kMhV1mi+qdLiHbIe7TgLXZW/s2jRvH1WrK2AgCBPebKrrpbWmFXGynq5ZfAV6Gf+LzoYYv2PK08cUXkgRO1W4AWVyFweEPDtyB3VqOI+OCIvXDwvsZYBDpzS351ZDmVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Zm9g0deC; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4VpVqx5SJ3z9sp7;
	Tue, 28 May 2024 13:37:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1716896269;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GTsatAjEP5Z8hfmSAf2UWHF4m9F5ZsKNkIun34OCiBY=;
	b=Zm9g0deCam8+HbkRh/fSgRnY4JWMb05jZLjC2f/Wj9SYi6E7+mdZHPZs6SyE3htSRNERjr
	EqWEYEei5jTbvWfIRzj3W4Dyy/SZLUSn+Y91W5exEERsSL5YFWLhWc8thlSck/DA0PYmcA
	9fFjW3mdubYrMh+MeQaOTFQQGi6Lf6AMvxfCGEeX481BV9rhpMFhHmf+vTPXAlzDY8ogAO
	sx9EkNDYfLn6Ehjusk6t8lpVDy0c69VK4gkXaCv0cqsdyGtB3rESCkBGS7KeLR0hXfHSmS
	H5yu/mKg6imqOJy7btrNknjLhd4bbmbju763kIgEm1TpZ1fcJ1kN/+6+ael63Q==
Date: Tue, 28 May 2024 11:37:43 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, mcgrof@kernel.org
Subject: Re: [PATCH v5.1] fs: Allow fine-grained control of folio sizes
Message-ID: <20240528113743.7bpg2kgeirwysmoa@quentin>
References: <20240527210125.1905586-1-willy@infradead.org>
 <e732a6ea-ade2-4398-b1ac-9e552fd365f5@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e732a6ea-ade2-4398-b1ac-9e552fd365f5@suse.de>

> > + * is non-atomic.
> > + */
> > +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > +		unsigned int min, unsigned int max)
> > +{
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		return;
> > +
> Errm. Sure? When transparent hugepages are _enabled_ we don't support this
> feature?
> Confused.

I think large folio support depends on THP, at least for now. I remember
willy mentioning that in a thread. The future plan is to get rid of
this dependency.

> 
> Cheers,
> 
> Hannes
> -- 
> Dr. Hannes Reinecke                  Kernel Storage Architect
> hare@suse.de                                +49 911 74053 688
> SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
> HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
> 

-- 
Pankaj Raghav

