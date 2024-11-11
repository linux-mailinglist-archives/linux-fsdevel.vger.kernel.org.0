Return-Path: <linux-fsdevel+bounces-34260-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3579C422A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:52:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3F61B273DF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF60E19E98E;
	Mon, 11 Nov 2024 15:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="UDuNNtgK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RXlIDeTX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A125777;
	Mon, 11 Nov 2024 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731340313; cv=none; b=hX+lkmotTQP62veEl7WrB3d/3zIF3VRDG1MoDUvEA1hcYQ/1uqisW/UitafnT+9pIZIM5PWBuoPX8w7L7kOwrHD398YihaoXmN2LJV+/wlxwZBmJxwm5dbty44aUIlW0rmPj4onBbnfXUashXeJ+th/uTWN61kScn4cJ9JOrCoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731340313; c=relaxed/simple;
	bh=p0y/edzcANgZ9Yq4x1BTo288Tix9RxkWNx1rV1TI3ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcjNpVXjxp5WimI+4HjFEOErp3YkKEadSjdu3YYS0YxGGYPUaguqGWy88evkpRTR/ldWnuZ5+rCLX1T1CS9yK/WUusx0iyWHnhei+u/Bc6c+anJMGtH7Nboqa3xTlcCio3V9kl1PPFB4Z7NOKyFa4fKsTxRr7PaI4/wW4ea6Jxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=UDuNNtgK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RXlIDeTX; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 6552A1380679;
	Mon, 11 Nov 2024 10:51:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 11 Nov 2024 10:51:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731340311; x=
	1731426711; bh=sb7goKiV2lwec3DtIWx/4XS6HkWtaXhVKBL0qgh/MLk=; b=U
	DuNNtgK30tGFfgc46KCYp1pkTqcNpgfcP0jMEf+aU88lgw1/PHLKV913yGYrPBoS
	AHzH0TvfNj3XA0n1TBmwR8P8BbZtQ3JK/5i10JZaQ8rzxf9YfQ2y7Jtop+RECWRY
	N3Dv+SmVmTMfStL4r67tAl8u2NerCveEM2EbmCd+4AOisvYdfsEwzcZtBJa5FqoD
	4cwJ7vgKWgxDKTnvgUR3PaWePjGNA12xG/5brvw4qAUW3+iiKtqFrZwP/78e6LwX
	mU+R1ojclGqv5/NqLYSeHErEwpJ0sAd0D4tOJOCmPTUBYRGZYG2SnM9Lobd7Ga09
	Eoj6wxRj+PQcPWwE5lrtA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731340311; x=1731426711; bh=sb7goKiV2lwec3DtIWx/4XS6HkWtaXhVKBL
	0qgh/MLk=; b=RXlIDeTXFg8aCHV0FLht94dARccM2sXlLp1TjVtRCP7SNh0ZeXI
	3muWXleEigeqCHIsVaiX6Aupb3UwdMLgtI/LUBQ1L5dYQ6EsBr1HZNwIxFedqeWh
	z4uEgvSsA2eIjPTfOwIfg+5Q9de9qhL0btjXj3OVxs3ZEkkwJv2EchYKyop5lrl1
	1ax7EtxXVqCNh/rMPbDd+QTU97Z9r7FkCaJ1W3nCWSQ+y3yDfmS6Qi132+ANXP6h
	jPV2YhsxJ/iiE0Zk9xweFN3OlyfQbMDBlT7nb8bobo4AMA3XdrmnZhvdd/LWFeyb
	VRJvfbNYl0f3IWaddvd/Z/sxTV4rC5nYKqg==
X-ME-Sender: <xms:FigyZwm22GrJqET7MUv8cp0zqiKKWBUpL1ewQ0nmSQYyP3Eok3vBxg>
    <xme:FigyZ_2zExiXI7erehh_qegwLXJVeTv5a4h8PQJNDm-BPi9GDdMtBn6TfSkWjjFAX
    tDHzScI5Nl4WcZ9RMA>
