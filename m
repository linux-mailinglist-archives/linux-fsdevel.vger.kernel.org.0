Return-Path: <linux-fsdevel+bounces-7944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5022982DAF0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 15:07:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6660B21985
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jan 2024 14:06:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B98C1758F;
	Mon, 15 Jan 2024 14:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vATJg++B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FA17584;
	Mon, 15 Jan 2024 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=k+DYOQ+yWRd2pgMIRz/5wGINWA2P7yC/o6J+Q7W5b70=; b=vATJg++BpawwIU6E3l3nCyM/fl
	CR1jGpmQB/8Vq7OxY1+wQ2R/Hf3ne8n0WN2AvXfif1DigL2m2rVPRPfBIGHsnUly6m2P18LQsHeeE
	pv+B6kcZ03YpFkpKUaN87vnGX7uiFbMHtRfudt/fZlAfUY3gjxMPFrspblYKei4oeLsyxJS6XNYy4
	LqB76AJULX5LYDl+H6w6rAl7am/wUSRx0JzXHryKNdYAP90XSPckLxOj9SUfy7eZIE7Kyi9Iei+Yr
	r2XvhpG935/rETqKfQZjY4lEZGAuxuj/0flXZIbbrxN+farXylvZfJ9RJiRByx9wkGofpA3ZAue1Z
	aDzeDz7g==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rPNbh-009rfH-Cs; Mon, 15 Jan 2024 14:06:29 +0000
Date: Mon, 15 Jan 2024 14:06:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-erofs@lists.ozlabs.org, David Howells <dhowells@redhat.com>,
	Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, Chao Yu <chao@kernel.org>,
	Yue Hu <huyue2@coolpad.com>, Jeffle Xu <jefflexu@linux.alibaba.com>
Subject: Re: [PATCH v2 3/4] erofs: Don't use certain internal folio_*()
 functions
Message-ID: <ZaU75cT0jx9Ya+6G@casper.infradead.org>
References: <20240115083337.1355191-1-hsiangkao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240115083337.1355191-1-hsiangkao@linux.alibaba.com>

On Mon, Jan 15, 2024 at 04:33:37PM +0800, Gao Xiang wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Filesystems should use folio->index and folio->mapping, instead of
> folio_index(folio), folio_mapping() and folio_file_mapping() since
> they know that it's in the pagecache.
> 
> Change this automagically with:
> 
> perl -p -i -e 's/folio_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_file_mapping[(]([^)]*)[)]/\1->mapping/g' fs/erofs/*.c
> perl -p -i -e 's/folio_index[(]([^)]*)[)]/\1->index/g' fs/erofs/*.c
> 
> Reported-by: Matthew Wilcox <willy@infradead.org>
> Signed-off-by: David Howells <dhowells@redhat.com>
> Reviewed-by: Jeff Layton <jlayton@kernel.org>
> Cc: Chao Yu <chao@kernel.org>
> Cc: Yue Hu <huyue2@coolpad.com>
> Cc: Jeffle Xu <jefflexu@linux.alibaba.com>
> Cc: linux-erofs@lists.ozlabs.org
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
> Hi folks,
> 
> I tend to apply this patch upstream since compressed data fscache
> adaption touches this part too.  If there is no objection, I'm
> going to take this patch separately for -next shortly..

Could you change the subject?  It's not that the functions are
"internal", it's that filesystems don't need to use them because they're
guaranteed to not see swap pages.  Maybe just s/internal/unnecessary/

> Thanks,
> Gao Xiang
> 
> Change since v1:
>  - a better commit message pointed out by Jeff Layton.
> 
>  fs/erofs/fscache.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
> index 87ff35bff8d5..bc12030393b2 100644
> --- a/fs/erofs/fscache.c
> +++ b/fs/erofs/fscache.c
> @@ -165,10 +165,10 @@ static int erofs_fscache_read_folios_async(struct fscache_cookie *cookie,
>  static int erofs_fscache_meta_read_folio(struct file *data, struct folio *folio)
>  {
>  	int ret;
> -	struct erofs_fscache *ctx = folio_mapping(folio)->host->i_private;
> +	struct erofs_fscache *ctx = folio->mapping->host->i_private;
>  	struct erofs_fscache_request *req;
>  
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>  				folio_pos(folio), folio_size(folio));
>  	if (IS_ERR(req)) {
>  		folio_unlock(folio);
> @@ -276,7 +276,7 @@ static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
>  	struct erofs_fscache_request *req;
>  	int ret;
>  
> -	req = erofs_fscache_req_alloc(folio_mapping(folio),
> +	req = erofs_fscache_req_alloc(folio->mapping,
>  			folio_pos(folio), folio_size(folio));
>  	if (IS_ERR(req)) {
>  		folio_unlock(folio);
> -- 
> 2.39.3
> 

