Return-Path: <linux-fsdevel+bounces-15366-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5AB88CF96
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 22:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F4D11C63C11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 21:05:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63DC213D523;
	Tue, 26 Mar 2024 21:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vcWq09x/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDE67353B;
	Tue, 26 Mar 2024 21:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711487134; cv=none; b=E+hOETjvMRwzQeCl1PbNNz1bpic14mDrjyOmLf7j5Sy+0QwD12JIhtsno52DUGCqvpAAMH+9glQm6K5vz4BVvs5yVd6qYFeSY1zVWQw77QadzHOUqYhDBkKyKfyx91vJ/3ZQUkLzknrDRTmp6C7kqLVFU82IihfjxwWmC4yfRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711487134; c=relaxed/simple;
	bh=jYAeRqI/a9Wl9HNgHsa8qq4ThtqyFYAJMlxgrSsJjU4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VFa8QFinxo4Ek0t6osuY0BAqIsQ3BDjvWWFbiwOZDe/+7Fp4NRCpebt99ti3K7kCFJpMndijkqr1Md1Vczq0ZdRqZc1fxD0eVJkcV02V2AR/HjGKAEtyXSgSUSX27W1bFyhdVWiWnVkXnSshjDOu3kU8Kq/QTkCVLXyszlRoeiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vcWq09x/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54545C433C7;
	Tue, 26 Mar 2024 21:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1711487134;
	bh=jYAeRqI/a9Wl9HNgHsa8qq4ThtqyFYAJMlxgrSsJjU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vcWq09x/OCqEpGMMd/b85oYWK2rDTnBqZ4ffVYAQjNY8WOHpXqkUbc55i1pKvpkA2
	 e+pIkYKDcOfnNFhZZkoO6i3pb3tefI9oOJ3vwI7iOutQ4JJwFuuoEGnyYp5nXIDrae
	 lTuMUZ2xEvD//rEGfGB0xo/MgqL78Ksld94KOAZU=
Date: Tue, 26 Mar 2024 14:05:33 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Soma Nakata <soma.nakata01@gmail.com>
Cc: linux-mm@kvack.org, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: set folio->mapping to NULL before
 xas_store()
Message-Id: <20240326140533.a0d0041371e21540dd934722@linux-foundation.org>
In-Reply-To: <20240322210455.3738-1-soma.nakata01@gmail.com>
References: <20240322210455.3738-1-soma.nakata01@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Mar 2024 06:04:54 +0900 Soma Nakata <soma.nakata01@gmail.com> wrote:

> Functions such as __filemap_get_folio() check the truncation of
> folios based on the mapping field. Therefore setting this field to NULL
> earlier prevents unnecessary operations on already removed folios.
> 
> ...
>
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -139,11 +139,12 @@ static void page_cache_delete(struct address_space *mapping,
>  
>  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>  
> +	folio->mapping = NULL;
> +	/* Leave page->index set: truncation lookup relies upon it */
> +
>  	xas_store(&xas, shadow);
>  	xas_init_marks(&xas);
>  
> -	folio->mapping = NULL;
> -	/* Leave page->index set: truncation lookup relies upon it */
>  	mapping->nrpages -= nr;
>  }

Seems at least harmless, but I wonder if it can really make any
difference.  Don't readers of folio->mapping lock the folio first?

