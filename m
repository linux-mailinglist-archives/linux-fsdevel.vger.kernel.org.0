Return-Path: <linux-fsdevel+bounces-18181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9DE8B61F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 21:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2715628462D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 19:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B99F13B5BB;
	Mon, 29 Apr 2024 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Jc0JoP+e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0923113AA3B;
	Mon, 29 Apr 2024 19:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714418496; cv=none; b=lbePcjylgjlyZkbmJM01kk1+M9d0CDZOYK1cWO7DC4L5bI/RC03LxkYKEwpHvulGmHCsh5mmlAK8gBcuJes2Fn+VT1mtYx2KATiuIw3ZMEJ9J5RMkTTbAd2XbXk36siEveHe08zL2mQm35Jbp1YkmgQAzTcaDBmPAEKcNfj+AhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714418496; c=relaxed/simple;
	bh=jp0/hhNkqyvc+wcHZcmBPELue9y/n98F9TDt18ONk+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgAx6T7XRs0SE5R+TzH6KJH76qxmhcQTX/1yTowdZkvLepFo4m0zYpHaHj424KDCrbXdT3makDa/6hufNn8PzRPT2k3siMAjduvbPK5F05Z9gOMkv6kAVpdWg6AUs9bTg7VtCnLLFOob8F+e9QNnNbnxviwZhjjmr9DHRMF3wkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Jc0JoP+e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=neJzdRz9MNUmJ0r+KdRG51iWaNXVEV9Q2WvkNbVMuAo=; b=Jc0JoP+eKlc+BEPzMeneXAxsma
	j/OYXl9xWbSVrgWEs60bJmZmC5ymQ6SxfijEAStU0JqYGSMrjhQl6oNoCCKdGKJWUrSWku+ucHqTd
	PX1zm4qHityOpwJAN4lQlbZteHHAf1yVdNPaFECdf0EE0gXFMv7iJgeYnyrdgXnQBOwxRVi4j4q1K
	+NWVRPqo4iabfKD59KHwsIpvkgf1QQuiO/oAQl1F9jEZlKEvQhCb+NCFSPzmwkpI9i7cev5c5lHkB
	6zsNABrfOfPUa8ebmNG6SglJtXXI0vKLoXXI5iLW3FpLMd/2fpU/w572XWrQS4/s+eomGeYpFOSvw
	sqIfsjmw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s1WYv-0000000D9vn-12aN;
	Mon, 29 Apr 2024 19:21:17 +0000
Date: Mon, 29 Apr 2024 20:21:17 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kairui Song <kasong@tencent.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>,
	Barry Song <v-songbaohua@oppo.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Neil Brown <neilb@suse.de>,
	Minchan Kim <minchan@kernel.org>, Hugh Dickins <hughd@google.com>,
	David Hildenbrand <david@redhat.com>,
	Yosry Ahmed <yosryahmed@google.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 08/12] nfs: drop usage of folio_file_pos
Message-ID: <Zi_zLQqpJ6PRX7HD@casper.infradead.org>
References: <20240429190500.30979-1-ryncsn@gmail.com>
 <20240429191138.34123-1-ryncsn@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429191138.34123-1-ryncsn@gmail.com>

On Tue, Apr 30, 2024 at 03:11:34AM +0800, Kairui Song wrote:
> +++ b/fs/nfs/file.c
> @@ -588,7 +588,7 @@ static vm_fault_t nfs_vm_page_mkwrite(struct vm_fault *vmf)
>  
>  	dfprintk(PAGECACHE, "NFS: vm_page_mkwrite(%pD2(%lu), offset %lld)\n",
>  		 filp, filp->f_mapping->host->i_ino,
> -		 (long long)folio_file_pos(folio));
> +		 (long long)folio_pos(folio));

Yes, we can't call page_mkwrite() on a swapcache page.

> +++ b/fs/nfs/nfstrace.h
> @@ -960,7 +960,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event,
>  			__entry->fileid = nfsi->fileid;
>  			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
>  			__entry->version = inode_peek_iversion_raw(inode);
> -			__entry->offset = folio_file_pos(folio);
> +			__entry->offset = folio_pos(folio);
>  			__entry->count = nfs_folio_length(folio);
>  		),
>  
> @@ -1008,7 +1008,7 @@ DECLARE_EVENT_CLASS(nfs_folio_event_done,
>  			__entry->fileid = nfsi->fileid;
>  			__entry->fhandle = nfs_fhandle_hash(&nfsi->fh);
>  			__entry->version = inode_peek_iversion_raw(inode);
> -			__entry->offset = folio_file_pos(folio);
> +			__entry->offset = folio_pos(folio);

These two I don't know about.

> +++ b/fs/nfs/write.c
> @@ -281,7 +281,7 @@ static void nfs_grow_file(struct folio *folio, unsigned int offset,
>  	end_index = ((i_size - 1) >> folio_shift(folio)) << folio_order(folio);
>  	if (i_size > 0 && folio_index(folio) < end_index)
>  		goto out;
> -	end = folio_file_pos(folio) + (loff_t)offset + (loff_t)count;
> +	end = folio_pos(folio) + (loff_t)offset + (loff_t)count;

This one concerns me.  Are we sure we can't call nfs_grow_file()
for a swapfile?

> @@ -2073,7 +2073,7 @@ int nfs_wb_folio_cancel(struct inode *inode, struct folio *folio)
>   */
>  int nfs_wb_folio(struct inode *inode, struct folio *folio)
>  {
> -	loff_t range_start = folio_file_pos(folio);
> +	loff_t range_start = folio_pos(folio);
>  	loff_t range_end = range_start + (loff_t)folio_size(folio) - 1;

Likewise here.  Are we absolutely certain that swap I/O can't call this
function?

