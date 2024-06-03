Return-Path: <linux-fsdevel+bounces-20817-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76EA8D8264
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 14:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152921C23838
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2024 12:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2525812C47D;
	Mon,  3 Jun 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Qu3MYxmZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81164F;
	Mon,  3 Jun 2024 12:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717418214; cv=none; b=kr6B3KGUPdSM2/vsRRQTG5pd2lEzJrwb8HNLuaPW8mRufSqouHuF5eYcn49brtVUI6CPSikT9O39qpHj1XrI5Q48tnFFVDbjZbZgD+hZbsT1V5Fq46zn2hfy7jVKo2IXS44/yYclYD/wbSKjfPw22xftks3kJQeIYA8saPwrbFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717418214; c=relaxed/simple;
	bh=t1T26TRB9XYsNoZ575DQn4UY8pOFxLN+NFaGfC3uQX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sYluMXEgxlli2GJA2WFSSrK6I9RbED1O1s+aAuCOxXDZx57uPwvZWtf7iTXbdgec0bVdbGMEjNhkCaTALGfd2dJWuEEOeZdw8EgnNosA/xUTtrhY6A4dxnSSy5SMKLNQkbNuFj7A7HFKY9ldhLtS8fRMVlMrl+9JFEMwvs7DiY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Qu3MYxmZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7C0eF6nlIGCKMOH3zNzr9pWa+xfNDLGWYp9HnkvxvOw=; b=Qu3MYxmZEw2c4/kq5YqDisMcfE
	T3EEy9+eBLkbf3m3LBWAdhU/l0k9B8cacnrBC9uulnLzicX4+IdesmhBMPK5VYN5Id/TOvRi3t0vr
	Pkg6jZUIg4NHgEvTPofHJ/bQEmq/NSgudg9keRezfDlbQ+LgFw4Vl+LQqUr8ncm0sMDORewAZTQGe
	QE0FwLaZlaQKXwpvd381tpYZMcQV/tsfDjR68AWBLseeYE5MDXhgjX3PkP3xbPH7Qx6m4MJpefgnu
	6+CssTsUmfcZbb5VJhLhLR0lOPUiEHKRgMlQpqlyUVMdwnMBduN6rGwFgJuN9c4lJWVe+f/LY8eg4
	VETO2aUA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sE6ve-0000000E5zG-18Wz;
	Mon, 03 Jun 2024 12:36:46 +0000
Date: Mon, 3 Jun 2024 13:36:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: david@fromorbit.com, chandan.babu@oracle.com, akpm@linux-foundation.org,
	brauner@kernel.org, djwong@kernel.org, linux-kernel@vger.kernel.org,
	hare@suse.de, john.g.garry@oracle.com, gost.dev@samsung.com,
	yang@os.amperecomputing.com, p.raghav@samsung.com,
	cl@os.amperecomputing.com, linux-xfs@vger.kernel.org, hch@lst.de,
	mcgrof@kernel.org, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <Zl243qf2WiPHIMWN@casper.infradead.org>
References: <20240529134509.120826-1-kernel@pankajraghav.com>
 <20240529134509.120826-6-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240529134509.120826-6-kernel@pankajraghav.com>

On Wed, May 29, 2024 at 03:45:03PM +0200, Pankaj Raghav (Samsung) wrote:
> @@ -3572,14 +3600,19 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  
>  	for (index = off_start; index < off_end; index += nr_pages) {
>  		struct folio *folio = filemap_get_folio(mapping, index);
> +		unsigned int min_order, target_order = new_order;
>  
>  		nr_pages = 1;
>  		if (IS_ERR(folio))
>  			continue;
>  
> -		if (!folio_test_large(folio))
> +		if (!folio->mapping || !folio_test_large(folio))
>  			goto next;

This check is useless.  folio->mapping is set to NULL on truncate,
but you haven't done anything to prevent truncate yet.  That happens
later when you lock the folio.

> +		min_order = mapping_min_folio_order(mapping);

You should hoist this out of the loop.

> +		if (new_order < min_order)
> +			target_order = min_order;
> +
>  		total++;
>  		nr_pages = folio_nr_pages(folio);
>  
> @@ -3589,7 +3622,18 @@ static int split_huge_pages_in_file(const char *file_path, pgoff_t off_start,
>  		if (!folio_trylock(folio))
>  			goto next;
>  
> -		if (!split_folio_to_order(folio, new_order))
> +		if (!folio_test_anon(folio)) {

Please explain how a folio _in a file_ can be anon?

> +			unsigned int min_order;
> +
> +			if (!folio->mapping)
> +				goto next;
> +
> +			min_order = mapping_min_folio_order(folio->mapping);
> +			if (new_order < target_order)
> +				target_order = min_order;

Why is this being repeated?

> +		}
> +
> +		if (!split_folio_to_order(folio, target_order))
>  			split++;
>  
>  		folio_unlock(folio);
> -- 
> 2.34.1
> 

