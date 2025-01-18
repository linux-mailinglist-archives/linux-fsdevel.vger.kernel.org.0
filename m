Return-Path: <linux-fsdevel+bounces-39574-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A68A15B38
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 04:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D84E18875A6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jan 2025 03:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B5254769;
	Sat, 18 Jan 2025 03:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Jp2WhVhP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E013D8A0;
	Sat, 18 Jan 2025 03:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737170980; cv=none; b=kQSf48a9A+/Izww2SVOE42hQSFnqZZHvbTMBfUTfEw7qbCRc5PCKXofm+J31bIflM9cOhFi3tCxq0sG3g8VG3lZviMJaattxCb5R3/rb/VJHBZUlMTE2L/5dDMDi3wz2gimMa2DcESqut36B8NxNysi/AES7aeqZNRnA9t/oSIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737170980; c=relaxed/simple;
	bh=GJOK3VKA6vQutwRnnwPPgaj1kuuscZciY9AVSbxrG3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VYbS/W3QwRaMORKAZ8tCB+anFRoO15ELku/5oHvN35XSBaUQBVRMjPdJh41VRucUBrICa1E5ZTNdPDq8HxaqX89EwWPeO4NM2PuztnJ7Wkvxpj6gRX/Ie/D3cYHINDdsAYJwGDrzXMJh61ItSZUjFHSPr4su3/XK6aiWya/FPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Jp2WhVhP; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737170968; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=367ImpVEwmep7eE3O/hYvXrPuqpcxFBuOp5wnrMW828=;
	b=Jp2WhVhPL9t3VaBKaxZBeMTF8l2DsIUdR+qixuf6r6r6feVWWv8Ik12Yl2e0BHFKteXV5ZErOm866HZ8L2mdlr/tF1jnkWReoUr+nDiUfyuBVZv/Jo3+Utk7jLpJ3rxkXC69W32NSHdTaOLjQ7n+YJew5HwpQ2HxETScTOryOJE=
Received: from 30.221.144.93(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0WNqQlY8_1737170967 cluster:ay36)
          by smtp.aliyun-inc.com;
          Sat, 18 Jan 2025 11:29:28 +0800
Message-ID: <08fccb39-1405-4aa9-884b-b28a5f7aad59@linux.alibaba.com>
Date: Sat, 18 Jan 2025 11:29:25 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/12] mm/filemap: drop streaming/uncached pages when
 writeback completes
To: Jens Axboe <axboe@kernel.dk>, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org
Cc: hannes@cmpxchg.org, clm@meta.com, linux-kernel@vger.kernel.org,
 willy@infradead.org, kirill@shutemov.name, bfoster@redhat.com
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-10-axboe@kernel.dk>
Content-Language: en-US
From: Jingbo Xu <jefflexu@linux.alibaba.com>
In-Reply-To: <20241220154831.1086649-10-axboe@kernel.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/20/24 11:47 PM, Jens Axboe wrote:
> If the folio is marked as streaming, drop pages when writeback completes.
> Intended to be used with RWF_DONTCACHE, to avoid needing sync writes for
> uncached IO.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  mm/filemap.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index dd563208d09d..aa0b3af6533d 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1599,6 +1599,27 @@ int folio_wait_private_2_killable(struct folio *folio)
>  }
>  EXPORT_SYMBOL(folio_wait_private_2_killable);
>  
> +/*
> + * If folio was marked as dropbehind, then pages should be dropped when writeback
> + * completes. Do that now. If we fail, it's likely because of a big folio -
> + * just reset dropbehind for that case and latter completions should invalidate.
> + */
> +static void folio_end_dropbehind_write(struct folio *folio)
> +{
> +	/*
> +	 * Hitting !in_task() should not happen off RWF_DONTCACHE writeback,
> +	 * but can happen if normal writeback just happens to find dirty folios
> +	 * that were created as part of uncached writeback, and that writeback
> +	 * would otherwise not need non-IRQ handling. Just skip the
> +	 * invalidation in that case.
> +	 */
> +	if (in_task() && folio_trylock(folio)) {
> +		if (folio->mapping)
> +			folio_unmap_invalidate(folio->mapping, folio, 0);
> +		folio_unlock(folio);
> +	}
> +}

Sorry shouldn't folio_end_writeback() be called from IRQ context (of the
block device) when the IO completes?  This may be a stupid question, but
I just can't understand that...

-- 
Thanks,
Jingbo

