Return-Path: <linux-fsdevel+bounces-65573-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 54CD5C07EB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 21:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CD324E50F5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 24 Oct 2025 19:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786BD2BE029;
	Fri, 24 Oct 2025 19:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b="chw4THql";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D3AM57Hq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6432329B204;
	Fri, 24 Oct 2025 19:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334382; cv=none; b=ZnSyT6Wegcb9joZOgCRvJ0ZpRhvIEDG+Qm5PG0iIjih4XPHMsXe5hg37ODeH50V4/kUWhR0aVrrHU6Pz3gHvKPYSBZGJL4aO74IoC7TA/PW1E6JOyTdaWxipaGGTAH/DONm5SG6eubytzPe/OUUz1HbSDidXct4WixRYpGq9mQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334382; c=relaxed/simple;
	bh=jPIkLLtaRCzb8aJMZTdAneGKRi508NY6HlZqhH47XHo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=kmwLvq6rCb9V0Ptihxk3vrABEjV8tIOZmY22Spph7S0079FVLxHUIZL3dr7w0VtBwyqUb43cXQeaqzdY77RrrMlXQ8bX0ity6lx/xKF/HN0oSTWyD9Cfs3TJ5FGfZImCTrJXOsVEKDtrvcEoRB8Pm0+FXE+yoH9rQWm95d7ivbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name; spf=pass smtp.mailfrom=shutemov.name; dkim=pass (2048-bit key) header.d=shutemov.name header.i=@shutemov.name header.b=chw4THql; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D3AM57Hq; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id C06511300286;
	Fri, 24 Oct 2025 15:32:58 -0400 (EDT)
Received: from phl-imap-10 ([10.202.2.85])
  by phl-compute-04.internal (MEProxy); Fri, 24 Oct 2025 15:32:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1761334378; x=1761341578; bh=2Eie9rhTwSUlY1W7oebxyg5hlbXGes4p
	kn2Ot5hK/W0=; b=chw4THqlrwqSs38QX7V0HBZScQNidiSKZogcPrpPVGKNFSpY
	Hr/x/WMn6jcDRCRIZOqeh+04AX2tNshXGRrFGFFPzhCB/R1Yxbn/BRD+CMocWPhx
	UpBf+N5OpFp4lqNgOHwlKFmSPMJxD8VYzLeHinflFas7Ld3ZoqbcEQqiXJ+Z3xAP
	fCb8VUSRAqgkBqs7wV2j07myrIUZ6+GGvVEyjZUlcvZ91XU4e/x3XfM5poD9+QHu
	OJagCG04BPvf0fs7RH1Vqko1n28A/AqdD/RTHNQZVzUfitMiaYH0gHyQoRxFET6p
	cqGsM92yKgXdESHu8b2MZAD7FbQFbs+Ml/t0YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761334378; x=
	1761341578; bh=2Eie9rhTwSUlY1W7oebxyg5hlbXGes4pkn2Ot5hK/W0=; b=D
	3AM57HqO1i+sRH2fR79zXWnSCId0q9IG98YuR6VSFOQGUhKSutqJMChsDLj/Q7L8
	yRv4VxnZju07Q9kZijHV78l8O2wKbfusNAjX6uQzY7sPxg2Gs/Rxi94yw2DyGXe1
	brZLqLfUgrH/eiiEFLDTB3k474jQq/i9D2lnlg+u8wxFgi/pIAx6UB2lZeZUiyKo
	+jKGYD4ZIVFHHKPB8YCAa7hdkfBWLFVvL2whsdr0dgz3YeV6J9qOeGLWBiMmo5iu
	rlz9ckZvDXJLCd/aR/cvyC1mVkfwHKTs/yIVTSZb6GfUdyBGBBbNxS5j8wpuygxC
	fwPJRsyOxvr6PwHvKmG4w==
