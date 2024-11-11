Return-Path: <linux-fsdevel+bounces-34264-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 182569C42A4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 17:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964A31F22457
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDC91A0BCF;
	Mon, 11 Nov 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="vVBPWXGW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lygO0h6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6217D1448C1;
	Mon, 11 Nov 2024 16:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731342595; cv=none; b=B6jmR+ZkMqhi/3Z8p6V28V5ryJMp78sp+aHoQLSlES+Ya1Ld5hhLwkLvAeF/frV5j06cF9ZRKmsq/4uXyQqv/IYVAQ6CZwq4R6AwSxcpCfCNKiylyf7GduCZ2gNNBJwOlZl6lajix6C0Tc2695kZgU5R/87XrsP8K0qVnAEMyX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731342595; c=relaxed/simple;
	bh=V6+O62JIiZCefN8Y8m3TfT6982eYu19JQLAO0TTpo00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAgIkX2bpeCNs4FnugnY0Ol4u+zlvpZNspBf5C5DEC1bm62CRKwWckulavx9IPLNEY1BJjwYZe+dFhGOw3cnSKcALBxHGr3lHqMV0MsWCqcHKUu7lFA7+IUdoqHQE35Lo2a+/cFBkl4M5EZEWFvgdW2gjQf6GiXoyjwyaqlzWIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=vVBPWXGW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lygO0h6i; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 6EEA91380687;
	Mon, 11 Nov 2024 11:29:51 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 11 Nov 2024 11:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731342591; x=
	1731428991; bh=ghB/11Aswprc8zwkP+jhTIoBLnJ8zHQI/9i63LpDVIw=; b=v
	VBPWXGWMIhdlSBeHsMrTohRJoM9UYbz9S602/raXt/v2wnuBeCIAwo6MOfSiehxJ
	Lffdqj17L3fmXJ8RWxe1JE6yEoMaaOZGayZXqKGYrKwYAMgerAJn89Ub4vNOLlH3
	Uv6tQDTmh4AqsgZyLV7oFDSpO8le8Ty+LxkIgve1oLAbZ8XZ6Sb9CSuDJGgpIIeU
	Wc6HwsyXiLWG7qYJ9iBaJ2GkyXMRVYnwSiGsXlzUHkKUFX7lEV9ap6lCcuZQ66OM
	wDfp3krIPZdEChaQIT8Au+ki2haIFYrUPpEVToaNcn89geVkW41fFRfXKcb4PDGO
	q/4iFYcOGHLKgMH9FUlSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731342591; x=1731428991; bh=ghB/11Aswprc8zwkP+jhTIoBLnJ8zHQI/9i
	63LpDVIw=; b=lygO0h6iu5AaCpwhuYj6D2rFfQ8oI+8CBZC3IHlHCUQEWl0XEMe
	O8uvskoLqrfdufaaWl4GDGOmhBjfUT5LhJAeMshlpjAdPli+B8YeNWNbVygWrRbB
	o4hz79TABlCH4c0ADNIvsFA+fbIfmt/RTj67htJXyCX2VXsYu2qyQMMX7JPAxXe2
	SsSdX1ON8AKpG3eAe4pVLtkA8He9xKQa7AlknenjpObi0nqBPjdzjvAezHqiGsa5
	XpJR9XOpTpNe+Mh7cjnFwjyg+b1V5TvAK82AAMx2kp5zkOxxf/i9fmhV7kCXnHHU
	owZoxwdd/0yqJgao43laGnuB6SxeBKMlDyQ==
X-ME-Sender: <xms:_jAyZ7QAEzFbsTLZQgAMiaZAexq3jmH4KJ2U8Tg26Xa204ECTlsu_A>
    <xme:_jAyZ8wgn_1eT9sc21RIcgoxwkDUJxlOqfl8c4Xjl65YT-gBujZwSOVSuP2VziJK1
    TapehLHA82HNXLbTuA>
X-ME-Received: <xmr:_jAyZw2XqA-0_-QFebNTZ_x5lwnEUTZm_uL-fwJOYG0JTWoS4HgmzqXkhY43GaDPVCj7Ug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdekkecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:_jAyZ7BqXe3MZEahxAAhi0bZXQ6FHfB19eriQGaKb_C_5k5h29Ho7A>
    <xmx:_jAyZ0hRJDUYZXjw_0X_dPw81VFtHtPsDaXrOd6sI8M-xwbi2FbPtg>
    <xmx:_jAyZ_rnwyA5mkhpTuHKmXTwT4GOCzzDP3k5dNVyEjDekKWIYlJRSA>
    <xmx:_jAyZ_jy6Q4QhMqmOnt7CKK2F2PMXCn6FAr-2DNSKf16LKQarK8m2w>
    <xmx:_zAyZwh2gvK-KIvzOl_l5p-9pmFTygYPObx6nZsWZnIFGxDFxlpkSNIG>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 11:29:48 -0500 (EST)
