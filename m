Return-Path: <linux-fsdevel+bounces-60678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DCCFB5000A
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 16:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 101E51C62274
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Sep 2025 14:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74050352084;
	Tue,  9 Sep 2025 14:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b="mgP0v51A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9UAhErE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from flow-b7-smtp.messagingengine.com (flow-b7-smtp.messagingengine.com [202.12.124.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6CDB3451B6;
	Tue,  9 Sep 2025 14:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757429346; cv=none; b=Ys98B65e4jcAtinYI5mduUcvtnTErtiUH+OMC50I/1KwPyki40RWwkOvI8N2T78lbRPiMxoGgI0WUpNkSz/7SSZQov7Ltiz87UMsHdB6Qw29smmPufvEZzorxqSifpU/fi5tVunUnn7X3F0HsLPzaBKsGD4cZHKEo+EcbCSvIsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757429346; c=relaxed/simple;
	bh=AbBtY9co23uwQZa5euqlsLmByYJLSL8y/i6l8asEyoU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=in8uER3z9+tJY1mZ1We3u32kHEAd5tRG0fL1IbtdzaOf10X9cFSnhIn4FH66A3rb9a0BXOVsQ5wy0zRAU+K6SkleS2ArO7c+uvZ8wBtbvMAQFDCmQBooTBT9FbUEQSzTCfMQG2eLRHuDAXkD0HzUA/R86WMDDragbEqdTUlQCyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com; spf=pass smtp.mailfrom=yadavpratyush.com; dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b=mgP0v51A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9UAhErE; arc=none smtp.client-ip=202.12.124.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadavpratyush.com
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailflow.stl.internal (Postfix) with ESMTP id B3F9E1300990;
	Tue,  9 Sep 2025 10:49:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Tue, 09 Sep 2025 10:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	yadavpratyush.com; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1757429341;
	 x=1757436541; bh=Y/TCCEjl1x7wxnth3DtTGIDGSel1rUvJ59NmeiL2G4Q=; b=
	mgP0v51AEKZ1oLuhYhq0dxoxmzdIjuj3YRTMs5TontGsnXuKeSsgTrsrHF6MMIfE
	212eXMod+EeJVAYGpAy4Wv7mBiYjAcuP6BQl0XEtvwCtFrOR3K7yecENrjLlgS+0
	GXlPErjy7qBU86skUgjtHi0JX73VCP4d2e6kArizhL8smzMUphAKx3KnN6NRc70+
	SBZBlQgCGhIuouqkBKe3T+HAMeylqU047Faj+5IWuvhIgMUt5yQO5NxiWcg9pAgl
	ipuSUbIJEwKfx9Bu+4HDHaX3P4/73OO7C3zCWENMLai5nGCDCq+btAty7NtMpVT5
	ICZUnKckfHRjdd9HvxPKIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1757429341; x=1757436541; bh=Y/TCCEjl1x7wxnth3DtTGIDGSel1rUvJ59N
	meiL2G4Q=; b=k9UAhErE0BymxMplbvUgbBzNElquxstojyh1E9JDW+hlCckC4yi
	Wxfbe/64U4mV02XMEQa41HdXXr6D7Pz0TeLA2qkTHnrg8Sad+Av1yC214EPVlh7c
	gGU/Zm8cgJ0YNGHykqSjIPPRgVIBJMHh4vNKSyFr/1Rw0sMkKtmz/l8KddE/3m5T
	d3bK2EMMn4Zp5aVovyEmeH3U+RiBG9K6iHTkI+gB5vUhOJbHZB/e3OsBpJMB5AMP
	YUnki6cCr0TLbu0DTcscCRzctwspe3ooGET70Sb+kC2h/zbuTL77tcH47MLZR4V5
	rB38co4swoM2kR6N5/JxiYwdS2wwFxtWX3w==
X-ME-Sender: <xms:Wj7AaIrI7M7ldDEGh2_Ckv7KIyHISKSpgzqMKkKLJFhg0iGJe_pciQ>
    <xme:Wj7AaNJLH6L9L49uJ1lYcLGgIaQLnilMIFWmRCqyovoUqXEb9Ci53_420Ne6ZiMES
    _l0O6XwDo13qd_55UM>
X-ME-Received: <xmr:Wj7AaFnq_4-dBrJZbIFCdnlipGr0VxvsMJXV5oxjE7RVXL_yHwuriD0TFPRF0Y05P0zdplbqUMEfjEmzXnpjINJGeYfc-UqE6gP95EOykMfw8egzlum9VL28v2PgT-KgkR8gW0xC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvtdeilecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefrrhgrthihuhhs
    hhcujggruggrvhcuoehmvgeshigruggrvhhprhgrthihuhhshhdrtghomheqnecuggftrf
    grthhtvghrnhepvefgffeuffelffeiveeghfffffeikeeivefhvdeuueetfeekkeegtdeh
    heeuueeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmvgeshigruggrvhhprhgrthihuhhs
    hhdrtghomhdpnhgspghrtghpthhtohepjedvpdhmohguvgepshhmthhpohhuthdprhgtph
    htthhopeifihhtuhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheplhgvohhnrhhosehn
    vhhiughirgdrtghomhdprhgtphhtthhopehprghrrghvsehnvhhiughirgdrtghomhdprh
    gtphhtthhopegrjhgrhigrtghhrghnughrrgesnhhvihguihgrrdgtohhmpdhrtghpthht
    ohepshgrvggvughmsehnvhhiughirgdrtghomhdprhgtphhtthhopehlihhnuhigqdhfsh
    guvghvvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidq
    rghpihesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsrhgruhhnvghrse
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghnnhgrrhhtsehpohgvthhtvghrihhn
    ghdrnhgvth
