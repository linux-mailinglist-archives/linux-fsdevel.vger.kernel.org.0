Return-Path: <linux-fsdevel+bounces-74760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BqeAoAdcGlRVwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-74760-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:27:44 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 717CE4E7DE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 01:27:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9B9F7A26B7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Jan 2026 00:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AEB279DC9;
	Wed, 21 Jan 2026 00:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZcjHq1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4673277CBF
	for <linux-fsdevel@vger.kernel.org>; Wed, 21 Jan 2026 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768955254; cv=none; b=HLkgrVdvgnrwxB16DNBm5d4WTc76Oi2ymFnG+4EBV9W1fZSZp2LlLBm6U5nryWCJdH1LQe1H33C89c+Hi6MVMdkYuUjlL0JIXEWYGyNTn9zv5L1yf8rtu9sEfKguLyn9wI0+e0+9AugsxvOim+cgOMUJ99AKXZS/8NKs2h9A1vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768955254; c=relaxed/simple;
	bh=tqrIn/rvJhREjbNiNmFvH5kp0Rrgg/owpt/3USFyP34=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Erq7kRRWH3ZArqx1iFWdStRKiJhuXc5IfYjTEwCWd+Jkvjh8p4VlTvzVs7jD5/02Q5XKMIl/K8Mf1sFrcqt9ZEOFkiU64rAm7pj8nnMvV/s+1KJd/svNRifyqCsq6eHYlfRZMxoFXzCisI9vffgEOHVqqEfrUE/PWSuoL2hYBJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZcjHq1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E0FC16AAE;
	Wed, 21 Jan 2026 00:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768955254;
	bh=tqrIn/rvJhREjbNiNmFvH5kp0Rrgg/owpt/3USFyP34=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eZcjHq1hg2jkwBVHhg26EN+xHVS5OBwWJCCb+2Ag2La1oELlX5VYgdO1wAm2WrfWg
	 Qm7vRgAZtCH7vQXHNHpBlLI/d+4n7s9penNhW4IUi5B2k1Cbv3Ds5a4/Hfh7k7SVDk
	 9Go5zyEMkXcFDT8TeGRbVosIpEzu8BfVsrbs1F8NkGKIchSn3ZuBMqfb0yfuPx70Ut
	 w3hdkrlk7UCM2jD2J4GD1cY6JtphQ4Sag02GS7Vaywqq7NzJdlnz9/DcevWYQdJ7Vb
	 cvLft7WFEN9vVHbMYdIH4jsyf2R/10lVPWhgXAJc9W3rhcNu6peNm4MpIgMYRjoiXl
	 SOlM0DlVkGqlg==
Date: Tue, 20 Jan 2026 16:27:33 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, jefflexu@linux.alibaba.com, luochunsheng@ustc.edu,
	horst@birthelmer.de, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] fuse: simplify logic in fuse_notify_store() and
 fuse_retrieve()
Message-ID: <20260121002733.GH15532@frogsfrogsfrogs>
References: <20260120224449.1847176-1-joannelkoong@gmail.com>
 <20260120224449.1847176-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120224449.1847176-3-joannelkoong@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-74760-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 717CE4E7DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 02:44:47PM -0800, Joanne Koong wrote:
> Simplify the folio parsing logic in fuse_notify_store() and
> fuse_retrieve().
> 
> In particular, calculate the index by tracking pos, which allows us to
> remove calculating nr_pages, and use "pos" in place of outarg's offset
> field.
> 
> Suggested-by: Jingbo Xu <jefflexu@linux.alibaba.com>
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>

