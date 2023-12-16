Return-Path: <linux-fsdevel+bounces-6305-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A985815791
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 05:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04BF0287979
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Dec 2023 04:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CC510A3D;
	Sat, 16 Dec 2023 04:51:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F0F210A0A;
	Sat, 16 Dec 2023 04:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4DFE368B05; Sat, 16 Dec 2023 05:51:29 +0100 (CET)
Date: Sat, 16 Dec 2023 05:51:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jan Kara <jack@suse.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 09/11] writeback: Factor writeback_iter_next() out of
 write_cache_pages()
Message-ID: <20231216045128.GA9679@lst.de>
References: <20231214132544.376574-1-hch@lst.de> <20231214132544.376574-10-hch@lst.de> <ZXxf4TB5YU8huiz1@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXxf4TB5YU8huiz1@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 15, 2023 at 09:17:05AM -0500, Brian Foster wrote:
> +	while ((folio = writeback_get_next(mapping, wbc)) != NULL) {
>  		wbc->done_index = folio->index;
>  		folio_lock(folio);
>  		if (likely(should_writeback_folio(mapping, wbc, folio)))
>  			break;
>  		folio_unlock(folio);
>  	}
>  
> +	if (folio)
> +		trace_wbc_writepage(wbc, inode_to_bdi(mapping->host));
>  	return folio;

I posted a very similar transformation in reply to willy's first posting
of the series :)  I guess that's 2:1 now and I might as well go ahead
and do something like that now :)