X-ME-Received: <xmr:FigyZ-pItT7PVvnTxvk65ixSYDkfkAkUn0aOxDcJm-r4UF5eE0BzTTr_K0DoXUzKCMMACQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdekudcutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:FigyZ8mzTfuVg8VymzOzSnBqNo1GZtiEJBZyaf1tf6sQ5wLlXzGANw>
    <xmx:FigyZ-3mKxfYzkYPDLFgfNHztIsA3RTOb_R2ryVgk0moSzuZog32AA>
    <xmx:FigyZzvdjDgtzQNE7ujH4FGR5dp8g7e3pwSnrGU3lhlohGczLs8TTw>
    <xmx:FigyZ6XFvjF44G2vVkwL3TS8pzE92VltzhBAslVGWlnVGNwpmSxdGg>
    <xmx:FygyZ3k3dqUMHOfCwPljYm0D7RBMstJo2faswK0mDRBpa-S0FxQ_hr-2>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:51:48 -0500 (EST)
Date: Mon, 11 Nov 2024 17:51:44 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <bi5byc65zc54au7mrzf3lcfyhwfvnbigz3f3cn3a4ski6oecbw@rbnepvj4qrgf>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <kda46xt3rzrb7xs34flewgxnv5vb34bvkfngsmu3y2tycyuva5@4uy4w332ulhc>
 <1c45f4e0-c222-4c47-8b65-5d4305fdb998@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c45f4e0-c222-4c47-8b65-5d4305fdb998@kernel.dk>

On Mon, Nov 11, 2024 at 08:31:28AM -0700, Jens Axboe wrote:
> On 11/11/24 8:25 AM, Kirill A. Shutemov wrote:
> > On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
> >> On 11/11/24 2:15 AM, Kirill A. Shutemov wrote:
> >>>> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> >>>>  			}
> >>>>  		}
> >>>>  put_folios:
> >>>> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
> >>>> -			folio_put(fbatch.folios[i]);
> >>>> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> >>>> +			struct folio *folio = fbatch.folios[i];
> >>>> +
> >>>> +			if (folio_test_uncached(folio)) {
> >>>> +				folio_lock(folio);
> >>>> +				invalidate_complete_folio2(mapping, folio, 0);
> >>>> +				folio_unlock(folio);
> >>>
> >>> I am not sure it is safe. What happens if it races with page fault?
> >>>
> >>> The only current caller of invalidate_complete_folio2() unmaps the folio
> >>> explicitly before calling it. And folio lock prevents re-faulting.
> >>>
> >>> I think we need to give up PG_uncached if we see folio_mapped(). And maybe
> >>> also mark the page accessed.
> >>
> >> Ok thanks, let me take a look at that and create a test case that
> >> exercises that explicitly.
> > 
> > It might be worth generalizing it to clearing PG_uncached for any page cache
> > lookups that don't come from RWF_UNCACHED.
> 
> We can do that - you mean at lookup time? Eg have __filemap_get_folio()
> do:
> 
> if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
> 	folio_clear_uncached(folio);
> 
> or do you want this logic just in filemap_read()? Arguably it should
> already clear it in the quoted code above, regardless, eg:
> 
> 	if (folio_test_uncached(folio)) {
> 		folio_lock(folio);
> 		invalidate_complete_folio2(mapping, folio, 0);
> 		folio_clear_uncached(folio);
> 		folio_unlock(folio);
> 	}
> 
> in case invalidation fails.

The point is to leave the folio in page cache if there's a
non-RWF_UNCACHED user of it.

Putting the check in __filemap_get_folio() sounds reasonable.

But I am not 100% sure it would be enough to never get PG_uncached mapped.
Will think about it more.

Anyway, I think we need BUG_ON(folio_mapped(folio)) inside
invalidate_complete_folio2().

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

