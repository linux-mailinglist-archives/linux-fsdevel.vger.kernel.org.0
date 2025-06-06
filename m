Return-Path: <linux-fsdevel+bounces-50793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1858ACFAB4
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 03:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0ED1171893
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Jun 2025 01:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7C12B9CD;
	Fri,  6 Jun 2025 01:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q0mAeVB4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB6617BCE;
	Fri,  6 Jun 2025 01:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749173284; cv=none; b=O4wtoOv07RvBzzrb5GynGilWhi+O0skab7c7gnvKlV+EGYcy5jR+8SwhYFLdpH2GmvW3mgq7on/Qifs6LwSskzMZ+hIKV4PhCVwM9nDy7URU5yNMQUSRHTofrQyGwumxvzmUtswIVc9MzvZOaIaSN19xDVl6A4RRUvuPOXbp5aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749173284; c=relaxed/simple;
	bh=0iKrL/n+MLFh0pCCbTB9JGw89j/b/nhbrgaZzkAxMu4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=sxaKyWtKFgP2Z2ts6T5/4TiBMZ4JoUURdsNiee8Rkt1Oh09R3Ohus6cyDv+ZAgRswpFO4gKQrWGQYjXNmL2P2l6UuM+RRqQOqIAGHLeZ6fpgJrRJ7SZ0CofFZu30cjGZlEq7s30SxTNAhKrdr4n2wZaO3JSv7r0S08Z8iY3i5Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Q0mAeVB4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0659EC4CEE7;
	Fri,  6 Jun 2025 01:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749173283;
	bh=0iKrL/n+MLFh0pCCbTB9JGw89j/b/nhbrgaZzkAxMu4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q0mAeVB4rEePRqck8J74qLvSR6giowX04BXsAcszmK9avuglxP2sgBkaCq6ERXmjv
	 CchR7WWg5EpKpXVNiJL9jtqfeKRaExqH7v8LJlCcRVdQjyHiNZ+0pKNTlVQ0343V1B
	 pRYqZYbl/lNk1iivZ3+i+BNDs3RxKVGdSx6GxkEo=
Date: Thu, 5 Jun 2025 18:28:02 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: hughd@google.com, baolin.wang@linux.alibaba.com, willy@infradead.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/7] mm: shmem: correctly pass alloced parameter to
 shmem_recalc_inode() to avoid WARN_ON()
Message-Id: <20250605182802.ec8d869bc02583cbc9de9648@linux-foundation.org>
In-Reply-To: <721923ac-4bb1-1b2b-fce5-9d957c535c97@huaweicloud.com>
References: <20250605221037.7872-1-shikemeng@huaweicloud.com>
	<20250605221037.7872-2-shikemeng@huaweicloud.com>
	<20250605125724.d2e3db9c23af7627a53d8914@linux-foundation.org>
	<721923ac-4bb1-1b2b-fce5-9d957c535c97@huaweicloud.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Jun 2025 09:11:37 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:

> >> --- a/mm/shmem.c
> >> +++ b/mm/shmem.c
> >> @@ -2145,7 +2145,7 @@ static void shmem_set_folio_swapin_error(struct inode *inode, pgoff_t index,
> >>  	 * won't be 0 when inode is released and thus trigger WARN_ON(i_blocks)
> >>  	 * in shmem_evict_inode().
> >>  	 */
> >> -	shmem_recalc_inode(inode, -nr_pages, -nr_pages);
> >> +	shmem_recalc_inode(inode, 0, -nr_pages);
> >>  	swap_free_nr(swap, nr_pages);
> >>  }
> > 
> > Huh, three years ago.  What do we think might be the userspace-visible
> > runtime effects of this?
> This could trigger WARN_ON(i_blocks) in shmem_evict_inode() as i_blocks
> is supposed to be dropped in the quota free routine.

I don't believe we've seen such a report in those three years so perhaps
no need to backport.  But it's a one-liner so let's backport ;) And
possibly [2/7] and [3/7] should receive the same treatment.

I don't think any of these need to be fast-tracked into mm-hotfixes so
please resend after a suitable review period and include the cc:stable
on those which -stable needs.

