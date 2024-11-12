Return-Path: <linux-fsdevel+bounces-34416-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 437D89C5216
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 10:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10D71F2311C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 09:33:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792620E31C;
	Tue, 12 Nov 2024 09:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="xjBcNWO9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nlcp8EFB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6935820DD7B;
	Tue, 12 Nov 2024 09:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403919; cv=none; b=LkJ5ykhdxB2+F4rskPHNVD/P0ut5Ewj1za0uF2iUuP6WlID3LEZisMiM7YwyBN3j2WJgOAogl74p0MVLKveju1Cep+uFweGieW4LCGURflHxvCVoRv7SO2WJiHvB7MYFhTsv8nw++FGfegT1Z19vreapWaMFM3DCpmt/iQjnH5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403919; c=relaxed/simple;
	bh=Ebx2GMsXRC20bvaOcUXZ1jrU+HoF9xODvZsps2HiEA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hF8owf7BFktzEc/9ypqPI132Yvnf9JVhU4P6rVxBA2hj7tNh9sI7NLnZ7NeY2KQ/J/OXYbdXp2bHozeG/HZbbo1nUiJWPpM0xOztQVUF9Gk2FbPuG5K1gwDT0voUFKheo4Vf6aTeSTjfDiY7a/VKxUISYRQDKSq9ZYBqoZJo+QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=xjBcNWO9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nlcp8EFB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 23AC211401E3;
	Tue, 12 Nov 2024 04:31:56 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 Nov 2024 04:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731403915; x=
	1731490315; bh=FNlD3yPiuWbAqLIV7df6vsprp48I6w6nBmNGvoAwP9I=; b=x
	jBcNWO9IjhEwVG69snNMP2cVKfiSF+T/WgMRoXX9WM2UOkn4xBbFryL9MEIZOZmr
	dSgQq2vyN9mGmE0uirM3PCswTym/cB0TwQcULav1Dt/ZLcc3/nkhG6oGx0HW9cPF
	e9CnR1RPAjYbc9BTUdw5CcrRihrlfNHrJrSic4SOhjhzDjGhkn99J9mBw5Po5kMN
	5s0IXX8uRR7+vcuBHR/+ksxX3/a8w5gjCKEvc9Wwq/8FMvIU334N4o3HA95A7DuQ
	hPtRQO6Ayy+jYJk86DE+h8o3FNxmxcbmjEQVBOF/wRytPKYWk/gMGmuJ+6nHh18H
	5Pi/wL4Hg+VT8vVc2cg0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731403915; x=1731490315; bh=FNlD3yPiuWbAqLIV7df6vsprp48I6w6nBmN
	GvoAwP9I=; b=nlcp8EFBp3zKT6lrkjB1fbLOxMHHB8nQRmAPaInKCvSSbumtsur
	GrjU7DBjELcgTStMHU3tgHquiS7xFPcNTsDuZuZvUA5l2nbwuMaEoYZzxVZbQKRN
	Ay/rJnoFcTZ091nSErflIkpd67cj74epKCTmvMl4zX6xTz4MBTuXzjdonNFINvjI
	UeVba9Y3PgxsFtCXDPICKg2z7+aaZRoaSBaC4sTvoUBSFhkH74zRX41p0OZeszey
	IEsod7+bFCWmtM4S+HVLR771UzfXMpmNw5ctLLH5Xt51vROn/MC4VkGDag6lBu29
	dmYzbWOHbbL5ssZwDD/53ebCLavyVgPTujw==
X-ME-Sender: <xms:iyAzZ91xTfF_hYxgovCuiN6yTSDKfknMpfnQZatQnaiYw0-EPyOkrQ>
    <xme:iyAzZ0El-Dedh0Hh-oKli7rD8aS1zsLRDurV_O8J43U1EgQFCzr0rVuWZ8erS0Qay
    ZV2298N8rv7pTUiN3s>
