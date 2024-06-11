Return-Path: <linux-fsdevel+bounces-21475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A518E904670
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 23:53:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E1EAB233A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 21:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAD715383D;
	Tue, 11 Jun 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="C2bNg4Do"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D613152E05;
	Tue, 11 Jun 2024 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718142778; cv=none; b=HXEnABL1S0MUpr9feONADuX+6hUBF5C1H4xOcwAT2i3KRbgj0H8PdNUmAqeIkqHJDstHQm9jQG+InqFDZGqH+MEZSQSp54Zj77iDVhFoI+PH/iW6EdRSXAEv1CRQf7H65RiT0mLeUDMM7b66UZk7gVKLaMasbUK/VW4miI7roFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718142778; c=relaxed/simple;
	bh=bN3kTxm6Ndk0I7NTtl4/N+CXYAErUn5s3+b6HXKCZMk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=rTt9SckCBbGek3tGRCBias5RQI8Umb9CWDRFpga6RFBZnCT26PQAQrBnO/Sh54mBf0X7kz2k0bGO5S9veVLAjQc2XRAZ9CGuQksNBpd5lyCi7Bd9ZE3RNqdJvmiB61+ay0WMwzXDcSuz7r7a9buJJc4rKlCFti8OLfYt0HX8pOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=C2bNg4Do; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66CD1C2BD10;
	Tue, 11 Jun 2024 21:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718142777;
	bh=bN3kTxm6Ndk0I7NTtl4/N+CXYAErUn5s3+b6HXKCZMk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=C2bNg4DoM4HoolXmLSzJ1vZMdAExYVg2RPsmEocPT2zFiStkz6q6W01AmaaSbMtAw
	 mpwMJmn0Ooh2s+oNjRJHJdjdMFykPBFOP79nDqqGmtkkhbe9dklllkFJIAqDLnP2Bq
	 dWQYB4t8jq5o8Sti+judvhxj9aN4nWP5gQ1j9CCg=
Date: Tue, 11 Jun 2024 14:52:56 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: willy@infradead.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] writeback: factor out balance_wb_limits to remove
 repeated code
Message-Id: <20240611145256.41a857beb521df61cff1695a@linux-foundation.org>
In-Reply-To: <20240606033547.344376-1-shikemeng@huaweicloud.com>
References: <20240606033547.344376-1-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 11:35:47 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> Factor out balance_wb_limits to remove repeated code
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  mm/page-writeback.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/mm/page-writeback.c b/mm/page-writeback.c
> index bf050abd9053..f611272d3c5b 100644
> --- a/mm/page-writeback.c
> +++ b/mm/page-writeback.c
> @@ -1783,6 +1783,21 @@ static inline void wb_dirty_exceeded(struct dirty_throttle_control *dtc,
>  		((dtc->dirty > dtc->thresh) || strictlimit);
>  }
>  
> +/*
> + * The limits fileds dirty_exceeded and pos_ratio won't be updated if wb is
> + * in freerun state. Please don't use these invalid fileds in freerun case.

s/fileds/fields/.  I queued a fix for this.

> + */
> +static void balance_wb_limits(struct dirty_throttle_control *dtc,
> +			      bool strictlimit)
> +{
> +	wb_dirty_freerun(dtc, strictlimit);
> +	if (dtc->freerun)
> +		return;
> +
> +	wb_dirty_exceeded(dtc, strictlimit);
> +	wb_position_ratio(dtc);
> +}
> +
>  /*
>   * balance_dirty_pages() must be called by processes which are generating dirty
>   * data.  It looks at the number of dirty pages in the machine and will force
> @@ -1869,12 +1884,9 @@ static int balance_dirty_pages(struct bdi_writeback *wb,
>  		 * Calculate global domain's pos_ratio and select the
>  		 * global dtc by default.
>  		 */
> -		wb_dirty_freerun(gdtc, strictlimit);
> +		balance_wb_limits(gdtc, strictlimit);
>  		if (gdtc->freerun)
>  			goto free_running;

Would it be neater to do

		if (balance_wb_limits(...))
			goto free_running;

?

That would require a balance_wb_limits() comment update and probably
name change.  Just a thought.


