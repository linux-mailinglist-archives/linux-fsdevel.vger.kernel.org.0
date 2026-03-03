Return-Path: <linux-fsdevel+bounces-79125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLKPLZ6hpmlqRwAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 09:53:50 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E6A1EB288
	for <lists+linux-fsdevel@lfdr.de>; Tue, 03 Mar 2026 09:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 519AA31081C1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2026 08:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D0E388E75;
	Tue,  3 Mar 2026 08:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQFhgWr1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B0F277017;
	Tue,  3 Mar 2026 08:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772527707; cv=none; b=TZ0gwTk5A0ifYTE1Hh5K3VbMT+Z/DOg7cPHUO1udvB6TzMr7rKXkYj54gHaNLEweCRPczIcUk1J+Qlflz7dQIFkM80KVuGGmArwm9FhwCU1154O6KGH/uZFJyXv66kTe8G24fibYK1heOm9+uPHqnTh8v+zShUFz6zJ9RgDFYv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772527707; c=relaxed/simple;
	bh=epD00FefbJXRoRgkmbGok8xKZSTpyougdaUkz5Nbp/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S5HRx4d2rodn00/13equAThKbLFjWd6EqFN8cG+Xj0+P2VZvGu1aKRNXM2zNC/1oaGmOkKdnOOKmNy8A8tZccgI0hiwyutZQjlRYHdLjMA5Y5p5DktCpyRqJNi46Z7rnWeUKZZ6GcSa4ZBL+/tMcQWLHEwylX3cj/kNs1E5kSGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQFhgWr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F38F9C116C6;
	Tue,  3 Mar 2026 08:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772527706;
	bh=epD00FefbJXRoRgkmbGok8xKZSTpyougdaUkz5Nbp/Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sQFhgWr1bBwgDvH5hRq8G47VTi6WQCJ47jZwoimCj2jKA7Enu2hks2eyJoG2hcuu9
	 +T9aQKru/QcnhjqptMENpxixzOMs7BYgp1Ca4+8tHTygnwlYHehpvkmwb2pQrx7Id0
	 1rpjAeAG2ZA5qwxzkzlpxPNxwKhlXEux0+4Y056pdU6ojid6y/I7WySaGK1iYBObpw
	 9rzO6kLeeuQSv3dClKh6EI6i+efYyyiX2Pt3cOhHVAOOI0AfY3Qh1kpiBJloV1+FLF
	 9g+dbil+xnT1DQ4OIKE3h5qWQSP4bHu8NbGxtESdCq0SCAJUCTIyEMpNnRyR992wNP
	 foYgUBA1GAOYg==
Message-ID: <56a23a23-cbed-4ace-acef-3ada41bc182d@kernel.org>
Date: Tue, 3 Mar 2026 09:48:19 +0100
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
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>,
 Matthew Wilcox <willy@infradead.org>, Bas van Dijk <bas@dfinity.org>,
 Eero Kelly <eero.kelly@dfinity.org>,
 Andrew Battat <andrew.battat@dfinity.org>,
 Adam Bratschi-Kaye <adam.bratschikaye@dfinity.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260302203159.3208341-1-ziy@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260302203159.3208341-1-ziy@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 18E6A1EB288
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79125-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david@kernel.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,nvidia.com:email,dfinity.org:email]
X-Rspamd-Action: no action

On 3/2/26 21:31, Zi Yan wrote:
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
>    path) and reads the mapped file continuously with 16 threads,
> 4. in the parent process, uses madvise(MADV_REMOVE) to punch poles in the
>    large folio.
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
> 
> Fixes: 00527733d0dc8 ("mm/huge_memory: add two new (not yet used) functions for folio_split()")
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Reported-by: Bas van Dijk <bas@dfinity.org>
> Closes: https://lore.kernel.org/all/CAKNNEtw5_kZomhkugedKMPOG-sxs5Q5OLumWJdiWXv+C9Yct0w@mail.gmail.com/
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Cc: <stable@vger.kernel.org>
> ---
>  mm/huge_memory.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 56db54fa48181..f0bdac3f270b5 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -3647,6 +3647,7 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  	const bool is_anon = folio_test_anon(folio);
>  	int old_order = folio_order(folio);
>  	int start_order = split_type == SPLIT_TYPE_UNIFORM ? new_order : old_order - 1;
> +	struct folio *old_folio = folio;
>  	int split_order;
>  
>  	/*
> @@ -3668,11 +3669,17 @@ static int __split_unmapped_folio(struct folio *folio, int new_order,
>  			 * irq is disabled to allocate enough memory, whereas
>  			 * non-uniform split can handle ENOMEM.
>  			 */
> -			if (split_type == SPLIT_TYPE_UNIFORM)
> -				xas_split(xas, folio, old_order);
> -			else {

Just wondering whether we should no move the comment over here now, so
it just covers both cases.

> +			if (split_type == SPLIT_TYPE_UNIFORM) {
> +				xas_split(xas, old_folio, old_order);
> +			} else {
>  				xas_set_order(xas, folio->index, split_order);
> -				xas_try_split(xas, folio, old_order);
> +				/*
> +				 * use the to-be-split folio, so that a parallel
> +				 * folio_try_get() waits on it until xarray is
> +				 * updated with after-split folios and
> +				 * the original one is unfrozen.
> +				 */
> +				xas_try_split(xas, old_folio, old_order);
>  				if (xas_error(xas))
>  					return xas_error(xas);
>  			}

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David

