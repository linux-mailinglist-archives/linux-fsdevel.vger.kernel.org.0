Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC2BB1AC1AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Apr 2020 14:45:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636262AbgDPMpq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Apr 2020 08:45:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:48730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2636256AbgDPMpo (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:45:44 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC457208E4;
        Thu, 16 Apr 2020 12:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587041143;
        bh=3KyXh0MP4mZkOqfe5RfSHynnSjW05VbwhqHccC5ChQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zeXvRYDpN5hER0ZYWmDihR/9Gyu/Tnb6knJ230KQEP4f8kvJmf59qXXNT1MPZaiZv
         vXln21iBv+OLcLG6INd/tUlvSZxH/MzlL0SROgo3XICa4569hBblXzQxcc+0Z/pitO
         ALxF2uK40XUPBwsEcwYbS6Q7RggxXG9Vp9HAXPSY=
Date:   Thu, 16 Apr 2020 13:45:39 +0100
From:   Will Deacon <will@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH 1/2] mm: Remove definition of
 clear_bit_unlock_is_negative_byte
Message-ID: <20200416124536.GA32565@willie-the-truck>
References: <20200326122429.20710-1-willy@infradead.org>
 <20200326122429.20710-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200326122429.20710-2-willy@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Matthew,

Sorry I missed this, I'm over on @kernel.org now and don't have access to
my old @arm.com address anymore.

On Thu, Mar 26, 2020 at 05:24:28AM -0700, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> 
> This local definition hasn't been used since commit 84c6591103db
> ("locking/atomics, asm-generic/bitops/lock.h: Rewrite using
> atomic_fetch_*()") which provided a default definition.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Will Deacon <will.deacon@arm.com>
> ---
>  mm/filemap.c | 23 -----------------------
>  1 file changed, 23 deletions(-)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 80f7e1ae744c..312afbfcb49a 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1248,29 +1248,6 @@ void add_page_wait_queue(struct page *page, wait_queue_entry_t *waiter)
>  }
>  EXPORT_SYMBOL_GPL(add_page_wait_queue);
>  
> -#ifndef clear_bit_unlock_is_negative_byte
> -
> -/*
> - * PG_waiters is the high bit in the same byte as PG_lock.
> - *
> - * On x86 (and on many other architectures), we can clear PG_lock and
> - * test the sign bit at the same time. But if the architecture does
> - * not support that special operation, we just do this all by hand
> - * instead.
> - *
> - * The read of PG_waiters has to be after (or concurrently with) PG_locked
> - * being cleared, but a memory barrier should be unneccssary since it is
> - * in the same byte as PG_locked.
> - */
> -static inline bool clear_bit_unlock_is_negative_byte(long nr, volatile void *mem)
> -{
> -	clear_bit_unlock(nr, mem);
> -	/* smp_mb__after_atomic(); */
> -	return test_bit(PG_waiters, mem);
> -}
> -
> -#endif
> -

I'd really like to do this, but I worry that the generic definition still
isn't available on all architectures depending on how they pull together
their bitops.h. Have you tried building for alpha or s390? At a quick
glance, they look like they might fall apart :(

Will
