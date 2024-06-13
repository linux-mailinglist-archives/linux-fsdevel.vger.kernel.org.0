Return-Path: <linux-fsdevel+bounces-21614-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6968290675E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 10:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DAFC1F2249D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 08:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0213D13D638;
	Thu, 13 Jun 2024 08:45:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFEF28F1;
	Thu, 13 Jun 2024 08:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268351; cv=none; b=RZpIU125593On7xZ7WTTlVt4JTHMbyQ/YXYV/UcSjKxjRKBI/ucNsSwPejsxoRGEkM1l0UKBl0+Z2dyvMXQ5q5ep0fkIW++25pjkMpvcuFOpSm66qFEWO+w8r1mQzKPTlrA4IS0YrOk2lyD9scATh8faxQinJWV2XWhSMrXbAgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268351; c=relaxed/simple;
	bh=pd9icyH3HrNnyeWi69GOzEN/1vvh5EWir/kOPt6/4wM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a7OBYADKfKi67QZE55nH1MwQrXNdW9rTKZdBfN1ZpP7+Gv4PAm/nEBVWojSu2etdcFpK8kPjcjzUl08J1dYLAvTLRqM73ZfArkFrC5A1jRX1DRRTvQ/AwDVt5TY8zAkU+7nGjSgv5sP+B1m7eXC7U+hIRDpkhOIaI7ixRHe42ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9417068BEB; Thu, 13 Jun 2024 10:45:46 +0200 (CEST)
Date: Thu, 13 Jun 2024 10:45:45 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, willy@infradead.org,
	mcgrof@kernel.org, linux-mm@kvack.org, hare@suse.de,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	Zi Yan <zi.yan@sent.com>, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 10/11] xfs: make the calculation generic in
 xfs_sb_validate_fsb_count()
Message-ID: <20240613084545.GB23371@lst.de>
References: <20240607145902.1137853-1-kernel@pankajraghav.com> <20240607145902.1137853-11-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240607145902.1137853-11-kernel@pankajraghav.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

> +	uint64_t		max_index;
> +	uint64_t		max_bytes;
> +
>  	ASSERT(PAGE_SHIFT >= sbp->sb_blocklog);
>  	ASSERT(sbp->sb_blocklog >= BBSHIFT);
>  
> +	if (check_shl_overflow(nblocks, sbp->sb_blocklog, &max_bytes))
> +		return -EFBIG;
> +
>  	/* Limited by ULONG_MAX of page cache index */
> -	if (nblocks >> (PAGE_SHIFT - sbp->sb_blocklog) > ULONG_MAX)
> +	max_index = max_bytes >> PAGE_SHIFT;
> +
> +	if (max_index > ULONG_MAX)

Do we really need the max_index variable for a single user here?
Or do you plan to add more uses of it later (can't really think of one
though)?