X-ME-Received: <xmr:iyAzZ96abHMMjsPOz3Hw9fGndyoDzBzjqjpNKXSd99o3oc-axUadHylKUchQqSt1-EbpNQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffev
    lefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htoheprgigsghovgeskhgvrhhnvghlrdgukhdprhgtphhtthhopehlihhnuhigqdhmmhes
    khhvrggtkhdrohhrghdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdho
    rhhgpdhrtghpthhtoheptghlmhesmhgvthgrrdgtohhmpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfihilhhl
    hiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdgsthhrfhhsse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqvgigthegsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:iyAzZ63Q7EXiOk7JFUBF4NXVRXcrY7M9lUiAuOYgCFDX7e8xqTDEyQ>
    <xmx:iyAzZwEMECv2sF_yk7YNAWFWD0uuCcmwAVQqxB7sE26U9nXMUKkLUA>
    <xmx:iyAzZ7-ecDABuj_G5ZdJLL8xEv_IAN7O8x1TvLzD4NtaR6qTaPuZDw>
    <xmx:iyAzZ9nCRDsZWKm0D_ybKmAfH8R60w6pphF4HYh144lDv9rCIoS8PA>
    <xmx:iyAzZ4-gBXBjFkQyYDazj6Ch3P9CUI59NMJDadTHCveJ6rDIOOxTMVPd>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Nov 2024 04:31:51 -0500 (EST)
Date: Tue, 12 Nov 2024 11:31:48 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org, 
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 09/16] mm/filemap: drop uncached pages when writeback
 completes
Message-ID: <mxh6husr25uw6u7wgp4p3stqcsxh6uek2hjktfwof3z6ayzdjr@4t4s3deim7dd>
References: <20241111234842.2024180-1-axboe@kernel.dk>
 <20241111234842.2024180-10-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234842.2024180-10-axboe@kernel.dk>

On Mon, Nov 11, 2024 at 04:37:36PM -0700, Jens Axboe wrote:
> If the folio is marked as uncached, drop pages when writeback completes.
> Intended to be used with RWF_UNCACHED, to avoid needing sync writes for
> uncached IO.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  mm/filemap.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 3d0614ea5f59..40debe742abe 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1600,6 +1600,27 @@ int folio_wait_private_2_killable(struct folio *folio)
>  }
>  EXPORT_SYMBOL(folio_wait_private_2_killable);
>  
> +/*
> + * If folio was marked as uncached, then pages should be dropped when writeback
> + * completes. Do that now. If we fail, it's likely because of a big folio -
> + * just reset uncached for that case and latter completions should invalidate.
> + */
> +static void folio_end_uncached(struct folio *folio)
> +{
> +	/*
> +	 * Hitting !in_task() should not happen off RWF_UNCACHED writeback, but
> +	 * can happen if normal writeback just happens to find dirty folios
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
> +
>  /**
>   * folio_end_writeback - End writeback against a folio.
>   * @folio: The folio.
> @@ -1610,6 +1631,8 @@ EXPORT_SYMBOL(folio_wait_private_2_killable);
>   */
>  void folio_end_writeback(struct folio *folio)
>  {
> +	bool folio_uncached = false;
> +
>  	VM_BUG_ON_FOLIO(!folio_test_writeback(folio), folio);
>  
>  	/*
> @@ -1631,9 +1654,14 @@ void folio_end_writeback(struct folio *folio)
>  	 * reused before the folio_wake_bit().
>  	 */
>  	folio_get(folio);
> +	if (folio_test_uncached(folio) && folio_test_clear_uncached(folio))
> +		folio_uncached = true;

Hm? Maybe

	folio_uncached = folio_test_clear_uncached(folio);

?

>  	if (__folio_end_writeback(folio))
>  		folio_wake_bit(folio, PG_writeback);
>  	acct_reclaim_writeback(folio);
> +
> +	if (folio_uncached)
> +		folio_end_uncached(folio);
>  	folio_put(folio);
>  }
>  EXPORT_SYMBOL(folio_end_writeback);
> -- 
> 2.45.2
> 

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

