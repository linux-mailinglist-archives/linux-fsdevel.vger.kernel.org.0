Return-Path: <linux-fsdevel+bounces-50780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B6CACF879
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 21:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79A5916FBCE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 19:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80627D791;
	Thu,  5 Jun 2025 19:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="hLooBr5K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B101616FF37;
	Thu,  5 Jun 2025 19:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153446; cv=none; b=QQG9ogjsEBaH2I+c7B3U42eHsLsII8YQn0XqRLb0SOtQK3HKDf2Hjkbk+xo6t5I9pGvF5q3c6PiFgIQ4+VNfNbMg1o8yba/PoD5OBZ7HCvusARCG1z+9vWognXqBXpgivPUfGQaX+Yrqe1KyRo3WhdhPg6ygCM+xmS3nUml8GBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153446; c=relaxed/simple;
	bh=1u8lfpAO42Ly1Adp2rWOcQfq7JPHMSczCMk7/C3j4QA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=E6mMDFvxzc98DnZ36Ss+oA015mRmVm0ntvzOtzi3ZdtXJnMbb0sEQm78VOp9X3hpOZ/zGJgPFnAgYLf9UBxGGYwOMM9iOZoYg6J8DHcRnvO9KbHTLkEfXwWnXTo7s/4QovcHQTaY9d28P/+AMl1eOZXOWDEqVq6DJt1TYKD7CzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=hLooBr5K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08152C4CEE7;
	Thu,  5 Jun 2025 19:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749153445;
	bh=1u8lfpAO42Ly1Adp2rWOcQfq7JPHMSczCMk7/C3j4QA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hLooBr5KY9DQTeDlulfLIviETs7q2vSYR7FamOkzeGc/MKCoH26Ynb9m9h8AqVn5B
	 pdxTenQkJgFQ9M2aYtoP8thiTNlcEqaHKDqNMrHfqzZktN4uR1Kxz6U/QdLAfCeQF6
	 VgBLSRPPTePFj0wbig2U/E5ZfLi+J5V93V2wXL8I=
Date: Thu, 5 Jun 2025 12:57:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
Message-Id: <20250605125724.d2e3db9c23af7627a53d8914@linux-foundation.org>
In-Reply-To: <20250605221037.7872-2-shikemeng@huaweicloud.com>
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
	<20250605221037.7872-2-shikemeng@huaweicloud.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  6 Jun 2025 06:10:31 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> As noted in the comments, we need to release block usage for swap entry
> which was replaced with poisoned swap entry. However, no block usage is
> actually freed by calling shmem_recalc_inode(inode, -nr_pages, -nr_pages).
> Instead, call shmem_recalc_inode(inode, 0, -nr_pages) can correctly release
> the block usage.
> 
> ...
>
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
>  	 * in shmem_evict_inode().
>  	 */
> -	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
> +	shmem_recalc_inode(inode, 0, -nr_pages);
>  	swap_free_nr(swap, nr_pages);
>  }

Huh, three years ago.  What do we think might be the userspace-visible
runtime effects of this?


