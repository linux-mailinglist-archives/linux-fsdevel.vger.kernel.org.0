Return-Path: <linux-fsdevel+bounces-45502-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93AA78ABC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 11:11:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A87547A45CA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Apr 2025 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A09C2356D7;
	Wed,  2 Apr 2025 09:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b="TYycLM0v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HM9bPB+M"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF0720E00B;
	Wed,  2 Apr 2025 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743585059; cv=none; b=hzLScNtSlSQaII0FF+Aur13841RK4WlJaQcUJ0C1pFtbUV2Zu/Oe7A1DJZH6DdLZ/JiAoGgNgPxxSJxgLUD3Lb83ZxFz8ItpkaxcUNQ9pFDzJT/Ds58fGROXj9cXEZZNGz0TkuTr5pxdB/AZtT8uGz0KasER4hMp7dNc2tY73rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743585059; c=relaxed/simple;
	bh=VSe3OeVWWnLk2r3FC4J7BJMmPc/Q2MEG9Hs1eEpSz2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K9gG74cA6GEDfl/vEqxCGvnUgSx6Vub3l2EdNikqUhyUKCU0GyT4x5asSHGPbIQ7u3Yr1nQi7Bm3odzT29syd6i5R/glGWoxRI49pq+0Xa9AnfK37ViDpQZ04s3iN+jJSPPBJUeIoCwKI9u12i5PBsgYVuQzncw3FlO9oRwsZBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm; spf=pass smtp.mailfrom=fastmail.fm; dkim=pass (2048-bit key) header.d=fastmail.fm header.i=@fastmail.fm header.b=TYycLM0v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HM9bPB+M; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.fm
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B7704114011A;
	Wed,  2 Apr 2025 05:10:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Apr 2025 05:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1743585055;
	 x=1743671455; bh=jUcSKZNgP+Sg/DbCPgXX4khSpS1DYk5lWGNv40G5oaI=; b=
	TYycLM0vHgClioRO+V1aCV3RpEHvVzc2wW+b7rbdK7g83WOxAie9aBNrqurSQZYx
	VGzQGtoliTjk2XFf+g1muwvANWGHcLRxlmeF0tNvuGS9Fu0+/yjgcYf3powpXu/S
	keKjTTyc8fhIk949Qr+RtOI4mtpmGygKw81vVP0cCL/WFDqeV9scuroDdaLngPyz
	3ZKb/DYJoeFLwOu6poas7lKX6dCgnWYuGApajrGy3ZQ4Xr2hQ6shEQ7o4h4jaG2F
	ywG2n9Tzf+EgWyhLfWOg0voW/pYyabd+x3K2CevizZKeeBbnrA8hY+131JY3I/0o
	ydTFVTI6oyw0f+H5hmE7qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743585055; x=
	1743671455; bh=jUcSKZNgP+Sg/DbCPgXX4khSpS1DYk5lWGNv40G5oaI=; b=H
	M9bPB+MD7WOfJKSm9LbHnYaDx1S2wIBeP1aUYeqmRb3ftWGD4jLVJvDg4MPNZNaI
	tS83pafPiSm45eTXg8wVVxW5ZbkoMOJc9MVbmRUEuMgBSqi1/1MXCWZDyDGxhz8X
	SdzDDFyzbTL1ysRsKfjIZN9PeOnnyoTIlfWGlqm/yQ55ePpFwVfJOIxWvIdkfQXN
	30TcODpqI0mGB5seOlZQGwY/lgO7StGbMTjLqw5LW34R3tx+WDduiAygqtZkW6ZI
	Za21ou6niA1Jtcw2knzb+yfRzqPVZIuCtCEOkJ/NxPipWN5C73JiLeLqP4fp+yP2
	q+5zU5Mk7zObJ3SgSmRfA==
X-ME-Sender: <xms:Hv_sZyQvn7HkvJfNdnGs_meUZQBRg_NtmTzYTuAx3SuOYGPAG4v6_g>
    <xme:Hv_sZ3yGR5ptWUUhjYu_Ox-uoFJ4VWVbg7Z96DY3mM3POSdR52IjHxzqVQWzJ4h2y
    VMj4iIGKQJLRYME>
X-ME-Received: <xmr:Hv_sZ_0C-GzncG3R2lblJ4BAPnwO9DH57mL7tTqe-snV5wNMyz9i02uyHaEUn9YE_yN7ucnan7SLAE5J-IctbvePngcpHW7scfTdFkZnNC6qc_41-HqY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeehvdekucetufdoteggodetrf
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
X-ME-Proxy: <xmx:H__sZ-D_Z6Q2psY0YA439HNCyavSC38TJ7Whb_y8v-F8cAIO0hksRw>
    <xmx:H__sZ7j27s5vINVZI2ZZfoBGMgfe968pFn4DGcTOzHp3ou-_DN5N8A>
    <xmx:H__sZ6r47k-ziJw5inLc20YGY-mHULEfNJSvrnuco0rxG9MYQ6YXpA>
    <xmx:H__sZ-gtftfwRV8CELCSFGvpDR5VmOFG5dCnE6xOsE5lal6LpVH4bw>
    <xmx:H__sZ8qGwNo9cRmwYSV5WpJYOCQXkbOdiYNr1vup8BThFeZeqp8WRcL7>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Apr 2025 05:10:53 -0400 (EDT)
Message-ID: <0b0a6adf-348e-425d-b375-23da3d6668d0@fastmail.fm>
Date: Wed, 2 Apr 2025 11:10:52 +0200
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
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <0cf44936-57ef-42f2-a484-7f69b87b2520@uls.co.za>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/2/25 10:52, Jaco Kroon wrote:
> Hi,
> 
> On 2025/04/02 10:18, Miklos Szeredi wrote:
>> On Wed, 2 Apr 2025 at 09:55, Jaco Kroon <jaco@uls.co.za> wrote:
>>> Hi,
>>>
>>> I can definitely build on that, thank you.
>>>
>>> What's the advantage of kvmalloc over folio's here, why should it be
>>> preferred?
>> It offers the best of both worlds: first tries plain malloc (which
>> just does a folio alloc internally for size > PAGE_SIZE) and if that
>> fails, falls back to vmalloc, which should always succeed since it
>> uses order 0 pages.
> 
> So basically assigns the space, but doesn't commit physical pages for
> the allocation, meaning first access will cause a page fault, and single
> page allocation at that point in time?  Or is it merely the fact that
> vmalloc may return a virtual contiguous block that's not physically
> contiguous?


Yes vmalloc return buffers might not be physically contiguous - not
suitable for hardware DMA. And AFAIK it is also a blocking allocation.


Bernd

