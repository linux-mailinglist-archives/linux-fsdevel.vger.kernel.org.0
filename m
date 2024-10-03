Return-Path: <linux-fsdevel+bounces-30891-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1086198F13F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 16:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88A3F281CB3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F08B19E968;
	Thu,  3 Oct 2024 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sQOQ31A8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A36197A65;
	Thu,  3 Oct 2024 14:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727965162; cv=none; b=IFzjYjQioZWU1srzKoY0AbkxfEsWtkbJT57smcR1JA9oxLzCEa2kruwDBuXcXlbgDBoIu8EOVTN5FNEUrH9EzLPHNXoXYHB7/YgxEjBgoFA5dKJOVUJhL/CGUFCCCOY7vRNAbaDEOC/DxDt46CyiEndXzd6H0rAdyHOaWsDofRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727965162; c=relaxed/simple;
	bh=yvV/XCZSBeAgPdM0l8YoGpcgZKpyLl9J2RRsBcI7UM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QJlmhRBHJdTouzK+CeMdNseXZvDqX/wmrymIYwDMWN2bIi+AFXJJnB+xV8XxDW/kgx6wNSsDCpwy4zc8CRxd9POwPL4t7rBYjhk8gMTU/YPmss0Kb/1YvG5ZFHCU/z900orJvFfB6BaltkjQpHPv7r2zZ1o4Gi5NF6nrb7EBUy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=sQOQ31A8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zVgRWuybk2Cw8g/RlzCJeQTCunq05g5McEWnZP+Fqjg=; b=sQOQ31A87Eez7nqYo4z6bXXHcY
	KMIfgDY9QdWpwKMwpj76N4pBHwBawzpnp65CuuYOcIQ74zYbQ579z1WO+BOiuQBGZAg1kX1ytavoO
	tY+EP7PLiGFyVpjKYqnx1pFY8ZxazOj8/TqmZzblMbtTsvhSZMmwgiGgSAERI/oHV2Db/WoNnC5ns
	de1+k6AfBrzZRxWuVh3zuRseJ0LJEzzcMpSsGja8d+hjOqjVuifwRHorRY+ZSPlLq7jDXVAQulbqB
	QCDOf8gZ+r2tHssTkhiiTlK9ZGNf55QAxb48bAGwWiP4BBCNjHpXxgEa7P+qltoYx+hDZr7RfsrhW
	O3Ov+DKQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1swMfm-000000080GV-3Jt3;
	Thu, 03 Oct 2024 14:19:18 +0000
Date: Thu, 3 Oct 2024 15:19:18 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/6] fs: Move clearing of mappedtodisk to buffer.c
Message-ID: <Zv6n5oAy_2lZzrZ2@casper.infradead.org>
References: <20241002040111.1023018-1-willy@infradead.org>
 <20241002040111.1023018-2-willy@infradead.org>
 <20241003121020.36i4ufbbuf4fbua7@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241003121020.36i4ufbbuf4fbua7@quack3>

On Thu, Oct 03, 2024 at 02:10:20PM +0200, Jan Kara wrote:
> On Wed 02-10-24 05:01:03, Matthew Wilcox (Oracle) wrote:
> > The mappedtodisk flag is only meaningful for buffer head based
> > filesystems.  It should not be cleared for other filesystems.  This allows
> > us to reuse the mappedtodisk flag to have other meanings in filesystems
> > that do not use buffer heads.
> > 
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
> The patch looks good. But I'm bit confused about the changelog. There's no
> generic code checking for mappedtodisk. Only nilfs2 actually uses it for
> anything, all other filesystems just never look at it as far as my grepping
> shows. So speaking about "filesystems that do not use buffer heads" looks
> somewhat broad to me. Anyway feel free to add:

Hmm.  f2fs also uses it in page_mkwrite().  But it looks odd to me.
Perhaps we could get rid of mappedtodisk entirely ... I see ext4
used to use it until someone removed it in 9ea7df534ed2 ;-)

Anyway, what the changelog is trying to say is that only
buffer-head filesystems ever have the mappedtodisk flag set, eg by
block_read_full_folio() or do_mpage_readpage().  So it doesn't make
sense to clear it for non-buffer-head filesystems, and may inhibit their
ability to use it for unrelated purposes.