Date: Mon, 11 Nov 2024 18:29:44 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <j3ob6sbdi4aeiomhnleyic3lyig6oglk4mynibczhqjxbhhb2n@2hsnsn3mxyxq>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
 <kda46xt3rzrb7xs34flewgxnv5vb34bvkfngsmu3y2tycyuva5@4uy4w332ulhc>
 <1c45f4e0-c222-4c47-8b65-5d4305fdb998@kernel.dk>
 <bi5byc65zc54au7mrzf3lcfyhwfvnbigz3f3cn3a4ski6oecbw@rbnepvj4qrgf>
 <9f86d417-9ae7-466e-a48f-27c447bb706d@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f86d417-9ae7-466e-a48f-27c447bb706d@kernel.dk>

On Mon, Nov 11, 2024 at 08:57:17AM -0700, Jens Axboe wrote:
> On 11/11/24 8:51 AM, Kirill A. Shutemov wrote:
> > On Mon, Nov 11, 2024 at 08:31:28AM -0700, Jens Axboe wrote:
> >> On 11/11/24 8:25 AM, Kirill A. Shutemov wrote:
> >>> On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
> >>>> On 11/11/24 2:15 AM, Kirill A. Shutemov wrote:
> >>>>>> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> >>>>>>  			}
> >>>>>>  		}
> >>>>>>  put_folios:
> >>>>>> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
> >>>>>> -			folio_put(fbatch.folios[i]);
> >>>>>> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> >>>>>> +			struct folio *folio = fbatch.folios[i];
> >>>>>> +
> >>>>>> +			if (folio_test_uncached(folio)) {
> >>>>>> +				folio_lock(folio);
> >>>>>> +				invalidate_complete_folio2(mapping, folio, 0);
> >>>>>> +				folio_unlock(folio);
> >>>>>
> >>>>> I am not sure it is safe. What happens if it races with page fault?
> >>>>>
> >>>>> The only current caller of invalidate_complete_folio2() unmaps the folio
> >>>>> explicitly before calling it. And folio lock prevents re-faulting.
> >>>>>
> >>>>> I think we need to give up PG_uncached if we see folio_mapped(). And maybe
> >>>>> also mark the page accessed.
> >>>>
> >>>> Ok thanks, let me take a look at that and create a test case that
> >>>> exercises that explicitly.
> >>>
> >>> It might be worth generalizing it to clearing PG_uncached for any page cache
> >>> lookups that don't come from RWF_UNCACHED.
> >>
> >> We can do that - you mean at lookup time? Eg have __filemap_get_folio()
> >> do:
> >>
> >> if (folio_test_uncached(folio) && !(fgp_flags & FGP_UNCACHED))
> >> 	folio_clear_uncached(folio);
> >>
> >> or do you want this logic just in filemap_read()? Arguably it should
> >> already clear it in the quoted code above, regardless, eg:
> >>
> >> 	if (folio_test_uncached(folio)) {
> >> 		folio_lock(folio);
> >> 		invalidate_complete_folio2(mapping, folio, 0);
> >> 		folio_clear_uncached(folio);
> >> 		folio_unlock(folio);
> >> 	}
> >>
> >> in case invalidation fails.
> > 
> > The point is to leave the folio in page cache if there's a
> > non-RWF_UNCACHED user of it.
> 
> Right. The uncached flag should be ephemeral, hitting it should be
> relatively rare. But if it does happen, yeah we should leave the page in
> cache.
> 
> > Putting the check in __filemap_get_folio() sounds reasonable.
> 
> OK will do.
> 
> > But I am not 100% sure it would be enough to never get PG_uncached mapped.
> > Will think about it more.
> 
> Thanks!
> 
> > Anyway, I think we need BUG_ON(folio_mapped(folio)) inside
> > invalidate_complete_folio2().
> 
> Isn't that a bit rough? Maybe just a:
> 
> if (WARN_ON_ONCE(folio_mapped(folio)))
> 	return;
> 
> would do? I'm happy to do either one, let me know what you prefer.

I suggested BUG_ON() because current caller has it. But, yeah, WARN() is
good enough.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

