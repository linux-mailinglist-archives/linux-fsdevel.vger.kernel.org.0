Return-Path: <linux-fsdevel+bounces-28088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C94D69669EC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 21:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80A7B1F275FC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2024 19:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 167DF1BD4E5;
	Fri, 30 Aug 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLr54w9n"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623AE13B297;
	Fri, 30 Aug 2024 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725046659; cv=none; b=oAFinWNVkeSj84SxYlkruvzP6QX8VNUcoRIC/eqzbAoudnClxwH1hzzkSXEmeBSI8FInKecvV7WtPoylGgC/UevtfFWXFnGine2BnF3du7LyX3v9rRJIPW61q5aW10sr5n8CrSsHCHCDGF+BAnQcMbwVQo8RRmMwJreiB7esYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725046659; c=relaxed/simple;
	bh=v3d7EKw2yuV1k8Hz2elbexd9JBuH6XYQLtf2c00vq/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYJmUpp7uukLkQgquCSLRgplbWjB4RGM7mAtFnjOUcEzNc3Crz6YVckk0vkaQDdykztm8LLR7SaPs6SnS4vBXlmKBq3PWQX8hz/02mlR3B7N6fyqy/X9CD51x+5wgbQz9kPW9uKYXnxRFV08dCk/WKtF7s2BbHGjlNHX+81pFSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLr54w9n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9E2C4CEC2;
	Fri, 30 Aug 2024 19:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725046658;
	bh=v3d7EKw2yuV1k8Hz2elbexd9JBuH6XYQLtf2c00vq/k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLr54w9nrwwffnWVcVwe85e2U0sUFE6Rteuo8tg8YPSaD6fjekoNQRKZqr+FqFCYY
	 5i1l6EX9pcxMJV8g81aenchLLpzoLrhkLIcbT/lH1tONy0s8HRAlmZE3o7AdAiSz2N
	 HnX0aWD+5Cog6xS5OjHLB0DjHzre+z55zu9P49D2fhxmrhsgAqWv/YhN5uHmvfXOJC
	 izvx205zHg4AxXHDSfZF5rW5gKIoJ2sVxiXCw5OAsNdxU2/4XSSrcfEQxikbCmLL4r
	 mA+O7H90sHI2UxdPc3Wm5O0xhJYRr6F5n2spSuFAkjCPyVOR8IEhrRX7QIWYks2PK0
	 D7qrC09hlEbjw==
Date: Fri, 30 Aug 2024 09:37:37 -1000
From: Tejun Heo <tj@kernel.org>
To: Haifeng Xu <haifeng.xu@shopee.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
	tytso@mit.edu, yi.zhang@huaweicloud.com, yukuai1@huaweicloud.com,
	linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] buffer: Associate the meta bio with blkg from buffer page
Message-ID: <ZtIfgc1CcG9XOu0-@slm.duckdns.org>
References: <20240828033224.146584-1-haifeng.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828033224.146584-1-haifeng.xu@shopee.com>

Hello, Haifeng.

On Wed, Aug 28, 2024 at 11:32:24AM +0800, Haifeng Xu wrote:
...
> The filesystem is ext4(ordered). The meta data can be written out by
> writeback, but if there are too many dirty pages, we had to do
> checkpoint to write out the meta data in current thread context.
> 
> In this case, the blkg of thread1 has set io.max, so the j_checkpoint_mutex
> can't be released and many threads must wait for it. However, the blkg from
> buffer page didn' set any io policy. Therefore, for the meta buffer head,
> we can associate the bio with blkg from the buffer page instead of current
> thread context.
> 
> Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
> ---
>  fs/buffer.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index e55ad471c530..a7889f258d0d 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -2819,6 +2819,17 @@ static void submit_bh_wbc(blk_opf_t opf, struct buffer_head *bh,
>  	if (wbc) {
>  		wbc_init_bio(wbc, bio);
>  		wbc_account_cgroup_owner(wbc, bh->b_page, bh->b_size);
> +	} else if (buffer_meta(bh)) {
> +		struct folio *folio;
> +		struct cgroup_subsys_state *memcg_css, *blkcg_css;
> +
> +		folio = page_folio(bh->b_page);
> +		memcg_css = mem_cgroup_css_from_folio(folio);
> +		if (cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
> +		    cgroup_subsys_on_dfl(io_cgrp_subsys)) {
> +			blkcg_css = cgroup_e_css(memcg_css->cgroup, &io_cgrp_subsys);
> +			bio_associate_blkg_from_css(bio, blkcg_css);

I think the right way to do it is marking the bio with REQ_META and
implement forced charging in blk-throtl similar to blk-iocost.

Thanks.

-- 
tejun

