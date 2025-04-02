Return-Path: <linux-fsdevel+bounces-45511-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5B3A78DBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 14:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D6733B34DA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 12:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485D423A990;
	Wed,  2 Apr 2025 12:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="AZOEzLoA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pbzbP/jd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F45923956E;
	Wed,  2 Apr 2025 11:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595200; cv=none; b=eSBllvcUOFkq22LzgziynYImxnq0QOx4cRLEiPk2qu42D63hXw9YfjPsqHISCxm6Un0d95sBqGkymaV2tbmd3EGYj7xW6ohcfVdVNPvhUCGO0hX5Udq0prNEfbKSDlT71eqoeryH52yUqKMjuo7DGI2Si8XGSAFhJ5UNSpVXzLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595200; c=relaxed/simple;
	bh=vKsrwMMUSVkpYl3Wjc7iXyjyDZ/VVLnSOVOfX+Qs+WM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hPaR/1c0Oikxyr/FO0yRY5UcVC/0n3HSNSwGJ4JfpSRNtBvKhPnt+O3ZD1r2yWTFqLlcwK+sHjcd0PxvNwV8R4hszkcABUiIxcyOc4Va2UOxlyeSjg/V/wUztFUULceYFAtnKrZbkuNbtQXHBToq1NToWnJvqd6ciCUbT5x2IyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=AZOEzLoA; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pbzbP/jd; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2A89725401C1;
	Wed,  2 Apr 2025 07:59:57 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Wed, 02 Apr 2025 07:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743595197;
	 x=1743681597; bh=v92FjPBWjebyZcMwb5OIw0ehvZf97+SV1L6dSZLgD8Q=; b=
	AZOEzLoA7QUVKb5shewnFGBFgw89klcM9Y1m2+zFKF7aCC2zYpH6Iz/UyUHaBvrh
	x5fvAO7Bo1BKzcVrWjePRm0F2LZReoPqkQmjloKfbVd7dQywtirkZX3A6TW+YtNz
	UoIVPXN1/PbEuXxTEiPGPO1MGWUCiFuYQC6f70Fu7a/A6mr9d5vyvWFEkfZfFUvI
	Nyo9I5qVJ61+y14gMufrwCWR4k4bxHZL8ixK2DvLRuUM/7mUEuOpNiEdy67OEOmh
	79B1OB6x6Eyb3NTHaQJpmPU7jy9NReHesScQYvHX4J44EDNk5xkJhlVJOu+lXiDL
	OjliMcHihYJBjC8EiZbOAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743595197; x=
	1743681597; bh=v92FjPBWjebyZcMwb5OIw0ehvZf97+SV1L6dSZLgD8Q=; b=p
	bzbP/jd+lIqiZ3u5udtNVNXsVvC+Prq5lWYYt4Fq2cZ+vCFehUMPsAmdbGTDr5F1
	Sjsdy+Q7sIjIZv1XwjmSuhkAP5MS/l6IUTGxEcuMzqS075APYA+e4rrrU0OYV+MC
	Yf9m3e/YOh/zlFgoBCVsA31hYS+h6sp8Vi4Eeo2E1PQQbO2yHt3xejoP1+chIryz
	bhQ8fPIjrAHF83+1xXa/6x3DwHs3KbQxaMtUOyyX1YA3PM7Y7DsyJ5WaZhUrcMu1
	iASmnYY3gxGGDZizV5MXfeK7NDjTHVljVBvFJKBrM6bM1p2G0pX5Hi3LCqLqtoDU
	ah09p6+c46CRjdD8esk3Q==
X-ME-Sender: <xms:vCbtZ_DxDpvl_xxHg8jAOo8ku2myQK5qZESS5TQmu4qTa703eG5__A>
    <xme:vCbtZ1i_8ONZJD6Rympc0yLmKrhaC0_PFJ1tHwHhVIKJbztU1ZD-QLyVY3IudJ4pB
    nVLoMPzWFybWlWe>
