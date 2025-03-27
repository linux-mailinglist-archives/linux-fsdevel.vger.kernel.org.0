Return-Path: <linux-fsdevel+bounces-45148-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F751A7373D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:47:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E6C6881136
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E2215780;
	Thu, 27 Mar 2025 16:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tX86Jgoq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679D51FFC41;
	Thu, 27 Mar 2025 16:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093876; cv=none; b=sK0ITZZ7L5JQcyFQV75q/+g6t9/pm17eK3iBhWSF5gZkSzPB5Jpiu1qYDbdHYu667H55SYsqNdIH8Ae7kFpMHztA+n96bPA2aDb6ucBP93bVoYb39FrrfdobqRCA2hm95LhetIKr5XqPREioIMB49z24TfCU2NH6XYJwIkWBSfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093876; c=relaxed/simple;
	bh=FYGZZN5Z6khOmuwpDcsQ3OWEngqKDEy0XbKFM3ueaLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMJq/IE92DABcehW9ZXgTaGbunePB1uzHSqo/mBBiDFcuDHhS1Y458rHGo2feYrY+XuwXAYKpciqM7M0N/mnWFa0RiJX1nlue/E04pLyVkVJvOEfWA+Yu2hZBeKEmcBmz6l+vaAiI5qEHQFYQ7uk5Lq9R6IcxtcDclfT0TT+TUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tX86Jgoq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=MoCqLC0IyhHguklsqlEzr9OrpUUFrOWDPdsoNryKYDU=; b=tX86Jgoq24bhniWrtEPXpkd536
	cUmSpefVNuw5pC1Od8arup43Wnt7+0HRYOZoanyEQdX0oJU2QGL5xfloxkFz8kRQrsp5qXMswzpcm
	6N4x9LAKCqKwO8lowZUyg7JMY6pDkmDBvJoHIbH+vZK5Eftv03kMbr4oEon5AzyL5LhEdcON3/zXA
	ORGXhYuo5+I7eAubmfHcetoSzGNeQPVaTZQ2nCwjJ+3LPw9wiJeF3PnIZvz1oAInLzJaTKHfCth7z
	BLYHE3Kib6e5E7PS7n7ICBAU0KNrjkVE3ee8WJjXwWefDYjcgEz9JHDntUS/0mP8NIoRsj+4aMDGm
	vac/ZHUQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txqLG-0000000DMCf-0N50;
	Thu, 27 Mar 2025 16:44:30 +0000
Date: Thu, 27 Mar 2025 16:44:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Dave Chinner <david@fromorbit.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v3] mm/filemap: Allow arch to request folio size for exec
 memory
Message-ID: <Z-WAbWfZzG1GA-4n@casper.infradead.org>
References: <20250327160700.1147155-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327160700.1147155-1-ryan.roberts@arm.com>

On Thu, Mar 27, 2025 at 04:06:58PM +0000, Ryan Roberts wrote:
> So let's special-case the read(ahead) logic for executable mappings. The
> trade-off is performance improvement (due to more efficient storage of
> the translations in iTLB) vs potential read amplification (due to
> reading too much data around the fault which won't be used), and the
> latter is independent of base page size. I've chosen 64K folio size for
> arm64 which benefits both the 4K and 16K base page size configs and
> shouldn't lead to any read amplification in practice since the old
> read-around path was (usually) reading blocks of 128K. I don't
> anticipate any write amplification because text is always RO.

Is there not also the potential for wasted memory due to ELF alignment?
Kalesh talked about it in the MM BOF at the same time that Ted and I
were discussing it in the FS BOF.  Some coordination required (like
maybe Kalesh could have mentioned it to me rathere than assuming I'd be
there?)

> +#define arch_exec_folio_order() ilog2(SZ_64K >> PAGE_SHIFT)

I don't think the "arch" really adds much value here.

#define exec_folio_order()	get_order(SZ_64K)

> +#ifndef arch_exec_folio_order
> +/*
> + * Returns preferred minimum folio order for executable file-backed memory. Must
> + * be in range [0, PMD_ORDER]. Negative value implies that the HW has no
> + * preference and mm will not special-case executable memory in the pagecache.
> + */
> +static inline int arch_exec_folio_order(void)
> +{
> +	return -1;
> +}

This feels a bit fragile.  I often expect to be able to store an order
in an unsigned int.  Why not return 0 instead?


