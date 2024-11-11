Return-Path: <linux-fsdevel+bounces-34253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 936AC9C41C8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 16:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D5491F23196
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 371CF1A0715;
	Mon, 11 Nov 2024 15:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="QjtZcKRo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XQUTh0U6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5415D19E83D;
	Mon, 11 Nov 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731338730; cv=none; b=J9/ECqTiQ19qap5BlSnuEaPVvOQBvmYkwG3FCF3ef7PwK5SoU9MZL2lWOBp/KW3CoCG4kfMw9RKTgjYsrPLTIg7sRCidLJOmpSnbE+1UtM31qOhK1SBgyJhCtgwSJlPc8Qa/+BO3T8LYsQyLeZ5Y4oEhuhMuYZWVPJBrftgY0CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731338730; c=relaxed/simple;
	bh=9dAavv9p0sYccDojVJZ4cl0x/ONLpn4wEDpC1dF2Yek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4J5sXccMCa3ggVOhBe2b0GfMIYZQDm5mwI/UY6LjwluRO4AOOgvLZub/fhviK7aghnKfOU5zrkus9oCH6XaHhOCipl555Xp7kEvlC0qX2W6ZXiQg+Y399ZalIywKrU3meVzKE1faFo+4JuEEyBzvUExyBwSsawYlRzI6f/O2O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=QjtZcKRo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XQUTh0U6; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3E9AB114019E;
	Mon, 11 Nov 2024 10:25:26 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 11 Nov 2024 10:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1731338726; x=
	1731425126; bh=glOUfK74CVhSoPgVs5u0b45fN1MMozNH166QZjbcnEQ=; b=Q
	jtZcKRo+2VpN4sUOq6yeXY6iXnPAJ8V+hUOO/Z8SlYs+Uv51jxnGIZ45NGbB5zyS
	GEcpRhOQp5oscadc/X5/OnmqJwLOBVr7XUeJjkET6sUO1YnTRQyXac6slT3AZE3m
	BCiNuT1agTMW0HEf9dXNWmvybpW+75VefSJZvJBkQU+OpMYMZtLfGFpxZI4mdiZG
	yV5UETeicoGCp3BoHxLaIDqMNikoP0fhPntLGBc0TkNx5CAP0wRC4ZxKMJjxOLQ0
	7g6Y8XGio6BktXBqjDbDY0X9px+8x2lln7Md8FZ2BQ7BINSZMBG4rgpVSDVLwPNU
	FmK78jJCJi9BdslcOOOgw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1731338726; x=1731425126; bh=glOUfK74CVhSoPgVs5u0b45fN1MMozNH166
	QZjbcnEQ=; b=XQUTh0U65YU2xIul68Mzm28z75M4sE+fjHFJ8UNRfpBWlWvgqzA
	3x6uVQYywpgL3TfLp9mT8mjgRuJCt2XL4beqKgwLMnFuP4cDHI8LYmbH+oVkqisO
	D+FPiYEk6rhnpIhI73Bg/Errrr9pgxod2nUa7zr9Q95Bxms+zuTzCgt34vgPDvvq
	/Q5/OPzAz6QVm7XLX/xO/EQuy5e/4EB376PP0OQwqV6/uWnMfIg4AiUM7ZcNU55j
	aIr5GI6U5MmJ0GjYxUw5gF2NhHD5yHG1ShJrLn67m9GcVCTOsCjt9bYxpddED2eM
	s82B/IPmesoQuMUl4Vgrs3w91TweJOpBmZw==
X-ME-Sender: <xms:5SEyZytzf-awNTUQA_fsk4AuajFFJRhPKI7PvqxT_J1ASWRoxXSScg>
    <xme:5SEyZ3fHVmOW5htonIOpaLjH9XuEIw7aU-vexuxnHja11iCfGRZMhzMzGdB9PQl-W
    YASTyNgwkNjyrDj0kU>
X-ME-Received: <xmr:5SEyZ9wvPE6MvQ7yw55g4gIQXjowvB8My5olGKUQ880MgK-JO2eSJq2z_vJ3HIMC3PJ2EQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddvgdejhecutefuodetggdotefrodftvf
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
X-ME-Proxy: <xmx:5SEyZ9N0U44CUqbSqv3zKoRsSHgyzuhPF1AghXGUFt0Q2h2c9Fhwvw>
    <xmx:5SEyZy8URn0WCx4h6gEaXWcLoDMOT6RI-FNdVb9Dw1unc62pceiViw>
    <xmx:5SEyZ1VuMyusLWPGkuwiH5f2F6aqngqdVLbWyrMg3IlJd-FszAAm4w>
    <xmx:5SEyZ7fp_3jaPLwm0viNLfSITIG_KEV_J0eX3EOBzrrz_gAZbDIRfg>
    <xmx:5iEyZ3Md7drl-dsVDO8u2-_oW9d20OToy6R9KBhxt5WPFXDuLU_tL6xZ>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Nov 2024 10:25:23 -0500 (EST)
Date: Mon, 11 Nov 2024 17:25:19 +0200
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org, 
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH 08/15] mm/filemap: add read support for RWF_UNCACHED
Message-ID: <kda46xt3rzrb7xs34flewgxnv5vb34bvkfngsmu3y2tycyuva5@4uy4w332ulhc>
References: <20241110152906.1747545-1-axboe@kernel.dk>
 <20241110152906.1747545-9-axboe@kernel.dk>
 <s3sqyy5iz23yfekiwb3j6uhtpfhnjasiuxx6pufhb4f4q2kbix@svbxq5htatlh>
 <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <221590fa-b230-426a-a8ec-7f18b74044b8@kernel.dk>

On Mon, Nov 11, 2024 at 07:12:35AM -0700, Jens Axboe wrote:
> On 11/11/24 2:15 AM, Kirill A. Shutemov wrote:
> >> @@ -2706,8 +2712,16 @@ ssize_t filemap_read(struct kiocb *iocb, struct iov_iter *iter,
> >>  			}
> >>  		}
> >>  put_folios:
> >> -		for (i = 0; i < folio_batch_count(&fbatch); i++)
> >> -			folio_put(fbatch.folios[i]);
> >> +		for (i = 0; i < folio_batch_count(&fbatch); i++) {
> >> +			struct folio *folio = fbatch.folios[i];
> >> +
> >> +			if (folio_test_uncached(folio)) {
> >> +				folio_lock(folio);
> >> +				invalidate_complete_folio2(mapping, folio, 0);
> >> +				folio_unlock(folio);
> > 
> > I am not sure it is safe. What happens if it races with page fault?
> > 
> > The only current caller of invalidate_complete_folio2() unmaps the folio
> > explicitly before calling it. And folio lock prevents re-faulting.
> > 
> > I think we need to give up PG_uncached if we see folio_mapped(). And maybe
> > also mark the page accessed.
> 
> Ok thanks, let me take a look at that and create a test case that
> exercises that explicitly.

It might be worth generalizing it to clearing PG_uncached for any page cache
lookups that don't come from RWF_UNCACHED.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