X-ME-Sender: <xms:adT7aLrpDPQZGVa84VrLn300BloDRka_Xr4eaWU4ja3qoCoIjmh71Q>
    <xme:adT7aAd0gyIgXgFgJ6m9vi0bn0ShQv6mIHu_eH2ssB_IpNsPVjpLL9NN6UqSlFbOy
    zeK2Os0Ng_D0EzLwoOIOmVpDNzRJLXJxrZt0iqRPB-m3wUNHO6V2Wo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduhedtudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfmfhirhhi
    lhhlucetrdcuufhhuhhtvghmohhvfdcuoehkihhrihhllhesshhhuhhtvghmohhvrdhnrg
    hmvgeqnecuggftrfgrthhtvghrnhepfeehvedviefgueevgeduhfffjedugfdtvdfhvdek
    uefgueffteegkedvvdffteffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepkhhirhhilhhlsehshhhuthgvmhhovhdrnhgrmhgvpdhnsggprhgt
    phhtthhopedvfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephhgrnhhnvghsse
    gtmhhpgigthhhgrdhorhhgpdhrtghpthhtohepuggrvhhiugesfhhrohhmohhrsghithdr
    tghomhdprhgtphhtthhopehhuhhghhgusehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hsuhhrvghnsgesghhoohhglhgvrdgtohhmpdhrtghpthhtohepfihilhhlhiesihhnfhhr
    rgguvggrugdrohhrghdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegujhifohhngheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgr
    sheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhpphhtsehkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:adT7aFyRBRSeVnGi14kIw5Ck1L7OlC7KwIMqpMZgk5v61oO8fcM_Xw>
    <xmx:adT7aA9calwwSFl8H5vxhd7a94GeP9js63aA16vdy4NfsUhN7tM54g>
    <xmx:adT7aKAFG2RoCob6uF9S4yaeS54QhsKtAt-fxnxflvo7RqlSsAM5iA>
    <xmx:adT7aIdsOaSSwRDxprKYwXiknos2gcSFvlRqyzRQm_upT8MpgRROvg>
    <xmx:atT7aMGYELrvclqCX7O2E_660PuNtn2jwY1SNpAHOUyXq9fD6wrjUE8C>
Feedback-ID: ie3994620:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 18E372160065; Fri, 24 Oct 2025 15:32:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_7exwu8WuKB
Date: Fri, 24 Oct 2025 20:32:36 +0100
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: "David Hildenbrand" <david@redhat.com>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Hugh Dickins" <hughd@google.com>, "Matthew Wilcox" <willy@infradead.org>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>
Cc: "Lorenzo Stoakes" <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 "Vlastimil Babka" <vbabka@suse.cz>, "Mike Rapoport" <rppt@kernel.org>,
 "Suren Baghdasaryan" <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>,
 "Rik van Riel" <riel@surriel.com>, "Harry Yoo" <harry.yoo@oracle.com>,
 "Johannes Weiner" <hannes@cmpxchg.org>,
 "Shakeel Butt" <shakeel.butt@linux.dev>,
 "Baolin Wang" <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, "Dave Chinner" <david@fromorbit.com>,
 linux-mm <linux-mm@kvack.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 linux-kernel@vger.kernel.org, "Kiryl Shutsemau" <kas@kernel.org>
Message-Id: <ca03ba53-388d-4ac4-abf3-062dcdf6ff00@app.fastmail.com>
In-Reply-To: <18262e42-9686-43c1-8f5f-0595b5a00de1@redhat.com>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-2-kirill@shutemov.name>
 <18262e42-9686-43c1-8f5f-0595b5a00de1@redhat.com>
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries beyond i_size
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Fri, Oct 24, 2025, at 16:42, David Hildenbrand wrote:
> On 23.10.25 11:32, Kiryl Shutsemau wrote:
>>   	addr0 = addr - start * PAGE_SIZE;
>>   	if (folio_within_vma(folio, vmf->vma) &&
>> -	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK)) {
>> +	    (addr0 & PMD_MASK) == ((addr0 + folio_size(folio) - 1) & PMD_MASK) &&
>
> Isn't this just testing whether addr0 is aligned to folio_size(folio)? 
> (given that we don't support folios > PMD_SIZE), like
>
> 	IS_ALIGNED(addr0, folio_size(folio))

Actually, no. VMA can be not aligned to folio_size().

-- 
Kiryl Shutsemau / Kirill A. Shutemov

