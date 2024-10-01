Return-Path: <linux-fsdevel+bounces-30467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D922F98B8A0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 11:48:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C452F2813F3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Oct 2024 09:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 127BF19DFA6;
	Tue,  1 Oct 2024 09:48:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05CE72BAF1
	for <linux-fsdevel@vger.kernel.org>; Tue,  1 Oct 2024 09:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727776085; cv=none; b=f+oxMZmMVSoUQSkAf+pwcrpE61BN+V+/KiwT/qyXApJKFeH7EjRwkHJrUzx8XEYViVq5++CRjg5ZDa+XN+hqTEhTsVxaxz3O5Wz6NaREtkBok9S2GPbZSLBpDgH7IkGd6b+SuxArwgVCRIv6pel62yAHkwR/cJAgu90LHC5IHX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727776085; c=relaxed/simple;
	bh=JstjSzRX98qxQWqnfLsMllsEDmjl14O7nvcM2y5DxRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q2+2u7o6tAF43AJACRiNbII33JvcwvGxJeWkMz09YnR0TiRMe68mOuB9XbIKYQQVbakJ6PKjGyxJtRNF5Js1OzVqfCVkpWTBFjU9ZEC6ao+8Qq6gnv0hN01F0BOuM+Xyq2K+NtEkej2KB9sOt5AbL1OajHURKZ4zOhvs0YS9aXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 908AE339;
	Tue,  1 Oct 2024 02:48:25 -0700 (PDT)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4E9733F587;
	Tue,  1 Oct 2024 02:47:54 -0700 (PDT)
Date: Tue, 1 Oct 2024 10:47:47 +0100
From: Joey Gouly <joey.gouly@arm.com>
To: Omar Sandoval <osandov@osandov.com>
Cc: linux-fsdevel@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, kernel-team@fb.com,
	v9fs@lists.linux.dev, David Howells <dhowells@redhat.com>,
	Manu Bretelle <chantr4@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH] iov_iter: fix advancing slot in iter_folioq_get_pages()
Message-ID: <20241001094747.GA1483717@e124191.cambridge.arm.com>
References: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cbaf141ba6c0e2e209717d02746584072844841a.1727722269.git.osandov@fb.com>

On Mon, Sep 30, 2024 at 11:55:00AM -0700, Omar Sandoval wrote:
> From: Omar Sandoval <osandov@fb.com>
> 
> iter_folioq_get_pages() decides to advance to the next folioq slot when
> it has reached the end of the current folio. However, it is checking
> offset, which is the beginning of the current part, instead of
> iov_offset, which is adjusted to the end of the current part, so it
> doesn't advance the slot when it's supposed to. As a result, on the next
> iteration, we'll use the same folio with an out-of-bounds offset and
> return an unrelated page.
> 
> This manifested as various crashes and other failures in 9pfs in drgn's
> VM testing setup and BPF CI.
> 
> Fixes: db0aa2e9566f ("mm: Define struct folio_queue and ITER_FOLIOQ to handle a sequence of folios")
> Link: https://lore.kernel.org/linux-fsdevel/20240923183432.1876750-1-chantr4@gmail.com/
> Tested-by: Manu Bretelle <chantr4@gmail.com>
> Signed-off-by: Omar Sandoval <osandov@fb.com>
> ---
>  lib/iov_iter.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/iov_iter.c b/lib/iov_iter.c
> index 97003155bfac..1abb32c0da50 100644
> --- a/lib/iov_iter.c
> +++ b/lib/iov_iter.c
> @@ -1033,7 +1033,7 @@ static ssize_t iter_folioq_get_pages(struct iov_iter *iter,
>  		if (maxpages == 0 || extracted >= maxsize)
>  			break;
>  
> -		if (offset >= fsize) {
> +		if (iov_offset >= fsize) {
>  			iov_offset = 0;
>  			slot++;
>  			if (slot == folioq_nr_slots(folioq) && folioq->next) {

This fixes booting for me with my 9pfs rootfs. Tested on next-20241001+this patch.

Tested-by: Joey Gouly <joey.gouly@arm.com>

Thanks!

