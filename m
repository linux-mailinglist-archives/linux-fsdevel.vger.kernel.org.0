Return-Path: <linux-fsdevel+bounces-79116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kHTPJkF7pml7QQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79116-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 07:10:09 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02AE11E9687
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 07:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2A6F304C7E9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 06:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D1336C9C7;
	Tue,  3 Mar 2026 06:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="SQPrslp2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4D7262F;
	Tue,  3 Mar 2026 06:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772518197; cv=none; b=tzmYf/3vZv4P2EVoMdDw24vDZamQ8MvIjDjY6M1fhBJW831339heQso5TIcLBxwR9IJ1ehyCtY9t+Qpw9tLzQKvzWJf8rJbN0UOm+qQ4kJnkBy3FeuePrEojf/OLjugGat+fPppZ8MZGYxliRR/uIhtbSKBeQX5Uk3NsE4OJ9UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772518197; c=relaxed/simple;
	bh=0XflVbJeIFpTthv+Tc/f4RNstF2v9036S1VSXfSAqyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbTboC5jRX7dgjGD+qatUhFGPnRDzlixYnE5kaEmoHCttgBSz0VancvlUFgOoNIMRpx58z8iXaFV93GKWG6Yr330RH5WrYP8VNB7CLyfyFHwXvyVNev0MWal8HkmzYCx9e9MmZzqRd2uz+3MUAAr1OduW3a5rzJeNJ05pD3ZQVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=SQPrslp2; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1772518187; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=D0Oz/gBHMRnkmhHlWpJAtY0D0OpxHNbkfHskxgg3IuM=;
	b=SQPrslp22Hsob7y6orBIzSs6Yl6kXurJZVIMvnBMoB/5z6RHSdsQ+ca20+n2qzA2JG84rV6SbBEQzWVWYaY//5fRiQuxAve16cwBEtrcSAoiUQQRcgaOfsqhPaSuPZz/mL4Vx7JAPAddBKzLX1/u1nJvY7nFON6NsYKZarxRXmc=
Received: from 30.74.144.119(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X-8iZBK_1772518175 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 03 Mar 2026 14:09:45 +0800
Message-ID: <b075109d-1f7e-470a-a84b-26ce6edff3b8@linux.alibaba.com>
Date: Tue, 3 Mar 2026 14:09:45 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm/huge_memory: fix a folio_split() race condition
 with folio_try_get()
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Hugh Dickins
 <hughd@google.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Matthew Wilcox <willy@infradead.org>,
 Bas van Dijk <bas@dfinity.org>, Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260302203159.3208341-1-ziy@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260302203159.3208341-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 02AE11E9687
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-9.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79116-lists,linux-fsdevel=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baolin.wang@linux.alibaba.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,alibaba.com:email,nvidia.com:email,linux.dev:email]
X-Rspamd-Action: no action



On 3/3/26 4:31 AM, Zi Yan wrote:
> During a pagecache folio split, the values in the related xarray should not
> be changed from the original folio at xarray split time until all
> after-split folios are well formed and stored in the xarray. Current use
> of xas_try_split() in __split_unmapped_folio() lets some after-split folios
> show up at wrong indices in the xarray. When these misplaced after-split
> folios are unfrozen, before correct folios are stored via __xa_store(), and
> grabbed by folio_try_get(), they are returned to userspace at wrong file
> indices, causing data corruption. More detailed explanation is at the
> bottom.
> 
> The reproducer is at: https://github.com/dfinity/thp-madv-remove-test
> It
> 1. creates a memfd,
> 2. forks,
> 3. in the child process, maps the file with large folios (via shmem code
>     path) and reads the mapped file continuously with 16 threads,
> 4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
>     large folio.
> 
> Data corruption can be observed without the fix. Basically, data from a
> wrong page->index is returned.
> 
> Fix it by using the original folio in xas_try_split() calls, so that
> folio_try_get() can get the right after-split folios after the original
> folio is unfrozen.
> 
> Uniform split, split_huge_page*(), is not affected, since it uses
> xas_split_alloc() and xas_split() only once and stores the original folio
> in the xarray. Change xas_split() used in uniform split branch to use
> the original folio to avoid confusion.
> 
> Fixes below points to the commit introduces the code, but folio_split() is
> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
> truncate operation").
> 
> More details:
> 
> For example, a folio f is split non-uniformly into f, f2, f3, f4 like
> below:
> +----------------+---------+----+----+
> |       f        |    f2   | f3 | f4 |
> +----------------+---------+----+----+
> but the xarray would look like below after __split_unmapped_folio() is
> done:
> +----------------+---------+----+----+
> |       f        |    f2   | f3 | f3 |
> +----------------+---------+----+----+
> 
> After __split_unmapped_folio(), the code changes the xarray and unfreezes
> after-split folios:
> 
> 1. unfreezes f2, __xa_store(f2)
> 2. unfreezes f3, __xa_store(f3)
> 3. unfreezes f4, __xa_store(f4), which overwrites the second f3 to f4.
> 4. unfreezes f.
> 
> Meanwhile, a parallel filemap_get_entry() can read the second f3 from the
> xarray and use folio_try_get() on it at step 2 when f3 is unfrozen. Then,
> f3 is wrongly returned to user.
> 
> After the fix, the xarray looks like below after __split_unmapped_folio():
> +----------------+---------+----+----+
> |       f        |    f    | f  | f  |
> +----------------+---------+----+----+
> so that the race window no longer exists.

Thanks for the detailed explanation. Make sense to me.

> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reported-by: Bas van Dijk <bas@dfinity.org>
> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Cc: <stable@vger.kernel.org>
> ---

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