Looks fine to me,
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> ---
>  fs/fuse/dev.c | 42 +++++++++++++++++-------------------------
>  1 file changed, 17 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> index 7558ff337413..9cbd5b64d9c9 100644
> --- a/fs/fuse/dev.c
> +++ b/fs/fuse/dev.c
> @@ -1765,10 +1765,9 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  	struct address_space *mapping;
>  	u64 nodeid;
>  	int err;
> -	pgoff_t index;
> -	unsigned int offset;
>  	unsigned int num;
>  	loff_t file_size;
> +	loff_t pos;
>  	loff_t end;
>  
>  	if (size < sizeof(outarg))
> @@ -1785,7 +1784,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		return -EINVAL;
>  
>  	nodeid = outarg.nodeid;
> -	num = min(outarg.size, MAX_LFS_FILESIZE - outarg.offset);
> +	pos = outarg.offset;
> +	num = min(outarg.size, MAX_LFS_FILESIZE - pos);
>  
>  	down_read(&fc->killsb);
>  
> @@ -1795,10 +1795,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		goto out_up_killsb;
>  
>  	mapping = inode->i_mapping;
> -	index = outarg.offset >> PAGE_SHIFT;
> -	offset = outarg.offset & ~PAGE_MASK;
>  	file_size = i_size_read(inode);
> -	end = outarg.offset + num;
> +	end = pos + num;
>  	if (end > file_size) {
>  		file_size = end;
>  		fuse_write_update_attr(inode, file_size, num);
> @@ -1808,19 +1806,18 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		struct folio *folio;
>  		unsigned int folio_offset;
>  		unsigned int nr_bytes;
> -		unsigned int nr_pages;
> +		pgoff_t index = pos >> PAGE_SHIFT;
>  
>  		folio = filemap_grab_folio(mapping, index);
>  		err = PTR_ERR(folio);
>  		if (IS_ERR(folio))
>  			goto out_iput;
>  
> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> -		nr_bytes = min_t(unsigned, num, folio_size(folio) - folio_offset);
> -		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
> +		folio_offset = offset_in_folio(folio, pos);
> +		nr_bytes = min(num, folio_size(folio) - folio_offset);
>  
>  		err = fuse_copy_folio(cs, &folio, folio_offset, nr_bytes, 0);
> -		if (!folio_test_uptodate(folio) && !err && offset == 0 &&
> +		if (!folio_test_uptodate(folio) && !err && folio_offset == 0 &&
>  		    (nr_bytes == folio_size(folio) || file_size == end)) {
>  			folio_zero_segment(folio, nr_bytes, folio_size(folio));
>  			folio_mark_uptodate(folio);
> @@ -1831,9 +1828,8 @@ static int fuse_notify_store(struct fuse_conn *fc, unsigned int size,
>  		if (err)
>  			goto out_iput;
>  
> +		pos += nr_bytes;
>  		num -= nr_bytes;
> -		offset = 0;
> -		index += nr_pages;
>  	}
>  
>  	err = 0;
> @@ -1865,7 +1861,6 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  {
>  	int err;
>  	struct address_space *mapping = inode->i_mapping;
> -	pgoff_t index;
>  	loff_t file_size;
>  	unsigned int num;
>  	unsigned int offset;
> @@ -1876,15 +1871,16 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  	size_t args_size = sizeof(*ra);
>  	struct fuse_args_pages *ap;
>  	struct fuse_args *args;
> +	loff_t pos = outarg->offset;
>  
> -	offset = outarg->offset & ~PAGE_MASK;
> +	offset = offset_in_page(pos);
>  	file_size = i_size_read(inode);
>  
>  	num = min(outarg->size, fc->max_write);
> -	if (outarg->offset > file_size)
> +	if (pos > file_size)
>  		num = 0;
> -	else if (num > file_size - outarg->offset)
> -		num = file_size - outarg->offset;
> +	else if (num > file_size - pos)
> +		num = file_size - pos;
>  
>  	num_pages = (num + offset + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  	num_pages = min(num_pages, fc->max_pages);
> @@ -1907,31 +1903,27 @@ static int fuse_retrieve(struct fuse_mount *fm, struct inode *inode,
>  	args->in_pages = true;
>  	args->end = fuse_retrieve_end;
>  
> -	index = outarg->offset >> PAGE_SHIFT;
> -
>  	while (num && ap->num_folios < num_pages) {
>  		struct folio *folio;
>  		unsigned int folio_offset;
>  		unsigned int nr_bytes;
> -		unsigned int nr_pages;
> +		pgoff_t index = pos >> PAGE_SHIFT;
>  
>  		folio = filemap_get_folio(mapping, index);
>  		if (IS_ERR(folio))
>  			break;
>  
> -		folio_offset = ((index - folio->index) << PAGE_SHIFT) + offset;
> +		folio_offset = offset_in_folio(folio, pos);
>  		nr_bytes = min(folio_size(folio) - folio_offset, num);
> -		nr_pages = (offset + nr_bytes + PAGE_SIZE - 1) >> PAGE_SHIFT;
>  
>  		ap->folios[ap->num_folios] = folio;
>  		ap->descs[ap->num_folios].offset = folio_offset;
>  		ap->descs[ap->num_folios].length = nr_bytes;
>  		ap->num_folios++;
>  
> -		offset = 0;
> +		pos += nr_bytes;
>  		num -= nr_bytes;
>  		total_len += nr_bytes;
> -		index += nr_pages;
>  	}
>  	ra->inarg.offset = outarg->offset;
>  	ra->inarg.size = total_len;
> -- 
> 2.47.3
> 
> 