X-ME-Proxy: <xmx:Wj7AaBvS0dMVGs9SUTzz9TmH0Mep055tenv7pII7aNenLBLMCPxeIA>
    <xmx:Wj7AaP1ih8Dwk4RbYaA7fuRZaAcv1inNagfhkDbMSjDtIy4Uvu0wQw>
    <xmx:Wj7AaIbuJb2pBcDWFQ93y58maHi90wS0GGoAglU5mfYfgdOIqspENQ>
    <xmx:Wj7AaIFs2_0V2RcnSQ8cf9Ni9dMlDYA7DolIPUG6L7_ZxPllJtO1sQ>
    <xmx:XT7AaFDEX4cosPWdCU8mMesLFLGI6DT7fI8E4jebyApuljdXe77ZNvcm>
Feedback-ID: i93f149c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 9 Sep 2025 10:48:51 -0400 (EDT)
From: Pratyush Yadav <me@yadavpratyush.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Chris Li <chrisl@kernel.org>,
  Pasha Tatashin <pasha.tatashin@soleen.com>,  pratyush@kernel.org,
  jasonmiu@google.com,  graf@amazon.com,  changyuanl@google.com,
  rppt@kernel.org,  dmatlack@google.com,  rientjes@google.com,
  corbet@lwn.net,  rdunlap@infradead.org,  ilpo.jarvinen@linux.intel.com,
  kanie@linux.alibaba.com,  ojeda@kernel.org,  aliceryhl@google.com,
  masahiroy@kernel.org,  akpm@linux-foundation.org,  tj@kernel.org,
  yoann.congal@smile.fr,  mmaurer@google.com,  roman.gushchin@linux.dev,
  chenridong@huawei.com,  axboe@kernel.dk,  mark.rutland@arm.com,
  jannh@google.com,  vincent.guittot@linaro.org,  hannes@cmpxchg.org,
  dan.j.williams@intel.com,  david@redhat.com,  joel.granados@kernel.org,
  rostedt@goodmis.org,  anna.schumaker@oracle.com,  song@kernel.org,
  zhangguopeng@kylinos.cn,  linux@weissschuh.net,
  linux-kernel@vger.kernel.org,  linux-doc@vger.kernel.org,
  linux-mm@kvack.org,  gregkh@linuxfoundation.org,  tglx@linutronix.de,
  mingo@redhat.com,  bp@alien8.de,  dave.hansen@linux.intel.com,
  x86@kernel.org,  hpa@zytor.com,  rafael@kernel.org,  dakr@kernel.org,
  bartosz.golaszewski@linaro.org,  cw00.choi@samsung.com,
  myungjoo.ham@samsung.com,  yesanishhere@gmail.com,
  Jonathan.Cameron@huawei.com,  quic_zijuhu@quicinc.com,
  aleksander.lobakin@intel.com,  ira.weiny@intel.com,
  andriy.shevchenko@linux.intel.com,  leon@kernel.org,  lukas@wunner.de,
  bhelgaas@google.com,  wagi@kernel.org,  djeffery@redhat.com,
  stuart.w.hayes@gmail.com,  lennart@poettering.net,  brauner@kernel.org,
  linux-api@vger.kernel.org,  linux-fsdevel@vger.kernel.org,
  saeedm@nvidia.com,  ajayachandra@nvidia.com,  parav@nvidia.com,
  leonro@nvidia.com,  witu@nvidia.com
Subject: Re: [PATCH v3 29/30] luo: allow preserving memfd
In-Reply-To: <20250904173433.GA616306@nvidia.com>
References: <20250807014442.3829950-1-pasha.tatashin@soleen.com>
	<20250807014442.3829950-30-pasha.tatashin@soleen.com>
	<20250826162019.GD2130239@nvidia.com>
	<CAF8kJuPaSQN04M-pvpFTjjpzk3pfHNhpx+mCkvWpZOs=0TF3gg@mail.gmail.com>
	<20250902134156.GM186519@nvidia.com>
	<CACePvbWGR+XPfTub41=Ekj3aSMjzyO+FyJmzMy5HEQKq0-wqag@mail.gmail.com>
	<20250904173433.GA616306@nvidia.com>
Date: Tue, 09 Sep 2025 16:48:50 +0200
Message-ID: <mafs0h5xblm0d.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 04 2025, Jason Gunthorpe wrote:

> On Wed, Sep 03, 2025 at 05:01:15AM -0700, Chris Li wrote:
>
>> > And if you want to serialize that the optimal path would be to have a
>> > vmalloc of all the strings and a vmalloc of the [] data, sort of like
>> > the kho array idea.
>> 
>> The KHO array idea is already implemented in the existing KHO code or
>> that is something new you want to propose?
>
> Pratyush has proposed it

I just sent out the RFC:
https://lore.kernel.org/linux-mm/20250909144426.33274-1-pratyush@kernel.org/T/#u

[...]

-- 
Regards,
Pratyush Yadav

