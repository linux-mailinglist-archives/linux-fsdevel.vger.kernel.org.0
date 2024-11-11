Return-Path: <linux-fsdevel+bounces-34202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF0D9C3AB2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 10:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 061C91F21E91
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 09:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B259172BD5;
	Mon, 11 Nov 2024 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="LekmzLgi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F1c+RZqI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF44B155330;
	Mon, 11 Nov 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731316635; cv=none; b=jUArSxJFtPdkTzJORcyi+jSVGViS6Hs8YVRaJap1OWCE9gxWBZaD4hLoSx1fxXvR0ofiPeMNX6j6T6kGRtI6k7U9TAUpS/NK9gN2IYRrUkRKp+sid3lLxr5LpHrH+TChiTgcaUaMsTp0MABodQhTmR65AbV0slWN33nc8GvUwEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731316635; c=relaxed/simple;
	bh=ckYPYgW/v4vmdXHfm/iNhh8JzZotLLEJV6rNnzwjaSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dIvWvLBztZzP5IlL/a+RPjmol+c9/PWqHWB1usp40AaNrEYh7xSHpfGb9pNQCkjh7oy4jPzZriOLXFDd2ZKcjQiiXPur1j/3tjJh/KNXjiQINsvBte5mKajHM7Sf2srGaA/3EwvwR63bnAt/sjXnulvdFKQlFIhz4DeBxBUYsR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=LekmzLgi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F1c+RZqI; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id D55FF2540092;
	Mon, 11 Nov 2024 04:17:12 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 04:17:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731316632; x=
	1731403032; bh=XmE3W7zetRFDLRGbYnAfuW8ktkcE5sxS4dONI2aWK9o=; b=L
	ekmzLgiqx0Wv2UAa1SzpB10lqdpkCl9CQIw0/J0rCpvM0TGiL3ubC2O7PCe5ia06
	rM2oouUZManNnhvwSs5RaoC9UTJPqNhg2VPCY1w2DjN0ItiiyXZkRgFy4N8n7PGP
	cuP5g3yMgtUNKdj7sVU470RdLCeTYHUFZxlR1u1E75l3Wu1ny4EZy49MvoRbRNkB
	ZMXqfoAagOAeizFJCzMBqbce/4+LCvH6Wg+eFLEOk+at3zMDokGcgh7I/rsdFxaH
	RLnDVa/uMECchEo9h7vr6TDvTdDIsuuXdzsril3CiwSwLHJUmvIextdSZroMrTp6
	C0BXm7qM5e11SH0DbjcRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731316632; x=1731403032; bh=XmE3W7zetRFDLRGbYnAfuW8ktkcE5sxS4dO
	NI2aWK9o=; b=F1c+RZqIrDFmV3pW5Jd4pDJLeZRq4Vqnb8Q00u6Njhx2p4S41+8
	tkZLE8zcria+Hi0+odfoBaNrgdVovfZXHicJaX2sUN1fuhORoHExYhYu7Z6MVwsc
	j9j4tk2RzmzxAkjvG7J6WqrEy1LptSpMtlzMbsGBLyq0j3tw4eor4Udmn5Wa/3Oj
	eljEQHqNqAn10QXDFeFQJrQWu7boe1p8m3GUEowqNjM8ZXkmi67d96SoEHa2EDkN
	DrzSO7REjUrfFyVYH6cO2S53LbpNg4W/CAeALOcQAPfVVvzPQZrrmirGoAhQ/m/5
	euW9flcHZxMJiXLbbR+EYTytrmST5kRSHbw==
X-ME-Sender: <xms:mMsxZ6bfXLeTZbCO5qbawodzSD-F4Ee_7PeVfRIPsJwvx05yrI3U8Q>
    <xme:mMsxZ9Z5eOwzxI9JOHu4cPdILBR0GHezg3dyr9FqqoxCjc-7EnxsmxCa_aDP0eHge
    eAM3_g5FW535tKfSnU>
X-ME-Received: <xmr:mMsxZ098askg9K6WSFk9HDBE5fG-lgpe1MvHnaNV5xRqUrxoKyukjb-OR17VMrEStW4ERg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgddtvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddttddvnecu
    hfhrohhmpedfmfhirhhilhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhessh
    hhuhhtvghmohhvrdhnrghmvgeqnecuggftrfgrthhtvghrnhepffdvveeuteduhffhffev
    lefhteefveevkeelveejudduvedvuddvleetudevhfeknecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdr
    nhgrmhgvpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtth
    hopegrgigsohgvsehkvghrnhgvlhdrughkpdhrtghpthhtoheplhhinhhugidqmhhmsehk
    vhgrtghkrdhorhhgpdhrtghpthhtoheplhhinhhugidqfhhsuggvvhgvlhesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhr
    ghdprhgtphhtthhopegtlhhmsehmvghtrgdrtghomhdprhgtphhtthhopehlihhnuhigqd
    hkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopeifihhllhih
    sehinhhfrhgruggvrggurdhorhhg
X-ME-Proxy: <xmx:mMsxZ8pTvc3bHJY4tCGSFA8xk8DAq7RHPK1TH48DrlG4adz3djfEJA>
    <xmx:mMsxZ1rtX1nidtYNXJ4rzuJUdW2dn0DIJ2mJ1J5rKqRf9MvikTrJdA>
    <xmx:mMsxZ6SH9ZiFRZucW9NnMAuy097JpV-9uGMJLe6bvDGwYI5Bm389fg>
    <xmx:mMsxZ1qqNW7wsCeKdj9gKPbn6jmYMQ1pdTADSQjFNQVTgRnI2lhOwg>
    <xmx:mMsxZ5Il7GLjh_VpfXAcHQbKBqFThS1TY1vCigb6TXo17ebCjdeKI0Rn>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 04:17:09 -0500 (EST)
Date: Mon, 11 Nov 2024 11:17:06 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 09/15] mm/filemap: drop uncached pages when writeback
 completes
Message-ID: <2tkpzi5y2dzihcji6byngv53qjyklcforon2fnnxsmkduwiue3@vfqxataeqdaw>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-10-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241110152906.1747545-10-axboe@kernel.dk>

On Sun, Nov 10, 2024 at 08:28:01AM -0700, Jens Axboe wrote:
> If the folio is marked as uncached, drop pages when writeback completes.
> Intended to be used with RWF_UNCACHED, to avoid needing sync writes for
> uncached IO.
> 
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  mm/filemap.c | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/mm/filemap.c b/mm/filemap.c
> index bd698340ef24..efd02b047541 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1600,6 +1600,23 @@ int folio_wait_private_2_killable(struct folio *folio)
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
> +	bool reset = true;
> +
> +	if (folio_trylock(folio)) {
> +		reset = !invalidate_complete_folio2(folio->mapping, folio, 0);
> +		folio_unlock(folio);

The same problem with folio_mapped() here.

> +	}
> +	if (reset)
> +		folio_set_uncached(folio);
> +}
> +
>  /**
>   * folio_end_writeback - End writeback against a folio.
>   * @folio: The folio.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