X-ME-Received: <xmr:vCbtZ6ng6gVt7D0w1GnmBfovTJMbnNp_AtXIs86KloLsJh_XsxpdJE-niKrRUIGYEAnqRLm2FnNqKH2lvIDzE_S118jaW_G-AiMuZLy55_xZYS3T_s3M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepudelfedvudev
    udevleegleffffekudekgeevlefgkeeluedvheekheehheekhfefnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjrggtohesuhhlshdrtghordiirgdprhgtphhtthhopehm
    ihhklhhoshesshiivghrvgguihdrhhhupdhrtghpthhtoheplhhinhhugidqfhhsuggvvh
    gvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhsthhoph
    hhvgdrjhgrihhllhgvthesfigrnhgrughoohdrfhhrpdhrtghpthhtohepjhhorghnnhgv
    lhhkohhonhhgsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhguuhhnlhgrphesihhnfh
    hrrgguvggrugdrohhrghdprhgtphhtthhopehtrhgrphgvgihithesshhprgifnhdrlhhi
    nhhkpdhrtghpthhtohepuggrvhhiugdrlhgrihhghhhtrdhlihhnuhigsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:vCbtZxzqiHmhAbL5HnOPDoFMEY8KQzKUJMVPQVQRp4nOsEGh1q260A>
    <xmx:vCbtZ0SatBdiyWWwltRb0dwmMxslrJ7eiwIcAZ8bPMjrKWLIyaGl6Q>
    <xmx:vCbtZ0ZjFQoXmgZarF03DcoSeyF88ik-CaqrP25yDK4dT-GBK3t7Vw>
    <xmx:vCbtZ1S6cS20eVI9rS-Fp5u91Vahu9HehSpLZeTXAPg_z8GFsIaDOQ>
    <xmx:vSbtZ6ZEsbgJWxtystLd_OgRGHKV6QeWuh0ml0JqAl_zwL8fOOr06xLE>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 07:59:55 -0400 (EDT)
Message-ID: <cbc597b2-52a4-4c29-b240-427d353eb442@fastmail.fm>
Date: Wed, 2 Apr 2025 13:59:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] fuse: Adjust readdir() buffer to requesting buffer
 size.
To: Jaco Kroon <jaco@uls.co.za>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 christophe.jaillet@wanadoo.fr, joannelkoong@gmail.com,
 rdunlap@infradead.org, trapexit@spawn.link, david.laight.linux@gmail.com
References: <20250314221701.12509-1-jaco@uls.co.za>
 <20250401142831.25699-1-jaco@uls.co.za>
 <20250401142831.25699-3-jaco@uls.co.za>
 <CAJfpegtOGWz_r=7dbQiCh2wqjKh59BqzqJ0ruhtYtsYBB+GG2Q@mail.gmail.com>
 <19df312f-06a2-4e71-960a-32bc952b0ed2@uls.co.za>
 <CAJfpegseKMRLpu3-yS6PeU2aTmh_qKyAvJUWud_SLz1aCHY_tw@mail.gmail.com>
 <3f71532b-4fed-458a-a951-f631155c0107@uls.co.za>
 <CAJfpegtutvpYYzkW91SscwULcLt_xHeqCGLPmUHKAjozPAQQ8A@mail.gmail.com>
 <0cf44936-57ef-42f2-a484-7f69b87b2520@uls.co.za>
 <0b0a6adf-348e-425d-b375-23da3d6668d0@fastmail.fm>
 <f22c14e1-43d9-4976-b13e-a664f5195233@uls.co.za>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <f22c14e1-43d9-4976-b13e-a664f5195233@uls.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/2/25 13:13, Jaco Kroon wrote:
> Hi,
> 
> On 2025/04/02 11:10, Bernd Schubert wrote:
>>
>> On 4/2/25 10:52, Jaco Kroon wrote:
>>> Hi,
>>>
>>> On 2025/04/02 10:18, Miklos Szeredi wrote:
>>>> On Wed, 2 Apr 2025 at 09:55, Jaco Kroon <jaco@uls.co.za> wrote:
>>>>> Hi,
>>>>>
>>>>> I can definitely build on that, thank you.
>>>>>
>>>>> What's the advantage of kvmalloc over folio's here, why should it be
>>>>> preferred?
>>>> It offers the best of both worlds: first tries plain malloc (which
>>>> just does a folio alloc internally for size > PAGE_SIZE) and if that
>>>> fails, falls back to vmalloc, which should always succeed since it
>>>> uses order 0 pages.
>>> So basically assigns the space, but doesn't commit physical pages for
>>> the allocation, meaning first access will cause a page fault, and single
>>> page allocation at that point in time?  Or is it merely the fact that
>>> vmalloc may return a virtual contiguous block that's not physically
>>> contiguous?
>>
>> Yes vmalloc return buffers might not be physically contiguous - not
>> suitable for hardware DMA. And AFAIK it is also a blocking allocation.
> How do I go about confirming?  Can that behaviour be stopped so that in
> the case where it would block we can return an EAGAIN or EWOULDBLOCK
> error code instead?  Is that even desired?
> 
> Don't think hardware DMA is an issue here, so that's at least not an
> issue, but the blocking might be?

I was just writing what vmalloc does - neither of its disadvantages will
have an issue here

