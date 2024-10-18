Return-Path: <linux-fsdevel+bounces-32305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E029A3541
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 08:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F24281D0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Oct 2024 06:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C90D18132F;
	Fri, 18 Oct 2024 06:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="js7OcNVT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494A16F851;
	Fri, 18 Oct 2024 06:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232498; cv=none; b=TzyDKXJWTE4B131gSHeq0CDocBYYrK23rvQkGKY5zKDe+VBSWbltqWGTJjq65RoiL4F0+E2s86+pei/lw0GP/YzCRCe6JaHT+PMD6XH5Ym8Z109w5i822fu+8AEQZAxdnzGNuPUdwECiCGPxq2BEDAk5SbRjh79MiZK3i7lzBJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232498; c=relaxed/simple;
	bh=fNqmAtEYNhtplDhA6PjUnAvB7pejeWJszlEmMA9Mvxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oANc/M6uLhGZ88pVTshIx301k7/PpNa7mO0xYf728jySnHOilmtRwkCSmLBWKof/Ooc31BO/kF2vl60h/59TlUo+3X5l3Y2VIoF42bunc0+1EqIJLB/aq5YrAwANW18/dbV3/4rg5PTpO+V4RAOVAQkWasKAupNlQnSXJBAuRAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=js7OcNVT; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4XVF2t2J88z9tTv;
	Fri, 18 Oct 2024 08:21:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1729232486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv+PbWVQckbrIz0VUtUDCCH7eItZtALln6rMez0JkoE=;
	b=js7OcNVT4ZPS8cl7vuarPlz6Cp3TuzKDgtlHZ1zKMPHn350oEpqbygNRF5MACLhUr6Naff
	X2SsD5jVCEmYl01r4ldN3z5uUA/aoz7bYHcbJWrtBlACsJxKJys46jerCXoyf5TWajZb6l
	+8iKDz2r6L3pCtcbEp41F7YZ7Fl72syGKhZyRLQ9+q1/tQ6FQFG03TVYf8Df5iyhzokY7p
	gfFXRhJAqOh9FQaQZ6fgzmCpSzIV2ESYnOPnDitKsrakeSJX4CuMCdgPL8uHE63QBxiexN
	ldZ5RA5brWtGZgPdXEeVaAZ6eX4zMJ38MUixtYrb41tR5CrA7FbrXOS1m3NnZg==
Date: Fri, 18 Oct 2024 11:51:11 +0530
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Tyler Hicks <code@tyhicks.com>, ecryptfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 02/10] ecryptfs: Use a folio throughout
 ecryptfs_read_folio()
Message-ID: <nrdqlalnw7juepbpqrefnbh4a6ltjavwgogwv5ltkd76mieflz@jvjtoenberj7>
References: <20241017151709.2713048-1-willy@infradead.org>
 <20241017151709.2713048-3-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017151709.2713048-3-willy@infradead.org>
X-Rspamd-Queue-Id: 4XVF2t2J88z9tTv

On Thu, Oct 17, 2024 at 04:16:57PM +0100, Matthew Wilcox (Oracle) wrote:
> @@ -219,13 +219,11 @@ static int ecryptfs_read_folio(struct file *file, struct folio *folio)
>  		}
>  	}
>  out:
> -	if (rc)
> -		ClearPageUptodate(page);
> -	else
> -		SetPageUptodate(page);
> +	if (!rc)
> +		folio_mark_uptodate(folio);
>  	ecryptfs_printk(KERN_DEBUG, "Unlocking page with index = [0x%.16lx]\n",

Nit: Unlocking folio with index ..

> -			page->index);

--
Pankaj

