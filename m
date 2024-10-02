Return-Path: <linux-fsdevel+bounces-30808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76DCC98E67F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 00:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8B7A1C21A16
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 22:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F181F19E968;
	Wed,  2 Oct 2024 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NaNQ5BFc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE7819CC31;
	Wed,  2 Oct 2024 22:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727909757; cv=none; b=B0y2MxHMeTyfj9wzswrQnwdHnOujljDaTnCZ5M0d0PtJIdWX9tWsu7RbcYp6X7bJEGjHdU/1I5rWMzFqiTLzU/A2yyfe/WahfVC6ZMlz7LzlY18Jz9LTvc6hLmMhCmbPVr/JD7hQZ+nfyiBfFtd7tFzP6xL1jnZRe7xEzyutJ1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727909757; c=relaxed/simple;
	bh=hISdmrroN3z/ouzw/ahGkbNjtKr7wuAcEVgGI4iucIA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=dMoMf6vsMMFlVZ7j2Q3Po0gkDZhSp6lZxv11ypu5OGDIU2p6UzAOMEGu3OnBM9/kH7NX8htNc85MHzkkBaj5sdxwz9asV86SuM4b45XRkjZ4fDWOpWtbmNzjad3fVW2f9i1i48GjGBKTEtJuJ338ywrNnvpTRIQRhbgZxhTR8zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NaNQ5BFc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72634C4CEC2;
	Wed,  2 Oct 2024 22:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1727909756;
	bh=hISdmrroN3z/ouzw/ahGkbNjtKr7wuAcEVgGI4iucIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NaNQ5BFc0EogH4hGv2L5VXb2PjEsbiIYyespXgp3cTKFOHhtiMd0IhN2R06wsYtDi
	 WqRouJj2Rex11BlXtzt+iQjz4hBpDNc9AehzwbTFL1zehH9m6DmovbFBL+xiU+MCu4
	 yhjC+ILDwpsDDDnFsi8Wl7Wviay4DKbZyMCC4XB4=
Date: Wed, 2 Oct 2024 15:55:55 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox
 <willy@infradead.org>, Yu Zhao <yuzhao@google.com>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Meta kernel team <kernel-team@meta.com>
Subject: Re: [PATCH] mm/truncate: reset xa_has_values flag on each iteration
Message-Id: <20241002155555.7fc4c6e294c75e2510426598@linux-foundation.org>
In-Reply-To: <20241002225150.2334504-1-shakeel.butt@linux.dev>
References: <20241002225150.2334504-1-shakeel.butt@linux.dev>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Oct 2024 15:51:50 -0700 Shakeel Butt <shakeel.butt@linux.dev> wrote:

> Currently mapping_try_invalidate() and invalidate_inode_pages2_range()
> traverses the xarray in batches and then for each batch, maintains and
> set the flag named xa_has_values if the batch has a shadow entry to
> clear the entries at the end of the iteration. However they forgot to
> reset the flag at the end of the iteration which cause them to always
> try to clear the shadow entries in the subsequent iterations where
> there might not be any shadow entries. Fixing it.
> 

So this is an efficiency thing, no other effects expected?

> --- a/mm/truncate.c
> +++ b/mm/truncate.c
> @@ -463,10 +463,10 @@ unsigned long mapping_try_invalidate(struct address_space *mapping,
>  	unsigned long ret;
>  	unsigned long count = 0;
>  	int i;
> -	bool xa_has_values = false;
>  
>  	folio_batch_init(&fbatch);
>  	while (find_lock_entries(mapping, &index, end, &fbatch, indices)) {
> +		bool xa_has_values = false;
>  		int nr = folio_batch_count(&fbatch);
>  
>  		for (i = 0; i < nr; i++) {
> @@ -592,7 +592,6 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  	int ret = 0;
>  	int ret2 = 0;
>  	int did_range_unmap = 0;
> -	bool xa_has_values = false;
>  
>  	if (mapping_empty(mapping))
>  		return 0;
> @@ -600,6 +599,7 @@ int invalidate_inode_pages2_range(struct address_space *mapping,
>  	folio_batch_init(&fbatch);
>  	index = start;
>  	while (find_get_entries(mapping, &index, end, &fbatch, indices)) {
> +		bool xa_has_values = false;
>  		int nr = folio_batch_count(&fbatch);
>  
>  		for (i = 0; i < nr; i++) {
> -- 
> 2.43.5

