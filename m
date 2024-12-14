Return-Path: <linux-fsdevel+bounces-37416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7813B9F1C7E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 05:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7083F16970E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 14 Dec 2024 04:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC6C2EAE6;
	Sat, 14 Dec 2024 04:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="u3CFx5fW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECE7175AB;
	Sat, 14 Dec 2024 04:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734148983; cv=none; b=KlMSpQ6cxCGSY0txG2J7skVA5927+htTJzqyD/o4DJpd/1fOdHYf4coQON5fWbmV0QvOBzEjm+aGkuoFDvx6akWpawcUaO9yxSyhZgSNS0Rzp0HiP9AR8dX1I6B2ChvcYl8vxjfIcApzW/343yFd9Zydri3CBNEKl6XIrzwKL/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734148983; c=relaxed/simple;
	bh=zstp8Wu+KVKzgWTx0A+QmCIhiMsa5iWe6W6OFLiy+Yc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CfkCdWo/QsT+N83JqrqNO2FvYrDMeDO6ZBj5IJDhCp+YiYqpDiNw8mbQhNdSWuop/f4pnpIAs+SWip1HyP4JswQosp043RM8p77qh5FG7IpWbBN3/pFxfnS48uFJROfnPr/e7Jl3EUlwWsRwqxFxestUPpGjZ1JZid8x+V5Ouqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=u3CFx5fW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jaQ9uekgW3wGOKyDaJmcvtRmbzNiIXaD1Ad3D9xZuyQ=; b=u3CFx5fWftMx/DFfIvvxtvHyu1
	bogj6kmX3dZi3EmWlApnq6qtk/gG7+EGgLswu0bvUzSCn6foj2WKKWW/jlekJYSABYYwCKZ8247hI
	CwlmmMekA5hdiw6KtmWHLgn6qM/1PFhpK+Hp4sh/6UWWR5cPERfURhJOJnrhlC8ipHJpvmZiH75JM
	0wkNSMAD/rgNOp9xKK5WlCAGhCs1zdyYNOCK6WXfjYfGuduubkB4beXFuAoa7C2JEFH6Muei6M2mn
	Cf6BGsEa6Us/tsy1mvCsoOr0rjhFCGLIprO5ch9+r8SykAJHXK67zIHh706DjOmFnnHBnhsv90Iad
	4HvkUqvg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tMJMj-00000000Btk-1VfQ;
	Sat, 14 Dec 2024 04:02:53 +0000
Date: Sat, 14 Dec 2024 04:02:53 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: hch@lst.de, hare@suse.de, dave@stgolabs.net, david@fromorbit.com,
	djwong@kernel.org, john.g.garry@oracle.com, ritesh.list@gmail.com,
	kbusch@kernel.org, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-mm@kvack.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	p.raghav@samsung.com, da.gomez@samsung.com, kernel@pankajraghav.com
Subject: Re: [RFC v2 02/11] fs/buffer: add a for_each_bh() for
 block_read_full_folio()
Message-ID: <Z10DbUnisJJMl0zW@casper.infradead.org>
References: <20241214031050.1337920-1-mcgrof@kernel.org>
 <20241214031050.1337920-3-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241214031050.1337920-3-mcgrof@kernel.org>

On Fri, Dec 13, 2024 at 07:10:40PM -0800, Luis Chamberlain wrote:
> -	do {
> +	for_each_bh(bh, head) {
>  		if (buffer_uptodate(bh))
>  			continue;
>  
> @@ -2454,7 +2464,9 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
>  				continue;
>  		}
>  		arr[nr++] = bh;
> -	} while (i++, iblock++, (bh = bh->b_this_page) != head);
> +		i++;
> +		iblock++;
> +	}

This is non-equivalent.  That 'continue' you can see would increment i
and iblock.  Now it doesn't.

