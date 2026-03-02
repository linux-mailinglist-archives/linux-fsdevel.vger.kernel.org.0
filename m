Return-Path: <linux-fsdevel+bounces-78929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ms0LjerpWmpDgAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78929-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:22:31 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB021DBBB6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 02 Mar 2026 16:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 99B90305393D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Mar 2026 15:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4130387597;
	Mon,  2 Mar 2026 15:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oT5+jyWw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1B840148E
	for <linux-fsdevel@vger.kernel.org>; Mon,  2 Mar 2026 15:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772464314; cv=none; b=mmgYCGhFLBY/Te+DkUzqdW5ekKteQzXU4reM5miT3/klcsCBqL1RxQhyQuEixQOdN8wW867fc14syE1r/s2++s9Y7Jtx32rIAP2er213t8UheMpKNB8NgdTudevLWTubUuwcfVWnFoPhKULLkAHX2+2nOlEOHesuVRL5wVXudHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772464314; c=relaxed/simple;
	bh=KCBtXYwww92nUUG2zAgJgef7ktaJj2c3DTMGMJdUk1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s5d37cn+/odsbkBmvvgUlf/StQ9ZIXecdoxbQYJZ4ZrvoAV4V1Qir0nWuOnf4OBhOF2+MSli0+sRaAcoOsJTCtDHsH7sqGo14XNPitGixdrFEJsTKd1JyjJzEDcU9aUohGatp85Q7irQS/mru0tWzM1Et5HndlpfwYJJsctSj6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oT5+jyWw; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6a568d3c-daf3-46ba-a3ce-0a0deca824c2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772464301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXXw9BNPUOHdywM1sGGDpV4CuKnSXirRfOqdKTWATAU=;
	b=oT5+jyWwG/YxILKJmwFoom9NuVkMPFACb21bQYP02+BuJNutRR82NYY4ImmIDBhgFQ/5gR
	sfpjsJtrYJFEB8GJg9Fx1BbwjJqXGIgL+gQPoU7+5lJI75HtJA2X/KGCd0sgCBDh2FnPzG
	hZGcZvbRoFHZQzg6m6SI1Dz7B6yg2fE=
Date: Mon, 2 Mar 2026 23:11:27 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] mm/huge_memory: fix a folio_split() race condition with
 folio_try_get()
To: "David Hildenbrand (Arm)" <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 Bas van Dijk <bas@dfinity.org>, Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260228010614.2536430-1-ziy@nvidia.com>
 <d9e30bef-621f-444a-a1b0-510c50927d9b@linux.dev>
 <64fa6a73-8952-4ee1-b7c3-8b0ebef3ea78@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <64fa6a73-8952-4ee1-b7c3-8b0ebef3ea78@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BEB021DBBB6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78929-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid,nvidia.com:email,dfinity.org:email]
X-Rspamd-Action: no action



On 2026/3/2 22:28, David Hildenbrand (Arm) wrote:
> On 2/28/26 04:10, Lance Yang wrote:
>>
>>
>> On 2026/2/28 09:06, Zi Yan wrote:
>>> During a pagecache folio split, the values in the related xarray
>>> should not
>>> be changed from the original folio at xarray split time until all
>>> after-split folios are well formed and stored in the xarray. Current use
>>> of xas_try_split() in __split_unmapped_folio() lets some after-split
>>> folios
>>> show up at wrong indices in the xarray. When these misplaced after-split
>>> folios are unfrozen, before correct folios are stored via
>>> __xa_store(), and
>>> grabbed by folio_try_get(), they are returned to userspace at wrong file
>>> indices, causing data corruption.
>>>
>>> Fix it by using the original folio in xas_try_split() calls, so that
>>> folio_try_get() can get the right after-split folios after the original
>>> folio is unfrozen.
>>>
>>> Uniform split, split_huge_page*(), is not affected, since it uses
>>> xas_split_alloc() and xas_split() only once and stores the original folio
>>> in the xarray.
>>>
>>> Fixes below points to the commit introduces the code, but
>>> folio_split() is
>>> used in a later commit 7460b470a131f ("mm/truncate: use folio_split() in
>>> truncate operation").
>>>
>>> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used)
>>> functions for folio_split()")
>>> Reported-by: Bas van Dijk <bas@dfinity.org>
>>> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-
>>> sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
>>> Signed-off-by: Zi Yan <ziy@nvidia.com>
>>> Cc: <stable@vger.kernel.org>
>>> ---
>>
>> Thanks for the fix!
>>
>> I also made a C reproducer and tested this patch - the corruption
>> disappeared.
> 
> Should we link that reproducer somehow from the patch description?

Yes, the original reproducer provided by Bas is available here[1].

Regarding the C reproducer, Zi plans to add it to selftests in a
follow-up patch (as we discussed off-list).

[1] https://github.com/dfinity/thp-madv-remove-test

Cheers,
Lance

