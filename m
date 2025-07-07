Return-Path: <linux-fsdevel+bounces-54191-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB26AFBE51
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jul 2025 00:39:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 802E13B33DB
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Jul 2025 22:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C527288C1E;
	Mon,  7 Jul 2025 22:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YSAw3x7U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD4A218E8B;
	Mon,  7 Jul 2025 22:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751927926; cv=none; b=EIh8as7wAxkJwq7jjOzxwHL8QraM6JEQ5nEgtfwTEck37oibE7gRu/pcQZo/DqYIBYBtDR8i7VU8AVug9+KxFvss3L8jhI5vvUNMUkYH72dj/m3kIFHpSqZzHOwwCr9kd+2DKjmFxOPFM994bS45wXyZffwSllZXf3+AAs9zndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751927926; c=relaxed/simple;
	bh=ZHXT1F7ky+DycoXihHKVXqJluWPUcKdBjSeD3GvA/+A=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ceeAIGrlQNs5QM2h84LvRnbcTRRXUqAbnxktLEquSsqnsDUCsoBUDFbEsy2KNzpYbMcxZo3311rfa3zOuJ39d28WmWG57t0+G1C+dSdxRayVXEgUo5y37K11M5k68tiYOtD5mTf2U4DKOokTSVj4NC1a1tGYlJSnsCpcC6D1Mgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=YSAw3x7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE78C4CEE3;
	Mon,  7 Jul 2025 22:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1751927925;
	bh=ZHXT1F7ky+DycoXihHKVXqJluWPUcKdBjSeD3GvA/+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YSAw3x7U+rLv0xQ3x1tri6xBUf3RSx1Lf09XEKM6xTP3BH2qsTDBNFS46u3XnaNg7
	 F4nv5BPXF743X+05Ox8CW1NTguMNSbS2F7UYzJeoNGhMT2QT2DwZ34fcAWUiQwwVKX
	 RWG3UPR0cQrbhw01mez3XDUz/hs/isiqUlz5mBuA=
Date: Mon, 7 Jul 2025 15:38:44 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Ryan Roberts
 <ryan.roberts@arm.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>, Zi Yan
 <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Michal Hocko <mhocko@suse.com>, David
 Hildenbrand <david@redhat.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Thomas Gleixner <tglx@linutronix.de>, Nico
 Pache <npache@redhat.com>, Dev Jain <dev.jain@arm.com>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Jens Axboe <axboe@kernel.dk>,
 linux-kernel@vger.kernel.org, willy@infradead.org, linux-mm@kvack.org,
 x86@kernel.org, linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
 gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 0/5] add static PMD zero page support
Message-Id: <20250707153844.d868f7cfe16830cce66f3929@linux-foundation.org>
In-Reply-To: <20250707142319.319642-1-kernel@pankajraghav.com>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Jul 2025 16:23:14 +0200 "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com> wrote:

> There are many places in the kernel where we need to zeroout larger
> chunks but the maximum segment we can zeroout at a time by ZERO_PAGE
> is limited by PAGE_SIZE.
> 
> This concern was raised during the review of adding Large Block Size support
> to XFS[1][2].
> 
> This is especially annoying in block devices and filesystems where we
> attach multiple ZERO_PAGEs to the bio in different bvecs. With multipage
> bvec support in block layer, it is much more efficient to send out
> larger zero pages as a part of a single bvec.
> 
> Some examples of places in the kernel where this could be useful:
> - blkdev_issue_zero_pages()
> - iomap_dio_zero()
> - vmalloc.c:zero_iter()
> - rxperf_process_call()
> - fscrypt_zeroout_range_inline_crypt()
> - bch2_checksum_update()
> ...
> 
> We already have huge_zero_folio that is allocated on demand, and it will be
> deallocated by the shrinker if there are no users of it left.
> 
> At moment, huge_zero_folio infrastructure refcount is tied to the process
> lifetime that created it. This might not work for bio layer as the completions
> can be async and the process that created the huge_zero_folio might no
> longer be alive.

Can we change that?  Alter the refcounting model so that dropping the
final reference at interrupt time works as expected?

And if we were to do this, what sort of benefit might it produce?

> Add a config option STATIC_PMD_ZERO_PAGE that will always allocate
> the huge_zero_folio via memblock, and it will never be freed.

