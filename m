Return-Path: <linux-fsdevel+bounces-18950-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5648BEEB6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 23:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6704C2867AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 May 2024 21:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA96E14B967;
	Tue,  7 May 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WqdrQV8i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2951878C76;
	Tue,  7 May 2024 21:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715116275; cv=none; b=BGmTTPVlqnJtFd6lYsnJ8iULVrgD19zbJjlIkCmQHtHFAaBIbj0NXjfPh0g+nTa8MZ3DHHUdqTytDeUPNjfSYHjku3rbcoyVi+FgWjWe/x69XAKGbVTlrIvUApBHqtXeYcWU0vdpoZnG67bKlY4UM8MMV90gHgdhMcwOKDkAtUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715116275; c=relaxed/simple;
	bh=N17paVKsvnHlMoVYYbGAwSs5ZZJ5KRuS1vQScRvlcjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oElh/bv3Bg518xCRLBYDdAjMTzCsJrHP5hyY8nSO1KdVCZlyASuPpcWAcb+Gvm6gkqlvmD0JbfsNoCm2e8zitAYgH3M8LN/wFbNjJ+8E3enHdKXKTE3HIL8BHsnWgw5a6QNlGhnvvdM231lJDZs1V7MFYrHpZm2WyRptwzjyqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WqdrQV8i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFC5C2BBFC;
	Tue,  7 May 2024 21:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715116275;
	bh=N17paVKsvnHlMoVYYbGAwSs5ZZJ5KRuS1vQScRvlcjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WqdrQV8insRznhS1yS8bFigi9YWERuZXqwTfAJ03UGBVCbiEEmW/kxgojAjC0agF7
	 HMb94pFs5CoDoZ4OixNdFLDT4aXt/g/0EFpsaCb982WWXI/RQ+2XLGeyV/Jq1o7H8p
	 IXLNGPSLcUREpmxiQ6VUM93dnxbl0EIqo2DkVEqTms0gonZRfDCtyaTG2ZBy4vvvu7
	 ugrLjXODLxx89Znxlv9mxSG042NmyIkvzPsHih6e9KtNmtT5ewUfI7Kd/E2/GIZ1hK
	 64EN7mqB2nzqljWLrQLfB6gPBELzjcv7N49ukWuSPijpMdkWUsBcY7XKOfnJBSoetb
	 7xycCDWKc3VHg==
Date: Tue, 7 May 2024 14:11:14 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Cc: linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCHv2 2/2] iomap: Optimize iomap_read_folio
Message-ID: <20240507211114.GU360919@frogsfrogsfrogs>
References: <cover.1715067055.git.ritesh.list@gmail.com>
 <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ae9f3333c9a7e66214568d08f45664261c899c.1715067055.git.ritesh.list@gmail.com>

On Tue, May 07, 2024 at 02:25:43PM +0530, Ritesh Harjani (IBM) wrote:
> iomap_readpage_iter() handles "uptodate blocks" and "not uptodate blocks"
> within a folio separately. This makes iomap_read_folio() to call into
> ->iomap_begin() to request for extent mapping even though it might already
> have an extent which is not fully processed.
> This happens when we either have a large folio or with bs < ps. In these
> cases we can have sub blocks which can be uptodate (say for e.g. due to
> previous writes). With iomap_read_folio_iter(), this is handled more
> efficiently by not calling ->iomap_begin() call until all the sub blocks
> with the current folio are processed.
> 
> iomap_read_folio_iter() handles multiple sub blocks within a given
> folio but it's implementation logic is similar to how
> iomap_readahead_iter() handles multiple folios within a single mapped
> extent. Both of them iterate over a given range of folio/mapped extent
> and call iomap_readpage_iter() for reading.
> 
> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
> cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I like this improved changelog, it'e easier to understand why
_read_folio_iter needs to exist.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/iomap/buffered-io.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
> index 9f79c82d1f73..a9bd74ee7870 100644
> --- a/fs/iomap/buffered-io.c
> +++ b/fs/iomap/buffered-io.c
> @@ -444,6 +444,24 @@ static loff_t iomap_readpage_iter(const struct iomap_iter *iter,
>  	return pos - orig_pos + plen;
>  }
> 
> +static loff_t iomap_read_folio_iter(const struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx)
> +{
> +	struct folio *folio = ctx->cur_folio;
> +	size_t offset = offset_in_folio(folio, iter->pos);
> +	loff_t length = min_t(loff_t, folio_size(folio) - offset,
> +			      iomap_length(iter));
> +	loff_t done, ret;
> +
> +	for (done = 0; done < length; done += ret) {
> +		ret = iomap_readpage_iter(iter, ctx, done);
> +		if (ret <= 0)
> +			return ret;
> +	}
> +
> +	return done;
> +}
> +
>  int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  {
>  	struct iomap_iter iter = {
> @@ -459,7 +477,7 @@ int iomap_read_folio(struct folio *folio, const struct iomap_ops *ops)
>  	trace_iomap_readpage(iter.inode, 1);
> 
>  	while ((ret = iomap_iter(&iter, ops)) > 0)
> -		iter.processed = iomap_readpage_iter(&iter, &ctx, 0);
> +		iter.processed = iomap_read_folio_iter(&iter, &ctx);
> 
>  	if (ret < 0)
>  		folio_set_error(folio);
> --
> 2.44.0
> 
> 

