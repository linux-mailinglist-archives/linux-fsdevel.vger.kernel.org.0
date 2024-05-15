Return-Path: <linux-fsdevel+bounces-19534-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DF88C69CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 17:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59BF81C212D0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 15:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92A2156230;
	Wed, 15 May 2024 15:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GNj+3l13"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF0015575F;
	Wed, 15 May 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715787167; cv=none; b=l9gUT4LHP1OZzZYBnqelChQvEuMPhGrrW3oI75bky6uC+FhuuN7VhCGtFU46T8ZcqBfUCbWloRfziWSDOnb6tgN3snraaVDDsccGuKCzCq2JnqfWABFxFoQvqkzYhpaTJyMrSpsvbd50s4DF8v5G7o0PCXezfFngU75aA1Quu5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715787167; c=relaxed/simple;
	bh=rTr0ZwCN0KdjUd9KikyXdcy97IGdX7z3vq0LokO2akg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWqafrFY0wysO1Xzrl1r2+ttlK01AG5dDboM+nfGMyXPQfZ/M6bsnTF6m7CgX4GxBQOzkX548Edv6e9qlMbtEXSxJAlc2SVa7Y2GBkRDPjTJP8KBHSMT1vr2nLSNfU8fzHKqZtwP1snNKbnKthDDrKX6/82csKuEX+wa8LQIdo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GNj+3l13; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=eHwfVCsafGWvDE2TzhnqZg+hhQAlEsxHQ1ZY8ZtSmbY=; b=GNj+3l13CuwiMRDMw3zv0BrxQF
	v31PKlvcnCFAzhv0Ka9pkJo6IS4saac/L9JyyvIETVT8oeuzU9V7xXNFyaW7OcjDgIrRR29+0QLsG
	sy002gR8DfLW2b3W7t600g3i5FXw4v5QeY08x5oyXJut9o6CVxRFotgBDzbm/J1Fk36nF9Cmbg96z
	gnbUu3Frc90Od/IdaRRM8R/t/Zh1tAC59LwDojYZ36vQ3ZeTN06WWyeE7Q93Ew5kdBm1IeWAioVST
	yas1kZb5oF9Tp2u9lqGw6Q71mCe4Rkf+DZ10XIzdM308xo4mDkBMvR6IBpz30t+nUFMvAbWDufbtU
	jDd8bkew==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s7GcO-0000000Ab1Q-0wAA;
	Wed, 15 May 2024 15:32:36 +0000
Date: Wed, 15 May 2024 16:32:36 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: akpm@linux-foundation.org, djwong@kernel.org, brauner@kernel.org,
	david@fromorbit.com, chandan.babu@oracle.com, hare@suse.de,
	ritesh.list@gmail.com, john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <ZkTVlOQXxfa2VHXo@casper.infradead.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-6-mcgrof@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240503095353.3798063-6-mcgrof@kernel.org>

On Fri, May 03, 2024 at 02:53:47AM -0700, Luis Chamberlain wrote:
> +int split_folio_to_list(struct folio *folio, struct list_head *list);

...

> +static inline int split_folio_to_list(struct page *page, struct list_head *list)
> +{

Type mismatch.  Surprised the build bots didn't whine yet.

>  
> +		min_order = mapping_min_folio_order(folio->mapping);
> +		if (new_order < min_order) {
> +			VM_WARN_ONCE(1, "Cannot split mapped folio below min-order: %u",
> +				     min_order);
> +			ret = -EINVAL;
> +			goto out;
> +		}

Wouldn't we prefer this as:

		if (VM_WARN_ONCE(new_order < min_order,
				"Cannot split mapped folio below min-order: %u",
				min_order) {
			ret = -EINVAL;
			goto out;
		}


